-- selection build
require("LibVariables.LibVariables")

if (JLib.LibVariables.static.ENVIRONMENT ==
    JLib.LibVariables.static.eENVIRONMENT.Lua) then
    require("UI.Enums.Enums_Lua")

elseif (JLib.LibVariables.static.ENVIRONMENT ==
    JLib.LibVariables.static.eENVIRONMENT.CC) then
    require("UI.Enums.Enums_CC")
end