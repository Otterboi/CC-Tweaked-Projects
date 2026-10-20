local ConfigManager = require("ConfigManager")

InventoryManager = {}

local max_inventory_size = 16

local function process_inventory(more_details, callback)
    local item = nil
    local result = nil

    for i = 1, max_inventory_size do
        item = turtle.getItemDetail(i, more_details)

        if item then
            result = callback(item, i)

            if result then
                return result
            end
        end
    end

    return nil
end

function InventoryManager.store()
    turtle.select(1)

    process_inventory(false, function (item, i)
        turtle.select(i)

        if item["name"] == ConfigManager.seed_name then
            turtle.dropUp()
        elseif  item["name"] == "minecraft:coal" then
            turtle.drop()
        else
            turtle.dropDown()
        end
    end)

    turtle.select(1)
end

function InventoryManager.count_item(item_name)
    local total_items = 0

    process_inventory(false, function (item, _)
        if item["name"] == item_name then
            total_items = total_items + item["count"]
        end
    end)

    return total_items
end

function InventoryManager.find_slot_id(item_name)
    local slot = process_inventory(false, function (item, i)
        if item["name"] == item_name then
            return i
        end
    end)

    return slot or -1
end

function InventoryManager.find_seed()
    local seed = process_inventory(true, function (item, _)
        for key, _ in pairs(item["tags"]) do
            if key == "c:seeds" or key == "c:crops" then
                return item["name"]
            end
        end
    end)

    if not seed then
        error("Crop seeds cannot be found!\nEnsure seeds are in the turtle inventory or in an inventory above the turtle!",0)
    end

    return seed
end

return InventoryManager