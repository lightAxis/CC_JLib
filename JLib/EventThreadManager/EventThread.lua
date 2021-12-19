local class = require("Class.middleclass")

---@class EventThreadManager
local EventThread = class("EventThreadManager.EventThread")

---namespace JLib
JLib = JLib or {}
---namespace JLib.EventThreadManager
JLib.EventThreadManager = JLib.EventThreadManager or {}
JLib.EventThreadManager.EventThread = EventThread

function EventThread:initialize(method)
    self.Thread = coroutine()
    _, self.Filter = coroutine.resume(self.Thread)
end

---properties description 
---@class 
