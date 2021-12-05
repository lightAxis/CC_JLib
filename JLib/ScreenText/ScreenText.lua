local class = require("Class.middleclass")

--- public class ScreenText  
---  
---**require** :  
--- - Class.middleclass
---@class ScreenText
local ScreenText = class("ScreenText")

-- namespace JLib
JLib = JLib or {}
JLib.ScreenText = ScreenText

-- constructor
---@param monitor Screen target screen to display
function ScreenText:initialize(monitor)
    self._monitor = monitor
    self._curHorizontalAlignMode = JLib.Enums.HorizontalAlignmentMode.center
    self._curVerticalAlignMode = JLib.Enums.VerticalAlignmentMode.center
    self._textLines = {}
    self._textColors = {}
end
---@class ScreenText
---@field _monitor Screen
---@field _curHorizontalAlignMode Enums.HorizontalAlignmentMode
---@field _curVerticalAlignMode Enums.VerticalAlignmentMode
---@field _textLines table<number, string>
---@field _textColors table<number, Enums.Color>
---@field new fun(monitor?:Screen): ScreenText

-- functions

---add new textline to draw
---@param text string
---@param textcolor Enums.Color
function ScreenText:AddTextLine(text, textcolor)
    table.insert(self._textLines, text)
    table.insert(self._textColors, textcolor)
end

---set horizontal alignment mode
---@param mode Enums.HorizontalAlignmentMode
function ScreenText:SetHorizontalAlignMode(mode)
    self._curHorizontalAlignMode = mode
    -- print("dd")
end

---set vertical alignment mode
---@param mode Enums.VerticalAlignmentMode
function ScreenText:SetVerticalAlignMode(mode)
    self._curVerticalAlignMode = mode;
    -- print("dd")
end

---debug text line internal
function ScreenText:DebugTextLine()
    for i, v in ipairs(self._textLines) do print(v .. "\n") end
end

---draw the internal lines to terminal
function ScreenText:DrawTextLines()
    for i, v in ipairs(self._textLines) do
        local x, y = self:_calcCursorPosition(i)
        self._monitor:setCursorPos_Raw(x, y)
        self._monitor:setTextColor(self._textColors[i])
        self._monitor:write(v)
    end
end

---calculate cursor position of each lines
---@param index number
---@return number x, number y
function ScreenText:_calcCursorPosition(index)
    local strLen = string.len(self._textLines[index])
    -- print("strlen"..strLen.."\n")
    local linesLen = #(self._textLines)
    -- print("linesLen:"..linesLen.."\n")
    local monitorSize = self._monitor:getSize()
    -- print("xmax:"..xmax.."\n")
    -- print("ymax:"..ymax.."\n")
    local xmax, ymax = monitorSize.x, monitorSize.y
    local x, y

    if self._curHorizontalAlignMode == "Left" then
        x = 1
    elseif self._curHorizontalAlignMode == "Right" then
        x = xmax - strLen + 1
    elseif self._curHorizontalAlignMode == "Center" then
        x = math.floor((xmax - strLen) / 2) + 1
    end
    if self._curVerticalAlignMode == "Top" then
        y = 1
    elseif self._curVerticalAlignMode == "Bottom" then
        y = ymax - linesLen + 1
    elseif self._curVerticalAlignMode == "Center" then
        y = math.floor((ymax - linesLen) / 2) + 1
        -- print("y is center:"..y.."\n")
    end
    y = y + (index - 1)
    -- print("x,y,i:"..x.."/"..y.."/"..index.."\n")
    return x, y
end

---clear screen
function ScreenText:Clear()
    self._monitor:clear()
    self._textLines = {}
    self._monitor:setCursorPos_Raw(1, 1)
end

---set TextScale of monitor
---@param size number
function ScreenText:SetTextScale(size) self._monitor:setTextScale(size) end