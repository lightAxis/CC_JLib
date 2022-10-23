require("init")
require("UI.Includes")

local len = JLib.Vector2:new(30, 20)
local g = JLib.Grid:new(len)
g:setHorizontalSetting({"10", "3*", "*", "2*"})
g:setVerticalSetting({"*", "5", "*"})
g:updatePosLen()

local a, b = g:getPosLen(2, 2, 2, 2)

print(a.x, a.y)
print(b.x, b.y)
