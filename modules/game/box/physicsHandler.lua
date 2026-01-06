local BoxesObjectModule = require("modules.game.box.object")
local CONSTANTS = require("modules.game.box.constants")

local Module = {}

function Module:update(deltaTime)
    for index, box in pairs(BoxesObjectModule.boxes) do
        if box.merging then goto continue end

        box.velocityX = box.velocityX * (1 - CONSTANTS.FRICTION * deltaTime)
        box.velocityY = box.velocityY * (1 - CONSTANTS.FRICTION * deltaTime)

        box.element.x = box.element.x + box.velocityX * deltaTime
        box.element.y = box.element.y + box.velocityY * deltaTime

        ::continue::
    end
end

return Module