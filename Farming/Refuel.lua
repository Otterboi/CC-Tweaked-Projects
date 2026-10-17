Refuel = {}

local stack_size = 64

function Refuel.check_fuel(config_manager)
    local attempts = 10
    local is_refueled = false

    if turtle.getFuelLevel() <= config_manager:get_total_farm_size() * 2 then
        turtle.turnLeft()
        turtle.select(1)

        while turtle.getFuelLevel() <= config_manager:get_total_farm_size() * 2 and attempts ~= 0 do
            is_refueled = turtle.refuel()
            turtle.suck(stack_size)
            
            if not is_refueled then
                attempts = attempts - 1
            end
        end

        turtle.turnRight()
    end
end

return Refuel