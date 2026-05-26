--- Copyright © 2026, YourLocalCappy, all rights deserved ---

concommand.Create("_", function(pPlayer, pCmd, ArgS)

    if not ArgS or ArgS == "" then

        dbg.Warning("How to talk: _ <text>\n")
        return

    end

    ArgS = string.gsub(
        ArgS,
        '^"(.*)"$',
        "%1"
    )

    local text =
        string.match(
            ArgS,
            "^(.+)%s+(%d+%.?%d*)$"
        )

    if not text then
        text = ArgS
    end

    local p = pPlayer:GetPlayerName()

    print(p .. " : " .. text)

end, "Send a message in the chat. Usage: _ <text>", FCVAR.CLIENTDLL)