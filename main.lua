require("init")

require("UI.Includes")

local screen = JLib.Screen:new({}, JLib.Enums.Side.top)
---@type ScreenCanvas
local screenCanvas = JLib.ScreenCanvas:new(nil, screen, "screenCanvas")

local listbox = JLib.ListBox:new(screenCanvas, screen, "listbox")

local fuu = function(k, v) return { ["a"] = k, ["b"] = v } end

local testTable1 = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 0 }
local testTable2 = { "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k" }
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

screenCanvas:render()
screenCanvas:Reflect2Screen()
