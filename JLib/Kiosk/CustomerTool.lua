local class = require("Class.middleclass")

---@class Kiosk.CustomorTool
local customerTool = class("Kiosk.CustomerTool")

JLib = JLib or {}
JLib.Kiosk = JLib.Kiosk or {}
JLib.Kiosk.CustomerTool = customerTool

function customerTool:initialize()

end

---properties description
---@class Kiosk.CustomorTool
---@field new fun(self:Kiosk.CustomorTool):Kiosk.CustomorTool
