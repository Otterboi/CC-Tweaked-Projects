-- Author: Otterboi_
-- Client for the autosmelt command will take information 
-- from autosmelt server and define how many time this computer neeed to activate the drain

-- Gets command arguments
local args = {...}
args[1] = tonumber(args[1])

-- Prints usage of command is no arguments are provided
if table.getn(args) == 0 then
    print("Usage: autosmelt_client <port> <cast_type>")
    print("Ex: autosmelt_client 2 block")
    return
end

-- Error handeling
-- Checks if args are positive integers
if type(args[1]) ~= "number" or args[1] <= 0 then
    error("Error: Port must be a non negative integer!", 0)
    return
end

-- Checks if args are block, ingot or nugget
if not (string.lower(args[2]) ~= "block" or string.lower(args[2]) ~= "ingot" or string.lower(args[2]) ~= "nugget") then
    error("Error: Cast type can only be block, ingot or nugget!", 0)
    return
end

-- MAIN: Start of program execution
local modem = peripheral.find("modem")
modem.open(args[1])

local jobCount

print("Listening on port: " .. args[1])
print("Casting: " .. args[2])

-- Loops until it gets a message from the server telling it how many items to produce
while true do
    print("Waiting for server...")
    local _, _, _, _, message, _ = os.pullEvent("modem_message")
    jobCount = tonumber(message)
    print("Smelting " .. jobCount .. " " .. args[2])

    while jobCount > 0 do
        redstone.setOutput("bottom", true)
        os.sleep(1)
        redstone.setOutput("bottom", false)

        jobCount = jobCount - 1

        print("Dispensing 1 " .. args[2])

        if string.lower(args[2]) == "block" then
            os.sleep(15)
        elseif string.lower(args[2]) == "ingot" then
            os.sleep(3)
        elseif string.lower(args[2]) == "nugget" then
            os.sleep(2)
        end
    end

    modem.transmit(50, 0, "DONE")
end