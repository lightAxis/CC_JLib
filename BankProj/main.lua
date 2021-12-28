--- includes basic components
require("UI.Includes")
require("EventRouter.Includes")

--- make project global namespace
---@class BankProj
BankProj = {}

--- initialize EventRouter
--- this routes to UI Event and rednet event to other functions
BankProj.EventRouter = JLib.EventRouter.Router:new()

--- initialize UIRunner
--- this runs Scene UI intercation system from EventRouter
BankProj.UIRunner = JLib.UIRunner:new()
--- attach UIRunner to EventRouter
BankProj.EventRouter:attachUIRunner(BankProj.UIRunner)

--- initialize Screen objects to use,
--- can terminal or monitor
--- side must exist. NONE is terminal
local screen_term = JLib.Screen:new(peripheral.wrap("left"), JLib.Enums.Side.left)

------------ Param -------------

require("param")

------------ SCENENS -----------

--- register Project SceneFile to other 
local MainScene = require("Scenes.mainScene")
local LoginScene = require("Scenes.loginScene")

--- register Project Scene Instance to Project global namespace
BankProj.MainScene = MainScene:new(screen_term, BankProj)
BankProj.LoginScene = LoginScene:new(screen_term, BankProj)

--- register each screen sides initialize Scene
BankProj.UIRunner:attachScene(BankProj.MainScene)

--- set initial scene to start interact
BankProj.UIRunner:setIntialScene(JLib.Enums.Side.left)

-----------------------------------

--- clear and readner initial scenes
BankProj.UIRunner:ClearScreens()
BankProj.UIRunner:RenderScreen()

--- run main EventLoop to start Proj
BankProj.EventRouter:main()
