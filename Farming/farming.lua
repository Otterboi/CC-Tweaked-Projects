-- Author: Otterboi_
-- Auto farming turtle

local printWait = true

-- Checks if turtle needs to refuel
local function checkFuel()
  if turtle.getFuelLevel() <= 0 then
   turtle.select(1)
   turtle.refuel()
   
   if turtle.getFuelLevel() == 0 then
     print("No more fuel!")
     os.pullEvent("terminate")
   end
  end
end

-- Harvest and place crops
local function harvest()
  turtle.digDown()
  turtle.select(2)
  turtle.placeDown()
  turtle.select(1)
end

-- Reset turtle looking posistion
local function reset()
 turtle.turnLeft()
 turtle.turnLeft()
end

-- MAIN: Turtle Tasks
while true do
  local hasBlock, blockData = turtle.inspectDown()
 
  if blockData.state.age == 7 then
    printWait = true
    local moveCounter = 1
    local turnLeft = true
    
    while moveCounter <= 49 do
      hasBlock, blockData = turtle.inspectDown()
      checkFuel()
      
      if blockData.name == "minecraft:carrots" and blockData.state.age == 7 then
        harvest()
      end
      
      -- Turn left or right if at the end of farm
      if math.fmod(moveCounter, 7) == 0 and moveCounter ~= 49 then
        if turnLeft then
          turtle.turnLeft()
          turtle.forward()
          turtle.turnLeft()
          turnLeft = false
        else
          turtle.turnRight()
          turtle.forward()
          turtle.turnRight()
          turnLeft = true
        end
      elseif moveCounter ~= 49 then
        turtle.forward()
      end
      
      moveCounter = moveCounter + 1
    end   
    reset()
  else
    if printWait then
      print("Waiting for crop to grow...")
      printWait = false
    end  
  end
end
