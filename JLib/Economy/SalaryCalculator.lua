local class = require("Class.middleclass")

---@class Economy.SalaryCalculator
local salaryCalculator = class("Economy.SalaryCalculator")

JLib = JLib or {}
JLib.Economy = JLib.Economy or {}
JLib.Economy.SalaryCalculator = salaryCalculator

function salaryCalculator:initialize()
    self.PlayerWorkHours = {}
    self.PlayerLastworkdays = {}
    self.isPlayerSettlementTime = {}
    self.PlayerHourSalaries = {}
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
function salaryCalculator:calcHourSalary(name, hour, salary)
    if (self.PlayerWorkHours[name] == nil) then
        self.PlayerWorkHours[name] = 0
        self.PlayerLastworkdays[name] = os.day()
        self.isPlayerSettlementTime[name] = false
        print("no name :"..name.."exist, make one")
    end

    if (self.PlayerLastworkdays[name] ~= os.day()) then
        self.PlayerLastworkdays[name] = os.day()
        self.PlayerWorkHours[name] = 0
        self.isPlayerSettlementTime[name] = true
        print("nowday:"..self.PlayerLastworkdays[name].."osday:"..os.day())
        print("name :"..name.."reset work hour with days passed")
    end

    local wh = self.PlayerWorkHours[name] + hour
    if (wh > self.maxWorkHour) then
        wh = self.maxWorkHour - self.PlayerWorkHours[name]
        self.PlayerWorkHours[name] = self.maxWorkHour
        print("work hour overed!")
    else
        wh = hour
        self.PlayerWorkHours[name] = self.PlayerWorkHours[name] + hour
        print("worked")
    end
    self.PlayerHourSalaries[name] = math.floor(salary/1920)
    return self.PlayerHourSalaries[name]

end

---calculate salaries to give. base on oneday max work hour
---@param names table<number, string>
---@param hour number
---@param salaries table<number, number>
function salaryCalculator:calcHourSalaries(names, hour, salaries)
    for i = 1, #names, 1 do
        self:calcHourSalary(names[i],hour, salaries[i])
    end
end

---get is player earn salary for this day
---@param name string
---@return boolean isGetSalary
---@return number salary
function salaryCalculator:isPlayerSalarySettlement(name)
    if(self.isPlayerSettlementTime[name] == nil) then
        self.isPlayerSettlementTime[name] = false
        return false, 0
    else    
        if(self.isPlayerSettlementTime[name] == true) then
            self.isPlayerSettlementTime[name] = false
            return true, self.PlayerHourSalaries[name] * self.PlayerWorkHours[name]
        end
    end
end

---get is player earn salary for this day
---@param names table<number, string>
---@return table<string, number>
function salaryCalculator:isPlayersSalarySettlement(names)
    local result = {}
    for index, value in ipairs(names) do
        local isget, sal = self:isPlayerSalarySettlement(value)
        if(isget == true) then
            result[value] = sal
        end
    end
    return result
end
