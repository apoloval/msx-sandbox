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
	call loadPallete
stop:
	jp stop

initScreen:
	ld hl, FORCLR
	ld [hl], 15
	ld hl, BAKCLR
	ld [hl], 1
	ld hl, BDRCLR
	ld [hl], 1

	call INIGRP
	ret

loadPallete:
	call DISSCR

; Fill the char table
	ld hl, pcb_chars
	ld de, CHRTBL
	ld bc, 32*24*8
	call LDIRVM

; Fill the color table
	ld hl, pcb_cols
	ld de, CLRTBL
	ld bc, 32*24*8
	call LDIRVM

; Fill the name table
	ld hl, pcb_names
	ld de, NAMTBL
	ld bc, 768
	call LDIRVM


; Done, enable screen & return
	call ENASCR
	ret

include "pcb-chars.asm"
include "pcb-names.asm"