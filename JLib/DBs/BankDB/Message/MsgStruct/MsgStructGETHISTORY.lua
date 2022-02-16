local class = require("Class.middleclass")

require("Common.Serializer")
require("DBs.BankDB.Message.MsgStruct.IMsgStruct")

---@class BankDB.MsgStruct.GETHISTORY : BankDB.IMsgStruct
local GETHISTORY = class("BankDB.MsgStruct.GETHISTORY",
                         JLib.BankDB.MsgStruct.IMsgStruct)

JLib = JLib or {}
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.MsgStruct = JLib.BankDB.MsgStruct or {}
JLib.BankDB.MsgStruct.GETHISTORY = GETHISTORY

---constructor
---@param username? string or nil
---@param count? number or nil
---@param IDToSendBack? number or nil
function GETHISTORY:initialize(username, count, IDToSendBack)
    self.Username = username or nil
    self.Count = count or nil
    self.IDToSendBack = IDToSendBack or nil
end

---@class BankDB.MsgStruct.GETHISTORY : BankDB.IMsgStruct
---@field Username string
---@field Count number
---@field IDToSendBack number
---@field new fun(self:BankDB.MsgStruct.GETHISTORY):BankDB.MsgStruct.GETHISTORY

---serialize this
---@return string
function GETHISTORY:Serialize()
    local temp = {}
    temp.Username = self.Username
    temp.Count = self.Count
    temp.IDToSendBack = self.IDToSendBack
    return textutils.serialize(temp)
end

---deserialize string
---@param str string
---@return BankDB.MsgStruct.GETHISTORY
function GETHISTORY:Deserialize(str)
    local temp = textutils.unserialize(str)
    local temp2 = JLib.BankDB.MsgStruct.GETHISTORY:new()
    temp2.Username = temp.Username
    temp2.Count = temp.Count
    temp2.IDToSendBack = temp.IDToSendBack
    return temp2
end
