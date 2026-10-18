local ConfigManager = require("ConfigManager")

Refuel = {}

local stack_size = 64

-- throw error if fuel still isnt enough
function Refuel.check_fuel()
    local farm_size = ConfigManager.total_farm_size
    local total_fuel_required = math.ceil((farm_size * 2) / stack_size)

    if turtle.getFuelLevel() <= farm_size * 2 then
        turtle.turnLeft()
        turtle.select(1)

        for _ = 1, total_fuel_required do
            turtle.suck()
            turtle.refuel()
        end

        turtle.turnRight()
    end
end

return Refuel