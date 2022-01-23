local class = require("Class.middleclass")

---@class BankDB.Table_t.Daytime
local daytime = class("BankDB.Table_t.Daytime")


JLib = JLib or {}
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.Table_t = JLib.BankDB.Table_t or {}
JLib.BankDB.Table_t.Daytime = daytime


---constructor
function daytime:initialize()
    self.Realtime = os.date()
end

---properties description
---@class BankDB.Table_t.Daytime
---@field new fun(self:BankDB.Table_t.Daytime):BankDB.Table_t.Daytime


function daytime:Serialize()
    local temp = {}
    temp.Realtime = self.Realtime
    return textutils.serialize(temp)
end

function daytime:Deserialize(str)
    local temp = textutils.unserialize(str)
    local temp2 = JLib.BankDB.Table_t.Daytime:new()
    temp2.Realtime = temp.Realtime
    return temp2
end
