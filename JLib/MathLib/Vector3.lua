local class = require("Class.middleclass")

---public class Vector3  
---  
---**require** : 
--- - Class.middleclass
---@class Vector3
local Vector3 = class("Vector3")

-- namespace JLib
JLib = JLib or {}
JLib.Vector3 = Vector3

-- constructor
---@param x number
---@param y number
---@param z number
---@return number|nil info
function Vector3:initialize(x, y, z)
    self.x = x
    self.y = y
    self.z = z
end
---@class Vector3
---@field x number|nil
---@field y number|nil
---@field z number|nil
---@field new fun(x:number, y:number, z:number): Vector3

-- functions

-- operator+ overloading  
---add by each element
---@param lhs Vector3
---@param rhs Vector3
---@return Vector3
function Vector3.__add(lhs, rhs)
    return Vector3:new(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
end

-- operator- overloading  
---sub by each element
---@param lhs Vector3
---@param rhs Vector3
---@return Vector3
function Vector3.__sub(lhs, rhs)
    return Vector3:new(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z)
end

-- operator* (element mult) overloading
---@param lhs Vector3
---@param rhs Vector3
---@return Vector3
function Vector3.__mul(lhs, rhs)
    return Vector3:new(lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z)
end

-- operator /(element div)
---@param lhs Vector3
---@param rhs Vector3
---@return Vector3
function Vector3.__div(lhs, rhs)
    return Vector3:new(lhs.x / rhs.x, lhs.y / rhs.y, lhs.z / rhs.z)
end

-- operator dot product v1 dot v2
---@param vec3 Vector3
---@return number
function Vector3:dot(vec3)
    return self.x * vec3.x + self.y + vec3.y + self.z * vec3.z
end

-- operator cross product
---@param vec3 Vector3
---@return Vector3
function Vector3:cross(vec3)
    return Vector3:new(self.y * vec3.z - self.z * vec3.y,
                       self.z * vec3.x - self.x * vec3.z,
                       self.x * vec3.y - self.y * vec3.x)
end

-- deep copy
---@return Vector3
function Vector3:Copy() return JLib.Vector3(self.x, self.y, self.z) end