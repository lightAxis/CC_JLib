require("init")

require("UI.Border")
require("UI.Enums")
require("MathLib.Vector2")

screen = {}
screen.write = function(d) print("wruteee:" .. d) end

local a = JLib.Border:new(nil, screen)
a.BG = JLib.Enums.Colors.magenta
a:render()

local b = JLib.Border:new(a, screen)
b:render()

b:setPosRel(JLib.Vector2:new(2,3))
b:render()

a:setPosRel(JLib.Vector2:new(3,5))
a:render()
b:render()