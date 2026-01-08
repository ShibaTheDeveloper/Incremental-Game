-- ~/code/game/box/dragHandler.lua

local BoxesObjectModule = require("code.game.box.object")

local RenderModule = require("code.engine.render")

local CONSTANTS = require("code.game.box.constants")

local Module = {}
Module._wasMouseDown = false
Module.draggedBox = nil

local lastDraggedBoxAlpha = 0

function Module:update()
    local mouseDown = love.mouse.isDown(1)
    local mouseX, mouseY = RenderModule:getMousePos()

    if mouseDown and not self.draggedBox then
        local boxesArray = BoxesObjectModule:getSortedArray()
        local success = false

        for _, box in pairs(boxesArray) do
            box.element.zIndex = CONSTANTS.BASE_BOX_ZINDEX

            if not box.element:isPointInside(mouseX, mouseY) then goto continue end

            success = true

            self.draggedBox = box
            self.draggedBox.dragging = true

            lastDraggedBoxAlpha = self.draggedBox.element.color.alpha
            self.draggedBox.element.color.alpha = CONSTANTS.DRAGGED_BOX_ALPHA

            self.draggedBox.element.zIndex = CONSTANTS.BASE_BOX_ZINDEX + 2

            if success then break end
            :: continue ::
        end
    elseif not mouseDown and self.draggedBox then
        self.draggedBox.element.color.alpha = lastDraggedBoxAlpha
        self.draggedBox.element.zIndex = CONSTANTS.BASE_BOX_ZINDEX + 1

        self.draggedBox.dragging = false
        self.draggedBox = nil
    end

    self._wasMouseDown = mouseDown
end

return Module