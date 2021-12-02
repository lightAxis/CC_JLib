local class = require("Class.middleclass")

-- public class Enum_CC
local Enums_CC = class("Enums")

-- namespace JLib
JLib = JLib or {}
JLib.Enums = Enums_CC

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

-- constructor 
function Enums_CC:initialize() end