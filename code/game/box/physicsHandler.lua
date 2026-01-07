-- ~/code/game/box/physicsHandler.lua

local Module = {}

local BoxDragHandlerModule = require("code.game.box.dragHandler")
local BoxesObjectModule = require("code.game.box.object")

local extra = require("code.engine.extra")

local CONSTANTS = require("code.game.box.constants")

local function applyFriction(box, deltaTime)
    local weightFactor = CONSTANTS.BASE_WEIGHT / box.weight
    local fpsFactor = deltaTime * _G.FPS_SCALE
    box.velocityX = box.velocityX * (1 - CONSTANTS.FRICTION * fpsFactor * weightFactor)
    box.velocityY = box.velocityY * (1 - CONSTANTS.FRICTION * fpsFactor * weightFactor)
end

local function edgeBounceLR(box) -- check for edge bounces on the x axis
    local width = box.element.drawable:getWidth() * box.element.scaleX
    local halfWidth = width * box.element.anchorX

    if box.element.x - halfWidth < 0 then
        box.element.x = halfWidth
        box.velocityX = -box.velocityX * CONSTANTS.ELASTICITY
    elseif box.element.x + width * (1 - box.element.anchorX) > CONSTANTS.AREA_WIDTH then
        box.element.x = CONSTANTS.AREA_WIDTH - width * (1 - box.element.anchorX)
        box.velocityX = -box.velocityX * CONSTANTS.ELASTICITY
    end
end

local function edgeBounceUD(box) -- check for edge bounces on the y axis
    local height = box.element.drawable:getHeight() * box.element.scaleY
    local halfHeight = height * box.element.anchorY

    if box.element.y - halfHeight < 0 then
        box.element.y = halfHeight
        box.velocityY = -box.velocityY * CONSTANTS.ELASTICITY
    elseif box.element.y + height * (1 - box.element.anchorY) > CONSTANTS.AREA_HEIGHT then
        box.element.y = CONSTANTS.AREA_HEIGHT - height * (1 - box.element.anchorY)
        box.velocityY = -box.velocityY * CONSTANTS.ELASTICITY
    end
end

local function dragPhysics(box)
    if box.dragging then
        local mouseX, mouseY = extra.getScaledMousePos()
        box.velocityX = (mouseX - box.element.x) * CONSTANTS.DRAG_VELOCITY_MULTIPLIER
        box.velocityY = (mouseY - box.element.y) * CONSTANTS.DRAG_VELOCITY_MULTIPLIER
    end
end

local function changePosition(box, deltaTime)
    local fpsFactor = deltaTime * _G.FPS_SCALE
    box.element.x = box.element.x + box.velocityX * fpsFactor
    box.element.y = box.element.y + box.velocityY * fpsFactor
end

function Module:update(deltaTime)
    if BoxDragHandlerModule.draggedBox then
        dragPhysics(BoxDragHandlerModule.draggedBox)
    end

    local boxesArray = BoxesObjectModule:getSortedArray()
    for _, box in pairs(boxesArray) do
        if box.merging then goto continue end

        changePosition(box, deltaTime)

        applyFriction(box, deltaTime)

        edgeBounceLR(box)
        edgeBounceUD(box)

        :: continue ::
    end
end

return Module