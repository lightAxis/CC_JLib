local class = require("Class.middleclass")

-- public class Vector2
local Vector2 = class("Vector2")

-- namespace JLib
JLib = JLib or {}
JLib.Vector2 = Vector2

-- constructor
function Vector2:initialize(x, y)
    self.x = x or nil
    self.y = y or nil
end

-- functions

-- norm function
function Vector2:norm() return math.sqrt(self.x * self.x + self.y + self.y) end

-- operator +
function Vector2.__add(lhs, rhs) return
    Vector2:new(lhs.x + rhs.x, lhs.y + rhs.y) end

-- operator -
function Vector2.__sub(lhs, rhs) return
    Vector2:new(lhs.x - rhs.x, lhs.y - rhs.y) end

-- operator .toString()
function Vector2:toString() return "(" .. self.x .. "," .. self.y .. ")" end

-- operator dot product
function Vector2:dot(vec2) return self.x * vec2.x + self.y * vec2.y end

-- deep copy
function Vector2:Copy() return JLib.Vector2:new(self.x, self.y) end