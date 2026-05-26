--- Copyright © 2026, YourLocalCappy, all rights deserved ---

-- should be implemented in APK but i'm lazy to fix

-- ConVars

local isroll = ConVar("sv_roll", "1", FCVAR.REPLICATED)

local rollangle   = ConVar("sv_roll_angle", "0.1", FCVAR.REPLICATED)

local rollspeed   = ConVar("sv_roll_speed", "195", FCVAR.REPLICATED)

-- view roll hell yeah

local function ViewRoll(pPlayer)
    if not isroll:GetBool() then return 0 end

    local velocity = pPlayer:GetAbsVelocity()
    local angles   = pPlayer:GetAbsAngles()

    local forward, right, up = Vector(), Vector(), Vector()
    mathlib.AngleVectors(angles, forward, right, up)

    local side = velocity:Dot(right)

    local sign = (side < 0) and -1 or 1
    local speed = math.abs(side)

    local rollAngle = rollangle:GetFloat()
    local rollSpeed = rollspeed:GetFloat()

    local value
    if speed < rollSpeed then
        value = speed * rollAngle / rollSpeed
    else
        value = rollAngle
    end

    return value * sign
end

-- instead of Think here I need cheat hook
hook.Add("CheatImpulseCommands", "OhYeah", function(pPlayer)

    pPlayer = ToBasePlayer(pPlayer)

    if engine:IsPaused() then return end

    local roll = ViewRoll(pPlayer)

    if roll ~= 0 then
        pPlayer:ViewPunch(QAngle(0, 0, roll))
    end

end)

if not concommand then
   require("concommand")
end

concommand.Add("drop_currentwep", function(pPlayer)
   pPlayer = ToBasePlayer(pPlayer) or LocalPlayer()

	local pPlayerWeapon = pPlayer:GetActiveWeapon()
	local WeaponName = pPlayerWeapon:GetClassname()
	if (pPlayer ~= NULL or pPlayer ~= nil) then
		if (pPlayerWeapon ~= NULL or pPlayerWeapon ~= nil) then 
			if not _CLIENT then
				pPlayer:Weapon_Drop(pPlayerWeapon)
			else
				print("Sorry man, you can't do that.")
			end
		else
			return
		end
	else
		return
	end
end)