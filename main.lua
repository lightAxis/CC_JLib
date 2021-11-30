require("init")

require("UI.Includes")
-- require("LibGlobal.StaticMethods")
-- require("UI.Screen")
-- require("UI.ScreenCanvas")

-- require("UI.TextArea")
-- require("UI.Border")
-- require("UI.Margin")
-- require("MathLib.Vector2")

-- local screen = JLib.Screen:new(peripheral.wrap("top"))
local screen = JLib.Screen:new(term)
JLib.UITools.clearScreen(screen)
local posrel = JLib.Vector2:new(2, 3)
local len = JLib.Vector2:new(20, 9)
local bg = JLib.Enums.Colors.lightBlue
local fg = JLib.Enums.Colors.cyan

local text =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.\nNunc nec urna tortor.\nNam malesuada justo nec nulla molestie posuere.\nAenean mi quam, tristique a est sed, facilisis imperdiet purus.\nInteger ornare non nulla vel commodo.\nMorbi ut mollis lorem, ut placerat purus.\nUt in est vel mauris consectetur cursus eu sodales metus.\nIn hac habitasse platea dictumst.\nVivamus pharetra consectetur ex ut scelerisque.\nFusce consequat luctus justo, ut ornare nisl ultricies eget.\nAenean non fermentum sem.."
local textcolor = JLib.Enums.Colors.black

local margin = 2

local bordercolor = JLib.Enums.Colors.green
local borderthickness = 1

local scroll = 1

local sc1 = JLib.ScreenCanvas:new(nil, screen, "screencanvas_1")
local t1 = JLib.TextBlock:new(sc1, screen, "Textblock_1", posrel, len, bg, fg,
                              text)

t1:setTextColor(textcolor)
t1:setMarginAll(margin)
t1:setBorderColor(bordercolor)
t1:setBorderThickness(borderthickness)
t1:setScroll(scroll)

sc1:render()

-- local b1 = JLib.Border:new(sc1, screen, "border_1")
-- b1.Len = JLib.Vector2:new(15, 7)
-- b1.BorderThickness = 1
-- b1.BorderColor = JLib.Enums.Colors.red

-- local m1 = JLib.Margin:new(b1, screen, "margin_1")
-- m1.MarginLeft = 3
-- m1.MarginRight = 4
-- m1.MarginTop = 1
-- m1.MarginBottom = 2

-- local t1 = JLib.TextArea:new(m1, screen, "textarea_1")
-- t1:setText("1234\n123456789\n\n1234\n")
-- t1.BG = JLib.Enums.Colors.lime
-- t1.FG = JLib.Enums.Colors.gray
-- t1._scroll = 2

-- b1:render()

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
