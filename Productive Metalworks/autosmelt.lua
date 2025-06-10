-- Author: Otterboi_
-- Auto create blocks/ingots/nuggets from
-- liquid metal using Productive Metalworkds mod

-- Gets command arguments
local args = {...}
args[2] = tonumber(args[2])
args[3] = tonumber(args[3])
args[5] = tonumber(args[5])
args[6] = tonumber(args[6])
args[8] = tonumber(args[8])
args[9] = tonumber(args[9])

-- Prints usage of command is no arguments are provided
if table.getn(args) == 0 then
  print("Usage: autosmelt -b <port> <amount> -i <port> <amount> -n <port> <amount>")
  print("Ex: autosmelt -b 1 2 -i 2 5 -n 3 1")
  return
end

-- Error handling
if args[1] ~= "-b" or args[4] ~= "-i" or args[7] ~= "-n" then
  error("Error: -b -i and -n are mandatory!", 0)
  return
end

if (type(args[2]) ~= "number" or type(args[5]) ~= "number" or type(args[8]) ~= "number") or
   (args[3] <= 0 or args[6] <= 0 or args[9] <= 0)
then
  error("Error: Port number/amounts must be a none negative integer!", 0)
  return
end

-- Global variabls controlling state of command
local blockPort = 0
local ingotPort = 0
local nuggetPort = 0
local blockControllers = 0
local ingotControllers = 0
local nuggetControllers = 0

-- Calcualtes how many clients there are in the system
local currentJobs = args[3] + args[6] + args[9]
local isWorking = false

-- Finds where the fluid storage is
local function findDrain()
    for key, side in pairs(peripheral.getNames()) do
      if peripheral.getType(side) == "productivemetalworks:foundry_drain" then
        return side
      end
    end

    error("ERROR: Can't find foundry drain!", 0)
    return nil
end

-- Initialize the ports and client controllers
local function init()
  blockPort = args[2]
  blockControllers = args[3]

  ingotPort = args[5]
  ingotControllers = args[6]

  nuggetPort = args[8]
  nuggetControllers = args[9]
end

-- Waits until all clients are done before continuing
local function waitForClients()
  print("Waiting for clients...")
  local jobsRemaining = currentJobs

  while jobsRemaining ~= 0 do
    local _, _, _, _, message, _ = os.pullEvent("modem_message")

    if message == "DONE" then
      jobsRemaining = jobsRemaining - 1
    end
  end
  isWorking = false
  print("All jobs done waiting...")
end

-- MAIN: Start of program execution
local drain = findDrain()
local modem = peripheral.find("modem")
local totalBlocks = 0
local totalIngots = 0
local totalNuggets = 0

-- Checks if the drain exists if it does start execution of splitting tasks for clients
if drain then
  print("AutoSmelt Server running on port 50")
  modem.open(50)

  init()

  while true do
    local fluid = peripheral.wrap(drain).tanks()[1]

    if fluid ~= nil then
      local remainingFluid = fluid.amount
      print("Remaining Fluid: " .. remainingFluid)

      if not isWorking and remainingFluid >= 10 then
        totalBlocks = math.floor(math.floor((remainingFluid / 810)) / blockControllers)
        totalIngots = math.floor(math.floor(((remainingFluid - (810 * totalBlocks * blockControllers)) / 90) / ingotControllers))
        totalNuggets = math.floor(math.floor(((remainingFluid - (810 * totalBlocks * blockControllers) - (90 * totalIngots * ingotControllers)) / 10) / nuggetControllers))

        print("WORKING")
        print("Total Blocks: " .. totalBlocks)
        print("Total Ingots: " .. totalIngots)
        print("Total Nuggets: " .. totalNuggets)
        print("")

        -- Send to block port
        modem.transmit(blockPort, 0, totalBlocks)

        -- Send to ingot port
        modem.transmit(ingotPort, 0, totalIngots)

        -- Send to nugget port
        modem.transmit(nuggetPort, 0, totalNuggets)

        isWorking = true
        waitForClients()
      end
    end
  end
end
