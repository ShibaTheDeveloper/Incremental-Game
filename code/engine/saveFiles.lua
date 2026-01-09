---@diagnostic disable: inject-field
-- ~/code/engine/saveFiles.lua

local UISceneHandlerModule = require("code.game.ui.sceneHandler")
local BoxesObjectModule = require("code.game.box.object")

local SAVE_FILE_TEMPLATE = "slot%d.lua"
local SAVE_SLOTS = 3

local DEFAULT_FILE_DATA = {
    slot = 1,

    highestBoxTier = 1,
    boxSpawnTier = 1,

    playtime = 0,

    money = 0,

    settings = {
        sounds = {
            masterVolume = .5,
            soundVolume = .5,
            musicVolume = .5
        }
    },
    boxes = {}
}

local LUA_KEYWORDS = {
    ["and"]=true, ["break"]=true, ["do"]=true, ["else"]=true,
    ["elseif"]=true, ["end"]=true, ["false"]=true, ["for"]=true,
    ["function"]=true, ["goto"]=true, ["if"]=true, ["in"]=true,
    ["local"]=true, ["nil"]=true, ["not"]=true, ["or"]=true,
    ["repeat"]=true, ["return"]=true, ["then"]=true, ["true"]=true,
    ["until"]=true, ["while"]=true,
}

local Module = {}
Module.loadedFile = {}

-- checks if a string key can be used without quotes
local function isValidIdentifier(key)
    return type(key) == "string"
        and key:match("^[%a_][%w_]*$") -- starts with letter or underscore, only letters/digits/underscore
        and not LUA_KEYWORDS[key]      -- cannot be a lua keyword
end

local function serialize(inputTable, indentLevel)
    indentLevel = indentLevel or 0
    local lines = { "{" }

    for key, rawValue in pairs(inputTable) do
        local serializedKey

        if type(key) == "number" then
            serializedKey = "[" .. key .. "]" -- numeric keys are always wrapped in brackets
        elseif isValidIdentifier(key) then
            serializedKey = key              -- safe to use bare identifier
        else
            serializedKey = "[" .. string.format("%q", key) .. "]" -- quote any other string keys
        end

        local serializedValue
        if type(rawValue) == "table" then
            serializedValue = serialize(rawValue, indentLevel + 2) -- recursive serialization
        elseif type(rawValue) == "string" then
            serializedValue = string.format("%q", rawValue) -- quote strings
        else
            serializedValue = tostring(rawValue) -- numbers, booleans
        end

        -- add the line for this key-value pair with proper indentation
        table.insert(
            lines,
            string.rep(" ", indentLevel + 2)
                .. serializedKey .. " = "
                .. serializedValue
                .. ","
        )
    end

    table.insert(lines, string.rep(" ", indentLevel) .. "}") -- close the table
    return table.concat(lines, "\n")
end

local function deepCopy(tbl)
    local copy = {}

    for index, value in pairs(tbl) do
        if type(value) == "table" then
            copy[index] = deepCopy(value)
        else
            copy[index] = value
        end
    end

    return copy
end

function Module.saveFile(slot)
    Module.loadedFile.boxes = {}

    local highestTier = 1
    for _, box in pairs(BoxesObjectModule:getSortedArray()) do
        table.insert(Module.loadedFile.boxes, {
            velocityX = box.velocityX,
            velocityY = box.velocityY,

            rotation = box.element.rotation,
            x = box.element.x,
            y = box.element.y,
            tier = box.tier
        })

        if box.tier > highestTier then highestTier = box.tier end
    end

    Module.loadedFile.highestBoxTier = highestTier

    local path = string.format(SAVE_FILE_TEMPLATE, slot)
    local data = "return " .. serialize(Module.loadedFile)

    love.filesystem.write(path, data)
end

function Module.deleteFile(slot)
    local path = string.format(SAVE_FILE_TEMPLATE, slot)

    if love.filesystem.getInfo(path) then
        love.filesystem.remove(path)
    end
end

function Module.loadFile(slot)
    local path = string.format(SAVE_FILE_TEMPLATE, slot)

    if love.filesystem.getInfo(path) then
        local chunk = love.filesystem.load(path)
        Module.loadedFile = chunk()
        Module.loadedFile.slot = slot
    else
        Module.loadedFile = deepCopy(DEFAULT_FILE_DATA)
        Module.loadedFile.slot = slot

        Module.saveFile(slot)
    end

    for _, savedBoxData in pairs(Module.loadedFile.boxes) do
        local data = BoxesObjectModule:getBoxDataByTier(savedBoxData.tier)
        local box = BoxesObjectModule:createBox(data)

        if box then
            box.velocityX = savedBoxData.velocityX
            box.velocityY = savedBoxData.velocityY
            box.element.x = savedBoxData.x
            box.element.y = savedBoxData.y
            box.element.rotation = savedBoxData.rotation
        end
    end

    return Module.loadedFile
end

function Module.getAllSaveFiles()
    local saves = {}

    for slot = 1, SAVE_SLOTS do
        local path = string.format(SAVE_FILE_TEMPLATE, slot)

        if love.filesystem.getInfo(path) then
            local chunk = love.filesystem.load(path)
            local data = chunk()
            data.slot = slot
            saves[slot] = data
        else
            local data = deepCopy(DEFAULT_FILE_DATA)
            data.slot = slot
            saves[slot] = data
        end
    end

    local ordered = {}
    for slot = 1, SAVE_SLOTS do
        ordered[#ordered + 1] = saves[slot]
    end

    return ordered
end

function Module.quit()
    if UISceneHandlerModule.currentScene.name == "game" then
        Module.saveFile(Module.loadedFile.slot)
    end
end

function Module:update(deltaTime)
    if not Module.loadedFile then return end
    if Module.loadedFile.playtime == nil then return end

    Module.loadedFile.playtime = Module.loadedFile.playtime + deltaTime
end

function Module.init()
    for slot = 1, SAVE_SLOTS do
        local path = string.format(SAVE_FILE_TEMPLATE, slot)

        if not love.filesystem.getInfo(path) then
            local data = deepCopy(DEFAULT_FILE_DATA)
            data.slot = slot

            local serialized = "return " .. serialize(data)
            love.filesystem.write(path, serialized)
        end
    end
end

return Module