local Headers = {}

---namespace JLib
JLib = JLib or {}

---namespace JLib.PortDB
JLib.BankDB = JLib.BankDB or {}
JLib.BankDB.Headers = Headers

---@enum BankDB.Headers
JLib.BankDB.Headers = {
    ["REGISTER"] = 1,
    ["ACK_REGISTER"] = 2,
    ["SEND"] = 3,
    ["ACK_SEND"] = 4,
    ["GETACCOUNT"] = 5,
    ["ACK_GETACCOUNT"] = 6,
    ["GETHISTORY"] = 7,
    ["ACK_GETHISTORY"] = 8,
    ["GETACCOUNTS"] = 9,
    ["ACK_GETACCOUNTS"] = 10
}
