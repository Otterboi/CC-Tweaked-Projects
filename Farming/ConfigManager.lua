-- Author: Otterboi_
-- Config Manager module contains all functions required
-- to store and load config data for the farming turtle.

ConfigManager = {}

ConfigManager.total_farm_size = 0
ConfigManager.side_length = 0
ConfigManager.crop_max_age = 0
ConfigManager.crop_name = ""
ConfigManager.seed_name = ""

local file_name = "farming_config.txt"

-- Retrieves the file with a specific mode (read/write).
local function get_file(mode)
    local file = io.open(file_name, mode)

    if not file then
        return nil
    end

    return file
end

-- Loads the config data into memory from the config file.
function ConfigManager.load()
    local file = get_file("r")

    if file then
        local data = textutils.unserialise(file:read())

        ConfigManager.total_farm_size = data.total_farm_size
        ConfigManager.side_length = data.side_length
        ConfigManager.crop_max_age = data.crop_max_age
        ConfigManager.crop_name = data.crop_name
        ConfigManager.seed_name = data.seed_name

        file:close()

        print("Farming config successfully loaded!")
        return true
    else
        print("Farming config not found!")
    end
end

-- Stores the config data into a file for presistance
function ConfigManager.store(config_data)
    local file = get_file("w")

    if file then
        file:write("{total_farm_size=", config_data.total_farm_size, ",side_length=", config_data.side_length,
                   ",crop_max_age=", config_data.crop_max_age, ",crop_name=\"", config_data.crop_name, "\"",
                   ",seed_name=\"", config_data.seed_name, "\"}")
        file:close()
        ConfigManager.load()
    else
        error("Unable to write farming config file!", 0)
    end
end

return ConfigManager