local class = require("Class.middleclass")

---@class Kiosk.setting_t
local setting_t = class("Kiosk.setting_t")

JLib = JLib or {}
JLib.Kiosk = JLib.Kiosk or {}
JLib.Kiosk.setting_t = setting_t

function setting_t:initialize()
    self.Owner = ""
    self.Name = ""
end

---properties description
---@class Kiosk.setting_t
---@field Owner string
---@field Name string
---@field new fun(self:Kiosk.setting_t):Kiosk.setting_t

---serialize this to string
---@return string
function setting_t:Serialize()
    local temp = {}
    temp.Owner = self.Owner
    temp.Name = self.Name
    return textutils.serialize(temp)
end

---deserialize string to object
---@param str string
---@return Kiosk.setting_t
function setting_t:Deserialize(str)
    local temp = textutils.unserialize(str)
    local temp2 = JLib.Kiosk.setting_t:new()
    temp2.Owner = temp.Owner
    temp2.Name = temp.Name
    return temp2
end
