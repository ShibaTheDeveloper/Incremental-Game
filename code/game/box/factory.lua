-- ~/code/game/box/factory.lua

local BoxesObjectModule = require("code.game.box.object")

local SaveFilesModule = require("code.engine.saveFiles")
local CONSTANTS = require("code.game.box.constants")

local Module = {}

function Module:spawn()
    local x = math.random(-CONSTANTS.AREA_WIDTH, CONSTANTS.AREA_WIDTH)
    local y = math.random(-CONSTANTS.AREA_HEIGHT, CONSTANTS.AREA_HEIGHT)

    local spawnTier = 1

    if SaveFilesModule.loadedFile.boxSpawnTier then
        spawnTier = SaveFilesModule.loadedFile.boxSpawnTier
    end

    local data = BoxesObjectModule:getBoxDataByTier(spawnTier)
    local box = BoxesObjectModule:createBox(data)

    if box then
        box.element.x, box.element.y = x, y
    end

    local velocityX = math.random(CONSTANTS.MIN_SPAWN_VELOCITY, CONSTANTS.MAX_SPAWN_VELOCITY)
    local velocityY = math.random(CONSTANTS.MIN_SPAWN_VELOCITY, CONSTANTS.MAX_SPAWN_VELOCITY)

    box.velocityX = velocityX
    box.velocityY = velocityY
end

return Module