INCLUDES=-I ../include

all: hello.rom

hello.rom: hello.asm
	pasmo ${INCLUDES} hello.asm hello.rom

.PHONY clean:
	rm -f hello.rom
