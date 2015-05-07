;-----------------------------------------------------------------------------;
; File        : msx-bios.asm
; Description : Functions and system variable declarations for MSX BIOS
;
; Copyright (C) 2015 Alvaro Polo
;
; This Source Code Form is subject to the terms of the Mozilla Public
; License, v. 2.0. If a copy of the MPL was not distributed with this
; file, You can obtain one at http://mozilla.org/MPL/2.0/.
;
;-----------------------------------------------------------------------------;

;
; MSX-1 BIOS subroutines
;

INITXT      equ 0x006C
CHPUT       equ 0x00A2
POSIT       equ 0x00C6

;
; MSX-1 system variables
;

FORCLR      equ 0xf3e9
