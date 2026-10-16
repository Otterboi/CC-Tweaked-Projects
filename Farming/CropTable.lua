CropTable = {}

CropTable.crop_ages = {
    beetroot = 3,
    farmersdelight = 3,
    immersiveengineering = 4,
    sushigocrafting = 3,
    default = 7
}

function CropTable.get_age(crop)
    local mod_name, crop_name = string.match(crop, "(.+):(.+)")
    local crop_age = -1

    if mod_name == "minecraft" then
        crop_age = CropTable.crop_ages[crop_name]
    else
        crop_age = CropTable.crop_ages[mod_name]
    end

    return crop_age or CropTable.crop_ages["default"]
end

return CropTable