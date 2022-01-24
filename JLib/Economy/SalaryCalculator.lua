local class = require("Class.middleclass")

---@class Economy.SalaryCalculator
local salarycalc = class("Economy.SalaryCalculator")

JLib = JLib or {}
JLib.Economy = JLib.Economy or {}
JLib.Economy.SalaryCalculator = salarycalc

function salarycalc:initialize()
    self.PlayerWorkHours = {}
    self.PlayerLastworkdays = {}
    self.maxWorkHour = 9
end

---properties description
---@class Economy.SalaryCalculator
---@field PlayerWorkHours table<string,number>
---@field PlayerLastworkdays table<string,number>
---@field maxWorkHour number
---@field new fun(self:Economy.SalaryCalculator):Economy.SalaryCalculator

---calculate salary to give. base on oneday max work hour
---@param name any
---@param hour any
---@param salary any
---@return integer
function salarycalc:give(name, hour, salary)
    if (self.PlayerWorkHours[name] == nil) then
        self.PlayerWorkHours[name] = 0
        self.PlayerLastworkdays[name] = os.day()
    end

    if (self.PlayerLastworkdays[name] ~= os.day()) then
        self.PlayerWorkHours[name] = 0
    end

    local wh = self.PlayerWorkHours[name] + hour
    if (wh > self.maxWorkHour) then
        wh = self.maxWorkHour - self.PlayerWorkHours[name]
        self.PlayerWorkHours[name] = self.maxWorkHour
    else
        wh = hour
        self.PlayerWorkHours[name] = self.PlayerWorkHours[name] + hour
    end

    return math.floor(salary / 1920)

end
