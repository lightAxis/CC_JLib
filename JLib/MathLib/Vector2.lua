local class = require("Class.middleclass")

---public class Vector2  
---  
---**require** : 
--- - Class.middleclass
---@class Vector2
local Vector2 = class("Vector2")

-- namespace JLib
JLib = JLib or {}
JLib.Vector2 = Vector2

-- constructor
---@param x number
---@param y number
function Vector2:initialize(x, y)
    self.x = x
    self.y = y
end

-- properties description
---@class Vector2
---@field x number|nil
---@field y number|nil
---@field new fun(x:number, y:number): Vector2

-- functions

-- get L2 norm of this vector
---@return number norm 
function Vector2:norm() return math.sqrt(self.x * self.x + self.y + self.y) end

-- operator + overloading   
-- add each element value
---@param lhs Vector2
---@param rhs Vector2
---@return Vector2 vec
function Vector2.__add(lhs, rhs) return
    Vector2:new(lhs.x + rhs.x, lhs.y + rhs.y) end

-- operator - overloading
---sub each element value
---@param lhs Vector2
---@param rhs Vector2
---@return Vector2 vec
function Vector2.__sub(lhs, rhs) return
    Vector2:new(lhs.x - rhs.x, lhs.y - rhs.y) end

-- operator .toString() overloading  
---print each element to term
function Vector2:toString() return "(" .. self.x .. "," .. self.y .. ")" end

-- operator dot product
---@param vec2 Vector2 Vector2 to dot
---@return Vector2 vec
function Vector2:dot(vec2) return self.x * vec2.x + self.y * vec2.y end

-- deep copy
---@return Vector2 vec
function Vector2:Copy() return JLib.Vector2:new(self.x, self.y) end
