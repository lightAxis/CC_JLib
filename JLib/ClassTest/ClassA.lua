local class = require("Class.middleclass")

-- public class ClassA
local ClassA = class("ClassA")

-- namespace JLib
JLib = JLib or {}
JLib.ClassA = ClassA

-- constructor
function ClassA:initialize(x, y)
    -- public:
    self.x = x or 1
    self.y = y or 22

    -- private:
    self._x = 2
    self._y = 44
end

function ClassA:do1() print("A1") end

function ClassA:do2() print("A2") end