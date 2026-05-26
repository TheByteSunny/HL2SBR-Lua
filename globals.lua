--- Copyright © 2026, YourLocalCappy, all rights deserved ---

--[[

Here are some needed stuff

]]

-- include("game.lua")

engine = engine

engine.ServerCommand = engine.ServerCommand

entity = require("entity")

spaint = require("spaint")

ent = entity

cvar = require("cvar")

util = util or UTIL or {}

FCVAR_CLIENTDLL = _E.FCVAR_CLIENTDLL or 0

function engine.ServerCmd( cmd )
  if SERVER then
    if engine.ServerCommand then
     engine.ServerCommand( cmd .. "\n" )
    else
     print("engine.ServerCommand is NOT available!")
    end
  end
end

function LocalPlayer()
	if not _CLIENT then
		return util.GetLocalPlayer()
	else
		return _R.CBasePlayer.GetLocalPlayer()
	end
end

pPlayer = LocalPlayer() or _R.CBasePlayer

function GetPlayer()
  result = _R.CBasePlayer.GetLocalPlayer()
  print(result)
end

function GetGPlayer()
  return _R.CBasePlayer.GetLocalPlayer()
end

GPLAYER = GetGPlayer()

if bit then
function bit.has(v, f) return bit.band(v, f) ~= 0 end
function bit.add(v, f) return bit.bor(v, f) end
function bit.remove(v, f) return bit.band(v, bit.bnot(f)) end
function bit.toggle(v, f)
if bit.has(v, f) then return bit.remove(v, f) end
return bit.add(v, f)
end
end

function DEFINE_BASECLASS(name)
if ENT then
ENT.__base = name
elseif SWEP then
SWEP.__base = name
else
Warning("Not a SWEP or a entity!")
end
end

function DEFINE_FACTORY(name)
if ENT then
ENT.__factory = name
elseif SWEP then
SWEP.__factory = name
else
Warning("Not a SWEP or a entity!")
end
end

file = file or {}

function file.Write(name, content)
local f = filesystem.Open(name, "w", "DATA")
if not f then return false end
local ok = filesystem.Write(content, f) == #content
filesystem.Close(f)
return ok
end

function file.Append(name, content)
local f = filesystem.Open(name, "a", "DATA")
if not f then return false end
local ok = filesystem.Write(content, f) == #content
filesystem.Close(f)
return ok
end

function file.Read(name)
local f = filesystem.Open(name, "r", "DATA")
if not f then return nil end
local size = filesystem.Size(f)
if size <= 0 then filesystem.Close(f) return nil end
local _, content = filesystem.Read(size, f)
filesystem.Close(f)
return content
end

function file.Exists(name, path)
return filesystem.FileExists(name, path or "DATA")
end

function file.IsDir(name, path)
return filesystem.IsDirectory(name, path or "DATA")
end

function file.CreateDir(name)
filesystem.CreateDirHierarchy(name, "DATA")
end

function file.Delete(name)
return filesystem.RemoveFile(name, "DATA")
end

function file.Rename(old, new)
return filesystem.RenameFile(old, new, "DATA")
end

function file.Size(name)
local f = filesystem.Open(name, "r", "DATA")
if not f then return 0 end
local size = filesystem.Size(f)
filesystem.Close(f)
return size
end

function file.Find(pattern, path, sorting)
return fl.Find(pattern, path, sorting)
end

function ent.Remove(e)
UTIL.Remove(e)
end

concommand.Add("GetLocalPlayer", GetPlayer)

local var = CreateConVar("example_convar", "1", FCVAR_CLIENTDLL, "for example", "0", "1")

hook.Add("Think", "ExampleConVar", function()

  if not var then return end

  print("ConVar now is: " .. var:GetValue())

end)

CreateVConVar("example_vconvar", 0, 0, 255, function(new, old)
    print("ConVar was " .. old .. " now it's " .. new)
end)