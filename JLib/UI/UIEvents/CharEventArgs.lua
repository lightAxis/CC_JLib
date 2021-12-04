local class = require("Class.middleclass")

-- #includes
require("UI.UIEvents.EventArgs")

--- public class CharEventArgs : EventArgs
---  
---**require**  
--- - Class.middleclass
--- - UI.UIEvents.EventArgs
---@class CharEventArgs : EventArgs
local CharEventArgs = class("CharEventArgs", JLib.UIEvent.EventArgs)

--- namespace JLib
JLib = JLib or {}
--- namespace JLib.UIEvent
JLib.UIEvent = JLib.UIEvent or {}
JLib.UIEvent.CharEventArgs = CharEventArgs

-- consturctor
---@param char string
function CharEventArgs:initialize(char)
    JLib.UIEvent.EventArgs.initialize(self)
    self.Char = char
end

-- properties description
---@class CharEventArgs
---@field Char string 
---@field new fun(char: string): CharEventArgs

