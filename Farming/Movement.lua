-- Author: Otterboi_
-- Movement class that handles all movement based activites
-- the turtle must conduct.

local ConfigManager = require("ConfigManager")

Movement = {}

local turning_state = "LEFT"
local edgecase_state = nil

-- Instanciates Class
function Movement:new(Movement)
    Movement = Movement or {}
    setmetatable(Movement, self)
    self.__index = self

    return Movement
end

-- Turtle's turtle direction state to know if it has to
-- turn left or right.
local turning_direction = {
    LEFT = function()
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()
        turning_state = "RIGHT"
    end,
    RIGHT = function()
        turtle.turnRight()
        turtle.forward()
        turtle.turnRight()
        turning_state = "LEFT"
    end
}

-- Runs the state that is required.
function Movement:handle_turning()
    local state = turning_direction[turning_state]

    if state then
        state()
    else
        error("Invalid turning state!", 0)
    end
end

-- Turns the turtle 180 degrees
function Movement:reset_rotation()
    turtle.turnLeft()
    turtle.turnLeft()
end

-- For scanner only will return the turtle back to the chest
-- it started at.
function Movement:return_to_chest(width, length)
    self:reset_rotation()

    for _= 1, width - 1 do
        turtle.forward()
    end

    turtle.turnRight()

    for _= 1, length do
        turtle.forward()
    end

    self:reset_rotation()
end

-- The main movement function that uses the strategy pattern to handle
-- different movement strategies whill keeping the same base movement
-- protocol.
function Movement:move(action)
    local length = ConfigManager.length
    local width = ConfigManager.width

    for i = 1, width do
        for j = 1, length do
            if action then
                action()
            end

            if j < length then
                turtle.forward()
            end
        end

        if i < width then
            self:handle_turning()
        end
    end

    self:reset_rotation()
end

-- Ensures that the turtle is in the correct position and
-- rotation for storing and refueling.
function Movement:park()
    local has_block, block_data = turtle.inspectDown()
    local is_chest = string.match(block_data.name, "chest")

    if has_block then
        if not is_chest then
            turtle.back()
        end
    end

    turtle.turnLeft()
end

-- Returns the turtle back to its ready state to begin
-- harvesting.
function Movement:ready()
    turtle.turnRight()
    turtle.forward()
end

return Movement