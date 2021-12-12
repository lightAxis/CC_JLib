local class = require("Class.middleclass")

---@class DB.Protocols
local Protocols = {
    ["master"] = "IDs",
    ["add"] = 2,
    ["remove"] = 3,
    ["request"] = 4,
    ["refresh"] = 5
}

---namespace JLib
JLib = JLib or {}
---namespace JLib.DB
JLib.DB = JLib.DB or {}
JLib.DB.Protocols = Protocols
