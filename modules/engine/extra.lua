return {
    clamp = function(x, min, max)
        x = (x > max and max or x)
        x = (x < min and min or x)

        return x
    end,

    cloneTable = function(table)
        local newTable = {}

        for index, value in pairs(table) do
            newTable[index] = value
        end

        return newTable
    end
}