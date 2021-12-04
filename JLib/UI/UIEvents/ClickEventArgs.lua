local class = require("Class.middleclass")

-- #includes
require("UI.UIEvents.EventArgs")

-- public class ClickEventArgs : EventArgs  
---  
---**require**  
--- - Class.middleclass
--- - UI.UIEvents.EventArgs
---@class ClickEventArgs : EventArgs
local ClickEventArgs = class("ClickEventArgs", JLib.UIEvent.EventArgs)

-- namespace JLib
JLib = JLib or {}
-- namespace JLib.UIEvent
JLib.UIEvent = JLib.UIEvent or {}
JLib.UIEvent.ClickEventArgs = ClickEventArgs

-- constructor
---@param button Enums.MouseButton
---@param pos Vector2
function ClickEventArgs:initialize(button, pos)
    JLib.UIEvent.EventArgs.initialize(self)
    self.Button = button
    self.Pos = pos:Copy()
end

-- properties description
---@class ClickEventArgs
---@field Button Enums.MouseButton
---@field Pos Vector2
---@field new fun(button: Enums.MouseButton, pos: Vector2): ClickEventArgs