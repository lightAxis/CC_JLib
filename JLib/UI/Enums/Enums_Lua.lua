local class = require("Class.middleclass")

-- public class Enums_Lua
local Enums_Lua = class("Enums")

-- namespace JLib
JLib = JLib or {}
JLib.Enums = Enums_Lua

-- set default Enums
Enums_Lua.VerticalAlignmentMode = {
    ["top"] = "top",
    ["bottom"] = "bottom",
    ["center"] = "center"
}
Enums_Lua.HorizontalAlignmentMode = {
    ["left"] = "left",
    ["right"] = "right",
    ["center"] = "center"
}
Enums_Lua.Colors = {
    ["white"] = "white",
    ["orange"] = "oranage",
    ["magenta"] = "magenta",
    ["lightBlue"] = "lightBlue",
    ["yellow"] = "yellow",
    ["lime"] = "lime",
    ["pink"] = "pink",
    ["gray"] = "gray",
    ["lightGray"] = "lightGray",
    ["cyan"] = "cyan",
    ["purple"] = "purple",
    ["blue"] = "blue",
    ["brown"] = "brown",
    ["green"] = "green",
    ["red"] = "red",
    ["black"] = "black"
}
Enums_Lua.Side = {
    ["front"] = "front",
    ["back"] = "back",
    ["left"] = "left",
    ["right"] = "right",
    ["top"] = "top",
    ["bottom"] = "bottom"
}

-- constructor
function Enums_Lua:initialize() end