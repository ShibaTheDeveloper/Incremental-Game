local AnimateModule = require("modules.internal.animate")
local RenderModule = require("modules.internal.render")

local Module = {}
Module.equippedItem = nil
Module._items = {}

local Item = {
    name = "Template",
    element = nil,

    data = {},

    using = false,

    lastUseTime = 0,
    count = 1,
}
Item.__index = Item

function Item:remove()
    if self.count > 1 then
        self.count = self.count - 1
        return
    end

    for index, value in ipairs(Item._items) do
        if value == self then
            table.remove(Item._items, index)
            break
        end
    end

    if self.element then
        self.element:remove()
        self.element = nil
    end
end

function Item:equip()
    if Module.equippedItem and Module.equippedItem ~= self then Module.equippedItem:unEquip() end

    self.element.color.alpha = 1
    Module.equippedItem = self
end

function Item:unEquip()
    self.element.color.alpha = 0
    self.element.x = 0
    self.element.y = 0
end

function Item:use()
    if Module.equippedItem ~= self then return end
    if self.type ~= "useable" then return end
    if os.clock() - self.lastUseTime <= self.data.swingCooldown then return end
    if self.using then return end

    self.lastUseTime = os.clock()

    self.animationTimer = 0
    self.using = true
end

function Item:step(deltaTime)
    if not self.using or not self.element then return end

    self.animationTimer = self.animationTimer + deltaTime
    local time = math.min(self.animationTimer / self.data.swingSpeed, 1)

    local animation = self.useAnimation
    local currentKeyframe, nextKeyframe

    for i = 1, #animation - 1 do
        if time >= animation[i].setTime and time <= animation[i + 1].setTime then
            currentKeyframe = animation[i]
            nextKeyframe = animation[i + 1]
            break
        end
    end

    if not currentKeyframe or not nextKeyframe then
        currentKeyframe = animation[#animation - 1]
        nextKeyframe = animation[#animation]
    end

    local timeDifference = nextKeyframe.setTime - currentKeyframe.setTime
    local lerpFactor = 0
    if timeDifference > 0 then
        lerpFactor = (time - currentKeyframe.setTime) / timeDifference
    end

    self.element.rotation = AnimateModule.lerpNum(currentKeyframe.rotation, nextKeyframe.rotation, lerpFactor)
    self.element.offsetX = AnimateModule.lerpNum(currentKeyframe.x, nextKeyframe.x, lerpFactor)
    self.element.offsetY = AnimateModule.lerpNum(currentKeyframe.y, nextKeyframe.y, lerpFactor)

    if time >= 1 then
        self.animationTimer = 0
        self.using = false
    end
end

function Module:createItem(path)
    local exists = love.filesystem.getInfo(path)
    if not exists then return end

    for _, existingItem in ipairs(Module._items) do
        if existingItem.path == path then
            existingItem.count = existingItem.count + 1
            return existingItem
        end
    end

    local requirePath = path:gsub("/", "."):gsub("%.lua$", "")
    local data = require(requirePath)

    local item = setmetatable(data or {}, Item)
    item.path = path
    table.insert(Module._items, item)

    item.lastUseTime = -999
    item.count = 1

    local element = RenderModule:createElement("sprite", {spritePath = item.spritePath})
    item.element = element
    item:unEquip()

    return item
end

return Module