local class = require("Class.middleclass")

-- #includes
require("MathLib.Vector2")

-- public class Screen
local Screen_Lua = class("Screen")

-- namespace JLib
JLib = JLib or {}
JLib.Screen = Screen_Lua

-- [constructor]
function Screen_Lua:initialize(screenObj, side)
    if (screenObj == nil) then
        error("screenObj cannot be nil! Screen_Lua:initialize(screenObj, side)")
    end
    if (side == nil) then
        error("side cannot be nil! Screen_Lua:initialize(screenObj, side)")
    end
    self._screen = screenObj
    self._side = side
    self._renderHistory = {}
end

-- [functions]

-- @brief Writes text to the screen, using the current text and background colors.
-- @param text:string
function Screen_Lua:write(text)
    print("ScreenCC:write:" .. text .. "," .. #text .. "\n")
end

-- @brief Writes text to the screen using the specified text and background colors. Requires version 1.74 or newer.
-- @param text:string
-- @param fg:JLib.Enums.Color
-- @param gb:JLib.Enums.Color
function Screen_Lua:bilt(text, fg, bg)
    print("Screen_CC:bilt:" .. text .. "," .. fg .. "," .. bg .. "\n")
end

-- @brief Clears the entire screen.
function Screen_Lua:clear() print("Screen_CC:clear\n") end

-- @brief Clears the line the cursor is on.
function Screen_Lua:clearLine() print("Screen_CC:clearLine\n") end

-- @brief Returns two arguments containing the x and the y position of the cursor.
-- @return JLib.Vector2
function Screen_Lua:getCursorPos() error("Screen_CC:GetCurposPos!") end

-- @brief Returns two arguments containing the x and the y position of the cursor. use only lua
-- @return num, num
function Screen_Lua:getCursorPos_Raw() error("Screen_CC:getCursorPos_Raw!") end

-- @brief Sets the cursor's position.
function Screen_Lua:setCursorPos(pos)
    print("Screen_CC:setCursorPos:" .. pos:toString() .. "\n")
end

-- @brief Sets the cursor's position. use only lua
function Screen_Lua:setCursorPos_Raw(x, y)
    print("Screen_CC:setCursorPos_Raw:" .. x .. "," .. y .. "\n")
end

-- @brief Disables the blinking or turns it on.
function Screen_Lua:setCursorBlink(bool)
    print("Screen_CC:setCursorBlink:" .. bool .. "\n")
end

-- @brief Returns whether the terminal supports color.
-- @return bool
function Screen_Lua:isColor() error("Screen_CC:isColor!") end

-- @brief Returns two arguments containing the x and the y values stating the size of the screen. 
-- (Good for if you're making something to be compatible with both Turtles and Computers.)
-- use only lua
-- @return num, num
function Screen_Lua:getSize_Raw() return 40, 24 end

-- @brief Returns two arguments containing the x and the y values stating the size of the screen. 
-- (Good for if you're making something to be compatible with both Turtles and Computers.)
-- @return JLib.Vector2
function Screen_Lua:getSize()
    -- error("Screen_CC:getSize!") 
    return JLib.Vector2:new(40, 24)
end

-- @brief Sets the text color of the terminal. Limited functionality without an Advanced machines.
-- @param color:JLib.Enums.Color
function Screen_Lua:setTextColor(color)
    print("Screen_CC:setTextColor:" .. color .. "\n")
end

-- @brief Returns the current text color of the terminal. Requires version 1.74 or newer.
-- @return JLib.Enums.Color
function Screen_Lua:getTextColor() error("Screen_CC:getTextColor!") end

-- @brief Sets the background color of the terminal. Limited functionality without an Advanced Computer / Turtle / Monitor.
-- @return JLib.Enums.Color
function Screen_Lua:setBackgroundColor(color)
    print("Screen_CC:setBackgroundColor:" .. color .. "\n")
end

-- @brief Returns the current background color of the terminal. Requires version 1.74 or newer.
-- @return JLib.Enums.Color
function Screen_Lua:getBackgroundColor() error("Screen_CC:getBackgroundColor!") end

-- @brief Sets the text scale. Available only to monitor objects.
-- @param scale:num
function Screen_Lua:setTextScale(scale) error("Screen_CC:setTextScale!") end

-- custom functions

function Screen_Lua:addRenderElement(element)
    table.insert(self._renderHistory, element)
end

function Screen_Lua:clearScreen()
    self:setBackgroundColor(JLib.Enums.Colors.black)
    self:clear()

    self._renderHistory = {}
end

function Screen_Lua:getUIAtPos(pos)
    for i = #(self._renderHistory), 1, -1 do
        if (self._renderHistory[i]:isPositionOver(pos) == true) then
            return self._renderHistory[i]
        end
    end
    return nil
end

function Screen_Lua:getScreenSide() return self._side end
