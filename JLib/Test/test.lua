require("Class.class")

test = class()

--properties
test:set{
    prop1 = 1,
    prop2 = 2,
    _prop3 = 3,
}

--constructor
function test:init(a, b, c)
    self.prop1 = a + b + c
    self.prop2 = a * b * c
    self._prop3 = a * b + c
end

function test:PrintAll()
    print("prop1:"..self.prop1.."/prop2:"..self.prop2.."/_prop3:"..self._prop3)
end

