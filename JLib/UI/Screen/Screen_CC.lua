local class = require("Class.middleclass")

-- #includes
require("MathLib.Vector2")
require("UI.Screen.ScreenBuffer_t")

---public class Screen
---
---**require** :
--- - Class.middleclass
--- - MathLib.Vector2
---@class Screen
local Screen_CC = class("Screen")

-- namespace JLib
JLib = JLib or {}
JLib.Screen = Screen_CC

-- [constructor]
---@param screenObj any -- computercraft screen obj
---@param side Enums.Side
function Screen_CC:initialize(screenObj, side)
    if (screenObj == nil) then
        error("screenObj cannot be nil! Screen_CC:initialize(screenObj, side)")
    end
    if (side == nil) then
        error("side cannot be nil! Screen_CC:initialize(screenObj, side)")
    end
    self._screen = screenObj
    self._side = side
    self.IsMonitor = self._side ~= JLib.Enums.Side.NONE

    ---@type table<number, UIElement>
    self._renderHistory = {}

    self._CursorPos = JLib.Vector2:new(1, 1)
    self._BG = JLib.Enums.Color.black
    self._FG = JLib.Enums.Color.white
    self._ScreenSize = self:getSize()

    self._MAX_SCREEN_SIZE = JLib.Vector2:new(162, 80)

    -- ready Screen_t.Buffer table for maximum resolution in computercraft monitor
    ---@type table<number,table<number, Screen_t.Buffer>>
    self._screenBuffer = {}
    local BGStr = JLib.Enums.Blit[JLib.Enums.Color.black]
    local FGStr = JLib.Enums.Blit[JLib.Enums.Color.white]
    for x = 1, self._MAX_SCREEN_SIZE.x, 1 do
        self._screenBuffer[x] = {}
        for y = 1, self._MAX_SCREEN_SIZE.y, 1 do
            self._screenBuffer[x][y] = JLib.Screen_t.Buffer:new(" ", FGStr, BGStr)
        end
    end

end

-- properties description
---@class Screen
---@field _screen any
---@field _side Enums.Side
---@field _renderHistory table<number, UIElement>
---@field _screenBuffer table<number, table<number, Screen_t.Buffer>>
---@field new fun(self: Screen, screenObj: Screen, side: Enums.Side): Screen

-- [functions]

-- Writes text to the screen, using the current text and background colors.
---@param text string
function Screen_CC:write(text)

    local y = self._CursorPos.y
    if y < 1 then return nil
    elseif y > self._ScreenSize.y then return nil
    end

    local len = #text
    local x_min = self._CursorPos.x
    local _, x_max = JLib.UITools.Len2Pos_FromStart(x_min, len)

    if x_max < 1 then return nil
    elseif x_min > self._ScreenSize.x then return nil
    end
    local x_min_ = JLib.UITools.constrain(x_min, 1, self._ScreenSize.x)
    local x_max_ = JLib.UITools.constrain(x_max, 1, self._ScreenSize.x)

    local strLenOffset = x_min - x_min_ + 1

    local BGStr = JLib.Enums.Blit[self._BG]
    local FGStr = JLib.Enums.Blit[self._FG]

    if (BGStr == JLib.Enums.Blit[JLib.Enums.Color.None]) then
        -- if transparent
        for x = x_min_, x_max_, 1 do
            local curChar = text:sub(strLenOffset, strLenOffset)
            if curChar ~= " " then
                self._screenBuffer[x][y].Text = curChar
                self._screenBuffer[x][y].FG = FGStr
            end
            strLenOffset = strLenOffset + 1

        end
    else
        -- if not transparent
        for x = x_min_, x_max_, 1 do
            self._screenBuffer[x][y].Text = text:sub(strLenOffset, strLenOffset)
            self._screenBuffer[x][y].BG = BGStr
            self._screenBuffer[x][y].FG = FGStr
            strLenOffset = strLenOffset + 1
        end
    end

    self._CursorPos.x = x_max_ + 1
    -- self._screen.write(text)
end

-- Writes text to the screen using the specified text and background colors. Requires version 1.74 or newer.
---@param text string
---@param fg string
---@param bg string
function Screen_CC:bilt(text, fg, bg)

    if #text ~= #fg or #fg ~= #bg then
        error("blit must have same length text:" + #text + "/fg:" + #fg + "/bg:" + #bg)
        return nil
    end

    local y = self._CursorPos.y
    if y < 1 then return nil
    elseif y > self._ScreenSize.y then return nil
    end

    local len = #text
    local x_min = self._CursorPos.x
    local x_max = JLib.UITools.Len2Pos_FromStart(x_min, len)

    if x_max < 1 then return nil
    elseif x_min > self._ScreenSize.x then return nil
    end
    local x_min_ = JLib.UITools.constrain(x_min, 1, self._ScreenSize.x)
    local x_max_ = JLib.UITools.constrain(x_max, 1, self._ScreenSize.x)

    local strLenOffset = x_min - x_min_ + 1
    for x = x_min_, x_max_, 1 do
        self._screenBuffer[x][y].Text = text:sub(strLenOffset, 1)
        -- not transparent bg
        if (fg:sub(strLenOffset, 1) ~= JLib.Enums.Blit[JLib.Enums.Color.None]) then
            self._screenBuffer[x][y].BG = fg:sub(strLenOffset, 1)
        end
        self._screenBuffer[x][y].FG = bg:sub(strLenOffset, 1)
        strLenOffset = strLenOffset + 1
    end
    -- self._screen.bilt(text, fg, bg)

    self._CursorPos.x = x_max_ + 1
end

-- Clears the entire screen.
function Screen_CC:clear()

    local FGStr = JLib.Enums.Blit[self._FG]
    local BGStr = JLib.Enums.Blit[self._BG]
    -- avoid transparent clear
    if (BGStr == JLib.Enums.Blit[JLib.Enums.Color.None]) then
        BGStr = JLib.Enums.Blit[JLib.Enums.Color.black]
    end

    for x = 1, self._ScreenSize.x, 1 do
        for y = 1, self._ScreenSize.y, 1 do
            self._screenBuffer[x][y].Text = " "
            self._screenBuffer[x][y].FG = FGStr
            self._screenBuffer[x][y].BG = BGStr
        end
    end

    -- self._screen.clear()
    -- self._screen.clear()
end

-- Clears the line the cursor is on.
function Screen_CC:clearLine()
    local y = self._CursorPos.y
    if y < 1 or y > self._ScreenSize.y then return nil end

    local FGStr = JLib.Enums.Blit[self._FG]
    local BGStr = JLib.Enums.Blit[self._BG]

    -- avoid transparent bg
    if BGStr == JLib.Enums.Blit[JLib.Enums.Color.None] then
        BGStr = JLib.Enums.Blit[JLib.Enums.Color.black]
    end

    for x = 1, self._ScreenSize.x, 1 do
        self._screenBuffer[x][y].Text = " "
        self._screenBuffer[x][y].FG = FGStr
        self._screenBuffer[x][y].BG = BGStr
    end
    -- self._screen.clearLine()
end

-- Returns two arguments containing the x and the y position of the cursor.
---@return Vector2
function Screen_CC:getCursorPos()
    local x, y = Screen_CC:getCursorPos_Raw()
    return JLib.Vector2:new(x, y)
end

-- Returns two arguments containing the x and the y position of the cursor. use only lua
---@return number, number
function Screen_CC:getCursorPos_Raw() return self._screen.getCursorPos() end

-- Sets the cursor's position.
function Screen_CC:setCursorPos(pos)
    -- self._CursorPos = pos
    self:setCursorPos_Raw(pos.x, pos.y)
end

-- Sets the cursor's position. use only lua
-- change the real monitor cursor pos
function Screen_CC:setCursorPos_Raw(x, y)
    self._CursorPos = JLib.Vector2:new(x, y)
    self._screen.setCursorPos(x, y)
end

-- Disables the blinking or turns it on.
-- change the real monitor cursor blink
function Screen_CC:setCursorBlink(bool)
    self._screen.setCursorBlink(bool)
end

-- Returns whether the terminal supports color.
-- get from real monitor
---@return boolean
function Screen_CC:isColor() return self._screen.isColor() end

-- Returns two arguments containing the x and the y values stating the size of the screen.
---(Good for if you're making something to be compatible with both Turtles and Computers.)
---use only lua
---@return number, number
function Screen_CC:getSize_Raw()
    local x, y = self._screen.getSize()

    -- if link with monitor lost, keep draw with screenbuffer
    if (x == nil) then
        return self._ScreenSize.x, self._ScreenSize.y
    else
        return self._screen.getSize()
    end
end

-- Returns two arguments containing the x and the y values stating the size of the screen.
---(Good for if you're making something to be compatible with both Turtles and Computers.)
--- get size from real monitor
---@return Vector2
function Screen_CC:getSize()
    local x, y = self:getSize_Raw()
    return JLib.Vector2:new(x, y)
end

-- Sets the text color of the terminal. Limited functionality without an Advanced machines.
---@param color Enums.Color
function Screen_CC:setTextColor(color)
    self._FG = color
    -- self._screen.setTextColor(color)
end

-- Returns the current text color of the terminal. Requires version 1.74 or newer.
---@return Enums.Color
function Screen_CC:getTextColor() return self._FG end

-- Sets the background color of the terminal. Limited functionality without an Advanced Computer / Turtle / Monitor.
---@param color Enums.Color
function Screen_CC:setBackgroundColor(color)
    self._BG = color
    -- self._screen.setBackgroundColor(color)
end

-- Returns the current background color of the terminal. Requires version 1.74 or newer.
---@return Enums.Color
function Screen_CC:getBackgroundColor()
    return self._BG
    -- return self._screen.getBackgroundColor()
end

-- Sets the text scale. Available only to monitor objects.
-- set the real monitor text scale and update the screen size immediately
---@param scale number
function Screen_CC:setTextScale(scale)
    self._screen.setTextScale(scale)
    self._ScreenSize = self:getSize()
end

-- [custom functions]

---add new render element to renderHistory
---@param element UIElement
function Screen_CC:addRenderElement(element)
    table.insert(self._renderHistory, element)
end

---clear this screen
function Screen_CC:clearScreen()
    self:setBackgroundColor(JLib.Enums.Color.black)
    self:clear()

    self._renderHistory = {}
end

function Screen_CC:clearRenderHistory() self._renderHistory = {} end

---Get UIElement at position
---@param pos Vector2
---@return UIElement|nil
function Screen_CC:getUIAtPos(pos)
    -- print(#(self._renderHistory), "aaaa")
    for i = #(self._renderHistory), 1, -1 do
        if (self._renderHistory[i]:isPositionOver(pos) == true) then
            return self._renderHistory[i]
        end
    end
    -- print("aaaa2")
    return nil
end

---get screen side of this Screen module
---@return Enums.Side
function Screen_CC:getScreenSide() return self._side end

---reflect screen buffer to action screen
function Screen_CC:reflect2Screen()
    self._ScreenSize = self:getSize()

    local textStr = ""
    local fgStr = ""
    local bgStr = ""
    for y = 1, self._ScreenSize.y, 1 do
        self._screen.setCursorPos(1, y)

        textStr = ""
        fgStr = ""
        bgStr = ""
        for x = 1, self._ScreenSize.x, 1 do
            textStr = textStr .. self._screenBuffer[x][y].Text
            fgStr = fgStr .. self._screenBuffer[x][y].FG
            bgStr = bgStr .. self._screenBuffer[x][y].BG
        end

        self._screen.blit(textStr, fgStr, bgStr)
    end

    self._screen.setCursorPos(self._CursorPos.x, self._CursorPos.y)
end
