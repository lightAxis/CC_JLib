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
local screen = JLib.Screen:new({}, JLib.Enums.Side.top)
screen:clearScreen()
local posrel = JLib.Vector2:new(2, 3)
local len = JLib.Vector2:new(20, 9)
local bg = JLib.Enums.Color.lightBlue
local fg = JLib.Enums.Color.cyan

local text =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.\nNunc nec urna tortor.\nNam males" -- uada justo nec nulla molestie posuere."-- \nAenean mi quam, tristique a est sed, facilisis imperdiet purus.\nInteger ornare non nulla vel commodo.\nMorbi ut mollis lorem, ut placerat purus.\nUt in est vel mauris consectetur cursus eu sodales metus.\nIn hac habitasse platea dictumst.\nVivamus pharetra consectetur ex ut scelerisque.\nFusce consequat luctus justo, ut ornare nisl ultricies eget.\nAenean non fermentum sem.."
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
t1:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)

sc1:render()
t1._TextArea.IsTextEditable = true

t1._TextArea:triggerClickEvent(1, JLib.Vector2:new(8, 8))

screen:clearScreen()
sc1:render()
t1._TextArea:PostRendering()

-- while(true) do

--     local event, button, x, y = os.pullEvent()
--     if(event == "mouse_scroll") then
--         scroll = t1:getScroll()
--         scroll = scroll + button
--         t1:setScroll(scroll)
--     elseif(event == "mouse_click") then
--         if(button == 1) then
--             t1._TextArea:triggerClickEvent(button, JLib.Vector2:new(x,y))
--         end
--     elseif(event == "key") then
--         if(button == keys.up) then
--             t1.PosRel.y = t1.PosRel.y - 1
--         elseif(button == keys.down) then
--             t1.PosRel.y = t1.PosRel.y + 1
--         elseif(button == keys.left) then
--             t1.PosRel.x = t1.PosRel.x - 1
--         elseif(button == keys.right) then
--             t1.PosRel.x = t1.PosRel.x + 1
--         elseif(button == keys.numPad8) then
--             t1.Len.y = t1.Len.y - 1
--         elseif(button == keys.numPad2) then
--             t1.Len.y = t1.Len.y + 1
--         elseif(button == keys.numPad4) then
--             t1.Len.x = t1.Len.x - 1
--         elseif(button == keys.numPad6) then
--             t1.Len.x = t1.Len.x + 1
--         elseif(button == keys.one) then
--             t1:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.left)
--         elseif(button == keys.two) then
--             t1:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
--         elseif(button == keys.three) then
--             t1:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.right)
--         elseif(button == keys.backspace) then
--             t1._TextArea:triggerKeyInputEvent(button)
--         elseif(button == keys.delete) then
--             t1._TextArea:triggerKeyInputEvent(button)
--         elseif(button == keys.enter) then
--             t1._TextArea:triggerKeyInputEvent(button)
--         end
--     elseif(event == "char") then
--         t1._TextArea:triggerCharEvent(button) 
--     elseif(event == "monitor_touch") then
--         t1._TextArea:triggerClickEvent(1, JLib.Vector2:new(x,y))
--     end

--     screen:clearScreen()
--     sc1:render()
--     t1._TextArea:PostRendering()

--     --os.sleep(0.01)
-- end

