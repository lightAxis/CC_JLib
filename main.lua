--- includes basic components
require("init")
require("ProjTemplate.init")
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
local SCENENAME3 = require("Scenes.SCENENAME3")
local SCENENAME1_L = require("Scenes.SCENENAME1_L")
local SCENENAME2_L = require("Scenes.SCENENAME2_L")
local SCENENAME3_L = require("Scenes.SCENENAME3_L")

--- register Project Scene Instance to Project global namespace
ProjTemplate.SCENENAME1_L = SCENENAME1_L:new(screen_term, ProjTemplate)
ProjTemplate.SCENENAME2_L = SCENENAME2_L:new(screen_term, ProjTemplate)
ProjTemplate.SCENENAME3_L = SCENENAME3_L:new(screen_term, ProjTemplate)
ProjTemplate.SCENENAME1 = SCENENAME1:new(screen_term, ProjTemplate, ProjTemplate.SCENENAME1_L)
ProjTemplate.SCENENAME2 = SCENENAME2:new(screen_term, ProjTemplate, ProjTemplate.SCENENAME2_L)
ProjTemplate.SCENENAME3 = SCENENAME3:new(screen_term, ProjTemplate, ProjTemplate.SCENENAME3_L)

ProjTemplate.SCENENAME1_t_L = SCENENAME1_L:new(screen_term, ProjTemplate)
ProjTemplate.SCENENAME2_t_L = SCENENAME2_L:new(screen_term, ProjTemplate)
ProjTemplate.SCENENAME3_t_L = SCENENAME3_L:new(screen_term, ProjTemplate)
ProjTemplate.SCENENAME1_t = SCENENAME1:new(screen_left, ProjTemplate, ProjTemplate.SCENENAME1_t_L)
ProjTemplate.SCENENAME2_t = SCENENAME2:new(screen_left, ProjTemplate, ProjTemplate.SCENENAME2_t_L)
ProjTemplate.SCENENAME3_t = SCENENAME3:new(screen_left, ProjTemplate, ProjTemplate.SCENENAME3_t_L)

--- register each screen sides initialize Scene
ProjTemplate.UIRunner:attachScene(ProjTemplate.SCENENAME1)
ProjTemplate.UIRunner:attachScene(ProjTemplate.SCENENAME1_t)

--- set initial scene to start interact
ProjTemplate.UIRunner:setIntialScene(JLib.Enums.Side.NONE)

-----------------------------------

--- clear and readner initial scenes
ProjTemplate.UIRunner:ClearScreens()
ProjTemplate.UIRunner:RenderScreen()
ProjTemplate.UIRunner:Reflect2Screen()

--- run main EventLoop to start Proj
ProjTemplate.EventRouter:main()
