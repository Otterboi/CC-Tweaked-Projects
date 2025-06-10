local basalt = require("basalt")

-- Get a reference to the monitor
local monitor = peripheral.find("monitor")
local width, height = monitor.getSize()

monitor.setTextScale(0.5)

local color = colors.lime

-- Create frame and canvas for monitor
local monitorFrame = basalt.createFrame():setTerm(monitor)
monitorFrame:setBackground(colors.black)

local canvas = monitorFrame:getCanvas()
canvas:text(5, 5, "Ore", color, colors.black)
canvas:text(5, 6, "Duplicator", color, colors.black)

-- Vertical Lines
canvas:line(1, 1, 1, 10, "#", color, colors.black)
canvas:line(15, 1, 15, 10, "#", color, colors.black)

-- Horizontal Lines
canvas:line(1, 1, 15, 1, "#", color, colors.black)
canvas:line(1, 10, 15, 10, "#", color, colors.black)



-- Start Basalt
basalt.run()