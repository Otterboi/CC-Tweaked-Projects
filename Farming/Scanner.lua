local InventoryManager = require("InventoryManager")

Scanner = {}

-- Instanciates Class
function Scanner:new(scanner)
    scanner = scanner or {}
    setmetatable(scanner, self)
    self.__index = self
    return scanner
end

-- change this so that it only grabs the length (since only squares are allowed)
function Scanner:scan(movement)
    print("Scanning farmland!")

    local has_block, block_data = turtle.inspectDown()
    local crop_name = ""
    local seed_name = InventoryManager.find_seed()
    local total_farm_size = 0
    local side_length = 0

    --_, block_data = turtle.inspectDown()
    crop_name = block_data.name

    while true do
        has_block, block_data = turtle.inspectDown()

        if has_block and block_data["name"] == crop_name then
            side_length = side_length + 1
            turtle.forward()
        else
            turtle.back()
            movement:reset_rotation()
            break
        end
    end

    movement:return_to_chest(side_length)

    total_farm_size = side_length * side_length

    print("Scanning complete!")
    return total_farm_size, side_length, crop_name, seed_name
end

return Scanner