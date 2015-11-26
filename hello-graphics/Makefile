INCLUDES=-I ../include
SOURCES=\
	hello.asm

all: hello-graphics.rom

hello-graphics.rom: ${SOURCES} main.asm
	pasmo ${INCLUDES} main.asm hello-graphics.rom

.PHONY clean:
	rm -f *.rom *.bin
