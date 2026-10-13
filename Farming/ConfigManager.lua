ConfigManager = {total_farm_size=0, side_length=0, crop_max_age=0, crop_name=""}

local file_name = "farming_config.txt"

function ConfigManager:new(config_manager)
    config_manager = config_manager or {}
    setmetatable(config_manager, self)
    self.__index = self
    return config_manager
end

local function get_file_if_exists(mode)
    local file = io.open(file_name, mode)

    if not file then
        return nil, "FILE DNE ERROR or CANNOT READ :3"
    end

    return file
end

function ConfigManager:load()
    local file = get_file_if_exists("r")

    if file then
        local data = textutils.unserialise(file:read())
        self.total_farm_size = data.total_farm_size
        self.side_length = data.side_length
        self.crop_max_age = data.crop_max_age
        self.crop_name = data.crop_name

        file:close()
    end
end

function ConfigManager:store(config_data)
    local file = io.open(file_name, "w")
    if file then
        file:write("{total_farm_size=", config_data.total_farm_size, ",side_length=", config_data.side_length,
                   ",crop_max_age=", config_data.crop_max_age, ",crop_name=\"", config_data.crop_name, "\"}")
        file:close()
        self:load()
    else
        print("CREATE FILE DNE ERROR :3")
    end
end

function ConfigManager:get_total_farm_size()
    return self.total_farm_size
end

function ConfigManager:get_side_length()
    return self.side_length
end

function ConfigManager:get_crop_max_age()
    return self.crop_max_age
end

function ConfigManager:get_crop_name()
    return self.crop_name
end

return ConfigManager