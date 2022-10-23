local class = require("Class.middleclass")

require("Common.Serializer")
require("DBs.BankDB.Message.MsgStruct.IMsgStruct")

---@class BankDB.MsgStruct.SEND : BankDB.IMsgStruct
local SEND = class("BankDB.MsgStruct.SEND", JLib.BankDB.MsgStruct.IMsgStruct)

JLib = JLib or {}
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.MsgStruct = JLib.BankDB.MsgStruct or {}
JLib.BankDB.MsgStruct.SEND = SEND

---constructor
---@param from? string or nil
---@param to? string or nil
---@param balance? number or nil
---@param IDToSendBack? number or nil
function SEND:initialize(from, to, balance, IDToSendBack)
    self.From = from or nil
    self.FromMsg = self.From
    self.To = to or nil
    self.ToMsg = self.To
    self.Balance = balance or nil
    self.IDToSendBack = IDToSendBack or nil
end

---properties description
---@class BankDB.MsgStruct.SEND : BankDB.IMsgStruct
---@field From string
---@field FromMsg string
---@field To string
---@field ToMsg string
---@field Balance number
---@field IDToSendBack number
---@field new fun(self:BankDB.MsgStruct.SEND, from:string, to:string, balance:number):BankDB.MsgStruct.SEND

---serialize this
---@return string
function SEND:Serialize()
    local temp = {}
    temp.From = self.From
    temp.FromMsg = self.FromMsg
    temp.To = self.To
    temp.ToMsg = self.ToMsg
    temp.Balance = self.Balance
    temp.IDToSendBack = self.IDToSendBack
    return textutils.serialize(temp)
end

---deserialize 
---@param str string
---@return BankDB.MsgStruct.SEND
function SEND:Deserialize(str)
    local temp = textutils.unserialize(str)
    local temp2 = JLib.BankDB.MsgStruct.SEND:new()
    temp2.From = temp.From
    temp2.FromMsg = temp.FromMsg
    temp2.To = temp.To
    temp2.ToMsg = temp.ToMsg
    temp2.Balance = temp.Balance
    temp2.IDToSendBack = temp.IDToSendBack
    return temp2
end
