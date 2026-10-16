InventoryManager = {}

local max_inventory_size = 16

function InventoryManager.store(config_manager)
    turtle.select(1)
    turtle.turnLeft()

    local item = nil

    for i = 1, max_inventory_size do
        item = turtle.getItemDetail(i)

        if item then
            turtle.select(i)

            if item["name"] == config_manager:get_seed_name() then
                turtle.dropUp()
            elseif  item["name"] == "minecraft:coal" then
                turtle.drop()
            else
                turtle.dropDown()
            end
        end
    end

    turtle.turnRight()
    turtle.select(1)
end

function InventoryManager.count_item(item_name)
    turtle.select(1)

    local total_items = 0
    local item = nil

    for i = 1, max_inventory_size do
        item = turtle.getItemDetail(i)

        if item then
            if item["name"] == item_name then
                total_items = total_items + item["count"]
            end
        end
    end

    turtle.select(1)

    return total_items
end

return InventoryManager