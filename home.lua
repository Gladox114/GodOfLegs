function initHomeAxis()
    -- get the main axis (x axis or y axis) so the turtle will always try to go the main path and then to the sides regardless where.
    turtle.mainAxis = Goto.getAxis(turtle.startFacing)
    turtle.oppositeMainAxis = Goto.getAxis(dryTurn.left(turtle.startFacing))
end

function isGoingFromHome(position)
    -- compare if the startPosition (aka home) axis and the target position axis are the same.
    -- with this method we can know if we are going to that position or from, which is needed for the Goto library.
    if turtle.startPosition[turtle.oppositeMainAxis] == position[turtle.oppositeMainAxis] then
        --goingFromPosition = true
        return true
    else
        --goingFromPosition = false
        return false
    end
end
