local MovementActions = {}

function MovementActions.harvest(crop_age, max_age)
    if crop_age == max_age then
        turtle.digDown()
        turtle.select(2)
        turtle.placeDown()
        turtle.select(1)
    end
end

return MovementActions