-- selection build
require("LibGlobal.LibVariables")

if (JLib.LibVariables.static.ENVIRONMENT ==
    JLib.LibVariables.static.eENVIRONMENT.Lua) then
    require("UI.Screen.Screen_Lua")

elseif (JLib.LibVariables.static.ENVIRONMENT ==
    JLib.LibVariables.static.eENVIRONMENT.CC) then
    require("UI.Screen.Screen_CC")

end
