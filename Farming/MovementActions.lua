local InventoryManager = require("InventoryManager")

local MovementActions = {}

function MovementActions.harvest(config_manager)
    local seed_slot = InventoryManager.find_slot_id(config_manager:get_seed_name())
    local _, block_data = turtle.inspectDown()

    turtle.select(seed_slot)

    if block_data.name == config_manager:get_crop_name() then
        if block_data.state.age == config_manager:get_crop_max_age() then
            turtle.digDown()
            turtle.placeDown()
        end
    end
end

return MovementActions