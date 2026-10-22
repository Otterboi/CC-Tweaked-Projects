-- Author: Otterboi_
-- Auto farmland scanning and farming turtle

local Scanner = require("Scanner")
local Movement = require("Movement")
local Refuel = require("Refuel")
local InventoryManager = require("InventoryManager")
local ConfigManager = require("ConfigManager")
local CropTable = require("CropTable")
local MovementActions = require("MovementActions")

local movement = Movement:new()
local scanner = Scanner:new()

-- Sets the turtle to its default docking position.
local function dock()
    movement:park()
    InventoryManager.store()
    Refuel.check_fuel()
    movement:ready()

    print("Waiting for crop to grow...")
end

-- Initilizes the turtles state preparing it for scanning.
-- Throws an error if there is no fuel in the turtle.
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

-- Docks the turtle if a config file is found loading it into memory.
-- Initilizes the turtle, scans the farmland and generates the config file otherwise.
if ConfigManager.load() then
    dock()
else
    init_turtle()

    local length, width, crop_name, seed_name = scanner:scan(movement)
    local crop_max_age = CropTable.get_age(crop_name)
    local config_data = {length=length, width=width, crop_max_age=crop_max_age, crop_name=crop_name, seed_name=seed_name}

    ConfigManager.store(config_data)

    dock()
end

-- Main loop
while true do
    local _, block_data = turtle.inspectDown()

    if block_data.state.age == ConfigManager.crop_max_age then
        print("Farming...")

        for _ = 0, 1 do
            movement:move(MovementActions.harvest)
        end

        dock()
    end
end