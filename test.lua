--- Copyright © 2026, YourLocalCappy, all rights deserved ---

concommand.Add("TestKeyValues", function()

    local kv = KeyValues("Example")

    if kv:LoadFromFile("hl2sbr/scripts/test.txt") then
        print(kv:GetString("Text", "default"))
    end

    kv:deleteThis()

end)