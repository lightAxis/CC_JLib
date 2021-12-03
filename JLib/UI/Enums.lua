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

-- enum used in vertical alignmentmode
---@class Enums.VerticalAlignmentMode
JLib.Enums.VerticalAlignmentMode = {
    ["top"] = "top",
    ["bottom"] = "bottom",
    ["center"] = "center"
}

---@class Enums.HorizontalAlignmentMode
JLib.Enums.HorizontalAlignmentMode = {
    ["left"] = "left",
    ["right"] = "right",
    ["center"] = "center"
}

---@class Enums.Side
JLib.Enums.Side = {
    ["front"] = "front",
    ["back"] = "back",
    ["left"] = "left",
    ["right"] = "right",
    ["top"] = "top",
    ["bottom"] = "bottom"
}

---@class Enums.MouseButton
JLib.Enums.MouseButton = {["left"] = 1, ["right"] = 2, ["center"] = 3}

---@class Enums.ScrollDirection
JLib.Enums.ScrollDirection = {["up"] = -1, ["down"] = 1}
