local BoxPhysicsHandlerModule = require("modules.game.box.physicsHandler")
local BoxMergeManagerModule = require("modules.game.box.mergeManager")
local BoxScaleTweenModule = require("modules.game.box.scaleTween")
local BoxSpawnerModule = require("modules.game.box.spawner")

local Module = {}

function Module:update(deltaTime)
    BoxPhysicsHandlerModule:update(deltaTime)
    BoxMergeManagerModule:update(deltaTime)
    BoxScaleTweenModule:update(deltaTime)
    BoxSpawnerModule:update()
 end

return Module