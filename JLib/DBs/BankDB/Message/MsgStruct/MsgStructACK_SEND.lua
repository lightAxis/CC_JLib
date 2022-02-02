local class = require("Class.middleclass")

require("Common.Serializer")
require("DBs.BankDB.Message.MsgStruct.IMsgStruct")

---@class BankDB.MsgStruct.ACK_SEND : BankDB.IMsgStruct
local ACK_SEND = class("BankDB.MsgStruct.ACK_SEND",
                       JLib.BankDB.MsgStruct.IMsgStruct)

JLib = JLib or {}
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.MsgStruct = JLib.BankDB.MsgStruct or {}
JLib.BankDB.MsgStruct.ACK_SEND = ACK_SEND

---@class BankDB.MsgStruct.ACK_SEND.eState
JLib.BankDB.MsgStruct.ACK_SEND.eState = {
    ["NONE"] = -1,
    ["NO_ACCOUNT_TO_SEND"] = -2,
    ["NO_ACCOUNT_TO_RECIEVE"] = -3,
    ["NOT_ENOUGHT_BALLANCE_TO_SEND"] = -4,
    ["SUCCESS"] = 0
}

---@class BankDB.MsgStruct.ACK_SEND.eStateReverse
JLib.BankDB.MsgStruct.ACK_SEND.eStateReverse = {
    [-1] = "NONE",
    [-2] = "NO_ACCOUNT_TO_SEND",
    [-3] = "NO_ACCOUNT_TO_RECIEVE",
    [-4] = "NOT_ENOUGHT_BALLANCE_TO_SEND",
    [0] = "SUCCESS"
}

---constructor
---@param success? boolean or false
function ACK_SEND:initialize(success)
    self.Success = success or false
    self.State = JLib.BankDB.MsgStruct.ACK_SEND.eState.NONE
end

---properties description
---@class BankDB.MsgStruct.ACK_SEND : BankDB.IMsgStruct
---@field Success boolean
---@field State BankDB.MsgStruct.ACK_SEND.eState
---@field new fun(self:BankDB.MsgStruct.ACK_SEND, success?:boolean):BankDB.MsgStruct.ACK_SEND

---serialize this
---@return string
function ACK_SEND:Serialize()
    local temp = {}
    temp.Success = self.Success
    temp.State = self.State
    return textutils.serialize(temp)
end

---deserialize string
---@param str string
---@return BankDB.MsgStruct.ACK_SEND
function ACK_SEND:Deserialize(str)
    local temp = textutils.unserialize(str)
    local temp2 = JLib.BankDB.MsgStruct.ACK_SEND:new()
    temp2.Success = temp.Success
    temp2.State = temp.State
    return temp2
end
