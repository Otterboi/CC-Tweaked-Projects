Crop = {name = "", max_age = 0, growth_time = 0}

-- Instanciates Class
function Crop:new(crop)
    crop = crop or {}
    setmetatable(crop, self)
    self.__index = self
    return crop
end

function Crop:print()
    print("Name: " .. self.name .. " Age: " .. self.max_age .. " Time: " .. self.growth_time)
end

return Crop