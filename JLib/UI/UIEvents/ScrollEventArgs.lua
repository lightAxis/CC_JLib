local class = require("Class.middleclass")

-- #includes
require("UI.UIEvents.EventArgs")

-- public class ScrollEventArgs : JLib.UIEvent.EventArgs  
---  
---**require** : 
--- - Class.middleclass
--- - UI.UIEvent
---@class ScrollEventArgs : EventArgs
local ScrollEventArgs = class("ScrollEventArgs", JLib.UIEvent.EventArgs)

-- namespace JLib
JLib = JLib or {}
-- namespace JLib.UIEvent
JLib.UIEvent = JLib.UIEvent or {}
JLib.UIEvent.ScrollEventArgs = ScrollEventArgs

-- constructor
---@param direction Enums.ScrollDirection
---@param pos Vector2
function ScrollEventArgs:initialize(direction, pos)
    JLib.UIEvent.EventArgs.initialize(self)
    self.Direction = direction
    self.Pos = pos:Copy()
end

-- properties description
---@class ScrollEventArgs
---@field Direction Enums.ScrollDirection
---@field Pos Vector2
---@field new fun(direction: Enums.ScrollDirection, pos: Vector2): ScrollEventArgs