local class = require("Class.middleclass")

--- public class MsgStructAdd  
--- Client -> DB
---@class DB.MsgStructAdd : DB.IMsgStruct
local MsgStructAdd = class("MsgStructAdd")

---namespace JLib
JLib = JLib or {}

---namespace JLib.DB
JLib.DB = JLib.DB or {}
JLib.DB.MsgStructAdd = MsgStructAdd

---constructor
---@param IDToAdd number
---@param ProtocolToAdd string
function MsgStructAdd:initialize(IDToAdd, ProtocolToAdd)
    self.IDToAdd = IDToAdd
    self.ProtocolToAdd = ProtocolToAdd
end

--- properties description
---@class DB.MsgStructAdd : DB.IMsgStruct
---@field IDToAdd number
---@field ProtocolToAdd string
---@field new fun(self:DB.MsgStructAdd, IDToAdd: number, ProtocolToAdd: string):DB.MsgStructAdd
