-- Author: Otterboi_
-- Scanner class that will scan the entire farmland and 
-- retrieve the necessary data for harvesting. 

local InventoryManager = require("InventoryManager")

Scanner = {}

-- Instanciates Class
function Scanner:new(scanner)
    scanner = scanner or {}
    setmetatable(scanner, self)
    self.__index = self
    return scanner
end

-- Scans the farmland and returns the total farm size,
-- side length, crop name and seed name
function Scanner:scan(movement)
    print("Scanning farmland!")

    local has_block, block_data = turtle.inspectDown()
    local crop_name = ""
    local seed_name = InventoryManager.find_seed()
    local length = 0
    local width = 0
    local scanning = true

    crop_name = block_data.name

    while scanning do
        has_block, block_data = turtle.inspectDown()

        if has_block and block_data["name"] == crop_name then
            width = width + 1
            turtle.forward()
        else
            turtle.back()
            if length == 0 then
                turtle.turnLeft()
                length = width
                width = 0
            else
                scanning = false
            end
        end
    end

    movement:return_to_chest(width, length)

    print("Scanning complete!")
    return length, width, crop_name, seed_name
end

return Scanner