local class = require("Class.middleclass")

---@class BankDB.Table_t.History
local history = class("BankDB.Table_t.History")

JLib = JLib or {}
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.Table_t = JLib.BankDB.Table_t or {}
JLib.BankDB.Table_t.History = history


---constructor
---@param name string
---@param inout number
---@param balanceLeft number
---@param daytime BankDB.Table_t.Daytime
function history:initialize(name, inout, balanceLeft, daytime)
    self.Name = name
    self.Inout = inout
    self.BalanceLeft = balanceLeft
    self.DayTime = daytime
end

---properties description
---@class BankDB.Table_t.History
---@field Name string
---@field Inout number
---@field BalanceLeft number
---@field DayTime BankDB.Table_t.Daytime
---@field new fun(self:BankDB.Table_t.History, name:string, inout:number, balanceLeft:number, daytime:BankDB.Table_t.Daytime):BankDB.Table_t.History

---serialize this
---@return string
function history:Serialize()
    local temp = {}
    temp.Name = self.Name
    temp.Inout = self.Inout
    temp.BalanceLeft = self.BalanceLeft
    temp.DayTime = self.DayTime:Serialize()

    return textutils.serialize(temp)
end

---deserialize this string
---@param str string
---@return BankDB.Table_t.Daytime
function history:Deserialize(str)
    local temp = textutils.unserialize(str)
    local dayy = JLib.BankDB.Table_t.Daytime:Deserialize(temp.DayTime)
    local temp2 = JLib.BankDB.Table_t.History:new(temp.Name, temp.Inout, temp.BalanceLeft, dayy)
    return temp2
end
