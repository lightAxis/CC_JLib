local class = require("Class.middleclass")

-- #includes
require("MathLib.Vector2")

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
    self._renderHistory = {}
end

-- properties description
---@class Screen
---@field _screen any
---@field _side Enums.Side
---@field _renderHistory table<number, UIElement>
---@field new fun(self: Screen, screenObj: Screen, side: Enums.Side): Screen

-- [functions]

-- Writes text to the screen, using the current text and background colors.
---@param text string
function Screen_CC:write(text) self._screen.write(text) end

-- Writes text to the screen using the specified text and background colors. Requires version 1.74 or newer.
---@param text string
---@param fg Enums.Color
---@param bg Enums.Color
function Screen_CC:bilt(text, fg, bg) self._screen.bilt(text, fg, bg) end

-- Clears the entire screen.
function Screen_CC:clear() self._screen.clear() end

-- Clears the line the cursor is on.
function Screen_CC:clearLine() self._screen.clearLine() end

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
function Screen_CC:setCursorPos(pos) self:setCursorPos_Raw(pos.x, pos.y) end

-- Sets the cursor's position. use only lua
function Screen_CC:setCursorPos_Raw(x, y) self._screen.setCursorPos(x, y) end

-- Disables the blinking or turns it on.
function Screen_CC:setCursorBlink(bool) self._screen.setCursorBlink(bool) end

-- Returns whether the terminal supports color.
---@return boolean
function Screen_CC:isColor() return self._screen.isColor() end

-- Returns two arguments containing the x and the y values stating the size of the screen.  
---(Good for if you're making something to be compatible with both Turtles and Computers.)  
---use only lua  
---@return number, number
function Screen_CC:getSize_Raw() return self._screen.getSize() end

-- Returns two arguments containing the x and the y values stating the size of the screen.  
---(Good for if you're making something to be compatible with both Turtles and Computers.)  
---@return Vector2
function Screen_CC:getSize()
    local x, y = self:getSize_Raw()
    return JLib.Vector2:new(x, y)
end

-- Sets the text color of the terminal. Limited functionality without an Advanced machines.
---@param color Enums.Color
function Screen_CC:setTextColor(color) self._screen.setTextColor(color) end

-- Returns the current text color of the terminal. Requires version 1.74 or newer.
---@return Enums.Color
function Screen_CC:getTextColor() return self._screen.getTextColor() end

-- Sets the background color of the terminal. Limited functionality without an Advanced Computer / Turtle / Monitor.
---@return Enums.Color
function Screen_CC:setBackgroundColor(color)
    self._screen.setBackgroundColor(color)
end

-- Returns the current background color of the terminal. Requires version 1.74 or newer.
---@return Enums.Color
function Screen_CC:getBackgroundColor() return self._screen.getBackgroundColor() end

-- Sets the text scale. Available only to monitor objects.
---@param scale number
function Screen_CC:setTextScale(scale) self._screen.setTextScale(scale) end

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
