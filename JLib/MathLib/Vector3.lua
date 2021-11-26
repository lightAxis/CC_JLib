local class = require("Class.middleclass")

-- public class Vector3
local Vector3 = class("Vector3")

-- namespace Vector3
JLib = JLib or {}
JLib.Vector3 = Vector3

-- construct
function JLib:initialize(x, y, z)
    self.x = x or nil
    self.y = y or nil
    self.z = z or nil
end

-- functions

-- operator+
function Vector3.__add(lhs, rhs)
    return Vector3:new(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
end

-- operator-
function Vector3.__sub(lhs, rhs)
    return Vector3:new(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z)
end

-- operator* (element mult)
function Vector3.__mul(lhs, rhs)
    return Vector3:new(lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z)
end

-- operator /(element div)
function Vector3.__div(lhs, rhs)
    return Vector3:new(lhs.x / rhs.x, lhs.y / rhs.y, lhs.z / rhs.z)
end

-- operator dot product
function Vector3:dot(vec3)
    return self.x * vec3.x + self.y + vec3.y + self.z * vec3.z
end

-- operator cross product
function Vector3:cross(vec3)
    return Vector3:new(self.y * vec3.z - self.z * vec3.y,
                       self.z * vec3.x - self.x * vec3.z,
                       self.x * vec3.y - self.y * vec3.x)
end

-- deep copy
function Vector3:Copy() return JLib.Vector3(self.x, self.y, self.z) end
