local class = require("Class.middleclass")

---@class BankDB.Table.Daytime
local daytime = class("BankDB.Table.Daytime")


JLib = JLib or {}
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.Table = JLib.BankDB.Table or {}
JLib.BankDB.Table.Daytime = daytime


---constructor
function daytime:initialize()
    self.Day = os.day()
    self.Time = os.time()
end

---properties description
---@class BankDB.Table.Daytime
---@field Day number
---@field Time number
---@field new fun(self:BankDB.Table.Daytime):BankDB.Table.Daytime


function daytime:Serialize()
    local temp = {}
    temp.Day = self.Day
    temp.Time = self.Time

    return textutils.serialize(temp)
end

function daytime:Deserialize(str)
    local temp = textutils.unserialize(str)
    local temp2 = JLib.BankDB.Table.Daytime:new()
    temp2.Day = temp.Day
    temp2.Time = temp.Time
    return temp2
end