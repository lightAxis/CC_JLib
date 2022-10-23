--- includes basic components
require("UI.Includes")
require("EventRouter.Includes")

--- make project global namespace
---@class ProjTemplate
local ProjTemplate = {}

--- initialize EventRouter
--- this routes to UI Event and rednet event to other functions
ProjTemplate.EventRouter = JLib.EventRouter.Router:new()

--- initialize UIRunner
--- this runs Scene UI intercation system from EventRouter
ProjTemplate.UIRunner = JLib.UIRunner:new()
--- attach UIRunner to EventRouter
ProjTemplate.EventRouter:attachUIRunner(ProjTemplate.UIRunner)

--- initialize Screen objects to use,
--- can terminal or monitor
--- side must exist. NONE is terminal
local screen_term = JLib.Screen:new(term, JLib.Enums.Side.NONE)
local screen_left = JLib.Screen:new(peripheral.wrap("left"),
                                    JLib.Enums.Side.left)

------------ SCENENS -----------

--- register Project SceneFile to other 
local SCENENAME1 = require("Scenes.SCENENAME1")
local SCENENAME2 = require("Scenes.SCENENAME2")

--- register Project Scene Instance to Project global namespace
ProjTemplate.SCENENAME1 = SCENENAME1:new(screen_term, ProjTemplate)
ProjTemplate.SCENENAME2 = SCENENAME2:new(screen_term, ProjTemplate)
ProjTemplate.SCENENAME1_t = SCENENAME1:new(screen_left, ProjTemplate)
ProjTemplate.SCENENAME2_t = SCENENAME2:new(screen_left, ProjTemplate)

--- register each screen sides initialize Scene
ProjTemplate.UIRunner:attachScene(ProjTemplate.SCENENAME1)
ProjTemplate.UIRunner:attachScene(ProjTemplate.SCENENAME1_t)

--- set initial scene to start interact
ProjTemplate.UIRunner:setIntialScene(JLib.Enums.Side.NONE)

-----------------------------------

--- clear and readner initial scenes
ProjTemplate.UIRunner:ClearScreens()
ProjTemplate.UIRunner:RenderScreen()

--- run main EventLoop to start Proj
ProjTemplate.EventRouter:main()
