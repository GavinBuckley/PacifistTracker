# Spelunky 2 Pacifist Tracker
This is a mod created for DougDoug's Spelunky Pacifist playthrough.

## Features
- Kill counter built into the in-game HUD
- An option to instantly kill player when the player kills an enemy
- An option to add quips and custom quips to the death screen

![example1](https://user-images.githubusercontent.com/31485432/228916271-e686f72e-e7de-43df-b01c-65964800887b.jpg)
![example2](https://user-images.githubusercontent.com/31485432/228916296-3cfe9aeb-63a2-4694-a5f5-4507e7381cca.jpg)

## Requirements

This mod requires both [Modlunky2](https://github.com/spelunky-fyi/modlunky2) and [Playlunky](https://github.com/spelunky-fyi/Playlunky) to be installed.

## Installation 
- Download main.lua
- Navigate to the "Install Mods" Tab of Modlunky
- For the source file, select main.lua
- For the destination, create a folder titled "PacifistTracker" or whatever you like and select that folder
- Click install and the mod should be installed automatically

## Usage
- Ensure the mod is selected and click "Play!"
- (Optional) If you want to add custom quips to the death screen you can make the changes as follows:
  - Open main.lua in the text editor of your choice
  - At the bottom of the file, there should be an array titled "death_quips"
  - Add as many quips as you like 
  - Above the array there is a function with a random number generator. Make sure the max number is equal to the number of quips there are.
  - Save the file
  - In Modlunky, click "Refresh Mods"
- While in game, you can press CTRL + F4 to bring up the options menu
