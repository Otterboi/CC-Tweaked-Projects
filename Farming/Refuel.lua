Refuel = {}

local stack_size = 64

-- find # of fuel in inventory 
-- keep looping until enough fuel
function Refuel.check_fuel(config_manager)
    local attempts = 10

    turtle.back()
    turtle.turnLeft()
    turtle.select(1)

    while turtle.getFuelLevel() < config_manager:get_total_farm_size() * 2 and attempts ~= 0 do
        turtle.refuel()
        turtle.suck(stack_size)
        attempts = attempts - 1
    end

    turtle.turnRight()
end

return Refuel