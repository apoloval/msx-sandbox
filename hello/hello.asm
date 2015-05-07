;-----------------------------------------------------------------------------;
; A Hello World! implementation in Z80 assembly for MSX
;
; Copyright (C) 2015 Alvaro Polo
;-----------------------------------------------------------------------------;

INITXT 		equ 0x006C
POSIT		equ 0x00C6
CHPUT		equ 0x00A2

FGCOL 		equ 0xf3e9

org 0x8000

header:
	db "AB"
	dw main
	dw 0, 0, 0
	dw 0, 0, 0

main:
	call initScreen
	call printHello
stop:
	jp stop

initScreen:
	ld hl, FGCOL
	ld [hl], 15
	inc hl
	ld [hl], 1
	inc hl
	ld [hl], 1

	call INITXT

printHello:
	ld h, 1
	ld l, 1 
	call POSIT
	ld hl, hello
printChar:
	ld a, [hl]
	or a
	ret z
	call CHPUT
	inc hl
	jr printChar


hello db "Hello World!",0

org 0xbfff
ending db 0

