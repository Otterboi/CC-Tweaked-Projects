Plotter = {total_farm_size=0, side_length=0}

local current_state = "LEFT"
local trigger_block = "minecraft:redstone_torch"

local movement = {
    LEFT = function()
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()
        current_state = "RIGHT"
    end,
    RIGHT = function()
        turtle.turnRight()
        turtle.forward()
        turtle.turnRight()
        current_state = "LEFT"
    end
}

local function handle_turning()
    local state = movement[current_state]

    if state then
        state()
    else
        print("CREATE INVALID ACTION ERROR :3")
    end
end

-- Instanciates Class
function Plotter:new(plotter)
    plotter = plotter or {}

    setmetatable(plotter, self)
    self.__index = self

    plotter:scan()
    return plotter
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
                self.total_farm_size = self.total_farm_size + 1

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

        self.side_length = math.sqrt(self.total_farm_size)
        -- write to file from the file module
    else
        print("CREATE NO REDSTONE TORCH ERROR :3")
    end
end

function Plotter:get_side_length()
    return self.side_length
end

function Plotter:get_total_farm_size()
    return self.total_farm_size
end

return Plotter