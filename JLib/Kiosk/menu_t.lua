local class = require("Class.middleclass")

---@class Kiosk.menu_t
local menu_t = class("Kiosk.menu_t")

JLib = JLib or {}
JLib.Kiosk = JLib.Kiosk or {}
JLib.Kiosk.menu_t = menu_t

---constructor
---@param name string
---@param price number
---@param comment string
function menu_t:initialize(name, price, comment)
    self.Name = name or ""
    self.Price = price or 0
    self.Comment = comment or ""
end

---properties description
---@class Kiosk.menu_t
---@field Name string
---@field Price number
---@field Comment string
---@field new fun(self:Kiosk.menu_t, name:string, price:number, comment:string):Kiosk.menu_t

---serialize this to string
---@return string
function menu_t:Serialize()
    local temp = {}
    temp.Name = self.Name
    temp.Price = self.Price
    temp.Comment = self.Comment
    return textutils.serialize(temp)
end

---deserialize string to object
---@param str string
---@return Kiosk.menu_t
function menu_t:Deserialize(str)
    local temp = textutils.unserialize(str)
    local temp2 = JLib.Kiosk.menu_t:new()
    temp2.Name = temp.Name
    temp2.Price = temp.Price
    temp2.Comment = temp.Comment
    return temp2
end