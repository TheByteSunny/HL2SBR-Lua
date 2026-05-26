--- Copyright © 2026, YourLocalCappy, all rights deserved ---

require("concommand")

concommand.Add("list_addons", function()
    print("")
    for k, v in pairs(addons) do
        print("")
        print("Addon: " .. v.Addon)
    end
end)