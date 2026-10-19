local ConfigManager = require("ConfigManager")

Refuel = {}

local stack_size = 64

function Refuel.check_fuel()
    local farm_size = ConfigManager.total_farm_size
    local total_fuel_required = math.ceil((farm_size * 2) / stack_size)

    if turtle.getFuelLevel() <= farm_size * 2 then
        turtle.select(1)

        for _ = 1, total_fuel_required do
            turtle.suck()
            turtle.refuel()
        end

        if turtle.getFuelLevel() <= farm_size * 2 then
            error("Not enough fuel! Terminating program!", 0)
            return false
        end
    end

    return true
end

return Refuel