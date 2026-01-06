local BoxesObjectModule = require("modules.game.box.object")
local extra = require("modules.engine.extra")

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
    return extra.clamp(math.floor(getHighestTier() / 10) + 1, 1, math.huge)
end

function Module:update()
    if (os.clock() - self.timeSinceLastSpawn) >= self.spawnInterval then
        self.timeSinceLastSpawn = os.clock()

        local tier = getSpawnedBoxTier()
        BoxesObjectModule:createBox(tier, math.random(0, _G.windowWidth), math.random(0, _G.windowHeight))
    end
end

return Module