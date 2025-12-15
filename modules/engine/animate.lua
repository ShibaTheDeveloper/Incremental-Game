local Module = {}

function Module.lerp(a, b, lerpFactor)
    return a + (b - a) * lerpFactor
end

return Module