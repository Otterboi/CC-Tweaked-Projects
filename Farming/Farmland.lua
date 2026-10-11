Farmland = {total_farm_size=0, side_length=0}

-- Instanciates Class
function Farmland:new(farmland)
    farmland = farmland or {}
    setmetatable(farmland, self)
    self.__index = self
    return farmland
end

function Farmland:get_total_farm_size()
    return self.total_farm_size
end

function Farmland:get_side_length()
    return self.side_length
end

function Farmland:set_total_farm_size(total_farm_size)
    self.total_farm_size = total_farm_size
end

function Farmland:set_side_length(side_length)
    self.side_length = side_length
end

return Farmland