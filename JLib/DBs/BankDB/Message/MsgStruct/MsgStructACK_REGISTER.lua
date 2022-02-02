local class = require("Class.middleclass")

require("Common.Serializer")
require("DBs.BankDB.Message.MsgStruct.IMsgStruct")

---@class BankDB.MsgStruct.ACK_REGISTER : BankDB.IMsgStruct
local ACK_REGISTER = class("BankDB.MsgStruct.ACK_REGISTER",
                           JLib.BankDB.MsgStruct.IMsgStruct)

JLib = JLib or {}
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.MsgStruct = JLib.BankDB.MsgStruct or {}
JLib.BankDB.MsgStruct.ACK_REGISTER = ACK_REGISTER

---@class BankDB.MsgStruct.ACK_REGISTER.eState
JLib.BankDB.MsgStruct.ACK_REGISTER.eState = {
    ["NONE"] = -1,
    ["ALREADY_ACCOUNT_EXIST"] = -2,
    ["SUCCESS"] = 0
}

---@class BankDB.MsgStruct.ACK_REGISTER.eStateReverse
JLib.BankDB.MsgStruct.ACK_REGISTER.eStateReverse = {
    [-1] = "NONE",
    [-2] = "ALREADY_ACCOUNT_EXIST",
    [0] = "SUCCESS"
}

---constructor
---@param success? boolean or false
function ACK_REGISTER:initialize(success)
    self.Success = success or false
    self.State = JLib.BankDB.MsgStruct.ACK_REGISTER.eState.NONE
end

---properties description
---@class BankDB.MsgStruct.ACK_REGISTER : BankDB.IMsgStruct
---@field Success boolean
---@field State BankDB.MsgStruct.ACK_REGISTER.eState
---@field new fun(self:BankDB.MsgStruct.ACK_REGISTER, success:boolean):BankDB.MsgStruct.ACK_REGISTER

---serialize this
---@return string
function ACK_REGISTER:Serialize()
    local temp = {}
    temp.Success = self.Success
    temp.State = self.State
    return textutils.serialize(temp)
end

---serialize string
---@param str string
---@return BankDB.MsgStruct.ACK_REGISTER
function ACK_REGISTER:Deserialize(str)
    local temp = textutils.unserialize(str)
    local temp2 = JLib.BankDB.MsgStruct.ACK_REGISTER:new()
    temp2.Success = temp.Success
    temp2.State = temp.State
    return temp2
end
