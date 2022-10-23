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
local sc1 = JLib.ScreenCanvas:new(nil, screen, "screencanvas_1")

local listbox = JLib.ListBox:new(sc1, screen, "listbox")
local fuu = function(k, v) return {["a"] = k, ["b"] = v} end
local testTable1 = {1, 2, 3, 4, 5, 6, 7, 8, 9, 0}
local testTable2 = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k"}
local source = {}
for index, value in ipairs(testTable1) do
    table.insert(source, fuu(testTable1[index], testTable2[index]))
end

listbox:setItemSource(source)
local itemTemplate = function(obj)
    local text = tostring(obj.a) .. "/" .. obj.b
    return text
end

listbox:setItemTemplate(itemTemplate)
listbox:Refresh()
listbox.PosRel = JLib.Vector2:new(2, 3)
listbox.Len = JLib.Vector2:new(5, 5)
listbox:setScroll(2)

local tb1 = JLib.TextBlock:new(sc1, screen, "tb1", "")
tb1.PosRel = JLib.Vector2:new(10, 1)
tb1.Len = JLib.Vector2:new(10, 3)
tb1:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
tb1:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)
tb1:setIsTextEditable(true)

local tb2 = JLib.TextBlock:new(sc1, screen, "tb2", "")
tb2.PosRel = JLib.Vector2:new(10, 5)
tb2.Len = JLib.Vector2:new(10, 3)
tb2:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
tb2:setTextHorizontalAlignment(JLib.Enums.HorizontalAlignmentMode.center)

---@param obj ListBoxItem
local fuu2 = function(obj)
    local obj2 = obj.obj
    tb1:setText("id : " .. tostring(obj2.a))
    tb2:setText("pass : " .. obj2.b)
end

listbox.SelectedIndexChanged = fuu2

sc1:render()

local FocusedElement = sc1
while (true) do

    local event, button, x, y = os.pullEvent()
    if (event == "mouse_scroll") then
        local newFocusElement = screen:getUIAtPos(JLib.Vector2:new(x, y))
        -- if(newFocusElement ~= FocusedElement) then
        --     FocusedElement:FocusOut()
        --     newFocusElement:FocusIn()
        -- end
        newFocusElement:triggerScrollEvent(button, JLib.Vector2:new(x, y))
    elseif (event == "mouse_click") then
        if (button == 1) then
            local newFocusElement = screen:getUIAtPos(JLib.Vector2:new(x, y))
            if (newFocusElement ~= FocusedElement) then
                FocusedElement:FocusOut()
                newFocusElement:FocusIn()
            end
            newFocusElement:triggerClickEvent(button, JLib.Vector2:new(x, y))
            FocusedElement = newFocusElement
        end
    elseif (event == "char") then
        FocusedElement:triggerCharEvent(button)
    elseif (event == "key") then
        FocusedElement:triggerKeyInputEvent(button)
    elseif (event == "monitor_touch") then
        local newFocusElement = screen:getUIAtPos(JLib.Vector2:new(x, y))
        if (newFocusElement ~= FocusedElement) then
            FocusedElement:FocusOut()
            newFocusElement:FocusIn()
        end
        newFocusElement:triggerClickEvent(button, JLib.Vector2:new(x, y))
        FocusedElement = newFocusElement
    end

    -- screen:clearScreen()
    sc1:render()
    FocusedElement:PostRendering()
end
