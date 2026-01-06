local BoxesObjectModule = require("modules.game.box.object")
local AnimateModule = require("modules.engine.animate")

local EasingData = require("modules.data.easing")

local Module = {}

function Module:update(deltaTime)
    for _, box in pairs(BoxesObjectModule.boxes) do
        local tween = box._scaleTween
        if tween then
            tween.timeSinceStart = tween.timeSinceStart + deltaTime

            local timerLocalized = math.min(tween.timeSinceStart / tween.duration, 1)
            local lerpFactor = EasingData.easeOutQuad(timerLocalized)

            box.element.scaleX = AnimateModule.lerp(tween.startX, tween.targetX, lerpFactor)
            box.element.scaleY = AnimateModule.lerp(tween.startY, tween.targetY, lerpFactor)

            if timerLocalized >= 1 then
                box._scaleTween = nil
            end
        end
    end
end

return Module