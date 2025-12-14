local Module = {}

function Module.lerpNum(a, b, lerpFactor)
    return a + (b - a) * lerpFactor
end

return Module