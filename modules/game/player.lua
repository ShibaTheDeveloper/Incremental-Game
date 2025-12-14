local AnimateModule = require("modules.internal.animate")
local RenderModule = require("modules.internal.render")
local ItemModule = require("modules.game.item")

local Module = {}

function Module.init()
    ItemModule:createItem("modules/data/items/wooden_pickaxe.lua"):equip()
end

function Module:step(deltaTime)
    local item = ItemModule.equippedItem
    if not item then return end

    local element = item.element
    if not element then return end

    local mouseX, mouseY = RenderModule:physicalToVirtual(love.mouse.getPosition())
    local deltaX = mouseX - element.x

    if element.x == 0 and element.y == 0 then
        element.x = mouseX; element.y = mouseY
        return
    end

    local holding = love.mouse.isDown(1)

    if not holding and not item.using or item.type ~= "useable" then
        element.x = AnimateModule.lerpNum(element.x, mouseX, 0.02); element.y = AnimateModule.lerpNum(element.y, mouseY, 0.02)
        element.rotation = AnimateModule.lerpNum(element.rotation, deltaX / 4, 0.01)
    end

    item:step(deltaTime)
end

function Module:mouseClick()
    local item = ItemModule.equippedItem
    if not item then return end

    item:use()
end

return Module