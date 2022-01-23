local class = require("Class.middleclass")

require("DBs.BankDB.Message")
require("DBs.BankDB.Consts")
require("DBs.BankDB.Table")

---@class BankDB.Server
local Server = class("BankDB.Server")

JLib = JLib or {}
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.Server = Server

function Server:initialize()
    if (fs.exists(JLib.PortDB.Consts.ServerPath) == false) then
        fs.makeDir(JLib.PortDB.Consts.ServerPath)
    end
end

---properties descrtiption
---@class BankDB.Server
---@field new fun(self:BankDB.Server):BankDB.Server

---handler msg to Server
function Server:ServerHandle(msgLine)
    local msg = JLib.BankDB.Message:Deserialize(msgLine)
    if (msg.Header == JLib.BankDB.Headers.GETACCOUNT) then
        print("GETACCOUNT:" .. msg.SerializedMsgStruct)
    elseif (msg.Header == JLib.BankDB.Headers.GETHISTORY) then
        print("GETHISTORY:" .. msg.SerializedMsgStruct)
    elseif (msg.Header == JLib.BankDB.Headers.REGISTER) then
        print("REGISTER:" .. msg.SerializedMsgStruct)
    elseif (msg.Header == JLib.BankDB.Headers.SEND) then
        print("SEND:" .. msg.SerializedMsgStruct)
    end
end

---handle add in get account msg
---@param struct_ string
function Server:_serverHanleGETACCOUNT(struct_)

    local struct = JLib.BankDB.MsgStruct.GETACCOUNT:Deserialize(struct_)
    local bankpath = JLib.BankDB.Consts.ServerPath .. "/" .. struct.Username

    ---@type BankDB.Table
    local table = JLib.Common.Serializer.DeserializeFrom(bankpath,
                                                         JLib.BankDB.Table)

    local ackmsg = JLib.BankDB.MsgStruct.ACK_GETACCOUNT:new()

    -- SendNoTableError
    if (table == nil) then
        ackmsg.Account = nil
        ackmsg.Success = false
        ackmsg.State = JLib.BankDB.MsgStruct.ACK_GETACCOUNT.eState
                           .NO_ACCOUNT_FOR_NAME

        rednet.send(struct.IDToSendBack, ackmsg:Serialize(),
                    JLib.BankDB.Consts.masterPort)
        return nil
    end

    -- account exist. send back 
    ackmsg.Account = table
    ackmsg.Account.Histories = {}
    ackmsg.Success = true
    ackmsg.State = JLib.BankDB.MsgStruct.ACK_GETACCOUNT.eState.SUCCESS

    rednet.send(struct.IDToSendBack, ackmsg:Serialize(),
                JLib.BankDB.Consts.masterPort)
    return nil

end

---handle get account history msg
---@param struct_ string
function Server:_serverHanleGETHISTORY(struct_)

    local struct = JLib.BankDB.MsgStruct.GETHISTORY:Deserialize(struct_)
    local bankpath = JLib.BankDB.Consts.ServerPath .. "/" .. struct.Username

    ---@type BankDB.Table
    local table_ = JLib.Common.Serializer.DeserializeFrom(bankpath,
                                                          JLib.BankDB.Table)

    local ackmsg = JLib.BankDB.MsgStruct.ACK_GETHISTORY:new()

    --- no account error
    if (table_ == nil) then
        ackmsg.Histories = nil
        ackmsg.Success = false
        ackmsg.State = JLib.BankDB.MsgStruct.ACK_GETHISTORY.eState.NO_ACCOUNT
        rednet.send(struct.IDToSendBack, ackmsg:Serialize(),
                    JLib.BankDB.Consts.masterPort)
        return nil
    end

    -- quary account histories
    local histories = {}
    local idx = #histories
    for i = idx, 1, -1 do
        if (table_.Histories[i].DayTime.Day >= struct.DaytimeTerm.Day) then
            table.insert(histories, table_.Histories[i])
        elseif (table_.Histories[i].DayTime.Time >= struct.DaytimeTerm.Time) then
            table.insert(histories, table_.Histories[i])
        else
            break
        end
    end

    -- send back histories
    ackmsg.Histories = histories
    ackmsg.Success = true
    ackmsg.State = JLib.BankDB.MsgStruct.ACK_GETHISTORY.eState.SUCCESS
    rednet.send(struct.IDToSendBack, ackmsg:Serialize(),
                JLib.BankDB.Consts.masterPort)
    return nil
end

---handle register new account msg
---@param struct_ string
function Server:_serverHanleREGISTER(struct_)
    local struct = JLib.BankDB.MsgStruct.REGISTER:Deserialize(struct_)
    local bankpath = JLib.BankDB.Consts.ServerPath .. "/" .. struct.Username

    ---@type BankDB.Table
    local table_ = JLib.Common.Serializer.DeserializeFrom(bankpath,
                                                          JLib.BankDB.Table)
    local ackmsg = JLib.BankDB.MsgStruct.ACK_REGISTER:new()

    -- if table exist already ack
    if (table_ ~= nil) then
        ackmsg.Success = false
        ackmsg.State = JLib.BankDB.MsgStruct.ACK_REGISTER.eState
                           .ALREADY_ACCOUNT_EXIST
        rednet.send(struct.IDToSendBack, ackmsg:Serialize(),
                    JLib.BankDB.Consts.masterPort)
        return nil
    end

    -- make table and save
    local table_new = JLib.BankDB.Table:new()
    table_new.Owner = struct.Username
    table_new.Balance = 1000
    table_new.Histories = {}

    JLib.Common.Serializer.SerializeTo(table_new, bankpath, true)

    -- send ack success msg
    ackmsg.Success = true
    ackmsg.State = JLib.BankDB.MsgStruct.ACK_REGISTER.eState.SUCCESS
    rednet.send(struct.IDToSendBack, ackmsg:Serialize(),
                JLib.BankDB.Consts.masterPort)
    return nil
end

---handle sending balance msg
---@param struct_ string
function Server:_serverHanleSEND(struct_)
    local struct = JLib.BankDB.MsgStruct.SEND:Deserialize(struct_)
    local bankpath_from = JLib.BankDB.Consts.ServerPath .. "/" .. struct.From
    local bankpath_to = JLib.BankDB.Consts.ServerPath .. "/" .. struct.To

    local ackmsg = JLib.BankDB.MsgStruct.ACK_SEND:new()

    ---@type BankDB.Table
    local table_from = JLib.Common.Serializer.DeserializeFrom(bankpath_from,
                                                              JLib.BankDB.Table)

    -- error, no account from
    if (table_from == nil) then
        ackmsg.Success = false
        ackmsg.State = JLib.BankDB.MsgStruct.ACK_SEND.eState.NO_ACCOUNT_TO_SEND
        rednet.send(struct.IDToSendBack, ackmsg:Serialize(),
                    JLib.BankDB.Consts.masterPort)
        return nil
    end

    -- error, not enough balance left at from account
    if (table_from.Balance < struct.Balance) then
        ackmsg.Success = false
        ackmsg.State = JLib.BankDB.MsgStruct.ACK_SEND.eState
                           .NOT_ENOUGHT_BALLANCE_TO_SEND
        rednet.send(struct.IDToSendBack, ackmsg:Serialzie(),
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
        redner.send(struct.IDToSendBack, ackmsg:Serialzie(),
                    JLib.BankDB.Consts.masterPort)
        return nil
    end

    table_from.Balance = table_from.Balance - struct.Balance
    table_to.Balance = table_to.Balance + struct.Balance

    local new_daytime = JLib.BankDB.Table.Daytime:new()
    new_daytime.Day = os.day()
    new_daytime.Time = os.time()

    local new_history_from = JLib.BankDB.Table.History:new()
    new_history_from.BalanceLeft = table_from.Balance
    new_history_from.Inout = -struct.Balance
    new_history_from.Name = struct.FromMsg
    new_history_from.DayTime = JLib.BankDB.Table.Daytime:new()
    new_history_from.DayTime.Day = new_daytime.Day
    new_history_from.DayTime.Time = new_daytime.Time
    table.insert(table_from.Histories, new_history_from)

    local new_history_to = JLib.BankDB.Table.History:new()
    new_history_to.BalanceLeft = table_to.Balance
    new_history_to.Inout = struct.Balance
    new_history_to.Name = struct.ToMsg
    new_history_to.DayTime = JLib.BankDB.Table.Daytime:new()
    new_history_to.DayTime.Day = new_daytime.Day
    new_history_to.DayTime.Time = new_daytime.Time
    table.insert(table_to.Histories, new_history_to)

    JLib.Common.Serializer.SerializeTo(table_from, bankpath_from, true)
    JLib.Common.Serializer.SerializeTo(table_to, bankpath_to, true)

    ackmsg.Success = true
    ackmsg.State = JLib.BankDB.MsgStruct.ACK_SEND.eState.SUCCESS

    rednet.send(struct.IDToSendBack, ackmsg:Serialzie(),
                JLib.BankDB.Consts.masterPort)
    return nil
end
