--- Copyright © 2026, YourLocalCappy, all rights deserved ---

local table = _G.table or table or require("table") or {}
local insert = table.insert
local copy   = table.copy
local keys   = table.GetKeys
local pairs  = pairs

module("list", package.seeall)

local function shallow_copy(t)
    local new = {}
    for k, v in pairs(t) do
        new[k] = v
    end
    return new
end

local function get_keys(t)
    local out = {}
    for k in pairs(t) do
        out[#out + 1] = k
    end
    return out
end

local Registry = {}

local function Fetch(id, create)
    local bucket = Registry[id]

    if not bucket and create ~= false then
        bucket = {}
        Registry[id] = bucket
    end

    return bucket
end

function Snapshot(id)
    local bucket = Fetch(id, false)
    if not bucket then return nil end

    return shallow_copy(bucket)
end

function Raw(id)
    return Fetch(id, false)
end

function Write(id, key, value)
    if key == nil then
        error("list.Write: key is nil (id = " .. tostring(id) .. ")")
        return
    end

    local bucket = Fetch(id)
    bucket[key] = value
end

function Set(id, key, value)
    Write(id, key, value)
end

function Push(id, value)
    return insert(Fetch(id), value)
end

function Remove(id, key)
    local bucket = Fetch(id, false)
    if not bucket then return false end

    if bucket[key] ~= nil then
        bucket[key] = nil
        return true
    end

    return false
end

function Wipe(id)
    if Registry[id] then
        Registry[id] = {}
        return true
    end

    return false
end

function HasValue(id, value)
    local bucket = Fetch(id, false)
    if not bucket then return false end

    for i = 1, #bucket do
        if bucket[i] == value then
            return true
        end
    end

    for _, v in pairs(bucket) do
        if v == value then
            return true
        end
    end

    return false
end

function HasKey(id, key)
    local bucket = Fetch(id, false)
    return bucket and bucket[key] ~= nil or false
end

function IDs()
    return get_keys(Registry)
end

function Count(id)
    if not id then return nil end

    local bucket = Fetch(id, false)
    if not bucket then return 0 end

    local c = 0
    for _ in pairs(bucket) do
        c = c + 1
    end

    return c
end

--- COMPAT LAYER ---

local function ensure(id)
    if not list.Raw(id) then
        list.Write(id, "__init", true)
        list.Remove(id, "__init")
    end
    return list.Raw(id)
end

function list.Get(listid)
    local bucket = list.Raw(listid)
    if not bucket then return {} end
    return bucket
end

function list.GetForEdit(listid, nocreate)
    local bucket = list.Raw(listid)

    if not bucket and nocreate then
        return nil
    end

    return ensure(listid)
end

function list.GetTable()
    return list.IDs()
end

function list.Set(listid, key, value)
    list.Write(listid, key, value)
end

function list.Add(listid, value)
    return list.Push(listid, value)
end

function list.Contains(listid, value)
    local bucket = list.Raw(listid)
    if not bucket then return false end

    for _, v in pairs(bucket) do
        if v == value then
            return true
        end
    end

    return false
end

function list.HasEntry(listid, key)
    return list.HasKey(listid, key)
end