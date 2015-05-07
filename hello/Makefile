all: hello.rom

hello.rom: hello.asm
	pasmo hello.asm hello.rom

.PHONY clean:
	rm -f hello.rom
