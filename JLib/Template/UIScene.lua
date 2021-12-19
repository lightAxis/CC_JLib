local class = require("Class.middleclass")

-- #includes
require("UI.Includes")

---@class JUI.Page_Name
local SCENE = class("Page_Name")

---constructor
---@param screen Screen
---@param UIRunner UIRunner
function SCENE:initialize(screen, UIRunner)
    self._screen = screen
    self._UIRunner = UIRunner

    -- example
    -- you must have root
    self._Root = JLib.ScreenCanvas:new(nil, screen, "screen_canvas_1")

    self._tb1 = JLib.TextBlock:new(self._Root, self._screen, "text_block_1")
    self._tb1:setText("hoho this is text block!")
    self._tb1.PosRel = JLib.Vector2:new(3, 4)
    self._tb1.Len = JLib.Vector2:new(10, 5)
    self.BG = JLib.Enums.Color.lightGray
    self.BG = JLib.Enums.Color.white
    self._tb1:setTextVerticalAlignment(JLib.Enums.VerticalAlignmentMode.center)
    self._tb1:setTextHorizontalAlignment(
        JLib.Enums.HorizontalAlignmentMode.center)
    self._tb1:setIsTextEditable(true)

end
