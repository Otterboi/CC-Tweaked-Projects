Refuel = {}

local stack_size = 64

-- throw error if fuel still isnt enough
function Refuel.check_fuel(config_manager)
    local farm_size = config_manager:get_total_farm_size()
    local total_fuel_required = math.ceil((farm_size * 2) / stack_size)

    if turtle.getFuelLevel() <= farm_size * 2 then
        turtle.turnLeft()
        turtle.select(1)

        for _ = 0, total_fuel_required do
            turtle.refuel()
            turtle.suck(stack_size)
        end

        turtle.turnRight()
    end
end

return Refuel