-- ~/code/game/box/handler.lua

local BoxRotationHandlerModule = require("code.game.box.rotationHandler")
local BoxPhysicsHandlerModule = require("code.game.box.physicsHandler")
local BoxMergeManagerModule = require("code.game.box.mergeManager")
local BoxDragHandlerModule = require("code.game.box.dragHandler")
local BoxScaleTweenModule = require("code.game.box.scaleTween")
local BoxesObjectModule = require("code.game.box.object")

local Module = {}

function Module:update(deltaTime)
    BoxPhysicsHandlerModule:update(deltaTime)
    BoxMergeManagerModule:update(deltaTime)
    BoxScaleTweenModule:update(deltaTime)
    BoxesObjectModule:update(deltaTime)
    BoxRotationHandlerModule:update()
    BoxDragHandlerModule:update()
 end

return Module