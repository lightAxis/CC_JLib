local class = require("Class.middleclass")

require("DBs.BankDB.Message")
require("DBs.BankDB.Consts")

---@class BankDB.Client
local Client = class("BankDB.Client")

JLib = JLib or {}
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.Client = Client

function Client:initialize() end

--- properties description
---@class BankDB.Client
---@field new fun(self:BankDB.Client):BankDB.Client

---handle msg to client
---@param MsgLine string
function Client:HandleMsg(MsgLine)

    local msg = JLib.BankDB.Message:Deserialize(MsgLine)

    if (msg.Header == JLib.BankDB.Headers.ACK_GETACCOUNT) then
        self:_clientHandleACK_GETACCOUNT(msg.SerializedMsgStruct)
    elseif (msg.Header == JLib.BankDB.Headers.ACK_GETHISTORY) then
        self:_clientHandleACK_GETHISTORY(msg.SerializedMsgStruct)
    elseif (msg.Header == JLib.BankDB.Headers.ACK_REGISTER) then
        self:_clientHandleACK_REGISTER(msg.SerializedMsgStruct)
    elseif (msg.Header == JLib.BankDB.Headers.ACK_SEND) then
        self:_clientHandleACK_SEND(msg.SerializedMsgStruct)
    end
end

---handle client msg
---@param struct_ string
---@return boolean success
---@return BankDB.MsgStruct.ACK_GETACCOUNT.eState state
function Client:_clientHandleACK_GETACCOUNT(struct_)
    local struct = JLib.BankDB.MsgStruct.ACK_GETACCOUNT:Deserialize(struct_)

    if (struct.Success == true) then
        return true, struct.State
    else
        return false, struct.State
    end
end

---handle client msg ack_gethistory
---@param strcut_ string
---@return boolean success
---@return table<number, BankDB.Table_t.History> histories
---@return BankDB.MsgStruct.ACK_GETHISTORY.eState state
function Client:_clientHandleACK_GETHISTORY(strcut_)
    local struct = JLib.BankDB.MsgStruct.ACK_GETHISTORY:Deserialize(strcut_)

    if (struct.Success == true) then
        return true, struct.Histories, struct.State
    else
        return true, nil, struct.State
    end
end

---handle client msg ack_getregister
---@param strcut_ string
---@return boolean success
---@return integer|BankDB.MsgStruct.ACK_REGISTER.eState state
function Client:_clientHandleACK_REGISTER(strcut_)
    local struct = JLib.BankDB.MsgStruct.ACK_REGISTER:Deserialize(strcut_)

    if (struct.Success == true) then
        return true, struct.State
    else
        return false, struct.State
    end
end

---handle client msg ack_send
---@param strcut_ string
---@return boolean success
---@return integer|BankDB.MsgStruct.ACK_SEND.eState state
function Client:_clientHandleACK_SEND(strcut_)
    local struct = JLib.BankDB.MsgStruct.ACK_SEND:Deserialize(strcut_)

    if (struct.Success == true) then
        return true, struct.State
    else
        return true, struct.State
    end
end
