local class = require("Class.middleclass")

--- public class DB.Message
---@class DB.Message
local Message = class("Message")

---namespace JLib
JLib = JLib or {}
---namespace JLib.DB
JLib.DB = JLib.DB or {}
JLib.DB.Message = Message

---constructor
---@param protocol DB.Protocols
---@param MsgStruct DB.IMsgStruct
function Message:initialize(protocol, MsgStruct)
    self.protocol = protocol
    self.msgStruct = MsgStruct
end

--- field description
---@class DB.Message
---@field protocol DB.Protocols
---@field msgStruct DB.IMsgStruct
---@field new fun(self: DB.Message, protocol: DB.Protocols, MsgStruct: DB.IMsgStruct): DB.Message
