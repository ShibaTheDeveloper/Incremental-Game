local BoxesObjectModule = require("modules.game.box.object")
local extra = require("modules.engine.extra")

local CONSTANTS = require("modules.game.box.constants")

local Module = {}

Module.timeSinceLastSpawn = 0
Module.spawnInterval = 1

local function getHighestTier()
	local highestTier = 1

	for _, box in pairs(BoxesObjectModule.boxes) do
		if box.tier > highestTier then highestTier = box.tier end
	end

	return highestTier
end

local function getSpawnedBoxTier()
    return extra.clamp(math.floor(getHighestTier() / CONSTANTS.SPAWN_TIER_SCALING_DIVISOR) + 1, 1, math.huge)
end

function Module:update()
    if (os.clock() - self.timeSinceLastSpawn) >= self.spawnInterval then
        self.timeSinceLastSpawn = os.clock()

        local spawnTier = getSpawnedBoxTier()
        local box = BoxesObjectModule:createBox(spawnTier, math.random(0, CONSTANTS.AREA_WIDTH), math.random(0, CONSTANTS.AREA_HEIGHT))
        box.velocityX = math.random(-1, 1)
        box.velocityY = math.random(-1, 1)
    end
end

return Module