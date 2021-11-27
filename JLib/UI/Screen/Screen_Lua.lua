local class = require("Class.middleclass")

-- #includes
require("MathLib.Vector2")

-- public class Screen
local Screen = class("Screen")

-- namespace JLib
JLib = JLib or {}
JLib.Screen = Screen

-- [constructor]
function Screen:initialize(screenObj) self._screen = screenObj or nil end

-- [functions]

-- @brief Writes text to the screen, using the current text and background colors.
-- @param text:string
function Screen:write(text) print("Screen:write:" .. text) end

-- @brief Writes text to the screen using the specified text and background colors. Requires version 1.74 or newer.
-- @param text:string
-- @param fg:JLib.Enums.Color
-- @param gb:JLib.Enums.Color
function Screen:bilt(text, fg, bg)
    print("Screen:bilt:" .. text .. "," .. fg .. "," .. bg)
end

-- @brief Clears the entire screen.
function Screen:clear() print("Screen:clear:") end

-- @brief Clears the line the cursor is on.
function Screen:clearLine() print("Screen:clearLine") end

-- @brief Returns two arguments containing the x and the y position of the cursor.
-- @return JLib.Vector2
function Screen:getCursorPos() print("Screen:getCursorPos") end

-- @brief Returns two arguments containing the x and the y position of the cursor. use only lua
-- @return num, num
function Screen:getCursorPos_Raw() return self._screen.getCursorPos() end

-- @brief Sets the cursor's position.
function Screen:setCursorPos(pos) Screen:setCursorPos_Raw(pos.x, pos.y) end

-- @brief Sets the cursor's position. use only lua
function Screen:setCursorPos_Raw(x, y) self._screen.setCursorPos(x, y) end

-- @brief Disables the blinking or turns it on.
function Screen:setCursorBlink(bool) self._screen.setCursorBlink(bool) end

-- @brief Returns whether the terminal supports color.
-- @return bool
function Screen:isColor() return self._screen.isColor() end

-- @brief Returns two arguments containing the x and the y values stating the size of the screen. 
-- (Good for if you're making something to be compatible with both Turtles and Computers.)
-- use only lua
-- @return num, num
function Screen:getSize_Raw() return self._screen.getSize() end

-- @brief Returns two arguments containing the x and the y values stating the size of the screen. 
-- (Good for if you're making something to be compatible with both Turtles and Computers.)
-- @return JLib.Vector2
function Screen:getSize()
    local x, y = Screen:getSize_Raw()
    return JLib.Vector2:new(x, y)
end

-- @brief Sets the text color of the terminal. Limited functionality without an Advanced machines.
-- @param color:JLib.Enums.Color
function Screen:setTextColor(color) self._screen.setTextColor(color) end

-- @brief Returns the current text color of the terminal. Requires version 1.74 or newer.
-- @return JLib.Enums.Color
function Screen:getTextColor() return self._screen.getTextColor() end

-- @brief Sets the background color of the terminal. Limited functionality without an Advanced Computer / Turtle / Monitor.
-- @return JLib.Enums.Color
function Screen:setBackgroundColor(color) self._screen.setBackgroundColor(color) end

-- @brief Returns the current background color of the terminal. Requires version 1.74 or newer.
-- @return JLib.Enums.Color
function Screen:getBackgroundColor() return self._screen.getBackgroundColor() end

-- @brief Sets the text scale. Available only to monitor objects.
-- @param scale:num
function Screen:setTextScale(scale) self._screen.setTextScale(scale) end
