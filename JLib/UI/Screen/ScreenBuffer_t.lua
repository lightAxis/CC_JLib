local class = require("Class.middleclass")

---@class Screen_t.Buffer
local Buffer = class("Screen_t.Buffer")

JLib = JLib or {}
JLib.Screen_t = JLib.Screen_t or {}
JLib.Screen_t.Buffer = JLib.Screen_t.Buffer or {}
JLib.Screen_t.Buffer = Buffer

---constructor
---@param text string
---@param fg string
---@param bg string
function Buffer:initialize(text, fg, bg)
    self.Text = text
    self.FG = fg
    self.BG = bg
end

---properties description
---@class Screen_t.Buffer
---@field Text string
---@field BG string
---@field FG string
---@field new fun(self:Screen_t.Buffer, text:string, fg:string, bg:string):Screen_t.Buffer
