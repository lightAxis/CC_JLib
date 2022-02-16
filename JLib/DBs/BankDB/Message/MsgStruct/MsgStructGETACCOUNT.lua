local class = require("Class.middleclass")

require("Common.Serializer")
require("DBs.BankDB.Message.MsgStruct.IMsgStruct")

---@class BankDB.MsgStruct.GETACCOUNT : BankDB.IMsgStruct
local GETACCOUNT = class("BankDB.MsgStruct.GETACCOUNT",
                         JLib.BankDB.MsgStruct.IMsgStruct)

JLib = JLib or {}
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.MsgStruct = JLib.BankDB.MsgStruct or {}
JLib.BankDB.MsgStruct.GETACCOUNT = GETACCOUNT

---constructor
---@param name? string or ""
---@param IDToSendBack? number or nil
function GETACCOUNT:initialize(name, IDToSendBack)
    self.Username = name or ""
    self.IDToSendBack = IDToSendBack or nil
end

---properties description
---@class BankDB.MsgStruct.GETACCOUNT : BankDB.IMsgStruct
---@field Username string
---@field IDToSendBack number
---@field new fun(self:BankDB.MsgStruct.GETACCOUNT, name?:string):BankDB.MsgStruct.GETACCOUNT

---serialize this
---@return string
function GETACCOUNT:Serialize()
    local temp = {}
    temp.Username = self.Username
    temp.IDToSendBack = self.IDToSendBack
    return textutils.serialize(temp)
end

---deserialize string
---@param str string
---@return BankDB.MsgStruct.GETACCOUNT
function GETACCOUNT:Deserialize(str)
    local temp = textutils.unserialize(str)
    local temp2 = JLib.BankDB.MsgStruct.GETACCOUNT:new()
    temp2.Username = temp.Username
    temp2.IDToSendBack = temp.IDToSendBack
    return temp2
end
