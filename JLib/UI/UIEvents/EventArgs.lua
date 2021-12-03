local class = require("Class.middleclass")

---public class EventArgs  
---  
---**require** :  
--- - Class.middleclass
---@class EventArgs
local EventArgs = class("EventArgs")

-- namespace JLib
JLib = JLib or {}
-- namespace JLib.UIEvent
JLib.UIEvent = JLib.UIEvent or {}
JLib.UIEvent.EventArgs = EventArgs

---constructor
function EventArgs:initialize() self.Handled = false end

-- properties description
---@class EventArgs
---@field Handled boolean
---@field new fun(): EventArgs
