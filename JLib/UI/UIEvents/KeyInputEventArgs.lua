local class = require("Class.middleclass")

-- #includes
require("UI.UIEvents.EventArgs")

-- public class KeyInputEventArgs : EventArgs   
---  
---**require** :  
--- - Class.middleclass
--- - UI.UIEvents.EventArgs
---@class KeyInputEventArgs : EventArgs
local KeyInputEventArgs = class("KeyInputEventArgs", JLib.UIEvent.EventArgs)

-- namespace JLib
JLib = JLib or {}
-- namespace JLib.UIEvent
JLib.UIEvent = JLib.UIEvent or {}
JLib.UIEvent.KeyInputEventArgs = KeyInputEventArgs

-- constructor
---@param key any --TODO:set key enum
---@param isShiftPressed boolean
function KeyInputEventArgs:initialize(key, isShiftPressed)
    JLib.UIEvent.EventArgs.initialize(self)
    self.Key = key
    self.IsShiftPressed = isShiftPressed
end

-- properties description
---@class KeyInputEventArgs
---@field Key any
---@field IsShiftPressed boolean
---@field new fun(self:KeyInputEventArgs, key:any, isShiftPressed: boolean): KeyInputEventArgs