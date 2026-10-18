local Scanner = require("Scanner")
local Movement = require("Movement")
local Refuel = require("Refuel")
local Restock = require("Restock")
local InventoryManager = require("InventoryManager")
local ConfigManager = require("ConfigManager")
local CropTable = require("CropTable")
local MovementActions = require("MovementActions")

local movement = Movement:new()
local scanner = Scanner:new()

-- TODO
-- 6. Properly throw errors and handling

local function docking()
    movement:park()
    InventoryManager.store()
    Refuel.check_fuel()
    Restock.restock()
    movement:ready()
end

if ConfigManager.load() then
    docking()
else
    local total_farm_size, side_length, crop_name, seed_name = scanner:scan(movement)
    local crop_max_age = CropTable.get_age(crop_name)
    local config_data = {total_farm_size=total_farm_size, side_length=side_length, crop_max_age=crop_max_age, crop_name=crop_name, seed_name=seed_name}

    ConfigManager.store(config_data)

    movement:move(ConfigManager.total_farm_size, ConfigManager.side_length, nil)

    docking()
end

-- Main loop
while true do
    local _, block_data = turtle.inspectDown()

    if block_data.state.age == ConfigManager.crop_max_age then
        movement:move(ConfigManager.total_farm_size, ConfigManager.side_length, MovementActions.harvest)
        movement:move(ConfigManager.total_farm_size, ConfigManager.side_length, MovementActions.harvest)

        docking()
    end
end