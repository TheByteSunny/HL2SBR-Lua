--- Copyright © 2026, YourLocalCappy, all rights deserved ---

local red   = ConVar("playermodel_red",   "255", FCVAR.REPLICATED)
local green = ConVar("playermodel_green", "255", FCVAR.REPLICATED)
local blue  = ConVar("playermodel_blue",  "255", FCVAR.REPLICATED)

function PlayermodelUpdate(pPlayer)
    if not IsValid(pPlayer) then return end

    local r = red:GetInt()
    local g = green:GetInt()
    local b = blue:GetInt()

    pPlayer:SetRenderColor(r, g, b, 255)
end

concommand.Add("apply_playermodel_color", function(pPlayer)
    PlayermodelUpdate(pPlayer)
end)