require("CC_JLib.init")

require("UI.Includes")
-- require("LibGlobal.StaticMethods")
-- require("UI.Screen")
-- require("UI.ScreenCanvas")

-- require("UI.TextArea")
-- require("UI.Border")
-- require("UI.Margin")
-- require("MathLib.Vector2")


-- local screen = JLib.Screen:new(peripheral.wrap("top"), JLib.Enums.Side.top)
local screen = JLib.Screen:new(term, JLib.Enums.Side.top)
screen:clearScreen()
local posrel = JLib.Vector2:new(2, 3)
local len = JLib.Vector2:new(30, 15)
local bg = JLib.Enums.Color.lightBlue
local fg = JLib.Enums.Color.cyan
local text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit.\nNunc nec urna torto.\nNam males uada justo nec nulla molestie posuere.\nAenean mi quam, tristique a est sed, facilisis imperdiet purus.\nInteger ornare non nulla vel commodo.\nMorbi ut mollis lorem, ut placerat purus."--\nUt in est vel mauris consectetur cursus eu sodales metus.\nIn hac habitasse platea dictumst.\nVivamus pharetra consectetur ex ut scelerisque.\nFusce consequat luctus justo, ut ornare nisl ultricies eget.\nAenean non fermentum sem.."
local textcolor = JLib.Enums.Color.black
local margin = 2
local bordercolor = JLib.Enums.Color.green
local borderthickness = 1
local scroll = 1

local posrel2 = JLib.Vector2:new(5, 5)
local len2 = JLib.Vector2:new(20, 10)
local bg2 = JLib.Enums.Color.lightGray
local fg2 = JLib.Enums.Color.blue
local text2 = "another text!"
local textcolor2 = JLib.Enums.Color.red
local margin2 = 1
local bordercolor2 = JLib.Enums.Color.lightBlue
local borderthickness2 = 0
local scroll2 = 1

local sc1 = JLib.ScreenCanvas:new(nil, screen, "screencanvas_1")


local t2 = JLib.TextBlock:new(sc1, screen, "Textblock_2", text2, posrel2, len2,bg2, fg2)
t2:setTextColor(textcolor2)
t2:setMarginAll(margin2)
t2:setBorderColor(bordercolor2)
t2:setBorderThickness(borderthickness2)
t2:setScroll(scroll2)
t2:setIsTextEditable(true)


local t1 = JLib.TextBlock:new(sc1, screen, "Textblock_1",text, posrel, len, bg, fg)
t1:setTextColor(textcolor)
t1:setMarginAll(margin)
t1:setBorderColor(bordercolor)
t1:setBorderThickness(borderthickness)
t1:setScroll(scroll)
t1:setIsTextEditable(true)


sc1:render()
local FocusedElement = sc1
while(true) do
    
    local event, button, x, y = os.pullEvent()
    if(event == "mouse_scroll") then
        local newFocusElement = screen:getUIAtPos(JLib.Vector2:new(x,y))
        -- if(newFocusElement ~= FocusedElement) then
        --     FocusedElement:FocusOut()
        --     newFocusElement:FocusIn()
        -- end
        newFocusElement:triggerScrollEvent(button,JLib.Vector2:new(x, y))
    elseif(event == "mouse_click") then
        if(button == 1) then
            local newFocusElement = screen:getUIAtPos(JLib.Vector2:new(x,y))
            if(newFocusElement ~= FocusedElement) then
                FocusedElement:FocusOut()
                newFocusElement:FocusIn()
            end
            newFocusElement:triggerClickEvent(button, JLib.Vector2:new(x,y))
            FocusedElement = newFocusElement
        end
    elseif(event == "key") then
        if(button == keys.up) then
            t1.PosRel.y = t1.PosRel.y - 1
        elseif(button == keys.down) then
            t1.PosRel.y = t1.PosRel.y + 1
        elseif(button == keys.left) then
            t1.PosRel.x = t1.PosRel.x - 1
        elseif(button == keys.right) then
            t1.PosRel.x = t1.PosRel.x + 1
        elseif(button == keys.numPad8) then
            t1.Len.y = t1.Len.y - 1
        elseif(button == keys.numPad2) then
            t1.Len.y = t1.Len.y + 1
        elseif(button == keys.numPad4) then
            t1.Len.x = t1.Len.x - 1
        elseif(button == keys.numPad6) then
            t1.Len.x = t1.Len.x + 1
        elseif(button == keys.one) then
            t1:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.left)
        elseif(button == keys.two) then
            t1:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
        elseif(button == keys.three) then
            t1:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.right)
        elseif(button == keys.four) then
            t1:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.top)
        elseif(button == keys.five) then
            t1:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
        elseif(button == keys.six) then
            t1:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.bottom)
        elseif(button == keys.backspace) then
            FocusedElement:triggerKeyInputEvent(button)
        elseif(button == keys.delete) then
            FocusedElement:triggerKeyInputEvent(button)
        elseif(button == keys.enter) then
            FocusedElement:triggerKeyInputEvent(button)
        end
    elseif(event == "char") then
        FocusedElement:triggerCharEvent(button) 
    elseif(event == "monitor_touch") then
        local newFocusElement = screen:getUIAtPos(JLib.Vector2:new(x,y))
            if(newFocusElement ~= FocusedElement) then
                FocusedElement:FocusOut()
                newFocusElement:FocusIn()
            end
            newFocusElement:triggerClickEvent(button, JLib.Vector2:new(x,y))
            FocusedElement = newFocusElement
    end

    screen:clearScreen()
    sc1:render()
    FocusedElement:PostRendering()


    --os.sleep(0.01)
end

