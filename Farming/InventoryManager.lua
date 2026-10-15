InventoryManager = {}

local max_inventory_size = 16

function InventoryManager.store(config_manager)
    local item = nil

    for i = 1, max_inventory_size do
        item = turtle.getItemDetail(i)

        if item then
            if item["name"] ~= config_manager:get_seed_name() or item["name"] ~= "minecraft:coal" then
                turtle.dropDown()
            end
        end
    end
end

function InventoryManager.count_seeds()
    
end

return InventoryManager