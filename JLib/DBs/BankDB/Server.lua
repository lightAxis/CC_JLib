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
    if (fs.exists(JLib.BankDB.Consts.ServerPath) == false) then
        fs.makeDir(JLib.BankDB.Consts.ServerPath)
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
        self:_serverHanleGETACCOUNT(msg.SerializedMsgStruct)
    elseif (msg.Header == JLib.BankDB.Headers.GETHISTORY) then
        print("GETHISTORY:" .. msg.SerializedMsgStruct)
        self:_serverHanleGETHISTORY(msg.SerializedMsgStruct)
    elseif (msg.Header == JLib.BankDB.Headers.REGISTER) then
        print("REGISTER:" .. msg.SerializedMsgStruct)
        self:_serverHanleREGISTER(msg.SerializedMsgStruct)
    elseif (msg.Header == JLib.BankDB.Headers.SEND) then
        print("SEND:" .. msg.SerializedMsgStruct)
        self:_serverHanleSEND(msg.SerializedMsgStruct)
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
    ackmsgline = JLib.BankDB.Message:new(JLib.BankDB.Headers.ACK_GETACCOUNT,"")

    -- SendNoTableError
    if (table == nil) then
        ackmsg.Account = JLib.BankDB.Table:new()
        ackmsg.Success = false
        ackmsg.State = JLib.BankDB.MsgStruct.ACK_GETACCOUNT.eState
                           .NO_ACCOUNT_FOR_NAME
        print("---")
        print(ackmsg:Serialize())
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
    print("---")
    print(ackmsg:Serialize())
    
    ackmsgline.SerializedMsgStruct = ackmsg:Serialize()
    rednet.send(struct.IDToSendBack,  ackmsgline:Serialize(),
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
    local ackmsgline = JLib.BankDB.Message:new(JLib.BankDB.Headers.ACK_GETHISTORY,"")

    --- no account error
    if (table_ == nil) then
        ackmsg.Histories = {}
        ackmsg.Success = false
        ackmsg.State = JLib.BankDB.MsgStruct.ACK_GETHISTORY.eState.NO_ACCOUNT
        print("---")
        print(ackmsg:Serialize())
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
        if(i == outcount) then
            break
        end
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
function Server:_serverHanleREGISTER(struct_)
    local struct = JLib.BankDB.MsgStruct.REGISTER:Deserialize(struct_)
    local bankpath = JLib.BankDB.Consts.ServerPath .. "/" .. struct.Username

    ---@type BankDB.Table
    local table_ = JLib.Common.Serializer.DeserializeFrom(bankpath,
                                                          JLib.BankDB.Table)
    local ackmsg = JLib.BankDB.MsgStruct.ACK_REGISTER:new()
    local ackmsgline = JLib.BankDB.Message:new(JLib.BankDB.Headers.ACK_REGISTER,"")

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

    JLib.Common.Serializer.SerializeTo(table_new, bankpath, true)

    -- send ack success msg
    ackmsg.Success = true
    ackmsg.State = JLib.BankDB.MsgStruct.ACK_REGISTER.eState.SUCCESS
    print("---")
    print(ackmsg:Serialize())
    ackmsgline.SerializedMsgStruct = ackmsg:Serialize()
    rednet.send(struct.IDToSendBack, ackmsgline:Serialize(),
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
    return nil
end
