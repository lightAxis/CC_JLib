local class = require("Class.middleclass")

require("AdvancedPeripherals.PlayerDetector")

---@class Economy.WorkHourDetector
local workhourdetector = class("Economy.WorkHourDetector")

---namespace JLib
JLib = JLib or {}
---namespace JLib.Economy
JLib.Economy = JLib.Economy or {}
JLib.Economy.WorkHourDetector = workhourdetector

---constructor
---@param playerDetector AdvancedPeripherals.PlayerDetector
function workhourdetector:initialize(playerDetector)
    self.detector = playerDetector
    self.lastPlayerStates = {}
    self.PlayerAFKTime = {}
    self.isPlayerAFK = {}
    self.AKFTime = 10
end

---properties description
---@class Economy.WorkHourDetector
---@field detector AdvancedPeripherals.PlayerDetector
---@field lastPlayerStates table<string,AdvancedPeripherals.PlayerDetector.PlayerInfo>
---@field PlayerAKFTime table<string,number>
---@field isPlayerAFK table<string,boolean>
---@field new fun(self:Economy.WorkHourDetector, playerDetector:AdvancedPeripherals.PlayerDetector):Economy.WorkHourDetector

---update players salary
---@return table<number,string>
function workhourdetector:update()
    local players = self.detector.getOnlinePlayers()

    local results = {}

    for index, value in ipairs(players) do
        local playerinfo = self.detector.getPlayerPos(value)

        if (playerinfo ~= nil) then
            if (self.lastPlayerStates[value] == nil) then
                self.lastPlayerStates[value] = playerinfo
                self.PlayerAFKTime[value] = 0
                self.isPlayerAFK[value] = false
            else
                if (self:comparePlayerState(self.lastPlayerStates[value],
                                            playerinfo) == true) then
                    self.PlayerAFKTime[value] = self.PlayerAFKTime[value] + 1
                    if (self.PlayerAFKTime[value] >= self.AKFTime) then
                        self.isPlayerAFK[value] = true
                    end
                else
                    self.lastPlayerStates[value] = playerinfo
                    self.PlayerAFKTime[value] = 0
                    self.isPlayerAFK[value] = false
                end
            end

            if (self.isPlayerAFK[value] == false) then
                table.insert(results, value)
            end
        end
    end

    return results
end

---compare two player state
---@param state1 AdvancedPeripherals.PlayerDetector.PlayerInfo
---@param state2 AdvancedPeripherals.PlayerDetector.PlayerInfo
---@return boolean
function workhourdetector:comparePlayerState(state1, state2)
    if (state1.pitch ~= state2.pitch) then return false end
    if (state1.yaw ~= state2.yaw) then return false end
    if (state1.x ~= state2.x) then return false end
    if (state1.y ~= state2.y) then return false end
    if (state1.z ~= state2.z) then return false end
    if (state1.dimension ~= state2.dimension) then return false end
    if (state1.eyeHeight ~= state2.eyeHeight) then return false end
    return true
end
