local Scanner = require("Scanner")
local Movement = require("Movement")
local Refuel = require("Refuel")
local InventoryManager = require("InventoryManager")
local ConfigManager = require("ConfigManager")
local CropTable = require("CropTable")
local MovementActions = require("MovementActions")

local movement = Movement:new()
local scanner = Scanner:new()

-- TODO
-- Proper Documentation

local function docking()
    movement:park()
    InventoryManager.store()
    Refuel.check_fuel()
    movement:ready()

    print("Waiting for crop to grow...")
end

local function init_turtle()
    movement:park()
    turtle.suck(1)

    local fuel_location = InventoryManager.find_slot_id("minecraft:coal")
    if fuel_location == -1 then
        turtle.turnRight()
        error("Fuel not found!\n\nPlease insert fuel in the turtle or in the inventory to the left of the turtle's docking position.", 0)
    end

    turtle.select(fuel_location)
    turtle.refuel()
    turtle.suckDown(1)
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