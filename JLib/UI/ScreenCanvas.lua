local class = require("Class.middleclass")

-- #includes
require("UI.UIElement")

-- public class ScreenCanvas : UIElement
---  
---**require** :  
--- - Class.middleclass
--- - UI.UIElement
---@class ScreenCanvas : UIElement
local ScreenCanvas = class("ScreenCanvas", JLib.UIElement)

-- namespace JLib
JLib = JLib or {}
JLib.ScreenCanvas = ScreenCanvas

-- [constructor]
---@param parent UIElement
---@param screen Screen
---@param name string
function ScreenCanvas:initialize(parent, screen, name)
    JLib.UIElement.initialize(self, parent, screen, name)
end

-- properties description
---@class ScreenCanvas
---@field new fun(parentL: UIElement, screen: Screen, name: string): ScreenCanvas

-- functions

-- get length from screen and reset Len of current
function ScreenCanvas:_updateLengthFromScreen() self.Len =
    self._screen:getSize() end

-- [overrinding functions]

---overrided function from UIElement:render()
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

---overrided function from UIElement:_ClickEvent
---@param e ClickEventArgs
function ScreenCanvas:_ClickEvent(e) end

---overrided function from UIElement:_ScrollEvent
---@param e ScrollEventArgs
function ScreenCanvas:_ScrollEvent(e) end

---overrided function from UIElement:_KeyInputEvent
---@param e KeyInputEventArgs
function ScreenCanvas:_KeyInputEvent(e) end

---overrided function from UIElement:_CharEvent
---@param e CharEventArgs
function ScreenCanvas:_CharEvent(e) end

---overrided function from UIElement:PostRendering()
function ScreenCanvas:PostRendering() end

---overrided function from UIElement:FocusIn()
function ScreenCanvas:FocusIn() end

---overrided function from UIElement:FocusOut()
function ScreenCanvas:FocusOut() end
