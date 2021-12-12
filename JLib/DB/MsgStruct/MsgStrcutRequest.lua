local class = require("Class.middleclass")

--- public class MsgStructRequest   
--- Client -> DB
---@class DB.MsgStructRequest : DB.IMsgStruct
local MsgStructRequest = class("MsgStructRequest")

---namespace JLib
JLib = JLib or {}

---namespace JLib.DB
JLib.DB = JLib.DB or {}
JLib.DB.MsgStructRequest = MsgStructRequest

---constructor
---@param IDToSendBack number
---@param ProtocolToRequest string
function MsgStructRequest:initialize(IDToSendBack, ProtocolToRequest)
    self.IDToSendBack = IDToSendBack
    self.ProtocolToRequest = ProtocolToRequest
end

--- properties description
---@class DB.MsgStructRequest : DB.IMsgStruct
---@field IDToSendBack number
---@field ProtocolToRequest string
---@field new fun(self: DB.MsgStructRequest, IDToSend: number, ProtocolToRequest: string):DB.MsgStructRequest
