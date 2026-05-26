-- made by BartG
-- remade and updated by YourLocalCappy

--[[


   DO NOT MODIFY THIS FILE
   YOU SHOULD CREATE ANOTHER
   FILE FOR CUSTOM C_ARMS!


]]

-- include("game.lua")

if not concommand or concommand == NULL then
   require("concommand")
end

C_ARMS = C_ARMS or {}

function SetSkin(id)
   if CLIENT then
    engine.ClientCmd("r_skin " .. id)
    engine.ClientCmd("ent_fire skin")
   elseif SERVER then
    engine.ServerCommand("r_skin " .. id .. "\n")
    engine.ServerCommand("ent_fire skin\n")
   end
end

function SMRegisterCArm(name, skinID, namesmenu)
   if not name or skinID == nil then return end
    if C_ARMS[name] then return end

    C_ARMS[name] = skinID

    local cmd = "c_arms_" .. name

    concommand.Add(cmd, function()
        SetSkin(skinID)
    end)

    if CLIENT and smlib then
        smlib.CreateButton("Advanced Options", namesmenu, cmd)
    end
end

function RegisterCArm(name, skinID)
   if not name or skinID == nil then return end

    local cmd = "c_arms_" .. name

    concommand.Add(cmd, function()
        SetSkin(skinID)
    end)
end

-- default
RegisterCArm("citizen_white", 0)
RegisterCArm("citizen_black", 1)
RegisterCArm("citizen_zombie", 2)