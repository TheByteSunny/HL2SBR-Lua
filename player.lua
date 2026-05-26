--- Copyright © 2026, YourLocalCappy, all rights deserved ---

BasePlayer = _R.CBasePlayer

function LocalPlayer()
	if not _CLIENT then
		return UTIL.GetLocalPlayer()
	else
		return _R.CBasePlayer.GetLocalPlayer()
	end

   return _R.CBaseEntity
end

pPlayer = LocalPlayer()
