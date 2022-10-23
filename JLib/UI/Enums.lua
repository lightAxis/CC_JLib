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

---@enum Enums.Key
JLib.Enums.Key = {
    ["a"] = 65,
    ["c"] = 67,
    ["b"] = 66,
    ["e"] = 69,
    ["d"] = 68,
    ["g"] = 71,
    ["f"] = 70,
    ["i"] = 73,
    ["f10"] = 299,
    ["k"] = 75,
    ["j"] = 74,
    ["m"] = 77,
    ["l"] = 76,
    ["o"] = 79,
    ["n"] = 78,
    ["minus"] = 45,
    ["f23"] = 312,
    ["s"] = 83,
    ["return"] = 257,
    ["slash"] = 47,
    ["seven"] = 55,
    ["eight"] = 56,
    ["v"] = 86,
    ["six"] = 54,
    ["x"] = 88,
    ["numPad6"] = 326,
    ["z"] = 90,
    ["f18"] = 307,
    ["rightBracket"] = 93,
    ["f9"] = 298,
    ["left"] = 263,
    ["numPadSubtract"] = 333,
    ["f20"] = 309,
    ["numPadEqual"] = 336,
    ["leftCtrl"] = 341,
    ["rightCtrl"] = 345,
    ["numPad2"] = 322,
    ["delete"] = 261,
    ["pause"] = 284,
    ["leftAlt"] = 342,
    ["f4"] = 293,
    ["numLock"] = 282,
    ["semicolon"] = 59,
    ["pageDown"] = 267,
    ["f8"] = 297,
    ["f2"] = 291,
    ["backslash"] = 92,
    ["f16"] = 305,
    ["down"] = 264,
    ["r"] = 82,
    ["f11"] = 300,
    ["insert"] = 260,
    ["period"] = 46,
    ["rightShift"] = 344,
    ["f19"] = 308,
    ["h"] = 72,
    ["f15"] = 304,
    ["nine"] = 57,
    ["f3"] = 292,
    ["capsLock"] = 280,
    ["f5"] = 294,
    ["leftBracket"] = 91,
    ["numPad3"] = 323,
    ["scollLock"] = 281,
    ["f1"] = 290,
    ["f14"] = 303,
    ["zero"] = 48,
    ["space"] = 32,
    ["two"] = 50,
    ["up"] = 265,
    ["home"] = 268,
    ["equals"] = 61,
    ["f7"] = 296,
    ["apostrophe"] = 39,
    ["rightAlt"] = 346,
    ["three"] = 51,
    ["numPadEnter"] = 335,
    ["pageUp"] = 266,
    ["p"] = 80,
    ["y"] = 89,
    ["w"] = 87,
    ["u"] = 85,
    ["tab"] = 258,
    ["t"] = 84,
    ["four"] = 52,
    ["f21"] = 310,
    ["numPad1"] = 321,
    ["right"] = 262,
    ["numPadDecimal"] = 330,
    ["f25"] = 314,
    ["leftShift"] = 340,
    ["backspace"] = 259,
    ["grave"] = 96,
    ["end"] = 269,
    ["one"] = 49,
    ["numPadAdd"] = 334,
    ["f24"] = 313,
    ["q"] = 81,
    ["numPad7"] = 327,
    ["comma"] = 44,
    ["f13"] = 302,
    ["numPad4"] = 324,
    ["f17"] = 306,
    ["numPad0"] = 320,
    ["f22"] = 311,
    ["f6"] = 295,
    ["enter"] = 257,
    ["numPadDivide"] = 331,
    ["numPad5"] = 325,
    ["f12"] = 301,
    ["numPad9"] = 329,
    ["scrollLock"] = 281,
    ["five"] = 53,
    ["numPad8"] = 328
}

---@enum Enums.KeyReverse
JLib.Enums.KeyReverse = {
    [65] = "a",
    [67] = "c",
    [66] = "b",
    [69] = "e",
    [68] = "d",
    [71] = "g",
    [70] = "f",
    [73] = "i",
    [299] = "f10",
    [75] = "k",
    [74] = "j",
    [77] = "m",
    [76] = "l",
    [79] = "o",
    [78] = "n",
    [45] = "minus",
    [312] = "f23",
    [83] = "s",
    [257] = "return",
    [47] = "slash",
    [55] = "seven",
    [56] = "eight",
    [86] = "v",
    [54] = "six",
    [88] = "x",
    [326] = "numPad6",
    [90] = "z",
    [307] = "f18",
    [93] = "rightBracket",
    [298] = "f9",
    [263] = "left",
    [333] = "numPadSubtract",
    [309] = "f20",
    [336] = "numPadEqual",
    [341] = "leftCtrl",
    [345] = "rightCtrl",
    [322] = "numPad2",
    [261] = "delete",
    [284] = "pause",
    [342] = "leftAlt",
    [293] = "f4",
    [282] = "numLock",
    [59] = "semicolon",
    [267] = "pageDown",
    [297] = "f8",
    [291] = "f2",
    [92] = "backslash",
    [305] = "f16",
    [264] = "down",
    [82] = "r",
    [300] = "f11",
    [260] = "insert",
    [46] = "period",
    [344] = "rightShift",
    [308] = "f19",
    [72] = "h",
    [304] = "f15",
    [57] = "nine",
    [292] = "f3",
    [280] = "capsLock",
    [294] = "f5",
    [91] = "leftBracket",
    [323] = "numPad3",
    [290] = "f1",
    [303] = "f14",
    [48] = "zero",
    [32] = "space",
    [50] = "two",
    [265] = "up",
    [268] = "home",
    [61] = "equals",
    [296] = "f7",
    [39] = "apostrophe",
    [346] = "rightAlt",
    [51] = "three",
    [335] = "numPadEnter",
    [266] = "pageUp",
    [80] = "p",
    [89] = "y",
    [87] = "w",
    [85] = "u",
    [258] = "tab",
    [84] = "t",
    [52] = "four",
    [310] = "f21",
    [321] = "numPad1",
    [262] = "right",
    [330] = "numPadDecimal",
    [314] = "f25",
    [340] = "leftShift",
    [259] = "backspace",
    [96] = "grave",
    [269] = "end",
    [49] = "one",
    [334] = "numPadAdd",
    [313] = "f24",
    [81] = "q",
    [327] = "numPad7",
    [44] = "comma",
    [302] = "f13",
    [324] = "numPad4",
    [306] = "f17",
    [320] = "numPad0",
    [311] = "f22",
    [295] = "f6",
    [331] = "numPadDivide",
    [325] = "numPad5",
    [301] = "f12",
    [329] = "numPad9",
    [281] = "scrollLock",
    [53] = "five",
    [328] = "numPad8"
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
    ["black"] = 32768
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
}

---@type table<string, Enums.Color>
JLib.Enums.BlitReverse =
{
    ["0"] = colors.white,
    ["1"] = colors.orange,
    ["2"] = colors.magenta,
    ["3"] = colors.lightBlue,
    ["4"] = colors.yellow,
    ["5"] = colors.lime,
    ["6"] = colors.pink,
    ["7"] = colors.gray,
    ["8"] = colors.lightGray,
    ["9"] = colors.cyan,
    ["a"] = colors.purple,
    ["b"] = colors.blue,
    ["c"] = colors.brown,
    ["d"] = colors.green,
    ["e"] = colors.red,
    ["f"] = colors.black,
}
