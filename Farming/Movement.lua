Movement = {}

local turning_state = "LEFT"

-- Instanciates Class
function Movement:new(Movement)
    Movement = Movement or {}
    setmetatable(Movement, self)
    self.__index = self

    return Movement
end

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

function Movement:handle_turning()
    local state = turning_direction[turning_state]

    if state then
        state()
    else
        print("CREATE INVALID ACTION ERROR :3")
    end
end

function Movement:reset_rotation()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.forward()
end

-- Change this so that it can be used for harvesting and not
-- just resetting position as its resuable coded
function Movement:move(total_farm_size, side_length, action)
    local move_counter = 1

    while move_counter <= total_farm_size + 1 do
        if action then
            action()
        end

        if math.fmod(move_counter, side_length) == 0 and move_counter ~= total_farm_size then
            self:handle_turning()
        elseif move_counter ~= total_farm_size then
            turtle.forward()
        end
        move_counter = move_counter + 1
    end

    self:reset_rotation()
end

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

function Movement:ready()
    turtle.turnRight()
    turtle.forward()
end

return Movement