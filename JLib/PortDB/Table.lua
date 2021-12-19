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

---serialize content
---@return string
function Table:Serialize()
    local temp = {}
    temp["Port"] = self.Port
    temp["IDs"] = self.IDs
    -- for key, value in pairs(self.IDs) do 
    --     temp.IDs[key] = value 
    -- end
    return textutils.serialize(temp)
end

---deserialize function
---@param str string
---@return PortDB.Table
function Table:Deserialize(str)
    local temp = textutils.unserialize(str)
    local temp2 = Table:new(temp.Port)
    temp2.IDs = temp.IDs
    return temp2
end
