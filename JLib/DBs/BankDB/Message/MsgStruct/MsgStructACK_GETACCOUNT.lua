local class = require("Class.middleclass")

require("Common.Serializer")
require("DBs.BankDB.Message.MsgStruct.IMsgStruct")

---@class BankDB.MsgStruct.ACK_GETACCOUNT : BankDB.IMsgStruct
local ACK_GETACCOUNT = class("BankDB.MsgStruct.ACK_GETACCOUNT",
    JLib.BankDB.MsgStruct.IMsgStruct)

JLib = JLib or {}
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.MsgStruct = JLib.BankDB.MsgStruct or {}
JLib.BankDB.MsgStruct.ACK_GETACCOUNT = ACK_GETACCOUNT

---@enum BankDB.MsgStruct.ACK_GETACCOUNT.eState
JLib.BankDB.MsgStruct.ACK_GETACCOUNT.eState = {
    ["NONE"] = -1,
    ["NO_ACCOUNT_FOR_NAME"] = -2,
    ["SUCCESS"] = 0
}

---@enum BankDB.MsgStruct.ACK_GETACCOUNT.eStateReverse
JLib.BankDB.MsgStruct.ACK_GETACCOUNT.eStateReverse = {
    [-1] = "NONE",
    [-2] = "NO_ACCOUNT_FOR_NAME",
    [0] = "SUCCESS"
}

---constructor
function ACK_GETACCOUNT:initialize()
    self.Account = {}
    self.Success = false
    self.State = JLib.BankDB.MsgStruct.ACK_GETACCOUNT.eState.NONE
end

---properties description
---@class BankDB.MsgStruct.ACK_GETACCOUNT : BankDB.IMsgStruct
---@field Account BankDB.Table
---@field Success boolean
---@field State BankDB.MsgStruct.ACK_GETACCOUNT.eState
---@field new fun(self:BankDB.MsgStruct.ACK_GETACCOUNT):BankDB.MsgStruct.ACK_GETACCOUNT

---serialize this msg
---@return string
function ACK_GETACCOUNT:Serialize()
    local seri_bankdb = self.Account:Serialize()
    local temp = {}
    temp.Account = seri_bankdb
    temp.Success = self.Success
    temp.State = self.State
    return textutils.serialize(temp)
end

---deserialize from string
---@param str string
---@return BankDB.MsgStruct.ACK_GETACCOUNT
function ACK_GETACCOUNT:Deserialize(str)
    local temp = textutils.unserialize(str)
    local tempac = JLib.BankDB.Table:Deserialize(temp.Account)
    local new_t = JLib.BankDB.MsgStruct.ACK_GETACCOUNT:new()
    new_t.Account = tempac
    new_t.Success = temp.Success
    new_t.State = temp.State
    return new_t
end
