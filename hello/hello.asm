;-----------------------------------------------------------------------------;
; File        : hello.asm
; Description : A Hello World! implementation in Z80 assembly for MSX
;
; Copyright (C) 2015 Alvaro Polo
;
; This Source Code Form is subject to the terms of the Mozilla Public
; License, v. 2.0. If a copy of the MPL was not distributed with this
; file, You can obtain one at http://mozilla.org/MPL/2.0/.
;
;-----------------------------------------------------------------------------;

include "msx-bios.asm"

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
	ld hl, FORCLR
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

