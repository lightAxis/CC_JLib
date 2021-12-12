local class = require("Class.middleclass")

--- public class MsgStructRemove   
--- Client -> DB
---@class DB.MsgStructRemove : DB.IMsgStruct
local MsgStructRemove = class("MsgStructRemove")

---namespace JLib
JLib = JLib or {}

---namespace JLib.DB
JLib.DB = JLib.DB or {}
JLib.DB.MsgStructRemove = MsgStructRemove

---constructor
---@param IDToRemove number
---@param ProtocolToRemove string
function MsgStructRemove:initialize(IDToRemove, ProtocolToRemove)
    self.IDToRemove = IDToRemove
    self.ProtocolToRemove = ProtocolToRemove
end

--- properties description
---@class DB.MsgStructRemove : DB.IMsgStruct
---@field IDToRemove number
---@field ProtocolToRemove string
---@field new fun(self:DB.MsgStructRemove, IDToSend: number, ProtocolToRequest: string):DB.MsgStructRemove
