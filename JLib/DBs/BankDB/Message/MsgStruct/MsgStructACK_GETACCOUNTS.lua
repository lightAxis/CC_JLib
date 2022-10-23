local class = require("Class.middleclass")

require("Common.Serializer")
require("DBs.BankDB.Message.MsgStruct.IMsgStruct")

---@class BankDB.MsgStruct.ACK_GETACCOUNTS : BankDB.IMsgStruct
local ACK_GETACCOUNTS = class("BankDB.MsgStruct.ACK_GETACCOUNTS",
    JLib.BankDB.MsgStruct.IMsgStruct)

JLib = JLib or {}
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.MsgStruct = JLib.BankDB.MsgStruct or {}
JLib.BankDB.MsgStruct.ACK_GETACCOUNTS = ACK_GETACCOUNTS

function ACK_GETACCOUNTS:initialize()
    self.AccountsList = {}
    self.Success = false
    self.State = JLib.BankDB.MsgStruct.ACK_GETACCOUNTS.eState.NONE
end

---@enum BankDB.MsgStruct.ACK_GETACCOUNTS.eState
JLib.BankDB.MsgStruct.ACK_GETACCOUNTS.eState = {
    ["NONE"] = -1,
    ["NO_BANK_FILE"] = -2,
    ["SUCCESS"] = 0
}

---@enum BankDB.MsgStruct.ACK_GETACCOUNTS.eStateReverse
JLib.BankDB.MsgStruct.ACK_GETACCOUNTS.eStateReverse = {
    [-1] = "NONE",
    [-2] = "NO_BANK_FILE",
    [0] = "SUCCESS"
}

--- properties description
---@class BankDB.MsgStruct.ACK_GETACCOUNTS : BankDB.IMsgStruct
---@field AccountsList table<number, string>
---@field Success boolean
---@field State BankDB.MsgStruct.ACK_GETACCOUNTS.eState
---@field new fun(self:BankDB.MsgStruct.ACK_GETACCOUNTS):BankDB.MsgStruct.ACK_GETACCOUNTS

---serialize this msg
---@return string
function ACK_GETACCOUNTS:Serialize()
    local temp = {}
    temp.AccountsList = self.AccountsList
    temp.Success = self.Success
    temp.State = self.State
    return textutils.serialize(temp)
end

---deserialize string
---@param str string
---@return BankDB.MsgStruct.ACK_GETACCOUNTS
function ACK_GETACCOUNTS:Deserialize(str)
    local temp = textutils.unserialize(str)
    local temp2 = JLib.BankDB.MsgStruct.ACK_GETACCOUNTS:new()
    temp2.AccountsList = temp.AccountsList
    temp2.State = temp.State
    temp2.Success = temp.Success
    return temp2
end
