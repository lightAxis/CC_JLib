require("Class.class")

ScreenText = class()

--properties
ScreenText:set{
    _curHorizontalAlignMode = nil,
    _curVerticalAlignMode = nil,
    _monitor = nil,
    _textLines = {},
    _textColors = {},

}

--constructor
function ScreenText:init(monitor)
    self._monitor = monitor
    self._curHorizontalAlignMode = "Center"
    self._curVerticalAlignMode = "Center"
end



--functions
function ScreenText:AddTextLine(text, textcolor)
    table.insert(self._textLines, text)
    table.insert(self._textColors, textcolor)
end

function ScreenText:SetHorizontalAlignMode(mode)
    self._curHorizontalAlignMode = mode
    -- print("dd")
end

function ScreenText:SetVerticalAlignMode(mode)
    self._curVerticalAlignMode = mode;
    -- print("dd")
end

function ScreenText:DebugTextLine()
    for i, v in ipairs(self._textLines) do
        print(v.."\n")
    end
end


function ScreenText:DrawTextLines()
    for i, v in ipairs(self._textLines) do
        local x,y = self:_calcCursorPosition(i)
        self._monitor.setCursorPos(x, y)
        self._monitor.setTextColor(self._textColors[i])
        self._monitor.write(v)
    end
end


function ScreenText:_calcCursorPosition(index)
    local strLen = string.len(self._textLines[index])
    -- print("strlen"..strLen.."\n")
    local linesLen = #(self._textLines)
    -- print("linesLen:"..linesLen.."\n")
    local xmax, ymax = self._monitor.getSize()
    -- print("xmax:"..xmax.."\n")
    -- print("ymax:"..ymax.."\n")
    local textSize = self._monitor.getTextScale()
    -- print("textSize:"..textSize.."\n")


    local x,y

    if self._curHorizontalAlignMode == "Left" then
        x = 1
    elseif self._curHorizontalAlignMode == "Right" then
        x = xmax - strLen + 1
    elseif self._curHorizontalAlignMode == "Center" then
        x = math.floor((xmax - strLen)/2) + 1
    end

    if self._curVerticalAlignMode == "Top" then
        y = 1
    elseif self._curVerticalAlignMode == "Bottom" then
        y = ymax - linesLen + 1
    elseif self._curVerticalAlignMode == "Center" then
        y = math.floor((ymax - linesLen)/2) + 1
        -- print("y is center:"..y.."\n")
    end

    y = y + (index - 1)
    -- print("x,y,i:"..x.."/"..y.."/"..index.."\n")

    return x, y
end

function ScreenText:Clear()
    self._monitor.clear()
    self._textLines = {}
    self._monitor.setCursorPos(1,1)
end

function ScreenText:SetTextScale(size)
    self._monitor.setTextScale(size)
end