---@claBank.Consts
local Consts = {}

---namespace JLib
JLib = JLib or {}
---namespace JLib.Consts
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.Consts = Consts

---@class BankDB.Consts
JLib.BankDB.Consts = {
    ["masterPort"] = "BankDB",
    ["ServerPath"] = "BankDBServer",
    ["ClientPath"] = "BankDBClient",
    ["rednet_side"] = "left",
    ["player_detector_side"] = "right",
    ["salary_update_sec"] = 50,
    ["salary_init"] = 17568000
}
