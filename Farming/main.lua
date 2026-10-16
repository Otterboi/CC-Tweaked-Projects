local Scanner = require("Scanner")
local Movement = require("Movement")
local Refuel = require("Refuel")
local Restock = require("Restock")
local InventoryManager = require("InventoryManager")
local ConfigManager = require("ConfigManager")
local CropTable = require("CropTable")

local movement = Movement:new()
local scanner = Scanner:new()
local config_manager = ConfigManager:new()

if config_manager:load() then
    movement:park()
    Refuel.check_fuel(config_manager)
    InventoryManager.store(config_manager)
else
    local total_farm_size, side_length, crop_name, seed_name = scanner:scan(movement)
    local crop_max_age = CropTable.get_age(crop_name)
    local config_data = {total_farm_size=total_farm_size, side_length=side_length, crop_max_age=crop_max_age, crop_name=crop_name, seed_name=seed_name}

    config_manager:store(config_data)

    movement:move(config_manager:get_total_farm_size(), config_manager:get_side_length(), nil)
end

-- TODO
-- 4. Create class/module for 
--                            restocking -> get seed for easy searching (needs to know what the total amount of seeds are in the inventory ex: iventory search)
-- 5. Create harvesting movement_action
-- 6. Properly throw errors and handling

-- HOW IT SHOULD RUN:
-- Check if settings.txt exsits
-- If if does, go straight to main farming loop
--     doesnt, Plotting -> Farming loop
-- Once the turtle gets to the end of its movement check, Refule
--                                                        Reseed
--                                                        Store items in chest
--                                                        Return to waiting position