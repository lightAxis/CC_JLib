local class = require("Class.middleclass")

-- public class Enums_Lua
local Enums_Lua = class("Enums")

-- namespace JLib
JLib = JLib or {}
JLib.Enums = Enums_Lua

-- set default Enums
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

-- constructor
function Enums_Lua:initialize() end
