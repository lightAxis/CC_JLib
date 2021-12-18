local class = require("Class.middleclass")

---@class PortDB.Table
Table = class("PortDB.Table")

---namespace JLib
JLib = JLib or {}
---namespace JLib.PortDB
JLib.PortDB = JLib.PortDB or {}
JLib.PortDB.Table = Table

---constructor
---@param Port string
function Table:initialize(Port)
    self.Port = Port;
    self.IDs = {}
end

---properties description
---@class PortDB.Table
---@field Port string
---@field IDs table<number, number>
---@field new fun(self:PortDB.Table, Port: string):PortDB.Table
