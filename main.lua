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
local screen = JLib.Screen:new({}, JLib.Enums.Side.top)
screen:clearScreen()
local posrel = JLib.Vector2:new(2, 3)
local len = JLib.Vector2:new(10, 9)
local bg = JLib.Enums.Color.lightBlue
local fg = JLib.Enums.Color.cyan

local text = "12345\n123456789\n\n123\n456\n789\n1234567890"
local textcolor = JLib.Enums.Color.black

local margin = 2

local bordercolor = JLib.Enums.Color.green
local borderthickness = 1

local scroll = 1

local sc1 = JLib.ScreenCanvas:new(nil, screen, "screencanvas_1")
local t1 = JLib.TextBlock:new(sc1, screen, "Textblock_1", text, posrel, len, bg,
                              fg)

t1:setTextColor(textcolor)
t1:setMarginAll(margin)
t1:setBorderColor(bordercolor)
t1:setBorderThickness(borderthickness)
t1:setScroll(scroll)

t1._TextArea.IsTextEditable = true

sc1:render()

local touchPos = JLib.Vector2:new(9, 8)

local ee = screen:getUIAtPos(touchPos)
print(ee.Name)

ee._isTextEditting = true

ee:triggerClickEvent(JLib.Enums.MouseButton.left, touchPos)

ee:triggerCharEvent("x")

sc1:render()

ee:triggerKeyInputEvent(JLib.Enums.Key.backspace)

sc1:render()

ee:triggerKeyInputEvent(JLib.Enums.Key.delete)

sc1:render()

ee:triggerKeyInputEvent(JLib.Enums.Key.enter)
