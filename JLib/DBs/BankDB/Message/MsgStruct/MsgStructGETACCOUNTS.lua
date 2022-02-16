local class = require("Class.middleclass")

require("Common.Serializer")
require("DBs.BankDB.Message.MsgStruct.IMsgStruct")

---@class BankDB.MsgStruct.GETACCOUNTS : BankDB.IMsgStruct
local GETACCOUNTS = class("BankDB.MsgStruct.GETACCOUNTS",
                          JLib.BankDB.MsgStruct.IMsgStruct)

JLib = JLib or {}
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.MsgStruct = JLib.BankDB.MsgStruct or {}
JLib.BankDB.MsgStruct.GETACCOUNTS = GETACCOUNTS

---constructor
---@param IDToSendBack number
function GETACCOUNTS:initialize(IDToSendBack) self.IDToSendBack = IDToSendBack end

---properties description
---@class BankDB.MsgStruct.GETACCOUNTS : BankDB.IMsgStruct
---@field IDToSendBack string
---@field new fun(self:BankDB.MsgStruct.GETACCOUNTS, IDToSendBack:number):BankDB.MsgStruct.GETACCOUNTS

---serialize this to string
---@return string
function GETACCOUNTS:Serialize()
    local temp = {}
    temp.IDToSendBack = self.IDToSendBack
    return textutils.serialize(temp)
end

---deserialze string to obj
---@param str string
---@return BankDB.MsgStruct.GETACCOUNTS
function GETACCOUNTS:Deserialize(str)
    local temp = textutils.unserialize(str)
    local temp2 = JLib.BankDB.MsgStruct.GETACCOUNTS:new()
    temp2.IDToSendBack = temp.IDToSendBack
    return temp2
end
