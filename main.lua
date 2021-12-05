require("init")

require("UI.Includes")
-- require("LibGlobal.StaticMethods")
-- require("UI.Screen")
-- require("UI.ScreenCanvas")

-- require("UI.TextArea")
-- require("UI.Border")
-- require("UI.Margin")
-- require("MathLib.Vector2")

-- local screen = JLib.Screen:new(peripheral.wrap("top"), JLib.Enums.Side.top)
-- local screen = JLib.Screen:new(term, JLib.Enums.Side.top)
local screen = JLib.Screen:new({}, JLib.Enums.Side.top)
screen:clearScreen()
local posrel = JLib.Vector2:new(2, 3)
local len = JLib.Vector2:new(20, 9)
local bg = JLib.Enums.Color.lightBlue
local fg = JLib.Enums.Color.cyan

local text =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.\nNunc nec urna torto" -- r.\nNam males"--uada justo nec nulla molestie posuere."-- \nAenean mi quam, tristique a est sed, facilisis imperdiet purus.\nInteger ornare non nulla vel commodo.\nMorbi ut mollis lorem, ut placerat purus.\nUt in est vel mauris consectetur cursus eu sodales metus.\nIn hac habitasse platea dictumst.\nVivamus pharetra consectetur ex ut scelerisque.\nFusce consequat luctus justo, ut ornare nisl ultricies eget.\nAenean non fermentum sem.."
local textcolor = JLib.Enums.Color.black

local margin = 2

local bordercolor = JLib.Enums.Color.green
local borderthickness = 1

local scroll = 2

local sc1 = JLib.ScreenCanvas:new(nil, screen, "screencanvas_1")
local t1 = JLib.TextBlock:new(sc1, screen, "Textblock_1", text, posrel, len, bg,
                              fg)

t1:setTextColor(textcolor)
t1:setMarginAll(margin)
t1:setBorderColor(bordercolor)
t1:setBorderThickness(borderthickness)
t1:setScroll(scroll)

sc1:render()
t1._TextArea.IsTextEditable = true

t1._TextArea:triggerClickEvent(1, JLib.Vector2:new(4, 5))

sc1:render()
t1._TextArea:PostRendering()

t1._TextArea:triggerKeyInputEvent(JLib.Enums.Key.backspace)

sc1:render()
t1._TextArea:PostRendering()
