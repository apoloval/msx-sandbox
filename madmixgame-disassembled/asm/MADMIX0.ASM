.data:0000fa00 f3                               di

START:
; read slot selection register and save it in #fffd
.data:0000fa01 db a8                            in a,(0xa8)
.data:0000fa03 47                               ld b,a
.data:0000fa04 32 fd ff                         ld (0xfffd),a

; turn xxyy0000 into xxyyxxyy (expecting unique RAM slot ) and save it in #fffe
.data:0000fa07 cb 3f                            srl a
.data:0000fa09 cb 3f                            srl a
.data:0000fa0b cb 3f                            srl a
.data:0000fa0d cb 3f                            srl a
.data:0000fa0f b0                               or b
.data:0000fa10 32 fe ff                         ld (0xfffe),a

; reconfigure slot selection register for all pages to be in RAM
.data:0000fa13 d3 a8                            out (0xa8),a

; move MADMIX.SCR binary previously loaded in #8800 into #1000 (RAM)
.data:0000fa15 21 00 88                         ld hl,0x8800
.data:0000fa18 11 00 10                         ld de,0x1000
.data:0000fa1b 01 00 55                         ld bc,0x5500
.data:0000fa1e ed b0                            ldir

; call the screen setup
.data:0000fa20 cd 00 10                         call 0x1000

; restore the previous slot configuration
.data:0000fa23 3a fd ff                         ld a,(0xfffd)
.data:0000fa26 d3 a8                            out (0xa8),a

.data:0000fa28 fb                               ei
.data:0000fa29 c9                               ret

LAUNCHER:
.data:0000fa2a f3                               di

; activate RAM slot
.data:0000fa2b 3a fe ff                         ld a,(0xfffe)
.data:0000fa2e d3 a8                            out (0xa8),a

; jump to main
.data:0000fa30 c3 00 84                         jp 0x8400
