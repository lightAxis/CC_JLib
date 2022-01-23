local class = require("Class.middleclass")

require("DBs.BankDB.Message.Headers")
require("DBs.BankDB.Message.MsgStruct")

---@class BankDB.Message
local Message = class("BankDB.Message")

---namespace JLib
JLib = JLib or {}
---namespace JLib.PortDB
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.Message = Message

---constructor
---@param Header BankDB.Headers
---@param SerializedMsgStruct string
function Message:initialize(Header, SerializedMsgStruct)
    self.Header = Header
    self.SerializedMsgStruct = SerializedMsgStruct
end

---properties description
---@class BankDB.Message
---@field Header BankDB.Headers
---@field SerializedMsgStruct string
---@field new fun(self:BankDB.Message, Header: BankDB.Headers, SerializedMsgStruct: string):BankDB.Message

---serialize message
---@return string
function Message:Serialize()
    local temp = {}
    temp["Header"] = self.Header
    temp["SerializedMsgStruct"] = self.SerializedMsgStruct
    return textutils.serialize(temp)
end

---deserialize message 
---@param str string
---@return BankDB.Message
function Message:Deserialize(str)
    local temp = textutils.unserialize(str)
    -- print("---")
    -- print(str)
    local temp2 = Message:new(temp.Header, temp.SerializedMsgStruct)
    return temp2
end
