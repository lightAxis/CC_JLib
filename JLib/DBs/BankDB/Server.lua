local class = require("Class.middleclass")

require("DBs.BankDB.Message")
require("DBs.BankDB.Consts")
require("DBs.BankDB.Table")

require("AdvancedPeripherals.PlayerDetector")
require("AdvancedPeripherals.ChatBox")
require("Economy.WorkHourDetector")
require("Economy.SalaryCalculator")
require("Common.MonitorPrinter")

---@class BankDB.Server
local Server = class("BankDB.Server")

JLib = JLib or {}
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.Server = Server

function Server:initialize()
    if (fs.exists(JLib.BankDB.Consts.ServerPath) == false) then
        fs.makeDir(JLib.BankDB.Consts.ServerPath)
    end

    rednet.open(JLib.BankDB.Consts.rednet_side)
    ---@type AdvancedPeripherals.PlayerDetector
    self.PlayerDetector = peripheral.wrap(JLib.BankDB.Consts
                                              .player_detector_side)
    ---@type AdvancedPeripherals.ChatBox
    self.ChatBox = peripheral.wrap(JLib.BankDB.Consts.chat_box_side)

    self.SalaryTimer = os.startTimer(JLib.BankDB.Consts.salary_update_sec)
    self.WorkHourDetector = JLib.Economy.WorkHourDetector:new(
                                self.PlayerDetector)
    self.SalaryCalculator = JLib.Economy.SalaryCalculator:new()

    self.salaryMonitor = peripheral.wrap(JLib.BankDB.Consts.salary_monitor_side)
    self.salaryMonitorPrinter = JLib.Common.MonitorPrinter:new(
                                    self.salaryMonitor)
    self.bankingMonitor = peripheral.wrap(JLib.BankDB.Consts
                                              .banking_monitor_side)
    self.bankingMonitorPrinter = JLib.Common.MonitorPrinter:new(
                                     self.bankingMonitor)

    self.salaryMonitor.clear()
    self.salaryMonitor.setCursorPos(1, 1)
    self.bankingMonitor.clear()
    self.bankingMonitor.setCursorPos(1, 1)
end

---properties descrtiption
---@class BankDB.Server
---@field new fun(self:BankDB.Server):BankDB.Server

function Server:main()
    local a, b, c, d

    while true do
        a, b, c, d = os.pullEvent()

        if (a == "rednet_message") then
            if (d == JLib.BankDB.Consts.masterPort) then
                self:ServerHandle(c)
            end
        elseif (a == "timer") then
            if (b == self.SalaryTimer) then
                self:SalaryUpdate()
                self.SalaryTimer = os.startTimer(JLib.BankDB.Consts
                                                     .salary_update_sec)
            end
        end
    end
end

function Server:SalaryUpdate()
    self.salaryMonitorPrinter:print("-------------------------------")
    self.salaryMonitorPrinter:print("check players online...")
    local updated_players = self.WorkHourDetector:update()
    for index, value in ipairs(updated_players) do
        self.salaryMonitorPrinter:print(value)
    end

    self.salaryMonitorPrinter:print("check players working hour...")
    local workedPlayers = self.SalaryCalculator:checkPlayersHourWorked(
                              updated_players)
    for index, value in ipairs(workedPlayers) do
        self.salaryMonitorPrinter:print(value)
    end

    self.salaryMonitorPrinter:print("add players working hour...")
    local workingPlayersTable = self.SalaryCalculator:addPlayersHourWorked(
                                    workedPlayers)
    for key, value in pairs(workingPlayersTable) do
        self.salaryMonitorPrinter:print(key .. ":" .. value)
    end

    self.salaryMonitorPrinter:print("check player at payment time...")
    self.SalaryCalculator:checkIsPlayersTimeToPayment()
    local playersToBePaid = self.SalaryCalculator:extractPlayersListToBePaid()
    local playersPaymenyTable = self.SalaryCalculator:makePlayerPayTable(
                                    playersToBePaid)
    -- tb = {}

    -- for index, value in ipairs(updated_players) do
    --     -- print("---")
    --     print(value)
    --     local sal = self.SalaryCalculator:calcHourSalary(value, 1,
    --                                            JLib.BankDB.Consts.salary_init)
    --     -- print("-")
    --     -- print(sal)
    --     table.insert(tb,JLib.BankDB.Consts.salary_init)
    -- end

    -- local result_table = self.SalaryCalculator:isPlayersSalarySettlement(updated_players)
    self.salaryMonitorPrinter:print("give player salary...")
    for key, value in pairs(playersPaymenyTable) do
        self.salaryMonitorPrinter:print(key .. ":" .. value)
        self:_addSalaryToAccount(key, value)
    end

end

function Server:_addSalaryToAccount(name, salary)
    local bankpath = JLib.BankDB.Consts.ServerPath .. "/" .. name
    -- print("giv salr?")
    ---@type BankDB.Table
    local tb = JLib.Common.Serializer.DeserializeFrom(bankpath,
                                                      JLib.BankDB.Table)

    if (tb == nil) then return false end

    tb.Balance = tb.Balance + salary

    local hour = salary / (JLib.BankDB.Consts.salary_init / 1920)
    tb.WorkingHour = tb.WorkingHour + hour
    local new_his = JLib.BankDB.Table_t.History:new("salary", salary,
                                                    tb.Balance, JLib.BankDB
                                                        .Table_t.Daytime:new())
    table.insert(tb.Histories, new_his)

    JLib.Common.Serializer.SerializeTo(tb, bankpath, true)

    print("chatbox+debug:" .. name)
    local suc = self.ChatBox.sendMessageToPlayer(
                    "Got a Payment! : " .. salary .. "/ balance : " ..
                        tb.Balance, name, "KRW Bank")
    print(suc)
    return true
end

---handler msg to Server
function Server:ServerHandle(msgLine)
    local msg = JLib.BankDB.Message:Deserialize(msgLine)
    if (msg.Header == JLib.BankDB.Headers.GETACCOUNT) then
        self.bankingMonitorPrinter:print("GETACCOUNT:" ..
                                             msg.SerializedMsgStruct .. "\n")
        self:_serverHandleGETACCOUNT(msg.SerializedMsgStruct)
    elseif (msg.Header == JLib.BankDB.Headers.GETHISTORY) then
        self.bankingMonitorPrinter:print("GETHISTORY:" ..
                                             msg.SerializedMsgStruct .. "\n")
        self:_serverHandleGETHISTORY(msg.SerializedMsgStruct)
    elseif (msg.Header == JLib.BankDB.Headers.REGISTER) then
        self.bankingMonitorPrinter:print(
            "REGISTER:" .. msg.SerializedMsgStruct .. "\n")
        self:_serverHandleREGISTER(msg.SerializedMsgStruct)
    elseif (msg.Header == JLib.BankDB.Headers.SEND) then
        self.bankingMonitorPrinter:print(
            "SEND:" .. msg.SerializedMsgStruct .. "\n")
        self:_serverHandleSEND(msg.SerializedMsgStruct)
    elseif (msg.Header == JLib.BankDB.Headers.GETACCOUNTS) then
        self.bankingMonitorPrinter:print("GETACCOUNTS:" ..
                                             msg.SerializedMsgStruct .. "\n")
        self:_serverHandleGETACCOUNTS(msg.SerializedMsgStruct)
    end
end

---handle add in get account msg
---@param struct_ string
function Server:_serverHandleGETACCOUNT(struct_)

    local struct = JLib.BankDB.MsgStruct.GETACCOUNT:Deserialize(struct_)
    local bankpath = JLib.BankDB.Consts.ServerPath .. "/" .. struct.Username

    ---@type BankDB.Table
    local table = JLib.Common.Serializer.DeserializeFrom(bankpath,
                                                         JLib.BankDB.Table)

    local ackmsg = JLib.BankDB.MsgStruct.ACK_GETACCOUNT:new()
    local ackmsgline = JLib.BankDB.Message:new(
                           JLib.BankDB.Headers.ACK_GETACCOUNT, "")

    -- SendNoTableError
    if (table == nil) then
        ackmsg.Account = JLib.BankDB.Table:new()
        ackmsg.Success = false
        ackmsg.State = JLib.BankDB.MsgStruct.ACK_GETACCOUNT.eState
                           .NO_ACCOUNT_FOR_NAME
        self.bankingMonitorPrinter:print("---\n")
        self.bankingMonitorPrinter:print(ackmsg:Serialize() .. "\n")
        ackmsgline.SerializedMsgStruct = ackmsg:Serialize()
        rednet.send(struct.IDToSendBack, ackmsgline:Serialize(),
                    JLib.BankDB.Consts.masterPort)
        return nil
    end

    -- account exist. send back 
    ackmsg.Account = table
    ackmsg.Account.Histories = {}
    ackmsg.Success = true
    ackmsg.State = JLib.BankDB.MsgStruct.ACK_GETACCOUNT.eState.SUCCESS
    self.bankingMonitorPrinter:print("---\n")
    self.bankingMonitorPrinter:print(ackmsg:Serialize() .. "\n")

    ackmsgline.SerializedMsgStruct = ackmsg:Serialize()
    rednet.send(struct.IDToSendBack, ackmsgline:Serialize(),
                JLib.BankDB.Consts.masterPort)
    return nil

end

---handle get account history msg
---@param struct_ string
function Server:_serverHandleGETHISTORY(struct_)
    local struct = JLib.BankDB.MsgStruct.GETHISTORY:Deserialize(struct_)
    local bankpath = JLib.BankDB.Consts.ServerPath .. "/" .. struct.Username

    ---@type BankDB.Table
    local table_ = JLib.Common.Serializer.DeserializeFrom(bankpath,
                                                          JLib.BankDB.Table)

    local ackmsg = JLib.BankDB.MsgStruct.ACK_GETHISTORY:new()
    local ackmsgline = JLib.BankDB.Message:new(
                           JLib.BankDB.Headers.ACK_GETHISTORY, "")

    --- no account error
    if (table_ == nil) then
        ackmsg.Histories = {}
        ackmsg.Success = false
        ackmsg.State = JLib.BankDB.MsgStruct.ACK_GETHISTORY.eState.NO_ACCOUNT
        self.bankingMonitorPrinter:print("---\n")
        self.bankingMonitorPrinter:print(ackmsg:Serialize() .. "\n")
        ackmsgline.SerializedMsgStruct = ackmsg:Serialize()
        rednet.send(struct.IDToSendBack, ackmsgline:Serialize(),
                    JLib.BankDB.Consts.masterPort)
        return nil
    end

    -- quary account histories
    local histories = {}
    local i = #(table_.Histories)
    local outcount = i - struct.Count
    outcount = math.max(outcount, 0)
    while true do
        if (i == outcount) then break end
        table.insert(histories, table_.Histories[i])
        i = i - 1
    end

    -- send back histories
    ackmsg.Histories = histories
    ackmsg.Success = true
    ackmsg.State = JLib.BankDB.MsgStruct.ACK_GETHISTORY.eState.SUCCESS
    -- print("---")
    -- print(ackmsg:Serialize())
    ackmsgline.SerializedMsgStruct = ackmsg:Serialize()
    rednet.send(struct.IDToSendBack, ackmsgline:Serialize(),
                JLib.BankDB.Consts.masterPort)
    return nil
end

---handle register new account msg
---@param struct_ string
function Server:_serverHandleREGISTER(struct_)
    local struct = JLib.BankDB.MsgStruct.REGISTER:Deserialize(struct_)
    local bankpath = JLib.BankDB.Consts.ServerPath .. "/" .. struct.Username

    ---@type BankDB.Table
    local table_ = JLib.Common.Serializer.DeserializeFrom(bankpath,
                                                          JLib.BankDB.Table)
    local ackmsg = JLib.BankDB.MsgStruct.ACK_REGISTER:new()
    local ackmsgline = JLib.BankDB.Message:new(JLib.BankDB.Headers.ACK_REGISTER,
                                               "")

    -- if table exist already ack
    if (table_ ~= nil) then
        ackmsg.Success = false
        ackmsg.State = JLib.BankDB.MsgStruct.ACK_REGISTER.eState
                           .ALREADY_ACCOUNT_EXIST
        -- print("---")
        -- print(ackmsg:Serialize())
        ackmsgline.SerializedMsgStruct = ackmsg:Serialize()
        rednet.send(struct.IDToSendBack, ackmsgline:Serialize(),
                    JLib.BankDB.Consts.masterPort)
        return nil
    end

    -- make table and save
    local table_new = JLib.BankDB.Table:new()
    table_new.Owner = struct.Username
    table_new.Balance = 1000
    table_new.Histories = {}
    table_new.Salary = JLib.BankDB.Consts.salary_init
    table_new.WorkingHour = 0

    JLib.Common.Serializer.SerializeTo(table_new, bankpath, true)

    -- send ack success msg
    ackmsg.Success = true
    ackmsg.State = JLib.BankDB.MsgStruct.ACK_REGISTER.eState.SUCCESS
    self.bankingMonitorPrinter:write("---\n")
    self.bankingMonitorPrinter:write(ackmsg:Serialize() .. "\n")
    ackmsgline.SerializedMsgStruct = ackmsg:Serialize()
    rednet.send(struct.IDToSendBack, ackmsgline:Serialize(),
                JLib.BankDB.Consts.masterPort)
    return nil
end

---handle sending balance msg
---@param struct_ string
function Server:_serverHandleSEND(struct_)
    local struct = JLib.BankDB.MsgStruct.SEND:Deserialize(struct_)
    local bankpath_from = JLib.BankDB.Consts.ServerPath .. "/" .. struct.From
    local bankpath_to = JLib.BankDB.Consts.ServerPath .. "/" .. struct.To

    local ackmsg = JLib.BankDB.MsgStruct.ACK_SEND:new()
    local ackmsgline = JLib.BankDB.Message:new(JLib.BankDB.Headers.ACK_SEND, "")

    ---@type BankDB.Table
    local table_from = JLib.Common.Serializer.DeserializeFrom(bankpath_from,
                                                              JLib.BankDB.Table)

    -- error, no account from
    if (table_from == nil) then
        ackmsg.Success = false
        ackmsg.State = JLib.BankDB.MsgStruct.ACK_SEND.eState.NO_ACCOUNT_TO_SEND
        -- print("---")
        -- print(ackmsg:Serialize())
        ackmsgline.SerializedMsgStruct = ackmsg:Serialize()
        rednet.send(struct.IDToSendBack, ackmsgline:Serialize(),
                    JLib.BankDB.Consts.masterPort)
        return nil
    end

    -- error, not enough balance left at from account
    if (table_from.Balance < struct.Balance) then
        ackmsg.Success = false
        ackmsg.State = JLib.BankDB.MsgStruct.ACK_SEND.eState
                           .NOT_ENOUGHT_BALLANCE_TO_SEND
        --                    print("---")
        -- print(ackmsg:Serialize())
        ackmsgline.SerializedMsgStruct = ackmsg:Serialize()
        rednet.send(struct.IDToSendBack, ackmsgline:Serialize(),
                    JLib.BankDB.Consts.masterPort)
        return nil
    end

    ---@type BankDB.Table
    local table_to = JLib.Common.Serializer.DeserializeFrom(bankpath_to,
                                                            JLib.BankDB.Table)
    -- error, no account to 
    if (table_to == nil) then
        ackmsg.Success = false
        ackmsg.State = JLib.BankDB.MsgStruct.ACK_SEND.eState
                           .NO_ACCOUNT_TO_RECIEVE
        --    print("---")
        --    print(ackmsg:Serialize())
        ackmsgline.SerializedMsgStruct = ackmsg:Serialize()
        rednet.send(struct.IDToSendBack, ackmsgline:Serialize(),
                    JLib.BankDB.Consts.masterPort)
        return nil
    end

    table_from.Balance = table_from.Balance - struct.Balance
    table_to.Balance = table_to.Balance + struct.Balance

    local now_daytime = JLib.BankDB.Table_t.Daytime:new()

    local new_history_from = JLib.BankDB.Table_t.History:new()
    new_history_from.BalanceLeft = table_from.Balance
    new_history_from.Inout = -struct.Balance
    new_history_from.Name = struct.FromMsg
    new_history_from.DayTime = now_daytime
    table.insert(table_from.Histories, new_history_from)

    local new_history_to = JLib.BankDB.Table_t.History:new()
    new_history_to.BalanceLeft = table_to.Balance
    new_history_to.Inout = struct.Balance
    new_history_to.Name = struct.ToMsg
    new_history_to.DayTime = now_daytime
    table.insert(table_to.Histories, new_history_to)

    JLib.Common.Serializer.SerializeTo(table_from, bankpath_from, true)
    JLib.Common.Serializer.SerializeTo(table_to, bankpath_to, true)

    ackmsg.Success = true
    ackmsg.State = JLib.BankDB.MsgStruct.ACK_SEND.eState.SUCCESS
    -- print("---")
    --     print(ackmsg:Serialize())
    ackmsgline.SerializedMsgStruct = ackmsg:Serialize()
    rednet.send(struct.IDToSendBack, ackmsgline:Serialize(),
                JLib.BankDB.Consts.masterPort)

    self.ChatBox.sendMessageToPlayer(
        "you get " .. struct.Balance .. " from " .. struct.From, struct.To,
        "KRW Bank")

    return nil
end

function Server:_serverHandleGETACCOUNTS(struct_)
    local struct = JLib.BankDB.MsgStruct.GETACCOUNTS:Deserialize(struct_)
    local bankpath = JLib.BankDB.Consts.ServerPath

    local ackmsgline = JLib.BankDB.Message:new(
                           JLib.BankDB.Headers.ACK_GETACCOUNTS, "")
    local ackmsg = JLib.BankDB.MsgStruct.ACK_GETACCOUNTS:new()
    ackmsg.AccountsList = {}

    --- no path for bank file.
    if (fs.exists(bankpath) == false) then
        ackmsg.State = JLib.BankDB.MsgStruct.ACK_GETACCOUNTS.eState.NO_BANK_FILE
        ackmsg.Success = false
        ackmsgline.SerializedMsgStruct = ackmsg:Serialize()
        rednet.send(struct.IDToSendBack, ackmsgline:Serialize(),
                    JLib.BankDB.Consts.masterPort)
        return nil
    end

    local fsList = fs.list(bankpath)
    ackmsg.AccountsList = fsList

    ackmsg.State = JLib.BankDB.MsgStruct.ACK_GETACCOUNTS.eState.SUCCESS
    ackmsg.Success = true
    ackmsgline.SerializedMsgStruct = ackmsg:Serialize()
    rednet.send(struct.IDToSendBack, ackmsgline:Serialize(),
                JLib.BankDB.Consts.masterPort)

end

