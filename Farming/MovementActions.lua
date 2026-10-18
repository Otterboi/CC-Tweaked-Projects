local InventoryManager = require("InventoryManager")
local ConfigManager = require("ConfigManager")

local MovementActions = {}

function MovementActions.harvest()
    local seed_slot = InventoryManager.find_slot_id(ConfigManager.seed_name)
    local _, block_data = turtle.inspectDown()

    turtle.select(seed_slot)

    if block_data.name == ConfigManager.crop_name then
        if block_data.state.age == ConfigManager.crop_max_age then
            turtle.digDown()
            turtle.placeDown()
        end
    end
end

return MovementActions