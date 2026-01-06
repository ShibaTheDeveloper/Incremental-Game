local BoxesObjectModule = require("modules.game.box.object")
local extra = require("modules.engine.extra")

local CONSTANTS = require("modules.game.box.constants")

local Module = {}

local function applyFriction(box, deltaTime)
    local weightFactor = CONSTANTS.BASE_WEIGHT / box.weight
    box.velocityX = box.velocityX * (1 - CONSTANTS.FRICTION * deltaTime * weightFactor)
    box.velocityY = box.velocityY * (1 - CONSTANTS.FRICTION * deltaTime * weightFactor)
end

local function edgeBounceLR(box)
    local width = box.element.drawable:getWidth() * box.element.scaleX
    local halfWidth = width * box.element.anchorX

    if box.element.x - halfWidth < 0 then
        box.element.x = halfWidth
        box.velocityX = -box.velocityX * CONSTANTS.ELASTICITY
    elseif box.element.x + width * (1 - box.element.anchorX) > _G.WINDOW_WIDTH then
        box.element.x = _G.WINDOW_WIDTH - width * (1 - box.element.anchorX)
        box.velocityX = -box.velocityX * CONSTANTS.ELASTICITY
    end
end

local function edgeBounceUD(box)
    local height = box.element.drawable:getHeight() * box.element.scaleY
    local halfHeight = height * box.element.anchorY

    if box.element.y - halfHeight < 0 then
        box.element.y = halfHeight
        box.velocityY = -box.velocityY * CONSTANTS.ELASTICITY
    elseif box.element.y + height * (1 - box.element.anchorY) > _G.WINDOW_HEIGHT then
        box.element.y = _G.WINDOW_HEIGHT - height * (1 - box.element.anchorY)
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
    box.element.x = box.element.x + box.velocityX * deltaTime
    box.element.y = box.element.y + box.velocityY * deltaTime
end

function Module:update(deltaTime)
    for _, box in pairs(BoxesObjectModule.boxes) do
        if box.merging then goto continue end

        dragPhysics(box)

        changePosition(box, deltaTime)

        applyFriction(box, deltaTime)

        edgeBounceLR(box)
        edgeBounceUD(box)

        ::continue::
    end
end

return Module