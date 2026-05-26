--- Copyright © 2026, YourLocalCappy, all rights deserved ---

-- REDO: This is crap
CreateConVar("sv_npcs_move", "0", function(newValue, oldValue)
    if newValue == 1 then
       ColorPrint(0, 255, 0, 0, "NPCs move started")
       RunCmd("ent_fire npc_citizen startpatrolling")
       RunCmd("ent_fire npc_combine_s startpatrolling")
    end
end)
