-- ~/code/engine/extra.lua

local Module = {}

function Module.clamp(x, min, max)
    x = (x > max and max or x)
    x = (x < min and min or x)

    return x
end

function Module.cloneTable(table)
    local newTable = {}

   for index, value in pairs(table) do
        newTable[index] = value
    end

    return newTable
end

function Module.lerp(a, b, lerpFactor)
    return a + (b - a) * lerpFactor
end

return Module