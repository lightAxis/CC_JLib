local class = require("Class.middleclass")

-- namespace JLib.UIEvent
JLib = JLib or {}
JLib.UIEvent = JLib.UIEvent or {}

-- public class EventArgs
local EventArgs = class("EventArgs")
-- namespace JLib.UIEvent
JLib.UIEvent.EventArgs = EventArgs
-- constructor
function EventArgs:initialize() self.Handled = false end

-- public class ClickEventArgs : JLib.UIEvent.EventArgs
local ClickEventArgs = class("ClickEventArgs", JLib.UIEvent.EventArgs)
-- namespace JLib.UIEvent
JLib.UIEvent.ClickEventArgs = ClickEventArgs
-- constructor
function ClickEventArgs:initialize(button, pos)
    self.Button = button
    self.Pos = pos:Copy()
end

-- public class ScrollEventArgs : JLib.UIEvent.EventArgs
local ScrollEventArgs = class("ScrollEventArgs", JLib.UIEvent.EventArgs)
-- namespace JLib.UIEvent
JLib.UIEvent.ScrollEventArgs = ScrollEventArgs
-- constructor
function ScrollEventArgs:initialize(direction, pos)
    self.Direction = direction
    self.Pos = pos:Copy()
end

-- public class KeyInputEventArgs : JLib.UIEvent.EventArgs
local KeyInputEventArgs = class("KeyInputEventArgs", JLib.UIEvent.EventArgs)
-- namespace JLib.UIEvent
JLib.UIEvent.KeyInputEventArgs = KeyInputEventArgs
-- constructor
function KeyInputEventArgs:initialize(key) self.Key = key end
