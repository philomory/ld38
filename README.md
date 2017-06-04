#Strangeness
Strangeness is a small puzzle game about a man whose world is falling apart.
The puzzles are similar is style to those of games like Chip's Challenge or The Adventures of Lolo, but enemies only move when you do.

Currently features:

* Push boulders, grab keys, press buttons teleport across 19 levels!
* Throw rocks to stun enemies!
* Take all the time you need to think: nothing moves until you do.
* Programmer art!
* Auto-generated tracker music!

The original version of Strangeness was developed in 72 hours for Ludum Dare 38 - A Small World. This version is substantially improved from the Jam version.

For more information, see [the game's homepage](https://philomory.itch.io/strangeness) on [itch.io](http://itch,io/)

## Running the Game
To run the game from source, you'll need to have [Ruby 2.3.x](http://ruby-lang.org) installed. You'll also need the gem [bundler](http://bundler.io).

Once you have those, use `bundle install` to install the gem dependencies, and `ruby ld38.rb` to run the game.

Windows and Mac users may prefer to download double-clickable versions of the game from [itch.io](https://philomory.itch.io/strangeness).

## Playing the Game
The objective of the game is to navigate from the start of the level to the exit, marked by a swirling blue portal. Along the way you must avoid deadly
creatures, collect keys to open locks, push boulders onto switches, and more.

To navigate the menu:

* Use the up and down arrow keys to select menu options
* Use Space or Enter to select a menu option

The default controls in the game are:

* WASD or Arrow Keys to move
* Hold Shift and use WASD or Arrow Keys to throw a rock (if you have one)
* Escape to pause the game
* U to undo a move
* R to restart the level

Keybindings can be changed from the settings menu; this includes support for most gamepads. Additionally, there is an alternate control mode available
in the options menu, under which one set of directional keys moves (by default, WASD), and another is used to throw rocks (by default, the Arrow Keys).

## Tools
The following tools were used to create this game:

* Language: [Ruby](http://ruby-lang.org/)
* GameDev Library: [Gosu](http://libgosu.org/)
* Editor: [Textmate 2](https://macromates.com)
* Graphics: [Pyxel Edit](http://pyxeledit.com), [Pixen](http://pixenapp.com)
* Map: [Tiled](http://mapeditor.org)
* SFX: [bfxr](http://bfxr.net)
* Music: [Autotracker-bu](https://github.com/iamgreaser/it2everything/blob/master/atrk-bu.py) 
* Fonts: [Alagard](http://pix3m.deviantart.com/art/Bitmap-font-Alagard-381110713) and [Romulus](http://pix3m.deviantart.com/art/Bitmap-font-Romulus-380739406) by Pix3M

## License
This game is released under the MIT license. See License.txt for more information.