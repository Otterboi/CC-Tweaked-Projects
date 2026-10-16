Refuel = {}

local stack_size = 64

function Refuel.check_fuel(config_manager)
    local attempts = 10

    if turtle.getFuelLevel() <= config_manager:get_total_farm_size() * 2 then
        turtle.turnLeft()
        turtle.select(1)

        while turtle.getFuelLevel() <= config_manager:get_total_farm_size() * 2 and attempts ~= 0 do
            turtle.refuel()
            turtle.suck(stack_size)
            attempts = attempts - 1
        end

        turtle.turnRight()
    end
end

return Refuel