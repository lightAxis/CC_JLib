require("init")

require("LibGlobal.StaticMethods")
require("UI.TextBlock")
-- require("UI.Border")
require("UI.Screen")
require("MathLib.Vector2")

local screen = JLib.Screen:new({})

local t1 = JLib.TextBlock:new(nil, screen, "textblock_1")
t1.Len = JLib.Vector2:new(5, 5)
t1.PosRel = JLib.Vector2:new(2, 3)
t1:setText("1234\n123456789\n\n1234\n")
t1.BG = JLib.Enums.Colors.lime
t1.FG = JLib.Enums.Colors.gray
t1.scroll = 1

t1:render()

-- local b1 = JLib.Border:new(nil, screen, "borde_1")

-- require("UI.Border")
-- require("UI.Enums")
-- require("MathLib.Vector2")
-- require("UI.Screen")

-- local screen = JLib.Screen:new({})

-- local a = JLib.Border:new(nil, screen, "border_a")
-- a.BG = JLib.Enums.Colors.magenta
-- a.BorderColor = JLib.Enums.Colors.lime
-- a.BorderThickness = 1
-- a:setPosRel_Raw(2, 4)
-- a.Len = JLib.Vector2:new(7, 4)

-- local b = JLib.Border:new(a, screen, "border_b")
-- b.BG = JLib.Enums.Colors.pink
-- b.BorderColor = JLib.Enums.Colors.red
-- b.BorderThickness = 1
-- b:setPosRel(JLib.Vector2:new(5, 6))
-- b.Len = JLib.Vector2:new(8, 4)

-- a:render()
