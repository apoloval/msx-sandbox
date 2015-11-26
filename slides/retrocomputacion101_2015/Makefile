all: slides.wav

slides.wav: slides.cas
	mcp -e slides.cas slides.wav

slides.cas: slides.asc
	rm -f slides.cas
	mcp -a slides.cas slides.asc

.PHONY clean:
	rm *.wav *.cas
