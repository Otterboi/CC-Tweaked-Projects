# CC-Tweaked-Projects
A collections of Projects for the Mincraft Mod [CC:Tweaked](https://tweaked.cc/)

## Farming
- Uses a Farming Turtle to harvest crops with a growth age of 7.
- Replants the crop if seeds are available and the crop was harvested.
- Auto refuling when coal is in the 1st slot.

## Monitor
- A simple monitor using [basalt](https://basalt.madefor.cc/).
- Can display any text if the code is edited.

## Productive Metalworks
- Auto casts Blocks, Ingots and nuggets from the [Productive Metalworks](https://www.curseforge.com/minecraft/mc-mods/productive-metalworks) mod.
- Uses a client/server architechture.
- Clients must be set up the port and either accpet Blocks, Ingots or Nuggets. `Usage: autosmelt_client <port> <cast_type>`
- The server must open ports for Blocks, Ingots and Nuggets, as well as how many clients are needed for each item type. `Usage: autosmelt -b <port> <amount> -i <port> <amount> -n <port> <amount>`
- The server will read the contents of foundary and calculate how many Blocks, Ingots and Nuggets are required to use all the fluid.
- The clients receieve how many Blocks, Ingots or Nuggets it must produce then starts casting the items.

## Security
- A simple button using [basalt](https://basalt.madefor.cc/).
- When the button is pressed on the monitor, a redstone pulse sent activating any restone device.

> Energy Monitor and Master Control Terminal have not been worked on.
