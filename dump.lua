--- Copyright © 2026, YourLocalCappy, all rights deserved ---

local function SafePrint(str)
    print(str)
end

local function DumpIndex(name, obj, indent)
    indent = indent or ""

    local mt = getmetatable(obj)
    if not mt then return end

    SafePrint(indent .. name .. " <metatable>")

    for k, v in pairs(mt) do
        SafePrint(indent .. "  " .. name .. ".__meta." .. tostring(k) .. " (" .. type(v) .. ")")
    end

    if type(mt.__index) == "table" then
        SafePrint(indent .. "  " .. name .. ".__index (table)")
        for k, v in pairs(mt.__index) do
            SafePrint(indent .. "    " .. name .. ":" .. tostring(k) .. " (" .. type(v) .. ")")
        end
    elseif type(mt.__index) == "function" then
        SafePrint(indent .. "  " .. name .. ".__index (function)")
        SafePrint(indent .. "    " .. name .. ":* (engine-resolved methods)")
    end
end

local function DeepDump(name, tbl, indent, visited)
    indent = indent or ""
    visited = visited or {}

    if visited[tbl] then return end
    visited[tbl] = true

    for k, v in pairs(tbl) do
        if type(v) == "table" then
            SafePrint(indent .. name .. "." .. tostring(k) .. " (" .. type(v) .. ")")
            DeepDump(name .. "." .. tostring(k), v, indent .. "  ", visited)
        else
            SafePrint(indent .. name .. "." .. tostring(k) .. " (" .. type(v) .. ")")
        end
    end

    DumpIndex(name, tbl, indent)
end

local function Test(libname, lib)
    ColorPrint(0, 255, 255, 255, "[SCAN] " .. libname)

    if type(lib) ~= "table" then
        dbg.Warning("[WARNING] " .. libname .. " does not exist or is not a table.")
        return
    end

    DeepDump(libname, lib)
end

do

    local oldCall = hook.call
    local fired = {}

    hook.call = function(strEventName, tGamemode, ...)

        if not fired[strEventName] then
            fired[strEventName] = true
            print("[HOOK DETECTED] " .. tostring(strEventName))
        end

        return oldCall(strEventName, tGamemode, ...)
    end

end

UTIL2 = UTIL
util = require("util") or util
filesystem = require("filesystem")
bit = bit or require("bit")
file = file
mathlib = mathlib
math = math
convar = ConVar or convar or _R.ConVar or _R.convar
local pPlayer = _R.CBasePlayer
material = IMaterial or _R.IMaterial
ammo = _R.CAmmoDef or CAmmoDef
effect = effect or _R.effect
scriptpanel = CScriptedClientLuaPanel or _R.CScriptedClientLuaPanel
ppage = PropertyPage or _R.PropertyPage
pdialog = PropertyDialog or _R.PropertyDialog
frame = Frame or _R.Frame
panel = Panel or _R.Panel
checkbutton = CheckButton or _R.CheckButton
button = Button or _R.Button
BaseAnim = _R.CBaseAnimating or CBaseAnimating
coroutine = coroutine

concommand.Add("dump_all", function()

Test("material", material)
Test("engine", engine)
Test("cvar", cvar)
Test("surface", surface)
Test("debugoverlay", debugoverlay)
Test("mathlib", mathlib)
Test("math", math)
Test("vgui", vgui)
Test("util", util)
Test("UTIL", UTIL2)
Test("input", input)
Test("filesystem", filesystem)
Test("file", file)
Test("bit", bit)
Test("pPlayer", pPlayer)
Test("button", button)
Test("checkbutton", checkbutton)
Test("ppage", ppage)
Test("pdialog", pdialog)
Test("scriptpanel", scriptpanel)
Test("game", game)
Test("baseanim", BaseAnim)
Test("dbg", dbg)
Test("hook", hook)
Test("coroutine", coroutine)

end)