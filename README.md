## MSX Sandbox

This sandbox contains some experiments with code for MSX systems.

For assembly code, [Pasmo assembler](http://pasmo.speccy.org) is used. 
The provided makefiles assume you have it in your path. 

## Contents

* `hello/`. A Hello World! implementation written in assembly language. 
It generates a ROM file to be loaded as a cartridge and a BIN file
to be loaded with BLOAD from disk or cassette. 

## Tips & Tricks

### Generate CAS/WAV files from BIN files

There are several tools available in the Internet to generate a cassete
stream in CAS or WAV formats with your binary files. The most recommended 
is [MSX CAS Packager](http://apoloval.github.io/mcp/).

Follow the instructions provided in MCP's website to install the tool
and learn how to use it.
