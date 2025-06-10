local basalt = require("basalt")

-- Get a reference to the monitor
local monitor = peripheral.find("monitor")
local width, height = monitor.getSize()

monitor.setTextScale(0.5)

-- Global Varibales
local doorText = "OPEN"
local isOpen = false

-- Create frame for monitor
local monitorFrame = basalt.createFrame():setTerm(monitor)
monitorFrame:setBackground(colors.black)


-- Add a button
monitorFrame:addButton()
    :setText("")
    :setPosition(2, 4)
    :setWidth(13)
    :setHeight(4)
    :setBackground(colors.green)
    :setForeground(colors.black)
    :onClick(function()
        if not isOpen then
            redstone.setOutput("top", true)
            isOpen = true
            doorText = "CLOSE"
        else
            redstone.setOutput("top", false)
            isOpen = false
            doorText = "OPEN"
        end
    end)

-- Start Basalt
basalt.run()