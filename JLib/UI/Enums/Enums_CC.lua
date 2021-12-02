local class = require("Class.middleclass")

-- public class Enum_CC
local Enums_CC = class("Enums")

-- namespace JLib
JLib = JLib or {}
JLib.Enums = Enums_CC

-- set default Enums
Enums_CC.VerticalAlignmentMode = {
    ["top"] = "top",
    ["bottom"] = "bottom",
    ["center"] = "center"
}

Enums_CC.HorizontalAlignmentMode = {
    ["left"] = "left",
    ["right"] = "right",
    ["center"] = "center"
}

Enums_CC.Colors = {
    ["white"] = colors.white,
    ["orange"] = colors.oranage,
    ["magenta"] = colors.magenta,
    ["lightBlue"] = colors.lightBlue,
    ["yellow"] = colors.yellow,
    ["lime"] = colors.lime,
    ["pink"] = colors.pink,
    ["gray"] = colors.gray,
    ["lightGray"] = colors.lightGray,
    ["cyan"] = colors.cyan,
    ["purple"] = colors.purple,
    ["blue"] = colors.blue,
    ["brown"] = colors.brown,
    ["green"] = colors.green,
    ["red"] = colors.red,
    ["black"] = colors.black
}

Enums_CC.Side = {
    ["front"] = "front",
    ["back"] = "back",
    ["left"] = "left",
    ["right"] = "right",
    ["top"] = "top",
    ["bottom"] = "bottom"
}

Enums_CC.MouseButton = {["left"] = 1, ["right"] = 2, ["center"] = 3}

-- constructor 
function Enums_CC:initialize() end
