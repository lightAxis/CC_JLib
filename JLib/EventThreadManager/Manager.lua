local class = require("Class.middleclass")

---@class EventThreadManager.Manager
local Manager = class("EventThreadManager.Manager")

---namespace JLib
JLib = JLib or {}
---namespace JLib.EventThreadManager
JLib.EventThreadManager = JLib.EventThreadManager or {}
JLib.EventThreadManager.Manager = Manager

---constructor
function Manager:initialize()
    self.Threads = {}
    self.rednetThreads = {}
end

---properties description
---@class EventThreadManager.Manager
---@field Threads table<number, EventThreadManager.EventThread>
---@field rednetThreads table<number, EventThreadManager.EventThread>
---@field new fun(self:EventThreadManager.Manager):EventThreadManager.Manager

function Manager:reserveStop() os.queueEvent("stop") end

---attach eventThread to Manager
---@param eventThread EventThreadManager.EventThread
function Manager:attach(eventThread)

    -- if not exist, add eventthread to Threads
    if (eventThread.Filter == JLib.EventThreadManager.Events.rednet_message) then
        self.rednetThreads[eventThread.rednetFilter] = eventThread
    else
        self.Threads[eventThread.Filter] = eventThread
    end
end

function Manager:run()
    local EventTable = {}
    local ok, filter
    while true do

        EventTable = {os.pullEvent()}

        if (EventTable[1] == "stop") then break end

        if (EventTable[1] == JLib.EventThreadManager.Events.rednet_message) then
            if (self.rednetThreads[EventTable[4]] ~= nil) then
                ok, filter =
                    self.rednetThreads[EventTable[4]]:resume(EventTable)
                if (ok == nil) then
                    self.rednetThreads[EventTable[4]] = nil
                end
            end

        else
            if (self.Threads[EventTable[1]] ~= nil) then
                ok, filter = self.Threads[EventTable[1]]:resume(EventTable)
                if (ok == nil) then
                    self.Threads[EventTable[1]] = nil
                end
            end
        end

    end
end
