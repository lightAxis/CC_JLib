-- select your environment
-- 0 : jasuk500, 1 : CC, 2 : replit.com
local environment = 0

if (environment == 0) then
    -- in another env
    package.path = package.path .. ";D:/lua/CC_JLib/JLib/?.lua"

    require("LibVariables.LibVariables")
    JLib.LibVariables.static.ENVIRONMENT =
        JLib.LibVariables.static.eENVIRONMENT.Lua

elseif (environment == 1) then
    -- CC env
    package.path = package.path .. ";CC_JLib/JLib/?.lua"

    require("LibVariables.LibVariables")
    JLib.LibVariables.static.ENVIRONMENT =
        JLib.LibVariables.static.eENVIRONMENT.CC
elseif (environment == 2) then
    -- replit env
    package.path = package.path .. ";/home/runner/CCsource/JLib/?.lua"

    require("LibVariables.LibVariables")
    JLib.LibVariables.static.ENVIRONMENT =
        JLib.LibVariables.static.eENVIRONMENT.Lua
end

