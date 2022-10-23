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

---filter this player is worked at this hour
---@param name string
---@return boolean isWorkedthishour
function salaryCalculator:checkPlayerHourWorked(name)

    if (self.PlayerWorkHours[name] == nil) then
        self.PlayerWorkHours[name] = 0
        self.PlayerLastworkdays[name] = os.day()
        self.isPlayerSettlementTime[name] = false
        return false
    end

    if (self.PlayerWorkHours[name] >= self.maxWorkHour) then
        return false
    else
        return true
    end

end

---filter players is worked at this hour
---@param names table<number, string>
---@return table<number, string>
function salaryCalculator:checkPlayersHourWorked(names)
    local tb = {}

    for index, value in ipairs(names) do
        local worked = self:checkPlayerHourWorked(value)
        if (worked == true) then table.insert(tb, value) end
    end

    return tb
end

---renew work hours of player
---@param name string
---@return number playerWorkedHour
function salaryCalculator:addPlayerHourWorked(name)
    local wh = self.PlayerWorkHours[name] + 1
    if (wh > self.maxWorkHour) then
        wh = self.maxWorkHour - self.PlayerWorkHours[name]
        self.PlayerWorkHours[name] = self.maxWorkHour
        -- print("work hour overed!")
    else
        wh = 1
        self.PlayerWorkHours[name] = self.PlayerWorkHours[name] + 1
        -- print("worked")
        -- print(name, self.PlayerWorkHours[name])
    end

    return self.PlayerWorkHours[name]
end

---renew work hours of players
---@param names table<number, string>
---@return table<string, number> 
function salaryCalculator:addPlayersHourWorked(names)
    local tb = {}
    for index, value in ipairs(names) do
        local workhour = self:addPlayerHourWorked(value)
        tb[value] = workhour
    end
    return tb
end

---check is players is time to be get paid money
---@param names table<number, string>
function salaryCalculator:checkIsPlayersTimeToPayment()
    for key, value in pairs(self.PlayerLastworkdays) do
        if (self.PlayerLastworkdays[key] ~= os.day()) then
            self.PlayerLastworkdays[key] = os.day()
            self.isPlayerSettlementTime[key] = true
        end
    end
end

---extract and flag players to be paid now
---@return table<number, string>
function salaryCalculator:extractPlayersListToBePaid()
    local tb = {}
    for key, value in pairs(self.isPlayerSettlementTime) do
        if (value == true) then
            table.insert(tb, key)
            self.isPlayerSettlementTime[key] = false
        end
    end
    return tb
end

---make player payment table and reset work hours
---@param names table<number, string>
---@return table<string, number>
function salaryCalculator:makePlayerPayTable(names)
    local tb = {}
    for index, value in ipairs(names) do
        tb[value] = JLib.BankDB.Consts.salary_init / 1920 *
                        self.PlayerWorkHours[value]
        self.PlayerWorkHours[value] = 0
    end
    return tb
end

-- ---calculate salary to give. base on oneday max work hour
-- ---@param name any
-- ---@param hour any
-- ---@param salary any
-- ---@return integer
-- function salaryCalculator:calcHourSalary(name, hour, salary)
--     if (self.PlayerWorkHours[name] == nil) then
--         self.PlayerWorkHours[name] = 0
--         self.PlayerLastworkdays[name] = os.day()
--         self.isPlayerSettlementTime[name] = false
--         print("no name :" .. name .. "exist, make one")
--     end

--     if (self.PlayerLastworkdays[name] ~= os.day()) then
--         self.PlayerLastworkdays[name] = os.day()
--         self.PlayerWorkHours[name] = 0
--         self.isPlayerSettlementTime[name] = true
--         print("nowday:" .. self.PlayerLastworkdays[name] .. "osday:" .. os.day())
--         print("name :" .. name .. "reset work hour with days passed")
--     end

--     local wh = self.PlayerWorkHours[name] + hour
--     if (wh > self.maxWorkHour) then
--         wh = self.maxWorkHour - self.PlayerWorkHours[name]
--         self.PlayerWorkHours[name] = self.maxWorkHour
--         print("work hour overed!")
--     else
--         wh = hour
--         self.PlayerWorkHours[name] = self.PlayerWorkHours[name] + hour
--         print("worked")
--         print(name, self.PlayerWorkHours[name])
--     end
--     self.PlayerHourSalaries[name] = math.floor(salary / 1920)
--     return self.PlayerHourSalaries[name]

-- end

-- ---calculate salaries to give. base on oneday max work hour
-- ---@param names table<number, string>
-- ---@param hour number
-- ---@param salaries table<number, number>
-- function salaryCalculator:calcHourSalaries(names, hour, salaries)
--     for i = 1, #names, 1 do self:calcHourSalary(names[i], hour, salaries[i]) end
-- end

-- ---get is player earn salary for this day
-- ---@param name string
-- ---@return boolean isGetSalary
-- ---@return number salary
-- function salaryCalculator:isPlayerSalarySettlement(name)
--     if (self.isPlayerSettlementTime[name] == nil) then
--         self.isPlayerSettlementTime[name] = false
--         return false, 0
--     else
--         if (self.isPlayerSettlementTime[name] == true) then
--             self.isPlayerSettlementTime[name] = false
--             print("aa:", name, self.PlayerHourSalaries[name],
--                   self.PlayerWorkHours[name])
--             return true,
--                    self.PlayerHourSalaries[name] * self.PlayerWorkHours[name]
--         end
--     end
-- end

-- ---get is player earn salary for this day
-- ---@param names table<number, string>
-- ---@return table<string, number>
-- function salaryCalculator:isPlayersSalarySettlement(names)
--     local result = {}
--     for index, value in ipairs(names) do
--         local isget, sal = self:isPlayerSalarySettlement(value)
--         if (isget == true) then result[value] = sal end
--     end
--     return result
-- end
