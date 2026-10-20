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
-- Proper Documentation
-- Refactor scanner to only look for crop blocks

local function docking()
    movement:park()
    InventoryManager.store()
    Refuel.check_fuel()
    Restock.restock()
    movement:ready()

    print("Waiting for crop to grow...")
end

local function init_turtle()
    movement:park()
    turtle.suck(5)
    turtle.select(1)
    turtle.refuel()
    turtle.suckUp(1)
    movement:ready()
end

if ConfigManager.load() then
    docking()
else
    init_turtle()

    local total_farm_size, side_length, crop_name, seed_name = scanner:scan(movement)
    local crop_max_age = CropTable.get_age(crop_name)
    local config_data = {total_farm_size=total_farm_size, side_length=side_length, crop_max_age=crop_max_age, crop_name=crop_name, seed_name=seed_name}

    ConfigManager.store(config_data)

    movement:reset_rotation()
    movement:move(ConfigManager.total_farm_size, ConfigManager.side_length, nil)

    docking()
end

-- Main loop
while true do
    local _, block_data = turtle.inspectDown()

    if block_data.state.age == ConfigManager.crop_max_age then
        print("Farming...")

        for i = 0, 1 do
            movement:move(ConfigManager.total_farm_size, ConfigManager.side_length, MovementActions.harvest)
        end

        docking()
    end
end