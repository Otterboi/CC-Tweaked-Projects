-- Monitor the cable %, ring alarm if it hits 0, turn off the alarm when its no longer 0

-- Finds where the energy source is
local function findEnergySource()
    for key, side in pairs(peripheral.getNames()) do
      if peripheral.getType(side) == "ultimateuniversalcable" then
        return side
      end
    end

    error("ERROR: Can't find energy source!", 0)
    return nil
end