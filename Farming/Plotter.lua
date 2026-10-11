Plotter = {}

local turning_state = "LEFT"
local trigger_block = "minecraft:redstone_torch"

local total_farm_size = 0
local side_length = 0

-- Instanciates Class
function Plotter:new(plotter)
    plotter = plotter or {}
    setmetatable(plotter, self)
    self.__index = self

    return plotter
end

local movement = {
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

local function handle_turning()
    local state = movement[turning_state]

    if state then
        state()
    else
        print("CREATE INVALID ACTION ERROR :3")
    end
end

local function reset_position()
    -- turn around function somewhere
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.forward()

    local move_counter = 1

    while move_counter <= total_farm_size + 1 do
        if math.fmod(move_counter, side_length) == 0 and move_counter ~= total_farm_size then
            handle_turning()
        elseif move_counter ~= total_farm_size then
            turtle.forward()
        end
        move_counter = move_counter + 1
    end

    -- turn around function somewhere
end


function Plotter:scan()
    local first_trigger_seen = false
    local has_block, block_data = turtle.inspectDown()

    if block_data.name == trigger_block then
        first_trigger_seen = true
        turtle.forward()

        while first_trigger_seen do
            local has_block_front, _ = turtle.inspect()
            has_block, block_data = turtle.inspectDown()

            if block_data.name == trigger_block and first_trigger_seen then
                first_trigger_seen = false
                break
            end

            if has_block then
                total_farm_size = total_farm_size + 1

                if not has_block_front then
                    turtle.forward()
                else
                    handle_turning()
                end

            else
                turtle.back()
                handle_turning()
            end
        end

        side_length = math.sqrt(total_farm_size)

        -- put this in a different module/class
        local file = io.open("settings.txt", "w")
        if file then
            file:write("{total_farm_size=", total_farm_size,",side_length=",side_length,"}")
            file:close()
        else
            print("CREATE FILE DNE ERROR :3")
        end

        reset_position()
    else
        print("CREATE NO REDSTONE TORCH ERROR :3")
    end
end

return Plotter