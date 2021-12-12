local class = require("Class.middleclass")

---public class DB.Struct
---@class DB.Struct
local Struct = class("Struct")

---namespace JLib
JLib = JLib or {}
---namespace JLib.DB
JLib.DB = JLib.DB or {}
JLib.DB.Struct = Struct

---constructor
---@param protocolName string
function Struct:initialize(protocolName)
    self.protocol = protocolName
    self.IDs = {}
end

--- properties description
---@class DB.Struct
---@field protocol string
---@field IDs table<number, number>
---@field new fun(self:DB.Struct, protocolName: string): DB.Struct
