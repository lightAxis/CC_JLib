--- includes basic components
require("UI.Includes")
require("EventRouter.Includes")

--- make project global namespace
---@class KioskProj
KioskProj = {}

--- initialize EventRouter
--- this routes to UI Event and rednet event to other functions
KioskProj.EventRouter = JLib.EventRouter.Router:new()

--- initialize UIRunner
--- this runs Scene UI intercation system from EventRouter
KioskProj.UIRunner = JLib.UIRunner:new()
--- attach UIRunner to EventRouter
KioskProj.EventRouter:attachUIRunner(KioskProj.UIRunner)

--- initialize Screen objects to use,
--- can terminal or monitor
--- side must exist. NONE is terminal
local screen_term = JLib.Screen:new(peripheral.wrap("right"),
                                    JLib.Enums.Side.right)

------------ Param -------------

require("param")

------------ SCENENS -----------

--- register Project SceneFile to other 
local MainScene = require("Scenes.mainScene")

--- register Project Scene Instance to Project global namespace
KioskProj.MainScene = MainScene:new(screen_term, KioskProj)

--- register each screen sides initialize Scene
KioskProj.UIRunner:attachScene(KioskProj.MainScene)

--- set initial scene to start interact
KioskProj.UIRunner:setIntialScene(JLib.Enums.Side.right)

-----------------------------------

--- clear and readner initial scenes
KioskProj.UIRunner:ClearScreens()
KioskProj.UIRunner:RenderScreen()

--- run main EventLoop to start Proj
KioskProj.EventRouter:main()
