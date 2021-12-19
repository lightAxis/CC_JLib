local class = require("Class.middleclass")

---@class EventThreadManager.EventThread
local EventThread = class("EventThreadManager.EventThread")

---namespace JLib
JLib = JLib or {}
---namespace JLib.EventThreadManager
JLib.EventThreadManager = JLib.EventThreadManager or {}
JLib.EventThreadManager.EventThread = EventThread

---constructor
---@param eventMethod EventThreadManager.EventMethod
function EventThread:initialize(eventMethod)
    self.Thread = coroutine.create(function() eventMethod:main() end)
    self.Ok, self.Filter = coroutine.resume(self.Thread)

    self.rednetFilter = ""
    if (self.Filter == JLib.EventThreadManager.Events.rednet_message) then
        self.rednetFilter = eventMethod.rednetProtocol
    end
end

---resume with arg table
---@param args table<number, string>
---@return boolean, string
function EventThread:resume(args)
    if (args ~= nil) then
        return coroutine.resume(self.Thread, unpack(args))
    else
        return coroutine.resume(self.Thread)
    end
end

---get Thread state of this event thread
function EventThread:getThreadState() return coroutine.status(self.Thread) end

---properties description 
---@class EventThreadManager.EventThread
---@field Thread thread
---@field Filter string
---@field rednetFilter string
---@field new fun(self:EventThreadManager.EventThread ,eventMethod: EventThreadManager.EventMethod):EventThreadManager.EventThread
