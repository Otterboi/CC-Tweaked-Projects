local Plotter = require("Plotter")
local Movement = require("Movement")
local ConfigManager = require("ConfigManager")
local CropTable = require("crop_table")

local movement = Movement:new()
local plotter = Plotter:new()
local config_manager = ConfigManager:new()

plotter:scan(movement, config_manager, CropTable)

-- 1. Edit Plotter to also store the mod of the crop
-- 2. Create a class/module for reading/writing the settings.txt file
-- 3. Create lookup table for crops
-- 4. Create class/module for refulling
--                            reseeding
--                            dumping items into chest


-- HOW IT SHOULD RUN:
-- Check if settings.txt exsits
-- If if does, go straight to main farming loop
--     doesnt, Plotting -> Farming loop
-- Once the turtle gets to the end of its movement check, Refule
--                                                        Reseed
--                                                        Store items in chest
--                                                        Return to waiting position