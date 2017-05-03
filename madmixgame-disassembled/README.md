## Mad Mix Game Disassembled

This project is a partial disassembly of the mythical Mad Mix Game from Topo Soft.

This is the result of trying to debug the game to find out why it doesn't work on a MSX2 platform. The work was presented in RetroMadrid 2017 (slides [here][1]).

## Contents

* In `asm/` directory, you will find the disassembled files.  
* In `data/` directory, you will find some data files obtained from the binaries.
    * `data/cover-tspat.dat`: the tileset pattern of the cover image.
* In `util/` directory, you will find some utilities.
    * `util/tilesetconv.rb`: a Ruby script to generate a PNG file from a tileset pattern data file.


[1]: https://www.slideshare.net/AlvaroPoloValdenebro/desensamblando-mad-mix-game
