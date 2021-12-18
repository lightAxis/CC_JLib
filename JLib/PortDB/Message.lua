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
---@param MsgStruct any
function Message:initialize(Header, MsgStruct)
    self.Header = Header
    self.MsgStruct = MsgStruct
end

---properties description
---@class PortDB.Message
---@field Header string
---@field MsgStruct any
---@field new fun(self:PortDB.Message, Header, MsgStruct)
