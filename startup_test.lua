require("CC_JLib.init")
require("EventThreadManager.Include")

rednet.open("back")

local manager = JLib.EventThreadManager.Manager:new()

local temp = function(x, y, z, k)
    local z_ = tonumber(z) * 100
    print(x, y, z_, k)
end
local mouseEM = JLib.EventThreadManager.EventMethod:new(
                    JLib.EventThreadManager.Events.mouse_click, temp)
local eventThread = JLib.EventThreadManager.EventThread:new(mouseEM)

local temp2 = function(x, y, z, k) print(x, y, z, k) end
local charEM = JLib.EventThreadManager.EventMethod:new(
                   JLib.EventThreadManager.Events.char, temp2)
local eventThread2 = JLib.EventThreadManager.EventThread:new(charEM)

manager:attach(eventThread)
manager:attach(eventThread2)

manager:run()
