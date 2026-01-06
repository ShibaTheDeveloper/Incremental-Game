local BoxesObjectModule = require("modules.game.box.object")
local AnimateModule = require("modules.engine.animate")

local EasingData = require("modules.data.easing")
local BoxesData = require("modules.data.boxes")

local CONSTANTS = require("modules.game.box.constants")

local Module = {}
Module._activeMerges = {}

function Module:merge(boxA, boxB)
    if boxA.dragging or boxB.dragging then return end
    if boxA.merging or boxB.merging then return end
    if boxA.tier ~= boxB.tier then return end

    if #BoxesData < (boxA.tier + 1) then return end

    boxA.merging = true
    boxB.merging = true

    local startAX, startAY = boxA.element.x, boxA.element.y
    local startBX, startBY = boxB.element.x, boxB.element.y

    local middleX = (startAX + startBX) / 2
    local middleY = (startAY + startBY) / 2

    local dx = middleX - startAX
    local dy = middleY - startAY
    local distance = math.sqrt(dx * dx + dy * dy)

    local averageWeight = (boxA.weight + boxB.weight) / 2
    local velocityMagnitude = math.sqrt(boxA.velocityX^2 + boxA.velocityY^2 + boxB.velocityX^2 + boxB.velocityY^2) / 2

    local duration = (distance / CONSTANTS.BASE_MERGE_SPEED) * (1 + averageWeight / CONSTANTS.WEIGHT_DURATION_DIVISOR)
    duration = duration / (1 + velocityMagnitude / CONSTANTS.VELOCITY_SPEED_FACTOR)

    table.insert(self._activeMerges, {
        boxA = boxA,
        boxB = boxB,

        startAX = startAX,
        startAY = startAY,
        startBX = startBX,
        startBY = startBY,

        middleX = middleX,
        middleY = middleY,

        timeSinceStart = 0,
        duration = duration
    })
end

function Module:mergeUpdate(deltaTime)
    for i = #self._activeMerges, 1, -1 do
        local merge = self._activeMerges[i]
        merge.timeSinceStart = merge.timeSinceStart + deltaTime

        local t = math.min(merge.timeSinceStart / merge.duration, 1)
        local eased = EasingData.easeInQuad(t)

        merge.boxA.element.x = AnimateModule.lerp(merge.startAX, merge.middleX, eased)
        merge.boxA.element.y = AnimateModule.lerp(merge.startAY, merge.middleY, eased)
        merge.boxB.element.x = AnimateModule.lerp(merge.startBX, merge.middleX, eased)
        merge.boxB.element.y = AnimateModule.lerp(merge.startBY, merge.middleY, eased)

        if t >= 1 then
            merge.boxA:remove()
            merge.boxB:remove()

            local newTier = merge.boxA.tier + 1
            local newBox = BoxesObjectModule:createBox(newTier, merge.middleX, merge.middleY)

            if newBox then
                newBox.velocityX = (merge.boxA.velocityX + merge.boxB.velocityX) / 2
                newBox.velocityY = (merge.boxA.velocityY + merge.boxB.velocityY) / 2

                newBox._scaleTween = {
                    startX = merge.boxA.element.scaleX,
                    startY = merge.boxA.element.scaleY,
                    targetX = newBox.element.scaleX,
                    targetY = newBox.element.scaleY,
                    timeSinceStart = 0,
                    duration = CONSTANTS.BASE_SCALE_TWEEN_DURATION * (1 + newBox.weight / CONSTANTS.WEIGHT_DURATION_DIVISOR)
                }

                newBox.element.scaleX = merge.boxA.element.scaleX
                newBox.element.scaleY = merge.boxA.element.scaleY
            end

            table.remove(self._activeMerges, i)
        end
    end
end

function Module:checkMerges()
    for _, boxA in pairs(BoxesObjectModule.boxes) do
        if boxA.merging then goto continue end

        for _, boxB in pairs(BoxesObjectModule.boxes) do
            if boxA.merging or boxB.merging then goto continue end
            if boxA.tier ~= boxB.tier then goto continue end
            if boxA == boxB then goto continue end

            local distanceX = boxA.element.x - boxB.element.x
            local distanceY = boxA.element.y - boxB.element.y
            local distance = math.sqrt(distanceX^2 + distanceY^2)

            if distance > CONSTANTS.BASE_MERGE_RANGE then goto continue end

            self:merge(boxA, boxB)

            :: continue ::
        end

        :: continue ::
    end
end

function Module:update(deltaTime)
    self:mergeUpdate(deltaTime)
    self:checkMerges()
end

return Module