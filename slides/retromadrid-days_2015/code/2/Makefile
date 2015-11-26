INCLUDES=-I ../include

all: hello.bin

hello.bin: hello.asm
	pasmo ${INCLUDES} hello.asm hello.bin

.PHONY clean:
	rm -f *.rom *.bin
