require("Class.class")

-- public class ReactorControl
local ReactorControl = class()

-- namespace JLib
JLib = JLib or {}
JLib.ReactorControl = ReactorControl

--properties
ReactorControl:set{
    -- private:
    _reactorProxy = nil,
    _targetEnergyThreshold = 0.5,
    _minimumThrottle = 0.0,
    _maximumThrottle = 0.5,
    _pGain = 2.0,
    _IGain = 1.0,
    _I = 0.0,
    _last_u = 0.0,
}

-- constructor
function ReactorControl:init(reactorProxy)
    self._reactorProxy = reactorProxy
end 

-- functions
function ReactorControl:SetControllerTarget(targetEnergyThreshold)
    self._targetEnergyThreshold = targetEnergyThreshold
end

function ReactorControl:SetThrottleRange(minimumThrottle, maximumThrottle)
    self._minimumThrottle = minimumThrottle
    self._maximumThrottle = maximumThrottle
end

function ReactorControl:SetPGain(PGain)
    self._PGain = PGain
end

function ReactorControl:SetIGain(IGain)
    self._IGain = IGain
end

function ReactorControl:Control(dt)
    -- control reference
    local r = self._targetEnergyThreshold

    -- plant observation
    local totalEnergy = self._reactorProxy.getEnergyStored()
    local EnergyCapacity = self._reactorProxy.getEnergyCapacity()
    local y = totalEnergy / EnergyCapacity

    -- get error
    local e = r - y

    -- calc Integral term
    self._I = self._I + dt*self._IGain*e
    -- Integral Windup prevention
    self._I = math.max(-50, self._I)
    self._I = math.min( 50, self._I)

    -- calc input u
    self._last_u = self._PGain * e + self._I
    -- Saturate input u to thresholds
    self._last_u = math.max(self._minimumThrottle, self._last_u)
    self._last_u = math.min(self._maximumThrottle, self._last_u)

    self._reactorProxy.setAllControlRodLevels(math.floor((100 - self._last_u) + 0.5))
    -- print("asdafd:"..math.floor((100 - self._last_u) + 0.5))
    
    return r, y, self._last_u
end