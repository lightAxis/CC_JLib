-- -- selection build
-- require("LibGlobal.LibVariables")

-- if (JLib.LibVariables.static.ENVIRONMENT ==
--     JLib.LibVariables.static.eENVIRONMENT.Lua) then
--     require("UI.Enums.Enums_Lua")

-- elseif (JLib.LibVariables.static.ENVIRONMENT ==
--     JLib.LibVariables.static.eENVIRONMENT.CC) then
--     require("UI.Enums.Enums_CC")
-- end

-- set default Enums

local class = require("Class.middleclass")


-- namespace JLib
JLib = JLib or {}
-- namespace Enums
JLib.Enums = JLib.Enums or {}

-- enum used in vertical alignmentmode
---@enum Enums.VerticalAlignmentMode
JLib.Enums.VerticalAlignmentMode = {
    ["top"] = "top",
    ["bottom"] = "bottom",
    ["center"] = "center"
}

---@enum Enums.HorizontalAlignmentMode
JLib.Enums.HorizontalAlignmentMode = {
    ["left"] = "left",
    ["right"] = "right",
    ["center"] = "center"
}

---@enum Enums.Side
JLib.Enums.Side = {
    ["front"] = "front",
    ["back"] = "back",
    ["left"] = "left",
    ["right"] = "right",
    ["top"] = "top",
    ["bottom"] = "bottom",
    ["NONE"] = "NONE"
}

---@enum Enums.MouseButton
JLib.Enums.MouseButton = {
    ["left"] = 1,
    ["right"] = 2,
    ["center"] = 3
}

---@enum Enums.ScrollDirection
JLib.Enums.ScrollDirection = {
    ["up"] = -1,
    ["down"] = 1
}

---@enum Enums.Direction
JLib.Enums.Direction = {
    ["vertical"] = "vertical",
    ["horizontal"] = "horizontal"
}

---@enum Enums.Key
JLib.Enums.Key = {
    ["a"] = 30,
    ["c"] = 46,
    ["b"] = 48,
    ["e"] = 18,
    ["pageUp"] = 201,
    ["g"] = 34,
    ["f"] = 33,
    ["i"] = 23,
    ["h"] = 35,
    ["k"] = 37,
    ["underscore"] = 147,
    ["space"] = 57,
    ["l"] = 38,
    ["o"] = 24,
    ["cimcumflex"] = 144,
    ["q"] = 16,
    ["f1"] = 59,
    ["s"] = 31,
    ["insert"] = 210,
    ["f5"] = 63,
    ["seven"] = 8,
    ["eight"] = 9,
    ["numPadEnter"] = 156,
    ["y"] = 21,
    ["x"] = 45,
    ["numPad6"] = 77,
    ["z"] = 44,
    ["backslash"] = 43,
    ["rightBracket"] = 27,
    ["f9"] = 67,
    ["yen"] = 125,
    ["left"] = 203,
    ["numPadSubtract"] = 74,
    ["noconvert"] = 123,
    ["f4"] = 62,
    ["return"] = 28,
    ["leftCtrl"] = 29,
    ["rightCtrl"] = 157,
    ["numPad2"] = 80,
    ["grave"] = 41,
    ["delete"] = 211,
    ["four"] = 5,
    ["rightAlt"] = 184,
    ["leftAlt"] = 56,
    ["numPad7"] = 71,
    ["numLock"] = 69,
    ["home"] = 199,
    ["numPad0"] = 82,
    ["enter"] = 28,
    ["slash"] = 53,
    ["numPadEquals"] = 141,
    ["six"] = 7,
    ["down"] = 208,
    ["n"] = 49,
    ["f11"] = 87,
    ["t"] = 20,
    ["u"] = 22,
    ["rightShift"] = 54,
    ["zero"] = 11,
    ["p"] = 25,
    ["pageDown"] = 209,
    ["nine"] = 10,
    ["multiply"] = 55,
    ["capsLock"] = 58,
    ["minus"] = 12,
    ["leftBracket"] = 26,
    ["m"] = 50,
    ["scollLock"] = 70,
    ["v"] = 47,
    ["f14"] = 101,
    ["one"] = 2,
    ["circumflex"] = 144,
    ["d"] = 32,
    ["up"] = 200,
    ["equals"] = 13,
    ["numPad8"] = 72,
    ["f7"] = 65,
    ["apostrophe"] = 40,
    ["f10"] = 68,
    ["f13"] = 100,
    ["stop"] = 149,
    ["scrollLock"] = 70,
    ["comma"] = 51,
    ["numPad3"] = 81,
    ["numPad9"] = 73,
    ["numPad4"] = 75,
    ["tab"] = 15,
    ["f3"] = 61,
    ["numPadAdd"] = 78,
    ["kana"] = 112,
    ["numPad1"] = 79,
    ["right"] = 205,
    ["numPadDecimal"] = 83,
    ["f15"] = 102,
    ["leftShift"] = 42,
    ["backspace"] = 14,
    ["convert"] = 121,
    ["end"] = 207,
    ["three"] = 4,
    ["kanji"] = 148,
    ["colon"] = 146,
    ["two"] = 3,
    ["semiColon"] = 39,
    ["w"] = 17,
    ["f2"] = 60,
    ["period"] = 52,
    ["j"] = 36,
    ["ax"] = 150,
    ["r"] = 19,
    ["f6"] = 64,
    ["at"] = 145,
    ["numPadDivide"] = 181,
    ["numPad5"] = 76,
    ["f12"] = 88,
    ["pause"] = 197,
    ["f8"] = 66,
    ["five"] = 6,
    ["numPadComma"] = 179,

}

---@enum Enums.KeyReverse
JLib.Enums.KeyReverse = {
    [30] = "a",
    [46] = "c",
    [48] = "b",
    [18] = "e",
    [201] = "pageUp",
    [34] = "g",
    [33] = "f",
    [23] = "i",
    [35] = "h",
    [37] = "k",
    [147] = "underscore",
    [57] = "space",
    [38] = "l",
    [24] = "o",
    [16] = "q",
    [59] = "f1",
    [31] = "s",
    [210] = "insert",
    [63] = "f5",
    [8] = "seven",
    [9] = "eight",
    [156] = "numPadEnter",
    [21] = "y",
    [45] = "x",
    [77] = "numPad6",
    [44] = "z",
    [43] = "backslash",
    [27] = "rightBracket",
    [67] = "f9",
    [125] = "yen",
    [203] = "left",
    [74] = "numPadSubtract",
    [123] = "noconvert",
    [62] = "f4",
    [29] = "leftCtrl",
    [157] = "rightCtrl",
    [80] = "numPad2",
    [41] = "grave",
    [211] = "delete",
    [5] = "four",
    [184] = "rightAlt",
    [56] = "leftAlt",
    [71] = "numPad7",
    [69] = "numLock",
    [199] = "home",
    [82] = "numPad0",
    [28] = "enter",
    [53] = "slash",
    [141] = "numPadEquals",
    [7] = "six",
    [208] = "down",
    [49] = "n",
    [87] = "f11",
    [20] = "t",
    [22] = "u",
    [54] = "rightShift",
    [11] = "zero",
    [25] = "p",
    [209] = "pageDown",
    [10] = "nine",
    [55] = "multiply",
    [58] = "capsLock",
    [12] = "minus",
    [26] = "leftBracket",
    [50] = "m",
    [47] = "v",
    [101] = "f14",
    [2] = "one",
    [144] = "circumflex",
    [32] = "d",
    [200] = "up",
    [13] = "equals",
    [72] = "numPad8",
    [65] = "f7",
    [40] = "apostrophe",
    [68] = "f10",
    [100] = "f13",
    [149] = "stop",
    [70] = "scrollLock",
    [51] = "comma",
    [81] = "numPad3",
    [73] = "numPad9",
    [75] = "numPad4",
    [15] = "tab",
    [61] = "f3",
    [78] = "numPadAdd",
    [112] = "kana",
    [79] = "numPad1",
    [205] = "right",
    [83] = "numPadDecimal",
    [102] = "f15",
    [42] = "leftShift",
    [14] = "backspace",
    [121] = "convert",
    [207] = "end",
    [4] = "three",
    [148] = "kanji",
    [146] = "colon",
    [3] = "two",
    [39] = "semiColon",
    [17] = "w",
    [60] = "f2",
    [52] = "period",
    [36] = "j",
    [150] = "ax",
    [19] = "r",
    [64] = "f6",
    [145] = "at",
    [181] = "numPadDivide",
    [76] = "numPad5",
    [88] = "f12",
    [197] = "pause",
    [66] = "f8",
    [6] = "five",
    [179] = "numPadComma",

}

---@enum Enums.Color
JLib.Enums.Color = {
    ["white"] = 1,
    ["orange"] = 2,
    ["magenta"] = 4,
    ["lightBlue"] = 8,
    ["yellow"] = 16,
    ["lime"] = 32,
    ["pink"] = 64,
    ["gray"] = 128,
    ["lightGray"] = 256,
    ["cyan"] = 512,
    ["purple"] = 1024,
    ["blue"] = 2048,
    ["brown"] = 4096,
    ["green"] = 8192,
    ["red"] = 16384,
    ["black"] = 32768,
    ["None"] = -1,
}

---@type table<Enums.Color, string>
JLib.Enums.Blit =
{
    [JLib.Enums.Color.white] = "0",
    [JLib.Enums.Color.orange] = "1",
    [JLib.Enums.Color.magenta] = "2",
    [JLib.Enums.Color.lightBlue] = "3",
    [JLib.Enums.Color.yellow] = "4",
    [JLib.Enums.Color.lime] = "5",
    [JLib.Enums.Color.pink] = "6",
    [JLib.Enums.Color.gray] = "7",
    [JLib.Enums.Color.lightGray] = "8",
    [JLib.Enums.Color.cyan] = "9",
    [JLib.Enums.Color.purple] = "a",
    [JLib.Enums.Color.blue] = "b",
    [JLib.Enums.Color.brown] = "c",
    [JLib.Enums.Color.green] = "d",
    [JLib.Enums.Color.red] = "e",
    [JLib.Enums.Color.black] = "f",
    [JLib.Enums.Color.None] = "z",
}

---@type table<string, Enums.Color>
JLib.Enums.BlitReverse =
{
    ["0"] = JLib.Enums.Color.white,
    ["1"] = JLib.Enums.Color.orange,
    ["2"] = JLib.Enums.Color.magenta,
    ["3"] = JLib.Enums.Color.lightBlue,
    ["4"] = JLib.Enums.Color.yellow,
    ["5"] = JLib.Enums.Color.lime,
    ["6"] = JLib.Enums.Color.pink,
    ["7"] = JLib.Enums.Color.gray,
    ["8"] = JLib.Enums.Color.lightGray,
    ["9"] = JLib.Enums.Color.cyan,
    ["a"] = JLib.Enums.Color.purple,
    ["b"] = JLib.Enums.Color.blue,
    ["c"] = JLib.Enums.Color.brown,
    ["d"] = JLib.Enums.Color.green,
    ["e"] = JLib.Enums.Color.red,
    ["f"] = JLib.Enums.Color.black,
    ["z"] = JLib.Enums.Color.None,
}
