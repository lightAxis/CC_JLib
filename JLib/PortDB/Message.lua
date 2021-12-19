local class = require("Class.middleclass")

require("PortDB.Message.Headers")
require("PortDB.Message.MsgStruct")

---@class PortDB.Message
local Message = class("PortDB.Message")

---namespace JLib
JLib = JLib or {}
---namespace JLib.PortDB
JLib.PortDB = JLib.PortDB or {}
JLib.PortDB.Message = Message

---constructor
---@param Header PortDB.Headers
---@param SerializedMsgStruct string
function Message:initialize(Header, SerializedMsgStruct)
    self.Header = Header
    self.SerializedMsgStruct = SerializedMsgStruct
end

---properties description
---@class PortDB.Message
---@field Header PortDB.Headers
---@field SerializedMsgStruct string
---@field new fun(self:PortDB.Message, Header: PortDB.Headers, SerializedMsgStruct: string):PortDB.Message

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
---@return PortDB.Message
function Message:Deserialize(str)
    local temp = textutils.unserialize(str)
    local temp2 = Message:new(temp.Header, temp.SerializedMsgStruct)
    return temp2
end
