local class = require("Class.middleclass")
require("ClassTest.ClassA")

-- public class ClassB
local ClassB = class("ClassB", JLib.ClassA)

-- namespace JLib
JLib = JLib or {}
JLib.ClassB = ClassB

-- constructor
function ClassB:initialize(x, y, z, k)
    JLib.ClassA.initialize(self, x, y)
    self.z = z or 100
    self.k = k or 200
end

-- functions
function ClassB:do1() print("B1") end

function ClassB:do3() print("B3") end
