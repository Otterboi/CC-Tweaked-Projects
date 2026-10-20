local InventoryManager = require("InventoryManager")
local ConfigManager = require("ConfigManager")

local MovementActions = {}

function MovementActions.harvest()
    local seed_slot = -1
    local _, block_data = turtle.inspectDown()

    if block_data.name == ConfigManager.crop_name then
        if block_data.state.age == ConfigManager.crop_max_age then
            turtle.digDown()

            seed_slot = InventoryManager.find_slot_id(ConfigManager.seed_name)

            turtle.select(seed_slot)
            turtle.placeDown()
        end
    end
end

return MovementActions