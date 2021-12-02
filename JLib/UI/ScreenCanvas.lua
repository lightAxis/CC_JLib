local class = require("Class.middleclass")

-- #includes
require("UI.UIElement")

-- public class ScreenCanvas : UIElement
local ScreenCanvas = class("ScreenCanvas", JLib.UIElement)

-- namespace JLib
JLib = JLib or {}
JLib.ScreenCanvas = ScreenCanvas

-- constructor
function ScreenCanvas:initialize(parent, screen, name)
    JLib.UIElement.initialize(self, parent, screen, name)
end

-- functions
function ScreenCanvas:_updateLengthFromScreen() self.Len =
    self._screen:getSize() end

-- overrinding functions
function ScreenCanvas:render()

    -- update canvas length from attached screen
    self:_updateLengthFromScreen()

    -- global position is always 1
    self.Pos.x = 1
    self.Pos.y = 1

    -- render history add
    self:_addThisToRenderHistory()

    -- render children
    self:renderChildren()
end

function ScreenCanvas:_ClickEvent(e) end

function ScreenCanvas:_ScrollEvent(e) end

function ScreenCanvas:_KeyInputEvent(e) end