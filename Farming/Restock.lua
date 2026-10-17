local InventoryManager = require("InventoryManager")
Restock = {}

local stack_size = 64

-- throw errors if not enough seeds
function Restock.restock(config_manager)
    local farm_size = config_manager:get_total_farm_size()
    local total_seeds_required = math.ceil((farm_size) / stack_size)

    for _ = 0, total_seeds_required do
        turtle.suckUp()
    end
end

return Restock