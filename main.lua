dofile("JLib/ScreenText/ScreenText.lua")


local st = ScreenText(peripheral.wrap("top"));

st:Clear()

st:SetTextScale(2)
st:SetHorizontalAlignMode("Center")
st:SetVerticalAlignMode("Center")

st:AddTextLine("Rotten Water Trash!",colors.cyan)
st:AddTextLine("", colors.black)
st:AddTextLine("Kimoi", colors.red)

st:DrawTextLines()
