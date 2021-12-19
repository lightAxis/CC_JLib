local class = require("Class.middleclass")

---@class EventThreadManager.EventMethod
local EventMethod = class("EventThreadManager.EventMethod")

---namespace JLib
JLib = JLib or {}
---namespace JLib.EventThreadManager
JLib.EventThreadManager = JLib.EventThreadManager or {}
JLib.EventThreadManager.EventMethod = EventMethod

---constructor
---@param eventToListen EventThreadManager.Events
---@param method fun(event:string, button:string, a:string, b:string)
---@param rednetProtocol? string
function EventMethod:initialize(eventToListen, method, rednetProtocol)
    self.eventToListen = eventToListen
    self.method = method
    self.rednetProtocol = rednetProtocol or ""
end

---properties description
---@class EventThreadManager.EventMethod
---@field eventToListen EventThreadManager.Events
---@field method fun(event:string, button:string, a:string, b:string)

function EventMethod:main()
    local event, button, a, b
    while true do
        event, button, a, b = os.pullEvent(self.eventToListen)
        self.method(event, button, a, b)
    end
end
