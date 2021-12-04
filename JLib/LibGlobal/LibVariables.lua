local class = require("Class.middleclass")

-- public class LibVariables
---@class LibVariables
local LibVariables = class("RequireSelection")

-- namespace JLib
JLib = JLib or {}
JLib.LibVariables = LibVariables

-- constructor
function LibVariables:initialize() end

-- class static variable

-- environment of code to run. 
-- Lua : normal Lua environment
-- CC : ComputerCraft environment
LibVariables.static.ENVIRONMENT = "Lua"
LibVariables.static.eENVIRONMENT = {["Lua"] = "Lua", ["CC"] = "CC"}