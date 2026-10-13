Plotter = {}

local trigger_block = "minecraft:redstone_torch"

local total_farm_size = 0
local side_length = 0
local crop_max_age = 0
local crop_name = ""

-- Instanciates Class
function Plotter:new(plotter)
    plotter = plotter or {}
    setmetatable(plotter, self)
    self.__index = self

    return plotter
end

function Plotter:scan(movement, config_manager, CropTable)
    local first_trigger_seen = false
    local has_block, block_data = turtle.inspectDown()

    if block_data.name == trigger_block then
        first_trigger_seen = true

        turtle.forward()

        _, block_data = turtle.inspectDown()
        crop_name = block_data.name
        crop_max_age = CropTable.get_age(crop_name)

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
                    movement:handle_turning()
                end

            else
                turtle.back()
                movement:handle_turning()
            end
        end

        side_length = math.sqrt(total_farm_size)

        config_manager:store({total_farm_size=total_farm_size, side_length=side_length, crop_max_age=crop_max_age, crop_name=crop_name})

        movement:move(config_manager:get_total_farm_size(), config_manager:get_side_length(), nil)
    else
        print("CREATE NO REDSTONE TORCH ERROR :3")
    end
end

return Plotter