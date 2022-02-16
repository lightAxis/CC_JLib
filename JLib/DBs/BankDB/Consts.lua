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
    ["rednet_side"] = "back",
    ["player_detector_side"] = "top",
    ["chat_box_side"] = "bottom",
    ["salary_monitor_side"] = "right",
    ["banking_monitor_side"] = "left",
    ["salary_update_sec"] = 50,
    ["salary_init"] = 17568000
}
