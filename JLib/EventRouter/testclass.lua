local class = require("Class.middleclass")

---@class EventRouter.testclass
local testclass = class("testclass")

---namespace JLib
JLib = JLib or {}
---namespace JLib.EventRouter
JLib.EventRouter = JLib.EventRouter or {}
JLib.EventRouter.testclass = testclass

---constructor
function testclass:initialize() self._a = "tteesstt" end

-- properties description
---@class EventRouter.testclass
---@field _a string
---@field new fun(self:EventRouter.testclass):EventRouter.testclass

---test runction
---@param a string
---@param b string
---@param c string
---@param d string
function testclass:test(a, b, c, d) print(a, b, c, d, self._a, "secc") end
