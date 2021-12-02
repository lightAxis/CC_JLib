-- selection build
require("LibGlobal.LibVariables")

if (JLib.LibVariables.static.ENVIRONMENT ==
    JLib.LibVariables.static.eENVIRONMENT.Lua) then
    require("UI.Enums.Enums_Lua")

elseif (JLib.LibVariables.static.ENVIRONMENT ==
    JLib.LibVariables.static.eENVIRONMENT.CC) then
    require("UI.Enums.Enums_CC")
end

-- set default Enums
JLib.Enums.VerticalAlignmentMode = {
    ["top"] = "top",
    ["bottom"] = "bottom",
    ["center"] = "center"
}

JLib.Enums.HorizontalAlignmentMode = {
    ["left"] = "left",
    ["right"] = "right",
    ["center"] = "center"
}

JLib.Enums.Side = {
    ["front"] = "front",
    ["back"] = "back",
    ["left"] = "left",
    ["right"] = "right",
    ["top"] = "top",
    ["bottom"] = "bottom"
}

JLib.Enums.MouseButton = {["left"] = 1, ["right"] = 2, ["center"] = 3}

