local class = require("Class.middleclass")

require("Common.Serializer")
require("DBs.BankDB.Message.MsgStruct.IMsgStruct")

---@class BankDB.MsgStruct.REGISTER : BankDB.IMsgStruct
local REGISTER = class("BankDB.MsgStruct.REGISTER",
                       JLib.BankDB.MsgStruct.IMsgStruct)

JLib = JLib or {}
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.MsgStruct = JLib.BankDB.MsgStruct or {}
JLib.BankDB.MsgStruct.REGISTER = REGISTER

---constructor
---@param username? string or nil
---@param IDToSendBack? number or nil
function REGISTER:initialize(username, IDToSendBack)
    self.Username = username or nil
    self.IDToSendBack = IDToSendBack or nil
end

---properties description
---@class BankDB.MsgStruct.REGISTER : BankDB.IMsgStruct
---@field Username string
---@field IDToSendBack number
---@field new fun(self:BankDB.MsgStruct.REGISTER):BankDB.MsgStruct.REGISTER

---serialize this
---@return string
function REGISTER:Serialize()
    local temp = {}
    temp.Username = self.Username
    temp.IDToSendBack = self.IDToSendBack
    return textutils.serialize(temp)
end

---deserialize
---@param str string
---@return BankDB.MsgStruct.REGISTER
function REGISTER:Deserialize(str)
    local temp = textutils.unserialize(str)
    local temp2 = JLib.BankDB.MsgStruct.REGISTER:new()
    temp2.Username = temp.Username
    temp2.IDToSendBack = temp.IDToSendBack
    return temp2
end
