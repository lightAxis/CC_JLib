---namespace testProj
require("UI.Includes")
require("EventRouter.Includes")
-- require("testProj.Scens.Includes")

---@class testProj
local testProj = {}

testProj.EventRouter = JLib.EventRouter.Router:new()
testProj.UIRunner = JLib.UIRunner:new()

testProj.EventRouter:attachUIRunner(testProj.UIRunner)

local screen = JLib.Screen:new(term, JLib.Enums.Side.NONE)
local scene1 = require("testProj.Scens.scene1")
testProj.scene1 = scene1:new(screen, testProj)

testProj.UIRunner:attachScene(testProj.scene1)

testProj.UIRunner:setIntialScene(JLib.Enums.Side.NONE)
testProj.UIRunner:RenderScreen()

testProj.EventRouter:main()
