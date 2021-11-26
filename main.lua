require("init")

require("UI.Border")

screen = {}
screen.write = function(d) print("wruteee:" .. d) end

local a = JLib.Border:new(nil, screen)
a:render()

local b = JLib.Border:new(a, screen)
b:render()
