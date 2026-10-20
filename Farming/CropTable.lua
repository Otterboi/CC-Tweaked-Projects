-- Author: Otterboi_
-- Crop Table module stores and retrieves the various crop
-- ages depending on mod and crop.

CropTable = {}

CropTable.crop_ages = {
    beetroot = 3,
    farmersdelight = 3,
    immersiveengineering = 4,
    sushigocrafting = 3,
    default = 7
}

-- Gets the age of the crop from its mod/name.
-- Returns the crops age.
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