require("CC_JLib.init")
require("EventRouter.Includes")

rednet.open("left")

local rou = JLib.EventRouter.Router:new()

local aa = function(a, b, c, d) print(a, b, c, d, "aa") end

local bb = function(a, b, c, d) print(a, b, c, d, "bb") end

local cc = function(a, b, c, d) print(a, b, c, d, "cc") end

local testtest = JLib.EventRouter.testclass:new()

local a = function(a, b, c, d) testtest:test(a, b, c, d) end

rou:attachEventCallback(JLib.EventRouter.Events.mouse_up, aa)
rou:attachEventCallback(JLib.EventRouter.Events.mouse_drag, bb)
rou:attachRednetCallback("test", cc)
rou:attachEventCallback(JLib.EventRouter.Events.key, a)

rou:detachEventCallback(JLib.EventRouter.Events.mouse_up, aa)
rou:detachRednetCallback("test", cc)
rou:detachEventCallback(JLib.EventRouter.Events.key, a)

rou:main();
