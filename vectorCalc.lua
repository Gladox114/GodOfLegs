-- vector = {}

-- Returns a vector from a string --
------------------------------------
-- sources that helped --
-- https://stackoverflow.com/questions/19262761/lua-need-to-split-at-comma
-------------------------
function vector.stringToVector(vectorString)
    if vectorString then
        return vector.new(string.gmatch(vectorString, "([^,]+),([^,]+),([^,]+)")())
    end
end

-- Returns the distance between two vectors --
----------------------------------------------
-- sources that helped --
-- https://www.varsitytutors.com/calculus_3-help/distance-between-vectors
-- http://www.computercraft.info/wiki/VectorA:length
-------------------------
function vector.calculateDistance(vector1, vector2)
    vector3 = vector1 - vector2 -- subtract each other
    distance = vector3:length() -- the squareroot of summed up squared coordinates | squareroot(x²+y²+z²)
    return distance
end

-- The list has a string name indexed with the position.
-- That index contains an another index if it's used and "ore" is either true or false
-- mapping.mappedOre = {
--                      "2,2,2" = {ore = true},
--                      "2,3,2" = {ore = false}
--                     }
-- by the time it get's calculated it can also contain "distance" which should be temporary

-- Calculates from the current position to all vectors in the list the distance and
-- inserts the distance into all position's own index under the variable "distance"
function vector.getDistancetoAll(vectorList)
    for position_string, position_data in pairs(vectorList) do
        vectorList[position_string].distance = vector.calculateDistance(turtle.location,
            vector.stringToVector(position_string))
    end
end

--                            table
function vector.getTheLowest(vectorList)
    local lowestValue = math.huge
    local lowestIndex
    for position_string, position_data in pairs(vectorList) do
        if position_data.distance < lowestValue then
            lowestIndex = position_string
            lowestValue = position_data.distance
        end
    end
    return lowestIndex
end

cachedVectorFacing = {
    --          x,y,z
    vector.new(-1, 0, 0), -- ore is from your position facing to -x
    vector.new(0, 0, -1), -- block is facing -z
    vector.new(1, 0, 0), -- block is facing +x
    vector.new(0, 0, 1), -- +z

    vector.new(0, 1, 0), -- +y
    vector.new(0, -1, 0) -- -y
}

vectorFacing = {
    --          x,y,z
    function(i) return vector.new(-i, 0, 0) end, -- ore is from your position facing to -x
    function(i) return vector.new(0, 0, -i) end, -- block is facing -z
    function(i) return vector.new(i, 0, 0) end, -- block is facing +x
    function(i) return vector.new(0, 0, i) end, -- +z

    function(i) return vector.new(0, i, 0) end, -- +y
    function(i) return vector.new(0, -i, 0) end -- -y
}

dryTurn = {
    left = function(dryFacing)
        dryFacing = dryFacing - 1
        if dryFacing < 1 then dryFacing = 4 end
        return dryFacing
    end,
    right = function(dryFacing)
        dryFacing = dryFacing + 1
        if dryFacing > 4 then dryFacing = 1 end
        return dryFacing
    end,
    back = function(dryFacing)
        dryFacing = dryFacing + 1
        if dryFacing > 4 then dryFacing = 1 end
        dryFacing = dryFacing + 1
        if dryFacing > 4 then dryFacing = 1 end
        return dryFacing
    end
}

getBlockPos = {
    main = function(facing) -- saving some bytes | I'm actually lazy to write it into each function
        return turtle.location + cachedVectorFacing[facing]
    end,

    forward = function() return getBlockPos.main(turtle.facing) end,
    left = function() return getBlockPos.main(getBlockPos.dryTurn.left(turtle.facing)) end,
    right = function() return getBlockPos.main(getBlockPos.dryTurn.right(turtle.facing)) end,
    back = function() return getBlockPos.main(getBlockPos.dryTurn.left(getBlockPos.dryTurn.left(turtle.facing))) end,

    up = function() return turtle.location + cachedVectorFacing[5] end,
    down = function() return turtle.location + cachedVectorFacing[6] end
}
