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
CHKRAM:	equ	$0000
SYNCHR:	equ	$0008
RDSLT:	equ	$000c
CHRGTR:	equ	$0010
WRSLT:	equ	$0014
OUTDO:	equ	$0018
CALSLT:	equ	$001c
DCOMPR:	equ	$0020
ENASLT:	equ	$0024
GETYPR:	equ	$0028
CALLF:	equ	$0030
KEYINT:	equ	$0038

INITIO:	equ	$003b
INIFNK:	equ	$003e

DISSCR:	equ	$0041
ENASCR:	equ	$0044
WRTVDP:	equ	$0047
RDVRM:	equ	$004a
WRTVRM:	equ	$004d
SETRD:	equ	$0050
SETWRT:	equ	$0053
FILVRM:	equ	$0056
LDIRMV:	equ	$0059
LDIRVM:	equ	$005c
CHGMOD:	equ	$005f
CHGCLR:	equ	$0062
NMI:	equ	$0066
CLRSPR:	equ	$0069
INITXT:	equ	$006C
INIT32:	equ	$006f
INIGRP:	equ	$0072
INIMLT:	equ	$0075
SETTXT:	equ	$0078
SETT32:	equ	$007b
SETGRP:	equ	$007e
SETMLT:	equ	$0081
CALPAT:	equ	$0084
CALATR:	equ	$0087
GSPSIZ:	equ	$008a
GRPPRT:	equ	$008d

GICINI:	equ	$0090
WRTPSG:	equ	$0093
RDPSG:	equ	$0096
STRTMS:	equ	$0099

CHSNS:	equ	$009c
CHGET:	equ	$009f
CHPUT:	equ	$00a2
LPTOUT:	equ	$00a5
LPTSTT:	equ	$00a8
CNVCHR:	equ	$00ab
PINLIN:	equ	$00ae
INLIN:	equ	$00b1
QINLIN:	equ	$00b4
BREAKX:	equ	$00b7
ISCNTC:	equ	$00ba
CKCNTC:	equ	$00bd
BEEP:	equ	$00c0
CLS:	equ	$00c3
POSIT:	equ	$00c6
FNKSB:	equ	$00c9
ERAFNK:	equ	$00cc
DSPFNK:	equ	$00cf
TOTEXT:	equ	$00d2

GTSTCK:	equ	$00d5
GTTRIG:	equ	$00d8
GTPAD:	equ	$00db
GTPDL:	equ	$00de

TAPION:	equ	$00e1
TAPIN:	equ	$00e4
TAPIOF:	equ	$00e7
TAPOON:	equ	$00ea
TAPOUT:	equ	$00ed
TAPOOF:	equ	$00f0
STMOTR:	equ	$00f3

LFTQ:	equ	$00f6
PUTQ:	equ	$00f9

RIGHTC:	equ	$00fc
LEFTC:	equ	$00ff
UPC:	equ	$0102
TUPC:	equ	$0105
DOWNC:	equ	$0108
TDOWNC:	equ	$010b
SCALXY:	equ	$010e
MAPXY:	equ	$0111
FETCHC:	equ	$0114
STOREC:	equ	$0117
SETATR:	equ	$011a
READC:	equ	$011e
SETC:	equ	$0120
NSETCX:	equ	$0123
GTASPC:	equ	$0126
PNTINI:	equ	$0129
SCANR:	equ	$012c
SCANL:	equ	$012f

CHGCAP:	equ	$0132
CHGSND:	equ	$0135
RSLREG:	equ	$0138
WSLREG:	equ	$013b
RDVDP:	equ	$013e
SNSMAT:	equ	$0141
PHYDIO:	equ	$0144
FORMAT:	equ	$0147
ISFLIO:	equ	$014a
OUTDLP:	equ	$014e
GETVCP:	equ	$0150
GETVC2:	equ	$0153
KILBUF:	equ	$0156
CALBAS:	equ	$0159

;
; MSX-1 system variables
;
FORCLR:	equ	$f3e9
BAKCLR:	equ	$f3ea
BDRCLR:	equ	$f3eb

;
; MSX-1 VRAM addresses
;
CHRTBL:	equ	$0000
NAMTBL:	equ	$1800
CLRTBL:	equ	$2000
SPRATR:	equ	$1b00
SPRTBL:	equ	$3800
