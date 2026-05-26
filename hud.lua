--- Copyright © 2026, YourLocalCappy, all rights deserved ---

hook.Add("HudElementShouldDraw", "NotWatermarkDraw", function(name)

    if name == "CHudFlashlight" then
       return false 
    end

    if name == "CHudSuitPower" then
       return false 
    end

end)