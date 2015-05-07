INCLUDES=-I ../include

all: hello.rom hello.bin

hello.rom: hello.asm rom.asm
	pasmo ${INCLUDES} rom.asm hello.rom

hello.bin: hello.asm bin.asm
	pasmo ${INCLUDES} bin.asm hello.bin

.PHONY clean:
	rm -f *.rom *.bin
