local InventoryManager = require("InventoryManager")
local ConfigManager = require("ConfigManager")

Restock = {}

local stack_size = 64

-- throw errors if not enough seeds
function Restock.restock()
    local farm_size = ConfigManager.total_farm_size
    local total_seeds_required = math.ceil(farm_size / stack_size)

    for _ = 1, total_seeds_required do
        turtle.suckUp()
    end
end

return Restock