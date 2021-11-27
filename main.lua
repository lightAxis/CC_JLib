require("init")

require("UI.Border")
require("UI.Enums")
require("MathLib.Vector2")
require("UI.Screen")

local screen = JLib.Screen:new({})

local a = JLib.Border:new(nil, screen, "border_a")
a.BG = JLib.Enums.Colors.magenta
a.BorderColor = JLib.Enums.Colors.lime
a.BorderThickness = 1
a:setPosRel_Raw(2, 4)
a.Len = JLib.Vector2:new(7, 4)

local b = JLib.Border:new(a, screen, "border_b")
b.BG = JLib.Enums.Colors.pink
b.BorderColor = JLib.Enums.Colors.red
b.BorderThickness = 1
b:setPosRel(JLib.Vector2:new(5, 6))
b.Len = JLib.Vector2:new(8, 4)

a:render()

