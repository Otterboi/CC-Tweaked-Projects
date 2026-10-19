local InventoryManager = require("InventoryManager")
local ConfigManager = require("ConfigManager")

Restock = {}

local stack_size = 64

function Restock.restock()
    local farm_size = ConfigManager.total_farm_size
    local total_seeds_required = math.ceil(farm_size / stack_size)

    for _ = 1, total_seeds_required do
        turtle.suckUp()
    end

    if InventoryManager.count_item(ConfigManager.seed_name) < farm_size then
        error("Not enough seeds to maintain farm! Terminating program!", 0)
    end
end

return Restock