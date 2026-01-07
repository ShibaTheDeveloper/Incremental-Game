-- ~/code/game/box/mergeManager.lua

local ScreenFlashModule = require("code.game.vfx.screenFlash")
local BoxesObjectModule = require("code.game.box.object")
local SoundModule = require("code.engine.sound")
local extra = require("code.engine.extra")

local EasingData = require("code.data.easing")
local BoxesData = require("code.data.boxes")

local CONSTANTS = require("code.game.box.constants")

local Module = {}
Module._activeMerges = {}

function Module:merge(boxA, boxB)
    if boxA.dragging or boxB.dragging then return end
    if boxA.merging or boxB.merging then return end

    if #BoxesData < (boxA.tier + 1) then return end
    if boxA.tier ~= boxB.tier then return end

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

    local duration = (distance / CONSTANTS.BASE_MERGE_SPEED) * (1 + averageWeight / CONSTANTS.WEIGHT_ANIM_DURATION_DIVISOR)
    duration = duration / (1 + velocityMagnitude / CONSTANTS.VELOCITY_MERGE_DURATION_FACTOR)

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
        if not merge then goto continue end

        merge.timeSinceStart = merge.timeSinceStart + deltaTime

        if merge.boxA.dragging or merge.boxB.dragging then
            merge.boxA.merging = false
            merge.boxB.merging = false

            self._activeMerges[i] = nil

            goto continue
        end

        local timerLocalized = math.min(merge.timeSinceStart / merge.duration, 1)
        local eased = EasingData.easeInQuad(timerLocalized)

        merge.boxA.element.x = extra.lerp(merge.startAX, merge.middleX, eased)
        merge.boxA.element.y = extra.lerp(merge.startAY, merge.middleY, eased)
        merge.boxB.element.x = extra.lerp(merge.startBX, merge.middleX, eased)
        merge.boxB.element.y = extra.lerp(merge.startBY, merge.middleY, eased)

        if timerLocalized >= 1 then
            merge.boxA:remove()
            merge.boxB:remove()

            local newBoxTier = merge.boxA.tier + 1
            local newBoxData = BoxesObjectModule:getBoxDataByTier(newBoxTier, merge.middleX, merge.middleY)
            local newBox = BoxesObjectModule:createBox(newBoxData)

            if newBox then
                newBox.velocityX = (merge.boxA.velocityX + merge.boxB.velocityX) * CONSTANTS.ELASTICITY
                newBox.velocityY = (merge.boxA.velocityY + merge.boxB.velocityY) * CONSTANTS.ELASTICITY

                newBox._scaleTween = {
                    startX = merge.boxA.element.scaleX,
                    startY = merge.boxA.element.scaleY,
                    targetX = newBox.element.scaleX,
                    targetY = newBox.element.scaleY,
                    timeSinceStart = 0,
                    duration = CONSTANTS.BASE_SCALE_TWEEN_DURATION * (1 + newBox.weight / CONSTANTS.WEIGHT_ANIM_DURATION_DIVISOR)
                }

                newBox.element.scaleX = merge.boxA.element.scaleX
                newBox.element.scaleY = merge.boxA.element.scaleY

                local mergeSound = SoundModule:createSound(newBox.mergeSoundData)

                if mergeSound then
                    mergeSound:play()
                    mergeSound:remove()
                end

                if newBox.flashScreen then
                    ScreenFlashModule:flash(newBox.screenFlashColor)
                end
            end

            table.remove(self._activeMerges, i)
        end

        :: continue ::
    end
end

function Module:checkMerges()
    --%note TODO: optimize this with quadtrees
    local boxesArray = BoxesObjectModule:getSortedArray()

    for _, boxA in pairs(boxesArray) do
        if boxA.merging then goto continue end

        for _, boxB in pairs(boxesArray) do
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