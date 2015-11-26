INCLUDES=-I ../include

all: hello.rom hello.bin

hello.rom: hello.asm rom.asm
	pasmo ${INCLUDES} rom.asm hello.rom

hello.bin: hello.asm bin.asm
	pasmo ${INCLUDES} bin.asm hello.bin

hello.cas: hello.asc hello.bin
	rm -f hello.cas
	mcp -a hello.cas hello.asc hello.bin

hello.wav: hello.cas
	mcp -e hello.cas hello.wav

.PHONY clean:
	rm -f *.rom *.bin *.cas *.wav
