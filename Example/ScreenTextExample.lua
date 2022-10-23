require("CC_JLib.init")
require("UI.Includes")
require("ScreenText.ScreenText")

local sc = JLib.Screen:new(peripheral.wrap("back"), "back")
local st = JLib.ScreenText:new(sc)

st:Clear()
st:SetHorizontalAlignMode("Center")
st:SetVerticalAlignMode("Center")
st:SetTextScale(4)

st:AddTextLine("KRW Bank", colors.cyan)

st:DrawTextLines()