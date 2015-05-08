;-----------------------------------------------------------------------------;
; File        : bin.asm
; Description : A wrapper to generate a .bin file loadable with BLOAD
;
; Copyright (C) 2015 Alvaro Polo
;
; This Source Code Form is subject to the terms of the Mozilla Public
; License, v. 2.0. If a copy of the MPL was not distributed with this
; file, You can obtain one at http://mozilla.org/MPL/2.0/.
;
;-----------------------------------------------------------------------------;

org 0x8000 -7

header:
    db 0xfe
    dw main
    dw ending
    dw main

include "hello.asm"

; put 32 bytes at the end to avoid cassette load errors
ending dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
