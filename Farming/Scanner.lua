local InventoryManager = require("InventoryManager")

Scanner = {}

local trigger_block = "minecraft:redstone_torch"

-- Instanciates Class
function Scanner:new(scanner)
    scanner = scanner or {}
    setmetatable(scanner, self)
    self.__index = self

    return scanner
end

-- build error handling for seed_name (if no item in slot)
--                          trigger_block (none detected)
function Scanner:scan(movement)
    local has_block, block_data = turtle.inspectDown()
    local crop_name = ""
    local seed_name = InventoryManager.find_seed()
    local total_farm_size = 0
    local side_length = 0

    _, block_data = turtle.inspectDown()
    crop_name = block_data.name

    while true do
        local has_block_front, _ = turtle.inspect()
        has_block, block_data = turtle.inspectDown()

        if block_data.name == trigger_block then
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

    return total_farm_size, side_length, crop_name, seed_name
end

return Scanner