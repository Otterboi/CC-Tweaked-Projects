local Scanner = require("Scanner")
local Movement = require("Movement")
local refuel = require("Refuel")
local restock = require("Restock")
local iventory_manager = require("InventoryManager")
local ConfigManager = require("ConfigManager")
local CropTable = require("crop_table")

local movement = Movement:new()
local scanner = Scanner:new()
local config_manager = ConfigManager:new()

if config_manager:load() then
    refuel.check_fuel(config_manager)
else
    local total_farm_size, side_length, crop_name, seed_name = scanner:scan(movement)
    local crop_max_age = CropTable.get_age(crop_name)
    local config_data = {total_farm_size=total_farm_size, side_length=side_length, crop_max_age=crop_max_age, crop_name=crop_name, seed_name=seed_name}

    config_manager:store(config_data)

    movement:move(config_manager:get_total_farm_size(), config_manager:get_side_length(), nil)
end

-- 4. Create class/module for 
--                            restocking -> get seed for easy searching (needs to know what the total amount of seeds are in the inventory ex: iventory search)
--                            dumping all items into chest that isnt coal and the required amount of seeds
-- 5. Create harvesting movement_action

-- HOW IT SHOULD RUN:
-- Check if settings.txt exsits
-- If if does, go straight to main farming loop
--     doesnt, Plotting -> Farming loop
-- Once the turtle gets to the end of its movement check, Refule
--                                                        Reseed
--                                                        Store items in chest
--                                                        Return to waiting position