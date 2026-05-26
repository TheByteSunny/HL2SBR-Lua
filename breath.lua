--- Copyright © 2026, YourLocalCappy, all rights deserved ---

local sin = math.sin
local curtime = gpGlobals.curtime

hook.Add("CalcPlayerView", "CalcPlayerView", function(pPlayer, eyeOrigin, eyeAngles, fov)
  eyeAngles = eyeAngles + QAngle(sin(curtime()) / 2, 0, 0)

  return eyeOrigin, eyeAngles, fov
end)
