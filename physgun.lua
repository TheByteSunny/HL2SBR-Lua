--- Copyright © 2026, YourLocalCappy, all rights deserved ---

--[[
local offsetX = ConVar("physgun_glow_offset_x", "-1.5", FCVAR.REPLICATED)
local offsetY = ConVar("physgun_glow_offset_y", "0.0", FCVAR.REPLICATED)
local offsetZ = ConVar("physgun_glow_offset_z", "0.0", FCVAR.REPLICATED)
]]

function Physgun(mode, fx, r, g, b, scale, pPlayer)

    if not IsValid(pPlayer) then return end

    local wep = pPlayer:GetActiveWeapon()
    if not IsValid(wep) then return end

    if wep:GetClassname() ~= "weapon_physgun" then
        return
    end

    local vm = pPlayer:GetViewModel()

    if not IsValid(vm) then
        vm = wep
    end

    local att = vm:LookupAttachment("muzzle")

    if att <= 0 then
        return
    end

    --[[
    local pos = Vector()
    local ang = QAngle()

    if not vm:GetAttachment(att, pos, ang) then
        return
    end

    pos.x = pos.x + offsetX:GetFloat()
    pos.y = pos.y + offsetY:GetFloat()
    pos.z = pos.z + offsetZ:GetFloat()
    ]]

    local sprite = ents.Create("env_sprite")

    if not IsValid(sprite) then
        return
    end

    -- sprite:SetAbsOrigin(pos)

    sprite:KeyValue("model", "sprites/glow01.vmt")
    sprite:KeyValue("rendermode", tostring(mode))
    sprite:KeyValue("renderfx", tostring(fx))
    sprite:KeyValue("scale", tostring(scale))
    sprite:KeyValue("spawnflags", "1")

    sprite:SetOwnerEntity(pPlayer)

    sprite:SetRenderColor(r, g, b, 200)

    sprite:Spawn()
    sprite:Activate()

    sprite:SetParent(vm, att)

    timer.Simple(0.02, function()

        if IsValid(sprite) then
            sprite:Remove()
        end

    end)

end

PhysgunRender = "5"
PhysgunFX = "14"
PhysgunColorR = 0
PhysgunColorG = 220
PhysgunColorB = 255
PhysgunScale = "0.03"

local red = ConVar("physgun_glow_red", "0", FCVAR.REPLICATED)
local green = ConVar("physgun_glow_green", "220", FCVAR.REPLICATED)
local blue = ConVar("physgun_glow_blue", "255", FCVAR.REPLICATED)
local scal = ConVar("physgun_glow_scale", "0.03", FCVAR.REPLICATED)
local fxa = ConVar("physgun_glow_fx", "14", FCVAR.REPLICATED)
local render = ConVar("physgun_glow_render", "5", FCVAR.REPLICATED)

hook.Add("CheatImpulseCommands", "PhysgunSprite", function(pPlayer)

    if not IsValid(pPlayer) or not pPlayer:IsPlayer() then
        return
    end

    if engine:IsPaused() then
        return
    end

    local ra = red:GetInt()
    local ga = green:GetInt()
    local ba = blue:GetInt()

    local s = scal:GetFloat()

    local f = fxa:GetInt()
    local rd = render:GetInt()

    Physgun(
        rd,
        f,
        ra,
        ga,
        ba,
        s,
        pPlayer
    )

end)
