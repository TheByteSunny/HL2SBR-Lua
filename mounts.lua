--- Copyright © 2026, YourLocalCappy, all rights deserved ---

require("filesystem")

local function RunCmd(cmd)
  if CLIENT then
     engine.ClientCmd(cmd)
  elseif SERVER then 
     engine.ServerCommand(cmd .. "\n")
  end
end

local engine = engine or {}

local function engine.ClientCmd_Unrestricted(cmd)
  -- quite hacky
  if CLIENT then
     RunCmd(cmd)
  end
end

local function RunConsoleCommand(cmd, ...)
    if not cmd then return end

    local args = {...}
    if #args > 0 then
        cmd = cmd .. " " .. table.concat(args, " ")
    end

    RunCmd(cmd)
end

ExecuteCmd = RunCmd
RunCommand = RunCmd
Cmd = RunCmd

concommand.Add("mount_reload", function()

    local kv = KeyValues("Mounts")

    if not kv:LoadFromFile(
        "hl2sbr/cfg/mounts.kv"
    ) then

        print("[MOUNTS] Failed to load mounts.kv")

        kv:deleteThis()

        return

    end

    local game = kv:GetFirstSubKey()

    while game do

        if game:GetString() == "1" then

            local name = game:GetName()

            print("[MOUNTS] Mounting:", name)

            filesystem.MountSteamContent(name)

        end

        game = game:GetNextKey()

    end

    kv:deleteThis()

end)

RunCmd("mount_reload")