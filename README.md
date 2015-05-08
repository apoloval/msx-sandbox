## MSX Sandbox

This sandbox contains some experiments with code for MSX systems.

For assembly code, [Pasmo assembler](http://pasmo.speccy.org) is used. 
The provided makefiles assume you have it in your path. 

## Contents

* `hello/`. A Hello World! implementation written in assembly language. 
It generates a ROM file to be loaded as a cartridge and a BIN file
to be converted into WAV and loadde with BLOAD. 

## Tips & Tricks

### Generate WAV files from BIN files

You'll need the following utilities:

* [msxwav](http://computeremuzone.com/msx/utils/MSXWAV.zip): this tool can
generate a WAV file from a BIN file. Nevertheless, it only supports 2400BPS,
what is not supported by some real MSX computers. 
* [castools](http://home.kabelfoon.nl/~vincentd/): comprised by `wav2cas`, 
`cas2wav` & `casdir`. This is a toolset to convert WAV files into CAS format 
and back. The WAV format it generates is the most convenient for real MSX 
computers (1200 bps, mono, etc). Thus it can be used to convert the output of
msxwav to generate a CAS and convert it again to WAV. 

Unfortunatelly, these tools only works in Windows 32-bits. 

The procedure is as follows:

* Use `msxwav` to convert your BIN file into WAV
* Use `wav2cas` to convert the WAV file into CAS
* Check that CAS file contains what you expect with `casdir`
* Use `cas2wav` to generate the final WAV file from CAS
