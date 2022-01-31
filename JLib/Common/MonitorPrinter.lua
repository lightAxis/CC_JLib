local class = require("Class.middleclass")

require("CCPeripherals.Monitor")
require("MathLib.Vector2")

---@class Common.MonitorPrinter
local monitorPrinter = class("CCPeripherals.MonitorPrinter")

JLib = JLib or {}
JLib.Common = JLib.Common or {}
JLib.Common.MonitorPrinter = monitorPrinter

---constructor
---@param screen CCPeripherals.Monitor
function monitorPrinter:initialize(screen)
    self.screen = screen
    self.lines = {}
    self.size = JLib.Vector2:new(1, 1)
    self.size.x, self.size.y = self.screen.getSize()
    self.anchor = 1

    for i = 1, 10, self.size.y do table.insert(self.lines, "") end
end

---properties definition
---@class Common.MonitorPrinter
---@field screen CCPeripherals.Monitor
---@field lines table<number, string>
---@field size Vector2
---@field anchor number
---@field new fun(self:Common.MonitorPrinter, screen:CCPeripherals.Monitor):Common.MonitorPrinter

function monitorPrinter:print(str)
    if (self.anchor >= self.size.y) then
        for i = 2, self.size.y, 1 do self.lines[i - 1] = self.lines[i] end
        self.lines[self.size.y] = str
    else
        self.lines[self.anchor] = str
        self.anchor = self.anchor + 1
    end

    self.screen.clear()
    for i = 1, self.size.y, 1 do
        self.screen.setCursorPos(1, i)
        self.screen.write(self.lines[i])
    end
end
