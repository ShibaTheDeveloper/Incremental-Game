-- ~/code/game/box/object.lua

local IdManagerModule = require("code.engine.idManager")
local RenderModule = require("code.engine.render")
local BoxesData = require("code.data.boxes")
local extra = require("code.engine.extra")

local manager = IdManagerModule:createManager()

local CONSTANTS = require("code.game.box.constants")

local Box = {
    id = 0,
    element = nil,

    dragging = false,
    merging = false,

    description = "",
    quote = "",
    name = "",

    screenFlashColor = nil,
    screenFlashFadeDuration = 2,
    flashScreen = false,

    reflectionPath = "",
    reflective = false,

    weight = 0,
    tier = 1,

    velocityX = 0,
    velocityY = 0,
}
Box.__index = Box

local Module = {}
Module.boxes = {}

function Box:remove()
    local id = self.id

    Module.boxes[id] = nil
    manager:release(id)

    self.element:remove()
end

function Module:getBoxDataByTier(tier)
    local data = BoxesData[tier]
    if not BoxesData[tier] then return end

    local clonedData = extra.cloneTable(data)
    return clonedData
end

function Module:createBox(data)
    if not data then return end

    local element = RenderModule:createElement({
        x = data.x or 0,
        y = data.y or 0,
        spritePath = data.spritePath,
        type = "sprite",
        scaleX = data.scale,
        scaleY = data.scale,
        zIndex = CONSTANTS.BASE_BOX_ZINDEX,
        reflective = data.reflective,
        reflectionPath = data.reflectionPath
    })

    local box = setmetatable({
        id = manager:get(),
        element = element,

        dragging = false,
        merging = false,

        description = data.description,
        quote = data.quote,
        name = data.name,

        screenFlashColor = data.screenFlashColor or nil,
        screenFlashFadeDuration = data.screenFlashFadeDuration or 2,
        flashScreen = data.flashScreen or false,

        mergeSoundData = data.mergeSoundData or {soundPath = "assets/sounds/merge/default.wav"},

        weight = data.weight,
        tier = data.tier,

        velocityX = 0,
        velocityY = 0,
    }, Box)

    self.boxes[box.id] = box

    box._scaleTween = {
        startX = data.scale * CONSTANTS.SPAWN_SCALE_MULTIPLIER,
        startY = data.scale * CONSTANTS.SPAWN_SCALE_MULTIPLIER,
        targetX = data.scale,
        targetY = data.scale,
        timeSinceStart = 0,
        duration = CONSTANTS.BASE_SCALE_TWEEN_DURATION
    }

    return box
end

function Module:getSortedArray()
    local array = {}

    for _, box in pairs(self.boxes) do
        table.insert(array, box)
    end

    table.sort(array, function(a, b)
        return a.element.zIndex > b.element.zIndex
    end)

    return array
end

function Module:clearBoxes()
    for _, box in pairs(self:getSortedArray()) do
        box:remove()
    end
end

return Module