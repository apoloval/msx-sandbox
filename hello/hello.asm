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

main:
	call initScreen
	call printHello
stop:
	jp stop

initScreen:
	ld hl, FORCLR
	ld [hl], 15
	ld hl, BAKCLR
	ld [hl], 1
	ld hl, BDRCLR
	ld [hl], 1

	call INITXT
	call ERAFNK
	ret

printHello:
	call CLS
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
