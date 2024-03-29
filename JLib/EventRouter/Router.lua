local class = require("Class.middleclass")

---public class EventRouter
---@class EventRouter.Router
local Router = class("EventRouter")

---namespace JLib
JLib = JLib or {}
---namespace JLib.EventRouter
JLib.EventRouter = JLib.EventRouter or {}
JLib.EventRouter.Router = Router

---constructor
function Router:initialize()
    self._eventCallbacks = {}
    self._rednetCallbacks = {}
end

---properties description
---@class EventRouter.Router
---@field _eventCallbacks table<EventRouter.Events, table<number, fun(a:string, b:string, c:string, d:string)>|nil>
---@field _rednetCallbacks table<string, table<number, fun(a:string, b:string, c:string, d:string)>|nil>
---@field new fun(self:EventRouter.Router):EventRouter.Router

---attack event callback method to router
---@param event EventRouter.Events
---@param mthd fun(a:string, b:string, c:string, d:string)
function Router:attachEventCallback(event, mthd)
    if (event == JLib.EventRouter.Events.rednet_message) then
        error(
            "rednet message cannot attached in attachEventCallback function. use attachRednetCallback method instead!")
    end

    self._eventCallbacks[event] = self._eventCallbacks[event] or {}

    for index, value in ipairs(self._eventCallbacks[event]) do
        if (value == mthd) then return end
    end

    table.insert(self._eventCallbacks[event], mthd)
end

---attach rednet event callback method to router
---@param protocol string
---@param mthd fun(a:string, b:string, c:string, d:string)
function Router:attachRednetCallback(protocol, mthd)
    self._rednetCallbacks[protocol] = self._rednetCallbacks[protocol] or {}

    for index, value in ipairs(self._rednetCallbacks[protocol]) do
        if (value == mthd) then return end
    end

    table.insert(self._rednetCallbacks[protocol], mthd)
end

---detach event callback
---@param event EventRouter.Events
---@param mthd fun(a:string, b:string, c:string, d:string)
function Router:detachEventCallback(event, mthd)
    if (self._eventCallbacks[event] == nil) then return end

    for index, value in ipairs(self._eventCallbacks[event]) do
        if (value == mthd) then
            table.remove(self._eventCallbacks[event], index)
            return
        end
    end
end

---remove all event handlers
---@param event EventRouter.Events
function Router:removeEventCallback(event) self._eventCallbacks[event] = {} end

---detach rednet event callback
---@param protocol string
---@param mthd fun(a:string, b:string, c:string, d:string)
function Router:detachRednetCallback(protocol, mthd)
    if (self._rednetCallbacks[protocol] == nil) then return end

    for index, value in ipairs(self._rednetCallbacks[protocol]) do
        if (value == mthd) then
            table.remove(self._rednetCallbacks[protocol], index)
            return
        end
    end
end

---remove all rednet callback at protocol
---@param protocol string
function Router:removeRednetEventCallBack(protocol)
    self._rednetCallbacks[protocol] = nil
end

---attach UIRunner to this Router
---@param UIrunner UIRunner
function Router:attachUIRunner(UIrunner)

    self:attachEventCallback(JLib.EventRouter.Events.mouse_click, function(a, b,
                                                                           c, d)
        UIrunner:MouseClickEventCallback(a, b, c, d)
    end)

    self:attachEventCallback(JLib.EventRouter.Events.mouse_scroll, function(a,
                                                                            b,
                                                                            c, d)
        UIrunner:ScrollEventCallback(a, b, c, d)
    end)

    self:attachEventCallback(JLib.EventRouter.Events.key, function(a, b, c, d)
        UIrunner:KeyInputEventCallback(a, b, c, d)
    end)

    self:attachEventCallback(JLib.EventRouter.Events.char, function(a, b, c, d)
        UIrunner:CharEventCallback(a, b, c, d)
    end)

    self:attachEventCallback(JLib.EventRouter.Events.monitor_touch, function(a,
                                                                             b,
                                                                             c,
                                                                             d)
        UIrunner:MonitorTouchEventCallback(a, b, c, d)
    end)

end

---run callback table
---@param functionTable table<number, fun(a:string, b:string, c:string, d:string)>|nil
---@param a string
---@param b string
---@param c string
---@param d string
function Router:_runCallbacks(functionTable, a, b, c, d)
    if (functionTable == nil) then return end

    for index, value in ipairs(functionTable) do value(a, b, c, d) end

end

---main function for Router to run
function Router:main()
    local a, b, c, d

    while true do
        a, b, c, d = os.pullEvent()
        -- print(a, b, c, d, "aaaa123123")
        if (a == JLib.EventRouter.Events.rednet_message) then
            self:_runCallbacks(self._rednetCallbacks[d], a, b, c, d)
        else
            self:_runCallbacks(self._eventCallbacks[a], a, b, c, d)
        end
    end
end
