--- Copyright © 2026, YourLocalCappy, all rights deserved ---

i[[ I've been working on this since Alpha 2.0 ]]

require("list")
require("playermodel")

local pairs = pairs
local gsub  = string.gsub

local cv_model = ConVar("pm_model", "", 0)

function GetAllModels()
    return list.Raw("PlayerOptionsModel") or {}
end

concommand.Add("getpms", function()
    table.print(GetAllModels())
end)

local function no_space2(s)
    return gsub(s, "%s+", "_")
end

local function ApplyModel()
    RunCmd("cl_playermodel " .. cv_model:GetString())
end

local function ValidModel(model)
    util.PrecacheModel(model)
end

local Created = {}

local function RegisterAll()

    local Models = list.Raw("PlayerOptionsModel") or {}

    for k, v in pairs(Models) do

        local model = type(v) == "table" and v.Model or v

        local category = type(v) == "table" and (v.Category or "other") or "other"
        local name     = type(v) == "table" and (v.Name or k) or k

        category = no_space2(category:lower())
        name     = no_space2(name:lower())

        local cmd_load = "load_" .. category .. "_" .. name

        if not Created[cmd_load] then
            concommand.Add(cmd_load, function()
                RunCmd("cl_playermodel " .. model)
            end)

            Created[cmd_load] = true
        end

        local cmd_set = "pm_set_" .. name

        if not Created[cmd_set] then
            concommand.Add(cmd_set, function()
                RunCmd("pm_model " .. model)
                ApplyModel()
                ValidModel(model)
            end)

            Created[cmd_set] = true
        end

    end

end

concommand.Add("pm_refresh", RegisterAll)
concommand.Add("cl_refresh_playermodel", RegisterAll)

concommand.Add("pm_list", function()
    local Models = list.Raw("PlayerOptionsModel") or {}

    for k, v in pairs(Models) do
        local model = type(v) == "table" and v.Model or v
        print(k .. " -> " .. model)
    end
end)

RunCmd("wait 120; pm_refresh")