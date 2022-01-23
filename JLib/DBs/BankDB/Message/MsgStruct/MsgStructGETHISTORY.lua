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
---@param daytime? BankDB.Table.Daytime or nil
---@param IDToSendBack? number or nil
function GETHISTORY:initialize(username, daytime, IDToSendBack)
    self.Username = username or nil
    self.DaytimeTerm = daytime or nil
    self.IDToSendBack = IDToSendBack or nil
end

---@class BankDB.MsgStruct.GETHISTORY : BankDB.IMsgStruct
---@field Username string
---@field DaytimeTerm BankDB.Table.Daytime
---@field IDToSendBack number
---@field new fun(self:BankDB.MsgStruct.GETHISTORY):BankDB.MsgStruct.GETHISTORY

---serialize this
---@return string
function GETHISTORY:Serialize()
    local temp = {}
    temp.Username = self.Username
    temp.DaytimeTerm = self.DaytimeTerm:Serialize()
    temp.IDToSendBack = self.IDToSendBack
    return textutils.serialize(temp)
end

---deserialize string
---@param str string
---@return BankDB.MsgStruct.GETHISTORY
function GETHISTORY:Deserialize(str)
    local temp = textutils(str)
    local temp2 = JLib.BankDB.MsgStruct.GETHISTORY:new()
    temp2.Username = temp.Username
    temp2.DaytimeTerm = JLib.BankDB.Table.Daytime:Deserialize(temp.DaytimeTerm)
    temp2.IDToSendBack = temp.IDToSendBack
    return temp2
end
