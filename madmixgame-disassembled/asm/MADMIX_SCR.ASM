

.data:00001000 f3                               di
.data:00001001 cd bc 10                         call routine0

; prepares to write to VRAM at #1800 (Map section)
.data:00001004 21 00 18                         ld hl,0x1800
.data:00001007 7d                               ld a,l
.data:00001008 d3 99                            out (0x99),a
.data:0000100a 7c                               ld a,h
.data:0000100b e6 3f                            and 0x3f
.data:0000100d f6 40                            or 0x40
.data:0000100f d3 99                            out (0x99),a
.data:00001011 e3                               ex (sp),hl ; useless, probably a...
.data:00001012 e3                               ex (sp),hl ; ...form of long nop (19 T-states each)

; writes #300 bytes of autoincrement seq to VRAM Map section???
.data:00001013 01 00 00                         ld bc,0x0000
loop0:
.data:00001016 79                               ld a,c
.data:00001017 d3 98                            out (0x98),a
.data:00001019 03                               inc bc
.data:0000101a 78                               ld a,b
.data:0000101b fe 03                            cp 0x03
.data:0000101d 20 f7                            jr nz,loop0

; prepare to write VRAM at #0000 (Tileset Pattern Bank 0)
.data:0000101f 21 ed 10                         ld hl,data1
.data:00001022 11 00 00                         ld de,0x0000
.data:00001025 01 00 18                         ld bc,0x1800
.data:00001028 eb                               ex de,hl ; why? code ofuscation?
.data:00001029 7d                               ld a,l
.data:0000102a d3 99                            out (0x99),a
.data:0000102c 7c                               ld a,h
.data:0000102d e6 3f                            and 0x3f
.data:0000102f f6 40                            or 0x40
.data:00001031 d3 99                            out (0x99),a
.data:00001033 e3                               ex (sp),hl
.data:00001034 e3                               ex (sp),hl

; Copy #1800 bytes from data1 to Tileset Pattern Banks 0, 1 and 2
.data:00001035 eb                               ex de,hl
loop1:
.data:00001036 7e                               ld a,(hl)
.data:00001037 d3 98                            out (0x98),a
.data:00001039 23                               inc hl
.data:0000103a 0b                               dec bc
.data:0000103b 78                               ld a,b
.data:0000103c b1                               or c
.data:0000103d 20 f7                            jr nz,loop1

; Write #01 to VDP register 7 (border color in screen 2 to #1)
.data:0000103f 3e 01                            ld a,0x01
.data:00001041 47                               ld b,a
.data:00001042 0e 07                            ld c,0x07
.data:00001044 78                               ld a,b
.data:00001045 d3 99                            out (0x99),a
.data:00001047 79                               ld a,c
.data:00001048 f6 80                            or 0x80
.data:0000104a d3 99                            out (0x99),a

; Prepare to write VDP color banks (#2000) for 768 elements
.data:0000104c 01 00 03                         ld bc,0x0300
.data:0000104f 11 00 20                         ld de,0x2000
.data:00001052 21 f0 28                         ld hl,data2
loop2:
.data:00001055 c5                               push bc
.data:00001056 7e                               ld a,(hl)
.data:00001057 a7                               and a
.data:00001058 28 26                            jr z,cont0
.data:0000105a e5                               push hl
.data:0000105b c5                               push bc
.data:0000105c 47                               ld b,a
.data:0000105d e6 07                            and 0x07
.data:0000105f 4f                               ld c,a
.data:00001060 78                               ld a,b
.data:00001061 e6 78                            and 0x78
.data:00001063 0f                               rrca
.data:00001064 0f                               rrca
.data:00001065 0f                               rrca
.data:00001066 6f                               ld l,a
.data:00001067 e6 08                            and 0x08
.data:00001069 b1                               or c
.data:0000106a 4f                               ld c,a
.data:0000106b 7d                               ld a,l
.data:0000106c 21 ac 10                         ld hl,data0
.data:0000106f 85                               add a,l
.data:00001070 6f                               ld l,a
.data:00001071 46                               ld b,(hl)
.data:00001072 21 ac 10                         ld hl,data0
.data:00001075 79                               ld a,c
.data:00001076 85                               add a,l
.data:00001077 6f                               ld l,a
.data:00001078 7e                               ld a,(hl)
.data:00001079 0f                               rrca
.data:0000107a 0f                               rrca
.data:0000107b 0f                               rrca
.data:0000107c 0f                               rrca
.data:0000107d b0                               or b
.data:0000107e c1                               pop bc
.data:0000107f e1                               pop hl
cont0:
.data:00001080 01 08 00                         ld bc,0x0008
.data:00001083 23                               inc hl
.data:00001084 eb                               ex de,hl
.data:00001085 c5                               push bc
.data:00001086 f5                               push af
.data:00001087 7d                               ld a,l
.data:00001088 d3 99                            out (0x99),a
.data:0000108a 7c                               ld a,h
.data:0000108b e6 3f                            and 0x3f
.data:0000108d f6 40                            or 0x40
.data:0000108f d3 99                            out (0x99),a
.data:00001091 e3                               ex (sp),hl
.data:00001092 e3                               ex (sp),hl
.data:00001093 f1                               pop af
.data:00001094 04                               inc b
loop3:
.data:00001095 d3 98                            out (0x98),a
.data:00001097 0d                               dec c
.data:00001098 c2 95 10                         jp nz,loop3
.data:0000109b 05                               dec b
.data:0000109c c2 95 10                         jp nz,loop3
.data:0000109f c1                               pop bc
.data:000010a0 09                               add hl,bc
.data:000010a1 eb                               ex de,hl
.data:000010a2 c1                               pop bc
.data:000010a3 0b                               dec bc
.data:000010a4 78                               ld a,b
.data:000010a5 b1                               or c
.data:000010a6 20 ad                            jr nz,loop2
.data:000010a8 cd c7 10                         call routine1
.data:000010ab c9                               ret

data0:
.data:000010ac 01                               0x01
.data:000010ad 04                               0x04
.data:000010ae 06                               0x06
.data:000010af 0d                               0x0d '
'
.data:000010b0 0c                               0x0c ''
.data:000010b1 07                               0x07
.data:000010b2 0a                               0x0a '
'
.data:000010b3 0e                               0x0e
.data:000010b4 01                               0x01
.data:000010b5 04                               0x04
.data:000010b6 06                               0x06
.data:000010b7 08                               0x08
.data:000010b8 02                               0x02
.data:000010b9 07                               0x07
.data:000010ba 0b                               0x0b ''
.data:000010bb 0f                               0x0f
; This writes the value b10100010 in VDP register R1
routine0:
.data:000010bc db 99                            in a,(0x99)
.data:000010be 3e a2                            ld a,0xa2
.data:000010c0 d3 99                            out (0x99),a
.data:000010c2 3e 81                            ld a,0x81
.data:000010c4 d3 99                            out (0x99),a
.data:000010c6 c9                               ret
routine1:
.data:000010c7 db 99                            in a,(0x99)
.data:000010c9 a7                               and a
.data:000010ca f2 c7 10                         jp p,routine1
.data:000010cd db 99                            in a,(0x99)
.data:000010cf 3e e2                            ld a,0xe2
.data:000010d1 d3 99                            out (0x99),a
.data:000010d3 3e 81                            ld a,0x81
.data:000010d5 d3 99                            out (0x99),a
.data:000010d7 c9                               ret
.data:000010d8 3e a2                            ld a,0xa2
.data:000010da 32 e4 10                         ld (0x10e4),a
.data:000010dd c9                               ret
.data:000010de 3e e2                            ld a,0xe2
.data:000010e0 32 e4 10                         ld (0x10e4),a
.data:000010e3 c9                               ret
.data:000010e4 e2 02 e2                         jp po,0xe202
.data:000010e7 06 80                            ld b,0x80
.data:000010e9 00                               nop
.data:000010ea 36 07                            ld (hl),0x07
.data:000010ec 11                               db 0x11
data1:
.data:000010ed 00                               db 0x00
.data:000010ee 00                               db 0x00
.data:000010ef 00                               0x00
.data:000010f0 00                               nop
.data:000010f1 00                               nop
.data:000010f2 00                               nop
.data:000010f3 00                               nop
.data:000010f4 00                               nop
.data:000010f5 00                               nop
.data:000010f6 00                               nop
.data:000010f7 00                               nop
.data:000010f8 00                               nop
.data:000010f9 00                               nop
.data:000010fa 00                               nop
.data:000010fb 00                               nop
.data:000010fc 00                               nop
.data:000010fd 00                               nop
.data:000010fe 00                               nop
.data:000010ff 00                               nop
.data:00001100 00                               nop
.data:00001101 00                               nop
.data:00001102 00                               nop
.data:00001103 00                               nop
.data:00001104 00                               nop
.data:00001105 00                               nop
.data:00001106 00                               nop
.data:00001107 00                               nop
.data:00001108 00                               nop
.data:00001109 00                               nop
.data:0000110a 00                               nop
.data:0000110b 00                               nop
.data:0000110c 00                               nop
.data:0000110d 00                               nop
.data:0000110e 00                               nop
.data:0000110f 00                               nop
.data:00001110 00                               nop
.data:00001111 00                               nop
.data:00001112 00                               nop
.data:00001113 00                               nop
.data:00001114 00                               nop
.data:00001115 00                               nop
.data:00001116 00                               nop
.data:00001117 00                               nop
.data:00001118 00                               nop
.data:00001119 00                               nop
.data:0000111a 00                               nop
.data:0000111b 00                               nop
.data:0000111c 00                               nop
.data:0000111d 00                               nop
.data:0000111e 00                               nop
.data:0000111f 00                               nop
.data:00001120 00                               nop
.data:00001121 00                               nop
.data:00001122 00                               nop
.data:00001123 00                               nop
.data:00001124 00                               nop
.data:00001125 00                               nop
.data:00001126 00                               nop
.data:00001127 00                               nop
.data:00001128 0f                               rrca
.data:00001129 3f                               ccf
.data:0000112a 7f                               ld a,a
.data:0000112b cc aa 00                         call z,0x00aa
.data:0000112e 00                               nop
.data:0000112f 00                               nop
.data:00001130 00                               nop
.data:00001131 80                               add a,b
.data:00001132 c0                               ret nz
.data:00001133 c0                               ret nz
.data:00001134 e0                               ret po
.data:00001135 00                               nop
.data:00001136 00                               nop
.data:00001137 00                               nop
.data:00001138 00                               nop
.data:00001139 00                               nop
.data:0000113a 00                               nop
.data:0000113b 00                               nop
.data:0000113c 00                               nop
.data:0000113d 00                               nop
.data:0000113e 00                               nop
.data:0000113f 00                               nop
.data:00001140 00                               nop
.data:00001141 00                               nop
.data:00001142 00                               nop
.data:00001143 00                               nop
.data:00001144 00                               nop
.data:00001145 00                               nop
.data:00001146 00                               nop
.data:00001147 00                               nop
.data:00001148 00                               nop
.data:00001149 00                               nop
.data:0000114a 00                               nop
.data:0000114b 00                               nop
.data:0000114c 00                               nop
.data:0000114d 00                               nop
.data:0000114e 00                               nop
.data:0000114f 00                               nop
.data:00001150 00                               nop
.data:00001151 00                               nop
.data:00001152 00                               nop
.data:00001153 00                               nop
.data:00001154 00                               nop
.data:00001155 00                               nop
.data:00001156 00                               nop
.data:00001157 00                               nop
.data:00001158 00                               nop
.data:00001159 00                               nop
.data:0000115a 00                               nop
.data:0000115b 00                               nop
.data:0000115c 00                               nop
.data:0000115d 00                               nop
.data:0000115e 00                               nop
.data:0000115f 00                               nop
.data:00001160 00                               nop
.data:00001161 00                               nop
.data:00001162 00                               nop
.data:00001163 00                               nop
.data:00001164 00                               nop
.data:00001165 00                               nop
.data:00001166 00                               nop
.data:00001167 00                               nop
.data:00001168 00                               nop
.data:00001169 00                               nop
.data:0000116a 00                               nop
.data:0000116b 00                               nop
.data:0000116c 00                               nop
.data:0000116d 00                               nop
.data:0000116e 00                               nop
.data:0000116f 00                               nop
.data:00001170 00                               nop
.data:00001171 00                               nop
.data:00001172 00                               nop
.data:00001173 00                               nop
.data:00001174 00                               nop
.data:00001175 00                               nop
.data:00001176 00                               nop
.data:00001177 00                               nop
.data:00001178 00                               nop
.data:00001179 00                               nop
.data:0000117a 00                               nop
.data:0000117b 00                               nop
.data:0000117c 00                               nop
.data:0000117d 00                               nop
.data:0000117e 00                               nop
.data:0000117f 00                               nop
.data:00001180 00                               nop
.data:00001181 00                               nop
.data:00001182 00                               nop
.data:00001183 00                               nop
.data:00001184 00                               nop
.data:00001185 00                               nop
.data:00001186 00                               nop
.data:00001187 00                               nop
.data:00001188 00                               nop
.data:00001189 00                               nop
.data:0000118a 00                               nop
.data:0000118b 00                               nop
.data:0000118c 00                               nop
.data:0000118d 00                               nop
.data:0000118e 00                               nop
.data:0000118f 00                               nop
.data:00001190 00                               nop
.data:00001191 00                               nop
.data:00001192 00                               nop
.data:00001193 00                               nop
.data:00001194 00                               nop
.data:00001195 00                               nop
.data:00001196 00                               nop
.data:00001197 00                               nop
.data:00001198 00                               nop
.data:00001199 00                               nop
.data:0000119a 00                               nop
.data:0000119b 00                               nop
.data:0000119c 00                               nop
.data:0000119d 00                               nop
.data:0000119e 00                               nop
.data:0000119f 00                               nop
.data:000011a0 00                               nop
.data:000011a1 00                               nop
.data:000011a2 00                               nop
.data:000011a3 00                               nop
.data:000011a4 00                               nop
.data:000011a5 00                               nop
.data:000011a6 00                               nop
.data:000011a7 00                               nop
.data:000011a8 00                               nop
.data:000011a9 00                               nop
.data:000011aa 00                               nop
.data:000011ab 00                               nop
.data:000011ac 00                               nop
.data:000011ad 00                               nop
.data:000011ae 00                               nop
.data:000011af 00                               nop
.data:000011b0 00                               nop
.data:000011b1 00                               nop
.data:000011b2 00                               nop
.data:000011b3 00                               nop
.data:000011b4 00                               nop
.data:000011b5 00                               nop
.data:000011b6 00                               nop
.data:000011b7 00                               nop
.data:000011b8 00                               nop
.data:000011b9 00                               nop
.data:000011ba 00                               nop
.data:000011bb 00                               nop
.data:000011bc 00                               nop
.data:000011bd 00                               nop
.data:000011be 00                               nop
.data:000011bf 00                               nop
.data:000011c0 00                               nop
.data:000011c1 00                               nop
.data:000011c2 00                               nop
.data:000011c3 00                               nop
.data:000011c4 00                               nop
.data:000011c5 00                               nop
.data:000011c6 00                               nop
.data:000011c7 00                               nop
.data:000011c8 00                               nop
.data:000011c9 00                               nop
.data:000011ca 00                               nop
.data:000011cb 00                               nop
.data:000011cc 00                               nop
.data:000011cd 00                               nop
.data:000011ce 00                               nop
.data:000011cf 00                               nop
.data:000011d0 00                               nop
.data:000011d1 00                               nop
.data:000011d2 00                               nop
.data:000011d3 00                               nop
.data:000011d4 00                               nop
.data:000011d5 00                               nop
.data:000011d6 00                               nop
.data:000011d7 00                               nop
.data:000011d8 00                               nop
.data:000011d9 00                               nop
.data:000011da 00                               nop
.data:000011db 00                               nop
.data:000011dc 00                               nop
.data:000011dd 00                               nop
.data:000011de 00                               nop
.data:000011df 00                               nop
.data:000011e0 00                               nop
.data:000011e1 00                               nop
.data:000011e2 00                               nop
.data:000011e3 00                               nop
.data:000011e4 00                               nop
.data:000011e5 00                               nop
.data:000011e6 00                               nop
.data:000011e7 00                               nop
.data:000011e8 00                               nop
.data:000011e9 00                               nop
.data:000011ea 00                               nop
.data:000011eb 00                               nop
.data:000011ec 00                               nop
.data:000011ed 00                               nop
.data:000011ee 00                               nop
.data:000011ef 00                               nop
.data:000011f0 00                               nop
.data:000011f1 00                               nop
.data:000011f2 00                               nop
.data:000011f3 00                               nop
.data:000011f4 00                               nop
.data:000011f5 00                               nop
.data:000011f6 00                               nop
.data:000011f7 00                               nop
.data:000011f8 00                               nop
.data:000011f9 00                               nop
.data:000011fa 00                               nop
.data:000011fb 00                               nop
.data:000011fc 00                               nop
.data:000011fd 00                               nop
.data:000011fe 00                               nop
.data:000011ff 00                               nop
.data:00001200 00                               nop
.data:00001201 00                               nop
.data:00001202 00                               nop
.data:00001203 00                               nop
.data:00001204 00                               nop
.data:00001205 00                               nop
.data:00001206 00                               nop
.data:00001207 00                               nop
.data:00001208 00                               nop
.data:00001209 00                               nop
.data:0000120a 00                               nop
.data:0000120b 00                               nop
.data:0000120c 00                               nop
.data:0000120d 00                               nop
.data:0000120e 00                               nop
.data:0000120f 00                               nop
.data:00001210 00                               nop
.data:00001211 00                               nop
.data:00001212 00                               nop
.data:00001213 00                               nop
.data:00001214 00                               nop
.data:00001215 00                               nop
.data:00001216 00                               nop
.data:00001217 00                               nop
.data:00001218 00                               nop
.data:00001219 00                               nop
.data:0000121a 00                               nop
.data:0000121b 00                               nop
.data:0000121c 00                               nop
.data:0000121d 01 01 03                         ld bc,0x0301
.data:00001220 02                               ld (bc),a
.data:00001221 03                               inc bc
.data:00001222 07                               rlca
.data:00001223 07                               rlca
.data:00001224 07                               rlca
.data:00001225 5b                               ld e,e
.data:00001226 1a                               ld a,(de)
.data:00001227 3c                               inc a
.data:00001228 7c                               ld a,h
.data:00001229 fe ff                            cp 0xff
.data:0000122b 9f                               sbc a,a
.data:0000122c 63                               ld h,e
.data:0000122d 60                               ld h,b
.data:0000122e 60                               ld h,b
.data:0000122f 70                               ld (hl),b
.data:00001230 f0                               ret p
.data:00001231 f0                               ret p
.data:00001232 70                               ld (hl),b
.data:00001233 f0                               ret p
.data:00001234 90                               sub b
.data:00001235 00                               nop
.data:00001236 00                               nop
.data:00001237 00                               nop
.data:00001238 00                               nop
.data:00001239 00                               nop
.data:0000123a 00                               nop
.data:0000123b 00                               nop
.data:0000123c 00                               nop
.data:0000123d 00                               nop
.data:0000123e 00                               nop
.data:0000123f 00                               nop
.data:00001240 00                               nop
.data:00001241 00                               nop
.data:00001242 00                               nop
.data:00001243 00                               nop
.data:00001244 00                               nop
.data:00001245 00                               nop
.data:00001246 00                               nop
.data:00001247 00                               nop
.data:00001248 00                               nop
.data:00001249 00                               nop
.data:0000124a 00                               nop
.data:0000124b 00                               nop
.data:0000124c 00                               nop
.data:0000124d 00                               nop
.data:0000124e 00                               nop
.data:0000124f 00                               nop
.data:00001250 00                               nop
.data:00001251 00                               nop
.data:00001252 00                               nop
.data:00001253 00                               nop
.data:00001254 00                               nop
.data:00001255 00                               nop
.data:00001256 00                               nop
.data:00001257 00                               nop
.data:00001258 00                               nop
.data:00001259 00                               nop
.data:0000125a 00                               nop
.data:0000125b 00                               nop
.data:0000125c 00                               nop
.data:0000125d 00                               nop
.data:0000125e 00                               nop
.data:0000125f 00                               nop
.data:00001260 00                               nop
.data:00001261 00                               nop
.data:00001262 00                               nop
.data:00001263 00                               nop
.data:00001264 00                               nop
.data:00001265 00                               nop
.data:00001266 00                               nop
.data:00001267 00                               nop
.data:00001268 00                               nop
.data:00001269 00                               nop
.data:0000126a 00                               nop
.data:0000126b 00                               nop
.data:0000126c 00                               nop
.data:0000126d 00                               nop
.data:0000126e 00                               nop
.data:0000126f 00                               nop
.data:00001270 00                               nop
.data:00001271 00                               nop
.data:00001272 00                               nop
.data:00001273 00                               nop
.data:00001274 00                               nop
.data:00001275 00                               nop
.data:00001276 00                               nop
.data:00001277 00                               nop
.data:00001278 00                               nop
.data:00001279 00                               nop
.data:0000127a 00                               nop
.data:0000127b 00                               nop
.data:0000127c 00                               nop
.data:0000127d 00                               nop
.data:0000127e 00                               nop
.data:0000127f 00                               nop
.data:00001280 00                               nop
.data:00001281 00                               nop
.data:00001282 00                               nop
.data:00001283 00                               nop
.data:00001284 00                               nop
.data:00001285 00                               nop
.data:00001286 00                               nop
.data:00001287 00                               nop
.data:00001288 00                               nop
.data:00001289 00                               nop
.data:0000128a 00                               nop
.data:0000128b 00                               nop
.data:0000128c 00                               nop
.data:0000128d 00                               nop
.data:0000128e 00                               nop
.data:0000128f 00                               nop
.data:00001290 00                               nop
.data:00001291 00                               nop
.data:00001292 00                               nop
.data:00001293 00                               nop
.data:00001294 00                               nop
.data:00001295 00                               nop
.data:00001296 00                               nop
.data:00001297 00                               nop
.data:00001298 00                               nop
.data:00001299 00                               nop
.data:0000129a 00                               nop
.data:0000129b 00                               nop
.data:0000129c 00                               nop
.data:0000129d 00                               nop
.data:0000129e 00                               nop
.data:0000129f 00                               nop
.data:000012a0 00                               nop
.data:000012a1 00                               nop
.data:000012a2 00                               nop
.data:000012a3 00                               nop
.data:000012a4 00                               nop
.data:000012a5 00                               nop
.data:000012a6 00                               nop
.data:000012a7 00                               nop
.data:000012a8 00                               nop
.data:000012a9 00                               nop
.data:000012aa 00                               nop
.data:000012ab 00                               nop
.data:000012ac 00                               nop
.data:000012ad 00                               nop
.data:000012ae 00                               nop
.data:000012af 00                               nop
.data:000012b0 00                               nop
.data:000012b1 00                               nop
.data:000012b2 00                               nop
.data:000012b3 00                               nop
.data:000012b4 00                               nop
.data:000012b5 00                               nop
.data:000012b6 00                               nop
.data:000012b7 00                               nop
.data:000012b8 00                               nop
.data:000012b9 00                               nop
.data:000012ba 00                               nop
.data:000012bb 00                               nop
.data:000012bc 00                               nop
.data:000012bd 00                               nop
.data:000012be 00                               nop
.data:000012bf 00                               nop
.data:000012c0 00                               nop
.data:000012c1 00                               nop
.data:000012c2 00                               nop
.data:000012c3 00                               nop
.data:000012c4 00                               nop
.data:000012c5 00                               nop
.data:000012c6 00                               nop
.data:000012c7 00                               nop
.data:000012c8 00                               nop
.data:000012c9 00                               nop
.data:000012ca 00                               nop
.data:000012cb 00                               nop
.data:000012cc 00                               nop
.data:000012cd 00                               nop
.data:000012ce 00                               nop
.data:000012cf 00                               nop
.data:000012d0 00                               nop
.data:000012d1 00                               nop
.data:000012d2 00                               nop
.data:000012d3 00                               nop
.data:000012d4 00                               nop
.data:000012d5 00                               nop
.data:000012d6 00                               nop
.data:000012d7 00                               nop
.data:000012d8 03                               inc bc
.data:000012d9 0c                               inc c
.data:000012da 10 60                            djnz 0x133c
.data:000012dc 81                               add a,c
.data:000012dd 00                               nop
.data:000012de 00                               nop
.data:000012df 00                               nop
.data:000012e0 00                               nop
.data:000012e1 00                               nop
.data:000012e2 00                               nop
.data:000012e3 00                               nop
.data:000012e4 00                               nop
.data:000012e5 00                               nop
.data:000012e6 00                               nop
.data:000012e7 00                               nop
.data:000012e8 00                               nop
.data:000012e9 00                               nop
.data:000012ea 00                               nop
.data:000012eb 00                               nop
.data:000012ec 00                               nop
.data:000012ed 00                               nop
.data:000012ee 00                               nop
.data:000012ef 00                               nop
.data:000012f0 00                               nop
.data:000012f1 00                               nop
.data:000012f2 00                               nop
.data:000012f3 00                               nop
.data:000012f4 00                               nop
.data:000012f5 00                               nop
.data:000012f6 00                               nop
.data:000012f7 00                               nop
.data:000012f8 00                               nop
.data:000012f9 00                               nop
.data:000012fa 00                               nop
.data:000012fb 00                               nop
.data:000012fc 00                               nop
.data:000012fd 00                               nop
.data:000012fe 00                               nop
.data:000012ff 00                               nop
.data:00001300 c0                               ret nz
.data:00001301 b0                               or b
.data:00001302 08                               ex af,af'
.data:00001303 06 01                            ld b,0x01
.data:00001305 00                               nop
.data:00001306 00                               nop
.data:00001307 00                               nop
.data:00001308 00                               nop
.data:00001309 00                               nop
.data:0000130a 00                               nop
.data:0000130b 00                               nop
.data:0000130c 80                               add a,b
.data:0000130d 00                               nop
.data:0000130e 00                               nop
.data:0000130f 00                               nop
.data:00001310 00                               nop
.data:00001311 00                               nop
.data:00001312 00                               nop
.data:00001313 00                               nop
.data:00001314 00                               nop
.data:00001315 00                               nop
.data:00001316 00                               nop
.data:00001317 00                               nop
.data:00001318 00                               nop
.data:00001319 00                               nop
.data:0000131a 00                               nop
.data:0000131b 00                               nop
.data:0000131c 00                               nop
.data:0000131d 07                               rlca
.data:0000131e 0f                               rrca
.data:0000131f 0f                               rrca
.data:00001320 0e 0e                            ld c,0x0e
.data:00001322 0e 0d                            ld c,0x0d
.data:00001324 07                               rlca
.data:00001325 6d                               ld l,l
.data:00001326 7d                               ld a,l
.data:00001327 7d                               ld a,l
.data:00001328 fe fe                            cp 0xfe
.data:0000132a fe ff                            cp 0xff
.data:0000132c ff                               rst 0x38
.data:0000132d e0                               ret po
.data:0000132e b0                               or b
.data:0000132f e0                               ret po
.data:00001330 fc fe ff                         call m,0xfffe
.data:00001333 7f                               ld a,a
.data:00001334 7f                               ld a,a
.data:00001335 00                               nop
.data:00001336 00                               nop
.data:00001337 00                               nop
.data:00001338 0f                               rrca
.data:00001339 7f                               ld a,a
.data:0000133a ff                               rst 0x38
.data:0000133b ff                               rst 0x38
.data:0000133c ff                               rst 0x38
.data:0000133d 00                               nop
.data:0000133e 00                               nop
.data:0000133f 00                               nop
.data:00001340 c0                               ret nz
.data:00001341 f8                               ret m
.data:00001342 ff                               rst 0x38
.data:00001343 ff                               rst 0x38
.data:00001344 ff                               rst 0x38
.data:00001345 00                               nop
.data:00001346 00                               nop
.data:00001347 00                               nop
.data:00001348 00                               nop
.data:00001349 00                               nop
.data:0000134a 00                               nop
.data:0000134b c0                               ret nz
.data:0000134c e0                               ret po
.data:0000134d 00                               nop
.data:0000134e 00                               nop
.data:0000134f 00                               nop
.data:00001350 00                               nop
.data:00001351 00                               nop
.data:00001352 00                               nop
.data:00001353 00                               nop
.data:00001354 00                               nop
.data:00001355 00                               nop
.data:00001356 00                               nop
.data:00001357 00                               nop
.data:00001358 00                               nop
.data:00001359 00                               nop
.data:0000135a 00                               nop
.data:0000135b 00                               nop
.data:0000135c 00                               nop
.data:0000135d 00                               nop
.data:0000135e 00                               nop
.data:0000135f 00                               nop
.data:00001360 00                               nop
.data:00001361 00                               nop
.data:00001362 00                               nop
.data:00001363 00                               nop
.data:00001364 07                               rlca
.data:00001365 00                               nop
.data:00001366 00                               nop
.data:00001367 00                               nop
.data:00001368 00                               nop
.data:00001369 00                               nop
.data:0000136a 00                               nop
.data:0000136b 00                               nop
.data:0000136c ff                               rst 0x38
.data:0000136d 00                               nop
.data:0000136e 00                               nop
.data:0000136f 00                               nop
.data:00001370 00                               nop
.data:00001371 00                               nop
.data:00001372 00                               nop
.data:00001373 00                               nop
.data:00001374 e0                               ret po
.data:00001375 00                               nop
.data:00001376 00                               nop
.data:00001377 00                               nop
.data:00001378 00                               nop
.data:00001379 00                               nop
.data:0000137a 00                               nop
.data:0000137b 00                               nop
.data:0000137c 00                               nop
.data:0000137d 00                               nop
.data:0000137e 00                               nop
.data:0000137f 00                               nop
.data:00001380 00                               nop
.data:00001381 00                               nop
.data:00001382 00                               nop
.data:00001383 00                               nop
.data:00001384 00                               nop
.data:00001385 00                               nop
.data:00001386 00                               nop
.data:00001387 00                               nop
.data:00001388 00                               nop
.data:00001389 00                               nop
.data:0000138a 00                               nop
.data:0000138b 00                               nop
.data:0000138c 00                               nop
.data:0000138d 00                               nop
.data:0000138e 00                               nop
.data:0000138f 00                               nop
.data:00001390 00                               nop
.data:00001391 00                               nop
.data:00001392 00                               nop
.data:00001393 00                               nop
.data:00001394 00                               nop
.data:00001395 00                               nop
.data:00001396 00                               nop
.data:00001397 00                               nop
.data:00001398 00                               nop
.data:00001399 00                               nop
.data:0000139a 00                               nop
.data:0000139b 00                               nop
.data:0000139c 00                               nop
.data:0000139d 00                               nop
.data:0000139e 00                               nop
.data:0000139f 00                               nop
.data:000013a0 00                               nop
.data:000013a1 00                               nop
.data:000013a2 00                               nop
.data:000013a3 00                               nop
.data:000013a4 00                               nop
.data:000013a5 00                               nop
.data:000013a6 00                               nop
.data:000013a7 00                               nop
.data:000013a8 00                               nop
.data:000013a9 00                               nop
.data:000013aa 00                               nop
.data:000013ab 00                               nop
.data:000013ac 00                               nop
.data:000013ad 00                               nop
.data:000013ae 00                               nop
.data:000013af 00                               nop
.data:000013b0 00                               nop
.data:000013b1 00                               nop
.data:000013b2 00                               nop
.data:000013b3 00                               nop
.data:000013b4 00                               nop
.data:000013b5 00                               nop
.data:000013b6 00                               nop
.data:000013b7 00                               nop
.data:000013b8 00                               nop
.data:000013b9 00                               nop
.data:000013ba 00                               nop
.data:000013bb 00                               nop
.data:000013bc 00                               nop
.data:000013bd 00                               nop
.data:000013be 00                               nop
.data:000013bf 00                               nop
.data:000013c0 00                               nop
.data:000013c1 00                               nop
.data:000013c2 00                               nop
.data:000013c3 00                               nop
.data:000013c4 00                               nop
.data:000013c5 00                               nop
.data:000013c6 00                               nop
.data:000013c7 00                               nop
.data:000013c8 00                               nop
.data:000013c9 00                               nop
.data:000013ca 00                               nop
.data:000013cb 00                               nop
.data:000013cc 00                               nop
.data:000013cd 01 00 04                         ld bc,0x0400
.data:000013d0 08                               ex af,af'
.data:000013d1 10 10                            djnz 0x13e3
.data:000013d3 20 20                            jr nz,0x13f5
.data:000013d5 0a                               ld a,(bc)
.data:000013d6 15                               dec d
.data:000013d7 2b                               dec hl
.data:000013d8 5f                               ld e,a
.data:000013d9 3f                               ccf
.data:000013da 7c                               ld a,h
.data:000013db bb                               cp e
.data:000013dc 77                               ld (hl),a
.data:000013dd 00                               nop
.data:000013de 00                               nop
.data:000013df 00                               nop
.data:000013e0 00                               nop
.data:000013e1 00                               nop
.data:000013e2 00                               nop
.data:000013e3 00                               nop
.data:000013e4 00                               nop
.data:000013e5 00                               nop
.data:000013e6 00                               nop
.data:000013e7 00                               nop
.data:000013e8 00                               nop
.data:000013e9 00                               nop
.data:000013ea 00                               nop
.data:000013eb 00                               nop
.data:000013ec 00                               nop
.data:000013ed 00                               nop
.data:000013ee 00                               nop
.data:000013ef 00                               nop
.data:000013f0 00                               nop
.data:000013f1 00                               nop
.data:000013f2 00                               nop
.data:000013f3 00                               nop
.data:000013f4 00                               nop
.data:000013f5 00                               nop
.data:000013f6 00                               nop
.data:000013f7 00                               nop
.data:000013f8 00                               nop
.data:000013f9 00                               nop
.data:000013fa 00                               nop
.data:000013fb 00                               nop
.data:000013fc 00                               nop
.data:000013fd 80                               add a,b
.data:000013fe 10 aa                            djnz 0x13aa
.data:00001400 54                               ld d,h
.data:00001401 aa                               xor d
.data:00001402 fd                               defb 0xfd
.data:00001403 fa ff 40                         jp m,0x40ff
.data:00001406 30 0c                            jr nc,0x1414
.data:00001408 03                               inc bc
.data:00001409 08                               ex af,af'
.data:0000140a 50                               ld d,b
.data:0000140b a8                               xor b
.data:0000140c 75                               ld (hl),l
.data:0000140d 00                               nop
.data:0000140e 00                               nop
.data:0000140f 00                               nop
.data:00001410 00                               nop
.data:00001411 80                               add a,b
.data:00001412 40                               ld b,b
.data:00001413 30 0c                            jr nc,0x1421
.data:00001415 00                               nop
.data:00001416 00                               nop
.data:00001417 00                               nop
.data:00001418 00                               nop
.data:00001419 00                               nop
.data:0000141a 00                               nop
.data:0000141b 00                               nop
.data:0000141c 00                               nop
.data:0000141d 17                               rla
.data:0000141e 17                               rla
.data:0000141f 37                               scf
.data:00001420 37                               scf
.data:00001421 37                               scf
.data:00001422 77                               ld (hl),a
.data:00001423 7b                               ld a,e
.data:00001424 7b                               ld a,e
.data:00001425 ff                               rst 0x38
.data:00001426 ff                               rst 0x38
.data:00001427 ff                               rst 0x38
.data:00001428 bf                               cp a
.data:00001429 bf                               cp a
.data:0000142a df                               rst 0x18
.data:0000142b df                               rst 0x18
.data:0000142c df                               rst 0x18
.data:0000142d c7                               rst 0x00
.data:0000142e f3                               di
.data:0000142f f9                               ld sp,hl
.data:00001430 dc de df                         call c,0xdfde
.data:00001433 ef                               rst 0x28
.data:00001434 ef                               rst 0x28
.data:00001435 d1                               pop de
.data:00001436 ea ff ff                         jp pe,0xffff
.data:00001439 7f                               ld a,a
.data:0000143a 3f                               ccf
.data:0000143b cf                               rst 0x08
.data:0000143c e2 00 a0                         jp po,0xa000
.data:0000143f 50                               ld d,b
.data:00001440 e4 b0 f8                         call po,0xf8b0
.data:00001443 f4 e8 e0                         call p,0xe0e8
.data:00001446 c0                               ret nz
.data:00001447 c0                               ret nz
.data:00001448 80                               add a,b
.data:00001449 80                               add a,b
.data:0000144a 80                               add a,b
.data:0000144b 00                               nop
.data:0000144c 00                               nop
.data:0000144d 00                               nop
.data:0000144e 00                               nop
.data:0000144f 00                               nop
.data:00001450 00                               nop
.data:00001451 03                               inc bc
.data:00001452 07                               rlca
.data:00001453 1f                               rra
.data:00001454 3f                               ccf
.data:00001455 00                               nop
.data:00001456 07                               rlca
.data:00001457 3f                               ccf
.data:00001458 ff                               rst 0x38
.data:00001459 ff                               rst 0x38
.data:0000145a ff                               rst 0x38
.data:0000145b ff                               rst 0x38
.data:0000145c ff                               rst 0x38
.data:0000145d ff                               rst 0x38
.data:0000145e ff                               rst 0x38
.data:0000145f ff                               rst 0x38
.data:00001460 ff                               rst 0x38
.data:00001461 ff                               rst 0x38
.data:00001462 ff                               rst 0x38
.data:00001463 ff                               rst 0x38
.data:00001464 ff                               rst 0x38
.data:00001465 ff                               rst 0x38
.data:00001466 ff                               rst 0x38
.data:00001467 ff                               rst 0x38
.data:00001468 ff                               rst 0x38
.data:00001469 ff                               rst 0x38
.data:0000146a ff                               rst 0x38
.data:0000146b ff                               rst 0x38
.data:0000146c ff                               rst 0x38
.data:0000146d ff                               rst 0x38
.data:0000146e ff                               rst 0x38
.data:0000146f ff                               rst 0x38
.data:00001470 ff                               rst 0x38
.data:00001471 ff                               rst 0x38
.data:00001472 ff                               rst 0x38
.data:00001473 ff                               rst 0x38
.data:00001474 ff                               rst 0x38
.data:00001475 00                               nop
.data:00001476 e0                               ret po
.data:00001477 fc ff ff                         call m,0xffff
.data:0000147a ff                               rst 0x38
.data:0000147b ff                               rst 0x38
.data:0000147c ff                               rst 0x38
.data:0000147d 00                               nop
.data:0000147e 00                               nop
.data:0000147f 00                               nop
.data:00001480 00                               nop
.data:00001481 c0                               ret nz
.data:00001482 e0                               ret po
.data:00001483 f8                               ret m
.data:00001484 fc 00 00                         call m,0x0000
.data:00001487 00                               nop
.data:00001488 00                               nop
.data:00001489 00                               nop
.data:0000148a 00                               nop
.data:0000148b 00                               nop
.data:0000148c 00                               nop
.data:0000148d 00                               nop
.data:0000148e 00                               nop
.data:0000148f 00                               nop
.data:00001490 00                               nop
.data:00001491 00                               nop
.data:00001492 00                               nop
.data:00001493 00                               nop
.data:00001494 00                               nop
.data:00001495 00                               nop
.data:00001496 00                               nop
.data:00001497 00                               nop
.data:00001498 00                               nop
.data:00001499 00                               nop
.data:0000149a 00                               nop
.data:0000149b 00                               nop
.data:0000149c 00                               nop
.data:0000149d 00                               nop
.data:0000149e 00                               nop
.data:0000149f 00                               nop
.data:000014a0 00                               nop
.data:000014a1 00                               nop
.data:000014a2 00                               nop
.data:000014a3 00                               nop
.data:000014a4 00                               nop
.data:000014a5 00                               nop
.data:000014a6 00                               nop
.data:000014a7 00                               nop
.data:000014a8 00                               nop
.data:000014a9 00                               nop
.data:000014aa 00                               nop
.data:000014ab 00                               nop
.data:000014ac 00                               nop
.data:000014ad 00                               nop
.data:000014ae 00                               nop
.data:000014af 00                               nop
.data:000014b0 00                               nop
.data:000014b1 00                               nop
.data:000014b2 00                               nop
.data:000014b3 00                               nop
.data:000014b4 00                               nop
.data:000014b5 00                               nop
.data:000014b6 00                               nop
.data:000014b7 00                               nop
.data:000014b8 00                               nop
.data:000014b9 00                               nop
.data:000014ba 00                               nop
.data:000014bb 00                               nop
.data:000014bc 00                               nop
.data:000014bd 00                               nop
.data:000014be 00                               nop
.data:000014bf 00                               nop
.data:000014c0 00                               nop
.data:000014c1 00                               nop
.data:000014c2 00                               nop
.data:000014c3 00                               nop
.data:000014c4 00                               nop
.data:000014c5 00                               nop
.data:000014c6 00                               nop
.data:000014c7 00                               nop
.data:000014c8 00                               nop
.data:000014c9 00                               nop
.data:000014ca 00                               nop
.data:000014cb 00                               nop
.data:000014cc 01 20 41                         ld bc,0x4120
.data:000014cf 40                               ld b,b
.data:000014d0 41                               ld b,c
.data:000014d1 48                               ld c,b
.data:000014d2 81                               add a,c
.data:000014d3 89                               adc a,c
.data:000014d4 14                               inc d
.data:000014d5 ef                               rst 0x28
.data:000014d6 5f                               ld e,a
.data:000014d7 df                               rst 0x18
.data:000014d8 bf                               cp a
.data:000014d9 bf                               cp a
.data:000014da 7f                               ld a,a
.data:000014db 7f                               ld a,a
.data:000014dc ff                               rst 0x38
.data:000014dd 00                               nop
.data:000014de 00                               nop
.data:000014df 00                               nop
.data:000014e0 00                               nop
.data:000014e1 00                               nop
.data:000014e2 00                               nop
.data:000014e3 00                               nop
.data:000014e4 00                               nop
.data:000014e5 00                               nop
.data:000014e6 00                               nop
.data:000014e7 00                               nop
.data:000014e8 00                               nop
.data:000014e9 00                               nop
.data:000014ea 00                               nop
.data:000014eb 00                               nop
.data:000014ec 00                               nop
.data:000014ed 00                               nop
.data:000014ee 00                               nop
.data:000014ef 00                               nop
.data:000014f0 00                               nop
.data:000014f1 00                               nop
.data:000014f2 00                               nop
.data:000014f3 00                               nop
.data:000014f4 00                               nop
.data:000014f5 00                               nop
.data:000014f6 00                               nop
.data:000014f7 00                               nop
.data:000014f8 00                               nop
.data:000014f9 00                               nop
.data:000014fa 00                               nop
.data:000014fb 00                               nop
.data:000014fc 00                               nop
.data:000014fd 5f                               ld e,a
.data:000014fe 2a 05 20                         ld hl,(0x2005)
.data:00001501 50                               ld d,b
.data:00001502 f5                               push af
.data:00001503 ff                               rst 0x38
.data:00001504 ff                               rst 0x38
.data:00001505 ff                               rst 0x38
.data:00001506 ff                               rst 0x38
.data:00001507 af                               xor a
.data:00001508 57                               ld d,a
.data:00001509 0b                               dec bc
.data:0000150a 02                               ld (bc),a
.data:0000150b 55                               ld d,l
.data:0000150c fa a2 51                         jp m,0x51a2
.data:0000150f e8                               ret pe
.data:00001510 d4 fa f5                         call nc,0xf5fa
.data:00001513 fa ff 00                         jp m,0x00ff
.data:00001516 00                               nop
.data:00001517 80                               add a,b
.data:00001518 60                               ld h,b
.data:00001519 18 06                            jr 0x1521
.data:0000151b 20 54                            jr nz,0x1571
.data:0000151d 7b                               ld a,e
.data:0000151e fb                               ei
.data:0000151f fd                               defb 0xfd
.data:00001520 fd                               defb 0xfd
.data:00001521 fd 9d                            sbc a,iyl
.data:00001523 86                               add a,(hl)
.data:00001524 58                               ld e,b
.data:00001525 ef                               rst 0x28
.data:00001526 ef                               rst 0x28
.data:00001527 f7                               rst 0x30
.data:00001528 f7                               rst 0x30
.data:00001529 fb                               ei
.data:0000152a ff                               rst 0x38
.data:0000152b ff                               rst 0x38
.data:0000152c ff                               rst 0x38
.data:0000152d f7                               rst 0x30
.data:0000152e f7                               rst 0x30
.data:0000152f f7                               rst 0x30
.data:00001530 fb                               ei
.data:00001531 fb                               ei
.data:00001532 fd                               defb 0xfd
.data:00001533 fd                               defb 0xfd
.data:00001534 fe f9                            cp 0xf9
.data:00001536 fc ff df                         call m,0xdfff
.data:00001539 e7                               rst 0x20
.data:0000153a f9                               ld sp,hl
.data:0000153b ff                               rst 0x38
.data:0000153c ff                               rst 0x38
.data:0000153d 8f                               adc a,a
.data:0000153e e6 f6                            and 0xf6
.data:00001540 3e 1c                            ld a,0x1c
.data:00001542 08                               ex af,af'
.data:00001543 0c                               inc c
.data:00001544 04                               inc b
.data:00001545 c0                               ret nz
.data:00001546 c1                               pop bc
.data:00001547 c3 e7 ef                         jp 0xefe7
.data:0000154a df                               rst 0x18
.data:0000154b bf                               cp a
.data:0000154c 7f                               ld a,a
.data:0000154d ff                               rst 0x38
.data:0000154e ff                               rst 0x38
.data:0000154f ff                               rst 0x38
.data:00001550 ff                               rst 0x38
.data:00001551 ff                               rst 0x38
.data:00001552 ff                               rst 0x38
.data:00001553 ff                               rst 0x38
.data:00001554 ff                               rst 0x38
.data:00001555 ff                               rst 0x38
.data:00001556 ff                               rst 0x38
.data:00001557 ff                               rst 0x38
.data:00001558 ff                               rst 0x38
.data:00001559 ff                               rst 0x38
.data:0000155a ff                               rst 0x38
.data:0000155b ff                               rst 0x38
.data:0000155c ff                               rst 0x38
.data:0000155d ff                               rst 0x38
.data:0000155e ff                               rst 0x38
.data:0000155f ff                               rst 0x38
.data:00001560 ff                               rst 0x38
.data:00001561 ff                               rst 0x38
.data:00001562 ff                               rst 0x38
.data:00001563 ff                               rst 0x38
.data:00001564 ff                               rst 0x38
.data:00001565 ff                               rst 0x38
.data:00001566 ff                               rst 0x38
.data:00001567 ff                               rst 0x38
.data:00001568 ff                               rst 0x38
.data:00001569 ff                               rst 0x38
.data:0000156a ff                               rst 0x38
.data:0000156b ff                               rst 0x38
.data:0000156c ff                               rst 0x38
.data:0000156d 81                               add a,c
.data:0000156e 00                               nop
.data:0000156f 00                               nop
.data:00001570 80                               add a,b
.data:00001571 80                               add a,b
.data:00001572 c0                               ret nz
.data:00001573 e0                               ret po
.data:00001574 f8                               ret m
.data:00001575 ff                               rst 0x38
.data:00001576 7f                               ld a,a
.data:00001577 3f                               ccf
.data:00001578 1f                               rra
.data:00001579 1f                               rra
.data:0000157a 0f                               rrca
.data:0000157b 0f                               rrca
.data:0000157c 1f                               rra
.data:0000157d ff                               rst 0x38
.data:0000157e ff                               rst 0x38
.data:0000157f ff                               rst 0x38
.data:00001580 ff                               rst 0x38
.data:00001581 ff                               rst 0x38
.data:00001582 ff                               rst 0x38
.data:00001583 ff                               rst 0x38
.data:00001584 ff                               rst 0x38
.data:00001585 00                               nop
.data:00001586 80                               add a,b
.data:00001587 c0                               ret nz
.data:00001588 e0                               ret po
.data:00001589 f0                               ret p
.data:0000158a f8                               ret m
.data:0000158b fc fe 00                         call m,0x00fe
.data:0000158e 00                               nop
.data:0000158f 00                               nop
.data:00001590 00                               nop
.data:00001591 00                               nop
.data:00001592 00                               nop
.data:00001593 00                               nop
.data:00001594 00                               nop
.data:00001595 00                               nop
.data:00001596 00                               nop
.data:00001597 00                               nop
.data:00001598 00                               nop
.data:00001599 00                               nop
.data:0000159a 00                               nop
.data:0000159b 00                               nop
.data:0000159c 00                               nop
.data:0000159d 00                               nop
.data:0000159e 00                               nop
.data:0000159f 00                               nop
.data:000015a0 00                               nop
.data:000015a1 00                               nop
.data:000015a2 00                               nop
.data:000015a3 00                               nop
.data:000015a4 00                               nop
.data:000015a5 00                               nop
.data:000015a6 00                               nop
.data:000015a7 00                               nop
.data:000015a8 00                               nop
.data:000015a9 00                               nop
.data:000015aa 00                               nop
.data:000015ab 00                               nop
.data:000015ac 00                               nop
.data:000015ad 00                               nop
.data:000015ae 00                               nop
.data:000015af 00                               nop
.data:000015b0 00                               nop
.data:000015b1 00                               nop
.data:000015b2 00                               nop
.data:000015b3 00                               nop
.data:000015b4 00                               nop
.data:000015b5 00                               nop
.data:000015b6 00                               nop
.data:000015b7 00                               nop
.data:000015b8 00                               nop
.data:000015b9 00                               nop
.data:000015ba 00                               nop
.data:000015bb 00                               nop
.data:000015bc 1f                               rra
.data:000015bd 00                               nop
.data:000015be 00                               nop
.data:000015bf 00                               nop
.data:000015c0 00                               nop
.data:000015c1 00                               nop
.data:000015c2 01 7c 80                         ld bc,0x807c
.data:000015c5 01 02 04                         ld bc,0x0402
.data:000015c8 08                               ex af,af'
.data:000015c9 30 c1                            jr nc,0x158c
.data:000015cb 02                               ld (bc),a
.data:000015cc 15                               dec d
.data:000015cd 28 14                            jr z,0x15e3
.data:000015cf 2e 5e                            ld l,0x5e
.data:000015d1 be                               cp (hl)
.data:000015d2 5e                               ld e,(hl)
.data:000015d3 be                               cp (hl)
.data:000015d4 ff                               rst 0x38
.data:000015d5 fe d5                            cp 0xd5
.data:000015d7 ea d0 a0                         jp pe,0xa0d0
.data:000015da d0                               ret nc
.data:000015db aa                               xor d
.data:000015dc f5                               push af
.data:000015dd 00                               nop
.data:000015de 00                               nop
.data:000015df 00                               nop
.data:000015e0 00                               nop
.data:000015e1 00                               nop
.data:000015e2 00                               nop
.data:000015e3 00                               nop
.data:000015e4 00                               nop
.data:000015e5 00                               nop
.data:000015e6 00                               nop
.data:000015e7 00                               nop
.data:000015e8 00                               nop
.data:000015e9 00                               nop
.data:000015ea 00                               nop
.data:000015eb 00                               nop
.data:000015ec 00                               nop
.data:000015ed 00                               nop
.data:000015ee 00                               nop
.data:000015ef 00                               nop
.data:000015f0 00                               nop
.data:000015f1 00                               nop
.data:000015f2 00                               nop
.data:000015f3 00                               nop
.data:000015f4 00                               nop
.data:000015f5 00                               nop
.data:000015f6 00                               nop
.data:000015f7 00                               nop
.data:000015f8 00                               nop
.data:000015f9 00                               nop
.data:000015fa 00                               nop
.data:000015fb 00                               nop
.data:000015fc 00                               nop
.data:000015fd eb                               ex de,hl
.data:000015fe c0                               ret nz
.data:000015ff f0                               ret p
.data:00001600 f1                               pop af
.data:00001601 f8                               ret m
.data:00001602 fd                               defb 0xfd
.data:00001603 fe fe                            cp 0xfe
.data:00001605 7f                               ld a,a
.data:00001606 2f                               cpl
.data:00001607 15                               dec d
.data:00001608 0b                               dec bc
.data:00001609 81                               add a,c
.data:0000160a 80                               add a,b
.data:0000160b c1                               pop bc
.data:0000160c c4 ff fe                         call nz,0xfeff
.data:0000160f fe fe                            cp 0xfe
.data:00001611 fd                               defb 0xfd
.data:00001612 bb                               cp e
.data:00001613 5e                               ld e,(hl)
.data:00001614 2b                               dec hl
.data:00001615 2a f5 fa                         ld hl,(0xfaf5)
.data:00001618 ff                               rst 0x38
.data:00001619 bf                               cp a
.data:0000161a 7f                               ld a,a
.data:0000161b bd                               cp l
.data:0000161c 2a 74 3c                         ld hl,(0x3c74)
.data:0000161f 8c                               adc a,h
.data:00001620 40                               ld b,b
.data:00001621 ab                               xor e
.data:00001622 d5                               push de
.data:00001623 6a                               ld l,d
.data:00001624 1d                               dec e
.data:00001625 7f                               ld a,a
.data:00001626 7f                               ld a,a
.data:00001627 7f                               ld a,a
.data:00001628 3f                               ccf
.data:00001629 3f                               ccf
.data:0000162a bf                               cp a
.data:0000162b 9f                               sbc a,a
.data:0000162c 1f                               rra
.data:0000162d f7                               rst 0x30
.data:0000162e 77                               ld (hl),a
.data:0000162f f7                               rst 0x30
.data:00001630 bb                               cp e
.data:00001631 db ed                            in a,(0xed)
.data:00001633 f6 f9                            or 0xf9
.data:00001635 ff                               rst 0x38
.data:00001636 ff                               rst 0x38
.data:00001637 ff                               rst 0x38
.data:00001638 ff                               rst 0x38
.data:00001639 ff                               rst 0x38
.data:0000163a ff                               rst 0x38
.data:0000163b ff                               rst 0x38
.data:0000163c ff                               rst 0x38
.data:0000163d 03                               inc bc
.data:0000163e 01 01 01                         ld bc,0x0101
.data:00001641 03                               inc bc
.data:00001642 03                               inc bc
.data:00001643 07                               rlca
.data:00001644 0f                               rrca
.data:00001645 ff                               rst 0x38
.data:00001646 ff                               rst 0x38
.data:00001647 ff                               rst 0x38
.data:00001648 ff                               rst 0x38
.data:00001649 ff                               rst 0x38
.data:0000164a ff                               rst 0x38
.data:0000164b ff                               rst 0x38
.data:0000164c ff                               rst 0x38
.data:0000164d ff                               rst 0x38
.data:0000164e ff                               rst 0x38
.data:0000164f ff                               rst 0x38
.data:00001650 ff                               rst 0x38
.data:00001651 ff                               rst 0x38
.data:00001652 ff                               rst 0x38
.data:00001653 ff                               rst 0x38
.data:00001654 ff                               rst 0x38
.data:00001655 ff                               rst 0x38
.data:00001656 ff                               rst 0x38
.data:00001657 ff                               rst 0x38
.data:00001658 ff                               rst 0x38
.data:00001659 ff                               rst 0x38
.data:0000165a ff                               rst 0x38
.data:0000165b ff                               rst 0x38
.data:0000165c ff                               rst 0x38
.data:0000165d ff                               rst 0x38
.data:0000165e ff                               rst 0x38
.data:0000165f ff                               rst 0x38
.data:00001660 ff                               rst 0x38
.data:00001661 ff                               rst 0x38
.data:00001662 ff                               rst 0x38
.data:00001663 ff                               rst 0x38
.data:00001664 ff                               rst 0x38
.data:00001665 ff                               rst 0x38
.data:00001666 ff                               rst 0x38
.data:00001667 ff                               rst 0x38
.data:00001668 ff                               rst 0x38
.data:00001669 ff                               rst 0x38
.data:0000166a ff                               rst 0x38
.data:0000166b ff                               rst 0x38
.data:0000166c ff                               rst 0x38
.data:0000166d ff                               rst 0x38
.data:0000166e ff                               rst 0x38
.data:0000166f ff                               rst 0x38
.data:00001670 ff                               rst 0x38
.data:00001671 ff                               rst 0x38
.data:00001672 ff                               rst 0x38
.data:00001673 ff                               rst 0x38
.data:00001674 ff                               rst 0x38
.data:00001675 ff                               rst 0x38
.data:00001676 ff                               rst 0x38
.data:00001677 ff                               rst 0x38
.data:00001678 ff                               rst 0x38
.data:00001679 ff                               rst 0x38
.data:0000167a ff                               rst 0x38
.data:0000167b ff                               rst 0x38
.data:0000167c ff                               rst 0x38
.data:0000167d ff                               rst 0x38
.data:0000167e ff                               rst 0x38
.data:0000167f ff                               rst 0x38
.data:00001680 ff                               rst 0x38
.data:00001681 ff                               rst 0x38
.data:00001682 ff                               rst 0x38
.data:00001683 ff                               rst 0x38
.data:00001684 ff                               rst 0x38
.data:00001685 ff                               rst 0x38
.data:00001686 ff                               rst 0x38
.data:00001687 ff                               rst 0x38
.data:00001688 ff                               rst 0x38
.data:00001689 ff                               rst 0x38
.data:0000168a ff                               rst 0x38
.data:0000168b ff                               rst 0x38
.data:0000168c ff                               rst 0x38
.data:0000168d 00                               nop
.data:0000168e 00                               nop
.data:0000168f 80                               add a,b
.data:00001690 c0                               ret nz
.data:00001691 c0                               ret nz
.data:00001692 e0                               ret po
.data:00001693 f0                               ret p
.data:00001694 f0                               ret p
.data:00001695 00                               nop
.data:00001696 00                               nop
.data:00001697 00                               nop
.data:00001698 00                               nop
.data:00001699 00                               nop
.data:0000169a 00                               nop
.data:0000169b 00                               nop
.data:0000169c 00                               nop
.data:0000169d 00                               nop
.data:0000169e 00                               nop
.data:0000169f 00                               nop
.data:000016a0 00                               nop
.data:000016a1 00                               nop
.data:000016a2 00                               nop
.data:000016a3 00                               nop
.data:000016a4 00                               nop
.data:000016a5 00                               nop
.data:000016a6 00                               nop
.data:000016a7 00                               nop
.data:000016a8 01 06 08                         ld bc,0x0806
.data:000016ab 10 20                            djnz 0x16cd
.data:000016ad 01 0e 70                         ld bc,0x700e
.data:000016b0 80                               add a,b
.data:000016b1 01 08 41                         ld bc,0x4108
.data:000016b4 aa                               xor d
.data:000016b5 e0                               ret po
.data:000016b6 00                               nop
.data:000016b7 05                               dec b
.data:000016b8 0a                               ld a,(bc)
.data:000016b9 55                               ld d,l
.data:000016ba 8b                               adc a,e
.data:000016bb 1f                               rra
.data:000016bc bf                               cp a
.data:000016bd 02                               ld (bc),a
.data:000016be 09                               add hl,bc
.data:000016bf 53                               ld d,e
.data:000016c0 ab                               xor e
.data:000016c1 5a                               ld e,d
.data:000016c2 fa fd fd                         jp m,0xfdfd
.data:000016c5 ab                               xor e
.data:000016c6 17                               rla
.data:000016c7 7f                               ld a,a
.data:000016c8 7f                               ld a,a
.data:000016c9 ff                               rst 0x38
.data:000016ca ff                               rst 0x38
.data:000016cb fd                               defb 0xfd
.data:000016cc aa                               xor d
.data:000016cd ff                               rst 0x38
.data:000016ce ff                               rst 0x38
.data:000016cf ff                               rst 0x38
.data:000016d0 ff                               rst 0x38
.data:000016d1 ff                               rst 0x38
.data:000016d2 aa                               xor d
.data:000016d3 51                               ld d,c
.data:000016d4 80                               add a,b
.data:000016d5 7f                               ld a,a
.data:000016d6 7f                               ld a,a
.data:000016d7 7f                               ld a,a
.data:000016d8 bf                               cp a
.data:000016d9 af                               xor a
.data:000016da 92                               sub d
.data:000016db 05                               dec b
.data:000016dc 00                               nop
.data:000016dd 00                               nop
.data:000016de 00                               nop
.data:000016df 00                               nop
.data:000016e0 00                               nop
.data:000016e1 00                               nop
.data:000016e2 00                               nop
.data:000016e3 00                               nop
.data:000016e4 00                               nop
.data:000016e5 00                               nop
.data:000016e6 00                               nop
.data:000016e7 00                               nop
.data:000016e8 00                               nop
.data:000016e9 00                               nop
.data:000016ea 00                               nop
.data:000016eb 00                               nop
.data:000016ec 00                               nop
.data:000016ed 00                               nop
.data:000016ee 00                               nop
.data:000016ef 00                               nop
.data:000016f0 00                               nop
.data:000016f1 00                               nop
.data:000016f2 00                               nop
.data:000016f3 00                               nop
.data:000016f4 00                               nop
.data:000016f5 00                               nop
.data:000016f6 00                               nop
.data:000016f7 00                               nop
.data:000016f8 00                               nop
.data:000016f9 00                               nop
.data:000016fa 00                               nop
.data:000016fb 00                               nop
.data:000016fc 00                               nop
.data:000016fd 5f                               ld e,a
.data:000016fe af                               xor a
.data:000016ff 55                               ld d,l
.data:00001700 0f                               rrca
.data:00001701 05                               dec b
.data:00001702 0a                               ld a,(bc)
.data:00001703 81                               add a,c
.data:00001704 02                               ld (bc),a
.data:00001705 68                               ld l,b
.data:00001706 64                               ld h,h
.data:00001707 6a                               ld l,d
.data:00001708 a5                               and l
.data:00001709 a6                               and (hl)
.data:0000170a cd c6 cf                         call 0xcfc6
.data:0000170d 15                               dec d
.data:0000170e 2a 04 08                         ld hl,(0x0804)
.data:00001711 94                               sub h
.data:00001712 09                               add hl,bc
.data:00001713 80                               add a,b
.data:00001714 41                               ld b,c
.data:00001715 15                               dec d
.data:00001716 2a 55 8e                         ld hl,(0x8e55)
.data:00001719 35                               dec (hl)
.data:0000171a 5f                               ld e,a
.data:0000171b bf                               cp a
.data:0000171c 5f                               ld e,a
.data:0000171d 06 83                            ld b,0x83
.data:0000171f 51                               ld d,c
.data:00001720 a0                               and b
.data:00001721 d4 a8 f4                         call nc,0xf4a8
.data:00001724 fa 4f 4f                         jp m,0x4f4f
.data:00001727 27                               daa
.data:00001728 83                               add a,e
.data:00001729 11 20 14                         ld de,0x1420
.data:0000172c 0b                               dec bc
.data:0000172d f0                               ret p
.data:0000172e e0                               ret po
.data:0000172f e0                               ret po
.data:00001730 cc 81 8a                         call z,0x8a81
.data:00001733 60                               ld h,b
.data:00001734 00                               nop
.data:00001735 bf                               cp a
.data:00001736 0f                               rrca
.data:00001737 00                               nop
.data:00001738 00                               nop
.data:00001739 01 40 30                         ld bc,0x3040
.data:0000173c 06 9f                            ld b,0x9f
.data:0000173e 1f                               rra
.data:0000173f 3f                               ccf
.data:00001740 3f                               ccf
.data:00001741 3f                               ccf
.data:00001742 ff                               rst 0x38
.data:00001743 ff                               rst 0x38
.data:00001744 ff                               rst 0x38
.data:00001745 ff                               rst 0x38
.data:00001746 ff                               rst 0x38
.data:00001747 ff                               rst 0x38
.data:00001748 ff                               rst 0x38
.data:00001749 ff                               rst 0x38
.data:0000174a ff                               rst 0x38
.data:0000174b ff                               rst 0x38
.data:0000174c ff                               rst 0x38
.data:0000174d ff                               rst 0x38
.data:0000174e ff                               rst 0x38
.data:0000174f ff                               rst 0x38
.data:00001750 ff                               rst 0x38
.data:00001751 ff                               rst 0x38
.data:00001752 ff                               rst 0x38
.data:00001753 ff                               rst 0x38
.data:00001754 ff                               rst 0x38
.data:00001755 ff                               rst 0x38
.data:00001756 ff                               rst 0x38
.data:00001757 ff                               rst 0x38
.data:00001758 ff                               rst 0x38
.data:00001759 ff                               rst 0x38
.data:0000175a ff                               rst 0x38
.data:0000175b ff                               rst 0x38
.data:0000175c ff                               rst 0x38
.data:0000175d ff                               rst 0x38
.data:0000175e ff                               rst 0x38
.data:0000175f ff                               rst 0x38
.data:00001760 ff                               rst 0x38
.data:00001761 ff                               rst 0x38
.data:00001762 ff                               rst 0x38
.data:00001763 ff                               rst 0x38
.data:00001764 ff                               rst 0x38
.data:00001765 ff                               rst 0x38
.data:00001766 ff                               rst 0x38
.data:00001767 ff                               rst 0x38
.data:00001768 ff                               rst 0x38
.data:00001769 ff                               rst 0x38
.data:0000176a ff                               rst 0x38
.data:0000176b ff                               rst 0x38
.data:0000176c ff                               rst 0x38
.data:0000176d ff                               rst 0x38
.data:0000176e ff                               rst 0x38
.data:0000176f ff                               rst 0x38
.data:00001770 ff                               rst 0x38
.data:00001771 ff                               rst 0x38
.data:00001772 ff                               rst 0x38
.data:00001773 ff                               rst 0x38
.data:00001774 ff                               rst 0x38
.data:00001775 ff                               rst 0x38
.data:00001776 ff                               rst 0x38
.data:00001777 ff                               rst 0x38
.data:00001778 ff                               rst 0x38
.data:00001779 ff                               rst 0x38
.data:0000177a ff                               rst 0x38
.data:0000177b ff                               rst 0x38
.data:0000177c ff                               rst 0x38
.data:0000177d ff                               rst 0x38
.data:0000177e ff                               rst 0x38
.data:0000177f ff                               rst 0x38
.data:00001780 ff                               rst 0x38
.data:00001781 ff                               rst 0x38
.data:00001782 ff                               rst 0x38
.data:00001783 ff                               rst 0x38
.data:00001784 ff                               rst 0x38
.data:00001785 ff                               rst 0x38
.data:00001786 ff                               rst 0x38
.data:00001787 ff                               rst 0x38
.data:00001788 ff                               rst 0x38
.data:00001789 ff                               rst 0x38
.data:0000178a ff                               rst 0x38
.data:0000178b ff                               rst 0x38
.data:0000178c ff                               rst 0x38
.data:0000178d f8                               ret m
.data:0000178e f8                               ret m
.data:0000178f fc fc fc                         call m,0xfcfc
.data:00001792 fe fe                            cp 0xfe
.data:00001794 fe 00                            cp 0x00
.data:00001796 00                               nop
.data:00001797 00                               nop
.data:00001798 00                               nop
.data:00001799 00                               nop
.data:0000179a 00                               nop
.data:0000179b 80                               add a,b
.data:0000179c 80                               add a,b
.data:0000179d 00                               nop
.data:0000179e 00                               nop
.data:0000179f 00                               nop
.data:000017a0 00                               nop
.data:000017a1 00                               nop
.data:000017a2 02                               ld (bc),a
.data:000017a3 00                               nop
.data:000017a4 04                               inc b
.data:000017a5 25                               dec h
.data:000017a6 42                               ld b,d
.data:000017a7 05                               dec b
.data:000017a8 8b                               adc a,e
.data:000017a9 17                               rla
.data:000017aa 2b                               dec hl
.data:000017ab 17                               rla
.data:000017ac ac                               xor h
.data:000017ad 53                               ld d,e
.data:000017ae db 5a                            in a,(0x5a)
.data:000017b0 da bd bd                         jp c,0xbdbd
.data:000017b3 1d                               dec e
.data:000017b4 de bd                            sbc a,0xbd
.data:000017b6 7d                               ld a,l
.data:000017b7 fd                               defb 0xfd
.data:000017b8 fc fc ea                         call m,0xeafc
.data:000017bb d4 a8 fd                         call nc,0xfda8
.data:000017be fa d5 a8                         jp m,0xa8d5
.data:000017c1 00                               nop
.data:000017c2 01 0a 10                         ld bc,0x100a
.data:000017c5 55                               ld d,l
.data:000017c6 00                               nop
.data:000017c7 00                               nop
.data:000017c8 06 28                            ld b,0x28
.data:000017ca 40                               ld b,b
.data:000017cb 00                               nop
.data:000017cc 00                               nop
.data:000017cd 00                               nop
.data:000017ce 06 68                            ld b,0x68
.data:000017d0 80                               add a,b
.data:000017d1 00                               nop
.data:000017d2 00                               nop
.data:000017d3 01 2a 00                         ld bc,0x002a
.data:000017d6 f0                               ret p
.data:000017d7 0c                               inc c
.data:000017d8 03                               inc bc
.data:000017d9 00                               nop
.data:000017da 20 54                            jr nz,0x1830
.data:000017dc aa                               xor d
.data:000017dd 00                               nop
.data:000017de 00                               nop
.data:000017df 00                               nop
.data:000017e0 00                               nop
.data:000017e1 00                               nop
.data:000017e2 00                               nop
.data:000017e3 00                               nop
.data:000017e4 00                               nop
.data:000017e5 00                               nop
.data:000017e6 00                               nop
.data:000017e7 00                               nop
.data:000017e8 00                               nop
.data:000017e9 00                               nop
.data:000017ea 00                               nop
.data:000017eb 00                               nop
.data:000017ec 00                               nop
.data:000017ed 00                               nop
.data:000017ee 00                               nop
.data:000017ef 00                               nop
.data:000017f0 00                               nop
.data:000017f1 00                               nop
.data:000017f2 00                               nop
.data:000017f3 00                               nop
.data:000017f4 00                               nop
.data:000017f5 00                               nop
.data:000017f6 00                               nop
.data:000017f7 00                               nop
.data:000017f8 00                               nop
.data:000017f9 00                               nop
.data:000017fa 00                               nop
.data:000017fb 00                               nop
.data:000017fc 00                               nop
.data:000017fd 83                               add a,e
.data:000017fe 55                               ld d,l
.data:000017ff aa                               xor d
.data:00001800 f7                               rst 0x30
.data:00001801 ff                               rst 0x38
.data:00001802 ff                               rst 0x38
.data:00001803 ff                               rst 0x38
.data:00001804 ff                               rst 0x38
.data:00001805 ee ef                            xor 0xef
.data:00001807 ee df                            xor 0xdf
.data:00001809 da d7 9a                         jp c,0x9ad7
.data:0000180c 95                               sub l
.data:0000180d 80                               add a,b
.data:0000180e 52                               ld d,d
.data:0000180f a0                               and b
.data:00001810 41                               ld b,c
.data:00001811 a2                               and d
.data:00001812 01 84 49                         ld bc,0x4984
.data:00001815 bf                               cp a
.data:00001816 7f                               ld a,a
.data:00001817 bf                               cp a
.data:00001818 5f                               ld e,a
.data:00001819 ff                               rst 0x38
.data:0000181a 7f                               ld a,a
.data:0000181b ff                               rst 0x38
.data:0000181c 7f                               ld a,a
.data:0000181d f5                               push af
.data:0000181e fa fd fa                         jp m,0xfafd
.data:00001821 fd                               defb 0xfd
.data:00001822 fe f5                            cp 0xf5
.data:00001824 fe 0a                            cp 0x0a
.data:00001826 05                               dec b
.data:00001827 0a                               ld a,(bc)
.data:00001828 80                               add a,b
.data:00001829 02                               ld (bc),a
.data:0000182a a4                               and h
.data:0000182b 02                               ld (bc),a
.data:0000182c 82                               add a,d
.data:0000182d 44                               ld b,h
.data:0000182e 30 11                            jr nc,0x1841
.data:00001830 83                               add a,e
.data:00001831 22 03 a3                         ld (0xa303),hl
.data:00001834 51                               ld d,c
.data:00001835 61                               ld h,c
.data:00001836 07                               rlca
.data:00001837 1f                               rra
.data:00001838 1b                               dec de
.data:00001839 b8                               cp b
.data:0000183a f2 e2 84                         jp p,0x84e2
.data:0000183d ff                               rst 0x38
.data:0000183e fe fe                            cp 0xfe
.data:00001840 fe fc                            cp 0xfc
.data:00001842 7c                               ld a,h
.data:00001843 fc fc ff                         call m,0xfffc
.data:00001846 ff                               rst 0x38
.data:00001847 ff                               rst 0x38
.data:00001848 ff                               rst 0x38
.data:00001849 ff                               rst 0x38
.data:0000184a 7f                               ld a,a
.data:0000184b 7f                               ld a,a
.data:0000184c 7f                               ld a,a
.data:0000184d ff                               rst 0x38
.data:0000184e ff                               rst 0x38
.data:0000184f ff                               rst 0x38
.data:00001850 ff                               rst 0x38
.data:00001851 ff                               rst 0x38
.data:00001852 ff                               rst 0x38
.data:00001853 ff                               rst 0x38
.data:00001854 ff                               rst 0x38
.data:00001855 ff                               rst 0x38
.data:00001856 ff                               rst 0x38
.data:00001857 ff                               rst 0x38
.data:00001858 ff                               rst 0x38
.data:00001859 ff                               rst 0x38
.data:0000185a ff                               rst 0x38
.data:0000185b ff                               rst 0x38
.data:0000185c ff                               rst 0x38
.data:0000185d ff                               rst 0x38
.data:0000185e ff                               rst 0x38
.data:0000185f ff                               rst 0x38
.data:00001860 ff                               rst 0x38
.data:00001861 ff                               rst 0x38
.data:00001862 ff                               rst 0x38
.data:00001863 ff                               rst 0x38
.data:00001864 ff                               rst 0x38
.data:00001865 ff                               rst 0x38
.data:00001866 ff                               rst 0x38
.data:00001867 ff                               rst 0x38
.data:00001868 ff                               rst 0x38
.data:00001869 ff                               rst 0x38
.data:0000186a d9                               exx
.data:0000186b 99                               sbc a,c
.data:0000186c 99                               sbc a,c
.data:0000186d ff                               rst 0x38
.data:0000186e ff                               rst 0x38
.data:0000186f ff                               rst 0x38
.data:00001870 ff                               rst 0x38
.data:00001871 ff                               rst 0x38
.data:00001872 ff                               rst 0x38
.data:00001873 ff                               rst 0x38
.data:00001874 ff                               rst 0x38
.data:00001875 ff                               rst 0x38
.data:00001876 ff                               rst 0x38
.data:00001877 ff                               rst 0x38
.data:00001878 ff                               rst 0x38
.data:00001879 ff                               rst 0x38
.data:0000187a ff                               rst 0x38
.data:0000187b ff                               rst 0x38
.data:0000187c ff                               rst 0x38
.data:0000187d ff                               rst 0x38
.data:0000187e ff                               rst 0x38
.data:0000187f ff                               rst 0x38
.data:00001880 ff                               rst 0x38
.data:00001881 ff                               rst 0x38
.data:00001882 ff                               rst 0x38
.data:00001883 ff                               rst 0x38
.data:00001884 ff                               rst 0x38
.data:00001885 ff                               rst 0x38
.data:00001886 ff                               rst 0x38
.data:00001887 ff                               rst 0x38
.data:00001888 ff                               rst 0x38
.data:00001889 ff                               rst 0x38
.data:0000188a fe fe                            cp 0xfe
.data:0000188c fe ff                            cp 0xff
.data:0000188e ff                               rst 0x38
.data:0000188f 7f                               ld a,a
.data:00001890 7f                               ld a,a
.data:00001891 3f                               ccf
.data:00001892 3f                               ccf
.data:00001893 3f                               ccf
.data:00001894 3f                               ccf
.data:00001895 40                               ld b,b
.data:00001896 68                               ld l,b
.data:00001897 60                               ld h,b
.data:00001898 60                               ld h,b
.data:00001899 f8                               ret m
.data:0000189a d8                               ret c
.data:0000189b 9d                               sbc a,l
.data:0000189c af                               xor a
.data:0000189d 20 82                            jr nz,0x1821
.data:0000189f 05                               dec b
.data:000018a0 0a                               ld a,(bc)
.data:000018a1 91                               sub c
.data:000018a2 c0                               ret nz
.data:000018a3 c0                               ret nz
.data:000018a4 c0                               ret nz
.data:000018a5 5f                               ld e,a
.data:000018a6 be                               cp (hl)
.data:000018a7 55                               ld d,l
.data:000018a8 aa                               xor d
.data:000018a9 10 00                            djnz 0x18ab
.data:000018ab 00                               nop
.data:000018ac 00                               nop
.data:000018ad c4 aa 40                         call nz,0x40aa
.data:000018b0 80                               add a,b
.data:000018b1 00                               nop
.data:000018b2 00                               nop
.data:000018b3 0e 60                            ld c,0x60
.data:000018b5 40                               ld b,b
.data:000018b6 80                               add a,b
.data:000018b7 02                               ld (bc),a
.data:000018b8 0c                               inc c
.data:000018b9 20 c0                            jr nz,0x187b
.data:000018bb 01 2b c0                         ld bc,0xc02b
.data:000018be 00                               nop
.data:000018bf 05                               dec b
.data:000018c0 0a                               ld a,(bc)
.data:000018c1 5f                               ld e,a
.data:000018c2 bb                               cp e
.data:000018c3 7b                               ld a,e
.data:000018c4 f7                               rst 0x30
.data:000018c5 14                               inc d
.data:000018c6 2a 57 ff                         ld hl,(0xff57)
.data:000018c9 ff                               rst 0x38
.data:000018ca ff                               rst 0x38
.data:000018cb ff                               rst 0x38
.data:000018cc eb                               ex de,hl
.data:000018cd d3 f7                            out (0xf7),a
.data:000018cf 77                               ld (hl),a
.data:000018d0 6f                               ld l,a
.data:000018d1 6f                               ld l,a
.data:000018d2 9b                               sbc a,e
.data:000018d3 95                               sub l
.data:000018d4 aa                               xor d
.data:000018d5 f5                               push af
.data:000018d6 fe ff                            cp 0xff
.data:000018d8 ff                               rst 0x38
.data:000018d9 fd                               defb 0xfd
.data:000018da aa                               xor d
.data:000018db 55                               ld d,l
.data:000018dc a0                               and b
.data:000018dd 00                               nop
.data:000018de 00                               nop
.data:000018df 00                               nop
.data:000018e0 00                               nop
.data:000018e1 00                               nop
.data:000018e2 00                               nop
.data:000018e3 00                               nop
.data:000018e4 00                               nop
.data:000018e5 00                               nop
.data:000018e6 00                               nop
.data:000018e7 00                               nop
.data:000018e8 00                               nop
.data:000018e9 00                               nop
.data:000018ea 00                               nop
.data:000018eb 00                               nop
.data:000018ec 00                               nop
.data:000018ed 00                               nop
.data:000018ee 00                               nop
.data:000018ef 00                               nop
.data:000018f0 00                               nop
.data:000018f1 00                               nop
.data:000018f2 00                               nop
.data:000018f3 00                               nop
.data:000018f4 00                               nop
.data:000018f5 00                               nop
.data:000018f6 00                               nop
.data:000018f7 00                               nop
.data:000018f8 00                               nop
.data:000018f9 00                               nop
.data:000018fa 00                               nop
.data:000018fb 00                               nop
.data:000018fc 00                               nop
.data:000018fd 3b                               dec sp
.data:000018fe 90                               sub b
.data:000018ff 40                               ld b,b
.data:00001900 00                               nop
.data:00001901 a8                               xor b
.data:00001902 40                               ld b,b
.data:00001903 aa                               xor d
.data:00001904 75                               ld (hl),l
.data:00001905 0a                               ld a,(bc)
.data:00001906 15                               dec d
.data:00001907 2a 05 08                         ld hl,(0x0805)
.data:0000190a 00                               nop
.data:0000190b 00                               nop
.data:0000190c 50                               ld d,b
.data:0000190d 82                               add a,d
.data:0000190e 01 8a 01                         ld bc,0x018a
.data:00001911 12                               ld (de),a
.data:00001912 28 15                            jr z,0x1929
.data:00001914 2a bb fb                         ld hl,(0xfbbb)
.data:00001917 fb                               ei
.data:00001918 73                               ld (hl),e
.data:00001919 b7                               or a
.data:0000191a 67                               ld h,a
.data:0000191b 4b                               ld c,e
.data:0000191c 8e                               adc a,(hl)
.data:0000191d fd                               defb 0xfd
.data:0000191e fa fd fa                         jp m,0xfafd
.data:00001921 f4 68 d4                         call p,0xd468
.data:00001924 a2                               and d
.data:00001925 45                               ld b,l
.data:00001926 09                               add hl,bc
.data:00001927 46                               ld b,(hl)
.data:00001928 1a                               ld a,(de)
.data:00001929 0d                               dec c
.data:0000192a 32 4e 27                         ld (0x274e),a
.data:0000192d 25                               dec h
.data:0000192e 51                               ld d,c
.data:0000192f a1                               and c
.data:00001930 4b                               ld c,e
.data:00001931 02                               ld (bc),a
.data:00001932 57                               ld d,a
.data:00001933 8e                               adc a,(hl)
.data:00001934 0f                               rrca
.data:00001935 48                               ld c,b
.data:00001936 d1                               pop de
.data:00001937 c9                               ret
.data:00001938 91                               sub c
.data:00001939 89                               adc a,c
.data:0000193a 01 51 01                         ld bc,0x0151
.data:0000193d f8                               ret m
.data:0000193e f8                               ret m
.data:0000193f f8                               ret m
.data:00001940 f8                               ret m
.data:00001941 f8                               ret m
.data:00001942 f8                               ret m
.data:00001943 f8                               ret m
.data:00001944 f9                               ld sp,hl
.data:00001945 7f                               ld a,a
.data:00001946 9f                               sbc a,a
.data:00001947 9f                               sbc a,a
.data:00001948 8f                               adc a,a
.data:00001949 8f                               adc a,a
.data:0000194a 87                               add a,a
.data:0000194b 83                               add a,e
.data:0000194c 03                               inc bc
.data:0000194d ff                               rst 0x38
.data:0000194e ff                               rst 0x38
.data:0000194f ff                               rst 0x38
.data:00001950 ff                               rst 0x38
.data:00001951 ff                               rst 0x38
.data:00001952 ff                               rst 0x38
.data:00001953 ff                               rst 0x38
.data:00001954 ff                               rst 0x38
.data:00001955 ff                               rst 0x38
.data:00001956 ff                               rst 0x38
.data:00001957 ff                               rst 0x38
.data:00001958 ff                               rst 0x38
.data:00001959 ff                               rst 0x38
.data:0000195a ff                               rst 0x38
.data:0000195b ff                               rst 0x38
.data:0000195c ff                               rst 0x38
.data:0000195d ff                               rst 0x38
.data:0000195e ff                               rst 0x38
.data:0000195f ff                               rst 0x38
.data:00001960 ff                               rst 0x38
.data:00001961 ff                               rst 0x38
.data:00001962 ff                               rst 0x38
.data:00001963 ff                               rst 0x38
.data:00001964 ff                               rst 0x38
.data:00001965 99                               sbc a,c
.data:00001966 93                               sub e
.data:00001967 83                               add a,e
.data:00001968 83                               add a,e
.data:00001969 c3 c3 c3                         jp 0xc3c3
.data:0000196c c7                               rst 0x00
.data:0000196d ff                               rst 0x38
.data:0000196e ff                               rst 0x38
.data:0000196f ff                               rst 0x38
.data:00001970 ff                               rst 0x38
.data:00001971 ff                               rst 0x38
.data:00001972 ff                               rst 0x38
.data:00001973 ff                               rst 0x38
.data:00001974 ff                               rst 0x38
.data:00001975 ff                               rst 0x38
.data:00001976 ff                               rst 0x38
.data:00001977 ff                               rst 0x38
.data:00001978 ff                               rst 0x38
.data:00001979 ff                               rst 0x38
.data:0000197a ff                               rst 0x38
.data:0000197b ff                               rst 0x38
.data:0000197c ff                               rst 0x38
.data:0000197d ff                               rst 0x38
.data:0000197e ff                               rst 0x38
.data:0000197f ff                               rst 0x38
.data:00001980 ff                               rst 0x38
.data:00001981 ff                               rst 0x38
.data:00001982 ff                               rst 0x38
.data:00001983 ff                               rst 0x38
.data:00001984 ff                               rst 0x38
.data:00001985 fe fa                            cp 0xfa
.data:00001987 fa f2 f1                         jp m,0xf1f2
.data:0000198a e1                               pop hl
.data:0000198b c1                               pop bc
.data:0000198c c1                               pop bc
.data:0000198d 1f                               rra
.data:0000198e 1f                               rra
.data:0000198f 1f                               rra
.data:00001990 1f                               rra
.data:00001991 1f                               rra
.data:00001992 1f                               rra
.data:00001993 1f                               rra
.data:00001994 1f                               rra
.data:00001995 cb b3                            res 6,e
.data:00001997 83                               add a,e
.data:00001998 bb                               cp e
.data:00001999 83                               add a,e
.data:0000199a 89                               adc a,c
.data:0000199b 89                               adc a,c
.data:0000199c 88                               adc a,b
.data:0000199d c0                               ret nz
.data:0000199e 81                               add a,c
.data:0000199f a4                               and h
.data:000019a0 82                               add a,d
.data:000019a1 b0                               or b
.data:000019a2 d0                               ret nc
.data:000019a3 41                               ld b,c
.data:000019a4 e0                               ret po
.data:000019a5 03                               inc bc
.data:000019a6 58                               ld e,b
.data:000019a7 80                               add a,b
.data:000019a8 00                               nop
.data:000019a9 45                               ld b,l
.data:000019aa 00                               nop
.data:000019ab 00                               nop
.data:000019ac 15                               dec d
.data:000019ad 00                               nop
.data:000019ae 02                               ld (bc),a
.data:000019af 15                               dec d
.data:000019b0 aa                               xor d
.data:000019b1 40                               ld b,b
.data:000019b2 20 0e                            jr nz,0x19c2
.data:000019b4 39                               add hl,sp
.data:000019b5 5f                               ld e,a
.data:000019b6 bf                               cp a
.data:000019b7 f5                               push af
.data:000019b8 aa                               xor d
.data:000019b9 00                               nop
.data:000019ba 03                               inc bc
.data:000019bb 18 e1                            jr 0x199e
.data:000019bd f5                               push af
.data:000019be a2                               and d
.data:000019bf 50                               ld d,b
.data:000019c0 00                               nop
.data:000019c1 03                               inc bc
.data:000019c2 fc 40 61                         call m,0x6140
.data:000019c5 55                               ld d,l
.data:000019c6 aa                               xor d
.data:000019c7 10 00                            djnz 0x19c9
.data:000019c9 d6 3d                            sub 0x3d
.data:000019cb 0a                               ld a,(bc)
.data:000019cc 16 45                            ld d,0x45
.data:000019ce 80                               add a,b
.data:000019cf 02                               ld (bc),a
.data:000019d0 50                               ld d,b
.data:000019d1 80                               add a,b
.data:000019d2 00                               nop
.data:000019d3 00                               nop
.data:000019d4 02                               ld (bc),a
.data:000019d5 00                               nop
.data:000019d6 07                               rlca
.data:000019d7 90                               sub b
.data:000019d8 00                               nop
.data:000019d9 01 0a 55                         ld bc,0x550a
.data:000019dc af                               xor a
.data:000019dd 00                               nop
.data:000019de 00                               nop
.data:000019df 00                               nop
.data:000019e0 00                               nop
.data:000019e1 00                               nop
.data:000019e2 00                               nop
.data:000019e3 00                               nop
.data:000019e4 00                               nop
.data:000019e5 00                               nop
.data:000019e6 00                               nop
.data:000019e7 00                               nop
.data:000019e8 00                               nop
.data:000019e9 00                               nop
.data:000019ea 00                               nop
.data:000019eb 00                               nop
.data:000019ec 00                               nop
.data:000019ed 00                               nop
.data:000019ee 00                               nop
.data:000019ef 00                               nop
.data:000019f0 00                               nop
.data:000019f1 00                               nop
.data:000019f2 00                               nop
.data:000019f3 00                               nop
.data:000019f4 00                               nop
.data:000019f5 00                               nop
.data:000019f6 00                               nop
.data:000019f7 00                               nop
.data:000019f8 00                               nop
.data:000019f9 00                               nop
.data:000019fa 00                               nop
.data:000019fb 00                               nop
.data:000019fc 00                               nop
.data:000019fd aa                               xor d
.data:000019fe f5                               push af
.data:000019ff ea fd fa                         jp pe,0xfafd
.data:00001a02 fd                               defb 0xfd
.data:00001a03 fa f5 80                         jp m,0x80f5
.data:00001a06 55                               ld d,l
.data:00001a07 a0                               and b
.data:00001a08 54                               ld d,h
.data:00001a09 a8                               xor b
.data:00001a0a 00                               nop
.data:00001a0b a0                               and b
.data:00001a0c 50                               ld d,b
.data:00001a0d 1d                               dec e
.data:00001a0e 28 5c                            jr z,0x1a6c
.data:00001a10 2e 5f                            ld l,0x5f
.data:00001a12 2e 5f                            ld l,0x5f
.data:00001a14 bf                               cp a
.data:00001a15 15                               dec d
.data:00001a16 2a 14 00                         ld hl,(0x0014)
.data:00001a19 10 80                            djnz 0x199b
.data:00001a1b 40                               ld b,b
.data:00001a1c 81                               add a,c
.data:00001a1d 40                               ld b,b
.data:00001a1e a9                               xor c
.data:00001a1f 02                               ld (bc),a
.data:00001a20 85                               add a,l
.data:00001a21 0a                               ld a,(bc)
.data:00001a22 55                               ld d,l
.data:00001a23 af                               xor a
.data:00001a24 57                               ld d,a
.data:00001a25 9e                               sbc a,(hl)
.data:00001a26 5c                               ld e,h
.data:00001a27 ba                               cp d
.data:00001a28 f4 b8 f4                         call p,0xf4b8
.data:00001a2b f9                               ld sp,hl
.data:00001a2c f5                               push af
.data:00001a2d c7                               rst 0x00
.data:00001a2e 0b                               dec bc
.data:00001a2f 0f                               rrca
.data:00001a30 93                               sub e
.data:00001a31 fc f2 c4                         call m,0xc4f2
.data:00001a34 4c                               ld c,h
.data:00001a35 01 89 c0                         ld bc,0xc089
.data:00001a38 c8                               ret z
.data:00001a39 a0                               and b
.data:00001a3a e4 20 02                         call po,0x0220
.data:00001a3d f9                               ld sp,hl
.data:00001a3e f9                               ld sp,hl
.data:00001a3f f9                               ld sp,hl
.data:00001a40 f9                               ld sp,hl
.data:00001a41 f9                               ld sp,hl
.data:00001a42 fd 7d                            ld a,iyl
.data:00001a44 7d                               ld a,l
.data:00001a45 01 00 00                         ld bc,0x0000
.data:00001a48 00                               nop
.data:00001a49 00                               nop
.data:00001a4a 00                               nop
.data:00001a4b 00                               nop
.data:00001a4c 00                               nop
.data:00001a4d ff                               rst 0x38
.data:00001a4e ff                               rst 0x38
.data:00001a4f ff                               rst 0x38
.data:00001a50 7f                               ld a,a
.data:00001a51 3f                               ccf
.data:00001a52 1f                               rra
.data:00001a53 2f                               cpl
.data:00001a54 37                               scf
.data:00001a55 ff                               rst 0x38
.data:00001a56 ff                               rst 0x38
.data:00001a57 ff                               rst 0x38
.data:00001a58 ff                               rst 0x38
.data:00001a59 ff                               rst 0x38
.data:00001a5a ff                               rst 0x38
.data:00001a5b ff                               rst 0x38
.data:00001a5c ff                               rst 0x38
.data:00001a5d ff                               rst 0x38
.data:00001a5e ff                               rst 0x38
.data:00001a5f ff                               rst 0x38
.data:00001a60 ff                               rst 0x38
.data:00001a61 ff                               rst 0x38
.data:00001a62 ff                               rst 0x38
.data:00001a63 ff                               rst 0x38
.data:00001a64 ff                               rst 0x38
.data:00001a65 c7                               rst 0x00
.data:00001a66 e7                               rst 0x20
.data:00001a67 e7                               rst 0x20
.data:00001a68 e7                               rst 0x20
.data:00001a69 e7                               rst 0x20
.data:00001a6a e7                               rst 0x20
.data:00001a6b e7                               rst 0x20
.data:00001a6c e7                               rst 0x20
.data:00001a6d ff                               rst 0x38
.data:00001a6e ff                               rst 0x38
.data:00001a6f ff                               rst 0x38
.data:00001a70 ff                               rst 0x38
.data:00001a71 ff                               rst 0x38
.data:00001a72 ff                               rst 0x38
.data:00001a73 ff                               rst 0x38
.data:00001a74 ff                               rst 0x38
.data:00001a75 ff                               rst 0x38
.data:00001a76 ff                               rst 0x38
.data:00001a77 ff                               rst 0x38
.data:00001a78 ff                               rst 0x38
.data:00001a79 ff                               rst 0x38
.data:00001a7a ff                               rst 0x38
.data:00001a7b ff                               rst 0x38
.data:00001a7c ff                               rst 0x38
.data:00001a7d ff                               rst 0x38
.data:00001a7e ff                               rst 0x38
.data:00001a7f ff                               rst 0x38
.data:00001a80 fe fc                            cp 0xfc
.data:00001a82 f8                               ret m
.data:00001a83 f0                               ret p
.data:00001a84 e0                               ret po
.data:00001a85 81                               add a,c
.data:00001a86 00                               nop
.data:00001a87 00                               nop
.data:00001a88 00                               nop
.data:00001a89 00                               nop
.data:00001a8a 00                               nop
.data:00001a8b 00                               nop
.data:00001a8c 10 1f                            djnz 0x1aad
.data:00001a8e 9f                               sbc a,a
.data:00001a8f 9f                               sbc a,a
.data:00001a90 9f                               sbc a,a
.data:00001a91 9f                               sbc a,a
.data:00001a92 bf                               cp a
.data:00001a93 bf                               cp a
.data:00001a94 be                               cp (hl)
.data:00001a95 84                               add a,h
.data:00001a96 84                               add a,h
.data:00001a97 06 01                            ld b,0x01
.data:00001a99 03                               inc bc
.data:00001a9a 03                               inc bc
.data:00001a9b 05                               dec b
.data:00001a9c 06 70                            ld b,0x70
.data:00001a9e f0                               ret p
.data:00001a9f e0                               ret po
.data:00001aa0 d0                               ret nc
.data:00001aa1 f0                               ret p
.data:00001aa2 cb 3f                            srl a
.data:00001aa4 0f                               rrca
.data:00001aa5 0a                               ld a,(bc)
.data:00001aa6 57                               ld d,a
.data:00001aa7 2f                               cpl
.data:00001aa8 9f                               sbc a,a
.data:00001aa9 2f                               cpl
.data:00001aaa 5f                               ld e,a
.data:00001aab 2f                               cpl
.data:00001aac 9f                               sbc a,a
.data:00001aad 7f                               ld a,a
.data:00001aae f2 c1 84                         jp p,0x84c1
.data:00001ab1 8b                               adc a,e
.data:00001ab2 85                               add a,l
.data:00001ab3 0b                               dec bc
.data:00001ab4 17                               rla
.data:00001ab5 22 c5 8b                         ld (0x8bc5),hl
.data:00001ab8 97                               sub a
.data:00001ab9 0b                               dec bc
.data:00001aba 17                               rla
.data:00001abb 0b                               dec bc
.data:00001abc 17                               rla
.data:00001abd 60                               ld h,b
.data:00001abe b0                               or b
.data:00001abf b0                               or b
.data:00001ac0 b0                               or b
.data:00001ac1 b2                               or d
.data:00001ac2 d0                               ret nc
.data:00001ac3 d0                               ret nc
.data:00001ac4 e0                               ret po
.data:00001ac5 2c                               inc l
.data:00001ac6 14                               inc d
.data:00001ac7 8c                               adc a,h
.data:00001ac8 18 28                            jr 0x1af2
.data:00001aca 58                               ld e,b
.data:00001acb 28 18                            jr z,0x1ae5
.data:00001acd 15                               dec d
.data:00001ace 2b                               dec hl
.data:00001acf 55                               ld d,l
.data:00001ad0 2f                               cpl
.data:00001ad1 57                               ld d,a
.data:00001ad2 af                               xor a
.data:00001ad3 5f                               ld e,a
.data:00001ad4 bf                               cp a
.data:00001ad5 ff                               rst 0x38
.data:00001ad6 ff                               rst 0x38
.data:00001ad7 ff                               rst 0x38
.data:00001ad8 ff                               rst 0x38
.data:00001ad9 fe fd                            cp 0xfd
.data:00001adb fb                               ei
.data:00001adc f7                               rst 0x30
.data:00001add 00                               nop
.data:00001ade 00                               nop
.data:00001adf 00                               nop
.data:00001ae0 00                               nop
.data:00001ae1 00                               nop
.data:00001ae2 00                               nop
.data:00001ae3 00                               nop
.data:00001ae4 00                               nop
.data:00001ae5 00                               nop
.data:00001ae6 00                               nop
.data:00001ae7 00                               nop
.data:00001ae8 00                               nop
.data:00001ae9 00                               nop
.data:00001aea 00                               nop
.data:00001aeb 00                               nop
.data:00001aec 00                               nop
.data:00001aed 00                               nop
.data:00001aee 00                               nop
.data:00001aef 00                               nop
.data:00001af0 00                               nop
.data:00001af1 00                               nop
.data:00001af2 00                               nop
.data:00001af3 00                               nop
.data:00001af4 00                               nop
.data:00001af5 00                               nop
.data:00001af6 00                               nop
.data:00001af7 00                               nop
.data:00001af8 00                               nop
.data:00001af9 00                               nop
.data:00001afa 00                               nop
.data:00001afb 00                               nop
.data:00001afc 00                               nop
.data:00001afd fa d5 ea                         jp m,0xead5
.data:00001b00 54                               ld d,h
.data:00001b01 aa                               xor d
.data:00001b02 55                               ld d,l
.data:00001b03 aa                               xor d
.data:00001b04 55                               ld d,l
.data:00001b05 80                               add a,b
.data:00001b06 20 80                            jr nz,0x1a88
.data:00001b08 00                               nop
.data:00001b09 81                               add a,c
.data:00001b0a 00                               nop
.data:00001b0b 40                               ld b,b
.data:00001b0c 00                               nop
.data:00001b0d 5f                               ld e,a
.data:00001b0e be                               cp (hl)
.data:00001b0f 5f                               ld e,a
.data:00001b10 3e 7d                            ld a,0x7d
.data:00001b12 3a 74 38                         ld a,(0x3874)
.data:00001b15 48                               ld c,b
.data:00001b16 85                               add a,l
.data:00001b17 48                               ld c,b
.data:00001b18 94                               sub h
.data:00001b19 0a                               ld a,(bc)
.data:00001b1a 04                               inc b
.data:00001b1b 4a                               ld c,d
.data:00001b1c a5                               and l
.data:00001b1d af                               xor a
.data:00001b1e 5d                               ld e,l
.data:00001b1f bf                               cp a
.data:00001b20 5b                               ld e,e
.data:00001b21 3f                               ccf
.data:00001b22 5f                               ld e,a
.data:00001b23 2d                               dec l
.data:00001b24 1b                               dec de
.data:00001b25 a9                               xor c
.data:00001b26 f4 a8 d2                         call p,0xd2a8
.data:00001b29 aa                               xor d
.data:00001b2a f4 51 ea                         call p,0xea51
.data:00001b2d 8c                               adc a,h
.data:00001b2e 96                               sub (hl)
.data:00001b2f 80                               add a,b
.data:00001b30 29                               add hl,hl
.data:00001b31 44                               ld b,h
.data:00001b32 94                               sub h
.data:00001b33 64                               ld h,h
.data:00001b34 41                               ld b,c
.data:00001b35 a1                               and c
.data:00001b36 45                               ld b,l
.data:00001b37 00                               nop
.data:00001b38 14                               inc d
.data:00001b39 a4                               and h
.data:00001b3a 71                               ld (hl),c
.data:00001b3b a8                               xor b
.data:00001b3c 70                               ld (hl),b
.data:00001b3d 7f                               ld a,a
.data:00001b3e 3f                               ccf
.data:00001b3f 3f                               ccf
.data:00001b40 3f                               ccf
.data:00001b41 1f                               rra
.data:00001b42 1f                               rra
.data:00001b43 0f                               rrca
.data:00001b44 6f                               ld l,a
.data:00001b45 00                               nop
.data:00001b46 00                               nop
.data:00001b47 00                               nop
.data:00001b48 00                               nop
.data:00001b49 00                               nop
.data:00001b4a 80                               add a,b
.data:00001b4b 80                               add a,b
.data:00001b4c 80                               add a,b
.data:00001b4d fe be                            cp 0xbe
.data:00001b4f 9c                               sbc a,h
.data:00001b50 c0                               ret nz
.data:00001b51 c0                               ret nz
.data:00001b52 e0                               ret po
.data:00001b53 e0                               ret po
.data:00001b54 f0                               ret p
.data:00001b55 ff                               rst 0x38
.data:00001b56 ff                               rst 0x38
.data:00001b57 3f                               ccf
.data:00001b58 1f                               rra
.data:00001b59 07                               rlca
.data:00001b5a 01 00 00                         ld bc,0x0000
.data:00001b5d ff                               rst 0x38
.data:00001b5e ff                               rst 0x38
.data:00001b5f ff                               rst 0x38
.data:00001b60 ff                               rst 0x38
.data:00001b61 ff                               rst 0x38
.data:00001b62 fe bc                            cp 0xbc
.data:00001b64 00                               nop
.data:00001b65 c3 c3 81                         jp 0x81c3
.data:00001b68 81                               add a,c
.data:00001b69 00                               nop
.data:00001b6a 00                               nop
.data:00001b6b 00                               nop
.data:00001b6c 00                               nop
.data:00001b6d ff                               rst 0x38
.data:00001b6e ff                               rst 0x38
.data:00001b6f ff                               rst 0x38
.data:00001b70 ff                               rst 0x38
.data:00001b71 ff                               rst 0x38
.data:00001b72 7f                               ld a,a
.data:00001b73 3c                               inc a
.data:00001b74 00                               nop
.data:00001b75 ff                               rst 0x38
.data:00001b76 ff                               rst 0x38
.data:00001b77 fc f8 e0                         call m,0xe0f8
.data:00001b7a 88                               adc a,b
.data:00001b7b 18 00                            jr 0x1b7d
.data:00001b7d 41                               ld b,c
.data:00001b7e c1                               pop bc
.data:00001b7f c1                               pop bc
.data:00001b80 c3 83 87                         jp 0x8783
.data:00001b83 0f                               rrca
.data:00001b84 1f                               rra
.data:00001b85 00                               nop
.data:00001b86 20 10                            jr nz,0x1b98
.data:00001b88 00                               nop
.data:00001b89 20 40                            jr nz,0x1bcb
.data:00001b8b a1                               and c
.data:00001b8c 41                               ld b,c
.data:00001b8d 3e 7e                            ld a,0x7e
.data:00001b8f 7c                               ld a,h
.data:00001b90 7c                               ld a,h
.data:00001b91 fc fa f9                         call m,0xf9fa
.data:00001b94 f0                               ret p
.data:00001b95 04                               inc b
.data:00001b96 20 08                            jr nz,0x1ba0
.data:00001b98 40                               ld b,b
.data:00001b99 41                               ld b,c
.data:00001b9a a0                               and b
.data:00001b9b 50                               ld d,b
.data:00001b9c 20 23                            jr nz,0x1bc1
.data:00001b9e 32 31 61                         ld (0x6131),a
.data:00001ba1 01 80 00                         ld bc,0x0080
.data:00001ba4 20 af                            jr nz,0x1b55
.data:00001ba6 97                               sub a
.data:00001ba7 af                               xor a
.data:00001ba8 1f                               rra
.data:00001ba9 0f                               rrca
.data:00001baa 07                               rlca
.data:00001bab 4b                               ld c,e
.data:00001bac 07                               rlca
.data:00001bad 0a                               ld a,(bc)
.data:00001bae 07                               rlca
.data:00001baf 0b                               dec bc
.data:00001bb0 85                               add a,l
.data:00001bb1 83                               add a,e
.data:00001bb2 c5                               push bc
.data:00001bb3 cb c5                            set 0,l
.data:00001bb5 8b                               adc a,e
.data:00001bb6 85                               add a,l
.data:00001bb7 c2 a1 e8                         jp nz,0xe8a1
.data:00001bba f5                               push af
.data:00001bbb fe 7f                            cp 0x7f
.data:00001bbd e2 d0 ff                         jp po,0xffd0
.data:00001bc0 00                               nop
.data:00001bc1 2a 57 fb                         ld hl,(0xfb57)
.data:00001bc4 ff                               rst 0x38
.data:00001bc5 28 50                            jr z,0x1c17
.data:00001bc7 e5                               push hl
.data:00001bc8 24                               inc h
.data:00001bc9 b1                               or c
.data:00001bca 74                               ld (hl),h
.data:00001bcb fa fa 5f                         jp m,0x5ffa
.data:00001bce bf                               cp a
.data:00001bcf 5f                               ld e,a
.data:00001bd0 bf                               cp a
.data:00001bd1 5f                               ld e,a
.data:00001bd2 bc                               cp h
.data:00001bd3 50                               ld d,b
.data:00001bd4 03                               inc bc
.data:00001bd5 f7                               rst 0x30
.data:00001bd6 ef                               rst 0x28
.data:00001bd7 ef                               rst 0x28
.data:00001bd8 df                               rst 0x18
.data:00001bd9 df                               rst 0x18
.data:00001bda 0f                               rrca
.data:00001bdb f1                               pop af
.data:00001bdc fe 00                            cp 0x00
.data:00001bde 00                               nop
.data:00001bdf 00                               nop
.data:00001be0 00                               nop
.data:00001be1 00                               nop
.data:00001be2 00                               nop
.data:00001be3 00                               nop
.data:00001be4 00                               nop
.data:00001be5 00                               nop
.data:00001be6 00                               nop
.data:00001be7 00                               nop
.data:00001be8 00                               nop
.data:00001be9 00                               nop
.data:00001bea 00                               nop
.data:00001beb 00                               nop
.data:00001bec 00                               nop
.data:00001bed 00                               nop
.data:00001bee 00                               nop
.data:00001bef 00                               nop
.data:00001bf0 00                               nop
.data:00001bf1 00                               nop
.data:00001bf2 00                               nop
.data:00001bf3 00                               nop
.data:00001bf4 00                               nop
.data:00001bf5 00                               nop
.data:00001bf6 00                               nop
.data:00001bf7 00                               nop
.data:00001bf8 00                               nop
.data:00001bf9 00                               nop
.data:00001bfa 00                               nop
.data:00001bfb 00                               nop
.data:00001bfc 00                               nop
.data:00001bfd aa                               xor d
.data:00001bfe 51                               ld d,c
.data:00001bff 88                               adc a,b
.data:00001c00 55                               ld d,l
.data:00001c01 a0                               and b
.data:00001c02 04                               inc b
.data:00001c03 90                               sub b
.data:00001c04 00                               nop
.data:00001c05 81                               add a,c
.data:00001c06 00                               nop
.data:00001c07 00                               nop
.data:00001c08 02                               ld (bc),a
.data:00001c09 01 00 01                         ld bc,0x0100
.data:00001c0c 02                               ld (bc),a
.data:00001c0d 14                               inc d
.data:00001c0e a8                               xor b
.data:00001c0f 11 80 41                         ld de,0x4180
.data:00001c12 82                               add a,d
.data:00001c13 41                               ld b,c
.data:00001c14 a2                               and d
.data:00001c15 42                               ld b,d
.data:00001c16 a1                               and c
.data:00001c17 52                               ld d,d
.data:00001c18 a9                               xor c
.data:00001c19 54                               ld d,h
.data:00001c1a e8                               ret pe
.data:00001c1b 35                               dec (hl)
.data:00001c1c 88                               adc a,b
.data:00001c1d 85                               add a,l
.data:00001c1e 40                               ld b,b
.data:00001c1f a8                               xor b
.data:00001c20 5c                               ld e,h
.data:00001c21 af                               xor a
.data:00001c22 15                               dec d
.data:00001c23 02                               ld (bc),a
.data:00001c24 80                               add a,b
.data:00001c25 55                               ld d,l
.data:00001c26 a8                               xor b
.data:00001c27 00                               nop
.data:00001c28 01 d5 7f                         ld bc,0x7fd5
.data:00001c2b aa                               xor d
.data:00001c2c d5                               push de
.data:00001c2d 0b                               dec bc
.data:00001c2e 15                               dec d
.data:00001c2f ae                               xor (hl)
.data:00001c30 5c                               ld e,h
.data:00001c31 fa d4 a8                         jp m,0xa8d4
.data:00001c34 42                               ld b,d
.data:00001c35 a0                               and b
.data:00001c36 41                               ld b,c
.data:00001c37 03                               inc bc
.data:00001c38 47                               ld b,a
.data:00001c39 8e                               adc a,(hl)
.data:00001c3a 2e 5c                            ld l,0x5c
.data:00001c3c 19                               add hl,de
.data:00001c3d d7                               rst 0x10
.data:00001c3e 87                               add a,a
.data:00001c3f 2b                               dec hl
.data:00001c40 5b                               ld e,e
.data:00001c41 bd                               cp l
.data:00001c42 7e                               ld a,(hl)
.data:00001c43 df                               rst 0x18
.data:00001c44 75                               ld (hl),l
.data:00001c45 c0                               ret nz
.data:00001c46 c0                               ret nz
.data:00001c47 e0                               ret po
.data:00001c48 e0                               ret po
.data:00001c49 f0                               ret p
.data:00001c4a f0                               ret p
.data:00001c4b 78                               ld a,b
.data:00001c4c 7c                               ld a,h
.data:00001c4d 83                               add a,e
.data:00001c4e 20 40                            jr nz,0x1c90
.data:00001c50 10 0a                            djnz 0x1c5c
.data:00001c52 05                               dec b
.data:00001c53 06 03                            ld b,0x03
.data:00001c55 fe f8                            cp 0xf8
.data:00001c57 01 00 0b                         ld bc,0x0b00
.data:00001c5a 55                               ld d,l
.data:00001c5b bf                               cp a
.data:00001c5c ff                               rst 0x38
.data:00001c5d 04                               inc b
.data:00001c5e 09                               add hl,bc
.data:00001c5f 26 8b                            ld h,0x8b
.data:00001c61 6f                               ld l,a
.data:00001c62 df                               rst 0x18
.data:00001c63 ff                               rst 0x38
.data:00001c64 ff                               rst 0x38
.data:00001c65 86                               add a,(hl)
.data:00001c66 5a                               ld e,d
.data:00001c67 f5                               push af
.data:00001c68 ff                               rst 0x38
.data:00001c69 ff                               rst 0x38
.data:00001c6a ff                               rst 0x38
.data:00001c6b ff                               rst 0x38
.data:00001c6c ff                               rst 0x38
.data:00001c6d 00                               nop
.data:00001c6e 80                               add a,b
.data:00001c6f 50                               ld d,b
.data:00001c70 8a                               adc a,d
.data:00001c71 f5                               push af
.data:00001c72 ff                               rst 0x38
.data:00001c73 ff                               rst 0x38
.data:00001c74 ff                               rst 0x38
.data:00001c75 c3 3e 80                         jp 0x803e
.data:00001c78 50                               ld d,b
.data:00001c79 aa                               xor d
.data:00001c7a fd                               defb 0xfd
.data:00001c7b ff                               rst 0x38
.data:00001c7c ff                               rst 0x38
.data:00001c7d 81                               add a,c
.data:00001c7e 00                               nop
.data:00001c7f 03                               inc bc
.data:00001c80 25                               dec h
.data:00001c81 96                               sub (hl)
.data:00001c82 59                               ld e,c
.data:00001c83 e0                               ret po
.data:00001c84 40                               ld b,b
.data:00001c85 03                               inc bc
.data:00001c86 03                               inc bc
.data:00001c87 07                               rlca
.data:00001c88 07                               rlca
.data:00001c89 0f                               rrca
.data:00001c8a 1f                               rra
.data:00001c8b 3e 3e                            ld a,0x3e
.data:00001c8d f0                               ret p
.data:00001c8e e0                               ret po
.data:00001c8f c0                               ret nz
.data:00001c90 c0                               ret nz
.data:00001c91 80                               add a,b
.data:00001c92 40                               ld b,b
.data:00001c93 e0                               ret po
.data:00001c94 f0                               ret p
.data:00001c95 08                               ex af,af'
.data:00001c96 00                               nop
.data:00001c97 20 41                            jr nz,0x1cda
.data:00001c99 00                               nop
.data:00001c9a 05                               dec b
.data:00001c9b 80                               add a,b
.data:00001c9c 81                               add a,c
.data:00001c9d 10 08                            djnz 0x1ca7
.data:00001c9f 84                               add a,h
.data:00001ca0 44                               ld b,h
.data:00001ca1 a2                               and d
.data:00001ca2 a2                               and d
.data:00001ca3 d1                               pop de
.data:00001ca4 51                               ld d,c
.data:00001ca5 0b                               dec bc
.data:00001ca6 25                               dec h
.data:00001ca7 13                               inc de
.data:00001ca8 25                               dec h
.data:00001ca9 0a                               ld a,(bc)
.data:00001caa 11 04 01                         ld de,0x0104
.data:00001cad c2 e1 e0                         jp nz,0xe0e1
.data:00001cb0 f5                               push af
.data:00001cb1 f0                               ret p
.data:00001cb2 e8                               ret pe
.data:00001cb3 ef                               rst 0x28
.data:00001cb4 5f                               ld e,a
.data:00001cb5 ff                               rst 0x38
.data:00001cb6 5f                               ld e,a
.data:00001cb7 aa                               xor d
.data:00001cb8 55                               ld d,l
.data:00001cb9 88                               adc a,b
.data:00001cba 00                               nop
.data:00001cbb 80                               add a,b
.data:00001cbc ff                               rst 0x38
.data:00001cbd ff                               rst 0x38
.data:00001cbe ff                               rst 0x38
.data:00001cbf aa                               xor d
.data:00001cc0 55                               ld d,l
.data:00001cc1 aa                               xor d
.data:00001cc2 05                               dec b
.data:00001cc3 00                               nop
.data:00001cc4 e0                               ret po
.data:00001cc5 fe ff                            cp 0xff
.data:00001cc7 ff                               rst 0x38
.data:00001cc8 55                               ld d,l
.data:00001cc9 aa                               xor d
.data:00001cca 15                               dec d
.data:00001ccb 00                               nop
.data:00001ccc 00                               nop
.data:00001ccd 0f                               rrca
.data:00001cce 0f                               rrca
.data:00001ccf 17                               rla
.data:00001cd0 8b                               adc a,e
.data:00001cd1 17                               rla
.data:00001cd2 4b                               ld c,e
.data:00001cd3 a5                               and l
.data:00001cd4 12                               ld (de),a
.data:00001cd5 ff                               rst 0x38
.data:00001cd6 ff                               rst 0x38
.data:00001cd7 ff                               rst 0x38
.data:00001cd8 ff                               rst 0x38
.data:00001cd9 ff                               rst 0x38
.data:00001cda ff                               rst 0x38
.data:00001cdb f8                               ret m
.data:00001cdc f7                               rst 0x30
.data:00001cdd 00                               nop
.data:00001cde 00                               nop
.data:00001cdf 00                               nop
.data:00001ce0 00                               nop
.data:00001ce1 00                               nop
.data:00001ce2 00                               nop
.data:00001ce3 00                               nop
.data:00001ce4 00                               nop
.data:00001ce5 00                               nop
.data:00001ce6 00                               nop
.data:00001ce7 00                               nop
.data:00001ce8 00                               nop
.data:00001ce9 00                               nop
.data:00001cea 00                               nop
.data:00001ceb 00                               nop
.data:00001cec 00                               nop
.data:00001ced 00                               nop
.data:00001cee 00                               nop
.data:00001cef 00                               nop
.data:00001cf0 00                               nop
.data:00001cf1 00                               nop
.data:00001cf2 00                               nop
.data:00001cf3 00                               nop
.data:00001cf4 00                               nop
.data:00001cf5 00                               nop
.data:00001cf6 00                               nop
.data:00001cf7 00                               nop
.data:00001cf8 00                               nop
.data:00001cf9 00                               nop
.data:00001cfa 00                               nop
.data:00001cfb 00                               nop
.data:00001cfc 00                               nop
.data:00001cfd 00                               nop
.data:00001cfe 00                               nop
.data:00001cff 00                               nop
.data:00001d00 00                               nop
.data:00001d01 00                               nop
.data:00001d02 00                               nop
.data:00001d03 00                               nop
.data:00001d04 00                               nop
.data:00001d05 05                               dec b
.data:00001d06 02                               ld (bc),a
.data:00001d07 01 02 04                         ld bc,0x0402
.data:00001d0a 02                               ld (bc),a
.data:00001d0b 04                               inc b
.data:00001d0c 00                               nop
.data:00001d0d 45                               ld b,l
.data:00001d0e a2                               and d
.data:00001d0f 44                               ld b,h
.data:00001d10 82                               add a,d
.data:00001d11 48                               ld c,b
.data:00001d12 00                               nop
.data:00001d13 01 22 20                         ld bc,0x2022
.data:00001d16 00                               nop
.data:00001d17 08                               ex af,af'
.data:00001d18 00                               nop
.data:00001d19 05                               dec b
.data:00001d1a 10 6a                            djnz 0x1d86
.data:00001d1c ff                               rst 0x38
.data:00001d1d 00                               nop
.data:00001d1e 05                               dec b
.data:00001d1f 2f                               cpl
.data:00001d20 ff                               rst 0x38
.data:00001d21 5e                               ld e,(hl)
.data:00001d22 15                               dec d
.data:00001d23 a0                               and b
.data:00001d24 90                               sub b
.data:00001d25 00                               nop
.data:00001d26 00                               nop
.data:00001d27 aa                               xor d
.data:00001d28 d0                               ret nc
.data:00001d29 a1                               and c
.data:00001d2a 05                               dec b
.data:00001d2b 02                               ld (bc),a
.data:00001d2c 00                               nop
.data:00001d2d 34                               inc (hl)
.data:00001d2e d0                               ret nc
.data:00001d2f 00                               nop
.data:00001d30 12                               ld (de),a
.data:00001d31 44                               ld b,h
.data:00001d32 d0                               ret nc
.data:00001d33 e8                               ret pe
.data:00001d34 94                               sub h
.data:00001d35 3a 35 72                         ld a,(0x7235)
.data:00001d38 65                               ld h,l
.data:00001d39 6b                               ld l,e
.data:00001d3a d5                               push de
.data:00001d3b ce d7                            adc a,0xd7
.data:00001d3d fe ff                            cp 0xff
.data:00001d3f ff                               rst 0x38
.data:00001d40 ff                               rst 0x38
.data:00001d41 ab                               xor e
.data:00001d42 57                               ld d,a
.data:00001d43 bf                               cp a
.data:00001d44 7f                               ld a,a
.data:00001d45 be                               cp (hl)
.data:00001d46 df                               rst 0x18
.data:00001d47 ef                               rst 0x28
.data:00001d48 77                               ld (hl),a
.data:00001d49 db f1                            in a,(0xf1)
.data:00001d4b fe ff                            cp 0xff
.data:00001d4d 00                               nop
.data:00001d4e 00                               nop
.data:00001d4f 80                               add a,b
.data:00001d50 c0                               ret nz
.data:00001d51 f0                               ret p
.data:00001d52 f8                               ret m
.data:00001d53 7c                               ld a,h
.data:00001d54 3f                               ccf
.data:00001d55 bf                               cp a
.data:00001d56 7f                               ld a,a
.data:00001d57 a5                               and l
.data:00001d58 53                               ld d,e
.data:00001d59 09                               add hl,bc
.data:00001d5a 16 01                            ld d,0x01
.data:00001d5c 00                               nop
.data:00001d5d ff                               rst 0x38
.data:00001d5e ff                               rst 0x38
.data:00001d5f ff                               rst 0x38
.data:00001d60 ff                               rst 0x38
.data:00001d61 ff                               rst 0x38
.data:00001d62 bd                               cp l
.data:00001d63 68                               ld l,b
.data:00001d64 15                               dec d
.data:00001d65 ff                               rst 0x38
.data:00001d66 ff                               rst 0x38
.data:00001d67 ff                               rst 0x38
.data:00001d68 ff                               rst 0x38
.data:00001d69 fd                               defb 0xfd
.data:00001d6a fe d4                            cp 0xd4
.data:00001d6c 2a ff ff                         ld hl,(0xffff)
.data:00001d6f ff                               rst 0x38
.data:00001d70 ff                               rst 0x38
.data:00001d71 bf                               cp a
.data:00001d72 55                               ld d,l
.data:00001d73 a8                               xor b
.data:00001d74 00                               nop
.data:00001d75 fe fd                            cp 0xfd
.data:00001d77 e8                               ret pe
.data:00001d78 54                               ld d,h
.data:00001d79 a0                               and b
.data:00001d7a 00                               nop
.data:00001d7b 00                               nop
.data:00001d7c 00                               nop
.data:00001d7d 00                               nop
.data:00001d7e 00                               nop
.data:00001d7f 01 03 0f                         ld bc,0x0f03
.data:00001d82 1f                               rra
.data:00001d83 3e fc                            ld a,0xfc
.data:00001d85 7d                               ld a,l
.data:00001d86 fb                               ei
.data:00001d87 f7                               rst 0x30
.data:00001d88 e7                               rst 0x20
.data:00001d89 cf                               rst 0x08
.data:00001d8a af                               xor a
.data:00001d8b 1f                               rra
.data:00001d8c 2f                               cpl
.data:00001d8d f0                               ret p
.data:00001d8e f9                               ld sp,hl
.data:00001d8f fd                               defb 0xfd
.data:00001d90 fc fc fe                         call m,0xfefc
.data:00001d93 fe fe                            cp 0xfe
.data:00001d95 02                               ld (bc),a
.data:00001d96 09                               add hl,bc
.data:00001d97 02                               ld (bc),a
.data:00001d98 01 12 05                         ld bc,0x0512
.data:00001d9b 2b                               dec hl
.data:00001d9c 1e e8                            ld e,0xe8
.data:00001d9e 68                               ld l,b
.data:00001d9f d8                               ret c
.data:00001da0 9c                               sbc a,h
.data:00001da1 94                               sub h
.data:00001da2 b4                               or h
.data:00001da3 6c                               ld l,h
.data:00001da4 d4 80 f0                         call nc,0xf080
.data:00001da7 df                               rst 0x18
.data:00001da8 75                               ld (hl),l
.data:00001da9 ba                               cp d
.data:00001daa 55                               ld d,l
.data:00001dab 3a 1f ba                         ld a,(0xba1f)
.data:00001dae 11 83 7e                         ld de,0x7e83
.data:00001db1 95                               sub l
.data:00001db2 5a                               ld e,d
.data:00001db3 ac                               xor h
.data:00001db4 4a                               ld c,d
.data:00001db5 ff                               rst 0x38
.data:00001db6 be                               cp (hl)
.data:00001db7 3f                               ccf
.data:00001db8 1e 1f                            ld e,0x1f
.data:00001dba 0f                               rrca
.data:00001dbb 0f                               rrca
.data:00001dbc 0f                               rrca
.data:00001dbd 5f                               ld e,a
.data:00001dbe 8f                               adc a,a
.data:00001dbf 4b                               ld c,e
.data:00001dc0 8d                               adc a,l
.data:00001dc1 53                               ld d,e
.data:00001dc2 91                               sub c
.data:00001dc3 52                               ld d,d
.data:00001dc4 91                               sub c
.data:00001dc5 80                               add a,b
.data:00001dc6 f8                               ret m
.data:00001dc7 d7                               rst 0x10
.data:00001dc8 ea fd fa                         jp pe,0xfafd
.data:00001dcb ff                               rst 0x38
.data:00001dcc 7e                               ld a,(hl)
.data:00001dcd 09                               add hl,bc
.data:00001dce 04                               inc b
.data:00001dcf 82                               add a,d
.data:00001dd0 61                               ld h,c
.data:00001dd1 3f                               ccf
.data:00001dd2 a0                               and b
.data:00001dd3 20 a0                            jr nz,0x1d75
.data:00001dd5 7f                               ld a,a
.data:00001dd6 bf                               cp a
.data:00001dd7 57                               ld d,a
.data:00001dd8 2b                               dec hl
.data:00001dd9 17                               rla
.data:00001dda 8b                               adc a,e
.data:00001ddb 45                               ld b,l
.data:00001ddc e2 00 00                         jp po,0x0000
.data:00001ddf 00                               nop
.data:00001de0 00                               nop
.data:00001de1 00                               nop
.data:00001de2 00                               nop
.data:00001de3 00                               nop
.data:00001de4 00                               nop
.data:00001de5 00                               nop
.data:00001de6 00                               nop
.data:00001de7 00                               nop
.data:00001de8 00                               nop
.data:00001de9 00                               nop
.data:00001dea 00                               nop
.data:00001deb 00                               nop
.data:00001dec 00                               nop
.data:00001ded 00                               nop
.data:00001dee 00                               nop
.data:00001def 00                               nop
.data:00001df0 00                               nop
.data:00001df1 00                               nop
.data:00001df2 00                               nop
.data:00001df3 00                               nop
.data:00001df4 00                               nop
.data:00001df5 00                               nop
.data:00001df6 00                               nop
.data:00001df7 00                               nop
.data:00001df8 00                               nop
.data:00001df9 00                               nop
.data:00001dfa 00                               nop
.data:00001dfb 00                               nop
.data:00001dfc 00                               nop
.data:00001dfd 00                               nop
.data:00001dfe 00                               nop
.data:00001dff 00                               nop
.data:00001e00 00                               nop
.data:00001e01 00                               nop
.data:00001e02 00                               nop
.data:00001e03 00                               nop
.data:00001e04 02                               ld (bc),a
.data:00001e05 04                               inc b
.data:00001e06 08                               ex af,af'
.data:00001e07 00                               nop
.data:00001e08 01 0a 15                         ld bc,0x150a
.data:00001e0b 0b                               dec bc
.data:00001e0c 83                               add a,e
.data:00001e0d 87                               add a,a
.data:00001e0e 01 00 50                         ld bc,0x5000
.data:00001e11 aa                               xor d
.data:00001e12 ff                               rst 0x38
.data:00001e13 ff                               rst 0x38
.data:00001e14 fe ff                            cp 0xff
.data:00001e16 7c                               ld a,h
.data:00001e17 ab                               xor e
.data:00001e18 16 08                            ld d,0x08
.data:00001e1a 41                               ld b,c
.data:00001e1b a0                               and b
.data:00001e1c 80                               add a,b
.data:00001e1d 60                               ld h,b
.data:00001e1e 83                               add a,e
.data:00001e1f 15                               dec d
.data:00001e20 2f                               cpl
.data:00001e21 bf                               cp a
.data:00001e22 7f                               ld a,a
.data:00001e23 bf                               cp a
.data:00001e24 5f                               ld e,a
.data:00001e25 a0                               and b
.data:00001e26 55                               ld d,l
.data:00001e27 fe fa                            cp 0xfa
.data:00001e29 fd                               defb 0xfd
.data:00001e2a f4 e8 a0                         call p,0xa0e8
.data:00001e2d 21 09 81                         ld hl,0x8109
.data:00001e30 81                               add a,c
.data:00001e31 11 03 53                         ld de,0x5303
.data:00001e34 8b                               adc a,e
.data:00001e35 8e                               adc a,(hl)
.data:00001e36 97                               sub a
.data:00001e37 ab                               xor e
.data:00001e38 97                               sub a
.data:00001e39 2b                               dec hl
.data:00001e3a 15                               dec d
.data:00001e3b 0a                               ld a,(bc)
.data:00001e3c 01 bf ff                         ld bc,0xffbf
.data:00001e3f ff                               rst 0x38
.data:00001e40 ff                               rst 0x38
.data:00001e41 ff                               rst 0x38
.data:00001e42 ff                               rst 0x38
.data:00001e43 ff                               rst 0x38
.data:00001e44 5f                               ld e,a
.data:00001e45 ff                               rst 0x38
.data:00001e46 ff                               rst 0x38
.data:00001e47 ff                               rst 0x38
.data:00001e48 ff                               rst 0x38
.data:00001e49 ff                               rst 0x38
.data:00001e4a ff                               rst 0x38
.data:00001e4b ff                               rst 0x38
.data:00001e4c ff                               rst 0x38
.data:00001e4d 9f                               sbc a,a
.data:00001e4e 47                               ld b,a
.data:00001e4f a3                               and e
.data:00001e50 d0                               ret nc
.data:00001e51 a6                               and (hl)
.data:00001e52 d3 e0                            out (0xe0),a
.data:00001e54 d6 c0                            sub 0xc0
.data:00001e56 f0                               ret p
.data:00001e57 bc                               cp h
.data:00001e58 ff                               rst 0x38
.data:00001e59 3f                               ccf
.data:00001e5a 87                               add a,a
.data:00001e5b 50                               ld d,b
.data:00001e5c 28 00                            jr z,0x1e5e
.data:00001e5e 00                               nop
.data:00001e5f 00                               nop
.data:00001e60 80                               add a,b
.data:00001e61 fe ff                            cp 0xff
.data:00001e63 ff                               rst 0x38
.data:00001e64 1f                               rra
.data:00001e65 00                               nop
.data:00001e66 00                               nop
.data:00001e67 00                               nop
.data:00001e68 00                               nop
.data:00001e69 00                               nop
.data:00001e6a ff                               rst 0x38
.data:00001e6b ff                               rst 0x38
.data:00001e6c ff                               rst 0x38
.data:00001e6d 00                               nop
.data:00001e6e 00                               nop
.data:00001e6f 00                               nop
.data:00001e70 01 7f ff                         ld bc,0xff7f
.data:00001e73 ff                               rst 0x38
.data:00001e74 e0                               ret po
.data:00001e75 03                               inc bc
.data:00001e76 0f                               rrca
.data:00001e77 3f                               ccf
.data:00001e78 ff                               rst 0x38
.data:00001e79 fc e2 01                         call m,0x01e2
.data:00001e7c 75                               ld (hl),l
.data:00001e7d f8                               ret m
.data:00001e7e e0                               ret po
.data:00001e7f c4 00 11                         call nz,0x1100
.data:00001e82 20 05                            jr nz,0x1e89
.data:00001e84 0b                               dec bc
.data:00001e85 7f                               ld a,a
.data:00001e86 bf                               cp a
.data:00001e87 7f                               ld a,a
.data:00001e88 ff                               rst 0x38
.data:00001e89 7f                               ld a,a
.data:00001e8a ff                               rst 0x38
.data:00001e8b ff                               rst 0x38
.data:00001e8c fe fe                            cp 0xfe
.data:00001e8e fa f6 fa                         jp m,0xfaf6
.data:00001e91 f6 ec                            or 0xec
.data:00001e93 54                               ld d,h
.data:00001e94 ac                               xor h
.data:00001e95 e1                               pop hl
.data:00001e96 5f                               ld e,a
.data:00001e97 2a 05 00                         ld hl,(0x0005)
.data:00001e9a 00                               nop
.data:00001e9b c0                               ret nz
.data:00001e9c 00                               nop
.data:00001e9d aa                               xor d
.data:00001e9e 42                               ld b,d
.data:00001e9f 86                               add a,(hl)
.data:00001ea0 27                               daa
.data:00001ea1 07                               rlca
.data:00001ea2 0b                               dec bc
.data:00001ea3 0c                               inc c
.data:00001ea4 18 2e                            jr 0x1ed4
.data:00001ea6 17                               rla
.data:00001ea7 0f                               rrca
.data:00001ea8 07                               rlca
.data:00001ea9 0b                               dec bc
.data:00001eaa 17                               rla
.data:00001eab 8b                               adc a,e
.data:00001eac 87                               add a,a
.data:00001ead a5                               and l
.data:00001eae 56                               ld d,(hl)
.data:00001eaf a5                               and l
.data:00001eb0 56                               ld d,(hl)
.data:00001eb1 a5                               and l
.data:00001eb2 56                               ld d,(hl)
.data:00001eb3 a7                               and a
.data:00001eb4 56                               ld d,(hl)
.data:00001eb5 07                               rlca
.data:00001eb6 87                               add a,a
.data:00001eb7 07                               rlca
.data:00001eb8 07                               rlca
.data:00001eb9 07                               rlca
.data:00001eba 8b                               adc a,e
.data:00001ebb 0b                               dec bc
.data:00001ebc 8b                               adc a,e
.data:00001ebd d2 91 50                         jp nc,0x5091
.data:00001ec0 91                               sub c
.data:00001ec1 c8                               ret z
.data:00001ec2 a9                               xor c
.data:00001ec3 48                               ld c,b
.data:00001ec4 a8                               xor b
.data:00001ec5 ff                               rst 0x38
.data:00001ec6 7e                               ld a,(hl)
.data:00001ec7 ff                               rst 0x38
.data:00001ec8 7f                               ld a,a
.data:00001ec9 bf                               cp a
.data:00001eca 7f                               ld a,a
.data:00001ecb bf                               cp a
.data:00001ecc 7f                               ld a,a
.data:00001ecd 51                               ld d,c
.data:00001ece 90                               sub b
.data:00001ecf 51                               ld d,c
.data:00001ed0 90                               sub b
.data:00001ed1 c0                               ret nz
.data:00001ed2 a8                               xor b
.data:00001ed3 c8                               ret z
.data:00001ed4 e8                               ret pe
.data:00001ed5 51                               ld d,c
.data:00001ed6 b2                               or d
.data:00001ed7 59                               ld e,c
.data:00001ed8 b8                               cp b
.data:00001ed9 5d                               ld e,l
.data:00001eda bc                               cp h
.data:00001edb 5c                               ld e,h
.data:00001edc be                               cp (hl)
.data:00001edd 00                               nop
.data:00001ede 00                               nop
.data:00001edf 00                               nop
.data:00001ee0 00                               nop
.data:00001ee1 00                               nop
.data:00001ee2 00                               nop
.data:00001ee3 00                               nop
.data:00001ee4 00                               nop
.data:00001ee5 00                               nop
.data:00001ee6 00                               nop
.data:00001ee7 00                               nop
.data:00001ee8 00                               nop
.data:00001ee9 00                               nop
.data:00001eea 00                               nop
.data:00001eeb 00                               nop
.data:00001eec 00                               nop
.data:00001eed 00                               nop
.data:00001eee 00                               nop
.data:00001eef 00                               nop
.data:00001ef0 00                               nop
.data:00001ef1 00                               nop
.data:00001ef2 00                               nop
.data:00001ef3 00                               nop
.data:00001ef4 00                               nop
.data:00001ef5 00                               nop
.data:00001ef6 00                               nop
.data:00001ef7 00                               nop
.data:00001ef8 00                               nop
.data:00001ef9 00                               nop
.data:00001efa 00                               nop
.data:00001efb 00                               nop
.data:00001efc 00                               nop
.data:00001efd 05                               dec b
.data:00001efe 2a 55 2f                         ld hl,(0x2f55)
.data:00001f01 5f                               ld e,a
.data:00001f02 2f                               cpl
.data:00001f03 5f                               ld e,a
.data:00001f04 3f                               ccf
.data:00001f05 41                               ld b,c
.data:00001f06 a8                               xor b
.data:00001f07 54                               ld d,h
.data:00001f08 ea fd fa                         jp pe,0xfafd
.data:00001f0b fd                               defb 0xfd
.data:00001f0c fe 7d                            cp 0x7d
.data:00001f0e f8                               ret m
.data:00001f0f 50                               ld d,b
.data:00001f10 21 02 85                         ld hl,0x8502
.data:00001f13 0a                               ld a,(bc)
.data:00001f14 05                               dec b
.data:00001f15 0a                               ld a,(bc)
.data:00001f16 55                               ld d,l
.data:00001f17 af                               xor a
.data:00001f18 5f                               ld e,a
.data:00001f19 ff                               rst 0x38
.data:00001f1a ff                               rst 0x38
.data:00001f1b ff                               rst 0x38
.data:00001f1c ff                               rst 0x38
.data:00001f1d 13                               inc de
.data:00001f1e 45                               ld b,l
.data:00001f1f b0                               or b
.data:00001f20 f8                               ret m
.data:00001f21 f0                               ret p
.data:00001f22 c1                               pop bc
.data:00001f23 8a                               adc a,d
.data:00001f24 15                               dec d
.data:00001f25 45                               ld b,l
.data:00001f26 0a                               ld a,(bc)
.data:00001f27 15                               dec d
.data:00001f28 0a                               ld a,(bc)
.data:00001f29 15                               dec d
.data:00001f2a 02                               ld (bc),a
.data:00001f2b a1                               and c
.data:00001f2c 50                               ld d,b
.data:00001f2d 73                               ld (hl),e
.data:00001f2e 99                               sbc a,c
.data:00001f2f f1                               pop af
.data:00001f30 e2 f2 e0                         jp po,0xe0f2
.data:00001f33 53                               ld d,e
.data:00001f34 a7                               and a
.data:00001f35 80                               add a,b
.data:00001f36 a7                               and a
.data:00001f37 5c                               ld e,h
.data:00001f38 bf                               cp a
.data:00001f39 2b                               dec hl
.data:00001f3a c5                               push bc
.data:00001f3b f2 5c af                         jp p,0xaf5c
.data:00001f3e 7f                               ld a,a
.data:00001f3f ff                               rst 0x38
.data:00001f40 fa cd ff                         jp m,0xffcd
.data:00001f43 87                               add a,a
.data:00001f44 71                               ld (hl),c
.data:00001f45 ff                               rst 0x38
.data:00001f46 ff                               rst 0x38
.data:00001f47 ff                               rst 0x38
.data:00001f48 bb                               cp e
.data:00001f49 44                               ld b,h
.data:00001f4a aa                               xor d
.data:00001f4b fd                               defb 0xfd
.data:00001f4c ff                               rst 0x38
.data:00001f4d a2                               and d
.data:00001f4e 40                               ld b,b
.data:00001f4f a2                               and d
.data:00001f50 49                               ld c,c
.data:00001f51 42                               ld b,d
.data:00001f52 89                               adc a,c
.data:00001f53 60                               ld h,b
.data:00001f54 9b                               sbc a,e
.data:00001f55 94                               sub h
.data:00001f56 29                               add hl,hl
.data:00001f57 00                               nop
.data:00001f58 70                               ld (hl),b
.data:00001f59 e2 65 42                         jp po,0x4265
.data:00001f5c 84                               add a,h
.data:00001f5d 00                               nop
.data:00001f5e 14                               inc d
.data:00001f5f 21 00 00                         ld hl,0x0000
.data:00001f62 55                               ld d,l
.data:00001f63 2a 57 00                         ld hl,(0x0057)
.data:00001f66 94                               sub h
.data:00001f67 0a                               ld a,(bc)
.data:00001f68 50                               ld d,b
.data:00001f69 00                               nop
.data:00001f6a 00                               nop
.data:00001f6b ac                               xor h
.data:00001f6c 03                               inc bc
.data:00001f6d 08                               ex af,af'
.data:00001f6e 41                               ld b,c
.data:00001f6f a8                               xor b
.data:00001f70 20 00                            jr nz,0x1f72
.data:00001f72 02                               ld (bc),a
.data:00001f73 89                               adc a,c
.data:00001f74 54                               ld d,h
.data:00001f75 84                               add a,h
.data:00001f76 31 8a 09                         ld sp,0x098a
.data:00001f79 02                               ld (bc),a
.data:00001f7a a4                               and h
.data:00001f7b d0                               ret nc
.data:00001f7c e6 2f                            and 0x2f
.data:00001f7e 15                               dec d
.data:00001f7f 82                               add a,d
.data:00001f80 50                               ld d,b
.data:00001f81 3b                               dec sp
.data:00001f82 4f                               ld c,a
.data:00001f83 fc 7f ff                         call m,0xff7f
.data:00001f86 58                               ld e,b
.data:00001f87 83                               add a,e
.data:00001f88 3c                               inc a
.data:00001f89 f3                               di
.data:00001f8a cf                               rst 0x08
.data:00001f8b 3f                               ccf
.data:00001f8c e7                               rst 0x20
.data:00001f8d 50                               ld d,b
.data:00001f8e f0                               ret p
.data:00001f8f f0                               ret p
.data:00001f90 e0                               ret po
.data:00001f91 f0                               ret p
.data:00001f92 f8                               ret m
.data:00001f93 e0                               ret po
.data:00001f94 17                               rla
.data:00001f95 00                               nop
.data:00001f96 01 ff 2d                         ld bc,0x2dff
.data:00001f99 50                               ld d,b
.data:00001f9a 00                               nop
.data:00001f9b 01 0f 34                         ld bc,0x340f
.data:00001f9e e9                               jp (hl)
.data:00001f9f 50                               ld d,b
.data:00001fa0 83                               add a,e
.data:00001fa1 06 1d                            ld b,0x1d
.data:00001fa3 e8                               ret pe
.data:00001fa4 53                               ld d,e
.data:00001fa5 83                               add a,e
.data:00001fa6 85                               add a,l
.data:00001fa7 83                               add a,e
.data:00001fa8 85                               add a,l
.data:00001fa9 82                               add a,d
.data:00001faa 41                               ld b,c
.data:00001fab 40                               ld b,b
.data:00001fac 41                               ld b,c
.data:00001fad a3                               and e
.data:00001fae d2 ab d2                         jp nc,0xd2ab
.data:00001fb1 eb                               ex de,hl
.data:00001fb2 d3 eb                            out (0xeb),a
.data:00001fb4 73                               ld (hl),e
.data:00001fb5 4b                               ld c,e
.data:00001fb6 9f                               sbc a,a
.data:00001fb7 1b                               dec de
.data:00001fb8 b3                               or e
.data:00001fb9 37                               scf
.data:00001fba f6 b5                            or 0xb5
.data:00001fbc 36 50                            ld (hl),0x50
.data:00001fbe 91                               sub c
.data:00001fbf 50                               ld d,b
.data:00001fc0 a1                               and c
.data:00001fc1 20 a1                            jr nz,0x1f64
.data:00001fc3 42                               ld b,d
.data:00001fc4 81                               add a,c
.data:00001fc5 bf                               cp a
.data:00001fc6 7f                               ld a,a
.data:00001fc7 bf                               cp a
.data:00001fc8 7f                               ld a,a
.data:00001fc9 bf                               cp a
.data:00001fca 7f                               ld a,a
.data:00001fcb bf                               cp a
.data:00001fcc 7f                               ld a,a
.data:00001fcd c8                               ret z
.data:00001fce a8                               xor b
.data:00001fcf c9                               ret
.data:00001fd0 a8                               xor b
.data:00001fd1 c8                               ret z
.data:00001fd2 a8                               xor b
.data:00001fd3 c9                               ret
.data:00001fd4 92                               sub d
.data:00001fd5 5e                               ld e,(hl)
.data:00001fd6 be                               cp (hl)
.data:00001fd7 7f                               ld a,a
.data:00001fd8 bf                               cp a
.data:00001fd9 7f                               ld a,a
.data:00001fda 1e 6d                            ld e,0x6d
.data:00001fdc f3                               di
.data:00001fdd 00                               nop
.data:00001fde 00                               nop
.data:00001fdf 00                               nop
.data:00001fe0 00                               nop
.data:00001fe1 00                               nop
.data:00001fe2 00                               nop
.data:00001fe3 00                               nop
.data:00001fe4 00                               nop
.data:00001fe5 00                               nop
.data:00001fe6 00                               nop
.data:00001fe7 00                               nop
.data:00001fe8 00                               nop
.data:00001fe9 00                               nop
.data:00001fea 00                               nop
.data:00001feb 00                               nop
.data:00001fec 00                               nop
.data:00001fed 00                               nop
.data:00001fee 00                               nop
.data:00001fef 00                               nop
.data:00001ff0 00                               nop
.data:00001ff1 00                               nop
.data:00001ff2 00                               nop
.data:00001ff3 00                               nop
.data:00001ff4 00                               nop
.data:00001ff5 00                               nop
.data:00001ff6 00                               nop
.data:00001ff7 00                               nop
.data:00001ff8 00                               nop
.data:00001ff9 00                               nop
.data:00001ffa 00                               nop
.data:00001ffb 00                               nop
.data:00001ffc 00                               nop
.data:00001ffd 5f                               ld e,a
.data:00001ffe 2f                               cpl
.data:00001fff 1f                               rra
.data:00002000 0f                               rrca
.data:00002001 07                               rlca
.data:00002002 40                               ld b,b
.data:00002003 20 50                            jr nz,0x2055
.data:00002005 fc f8 f1                         call m,0xf1f8
.data:00002008 c2 15 2b                         jp nz,0x2b15
.data:0000200b 55                               ld d,l
.data:0000200c 2b                               dec hl
.data:0000200d 02                               ld (bc),a
.data:0000200e a9                               xor c
.data:0000200f 54                               ld d,h
.data:00002010 fe ff                            cp 0xff
.data:00002012 ff                               rst 0x38
.data:00002013 ff                               rst 0x38
.data:00002014 ff                               rst 0x38
.data:00002015 fe 7c                            cp 0x7c
.data:00002017 a8                               xor b
.data:00002018 01 00 c1                         ld bc,0xc100
.data:0000201b 90                               sub b
.data:0000201c 04                               inc b
.data:0000201d 2b                               dec hl
.data:0000201e 5f                               ld e,a
.data:0000201f bf                               cp a
.data:00002020 5f                               ld e,a
.data:00002021 bf                               cp a
.data:00002022 4f                               ld c,a
.data:00002023 97                               sub a
.data:00002024 2a f8 fe                         ld hl,(0xfef8)
.data:00002027 ff                               rst 0x38
.data:00002028 ff                               rst 0x38
.data:00002029 ff                               rst 0x38
.data:0000202a ff                               rst 0x38
.data:0000202b fe fe                            cp 0xfe
.data:0000202d 00                               nop
.data:0000202e 05                               dec b
.data:0000202f 0e 91                            ld c,0x91
.data:00002031 27                               daa
.data:00002032 4f                               ld c,a
.data:00002033 5f                               ld e,a
.data:00002034 9f                               sbc a,a
.data:00002035 2f                               cpl
.data:00002036 1f                               rra
.data:00002037 2f                               cpl
.data:00002038 97                               sub a
.data:00002039 cf                               rst 0x08
.data:0000203a d7                               rst 0x10
.data:0000203b cf                               rst 0x08
.data:0000203c a6                               and (hl)
.data:0000203d ff                               rst 0x38
.data:0000203e f3                               di
.data:0000203f c7                               rst 0x00
.data:00002040 cf                               rst 0x08
.data:00002041 5f                               ld e,a
.data:00002042 bc                               cp h
.data:00002043 a0                               and b
.data:00002044 00                               nop
.data:00002045 fc f1 f7                         call m,0xf7f1
.data:00002048 eb                               ex de,hl
.data:00002049 e6 7e                            and 0x7e
.data:0000204b 01 80 79                         ld bc,0x7980
.data:0000204e e6 81                            and 0x81
.data:00002050 7c                               ld a,h
.data:00002051 fe ff                            cp 0xff
.data:00002053 ff                               rst 0x38
.data:00002054 3f                               ccf
.data:00002055 c8                               ret z
.data:00002056 c7                               rst 0x00
.data:00002057 1f                               rra
.data:00002058 8f                               adc a,a
.data:00002059 9a                               sbc a,d
.data:0000205a 41                               ld b,c
.data:0000205b 48                               ld c,b
.data:0000205c e6 3e                            and 0x3e
.data:0000205e 01 e9 fb                         ld bc,0xfbe9
.data:00002061 fb                               ei
.data:00002062 7d                               ld a,l
.data:00002063 0e b0                            ld c,0xb0
.data:00002065 c1                               pop bc
.data:00002066 99                               sbc a,c
.data:00002067 98                               sbc a,b
.data:00002068 00                               nop
.data:00002069 00                               nop
.data:0000206a 00                               nop
.data:0000206b 01 83 91                         ld bc,0x9183
.data:0000206e aa                               xor d
.data:0000206f ff                               rst 0x38
.data:00002070 fe 7e                            cp 0x7e
.data:00002072 0c                               inc c
.data:00002073 f1                               pop af
.data:00002074 fd                               defb 0xfd
.data:00002075 c3 9d 3c                         jp 0x3c9d
.data:00002078 71                               ld (hl),c
.data:00002079 e7                               rst 0x20
.data:0000207a df                               rst 0x18
.data:0000207b ff                               rst 0x38
.data:0000207c be                               cp (hl)
.data:0000207d 3f                               ccf
.data:0000207e a0                               and b
.data:0000207f 97                               sub a
.data:00002080 5f                               ld e,a
.data:00002081 2f                               cpl
.data:00002082 6f                               ld l,a
.data:00002083 da 11 9c                         jp c,0x9c11
.data:00002086 39                               add hl,sp
.data:00002087 f3                               di
.data:00002088 fb                               ei
.data:00002089 fe dd                            cp 0xdd
.data:0000208b f6 f8                            or 0xf8
.data:0000208d aa                               xor d
.data:0000208e 40                               ld b,b
.data:0000208f ab                               xor e
.data:00002090 47                               ld b,a
.data:00002091 07                               rlca
.data:00002092 73                               ld (hl),e
.data:00002093 cd f2 1a                         call 0x1af2
.data:00002096 40                               ld b,b
.data:00002097 e6 92                            and 0x92
.data:00002099 d3 ea                            out (0xea),a
.data:0000209b e8                               ret pe
.data:0000209c f6 86                            or 0x86
.data:0000209e 39                               add hl,sp
.data:0000209f 92                               sub d
.data:000020a0 66                               ld h,(hl)
.data:000020a1 19                               add hl,de
.data:000020a2 cb e7                            set 4,a
.data:000020a4 9f                               sbc a,a
.data:000020a5 42                               ld b,d
.data:000020a6 41                               ld b,c
.data:000020a7 82                               add a,d
.data:000020a8 81                               add a,c
.data:000020a9 0b                               dec bc
.data:000020aa 57                               ld d,a
.data:000020ab af                               xor a
.data:000020ac 7f                               ld a,a
.data:000020ad e8                               ret pe
.data:000020ae 70                               ld (hl),b
.data:000020af f9                               ld sp,hl
.data:000020b0 f3                               di
.data:000020b1 f2 f8 e8                         jp p,0xe8f8
.data:000020b4 d1                               pop de
.data:000020b5 6c                               ld l,h
.data:000020b6 a9                               xor c
.data:000020b7 ea 54 2c                         jp pe,0x2c54
.data:000020ba e1                               pop hl
.data:000020bb 98                               sbc a,b
.data:000020bc e5                               push hl
.data:000020bd 82                               add a,d
.data:000020be 05                               dec b
.data:000020bf 0a                               ld a,(bc)
.data:000020c0 55                               ld d,l
.data:000020c1 ab                               xor e
.data:000020c2 55                               ld d,l
.data:000020c3 ab                               xor e
.data:000020c4 5b                               ld e,e
.data:000020c5 ff                               rst 0x38
.data:000020c6 ff                               rst 0x38
.data:000020c7 ff                               rst 0x38
.data:000020c8 fe ff                            cp 0xff
.data:000020ca de bd                            sbc a,0xbd
.data:000020cc ea 51 90                         jp pe,0x9051
.data:000020cf 10 a2                            djnz 0x2073
.data:000020d1 25                               dec h
.data:000020d2 a2                               and d
.data:000020d3 25                               dec h
.data:000020d4 22 77 fb                         ld (0xfb77),hl
.data:000020d7 7b                               ld a,e
.data:000020d8 fb                               ei
.data:000020d9 7d                               ld a,l
.data:000020da fd 7d                            ld a,iyl
.data:000020dc fe 00                            cp 0x00
.data:000020de 00                               nop
.data:000020df 00                               nop
.data:000020e0 00                               nop
.data:000020e1 00                               nop
.data:000020e2 00                               nop
.data:000020e3 00                               nop
.data:000020e4 00                               nop
.data:000020e5 00                               nop
.data:000020e6 00                               nop
.data:000020e7 00                               nop
.data:000020e8 00                               nop
.data:000020e9 00                               nop
.data:000020ea 00                               nop
.data:000020eb 00                               nop
.data:000020ec 00                               nop
.data:000020ed 00                               nop
.data:000020ee 00                               nop
.data:000020ef 00                               nop
.data:000020f0 00                               nop
.data:000020f1 00                               nop
.data:000020f2 00                               nop
.data:000020f3 00                               nop
.data:000020f4 00                               nop
.data:000020f5 00                               nop
.data:000020f6 00                               nop
.data:000020f7 00                               nop
.data:000020f8 00                               nop
.data:000020f9 00                               nop
.data:000020fa 00                               nop
.data:000020fb 00                               nop
.data:000020fc 00                               nop
.data:000020fd 2c                               inc l
.data:000020fe 7c                               ld a,h
.data:000020ff 38 70                            jr c,0x2171
.data:00002101 71                               ld (hl),c
.data:00002102 62                               ld h,d
.data:00002103 45                               ld b,l
.data:00002104 4a                               ld c,d
.data:00002105 15                               dec d
.data:00002106 02                               ld (bc),a
.data:00002107 41                               ld b,c
.data:00002108 90                               sub b
.data:00002109 7a                               ld a,d
.data:0000210a bf                               cp a
.data:0000210b ff                               rst 0x38
.data:0000210c ff                               rst 0x38
.data:0000210d fe fc                            cp 0xfc
.data:0000210f 7c                               ld a,h
.data:00002110 38 01                            jr c,0x2113
.data:00002112 40                               ld b,b
.data:00002113 a0                               and b
.data:00002114 c2 0b 57                         jp nz,0x570b
.data:00002117 2f                               cpl
.data:00002118 bf                               cp a
.data:00002119 4f                               ld c,a
.data:0000211a b5                               or l
.data:0000211b 0a                               ld a,(bc)
.data:0000211c 81                               add a,c
.data:0000211d 05                               dec b
.data:0000211e c0                               ret nz
.data:0000211f f0                               ret p
.data:00002120 fc ff ff                         call m,0xffff
.data:00002123 bf                               cp a
.data:00002124 5d                               ld e,l
.data:00002125 7c                               ld a,h
.data:00002126 a8                               xor b
.data:00002127 12                               ld (de),a
.data:00002128 00                               nop
.data:00002129 e0                               ret po
.data:0000212a e1                               pop hl
.data:0000212b c2 c5 b8                         jp nz,0xb8c5
.data:0000212e e0                               ret po
.data:0000212f c6 2c                            add a,0x2c
.data:00002131 2c                               inc l
.data:00002132 19                               add hl,de
.data:00002133 9a                               sbc a,d
.data:00002134 4a                               ld c,d
.data:00002135 02                               ld (bc),a
.data:00002136 00                               nop
.data:00002137 a1                               and c
.data:00002138 fe 86                            cp 0x86
.data:0000213a 00                               nop
.data:0000213b 20 55                            jr nz,0x2192
.data:0000213d 0c                               inc c
.data:0000213e 73                               ld (hl),e
.data:0000213f 80                               add a,b
.data:00002140 25                               dec h
.data:00002141 04                               inc b
.data:00002142 05                               dec b
.data:00002143 88                               adc a,b
.data:00002144 58                               ld e,b
.data:00002145 10 c0                            djnz 0x2107
.data:00002147 38 46                            jr c,0x218f
.data:00002149 a1                               and c
.data:0000214a 54                               ld d,h
.data:0000214b 02                               ld (bc),a
.data:0000214c 10 07                            djnz 0x2155
.data:0000214e 29                               add hl,hl
.data:0000214f 04                               inc b
.data:00002150 03                               inc bc
.data:00002151 c1                               pop bc
.data:00002152 30 8c                            jr nc,0x20e0
.data:00002154 00                               nop
.data:00002155 eb                               ex de,hl
.data:00002156 e7                               rst 0x20
.data:00002157 6f                               ld l,a
.data:00002158 0f                               rrca
.data:00002159 3f                               ccf
.data:0000215a 5f                               ld e,a
.data:0000215b bf                               cp a
.data:0000215c 57                               ld d,a
.data:0000215d f6 fc                            or 0xfc
.data:0000215f ff                               rst 0x38
.data:00002160 ff                               rst 0x38
.data:00002161 fe ff                            cp 0xff
.data:00002163 fe ff                            cp 0xff
.data:00002165 7f                               ld a,a
.data:00002166 e4 fb 7f                         call po,0x7ffb
.data:00002169 ff                               rst 0x38
.data:0000216a 7f                               ld a,a
.data:0000216b 41                               ld b,c
.data:0000216c 30 fd                            jr nc,0x216b
.data:0000216e bc                               cp h
.data:0000216f 5f                               ld e,a
.data:00002170 ab                               xor e
.data:00002171 f5                               push af
.data:00002172 fe ff                            cp 0xff
.data:00002174 7f                               ld a,a
.data:00002175 41                               ld b,c
.data:00002176 3f                               ccf
.data:00002177 ff                               rst 0x38
.data:00002178 ff                               rst 0x38
.data:00002179 ff                               rst 0x38
.data:0000217a ff                               rst 0x38
.data:0000217b bf                               cp a
.data:0000217c fe ff                            cp 0xff
.data:0000217e fe f5                            cp 0xf5
.data:00002180 ab                               xor e
.data:00002181 ff                               rst 0x38
.data:00002182 ff                               rst 0x38
.data:00002183 7c                               ld a,h
.data:00002184 ad                               xor l
.data:00002185 00                               nop
.data:00002186 f8                               ret m
.data:00002187 7f                               ld a,a
.data:00002188 fe d5                            cp 0xd5
.data:0000218a a0                               and b
.data:0000218b 00                               nop
.data:0000218c 25                               dec h
.data:0000218d f9                               ld sp,hl
.data:0000218e fd                               defb 0xfd
.data:0000218f 0e e1                            ld c,0xe1
.data:00002191 fc ff ff                         call m,0xffff
.data:00002194 eb                               ex de,hl
.data:00002195 1c                               inc e
.data:00002196 01 bf bf                         ld bc,0xbfbf
.data:00002199 3f                               ccf
.data:0000219a fe ff                            cp 0xff
.data:0000219c ff                               rst 0x38
.data:0000219d ed ed                            defb 0xed, 0xed
.data:0000219f 7a                               ld a,d
.data:000021a0 ff                               rst 0x38
.data:000021a1 5f                               ld e,a
.data:000021a2 bc                               cp h
.data:000021a3 f1                               pop af
.data:000021a4 42                               ld b,d
.data:000021a5 be                               cp (hl)
.data:000021a6 7e                               ld a,(hl)
.data:000021a7 fd                               defb 0xfd
.data:000021a8 eb                               ex de,hl
.data:000021a9 a3                               and e
.data:000021aa 17                               rla
.data:000021ab 26 d6                            ld h,0xd6
.data:000021ad a2                               and d
.data:000021ae 01 f8 fe                         ld bc,0xfef8
.data:000021b1 ff                               rst 0x38
.data:000021b2 3b                               dec sp
.data:000021b3 18 18                            jr 0x21cd
.data:000021b5 c4 02 15                         call nz,0x1502
.data:000021b8 2a 17 bf                         ld hl,(0xbf17)
.data:000021bb cc e9 bb                         call z,0xbbe9
.data:000021be 37                               scf
.data:000021bf 75                               ld (hl),l
.data:000021c0 e6 ce                            and 0xce
.data:000021c2 1f                               rra
.data:000021c3 bd                               cp l
.data:000021c4 65                               ld h,l
.data:000021c5 d5                               push de
.data:000021c6 23                               inc hl
.data:000021c7 56                               ld d,(hl)
.data:000021c8 98                               sbc a,b
.data:000021c9 64                               ld h,h
.data:000021ca 9e                               sbc a,(hl)
.data:000021cb 39                               add hl,sp
.data:000021cc 81                               add a,c
.data:000021cd 45                               ld b,l
.data:000021ce 4a                               ld c,d
.data:000021cf 45                               ld b,l
.data:000021d0 8a                               adc a,d
.data:000021d1 85                               add a,l
.data:000021d2 a2                               and d
.data:000021d3 15                               dec d
.data:000021d4 0b                               dec bc
.data:000021d5 fe fe                            cp 0xfe
.data:000021d7 fe fe                            cp 0xfe
.data:000021d9 fe fe                            cp 0xfe
.data:000021db fe fc                            cp 0xfc
.data:000021dd 00                               nop
.data:000021de 00                               nop
.data:000021df 00                               nop
.data:000021e0 00                               nop
.data:000021e1 00                               nop
.data:000021e2 00                               nop
.data:000021e3 00                               nop
.data:000021e4 00                               nop
.data:000021e5 00                               nop
.data:000021e6 00                               nop
.data:000021e7 00                               nop
.data:000021e8 00                               nop
.data:000021e9 00                               nop
.data:000021ea 00                               nop
.data:000021eb 00                               nop
.data:000021ec 00                               nop
.data:000021ed 00                               nop
.data:000021ee 00                               nop
.data:000021ef 00                               nop
.data:000021f0 00                               nop
.data:000021f1 00                               nop
.data:000021f2 00                               nop
.data:000021f3 00                               nop
.data:000021f4 00                               nop
.data:000021f5 00                               nop
.data:000021f6 00                               nop
.data:000021f7 00                               nop
.data:000021f8 00                               nop
.data:000021f9 00                               nop
.data:000021fa 00                               nop
.data:000021fb 00                               nop
.data:000021fc 00                               nop
.data:000021fd 05                               dec b
.data:000021fe 22 61 72                         ld (0x7261),hl
.data:00002201 78                               ld a,b
.data:00002202 7c                               ld a,h
.data:00002203 7f                               ld a,a
.data:00002204 7f                               ld a,a
.data:00002205 ff                               rst 0x38
.data:00002206 ff                               rst 0x38
.data:00002207 7e                               ld a,(hl)
.data:00002208 bd                               cp l
.data:00002209 4a                               ld c,d
.data:0000220a 24                               inc h
.data:0000220b 08                               ex af,af'
.data:0000220c c0                               ret nz
.data:0000220d c5                               push bc
.data:0000220e 8a                               adc a,d
.data:0000220f 15                               dec d
.data:00002210 0b                               dec bc
.data:00002211 57                               ld d,a
.data:00002212 2b                               dec hl
.data:00002213 57                               ld d,a
.data:00002214 09                               add hl,bc
.data:00002215 50                               ld d,b
.data:00002216 aa                               xor d
.data:00002217 fd                               defb 0xfd
.data:00002218 ff                               rst 0x38
.data:00002219 ff                               rst 0x38
.data:0000221a ff                               rst 0x38
.data:0000221b ff                               rst 0x38
.data:0000221c ff                               rst 0x38
.data:0000221d 2b                               dec hl
.data:0000221e 15                               dec d
.data:0000221f 8f                               adc a,a
.data:00002220 64                               ld h,h
.data:00002221 d0                               ret nc
.data:00002222 e0                               ret po
.data:00002223 d0                               ret nc
.data:00002224 e0                               ret po
.data:00002225 8a                               adc a,d
.data:00002226 15                               dec d
.data:00002227 2b                               dec hl
.data:00002228 15                               dec d
.data:00002229 2a 55 2a                         ld hl,(0x2a55)
.data:0000222c 05                               dec b
.data:0000222d f0                               ret p
.data:0000222e ff                               rst 0x38
.data:0000222f ff                               rst 0x38
.data:00002230 ff                               rst 0x38
.data:00002231 ff                               rst 0x38
.data:00002232 ff                               rst 0x38
.data:00002233 bf                               cp a
.data:00002234 5f                               ld e,a
.data:00002235 ea fd fe                         jp pe,0xfefd
.data:00002238 ff                               rst 0x38
.data:00002239 ff                               rst 0x38
.data:0000223a ff                               rst 0x38
.data:0000223b ff                               rst 0x38
.data:0000223c ff                               rst 0x38
.data:0000223d a8                               xor b
.data:0000223e 59                               ld e,c
.data:0000223f b8                               cp b
.data:00002240 51                               ld d,c
.data:00002241 b2                               or d
.data:00002242 51                               ld d,c
.data:00002243 b2                               or d
.data:00002244 71                               ld (hl),c
.data:00002245 aa                               xor d
.data:00002246 5f                               ld e,a
.data:00002247 bf                               cp a
.data:00002248 7f                               ld a,a
.data:00002249 ff                               rst 0x38
.data:0000224a 7f                               ld a,a
.data:0000224b ff                               rst 0x38
.data:0000224c ff                               rst 0x38
.data:0000224d cc fe fc                         call z,0xfcfe
.data:00002250 fe fc                            cp 0xfc
.data:00002252 fe fe                            cp 0xfe
.data:00002254 ff                               rst 0x38
.data:00002255 22 04 10                         ld (0x1004),hl
.data:00002258 42                               ld b,d
.data:00002259 25                               dec h
.data:0000225a 53                               ld d,e
.data:0000225b 2f                               cpl
.data:0000225c 17                               rla
.data:0000225d be                               cp (hl)
.data:0000225e 55                               ld d,l
.data:0000225f 03                               inc bc
.data:00002260 ab                               xor e
.data:00002261 76                               halt
.data:00002262 f6 f6                            or 0xf6
.data:00002264 f6 c0                            or 0xc0
.data:00002266 80                               add a,b
.data:00002267 01 03 01                         ld bc,0x0103
.data:0000226a 00                               nop
.data:0000226b 00                               nop
.data:0000226c 00                               nop
.data:0000226d 3f                               ccf
.data:0000226e 1f                               rra
.data:0000226f 8d                               adc a,l
.data:00002270 ca 87 07                         jp z,0x0787
.data:00002273 07                               rlca
.data:00002274 07                               rlca
.data:00002275 df                               rst 0x18
.data:00002276 ff                               rst 0x38
.data:00002277 ff                               rst 0x38
.data:00002278 bf                               cp a
.data:00002279 6f                               ld l,a
.data:0000227a fe fd                            cp 0xfd
.data:0000227c ff                               rst 0x38
.data:0000227d f2 ff ff                         jp p,0xffff
.data:00002280 ff                               rst 0x38
.data:00002281 ff                               rst 0x38
.data:00002282 fb                               ei
.data:00002283 74                               ld (hl),h
.data:00002284 ff                               rst 0x38
.data:00002285 ff                               rst 0x38
.data:00002286 df                               rst 0x18
.data:00002287 ff                               rst 0x38
.data:00002288 ff                               rst 0x38
.data:00002289 ff                               rst 0x38
.data:0000228a 5e                               ld e,(hl)
.data:0000228b ff                               rst 0x38
.data:0000228c ff                               rst 0x38
.data:0000228d aa                               xor d
.data:0000228e d7                               rst 0x10
.data:0000228f fc e0 00                         call m,0x00e0
.data:00002292 b2                               or d
.data:00002293 ff                               rst 0x38
.data:00002294 e8                               ret pe
.data:00002295 fa d5 ea                         jp m,0xead5
.data:00002298 ff                               rst 0x38
.data:00002299 fe fe                            cp 0xfe
.data:0000229b fc fd 0d                         call m,0x0dfd
.data:0000229e 54                               ld d,h
.data:0000229f 80                               add a,b
.data:000022a0 1f                               rra
.data:000022a1 7f                               ld a,a
.data:000022a2 ff                               rst 0x38
.data:000022a3 bc                               cp h
.data:000022a4 73                               ld (hl),e
.data:000022a5 66                               ld h,(hl)
.data:000022a6 46                               ld b,(hl)
.data:000022a7 13                               inc de
.data:000022a8 22 97 86                         ld (0x8697),hl
.data:000022ab 0f                               rrca
.data:000022ac 6f                               ld l,a
.data:000022ad 59                               ld e,c
.data:000022ae dd 5c                            ld e,ixh
.data:000022b0 3e bf                            ld a,0xbf
.data:000022b2 7f                               ld a,a
.data:000022b3 ff                               rst 0x38
.data:000022b4 ff                               rst 0x38
.data:000022b5 67                               ld h,a
.data:000022b6 73                               ld (hl),e
.data:000022b7 bb                               cp e
.data:000022b8 39                               add hl,sp
.data:000022b9 6c                               ld l,h
.data:000022ba 9e                               sbc a,(hl)
.data:000022bb fe ff                            cp 0xff
.data:000022bd fe fd                            cp 0xfd
.data:000022bf f3                               di
.data:000022c0 fe 1f                            cp 0x1f
.data:000022c2 c2 54 5d                         jp nz,0x5d54
.data:000022c5 62                               ld h,d
.data:000022c6 94                               sub h
.data:000022c7 c8                               ret z
.data:000022c8 10 41                            djnz 0x230b
.data:000022ca 80                               add a,b
.data:000022cb 05                               dec b
.data:000022cc 2f                               cpl
.data:000022cd 15                               dec d
.data:000022ce 2b                               dec hl
.data:000022cf 17                               rla
.data:000022d0 ab                               xor e
.data:000022d1 57                               ld d,a
.data:000022d2 af                               xor a
.data:000022d3 7f                               ld a,a
.data:000022d4 ff                               rst 0x38
.data:000022d5 fc fc fa                         call m,0xfafc
.data:000022d8 fa f2 e6                         jp m,0xe6f2
.data:000022db ce 9e                            adc a,0x9e
.data:000022dd 00                               nop
.data:000022de 00                               nop
.data:000022df 00                               nop
.data:000022e0 00                               nop
.data:000022e1 00                               nop
.data:000022e2 00                               nop
.data:000022e3 00                               nop
.data:000022e4 00                               nop
.data:000022e5 00                               nop
.data:000022e6 00                               nop
.data:000022e7 00                               nop
.data:000022e8 00                               nop
.data:000022e9 00                               nop
.data:000022ea 00                               nop
.data:000022eb 00                               nop
.data:000022ec 00                               nop
.data:000022ed 00                               nop
.data:000022ee 00                               nop
.data:000022ef 00                               nop
.data:000022f0 00                               nop
.data:000022f1 00                               nop
.data:000022f2 00                               nop
.data:000022f3 00                               nop
.data:000022f4 00                               nop
.data:000022f5 00                               nop
.data:000022f6 00                               nop
.data:000022f7 00                               nop
.data:000022f8 00                               nop
.data:000022f9 00                               nop
.data:000022fa 00                               nop
.data:000022fb 00                               nop
.data:000022fc 00                               nop
.data:000022fd 7f                               ld a,a
.data:000022fe 7f                               ld a,a
.data:000022ff 3f                               ccf
.data:00002300 5f                               ld e,a
.data:00002301 3f                               ccf
.data:00002302 4a                               ld c,d
.data:00002303 15                               dec d
.data:00002304 02                               ld (bc),a
.data:00002305 f1                               pop af
.data:00002306 f2 e1 a2                         jp p,0xa2e1
.data:00002309 45                               ld b,l
.data:0000230a 8a                               adc a,d
.data:0000230b 05                               dec b
.data:0000230c 0b                               dec bc
.data:0000230d 02                               ld (bc),a
.data:0000230e a0                               and b
.data:0000230f 54                               ld d,h
.data:00002310 aa                               xor d
.data:00002311 55                               ld d,l
.data:00002312 fe ff                            cp 0xff
.data:00002314 ff                               rst 0x38
.data:00002315 ff                               rst 0x38
.data:00002316 bf                               cp a
.data:00002317 5e                               ld e,(hl)
.data:00002318 2f                               cpl
.data:00002319 05                               dec b
.data:0000231a 8a                               adc a,d
.data:0000231b 44                               ld b,h
.data:0000231c a0                               and b
.data:0000231d c2 45 8b                         jp nz,0x8b45
.data:00002320 17                               rla
.data:00002321 2f                               cpl
.data:00002322 17                               rla
.data:00002323 2f                               cpl
.data:00002324 57                               ld d,a
.data:00002325 80                               add a,b
.data:00002326 f0                               ret p
.data:00002327 fe ff                            cp 0xff
.data:00002329 ff                               rst 0x38
.data:0000232a ff                               rst 0x38
.data:0000232b ff                               rst 0x38
.data:0000232c ff                               rst 0x38
.data:0000232d aa                               xor d
.data:0000232e 05                               dec b
.data:0000232f 00                               nop
.data:00002330 e0                               ret po
.data:00002331 ff                               rst 0x38
.data:00002332 ff                               rst 0x38
.data:00002333 ff                               rst 0x38
.data:00002334 ff                               rst 0x38
.data:00002335 be                               cp (hl)
.data:00002336 55                               ld d,l
.data:00002337 2a 00 80                         ld hl,(0x8000)
.data:0000233a ff                               rst 0x38
.data:0000233b ff                               rst 0x38
.data:0000233c ff                               rst 0x38
.data:0000233d b2                               or d
.data:0000233e 61                               ld h,c
.data:0000233f e2 01 00                         jp po,0x0001
.data:00002342 00                               nop
.data:00002343 e0                               ret po
.data:00002344 c1                               pop bc
.data:00002345 ff                               rst 0x38
.data:00002346 7f                               ld a,a
.data:00002347 ff                               rst 0x38
.data:00002348 5d                               ld e,l
.data:00002349 2a 00 00                         ld hl,(0x0000)
.data:0000234c 55                               ld d,l
.data:0000234d ff                               rst 0x38
.data:0000234e fe ff                            cp 0xff
.data:00002350 de ab                            sbc a,0xab
.data:00002352 02                               ld (bc),a
.data:00002353 00                               nop
.data:00002354 50                               ld d,b
.data:00002355 2f                               cpl
.data:00002356 1f                               rra
.data:00002357 2f                               cpl
.data:00002358 1f                               rra
.data:00002359 2f                               cpl
.data:0000235a 57                               ld d,a
.data:0000235b 17                               rla
.data:0000235c 09                               add hl,bc
.data:0000235d fa fc ff                         jp m,0xfffc
.data:00002360 ff                               rst 0x38
.data:00002361 ff                               rst 0x38
.data:00002362 ff                               rst 0x38
.data:00002363 ff                               rst 0x38
.data:00002364 5f                               ld e,a
.data:00002365 00                               nop
.data:00002366 00                               nop
.data:00002367 80                               add a,b
.data:00002368 d4 ef d7                         call nc,0xd7ef
.data:0000236b ed fb                            defb 0xed, 0xfb
.data:0000236d 07                               rlca
.data:0000236e 0f                               rrca
.data:0000236f 0f                               rrca
.data:00002370 1f                               rra
.data:00002371 ff                               rst 0x38
.data:00002372 ff                               rst 0x38
.data:00002373 ff                               rst 0x38
.data:00002374 ff                               rst 0x38
.data:00002375 ff                               rst 0x38
.data:00002376 ff                               rst 0x38
.data:00002377 f7                               rst 0x30
.data:00002378 ff                               rst 0x38
.data:00002379 ff                               rst 0x38
.data:0000237a fb                               ei
.data:0000237b ff                               rst 0x38
.data:0000237c ff                               rst 0x38
.data:0000237d ff                               rst 0x38
.data:0000237e ff                               rst 0x38
.data:0000237f ff                               rst 0x38
.data:00002380 ff                               rst 0x38
.data:00002381 ff                               rst 0x38
.data:00002382 d4 e8 ff                         call nc,0xffe8
.data:00002385 ff                               rst 0x38
.data:00002386 fd                               defb 0xfd
.data:00002387 ea c0 20                         jp pe,0x20c0
.data:0000238a 40                               ld b,b
.data:0000238b af                               xor a
.data:0000238c fd                               defb 0xfd
.data:0000238d 7f                               ld a,a
.data:0000238e ff                               rst 0x38
.data:0000238f fc f8 f8                         call m,0xf8f8
.data:00002392 f8                               ret m
.data:00002393 f0                               ret p
.data:00002394 f0                               ret p
.data:00002395 f9                               ld sp,hl
.data:00002396 fb                               ei
.data:00002397 02                               ld (bc),a
.data:00002398 e5                               push hl
.data:00002399 f9                               ld sp,hl
.data:0000239a fe ff                            cp 0xff
.data:0000239c ff                               rst 0x38
.data:0000239d ac                               xor h
.data:0000239e 7b                               ld a,e
.data:0000239f ff                               rst 0x38
.data:000023a0 7f                               ld a,a
.data:000023a1 ff                               rst 0x38
.data:000023a2 7f                               ld a,a
.data:000023a3 9e                               sbc a,(hl)
.data:000023a4 e1                               pop hl
.data:000023a5 af                               xor a
.data:000023a6 df                               rst 0x18
.data:000023a7 9f                               sbc a,a
.data:000023a8 5f                               ld e,a
.data:000023a9 bf                               cp a
.data:000023aa bf                               cp a
.data:000023ab 7f                               ld a,a
.data:000023ac ff                               rst 0x38
.data:000023ad e7                               rst 0x20
.data:000023ae ea dd df                         jp pe,0xdfdd
.data:000023b1 df                               rst 0x18
.data:000023b2 df                               rst 0x18
.data:000023b3 ef                               rst 0x28
.data:000023b4 ef                               rst 0x28
.data:000023b5 3f                               ccf
.data:000023b6 df                               rst 0x18
.data:000023b7 df                               rst 0x18
.data:000023b8 ef                               rst 0x28
.data:000023b9 ef                               rst 0x28
.data:000023ba ef                               rst 0x28
.data:000023bb ff                               rst 0x38
.data:000023bc ff                               rst 0x38
.data:000023bd a3                               and e
.data:000023be 80                               add a,b
.data:000023bf d4 c2 e4                         call nc,0xe4c2
.data:000023c2 e0                               ret po
.data:000023c3 fc f7 c7                         call m,0xc7f7
.data:000023c6 71                               ld (hl),c
.data:000023c7 10 84                            djnz 0x234d
.data:000023c9 55                               ld d,l
.data:000023ca eb                               ex de,hl
.data:000023cb 3d                               dec a
.data:000023cc 08                               ex af,af'
.data:000023cd fe f0                            cp 0xf0
.data:000023cf 02                               ld (bc),a
.data:000023d0 16 70                            ld d,0x70
.data:000023d2 d8                               ret c
.data:000023d3 42                               ld b,d
.data:000023d4 05                               dec b
.data:000023d5 1e 94                            ld e,0x94
.data:000023d7 2c                               inc l
.data:000023d8 5c                               ld e,h
.data:000023d9 f0                               ret p
.data:000023da e2 b0 e4                         jp po,0xe4b0
.data:000023dd 00                               nop
.data:000023de 00                               nop
.data:000023df 00                               nop
.data:000023e0 00                               nop
.data:000023e1 00                               nop
.data:000023e2 00                               nop
.data:000023e3 00                               nop
.data:000023e4 00                               nop
.data:000023e5 00                               nop
.data:000023e6 00                               nop
.data:000023e7 00                               nop
.data:000023e8 00                               nop
.data:000023e9 00                               nop
.data:000023ea 00                               nop
.data:000023eb 00                               nop
.data:000023ec 00                               nop
.data:000023ed 00                               nop
.data:000023ee 00                               nop
.data:000023ef 00                               nop
.data:000023f0 00                               nop
.data:000023f1 00                               nop
.data:000023f2 00                               nop
.data:000023f3 00                               nop
.data:000023f4 00                               nop
.data:000023f5 00                               nop
.data:000023f6 00                               nop
.data:000023f7 00                               nop
.data:000023f8 00                               nop
.data:000023f9 00                               nop
.data:000023fa 00                               nop
.data:000023fb 00                               nop
.data:000023fc 00                               nop
.data:000023fd 00                               nop
.data:000023fe 28 76                            jr z,0x2476
.data:00002400 7a                               ld a,d
.data:00002401 7c                               ld a,h
.data:00002402 74                               ld (hl),h
.data:00002403 78                               ld a,b
.data:00002404 68                               ld l,b
.data:00002405 15                               dec d
.data:00002406 2b                               dec hl
.data:00002407 17                               rla
.data:00002408 2b                               dec hl
.data:00002409 57                               ld d,a
.data:0000240a ab                               xor e
.data:0000240b 57                               ld d,a
.data:0000240c ab                               xor e
.data:0000240d ff                               rst 0x38
.data:0000240e ff                               rst 0x38
.data:0000240f ff                               rst 0x38
.data:00002410 ff                               rst 0x38
.data:00002411 ff                               rst 0x38
.data:00002412 ff                               rst 0x38
.data:00002413 ff                               rst 0x38
.data:00002414 ff                               rst 0x38
.data:00002415 d0                               ret nc
.data:00002416 e0                               ret po
.data:00002417 d0                               ret nc
.data:00002418 e2 c1 ea                         jp po,0xeac1
.data:0000241b c5                               push bc
.data:0000241c 82                               add a,d
.data:0000241d 2b                               dec hl
.data:0000241e 14                               inc d
.data:0000241f 41                               ld b,c
.data:00002420 80                               add a,b
.data:00002421 50                               ld d,b
.data:00002422 a2                               and d
.data:00002423 5d                               ld e,l
.data:00002424 ff                               rst 0x38
.data:00002425 ff                               rst 0x38
.data:00002426 bf                               cp a
.data:00002427 5f                               ld e,a
.data:00002428 25                               dec h
.data:00002429 0a                               ld a,(bc)
.data:0000242a 00                               nop
.data:0000242b 60                               ld h,b
.data:0000242c d5                               push de
.data:0000242d ff                               rst 0x38
.data:0000242e ff                               rst 0x38
.data:0000242f ff                               rst 0x38
.data:00002430 ff                               rst 0x38
.data:00002431 57                               ld d,a
.data:00002432 aa                               xor d
.data:00002433 05                               dec b
.data:00002434 00                               nop
.data:00002435 ff                               rst 0x38
.data:00002436 ff                               rst 0x38
.data:00002437 ff                               rst 0x38
.data:00002438 ff                               rst 0x38
.data:00002439 ff                               rst 0x38
.data:0000243a ff                               rst 0x38
.data:0000243b 2f                               cpl
.data:0000243c 56                               ld d,(hl)
.data:0000243d 82                               add a,d
.data:0000243e 45                               ld b,l
.data:0000243f 8b                               adc a,e
.data:00002440 c5                               push bc
.data:00002441 8b                               adc a,e
.data:00002442 47                               ld b,a
.data:00002443 0b                               dec bc
.data:00002444 95                               sub l
.data:00002445 ff                               rst 0x38
.data:00002446 ff                               rst 0x38
.data:00002447 ef                               rst 0x28
.data:00002448 d5                               push de
.data:00002449 c0                               ret nz
.data:0000244a f1                               pop af
.data:0000244b ea ff ff                         jp pe,0xffff
.data:0000244e ff                               rst 0x38
.data:0000244f fd                               defb 0xfd
.data:00002450 fe fd                            cp 0xfd
.data:00002452 fe ff                            cp 0xff
.data:00002454 fe 80                            cp 0x80
.data:00002456 85                               add a,l
.data:00002457 92                               sub d
.data:00002458 81                               add a,c
.data:00002459 d2 c5 4b                         jp nc,0x4bc5
.data:0000245c d5                               push de
.data:0000245d 35                               dec (hl)
.data:0000245e 00                               nop
.data:0000245f 56                               ld d,(hl)
.data:00002460 2f                               cpl
.data:00002461 bf                               cp a
.data:00002462 fc f3 ec                         call m,0xecf3
.data:00002465 4e                               ld c,(hl)
.data:00002466 01 ea ed                         ld bc,0xedea
.data:00002469 f5                               push af
.data:0000246a 07                               rlca
.data:0000246b 81                               add a,c
.data:0000246c 00                               nop
.data:0000246d 13                               inc de
.data:0000246e bf                               cp a
.data:0000246f ff                               rst 0x38
.data:00002470 ff                               rst 0x38
.data:00002471 ff                               rst 0x38
.data:00002472 ff                               rst 0x38
.data:00002473 ff                               rst 0x38
.data:00002474 ff                               rst 0x38
.data:00002475 ff                               rst 0x38
.data:00002476 cb ff                            set 7,a
.data:00002478 fa d5 ea                         jp m,0xead5
.data:0000247b ff                               rst 0x38
.data:0000247c ff                               rst 0x38
.data:0000247d ff                               rst 0x38
.data:0000247e fe 80                            cp 0x80
.data:00002480 04                               inc b
.data:00002481 10 ba                            djnz 0x243d
.data:00002483 57                               ld d,a
.data:00002484 fe ea                            cp 0xea
.data:00002486 90                               sub b
.data:00002487 20 00                            jr nz,0x2489
.data:00002489 08                               ex af,af'
.data:0000248a a4                               and h
.data:0000248b 59                               ld e,c
.data:0000248c 7f                               ld a,a
.data:0000248d f0                               ret p
.data:0000248e f0                               ret p
.data:0000248f f0                               ret p
.data:00002490 f0                               ret p
.data:00002491 f8                               ret m
.data:00002492 f8                               ret m
.data:00002493 f8                               ret m
.data:00002494 fc ff ff                         call m,0xffff
.data:00002497 ff                               rst 0x38
.data:00002498 ff                               rst 0x38
.data:00002499 ff                               rst 0x38
.data:0000249a ff                               rst 0x38
.data:0000249b ff                               rst 0x38
.data:0000249c ff                               rst 0x38
.data:0000249d ff                               rst 0x38
.data:0000249e ff                               rst 0x38
.data:0000249f ff                               rst 0x38
.data:000024a0 ff                               rst 0x38
.data:000024a1 ff                               rst 0x38
.data:000024a2 fd                               defb 0xfd
.data:000024a3 fb                               ei
.data:000024a4 af                               xor a
.data:000024a5 ff                               rst 0x38
.data:000024a6 f7                               rst 0x30
.data:000024a7 ff                               rst 0x38
.data:000024a8 df                               rst 0x18
.data:000024a9 bf                               cp a
.data:000024aa ff                               rst 0x38
.data:000024ab ff                               rst 0x38
.data:000024ac ff                               rst 0x38
.data:000024ad af                               xor a
.data:000024ae 5f                               ld e,a
.data:000024af 7f                               ld a,a
.data:000024b0 bf                               cp a
.data:000024b1 7f                               ld a,a
.data:000024b2 ff                               rst 0x38
.data:000024b3 ff                               rst 0x38
.data:000024b4 f7                               rst 0x30
.data:000024b5 ff                               rst 0x38
.data:000024b6 ff                               rst 0x38
.data:000024b7 ff                               rst 0x38
.data:000024b8 ff                               rst 0x38
.data:000024b9 ff                               rst 0x38
.data:000024ba ff                               rst 0x38
.data:000024bb ff                               rst 0x38
.data:000024bc ff                               rst 0x38
.data:000024bd 07                               rlca
.data:000024be 07                               rlca
.data:000024bf 03                               inc bc
.data:000024c0 03                               inc bc
.data:000024c1 03                               inc bc
.data:000024c2 01 01 01                         ld bc,0x0101
.data:000024c5 c0                               ret nz
.data:000024c6 e0                               ret po
.data:000024c7 f8                               ret m
.data:000024c8 fc fe fe                         call m,0xfefe
.data:000024cb ff                               rst 0x38
.data:000024cc ff                               rst 0x38
.data:000024cd 0a                               ld a,(bc)
.data:000024ce 17                               rla
.data:000024cf 1d                               dec e
.data:000024d0 ba                               cp d
.data:000024d1 68                               ld l,b
.data:000024d2 30 03                            jr nc,0x24d7
.data:000024d4 04                               inc b
.data:000024d5 c5                               push bc
.data:000024d6 89                               adc a,c
.data:000024d7 12                               ld (de),a
.data:000024d8 25                               dec h
.data:000024d9 4b                               ld c,e
.data:000024da 95                               sub l
.data:000024db 0b                               dec bc
.data:000024dc 5f                               ld e,a
.data:000024dd 00                               nop
.data:000024de 00                               nop
.data:000024df 00                               nop
.data:000024e0 00                               nop
.data:000024e1 00                               nop
.data:000024e2 00                               nop
.data:000024e3 00                               nop
.data:000024e4 00                               nop
.data:000024e5 00                               nop
.data:000024e6 00                               nop
.data:000024e7 00                               nop
.data:000024e8 00                               nop
.data:000024e9 00                               nop
.data:000024ea 00                               nop
.data:000024eb 00                               nop
.data:000024ec 00                               nop
.data:000024ed 00                               nop
.data:000024ee 00                               nop
.data:000024ef 00                               nop
.data:000024f0 00                               nop
.data:000024f1 00                               nop
.data:000024f2 00                               nop
.data:000024f3 00                               nop
.data:000024f4 00                               nop
.data:000024f5 00                               nop
.data:000024f6 00                               nop
.data:000024f7 00                               nop
.data:000024f8 00                               nop
.data:000024f9 00                               nop
.data:000024fa 00                               nop
.data:000024fb 00                               nop
.data:000024fc 00                               nop
.data:000024fd 70                               ld (hl),b
.data:000024fe 60                               ld h,b
.data:000024ff 50                               ld d,b
.data:00002500 60                               ld h,b
.data:00002501 40                               ld b,b
.data:00002502 63                               ld h,e
.data:00002503 07                               rlca
.data:00002504 42                               ld b,d
.data:00002505 55                               ld d,l
.data:00002506 2a 15 0a                         ld hl,(0x0a15)
.data:00002509 05                               dec b
.data:0000250a 82                               add a,d
.data:0000250b 40                               ld b,b
.data:0000250c a0                               and b
.data:0000250d ff                               rst 0x38
.data:0000250e ff                               rst 0x38
.data:0000250f ff                               rst 0x38
.data:00002510 ff                               rst 0x38
.data:00002511 5f                               ld e,a
.data:00002512 ae                               xor (hl)
.data:00002513 5f                               ld e,a
.data:00002514 2e 45                            ld l,0x45
.data:00002516 ab                               xor e
.data:00002517 45                               ld b,l
.data:00002518 8b                               adc a,e
.data:00002519 45                               ld b,l
.data:0000251a aa                               xor d
.data:0000251b 45                               ld b,l
.data:0000251c 82                               add a,d
.data:0000251d ff                               rst 0x38
.data:0000251e ff                               rst 0x38
.data:0000251f ff                               rst 0x38
.data:00002520 ff                               rst 0x38
.data:00002521 ff                               rst 0x38
.data:00002522 ff                               rst 0x38
.data:00002523 ff                               rst 0x38
.data:00002524 ff                               rst 0x38
.data:00002525 ff                               rst 0x38
.data:00002526 ff                               rst 0x38
.data:00002527 ff                               rst 0x38
.data:00002528 2f                               cpl
.data:00002529 07                               rlca
.data:0000252a 89                               adc a,c
.data:0000252b f4 fd c4                         call p,0xc4fd
.data:0000252e a8                               xor b
.data:0000252f fd                               defb 0xfd
.data:00002530 ff                               rst 0x38
.data:00002531 ff                               rst 0x38
.data:00002532 ff                               rst 0x38
.data:00002533 ff                               rst 0x38
.data:00002534 ff                               rst 0x38
.data:00002535 09                               add hl,bc
.data:00002536 02                               ld (bc),a
.data:00002537 00                               nop
.data:00002538 a8                               xor b
.data:00002539 fa fd fe                         jp m,0xfefd
.data:0000253c fd                               defb 0xfd
.data:0000253d 0a                               ld a,(bc)
.data:0000253e 95                               sub l
.data:0000253f 0b                               dec bc
.data:00002540 05                               dec b
.data:00002541 02                               ld (bc),a
.data:00002542 00                               nop
.data:00002543 00                               nop
.data:00002544 14                               inc d
.data:00002545 ff                               rst 0x38
.data:00002546 ff                               rst 0x38
.data:00002547 ff                               rst 0x38
.data:00002548 7f                               ld a,a
.data:00002549 bf                               cp a
.data:0000254a 55                               ld d,l
.data:0000254b 0a                               ld a,(bc)
.data:0000254c 01 ff ff                         ld bc,0xffff
.data:0000254f ff                               rst 0x38
.data:00002550 ff                               rst 0x38
.data:00002551 ff                               rst 0x38
.data:00002552 ff                               rst 0x38
.data:00002553 bf                               cp a
.data:00002554 57                               ld d,a
.data:00002555 4b                               ld c,e
.data:00002556 e7                               rst 0x20
.data:00002557 eb                               ex de,hl
.data:00002558 e4 e2 b5                         call po,0xb5e2
.data:0000255b b1                               or c
.data:0000255c 55                               ld d,l
.data:0000255d d8                               ret c
.data:0000255e b0                               or b
.data:0000255f 60                               ld h,b
.data:00002560 e0                               ret po
.data:00002561 c0                               ret nz
.data:00002562 c0                               ret nz
.data:00002563 c0                               ret nz
.data:00002564 80                               add a,b
.data:00002565 0c                               inc c
.data:00002566 1e 1f                            ld e,0x1f
.data:00002568 0f                               rrca
.data:00002569 06 00                            ld b,0x00
.data:0000256b 00                               nop
.data:0000256c 00                               nop
.data:0000256d 7f                               ld a,a
.data:0000256e 3f                               ccf
.data:0000256f 1f                               rra
.data:00002570 0f                               rrca
.data:00002571 0f                               rrca
.data:00002572 07                               rlca
.data:00002573 07                               rlca
.data:00002574 07                               rlca
.data:00002575 ff                               rst 0x38
.data:00002576 ff                               rst 0x38
.data:00002577 ff                               rst 0x38
.data:00002578 ff                               rst 0x38
.data:00002579 ff                               rst 0x38
.data:0000257a ff                               rst 0x38
.data:0000257b ff                               rst 0x38
.data:0000257c ff                               rst 0x38
.data:0000257d bf                               cp a
.data:0000257e ff                               rst 0x38
.data:0000257f ff                               rst 0x38
.data:00002580 ff                               rst 0x38
.data:00002581 ff                               rst 0x38
.data:00002582 df                               rst 0x18
.data:00002583 bf                               cp a
.data:00002584 df                               rst 0x18
.data:00002585 fa f5 ff                         jp m,0xfff5
.data:00002588 ff                               rst 0x38
.data:00002589 ff                               rst 0x38
.data:0000258a ff                               rst 0x38
.data:0000258b ff                               rst 0x38
.data:0000258c ff                               rst 0x38
.data:0000258d f6 ef                            or 0xef
.data:0000258f ff                               rst 0x38
.data:00002590 ff                               rst 0x38
.data:00002591 ff                               rst 0x38
.data:00002592 f8                               ret m
.data:00002593 b4                               or h
.data:00002594 23                               inc hl
.data:00002595 7f                               ld a,a
.data:00002596 3f                               ccf
.data:00002597 df                               rst 0x18
.data:00002598 df                               rst 0x18
.data:00002599 0f                               rrca
.data:0000259a 8f                               adc a,a
.data:0000259b 0f                               rrca
.data:0000259c c3 ff ff                         jp 0xffff
.data:0000259f ff                               rst 0x38
.data:000025a0 ff                               rst 0x38
.data:000025a1 fe fe                            cp 0xfe
.data:000025a3 fd                               defb 0xfd
.data:000025a4 f3                               di
.data:000025a5 fb                               ei
.data:000025a6 fb                               ei
.data:000025a7 fb                               ei
.data:000025a8 f7                               rst 0x30
.data:000025a9 f7                               rst 0x30
.data:000025aa d7                               rst 0x10
.data:000025ab a6                               and (hl)
.data:000025ac ce f7                            adc a,0xf7
.data:000025ae bf                               cp a
.data:000025af f7                               rst 0x30
.data:000025b0 77                               ld (hl),a
.data:000025b1 77                               ld (hl),a
.data:000025b2 ef                               rst 0x28
.data:000025b3 ef                               rst 0x28
.data:000025b4 cf                               rst 0x08
.data:000025b5 7f                               ld a,a
.data:000025b6 ff                               rst 0x38
.data:000025b7 bf                               cp a
.data:000025b8 bf                               cp a
.data:000025b9 bf                               cp a
.data:000025ba bf                               cp a
.data:000025bb bf                               cp a
.data:000025bc bf                               cp a
.data:000025bd fe be                            cp 0xbe
.data:000025bf fe bf                            cp 0xbf
.data:000025c1 bf                               cp a
.data:000025c2 bf                               cp a
.data:000025c3 bf                               cp a
.data:000025c4 bf                               cp a
.data:000025c5 ff                               rst 0x38
.data:000025c6 ff                               rst 0x38
.data:000025c7 fe 7e                            cp 0x7e
.data:000025c9 7c                               ld a,h
.data:000025ca 78                               ld a,b
.data:000025cb b0                               or b
.data:000025cc a2                               and d
.data:000025cd 18 61                            jr 0x2630
.data:000025cf 0a                               ld a,(bc)
.data:000025d0 15                               dec d
.data:000025d1 4b                               ld c,e
.data:000025d2 17                               rla
.data:000025d3 bf                               cp a
.data:000025d4 ff                               rst 0x38
.data:000025d5 bf                               cp a
.data:000025d6 5f                               ld e,a
.data:000025d7 bf                               cp a
.data:000025d8 ff                               rst 0x38
.data:000025d9 ff                               rst 0x38
.data:000025da ff                               rst 0x38
.data:000025db fe fe                            cp 0xfe
.data:000025dd 00                               nop
.data:000025de 00                               nop
.data:000025df 00                               nop
.data:000025e0 00                               nop
.data:000025e1 00                               nop
.data:000025e2 00                               nop
.data:000025e3 00                               nop
.data:000025e4 00                               nop
.data:000025e5 00                               nop
.data:000025e6 00                               nop
.data:000025e7 00                               nop
.data:000025e8 00                               nop
.data:000025e9 00                               nop
.data:000025ea 00                               nop
.data:000025eb 00                               nop
.data:000025ec 00                               nop
.data:000025ed 00                               nop
.data:000025ee 00                               nop
.data:000025ef 00                               nop
.data:000025f0 00                               nop
.data:000025f1 00                               nop
.data:000025f2 00                               nop
.data:000025f3 00                               nop
.data:000025f4 00                               nop
.data:000025f5 00                               nop
.data:000025f6 00                               nop
.data:000025f7 00                               nop
.data:000025f8 00                               nop
.data:000025f9 00                               nop
.data:000025fa 00                               nop
.data:000025fb 00                               nop
.data:000025fc 00                               nop
.data:000025fd 05                               dec b
.data:000025fe 4a                               ld c,d
.data:000025ff 05                               dec b
.data:00002600 0a                               ld a,(bc)
.data:00002601 17                               rla
.data:00002602 2b                               dec hl
.data:00002603 17                               rla
.data:00002604 2f                               cpl
.data:00002605 54                               ld d,h
.data:00002606 aa                               xor d
.data:00002607 55                               ld d,l
.data:00002608 fb                               ei
.data:00002609 ff                               rst 0x38
.data:0000260a ff                               rst 0x38
.data:0000260b ff                               rst 0x38
.data:0000260c ff                               rst 0x38
.data:0000260d 15                               dec d
.data:0000260e 0a                               ld a,(bc)
.data:0000260f 41                               ld b,c
.data:00002610 a0                               and b
.data:00002611 d8                               ret c
.data:00002612 f5                               push af
.data:00002613 ff                               rst 0x38
.data:00002614 ff                               rst 0x38
.data:00002615 45                               ld b,l
.data:00002616 82                               add a,d
.data:00002617 00                               nop
.data:00002618 00                               nop
.data:00002619 00                               nop
.data:0000261a 00                               nop
.data:0000261b 81                               add a,c
.data:0000261c 82                               add a,d
.data:0000261d 5f                               ld e,a
.data:0000261e af                               xor a
.data:0000261f 57                               ld d,a
.data:00002620 05                               dec b
.data:00002621 02                               ld (bc),a
.data:00002622 00                               nop
.data:00002623 40                               ld b,b
.data:00002624 a0                               and b
.data:00002625 ff                               rst 0x38
.data:00002626 ff                               rst 0x38
.data:00002627 ff                               rst 0x38
.data:00002628 7f                               ld a,a
.data:00002629 af                               xor a
.data:0000262a 57                               ld d,a
.data:0000262b 0a                               ld a,(bc)
.data:0000262c 05                               dec b
.data:0000262d 53                               ld d,e
.data:0000262e c5                               push bc
.data:0000262f eb                               ex de,hl
.data:00002630 ff                               rst 0x38
.data:00002631 ff                               rst 0x38
.data:00002632 ff                               rst 0x38
.data:00002633 ff                               rst 0x38
.data:00002634 5f                               ld e,a
.data:00002635 fe fd                            cp 0xfd
.data:00002637 fe ff                            cp 0xff
.data:00002639 fe fd                            cp 0xfd
.data:0000263b fe fc                            cp 0xfc
.data:0000263d 2a 15 2f                         ld hl,(0x2f15)
.data:00002640 1f                               rra
.data:00002641 2f                               cpl
.data:00002642 1f                               rra
.data:00002643 2f                               cpl
.data:00002644 5f                               ld e,a
.data:00002645 80                               add a,b
.data:00002646 50                               ld d,b
.data:00002647 aa                               xor d
.data:00002648 ff                               rst 0x38
.data:00002649 ff                               rst 0x38
.data:0000264a ff                               rst 0x38
.data:0000264b ff                               rst 0x38
.data:0000264c ff                               rst 0x38
.data:0000264d 0a                               ld a,(bc)
.data:0000264e 01 c0 a8                         ld bc,0xa8c0
.data:00002651 fd                               defb 0xfd
.data:00002652 ff                               rst 0x38
.data:00002653 ff                               rst 0x38
.data:00002654 ff                               rst 0x38
.data:00002655 31 21 12                         ld sp,0x1221
.data:00002658 02                               ld (bc),a
.data:00002659 09                               add hl,bc
.data:0000265a a5                               and l
.data:0000265b fa fc 80                         jp m,0x80fc
.data:0000265e 80                               add a,b
.data:0000265f 80                               add a,b
.data:00002660 80                               add a,b
.data:00002661 00                               nop
.data:00002662 80                               add a,b
.data:00002663 e0                               ret po
.data:00002664 3c                               inc a
.data:00002665 00                               nop
.data:00002666 00                               nop
.data:00002667 00                               nop
.data:00002668 00                               nop
.data:00002669 00                               nop
.data:0000266a 00                               nop
.data:0000266b 00                               nop
.data:0000266c 00                               nop
.data:0000266d 07                               rlca
.data:0000266e 07                               rlca
.data:0000266f 07                               rlca
.data:00002670 07                               rlca
.data:00002671 0f                               rrca
.data:00002672 0f                               rrca
.data:00002673 1a                               ld a,(de)
.data:00002674 24                               inc h
.data:00002675 ff                               rst 0x38
.data:00002676 ff                               rst 0x38
.data:00002677 ff                               rst 0x38
.data:00002678 ff                               rst 0x38
.data:00002679 ff                               rst 0x38
.data:0000267a fd                               defb 0xfd
.data:0000267b bf                               cp a
.data:0000267c 76                               halt
.data:0000267d df                               rst 0x18
.data:0000267e ff                               rst 0x38
.data:0000267f ff                               rst 0x38
.data:00002680 ef                               rst 0x28
.data:00002681 df                               rst 0x18
.data:00002682 ef                               rst 0x28
.data:00002683 bf                               cp a
.data:00002684 6b                               ld l,e
.data:00002685 ff                               rst 0x38
.data:00002686 ff                               rst 0x38
.data:00002687 ff                               rst 0x38
.data:00002688 ff                               rst 0x38
.data:00002689 ff                               rst 0x38
.data:0000268a ff                               rst 0x38
.data:0000268b fe f5                            cp 0xf5
.data:0000268d ff                               rst 0x38
.data:0000268e ff                               rst 0x38
.data:0000268f ff                               rst 0x38
.data:00002690 ff                               rst 0x38
.data:00002691 ff                               rst 0x38
.data:00002692 ff                               rst 0x38
.data:00002693 bf                               cp a
.data:00002694 57                               ld d,a
.data:00002695 f8                               ret m
.data:00002696 ff                               rst 0x38
.data:00002697 ff                               rst 0x38
.data:00002698 fa a4 50                         jp m,0x50a4
.data:0000269b e7                               rst 0x20
.data:0000269c ff                               rst 0x38
.data:0000269d 37                               scf
.data:0000269e 8b                               adc a,e
.data:0000269f c7                               rst 0x00
.data:000026a0 e7                               rst 0x20
.data:000026a1 b5                               or l
.data:000026a2 e2 c8 93                         jp po,0x93c8
.data:000026a5 8e                               adc a,(hl)
.data:000026a6 5f                               ld e,a
.data:000026a7 9d                               sbc a,l
.data:000026a8 3d                               dec a
.data:000026a9 3d                               dec a
.data:000026aa 7d                               ld a,l
.data:000026ab fb                               ei
.data:000026ac fb                               ei
.data:000026ad ef                               rst 0x28
.data:000026ae cf                               rst 0x08
.data:000026af ef                               rst 0x28
.data:000026b0 cf                               rst 0x08
.data:000026b1 ef                               rst 0x28
.data:000026b2 cf                               rst 0x08
.data:000026b3 cf                               rst 0x08
.data:000026b4 9f                               sbc a,a
.data:000026b5 df                               rst 0x18
.data:000026b6 df                               rst 0x18
.data:000026b7 df                               rst 0x18
.data:000026b8 df                               rst 0x18
.data:000026b9 df                               rst 0x18
.data:000026ba df                               rst 0x18
.data:000026bb df                               rst 0x18
.data:000026bc df                               rst 0x18
.data:000026bd 7f                               ld a,a
.data:000026be 7f                               ld a,a
.data:000026bf 7f                               ld a,a
.data:000026c0 7f                               ld a,a
.data:000026c1 7f                               ld a,a
.data:000026c2 7f                               ld a,a
.data:000026c3 7f                               ld a,a
.data:000026c4 7f                               ld a,a
.data:000026c5 3f                               ccf
.data:000026c6 3f                               ccf
.data:000026c7 1f                               rra
.data:000026c8 1f                               rra
.data:000026c9 1f                               rra
.data:000026ca 1f                               rra
.data:000026cb 0f                               rrca
.data:000026cc 0f                               rrca
.data:000026cd 7f                               ld a,a
.data:000026ce ff                               rst 0x38
.data:000026cf ff                               rst 0x38
.data:000026d0 ff                               rst 0x38
.data:000026d1 ee a0                            xor 0xa0
.data:000026d3 a0                               and b
.data:000026d4 00                               nop
.data:000026d5 fc f8 f0                         call m,0xf0f8
.data:000026d8 40                               ld b,b
.data:000026d9 00                               nop
.data:000026da 02                               ld (bc),a
.data:000026db 01 aa 00                         ld bc,0x00aa
.data:000026de 00                               nop
.data:000026df 00                               nop
.data:000026e0 00                               nop
.data:000026e1 00                               nop
.data:000026e2 00                               nop
.data:000026e3 00                               nop
.data:000026e4 00                               nop
.data:000026e5 00                               nop
.data:000026e6 00                               nop
.data:000026e7 00                               nop
.data:000026e8 00                               nop
.data:000026e9 00                               nop
.data:000026ea 00                               nop
.data:000026eb 00                               nop
.data:000026ec 00                               nop
.data:000026ed 00                               nop
.data:000026ee 00                               nop
.data:000026ef 00                               nop
.data:000026f0 00                               nop
.data:000026f1 00                               nop
.data:000026f2 00                               nop
.data:000026f3 00                               nop
.data:000026f4 00                               nop
.data:000026f5 00                               nop
.data:000026f6 00                               nop
.data:000026f7 00                               nop
.data:000026f8 00                               nop
.data:000026f9 00                               nop
.data:000026fa 00                               nop
.data:000026fb 00                               nop
.data:000026fc 00                               nop
.data:000026fd 17                               rla
.data:000026fe 2f                               cpl
.data:000026ff 17                               rla
.data:00002700 2f                               cpl
.data:00002701 5f                               ld e,a
.data:00002702 2f                               cpl
.data:00002703 5f                               ld e,a
.data:00002704 2f                               cpl
.data:00002705 ab                               xor e
.data:00002706 c4 a1 c2                         call nz,0xc2a1
.data:00002709 95                               sub l
.data:0000270a ef                               rst 0x28
.data:0000270b ff                               rst 0x38
.data:0000270c ff                               rst 0x38
.data:0000270d ff                               rst 0x38
.data:0000270e ff                               rst 0x38
.data:0000270f ff                               rst 0x38
.data:00002710 ff                               rst 0x38
.data:00002711 ff                               rst 0x38
.data:00002712 ff                               rst 0x38
.data:00002713 ff                               rst 0x38
.data:00002714 fa 85 82                         jp m,0x8285
.data:00002717 85                               add a,l
.data:00002718 8a                               adc a,d
.data:00002719 85                               add a,l
.data:0000271a 82                               add a,d
.data:0000271b 85                               add a,l
.data:0000271c c2 55 aa                         jp nz,0xaa55
.data:0000271f 55                               ld d,l
.data:00002720 aa                               xor d
.data:00002721 7f                               ld a,a
.data:00002722 bf                               cp a
.data:00002723 7f                               ld a,a
.data:00002724 ff                               rst 0x38
.data:00002725 02                               ld (bc),a
.data:00002726 a0                               and b
.data:00002727 50                               ld d,b
.data:00002728 a8                               xor b
.data:00002729 54                               ld d,h
.data:0000272a aa                               xor d
.data:0000272b f5                               push af
.data:0000272c ea af 5f                         jp pe,0x5faf
.data:0000272f 2f                               cpl
.data:00002730 15                               dec d
.data:00002731 0a                               ld a,(bc)
.data:00002732 85                               add a,l
.data:00002733 42                               ld b,d
.data:00002734 a0                               and b
.data:00002735 fa fc fa                         jp m,0xfafc
.data:00002738 dc b2 50                         call c,0x50b2
.data:0000273b aa                               xor d
.data:0000273c 54                               ld d,h
.data:0000273d 3f                               ccf
.data:0000273e 5f                               ld e,a
.data:0000273f 3f                               ccf
.data:00002740 5f                               ld e,a
.data:00002741 3f                               ccf
.data:00002742 5f                               ld e,a
.data:00002743 2f                               cpl
.data:00002744 5f                               ld e,a
.data:00002745 ff                               rst 0x38
.data:00002746 ff                               rst 0x38
.data:00002747 ff                               rst 0x38
.data:00002748 ff                               rst 0x38
.data:00002749 ff                               rst 0x38
.data:0000274a ff                               rst 0x38
.data:0000274b ff                               rst 0x38
.data:0000274c ff                               rst 0x38
.data:0000274d ff                               rst 0x38
.data:0000274e ff                               rst 0x38
.data:0000274f ff                               rst 0x38
.data:00002750 fe fd                            cp 0xfd
.data:00002752 fb                               ei
.data:00002753 f6 ec                            or 0xec
.data:00002755 fa e0 9c                         jp m,0x9ce0
.data:00002758 70                               ld (hl),b
.data:00002759 c0                               ret nz
.data:0000275a 80                               add a,b
.data:0000275b 00                               nop
.data:0000275c 00                               nop
.data:0000275d f3                               di
.data:0000275e 0e 03                            ld c,0x03
.data:00002760 00                               nop
.data:00002761 00                               nop
.data:00002762 06 0f                            ld b,0x0f
.data:00002764 0f                               rrca
.data:00002765 e0                               ret po
.data:00002766 7f                               ld a,a
.data:00002767 ff                               rst 0x38
.data:00002768 ff                               rst 0x38
.data:00002769 7f                               ld a,a
.data:0000276a 3f                               ccf
.data:0000276b 1f                               rra
.data:0000276c 8f                               adc a,a
.data:0000276d 4f                               ld c,a
.data:0000276e bf                               cp a
.data:0000276f bf                               cp a
.data:00002770 bf                               cp a
.data:00002771 df                               rst 0x18
.data:00002772 df                               rst 0x18
.data:00002773 df                               rst 0x18
.data:00002774 ef                               rst 0x28
.data:00002775 ff                               rst 0x38
.data:00002776 ff                               rst 0x38
.data:00002777 ff                               rst 0x38
.data:00002778 ff                               rst 0x38
.data:00002779 ff                               rst 0x38
.data:0000277a ff                               rst 0x38
.data:0000277b ff                               rst 0x38
.data:0000277c ff                               rst 0x38
.data:0000277d fb                               ei
.data:0000277e f5                               push af
.data:0000277f fb                               ei
.data:00002780 ff                               rst 0x38
.data:00002781 fe ff                            cp 0xff
.data:00002783 ff                               rst 0x38
.data:00002784 fe eb                            cp 0xeb
.data:00002786 ff                               rst 0x38
.data:00002787 ff                               rst 0x38
.data:00002788 ff                               rst 0x38
.data:00002789 ff                               rst 0x38
.data:0000278a 7f                               ld a,a
.data:0000278b 7f                               ld a,a
.data:0000278c bf                               cp a
.data:0000278d eb                               ex de,hl
.data:0000278e ff                               rst 0x38
.data:0000278f ff                               rst 0x38
.data:00002790 ff                               rst 0x38
.data:00002791 ff                               rst 0x38
.data:00002792 ff                               rst 0x38
.data:00002793 ff                               rst 0x38
.data:00002794 ff                               rst 0x38
.data:00002795 ff                               rst 0x38
.data:00002796 fe f8                            cp 0xf8
.data:00002798 f0                               ret p
.data:00002799 f0                               ret p
.data:0000279a f0                               ret p
.data:0000279b f0                               ret p
.data:0000279c f8                               ret m
.data:0000279d 0f                               rrca
.data:0000279e 7f                               ld a,a
.data:0000279f ff                               rst 0x38
.data:000027a0 ff                               rst 0x38
.data:000027a1 ff                               rst 0x38
.data:000027a2 ff                               rst 0x38
.data:000027a3 ff                               rst 0x38
.data:000027a4 ff                               rst 0x38
.data:000027a5 fb                               ei
.data:000027a6 f7                               rst 0x30
.data:000027a7 f7                               rst 0x30
.data:000027a8 ef                               rst 0x28
.data:000027a9 e8                               ret pe
.data:000027aa c0                               ret nz
.data:000027ab c0                               ret nz
.data:000027ac 80                               add a,b
.data:000027ad df                               rst 0x18
.data:000027ae 9f                               sbc a,a
.data:000027af 9f                               sbc a,a
.data:000027b0 3f                               ccf
.data:000027b1 bf                               cp a
.data:000027b2 7f                               ld a,a
.data:000027b3 7f                               ld a,a
.data:000027b4 7f                               ld a,a
.data:000027b5 df                               rst 0x18
.data:000027b6 ee ee                            xor 0xee
.data:000027b8 ee ee                            xor 0xee
.data:000027ba ed ed                            defb 0xed, 0xed
.data:000027bc e8                               ret pe
.data:000027bd ff                               rst 0x38
.data:000027be ff                               rst 0x38
.data:000027bf ff                               rst 0x38
.data:000027c0 ff                               rst 0x38
.data:000027c1 ff                               rst 0x38
.data:000027c2 ff                               rst 0x38
.data:000027c3 ff                               rst 0x38
.data:000027c4 f0                               ret p
.data:000027c5 e4 e0 e0                         call po,0xe0e0
.data:000027c8 e0                               ret po
.data:000027c9 e4 c2 15                         call po,0x15c2
.data:000027cc 2b                               dec hl
.data:000027cd 00                               nop
.data:000027ce 0a                               ld a,(bc)
.data:000027cf 45                               ld b,l
.data:000027d0 2a 55 af                         ld hl,(0xaf55)
.data:000027d3 76                               halt
.data:000027d4 ff                               rst 0x38
.data:000027d5 55                               ld d,l
.data:000027d6 ab                               xor e
.data:000027d7 55                               ld d,l
.data:000027d8 bf                               cp a
.data:000027d9 fe df                            cp 0xdf
.data:000027db fe fd                            cp 0xfd
.data:000027dd 00                               nop
.data:000027de 00                               nop
.data:000027df 00                               nop
.data:000027e0 00                               nop
.data:000027e1 00                               nop
.data:000027e2 00                               nop
.data:000027e3 00                               nop
.data:000027e4 00                               nop
.data:000027e5 00                               nop
.data:000027e6 00                               nop
.data:000027e7 00                               nop
.data:000027e8 00                               nop
.data:000027e9 00                               nop
.data:000027ea 00                               nop
.data:000027eb 00                               nop
.data:000027ec 00                               nop
.data:000027ed 00                               nop
.data:000027ee 00                               nop
.data:000027ef 00                               nop
.data:000027f0 00                               nop
.data:000027f1 00                               nop
.data:000027f2 00                               nop
.data:000027f3 00                               nop
.data:000027f4 00                               nop
.data:000027f5 00                               nop
.data:000027f6 00                               nop
.data:000027f7 00                               nop
.data:000027f8 00                               nop
.data:000027f9 00                               nop
.data:000027fa 00                               nop
.data:000027fb 00                               nop
.data:000027fc 00                               nop
.data:000027fd 55                               ld d,l
.data:000027fe 2a 10 00                         ld hl,(0x0010)
.data:00002801 00                               nop
.data:00002802 00                               nop
.data:00002803 06 00                            ld b,0x00
.data:00002805 ea 80 00                         jp pe,0x0080
.data:00002808 00                               nop
.data:00002809 46                               ld b,(hl)
.data:0000280a a8                               xor b
.data:0000280b e8                               ret pe
.data:0000280c a6                               and (hl)
.data:0000280d ac                               xor h
.data:0000280e 00                               nop
.data:0000280f 00                               nop
.data:00002810 00                               nop
.data:00002811 c0                               ret nz
.data:00002812 80                               add a,b
.data:00002813 cc e0 05                         call z,0x05e0
.data:00002816 02                               ld (bc),a
.data:00002817 01 02 00                         ld bc,0x0002
.data:0000281a 00                               nop
.data:0000281b 00                               nop
.data:0000281c 00                               nop
.data:0000281d 7f                               ld a,a
.data:0000281e ff                               rst 0x38
.data:0000281f 3f                               ccf
.data:00002820 ff                               rst 0x38
.data:00002821 bf                               cp a
.data:00002822 57                               ld d,a
.data:00002823 0b                               dec bc
.data:00002824 00                               nop
.data:00002825 f5                               push af
.data:00002826 fe ff                            cp 0xff
.data:00002828 ff                               rst 0x38
.data:00002829 ff                               rst 0x38
.data:0000282a ff                               rst 0x38
.data:0000282b 6f                               ld l,a
.data:0000282c 15                               dec d
.data:0000282d 50                               ld d,b
.data:0000282e aa                               xor d
.data:0000282f 75                               ld (hl),l
.data:00002830 ba                               cp d
.data:00002831 fd                               defb 0xfd
.data:00002832 ff                               rst 0x38
.data:00002833 ff                               rst 0x38
.data:00002834 ff                               rst 0x38
.data:00002835 08                               ex af,af'
.data:00002836 00                               nop
.data:00002837 40                               ld b,b
.data:00002838 a8                               xor b
.data:00002839 e5                               push hl
.data:0000283a fa fd fe                         jp m,0xfefd
.data:0000283d 2f                               cpl
.data:0000283e 15                               dec d
.data:0000283f 2a 00 15                         ld hl,(0x1500)
.data:00002842 2a 17 0f                         ld hl,(0x0f17)
.data:00002845 fe d5                            cp 0xd5
.data:00002847 a8                               xor b
.data:00002848 55                               ld d,l
.data:00002849 00                               nop
.data:0000284a aa                               xor d
.data:0000284b dd                               defb 0xdd
.data:0000284c ff                               rst 0x38
.data:0000284d ec 58 58                         call pe,0x5858
.data:00002850 58                               ld e,b
.data:00002851 30 b0                            jr nc,0x2803
.data:00002853 b0                               or b
.data:00002854 b0                               or b
.data:00002855 00                               nop
.data:00002856 00                               nop
.data:00002857 00                               nop
.data:00002858 00                               nop
.data:00002859 00                               nop
.data:0000285a 00                               nop
.data:0000285b 00                               nop
.data:0000285c 00                               nop
.data:0000285d 07                               rlca
.data:0000285e 07                               rlca
.data:0000285f 03                               inc bc
.data:00002860 01 00 00                         ld bc,0x0000
.data:00002863 00                               nop
.data:00002864 00                               nop
.data:00002865 8f                               adc a,a
.data:00002866 c7                               rst 0x00
.data:00002867 c6 83                            add a,0x83
.data:00002869 02                               ld (bc),a
.data:0000286a 03                               inc bc
.data:0000286b 03                               inc bc
.data:0000286c 03                               inc bc
.data:0000286d ef                               rst 0x28
.data:0000286e ef                               rst 0x28
.data:0000286f a7                               and a
.data:00002870 47                               ld b,a
.data:00002871 37                               scf
.data:00002872 ff                               rst 0x38
.data:00002873 f7                               rst 0x30
.data:00002874 f7                               rst 0x30
.data:00002875 ff                               rst 0x38
.data:00002876 ff                               rst 0x38
.data:00002877 ff                               rst 0x38
.data:00002878 ff                               rst 0x38
.data:00002879 ff                               rst 0x38
.data:0000287a ff                               rst 0x38
.data:0000287b ff                               rst 0x38
.data:0000287c ff                               rst 0x38
.data:0000287d ff                               rst 0x38
.data:0000287e ff                               rst 0x38
.data:0000287f ff                               rst 0x38
.data:00002880 ff                               rst 0x38
.data:00002881 ff                               rst 0x38
.data:00002882 ff                               rst 0x38
.data:00002883 ff                               rst 0x38
.data:00002884 ff                               rst 0x38
.data:00002885 3f                               ccf
.data:00002886 5f                               ld e,a
.data:00002887 bf                               cp a
.data:00002888 df                               rst 0x18
.data:00002889 ef                               rst 0x28
.data:0000288a f7                               rst 0x30
.data:0000288b ef                               rst 0x28
.data:0000288c fb                               ei
.data:0000288d ff                               rst 0x38
.data:0000288e ff                               rst 0x38
.data:0000288f ff                               rst 0x38
.data:00002890 ff                               rst 0x38
.data:00002891 ff                               rst 0x38
.data:00002892 fe e0                            cp 0xe0
.data:00002894 11 ff fc                         ld de,0xfcff
.data:00002897 f8                               ret m
.data:00002898 e0                               ret po
.data:00002899 c0                               ret nz
.data:0000289a 08                               ex af,af'
.data:0000289b 15                               dec d
.data:0000289c 6e                               ld l,(hl)
.data:0000289d fe e8                            cp 0xe8
.data:0000289f 52                               ld d,d
.data:000028a0 bf                               cp a
.data:000028a1 ef                               rst 0x28
.data:000028a2 df                               rst 0x18
.data:000028a3 ff                               rst 0x38
.data:000028a4 ff                               rst 0x38
.data:000028a5 04                               inc b
.data:000028a6 2a d5 ff                         ld hl,(0xffd5)
.data:000028a9 ff                               rst 0x38
.data:000028aa fe f5                            cp 0xf5
.data:000028ac e0                               ret po
.data:000028ad 7f                               ld a,a
.data:000028ae 3f                               ccf
.data:000028af bf                               cp a
.data:000028b0 8f                               adc a,a
.data:000028b1 e1                               pop hl
.data:000028b2 9c                               sbc a,h
.data:000028b3 40                               ld b,b
.data:000028b4 0a                               ld a,(bc)
.data:000028b5 f0                               ret p
.data:000028b6 ea ef ef                         jp pe,0xefef
.data:000028b9 cc 00 49                         call z,0x4900
.data:000028bc a2                               and d
.data:000028bd 0d                               dec c
.data:000028be df                               rst 0x18
.data:000028bf 77                               ld (hl),a
.data:000028c0 ff                               rst 0x38
.data:000028c1 03                               inc bc
.data:000028c2 85                               add a,l
.data:000028c3 5f                               ld e,a
.data:000028c4 ff                               rst 0x38
.data:000028c5 7d                               ld a,l
.data:000028c6 db ff                            in a,(0xff)
.data:000028c8 27                               daa
.data:000028c9 6f                               ld l,a
.data:000028ca bf                               cp a
.data:000028cb ff                               rst 0x38
.data:000028cc ff                               rst 0x38
.data:000028cd bf                               cp a
.data:000028ce ff                               rst 0x38
.data:000028cf fe fd                            cp 0xfd
.data:000028d1 ff                               rst 0x38
.data:000028d2 ff                               rst 0x38
.data:000028d3 ff                               rst 0x38
.data:000028d4 ff                               rst 0x38
.data:000028d5 ea d5 af                         jp pe,0xafd5
.data:000028d8 7f                               ld a,a
.data:000028d9 ff                               rst 0x38
.data:000028da ff                               rst 0x38
.data:000028db ff                               rst 0x38
.data:000028dc ff                               rst 0x38
.data:000028dd 00                               nop
.data:000028de 00                               nop
.data:000028df 00                               nop
.data:000028e0 00                               nop
.data:000028e1 00                               nop
.data:000028e2 00                               nop
.data:000028e3 00                               nop
.data:000028e4 00                               nop
.data:000028e5 00                               nop
.data:000028e6 00                               nop
.data:000028e7 00                               nop
.data:000028e8 00                               nop
.data:000028e9 00                               nop
.data:000028ea 00                               nop
.data:000028eb 00                               nop
.data:000028ec 00                               nop
.data:000028ed 01 ff ff                         ld bc,0xffff
data2:
.data:000028f0 00                               nop
.data:000028f1 00                               nop
.data:000028f2 07                               rlca
.data:000028f3 07                               rlca
.data:000028f4 07                               rlca
.data:000028f5 07                               rlca
.data:000028f6 47                               ld b,a
.data:000028f7 45                               ld b,l
.data:000028f8 47                               ld b,a
.data:000028f9 07                               rlca
.data:000028fa 07                               rlca
.data:000028fb 07                               rlca
.data:000028fc 07                               rlca
.data:000028fd 07                               rlca
.data:000028fe 07                               rlca
.data:000028ff 07                               rlca
.data:00002900 07                               rlca
.data:00002901 07                               rlca
.data:00002902 07                               rlca
.data:00002903 07                               rlca
.data:00002904 07                               rlca
.data:00002905 07                               rlca
.data:00002906 07                               rlca
.data:00002907 07                               rlca
.data:00002908 07                               rlca
.data:00002909 07                               rlca
.data:0000290a 07                               rlca
.data:0000290b 07                               rlca
.data:0000290c 07                               rlca
.data:0000290d 04                               inc b
.data:0000290e 00                               nop
.data:0000290f 00                               nop
.data:00002910 00                               nop
.data:00002911 00                               nop
.data:00002912 07                               rlca
.data:00002913 07                               rlca
.data:00002914 07                               rlca
.data:00002915 07                               rlca
.data:00002916 45                               ld b,l
.data:00002917 45                               ld b,l
.data:00002918 47                               ld b,a
.data:00002919 47                               ld b,a
.data:0000291a 07                               rlca
.data:0000291b 07                               rlca
.data:0000291c 07                               rlca
.data:0000291d 07                               rlca
.data:0000291e 07                               rlca
.data:0000291f 07                               rlca
.data:00002920 07                               rlca
.data:00002921 07                               rlca
.data:00002922 07                               rlca
.data:00002923 07                               rlca
.data:00002924 07                               rlca
.data:00002925 07                               rlca
.data:00002926 07                               rlca
.data:00002927 07                               rlca
.data:00002928 07                               rlca
.data:00002929 07                               rlca
.data:0000292a 07                               rlca
.data:0000292b 07                               rlca
.data:0000292c 04                               inc b
.data:0000292d 04                               inc b
.data:0000292e 00                               nop
.data:0000292f 00                               nop
.data:00002930 00                               nop
.data:00002931 00                               nop
.data:00002932 04                               inc b
.data:00002933 04                               inc b
.data:00002934 07                               rlca
.data:00002935 07                               rlca
.data:00002936 45                               ld b,l
.data:00002937 45                               ld b,l
.data:00002938 47                               ld b,a
.data:00002939 47                               ld b,a
.data:0000293a 47                               ld b,a
.data:0000293b 47                               ld b,a
.data:0000293c 07                               rlca
.data:0000293d 07                               rlca
.data:0000293e 44                               ld b,h
.data:0000293f 44                               ld b,h
.data:00002940 44                               ld b,h
.data:00002941 07                               rlca
.data:00002942 07                               rlca
.data:00002943 07                               rlca
.data:00002944 07                               rlca
.data:00002945 07                               rlca
.data:00002946 07                               rlca
.data:00002947 07                               rlca
.data:00002948 07                               rlca
.data:00002949 07                               rlca
.data:0000294a 07                               rlca
.data:0000294b 04                               inc b
.data:0000294c 04                               inc b
.data:0000294d 44                               ld b,h
.data:0000294e 00                               nop
.data:0000294f 00                               nop
.data:00002950 00                               nop
.data:00002951 00                               nop
.data:00002952 44                               ld b,h
.data:00002953 44                               ld b,h
.data:00002954 04                               inc b
.data:00002955 47                               ld b,a
.data:00002956 45                               ld b,l
.data:00002957 4d                               ld c,l
.data:00002958 7d                               ld a,l
.data:00002959 7d                               ld a,l
.data:0000295a 7d                               ld a,l
.data:0000295b 47                               ld b,a
.data:0000295c 44                               ld b,h
.data:0000295d 44                               ld b,h
.data:0000295e 44                               ld b,h
.data:0000295f 44                               ld b,h
.data:00002960 44                               ld b,h
.data:00002961 44                               ld b,h
.data:00002962 44                               ld b,h
.data:00002963 07                               rlca
.data:00002964 07                               rlca
.data:00002965 07                               rlca
.data:00002966 07                               rlca
.data:00002967 07                               rlca
.data:00002968 07                               rlca
.data:00002969 07                               rlca
.data:0000296a 07                               rlca
.data:0000296b 04                               inc b
.data:0000296c 44                               ld b,h
.data:0000296d 44                               ld b,h
.data:0000296e 00                               nop
.data:0000296f 00                               nop
.data:00002970 00                               nop
.data:00002971 00                               nop
.data:00002972 74                               ld (hl),h
.data:00002973 74                               ld (hl),h
.data:00002974 44                               ld b,h
.data:00002975 44                               ld b,h
.data:00002976 45                               ld b,l
.data:00002977 4d                               ld c,l
.data:00002978 7d                               ld a,l
.data:00002979 7d                               ld a,l
.data:0000297a 6f                               ld l,a
.data:0000297b 44                               ld b,h
.data:0000297c 44                               ld b,h
.data:0000297d 44                               ld b,h
.data:0000297e 44                               ld b,h
.data:0000297f 44                               ld b,h
.data:00002980 7c                               ld a,h
.data:00002981 7c                               ld a,h
.data:00002982 44                               ld b,h
.data:00002983 44                               ld b,h
.data:00002984 07                               rlca
.data:00002985 07                               rlca
.data:00002986 07                               rlca
.data:00002987 07                               rlca
.data:00002988 07                               rlca
.data:00002989 04                               inc b
.data:0000298a 04                               inc b
.data:0000298b 44                               ld b,h
.data:0000298c 44                               ld b,h
.data:0000298d 74                               ld (hl),h
.data:0000298e 00                               nop
.data:0000298f 00                               nop
.data:00002990 00                               nop
.data:00002991 00                               nop
.data:00002992 04                               inc b
.data:00002993 44                               ld b,h
.data:00002994 44                               ld b,h
.data:00002995 44                               ld b,h
.data:00002996 44                               ld b,h
.data:00002997 45                               ld b,l
.data:00002998 4d                               ld c,l
.data:00002999 7d                               ld a,l
.data:0000299a 6c                               ld l,h
.data:0000299b 74                               ld (hl),h
.data:0000299c 44                               ld b,h
.data:0000299d 44                               ld b,h
.data:0000299e 44                               ld b,h
.data:0000299f 44                               ld b,h
.data:000029a0 44                               ld b,h
.data:000029a1 44                               ld b,h
.data:000029a2 44                               ld b,h
.data:000029a3 44                               ld b,h
.data:000029a4 44                               ld b,h
.data:000029a5 07                               rlca
.data:000029a6 04                               inc b
.data:000029a7 04                               inc b
.data:000029a8 04                               inc b
.data:000029a9 04                               inc b
.data:000029aa 04                               inc b
.data:000029ab 44                               ld b,h
.data:000029ac 44                               ld b,h
.data:000029ad 44                               ld b,h
.data:000029ae 00                               nop
.data:000029af 00                               nop
.data:000029b0 00                               nop
.data:000029b1 00                               nop
.data:000029b2 34                               inc (hl)
.data:000029b3 04                               inc b
.data:000029b4 04                               inc b
.data:000029b5 04                               inc b
.data:000029b6 04                               inc b
.data:000029b7 45                               ld b,l
.data:000029b8 45                               ld b,l
.data:000029b9 45                               ld b,l
.data:000029ba 04                               inc b
.data:000029bb 44                               ld b,h
.data:000029bc 44                               ld b,h
.data:000029bd 44                               ld b,h
.data:000029be 44                               ld b,h
.data:000029bf 44                               ld b,h
.data:000029c0 44                               ld b,h
.data:000029c1 44                               ld b,h
.data:000029c2 44                               ld b,h
.data:000029c3 44                               ld b,h
.data:000029c4 44                               ld b,h
.data:000029c5 04                               inc b
.data:000029c6 04                               inc b
.data:000029c7 04                               inc b
.data:000029c8 04                               inc b
.data:000029c9 04                               inc b
.data:000029ca 04                               inc b
.data:000029cb 04                               inc b
.data:000029cc 04                               inc b
.data:000029cd 04                               inc b
.data:000029ce 00                               nop
.data:000029cf 00                               nop
.data:000029d0 00                               nop
.data:000029d1 00                               nop
.data:000029d2 34                               inc (hl)
.data:000029d3 04                               inc b
.data:000029d4 04                               inc b
.data:000029d5 04                               inc b
.data:000029d6 04                               inc b
.data:000029d7 04                               inc b
.data:000029d8 04                               inc b
.data:000029d9 04                               inc b
.data:000029da 14                               inc d
.data:000029db 44                               ld b,h
.data:000029dc 44                               ld b,h
.data:000029dd 44                               ld b,h
.data:000029de 4c                               ld c,h
.data:000029df 4c                               ld c,h
.data:000029e0 4c                               ld c,h
.data:000029e1 44                               ld b,h
.data:000029e2 44                               ld b,h
.data:000029e3 44                               ld b,h
.data:000029e4 54                               ld d,h
.data:000029e5 04                               inc b
.data:000029e6 04                               inc b
.data:000029e7 04                               inc b
.data:000029e8 04                               inc b
.data:000029e9 04                               inc b
.data:000029ea 04                               inc b
.data:000029eb 04                               inc b
.data:000029ec 44                               ld b,h
.data:000029ed 44                               ld b,h
.data:000029ee 00                               nop
.data:000029ef 00                               nop
.data:000029f0 00                               nop
.data:000029f1 00                               nop
.data:000029f2 04                               inc b
.data:000029f3 04                               inc b
.data:000029f4 04                               inc b
.data:000029f5 04                               inc b
.data:000029f6 04                               inc b
.data:000029f7 04                               inc b
.data:000029f8 04                               inc b
.data:000029f9 04                               inc b
.data:000029fa 14                               inc d
.data:000029fb 4c                               ld c,h
.data:000029fc 44                               ld b,h
.data:000029fd 44                               ld b,h
.data:000029fe 4c                               ld c,h
.data:000029ff 4c                               ld c,h
.data:00002a00 4c                               ld c,h
.data:00002a01 44                               ld b,h
.data:00002a02 44                               ld b,h
.data:00002a03 4c                               ld c,h
.data:00002a04 54                               ld d,h
.data:00002a05 04                               inc b
.data:00002a06 04                               inc b
.data:00002a07 04                               inc b
.data:00002a08 04                               inc b
.data:00002a09 04                               inc b
.data:00002a0a 04                               inc b
.data:00002a0b 04                               inc b
.data:00002a0c 04                               inc b
.data:00002a0d 44                               ld b,h
.data:00002a0e 00                               nop
.data:00002a0f 00                               nop
.data:00002a10 00                               nop
.data:00002a11 00                               nop
.data:00002a12 04                               inc b
.data:00002a13 04                               inc b
.data:00002a14 04                               inc b
.data:00002a15 04                               inc b
.data:00002a16 04                               inc b
.data:00002a17 04                               inc b
.data:00002a18 03                               inc bc
.data:00002a19 03                               inc bc
.data:00002a1a 14                               inc d
.data:00002a1b 0c                               inc c
.data:00002a1c 44                               ld b,h
.data:00002a1d 44                               ld b,h
.data:00002a1e 4c                               ld c,h
.data:00002a1f 4c                               ld c,h
.data:00002a20 4c                               ld c,h
.data:00002a21 44                               ld b,h
.data:00002a22 54                               ld d,h
.data:00002a23 0b                               dec bc
.data:00002a24 54                               ld d,h
.data:00002a25 04                               inc b
.data:00002a26 03                               inc bc
.data:00002a27 04                               inc b
.data:00002a28 04                               inc b
.data:00002a29 04                               inc b
.data:00002a2a 04                               inc b
.data:00002a2b 04                               inc b
.data:00002a2c 44                               ld b,h
.data:00002a2d 54                               ld d,h
.data:00002a2e 00                               nop
.data:00002a2f 00                               nop
.data:00002a30 00                               nop
.data:00002a31 00                               nop
.data:00002a32 04                               inc b
.data:00002a33 04                               inc b
.data:00002a34 04                               inc b
.data:00002a35 04                               inc b
.data:00002a36 04                               inc b
.data:00002a37 04                               inc b
.data:00002a38 04                               inc b
.data:00002a39 04                               inc b
.data:00002a3a 04                               inc b
.data:00002a3b 0c                               inc c
.data:00002a3c 51                               ld d,c
.data:00002a3d 54                               ld d,h
.data:00002a3e 4c                               ld c,h
.data:00002a3f 4c                               ld c,h
.data:00002a40 4c                               ld c,h
.data:00002a41 44                               ld b,h
.data:00002a42 51                               ld d,c
.data:00002a43 0a                               ld a,(bc)
.data:00002a44 44                               ld b,h
.data:00002a45 04                               inc b
.data:00002a46 03                               inc bc
.data:00002a47 04                               inc b
.data:00002a48 04                               inc b
.data:00002a49 04                               inc b
.data:00002a4a 04                               inc b
.data:00002a4b 04                               inc b
.data:00002a4c 44                               ld b,h
.data:00002a4d 54                               ld d,h
.data:00002a4e 00                               nop
.data:00002a4f 00                               nop
.data:00002a50 00                               nop
.data:00002a51 00                               nop
.data:00002a52 04                               inc b
.data:00002a53 04                               inc b
.data:00002a54 04                               inc b
.data:00002a55 04                               inc b
.data:00002a56 04                               inc b
.data:00002a57 04                               inc b
.data:00002a58 04                               inc b
.data:00002a59 04                               inc b
.data:00002a5a 04                               inc b
.data:00002a5b 0c                               inc c
.data:00002a5c 0a                               ld a,(bc)
.data:00002a5d 0a                               ld a,(bc)
.data:00002a5e 0a                               ld a,(bc)
.data:00002a5f 0a                               ld a,(bc)
.data:00002a60 0a                               ld a,(bc)
.data:00002a61 0a                               ld a,(bc)
.data:00002a62 0a                               ld a,(bc)
.data:00002a63 4c                               ld c,h
.data:00002a64 44                               ld b,h
.data:00002a65 04                               inc b
.data:00002a66 04                               inc b
.data:00002a67 04                               inc b
.data:00002a68 04                               inc b
.data:00002a69 04                               inc b
.data:00002a6a 04                               inc b
.data:00002a6b 04                               inc b
.data:00002a6c 44                               ld b,h
.data:00002a6d 54                               ld d,h
.data:00002a6e 00                               nop
.data:00002a6f 00                               nop
.data:00002a70 00                               nop
.data:00002a71 00                               nop
.data:00002a72 04                               inc b
.data:00002a73 04                               inc b
.data:00002a74 04                               inc b
.data:00002a75 06 06                            ld b,0x06
.data:00002a77 06 06                            ld b,0x06
.data:00002a79 04                               inc b
.data:00002a7a 04                               inc b
.data:00002a7b 04                               inc b
.data:00002a7c 0c                               inc c
.data:00002a7d 0a                               ld a,(bc)
.data:00002a7e 0a                               ld a,(bc)
.data:00002a7f 0a                               ld a,(bc)
.data:00002a80 0a                               ld a,(bc)
.data:00002a81 0a                               ld a,(bc)
.data:00002a82 0c                               inc c
.data:00002a83 44                               ld b,h
.data:00002a84 44                               ld b,h
.data:00002a85 04                               inc b
.data:00002a86 04                               inc b
.data:00002a87 04                               inc b
.data:00002a88 04                               inc b
.data:00002a89 04                               inc b
.data:00002a8a 04                               inc b
.data:00002a8b 44                               ld b,h
.data:00002a8c 04                               inc b
.data:00002a8d 44                               ld b,h
.data:00002a8e 00                               nop
.data:00002a8f 00                               nop
.data:00002a90 00                               nop
.data:00002a91 00                               nop
.data:00002a92 06 06                            ld b,0x06
.data:00002a94 46                               ld b,(hl)
.data:00002a95 06 06                            ld b,0x06
.data:00002a97 06 06                            ld b,0x06
.data:00002a99 04                               inc b
.data:00002a9a 04                               inc b
.data:00002a9b 04                               inc b
.data:00002a9c 04                               inc b
.data:00002a9d 0c                               inc c
.data:00002a9e 0c                               inc c
.data:00002a9f 0c                               inc c
.data:00002aa0 0c                               inc c
.data:00002aa1 0c                               inc c
.data:00002aa2 04                               inc b
.data:00002aa3 44                               ld b,h
.data:00002aa4 44                               ld b,h
.data:00002aa5 04                               inc b
.data:00002aa6 04                               inc b
.data:00002aa7 04                               inc b
.data:00002aa8 04                               inc b
.data:00002aa9 04                               inc b
.data:00002aaa 04                               inc b
.data:00002aab 44                               ld b,h
.data:00002aac 44                               ld b,h
.data:00002aad 44                               ld b,h
.data:00002aae 00                               nop
.data:00002aaf 00                               nop
.data:00002ab0 00                               nop
.data:00002ab1 00                               nop
.data:00002ab2 46                               ld b,(hl)
.data:00002ab3 46                               ld b,(hl)
.data:00002ab4 06 06                            ld b,0x06
.data:00002ab6 06 06                            ld b,0x06
.data:00002ab8 06 04                            ld b,0x04
.data:00002aba 04                               inc b
.data:00002abb 04                               inc b
.data:00002abc 04                               inc b
.data:00002abd 06 06                            ld b,0x06
.data:00002abf 06 06                            ld b,0x06
.data:00002ac1 06 44                            ld b,0x44
.data:00002ac3 44                               ld b,h
.data:00002ac4 44                               ld b,h
.data:00002ac5 04                               inc b
.data:00002ac6 04                               inc b
.data:00002ac7 04                               inc b
.data:00002ac8 04                               inc b
.data:00002ac9 04                               inc b
.data:00002aca 04                               inc b
.data:00002acb 44                               ld b,h
.data:00002acc 44                               ld b,h
.data:00002acd 44                               ld b,h
.data:00002ace 00                               nop
.data:00002acf 00                               nop
.data:00002ad0 00                               nop
.data:00002ad1 00                               nop
.data:00002ad2 46                               ld b,(hl)
.data:00002ad3 46                               ld b,(hl)
.data:00002ad4 06 06                            ld b,0x06
.data:00002ad6 06 06                            ld b,0x06
.data:00002ad8 05                               dec b
.data:00002ad9 04                               inc b
.data:00002ada 04                               inc b
.data:00002adb 04                               inc b
.data:00002adc 05                               dec b
.data:00002add 46                               ld b,(hl)
.data:00002ade 46                               ld b,(hl)
.data:00002adf 47                               ld b,a
.data:00002ae0 46                               ld b,(hl)
.data:00002ae1 05                               dec b
.data:00002ae2 44                               ld b,h
.data:00002ae3 44                               ld b,h
.data:00002ae4 45                               ld b,l
.data:00002ae5 05                               dec b
.data:00002ae6 04                               inc b
.data:00002ae7 44                               ld b,h
.data:00002ae8 44                               ld b,h
.data:00002ae9 04                               inc b
.data:00002aea 44                               ld b,h
.data:00002aeb 44                               ld b,h
.data:00002aec 04                               inc b
.data:00002aed 44                               ld b,h
.data:00002aee 00                               nop
.data:00002aef 00                               nop
.data:00002af0 00                               nop
.data:00002af1 00                               nop
.data:00002af2 06 06                            ld b,0x06
.data:00002af4 06 06                            ld b,0x06
.data:00002af6 06 06                            ld b,0x06
.data:00002af8 05                               dec b
.data:00002af9 05                               dec b
.data:00002afa 05                               dec b
.data:00002afb 05                               dec b
.data:00002afc 05                               dec b
.data:00002afd 46                               ld b,(hl)
.data:00002afe 46                               ld b,(hl)
.data:00002aff 46                               ld b,(hl)
.data:00002b00 46                               ld b,(hl)
.data:00002b01 46                               ld b,(hl)
.data:00002b02 66                               ld h,(hl)
.data:00002b03 66                               ld h,(hl)
.data:00002b04 44                               ld b,h
.data:00002b05 44                               ld b,h
.data:00002b06 44                               ld b,h
.data:00002b07 44                               ld b,h
.data:00002b08 45                               ld b,l
.data:00002b09 44                               ld b,h
.data:00002b0a 44                               ld b,h
.data:00002b0b 44                               ld b,h
.data:00002b0c 04                               inc b
.data:00002b0d 44                               ld b,h
.data:00002b0e 00                               nop
.data:00002b0f 00                               nop
.data:00002b10 00                               nop
.data:00002b11 00                               nop
.data:00002b12 06 06                            ld b,0x06
.data:00002b14 06 06                            ld b,0x06
.data:00002b16 06 46                            ld b,0x46
.data:00002b18 46                               ld b,(hl)
.data:00002b19 46                               ld b,(hl)
.data:00002b1a 46                               ld b,(hl)
.data:00002b1b 46                               ld b,(hl)
.data:00002b1c 46                               ld b,(hl)
.data:00002b1d 46                               ld b,(hl)
.data:00002b1e 46                               ld b,(hl)
.data:00002b1f 47                               ld b,a
.data:00002b20 46                               ld b,(hl)
.data:00002b21 46                               ld b,(hl)
.data:00002b22 46                               ld b,(hl)
.data:00002b23 46                               ld b,(hl)
.data:00002b24 66                               ld h,(hl)
.data:00002b25 44                               ld b,h
.data:00002b26 45                               ld b,l
.data:00002b27 45                               ld b,l
.data:00002b28 45                               ld b,l
.data:00002b29 45                               ld b,l
.data:00002b2a 44                               ld b,h
.data:00002b2b 44                               ld b,h
.data:00002b2c 44                               ld b,h
.data:00002b2d 44                               ld b,h
.data:00002b2e 00                               nop
.data:00002b2f 00                               nop
.data:00002b30 00                               nop
.data:00002b31 00                               nop
.data:00002b32 06 06                            ld b,0x06
.data:00002b34 06 06                            ld b,0x06
.data:00002b36 06 06                            ld b,0x06
.data:00002b38 06 06                            ld b,0x06
.data:00002b3a 46                               ld b,(hl)
.data:00002b3b 46                               ld b,(hl)
.data:00002b3c 46                               ld b,(hl)
.data:00002b3d 46                               ld b,(hl)
.data:00002b3e 46                               ld b,(hl)
.data:00002b3f 46                               ld b,(hl)
.data:00002b40 46                               ld b,(hl)
.data:00002b41 46                               ld b,(hl)
.data:00002b42 66                               ld h,(hl)
.data:00002b43 66                               ld h,(hl)
.data:00002b44 6c                               ld l,h
.data:00002b45 45                               ld b,l
.data:00002b46 4d                               ld c,l
.data:00002b47 4d                               ld c,l
.data:00002b48 45                               ld b,l
.data:00002b49 45                               ld b,l
.data:00002b4a 45                               ld b,l
.data:00002b4b 44                               ld b,h
.data:00002b4c 44                               ld b,h
.data:00002b4d 04                               inc b
.data:00002b4e 00                               nop
.data:00002b4f 00                               nop
.data:00002b50 00                               nop
.data:00002b51 00                               nop
.data:00002b52 06 06                            ld b,0x06
.data:00002b54 06 06                            ld b,0x06
.data:00002b56 06 06                            ld b,0x06
.data:00002b58 06 06                            ld b,0x06
.data:00002b5a 06 7e                            ld b,0x7e
.data:00002b5c 46                               ld b,(hl)
.data:00002b5d 46                               ld b,(hl)
.data:00002b5e 46                               ld b,(hl)
.data:00002b5f 46                               ld b,(hl)
.data:00002b60 46                               ld b,(hl)
.data:00002b61 66                               ld h,(hl)
.data:00002b62 66                               ld h,(hl)
.data:00002b63 66                               ld h,(hl)
.data:00002b64 6c                               ld l,h
.data:00002b65 7d                               ld a,l
.data:00002b66 7d                               ld a,l
.data:00002b67 7d                               ld a,l
.data:00002b68 45                               ld b,l
.data:00002b69 45                               ld b,l
.data:00002b6a 6f                               ld l,a
.data:00002b6b 47                               ld b,a
.data:00002b6c 04                               inc b
.data:00002b6d 44                               ld b,h
.data:00002b6e 00                               nop
.data:00002b6f 00                               nop
.data:00002b70 00                               nop
.data:00002b71 00                               nop
.data:00002b72 06 06                            ld b,0x06
.data:00002b74 06 06                            ld b,0x06
.data:00002b76 06 3e                            ld b,0x3e
.data:00002b78 06 06                            ld b,0x06
.data:00002b7a 46                               ld b,(hl)
.data:00002b7b 46                               ld b,(hl)
.data:00002b7c 46                               ld b,(hl)
.data:00002b7d 46                               ld b,(hl)
.data:00002b7e 46                               ld b,(hl)
.data:00002b7f 47                               ld b,a
.data:00002b80 46                               ld b,(hl)
.data:00002b81 46                               ld b,(hl)
.data:00002b82 46                               ld b,(hl)
.data:00002b83 46                               ld b,(hl)
.data:00002b84 46                               ld b,(hl)
.data:00002b85 45                               ld b,l
.data:00002b86 7d                               ld a,l
.data:00002b87 4d                               ld c,l
.data:00002b88 4d                               ld c,l
.data:00002b89 7d                               ld a,l
.data:00002b8a 4d                               ld c,l
.data:00002b8b 47                               ld b,a
.data:00002b8c 44                               ld b,h
.data:00002b8d 44                               ld b,h
.data:00002b8e 00                               nop
.data:00002b8f 00                               nop
.data:00002b90 00                               nop
.data:00002b91 00                               nop
.data:00002b92 06 06                            ld b,0x06
.data:00002b94 06 06                            ld b,0x06
.data:00002b96 06 06                            ld b,0x06
.data:00002b98 3e 06                            ld a,0x06
.data:00002b9a 46                               ld b,(hl)
.data:00002b9b 46                               ld b,(hl)
.data:00002b9c 46                               ld b,(hl)
.data:00002b9d 46                               ld b,(hl)
.data:00002b9e 46                               ld b,(hl)
.data:00002b9f 46                               ld b,(hl)
.data:00002ba0 46                               ld b,(hl)
.data:00002ba1 46                               ld b,(hl)
.data:00002ba2 46                               ld b,(hl)
.data:00002ba3 46                               ld b,(hl)
.data:00002ba4 46                               ld b,(hl)
.data:00002ba5 66                               ld h,(hl)
.data:00002ba6 45                               ld b,l
.data:00002ba7 4d                               ld c,l
.data:00002ba8 4d                               ld c,l
.data:00002ba9 7d                               ld a,l
.data:00002baa 4d                               ld c,l
.data:00002bab 6c                               ld l,h
.data:00002bac 44                               ld b,h
.data:00002bad 44                               ld b,h
.data:00002bae 00                               nop
.data:00002baf 00                               nop
.data:00002bb0 00                               nop
.data:00002bb1 00                               nop
.data:00002bb2 06 3e                            ld b,0x3e
.data:00002bb4 06 06                            ld b,0x06
.data:00002bb6 06 06                            ld b,0x06
.data:00002bb8 06 06                            ld b,0x06
.data:00002bba 46                               ld b,(hl)
.data:00002bbb 46                               ld b,(hl)
.data:00002bbc 46                               ld b,(hl)
.data:00002bbd 46                               ld b,(hl)
.data:00002bbe 46                               ld b,(hl)
.data:00002bbf 46                               ld b,(hl)
.data:00002bc0 46                               ld b,(hl)
.data:00002bc1 46                               ld b,(hl)
.data:00002bc2 46                               ld b,(hl)
.data:00002bc3 46                               ld b,(hl)
.data:00002bc4 46                               ld b,(hl)
.data:00002bc5 6e                               ld l,(hl)
.data:00002bc6 45                               ld b,l
.data:00002bc7 45                               ld b,l
.data:00002bc8 45                               ld b,l
.data:00002bc9 7d                               ld a,l
.data:00002bca 45                               ld b,l
.data:00002bcb 45                               ld b,l
.data:00002bcc 44                               ld b,h
.data:00002bcd 44                               ld b,h
.data:00002bce 00                               nop
.data:00002bcf 00                               nop
.data:00002bd0 00                               nop
.data:00002bd1 00                               nop
.data:00002bd2 06 06                            ld b,0x06
.data:00002bd4 06 06                            ld b,0x06
.data:00002bd6 06 06                            ld b,0x06
.data:00002bd8 06 06                            ld b,0x06
.data:00002bda 46                               ld b,(hl)
.data:00002bdb 46                               ld b,(hl)
.data:00002bdc 46                               ld b,(hl)
.data:00002bdd 46                               ld b,(hl)
.data:00002bde 47                               ld b,a
.data:00002bdf 46                               ld b,(hl)
.data:00002be0 46                               ld b,(hl)
.data:00002be1 46                               ld b,(hl)
.data:00002be2 46                               ld b,(hl)
.data:00002be3 46                               ld b,(hl)
.data:00002be4 66                               ld h,(hl)
.data:00002be5 66                               ld h,(hl)
.data:00002be6 44                               ld b,h
.data:00002be7 44                               ld b,h
.data:00002be8 45                               ld b,l
.data:00002be9 45                               ld b,l
.data:00002bea 44                               ld b,h
.data:00002beb 44                               ld b,h
.data:00002bec 44                               ld b,h
.data:00002bed 44                               ld b,h
.data:00002bee 00                               nop
.data:00002bef 00                               nop
.data:00002bf0 e1                               pop hl
.data:00002bf1 fb                               ei
.data:00002bf2 c9                               ret
.data:00002bf3 00                               nop
.data:00002bf4 00                               nop
.data:00002bf5 00                               nop
.data:00002bf6 00                               nop
.data:00002bf7 00                               nop
.data:00002bf8 00                               nop
.data:00002bf9 12                               ld (de),a
.data:00002bfa 01 02 01                         ld bc,0x0102
.data:00002bfd 01 c8 c0                         ld bc,0xc0c8
.data:00002c00 10 10                            djnz 0x2c12
.data:00002c02 01 00 38                         ld bc,0x3800
.data:00002c05 00                               nop
.data:00002c06 00                               nop
.data:00002c07 00                               nop
.data:00002c08 00                               nop
.data:00002c09 00                               nop
.data:00002c0a 00                               nop
.data:00002c0b 00                               nop
.data:00002c0c 00                               nop
.data:00002c0d 00                               nop
.data:00002c0e 00                               nop
.data:00002c0f 00                               nop
.data:00002c10 00                               nop
.data:00002c11 00                               nop
.data:00002c12 00                               nop
.data:00002c13 00                               nop
.data:00002c14 00                               nop
.data:00002c15 00                               nop
.data:00002c16 18 10                            jr 0x2c28
.data:00002c18 78                               ld a,b
.data:00002c19 00                               nop
.data:00002c1a 00                               nop
.data:00002c1b 00                               nop
.data:00002c1c 00                               nop
.data:00002c1d 00                               nop
.data:00002c1e 00                               nop
.data:00002c1f 00                               nop
.data:00002c20 00                               nop
.data:00002c21 00                               nop
.data:00002c22 00                               nop
.data:00002c23 00                               nop
.data:00002c24 78                               ld a,b
.data:00002c25 00                               nop
.data:00002c26 00                               nop
.data:00002c27 03                               inc bc
.data:00002c28 00                               nop
.data:00002c29 00                               nop
.data:00002c2a 00                               nop
.data:00002c2b 00                               nop
.data:00002c2c 00                               nop
.data:00002c2d 00                               nop
.data:00002c2e 00                               nop
.data:00002c2f 00                               nop
.data:00002c30 00                               nop
.data:00002c31 00                               nop
.data:00002c32 00                               nop
.data:00002c33 00                               nop
.data:00002c34 00                               nop
.data:00002c35 00                               nop
.data:00002c36 18 68                            jr 0x2ca0
.data:00002c38 00                               nop
.data:00002c39 01 02 01                         ld bc,0x0102
.data:00002c3c 03                               inc bc
.data:00002c3d 01 02 03                         ld bc,0x0302
.data:00002c40 04                               inc b
.data:00002c41 01 02 01                         ld bc,0x0102
.data:00002c44 03                               inc bc
.data:00002c45 01 02 01                         ld bc,0x0102
.data:00002c48 50                               ld d,b
.data:00002c49 2c                               inc l
.data:00002c4a 64                               ld h,h
.data:00002c4b 2c                               inc l
.data:00002c4c 78                               ld a,b
.data:00002c4d 2c                               inc l
.data:00002c4e 8c                               adc a,h
.data:00002c4f 2c                               inc l
.data:00002c50 fe fe                            cp 0xfe
.data:00002c52 fe fe                            cp 0xfe
.data:00002c54 00                               nop
.data:00002c55 01 02 01                         ld bc,0x0102
.data:00002c58 80                               add a,b
.data:00002c59 81                               add a,c
.data:00002c5a 82                               add a,d
.data:00002c5b 81                               add a,c
.data:00002c5c 03                               inc bc
.data:00002c5d 04                               inc b
.data:00002c5e 05                               dec b
.data:00002c5f 04                               inc b
.data:00002c60 06 06                            ld b,0x06
.data:00002c62 06 06                            ld b,0x06
.data:00002c64 fe fe                            cp 0xfe
.data:00002c66 fe fe                            cp 0xfe
.data:00002c68 07                               rlca
.data:00002c69 08                               ex af,af'
.data:00002c6a 09                               add hl,bc
.data:00002c6b 08                               ex af,af'
.data:00002c6c 87                               add a,a
.data:00002c6d 88                               adc a,b
.data:00002c6e 89                               adc a,c
.data:00002c6f 88                               adc a,b
.data:00002c70 0a                               ld a,(bc)
.data:00002c71 39                               add hl,sp
.data:00002c72 0b                               dec bc
.data:00002c73 39                               add hl,sp
.data:00002c74 06 06                            ld b,0x06
.data:00002c76 06 06                            ld b,0x06
.data:00002c78 fe fe                            cp 0xfe
.data:00002c7a fe fe                            cp 0xfe
.data:00002c7c 10 11                            djnz 0x2c8f
.data:00002c7e 12                               ld (de),a
.data:00002c7f 11 90 91                         ld de,0x9190
.data:00002c82 92                               sub d
.data:00002c83 91                               sub c
.data:00002c84 13                               inc de
.data:00002c85 18 14                            jr 0x2c9b
.data:00002c87 18 15                            jr 0x2c9e
.data:00002c89 19                               add hl,de
.data:00002c8a 16 19                            ld d,0x19
.data:00002c8c fe fe                            cp 0xfe
.data:00002c8e fe fe                            cp 0xfe
.data:00002c90 0d                               dec c
.data:00002c91 0d                               dec c
.data:00002c92 0d                               dec c
.data:00002c93 0d                               dec c
.data:00002c94 8d                               adc a,l
.data:00002c95 8d                               adc a,l
.data:00002c96 8d                               adc a,l
.data:00002c97 8d                               adc a,l
.data:00002c98 0e 0e                            ld c,0x0e
.data:00002c9a 0e 0e                            ld c,0x0e
.data:00002c9c 0f                               rrca
.data:00002c9d 0f                               rrca
.data:00002c9e 0f                               rrca
.data:00002c9f 0f                               rrca
.data:00002ca0 3a 10 2c                         ld a,(0x2c10)
.data:00002ca3 f5                               push af
.data:00002ca4 3a ca 60                         ld a,(0x60ca)
.data:00002ca7 a7                               and a
.data:00002ca8 28 03                            jr z,0x2cad
.data:00002caa 7a                               ld a,d
.data:00002cab 18 03                            jr 0x2cb0
.data:00002cad cd 3c 8e                         call 0x8e3c
.data:00002cb0 32 15 2c                         ld (0x2c15),a
.data:00002cb3 47                               ld b,a
.data:00002cb4 e6 10                            and 0x10
.data:00002cb6 21 1c 2c                         ld hl,0x2c1c
.data:00002cb9 0e 00                            ld c,0x00
.data:00002cbb 28 09                            jr z,0x2cc6
.data:00002cbd 7e                               ld a,(hl)
.data:00002cbe a7                               and a
.data:00002cbf 20 07                            jr nz,0x2cc8
.data:00002cc1 0e 01                            ld c,0x01
.data:00002cc3 71                               ld (hl),c
.data:00002cc4 18 02                            jr 0x2cc8
.data:00002cc6 36 00                            ld (hl),0x00
.data:00002cc8 23                               inc hl
.data:00002cc9 71                               ld (hl),c
.data:00002cca 78                               ld a,b
.data:00002ccb ed 4b 16 2c                      ld bc,(0x2c16)
.data:00002ccf cd b6 8c                         call 0x8cb6
.data:00002cd2 c1                               pop bc
.data:00002cd3 e6 0f                            and 0x0f
.data:00002cd5 4f                               ld c,a
.data:00002cd6 3a 1a 2c                         ld a,(0x2c1a)
.data:00002cd9 a7                               and a
.data:00002cda 28 01                            jr z,0x2cdd
.data:00002cdc 4f                               ld c,a
.data:00002cdd d5                               push de
.data:00002cde 7b                               ld a,e
.data:00002cdf 1e 0f                            ld e,0x0f
.data:00002ce1 e6 03                            and 0x03
.data:00002ce3 28 02                            jr z,0x2ce7
.data:00002ce5 1e 03                            ld e,0x03
.data:00002ce7 7a                               ld a,d
.data:00002ce8 e6 03                            and 0x03
.data:00002cea 28 02                            jr z,0x2cee
.data:00002cec 1e 0c                            ld e,0x0c
.data:00002cee 79                               ld a,c
.data:00002cef a3                               and e
.data:00002cf0 20 01                            jr nz,0x2cf3
.data:00002cf2 78                               ld a,b
.data:00002cf3 4f                               ld c,a
.data:00002cf4 32 10 2c                         ld (0x2c10),a
.data:00002cf7 cd 64 2e                         call 0x2e64
.data:00002cfa 20 08                            jr nz,0x2d04
.data:00002cfc 78                               ld a,b
.data:00002cfd 4f                               ld c,a
.data:00002cfe 32 10 2c                         ld (0x2c10),a
.data:00002d01 cd 64 2e                         call 0x2e64
.data:00002d04 87                               add a,a
.data:00002d05 e5                               push hl
.data:00002d06 6f                               ld l,a
.data:00002d07 3a 0f 2c                         ld a,(0x2c0f)
.data:00002d0a a7                               and a
.data:00002d0b 28 02                            jr z,0x2d0f
.data:00002d0d 2e 00                            ld l,0x00
.data:00002d0f 7d                               ld a,l
.data:00002d10 21 3c 2e                         ld hl,0x2e3c
.data:00002d13 85                               add a,l
.data:00002d14 6f                               ld l,a
.data:00002d15 7c                               ld a,h
.data:00002d16 ce 00                            adc a,0x00
.data:00002d18 67                               ld h,a
.data:00002d19 5e                               ld e,(hl)
.data:00002d1a 23                               inc hl
.data:00002d1b 56                               ld d,(hl)
.data:00002d1c d5                               push de
.data:00002d1d dd e1                            pop ix
.data:00002d1f 79                               ld a,c
.data:00002d20 e6 0f                            and 0x0f
.data:00002d22 41                               ld b,c
.data:00002d23 21 38 2c                         ld hl,0x2c38
.data:00002d26 85                               add a,l
.data:00002d27 6f                               ld l,a
.data:00002d28 4e                               ld c,(hl)
.data:00002d29 e1                               pop hl
.data:00002d2a d1                               pop de
.data:00002d2b 3a 0f 2c                         ld a,(0x2c0f)
.data:00002d2e a7                               and a
.data:00002d2f 3a 2d 2c                         ld a,(0x2c2d)
.data:00002d32 20 03                            jr nz,0x2d37
.data:00002d34 a7                               and a
.data:00002d35 dd e9                            jp (ix)
.data:00002d37 e6 07                            and 0x07
.data:00002d39 5f                               ld e,a
.data:00002d3a fe 01                            cp 0x01
.data:00002d3c 20 23                            jr nz,0x2d61
.data:00002d3e 21 0e 2c                         ld hl,0x2c0e
.data:00002d41 35                               dec (hl)
.data:00002d42 28 13                            jr z,0x2d57
.data:00002d44 7e                               ld a,(hl)
.data:00002d45 fe 3c                            cp 0x3c
.data:00002d47 30 18                            jr nc,0x2d61
.data:00002d49 e6 01                            and 0x01
.data:00002d4b 3e 30                            ld a,0x30
.data:00002d4d 28 03                            jr z,0x2d52
.data:00002d4f 3a 18 2c                         ld a,(0x2c18)
.data:00002d52 32 24 2c                         ld (0x2c24),a
.data:00002d55 18 0a                            jr 0x2d61
.data:00002d57 cd 8b cf                         call 0xcf8b
.data:00002d5a af                               xor a
.data:00002d5b 32 0d 2c                         ld (0x2c0d),a
.data:00002d5e 32 2d 2c                         ld (0x2c2d),a
.data:00002d61 fe 02                            cp 0x02
.data:00002d63 20 29                            jr nz,0x2d8e
.data:00002d65 21 0e 2c                         ld hl,0x2c0e
.data:00002d68 35                               dec (hl)
.data:00002d69 28 16                            jr z,0x2d81
.data:00002d6b 7e                               ld a,(hl)
.data:00002d6c fe 3c                            cp 0x3c
.data:00002d6e 30 1e                            jr nc,0x2d8e
.data:00002d70 e6 01                            and 0x01
.data:00002d72 3a 47 91                         ld a,(0x9147)
.data:00002d75 20 02                            jr nz,0x2d79
.data:00002d77 ee 40                            xor 0x40
.data:00002d79 32 04 2c                         ld (0x2c04),a
.data:00002d7c 32 24 2c                         ld (0x2c24),a
.data:00002d7f 18 0d                            jr 0x2d8e
.data:00002d81 3a 18 2c                         ld a,(0x2c18)
.data:00002d84 32 24 2c                         ld (0x2c24),a
.data:00002d87 af                               xor a
.data:00002d88 32 0d 2c                         ld (0x2c0d),a
.data:00002d8b 32 2d 2c                         ld (0x2c2d),a
.data:00002d8e 7b                               ld a,e
.data:00002d8f 87                               add a,a
.data:00002d90 21 48 2c                         ld hl,0x2c48
.data:00002d93 85                               add a,l
.data:00002d94 6f                               ld l,a
.data:00002d95 7c                               ld a,h
.data:00002d96 ce 00                            adc a,0x00
.data:00002d98 67                               ld h,a
.data:00002d99 5e                               ld e,(hl)
.data:00002d9a 23                               inc hl
.data:00002d9b 56                               ld d,(hl)
.data:00002d9c 21 14 2c                         ld hl,0x2c14
.data:00002d9f 7e                               ld a,(hl)
.data:00002da0 3c                               inc a
.data:00002da1 e6 03                            and 0x03
.data:00002da3 77                               ld (hl),a
.data:00002da4 6f                               ld l,a
.data:00002da5 79                               ld a,c
.data:00002da6 87                               add a,a
.data:00002da7 87                               add a,a
.data:00002da8 85                               add a,l
.data:00002da9 6f                               ld l,a
.data:00002daa 26 00                            ld h,0x00
.data:00002dac 19                               add hl,de
.data:00002dad 7e                               ld a,(hl)
.data:00002dae fe ff                            cp 0xff
.data:00002db0 28 ea                            jr z,0x2d9c
.data:00002db2 fe fe                            cp 0xfe
.data:00002db4 20 03                            jr nz,0x2db9
.data:00002db6 3a 11 2c                         ld a,(0x2c11)
.data:00002db9 32 11 2c                         ld (0x2c11),a
.data:00002dbc 57                               ld d,a
.data:00002dbd e6 7f                            and 0x7f
.data:00002dbf 60                               ld h,b
.data:00002dc0 47                               ld b,a
.data:00002dc1 7a                               ld a,d
.data:00002dc2 e6 80                            and 0x80
.data:00002dc4 16 38                            ld d,0x38
.data:00002dc6 1e 40                            ld e,0x40
.data:00002dc8 6f                               ld l,a
.data:00002dc9 3a 0f 2c                         ld a,(0x2c0f)
.data:00002dcc a7                               and a
.data:00002dcd 28 02                            jr z,0x2dd1
.data:00002dcf 26 00                            ld h,0x00
.data:00002dd1 7d                               ld a,l
.data:00002dd2 f5                               push af
.data:00002dd3 e5                               push hl
.data:00002dd4 d5                               push de
.data:00002dd5 c5                               push bc
.data:00002dd6 7c                               ld a,h
.data:00002dd7 cd ad 89                         call 0x89ad
.data:00002dda 3a c6 8e                         ld a,(0x8ec6)
.data:00002ddd a7                               and a
.data:00002dde f5                               push af
.data:00002ddf cc fe 51                         call z,0x51fe
.data:00002de2 f1                               pop af
.data:00002de3 f5                               push af
.data:00002de4 cc a9 54                         call z,0x54a9
.data:00002de7 f1                               pop af
.data:00002de8 cc c0 55                         call z,0x55c0
.data:00002deb cd 82 57                         call 0x5782
.data:00002dee c1                               pop bc
.data:00002def d1                               pop de
.data:00002df0 e1                               pop hl
.data:00002df1 f1                               pop af
.data:00002df2 cc 40 84                         call z,0x8440
.data:00002df5 06 03                            ld b,0x03
.data:00002df7 21 2e 2c                         ld hl,0x2c2e
.data:00002dfa c5                               push bc
.data:00002dfb 7e                               ld a,(hl)
.data:00002dfc a7                               and a
.data:00002dfd 28 37                            jr z,0x2e36
.data:00002dff 23                               inc hl
.data:00002e00 56                               ld d,(hl)
.data:00002e01 cb 42                            bit 0,d
.data:00002e03 28 0c                            jr z,0x2e11
.data:00002e05 2b                               dec hl
.data:00002e06 d6 10                            sub 0x10
.data:00002e08 57                               ld d,a
.data:00002e09 1e 40                            ld e,0x40
.data:00002e0b 30 22                            jr nc,0x2e2f
.data:00002e0d 36 00                            ld (hl),0x00
.data:00002e0f 18 25                            jr 0x2e36
.data:00002e11 cb 7e                            bit 7,(hl)
.data:00002e13 2b                               dec hl
.data:00002e14 28 0b                            jr z,0x2e21
.data:00002e16 d6 08                            sub 0x08
.data:00002e18 5f                               ld e,a
.data:00002e19 fe 08                            cp 0x08
.data:00002e1b 30 0f                            jr nc,0x2e2c
.data:00002e1d 36 00                            ld (hl),0x00
.data:00002e1f 18 15                            jr 0x2e36
.data:00002e21 c6 08                            add a,0x08
.data:00002e23 5f                               ld e,a
.data:00002e24 fe 70                            cp 0x70
.data:00002e26 38 04                            jr c,0x2e2c
.data:00002e28 36 00                            ld (hl),0x00
.data:00002e2a 18 0a                            jr 0x2e36
.data:00002e2c 5f                               ld e,a
.data:00002e2d 16 38                            ld d,0x38
.data:00002e2f 77                               ld (hl),a
.data:00002e30 06 1a                            ld b,0x1a
.data:00002e32 af                               xor a
.data:00002e33 cd 40 84                         call 0x8440
.data:00002e36 23                               inc hl
.data:00002e37 23                               inc hl
.data:00002e38 c1                               pop bc
.data:00002e39 10 bf                            djnz 0x2dfa
.data:00002e3b c9                               ret
.data:00002e3c b7                               or a
.data:00002e3d 2e c7                            ld l,0xc7
.data:00002e3f 2e fc                            ld l,0xfc
.data:00002e41 2e 18                            ld l,0x18
.data:00002e43 2f                               cpl
.data:00002e44 50                               ld d,b
.data:00002e45 2f                               cpl
.data:00002e46 88                               adc a,b
.data:00002e47 2f                               cpl
.data:00002e48 c0                               ret nz
.data:00002e49 2f                               cpl
.data:00002e4a f8                               ret m
.data:00002e4b 2f                               cpl
.data:00002e4c b7                               or a
.data:00002e4d 2e b7                            ld l,0xb7
.data:00002e4f 2e 67                            ld l,0x67
.data:00002e51 30 f3                            jr nc,0x2e46
.data:00002e53 30 1b                            jr nc,0x2e70
.data:00002e55 31 5d 31                         ld sp,0x315d
.data:00002e58 8e                               adc a,(hl)
.data:00002e59 31 b7 31                         ld sp,0x31b7
.data:00002e5c b7                               or a
.data:00002e5d 31 52 32                         ld sp,0x3252
.data:00002e60 99                               sbc a,c
.data:00002e61 32 e2 32                         ld (0x32e2),a
.data:00002e64 c5                               push bc
.data:00002e65 ed 4b 16 2c                      ld bc,(0x2c16)
.data:00002e69 1f                               rra
.data:00002e6a 30 06                            jr nc,0x2e72
.data:00002e6c 79                               ld a,c
.data:00002e6d c6 04                            add a,0x04
.data:00002e6f 4f                               ld c,a
.data:00002e70 18 13                            jr 0x2e85
.data:00002e72 1f                               rra
.data:00002e73 30 03                            jr nc,0x2e78
.data:00002e75 0d                               dec c
.data:00002e76 18 0d                            jr 0x2e85
.data:00002e78 1f                               rra
.data:00002e79 30 06                            jr nc,0x2e81
.data:00002e7b 78                               ld a,b
.data:00002e7c c6 04                            add a,0x04
.data:00002e7e 47                               ld b,a
.data:00002e7f 18 04                            jr 0x2e85
.data:00002e81 1f                               rra
.data:00002e82 30 01                            jr nc,0x2e85
.data:00002e84 05                               dec b
.data:00002e85 cd b6 8c                         call 0x8cb6
.data:00002e88 3a 13 2c                         ld a,(0x2c13)
.data:00002e8b bd                               cp l
.data:00002e8c 3a 12 2c                         ld a,(0x2c12)
.data:00002e8f 28 0a                            jr z,0x2e9b
.data:00002e91 7d                               ld a,l
.data:00002e92 32 13 2c                         ld (0x2c13),a
.data:00002e95 cd da 8c                         call 0x8cda
.data:00002e98 32 12 2c                         ld (0x2c12),a
.data:00002e9b e6 1f                            and 0x1f
.data:00002e9d c1                               pop bc
.data:00002e9e c9                               ret
.data:00002e9f c5                               push bc
.data:00002ea0 47                               ld b,a
.data:00002ea1 70                               ld (hl),b
.data:00002ea2 c5                               push bc
.data:00002ea3 79                               ld a,c
.data:00002ea4 01 06 04                         ld bc,0x0406
.data:00002ea7 fe 04                            cp 0x04
.data:00002ea9 20 01                            jr nz,0x2eac
.data:00002eab 05                               dec b
.data:00002eac fe 02                            cp 0x02
.data:00002eae 20 01                            jr nz,0x2eb1
.data:00002eb0 0d                               dec c
.data:00002eb1 f1                               pop af
.data:00002eb2 cd 1b 8d                         call 0x8d1b
.data:00002eb5 c1                               pop bc
.data:00002eb6 c9                               ret
.data:00002eb7 fe 02                            cp 0x02
.data:00002eb9 20 02                            jr nz,0x2ebd
.data:00002ebb 0e 00                            ld c,0x00
.data:00002ebd 06 00                            ld b,0x00
.data:00002ebf fe 09                            cp 0x09
.data:00002ec1 ca d5 30                         jp z,0x30d5
.data:00002ec4 c3 37 2d                         jp 0x2d37
.data:00002ec7 c5                               push bc
.data:00002ec8 f5                               push af
.data:00002ec9 fe 02                            cp 0x02
.data:00002ecb 30 2a                            jr nc,0x2ef7
.data:00002ecd 7a                               ld a,d
.data:00002ece b3                               or e
.data:00002ecf e6 03                            and 0x03
.data:00002ed1 fe 02                            cp 0x02
.data:00002ed3 20 22                            jr nz,0x2ef7
.data:00002ed5 3e 0f                            ld a,0x0f
.data:00002ed7 32 12 2c                         ld (0x2c12),a
.data:00002eda 00                               nop
.data:00002edb af                               xor a
.data:00002edc 32 28 61                         ld (0x6128),a
.data:00002edf 7e                               ld a,(hl)
.data:00002ee0 3a ff 2b                         ld a,(0x2bff)
.data:00002ee3 f6 80                            or 0x80
.data:00002ee5 cd 9f 2e                         call 0x2e9f
.data:00002ee8 e5                               push hl
.data:00002ee9 21 01 00                         ld hl,0x0001
.data:00002eec cd 70 8d                         call 0x8d70
.data:00002eef 2a 08 2c                         ld hl,(0x2c08)
.data:00002ef2 23                               inc hl
.data:00002ef3 22 08 2c                         ld (0x2c08),hl
.data:00002ef6 e1                               pop hl
.data:00002ef7 f1                               pop af
.data:00002ef8 c1                               pop bc
.data:00002ef9 c3 37 2d                         jp 0x2d37
.data:00002efc fe 03                            cp 0x03
.data:00002efe f5                               push af
.data:00002eff 20 13                            jr nz,0x2f14
.data:00002f01 7a                               ld a,d
.data:00002f02 b3                               or e
.data:00002f03 e6 03                            and 0x03
.data:00002f05 fe 02                            cp 0x02
.data:00002f07 20 0b                            jr nz,0x2f14
.data:00002f09 3e 01                            ld a,0x01
.data:00002f0b 32 28 61                         ld (0x6128),a
.data:00002f0e 7e                               ld a,(hl)
.data:00002f0f d6 03                            sub 0x03
.data:00002f11 cd 9f 2e                         call 0x2e9f
.data:00002f14 f1                               pop af
.data:00002f15 c3 37 2d                         jp 0x2d37
.data:00002f18 f5                               push af
.data:00002f19 fe 02                            cp 0x02
.data:00002f1b 30 2f                            jr nc,0x2f4c
.data:00002f1d 7a                               ld a,d
.data:00002f1e b3                               or e
.data:00002f1f e6 03                            and 0x03
.data:00002f21 fe 02                            cp 0x02
.data:00002f23 20 27                            jr nz,0x2f4c
.data:00002f25 cb 50                            bit 2,b
.data:00002f27 78                               ld a,b
.data:00002f28 06 00                            ld b,0x00
.data:00002f2a 20 20                            jr nz,0x2f4c
.data:00002f2c 47                               ld b,a
.data:00002f2d 3e 02                            ld a,0x02
.data:00002f2f 32 28 61                         ld (0x6128),a
.data:00002f32 3a ff 2b                         ld a,(0x2bff)
.data:00002f35 cd 9f 2e                         call 0x2e9f
.data:00002f38 3e 08                            ld a,0x08
.data:00002f3a 32 1a 2c                         ld (0x2c1a),a
.data:00002f3d e5                               push hl
.data:00002f3e 21 02 00                         ld hl,0x0002
.data:00002f41 cd 70 8d                         call 0x8d70
.data:00002f44 2a 08 2c                         ld hl,(0x2c08)
.data:00002f47 23                               inc hl
.data:00002f48 22 08 2c                         ld (0x2c08),hl
.data:00002f4b e1                               pop hl
.data:00002f4c f1                               pop af
.data:00002f4d c3 37 2d                         jp 0x2d37
.data:00002f50 f5                               push af
.data:00002f51 fe 02                            cp 0x02
.data:00002f53 30 2f                            jr nc,0x2f84
.data:00002f55 7a                               ld a,d
.data:00002f56 b3                               or e
.data:00002f57 e6 03                            and 0x03
.data:00002f59 fe 02                            cp 0x02
.data:00002f5b 20 27                            jr nz,0x2f84
.data:00002f5d cb 58                            bit 3,b
.data:00002f5f 78                               ld a,b
.data:00002f60 06 00                            ld b,0x00
.data:00002f62 20 20                            jr nz,0x2f84
.data:00002f64 47                               ld b,a
.data:00002f65 3e 02                            ld a,0x02
.data:00002f67 32 28 61                         ld (0x6128),a
.data:00002f6a 3a ff 2b                         ld a,(0x2bff)
.data:00002f6d cd 9f 2e                         call 0x2e9f
.data:00002f70 3e 04                            ld a,0x04
.data:00002f72 32 1a 2c                         ld (0x2c1a),a
.data:00002f75 e5                               push hl
.data:00002f76 21 02 00                         ld hl,0x0002
.data:00002f79 cd 70 8d                         call 0x8d70
.data:00002f7c 2a 08 2c                         ld hl,(0x2c08)
.data:00002f7f 23                               inc hl
.data:00002f80 22 08 2c                         ld (0x2c08),hl
.data:00002f83 e1                               pop hl
.data:00002f84 f1                               pop af
.data:00002f85 c3 37 2d                         jp 0x2d37
.data:00002f88 f5                               push af
.data:00002f89 fe 02                            cp 0x02
.data:00002f8b 30 2f                            jr nc,0x2fbc
.data:00002f8d 7a                               ld a,d
.data:00002f8e b3                               or e
.data:00002f8f e6 03                            and 0x03
.data:00002f91 fe 02                            cp 0x02
.data:00002f93 20 27                            jr nz,0x2fbc
.data:00002f95 78                               ld a,b
.data:00002f96 cb 40                            bit 0,b
.data:00002f98 06 00                            ld b,0x00
.data:00002f9a 20 20                            jr nz,0x2fbc
.data:00002f9c 47                               ld b,a
.data:00002f9d 3e 02                            ld a,0x02
.data:00002f9f 32 28 61                         ld (0x6128),a
.data:00002fa2 3a ff 2b                         ld a,(0x2bff)
.data:00002fa5 cd 9f 2e                         call 0x2e9f
.data:00002fa8 3e 02                            ld a,0x02
.data:00002faa 32 1a 2c                         ld (0x2c1a),a
.data:00002fad e5                               push hl
.data:00002fae 21 02 00                         ld hl,0x0002
.data:00002fb1 cd 70 8d                         call 0x8d70
.data:00002fb4 2a 08 2c                         ld hl,(0x2c08)
.data:00002fb7 23                               inc hl
.data:00002fb8 22 08 2c                         ld (0x2c08),hl
.data:00002fbb e1                               pop hl
.data:00002fbc f1                               pop af
.data:00002fbd c3 37 2d                         jp 0x2d37
.data:00002fc0 f5                               push af
.data:00002fc1 fe 02                            cp 0x02
.data:00002fc3 30 2f                            jr nc,0x2ff4
.data:00002fc5 7a                               ld a,d
.data:00002fc6 b3                               or e
.data:00002fc7 e6 03                            and 0x03
.data:00002fc9 fe 02                            cp 0x02
.data:00002fcb 20 27                            jr nz,0x2ff4
.data:00002fcd 78                               ld a,b
.data:00002fce cb 48                            bit 1,b
.data:00002fd0 06 00                            ld b,0x00
.data:00002fd2 20 20                            jr nz,0x2ff4
.data:00002fd4 47                               ld b,a
.data:00002fd5 3e 02                            ld a,0x02
.data:00002fd7 32 28 61                         ld (0x6128),a
.data:00002fda 3a ff 2b                         ld a,(0x2bff)
.data:00002fdd cd 9f 2e                         call 0x2e9f
.data:00002fe0 3e 01                            ld a,0x01
.data:00002fe2 32 1a 2c                         ld (0x2c1a),a
.data:00002fe5 e5                               push hl
.data:00002fe6 21 02 00                         ld hl,0x0002
.data:00002fe9 cd 70 8d                         call 0x8d70
.data:00002fec 2a 08 2c                         ld hl,(0x2c08)
.data:00002fef 23                               inc hl
.data:00002ff0 22 08 2c                         ld (0x2c08),hl
.data:00002ff3 e1                               pop hl
.data:00002ff4 f1                               pop af
.data:00002ff5 c3 37 2d                         jp 0x2d37
.data:00002ff8 f5                               push af
.data:00002ff9 20 0a                            jr nz,0x3005
.data:00002ffb cb 58                            bit 3,b
.data:00002ffd 28 0e                            jr z,0x300d
.data:00002fff cb 98                            res 3,b
.data:00003001 f1                               pop af
.data:00003002 c3 37 2d                         jp 0x2d37
.data:00003005 fe 08                            cp 0x08
.data:00003007 28 22                            jr z,0x302b
.data:00003009 f1                               pop af
.data:0000300a c3 37 2d                         jp 0x2d37
.data:0000300d 3e 03                            ld a,0x03
.data:0000300f 32 28 61                         ld (0x6128),a
.data:00003012 3a 24 2c                         ld a,(0x2c24)
.data:00003015 32 18 2c                         ld (0x2c18),a
.data:00003018 32 48 91                         ld (0x9148),a
.data:0000301b 3a 04 2c                         ld a,(0x2c04)
.data:0000301e 32 24 2c                         ld (0x2c24),a
.data:00003021 3e 01                            ld a,0x01
.data:00003023 32 0d 2c                         ld (0x2c0d),a
.data:00003026 3e 08                            ld a,0x08
.data:00003028 32 2d 2c                         ld (0x2c2d),a
.data:0000302b f1                               pop af
.data:0000302c 3a 15 2c                         ld a,(0x2c15)
.data:0000302f e6 02                            and 0x02
.data:00003031 0f                               rrca
.data:00003032 0f                               rrca
.data:00003033 57                               ld d,a
.data:00003034 3a 1d 2c                         ld a,(0x2c1d)
.data:00003037 a7                               and a
.data:00003038 c4 43 30                         call nz,0x3043
.data:0000303b 06 04                            ld b,0x04
.data:0000303d 7a                               ld a,d
.data:0000303e f6 17                            or 0x17
.data:00003040 c3 bc 2d                         jp 0x2dbc
.data:00003043 06 03                            ld b,0x03
.data:00003045 21 2e 2c                         ld hl,0x2c2e
.data:00003048 7e                               ld a,(hl)
.data:00003049 a7                               and a
.data:0000304a 28 05                            jr z,0x3051
.data:0000304c 23                               inc hl
.data:0000304d 23                               inc hl
.data:0000304e 10 f8                            djnz 0x3048
.data:00003050 c9                               ret
.data:00003051 cb 42                            bit 0,d
.data:00003053 36 68                            ld (hl),0x68
.data:00003055 20 08                            jr nz,0x305f
.data:00003057 cb 7a                            bit 7,d
.data:00003059 36 40                            ld (hl),0x40
.data:0000305b 20 02                            jr nz,0x305f
.data:0000305d 36 40                            ld (hl),0x40
.data:0000305f 23                               inc hl
.data:00003060 72                               ld (hl),d
.data:00003061 3e 04                            ld a,0x04
.data:00003063 32 28 61                         ld (0x6128),a
.data:00003066 c9                               ret
.data:00003067 28 07                            jr z,0x3070
.data:00003069 fe 09                            cp 0x09
.data:0000306b 28 68                            jr z,0x30d5
.data:0000306d c3 37 2d                         jp 0x2d37
.data:00003070 7b                               ld a,e
.data:00003071 e6 03                            and 0x03
.data:00003073 3e 00                            ld a,0x00
.data:00003075 c2 37 2d                         jp nz,0x2d37
.data:00003078 3e 09                            ld a,0x09
.data:0000307a 32 2d 2c                         ld (0x2c2d),a
.data:0000307d 3e 01                            ld a,0x01
.data:0000307f 32 0d 2c                         ld (0x2c0d),a
.data:00003082 3a 24 2c                         ld a,(0x2c24)
.data:00003085 32 18 2c                         ld (0x2c18),a
.data:00003088 3a 04 2c                         ld a,(0x2c04)
.data:0000308b 32 24 2c                         ld (0x2c24),a
.data:0000308e 01 18 1c                         ld bc,0x1c18
.data:00003091 ed 43 16 2c                      ld (0x2c16),bc
.data:00003095 06 0c                            ld b,0x0c
.data:00003097 16 38                            ld d,0x38
.data:00003099 1e 40                            ld e,0x40
.data:0000309b c5                               push bc
.data:0000309c d5                               push de
.data:0000309d 26 08                            ld h,0x08
.data:0000309f d1                               pop de
.data:000030a0 7a                               ld a,d
.data:000030a1 c6 04                            add a,0x04
.data:000030a3 57                               ld d,a
.data:000030a4 06 05                            ld b,0x05
.data:000030a6 af                               xor a
.data:000030a7 f5                               push af
.data:000030a8 e5                               push hl
.data:000030a9 d5                               push de
.data:000030aa c5                               push bc
.data:000030ab 7c                               ld a,h
.data:000030ac cd ad 89                         call 0x89ad
.data:000030af 3a c6 8e                         ld a,(0x8ec6)
.data:000030b2 a7                               and a
.data:000030b3 f5                               push af
.data:000030b4 cc fe 51                         call z,0x51fe
.data:000030b7 f1                               pop af
.data:000030b8 f5                               push af
.data:000030b9 cc a9 54                         call z,0x54a9
.data:000030bc f1                               pop af
.data:000030bd cc c0 55                         call z,0x55c0
.data:000030c0 cd 82 57                         call 0x5782
.data:000030c3 c1                               pop bc
.data:000030c4 d1                               pop de
.data:000030c5 e1                               pop hl
.data:000030c6 f1                               pop af
.data:000030c7 cc 40 84                         call z,0x8440
.data:000030ca cd a0 89                         call 0x89a0
.data:000030cd c1                               pop bc
.data:000030ce 10 cb                            djnz 0x309b
.data:000030d0 3e 03                            ld a,0x03
.data:000030d2 32 28 61                         ld (0x6128),a
.data:000030d5 78                               ld a,b
.data:000030d6 e6 02                            and 0x02
.data:000030d8 0f                               rrca
.data:000030d9 0f                               rrca
.data:000030da 57                               ld d,a
.data:000030db 3a 1d 2c                         ld a,(0x2c1d)
.data:000030de a7                               and a
.data:000030df 60                               ld h,b
.data:000030e0 28 09                            jr z,0x30eb
.data:000030e2 cb c2                            set 0,d
.data:000030e4 e5                               push hl
.data:000030e5 cd 43 30                         call 0x3043
.data:000030e8 e1                               pop hl
.data:000030e9 cb 82                            res 0,d
.data:000030eb 7a                               ld a,d
.data:000030ec 06 0c                            ld b,0x0c
.data:000030ee 16 68                            ld d,0x68
.data:000030f0 c3 c6 2d                         jp 0x2dc6
.data:000030f3 f5                               push af
.data:000030f4 28 21                            jr z,0x3117
.data:000030f6 7a                               ld a,d
.data:000030f7 b3                               or e
.data:000030f8 e6 03                            and 0x03
.data:000030fa fe 02                            cp 0x02
.data:000030fc 20 19                            jr nz,0x3117
.data:000030fe 3e 03                            ld a,0x03
.data:00003100 32 28 61                         ld (0x6128),a
.data:00003103 3a 18 2c                         ld a,(0x2c18)
.data:00003106 32 24 2c                         ld (0x2c24),a
.data:00003109 af                               xor a
.data:0000310a 32 0d 2c                         ld (0x2c0d),a
.data:0000310d 32 2d 2c                         ld (0x2c2d),a
.data:00003110 f1                               pop af
.data:00003111 f5                               push af
.data:00003112 c6 3b                            add a,0x3b
.data:00003114 cd 9f 2e                         call 0x2e9f
.data:00003117 f1                               pop af
.data:00003118 c3 37 2d                         jp 0x2d37
.data:0000311b f5                               push af
.data:0000311c 20 3b                            jr nz,0x3159
.data:0000311e 7a                               ld a,d
.data:0000311f b3                               or e
.data:00003120 e6 03                            and 0x03
.data:00003122 fe 02                            cp 0x02
.data:00003124 20 33                            jr nz,0x3159
.data:00003126 3e 03                            ld a,0x03
.data:00003128 32 28 61                         ld (0x6128),a
.data:0000312b 3e 01                            ld a,0x01
.data:0000312d 32 0d 2c                         ld (0x2c0d),a
.data:00003130 3a fe 2b                         ld a,(0x2bfe)
.data:00003133 32 0e 2c                         ld (0x2c0e),a
.data:00003136 3a 24 2c                         ld a,(0x2c24)
.data:00003139 32 18 2c                         ld (0x2c18),a
.data:0000313c 3e 30                            ld a,0x30
.data:0000313e 32 24 2c                         ld (0x2c24),a
.data:00003141 3e 01                            ld a,0x01
.data:00003143 32 2d 2c                         ld (0x2c2d),a
.data:00003146 3a ff 2b                         ld a,(0x2bff)
.data:00003149 cd 9f 2e                         call 0x2e9f
.data:0000314c e5                               push hl
.data:0000314d 21 02 00                         ld hl,0x0002
.data:00003150 cd 70 8d                         call 0x8d70
.data:00003153 3e 0b                            ld a,0x0b
.data:00003155 32 28 61                         ld (0x6128),a
.data:00003158 e1                               pop hl
.data:00003159 f1                               pop af
.data:0000315a c3 37 2d                         jp 0x2d37
.data:0000315d f5                               push af
.data:0000315e 20 2a                            jr nz,0x318a
.data:00003160 7a                               ld a,d
.data:00003161 b3                               or e
.data:00003162 e6 03                            and 0x03
.data:00003164 fe 02                            cp 0x02
.data:00003166 20 22                            jr nz,0x318a
.data:00003168 3e 03                            ld a,0x03
.data:0000316a 32 28 61                         ld (0x6128),a
.data:0000316d 3a fe 2b                         ld a,(0x2bfe)
.data:00003170 32 0e 2c                         ld (0x2c0e),a
.data:00003173 3a 24 2c                         ld a,(0x2c24)
.data:00003176 32 18 2c                         ld (0x2c18),a
.data:00003179 3a 04 2c                         ld a,(0x2c04)
.data:0000317c 32 24 2c                         ld (0x2c24),a
.data:0000317f 3e 02                            ld a,0x02
.data:00003181 32 2d 2c                         ld (0x2c2d),a
.data:00003184 3a ff 2b                         ld a,(0x2bff)
.data:00003187 cd 9f 2e                         call 0x2e9f
.data:0000318a f1                               pop af
.data:0000318b c3 37 2d                         jp 0x2d37
.data:0000318e f5                               push af
.data:0000318f 20 22                            jr nz,0x31b3
.data:00003191 7a                               ld a,d
.data:00003192 b3                               or e
.data:00003193 e6 03                            and 0x03
.data:00003195 fe 02                            cp 0x02
.data:00003197 20 1a                            jr nz,0x31b3
.data:00003199 3e 03                            ld a,0x03
.data:0000319b 32 28 61                         ld (0x6128),a
.data:0000319e 3a 24 2c                         ld a,(0x2c24)
.data:000031a1 32 18 2c                         ld (0x2c18),a
.data:000031a4 3e 68                            ld a,0x68
.data:000031a6 32 24 2c                         ld (0x2c24),a
.data:000031a9 3e 03                            ld a,0x03
.data:000031ab 32 2d 2c                         ld (0x2c2d),a
.data:000031ae 3e 3b                            ld a,0x3b
.data:000031b0 cd 9f 2e                         call 0x2e9f
.data:000031b3 f1                               pop af
.data:000031b4 c3 37 2d                         jp 0x2d37
.data:000031b7 c5                               push bc
.data:000031b8 f5                               push af
.data:000031b9 ca 3a 32                         jp z,0x323a
.data:000031bc fe 08                            cp 0x08
.data:000031be 20 17                            jr nz,0x31d7
.data:000031c0 3e 03                            ld a,0x03
.data:000031c2 32 28 61                         ld (0x6128),a
.data:000031c5 3a 18 2c                         ld a,(0x2c18)
.data:000031c8 32 24 2c                         ld (0x2c24),a
.data:000031cb af                               xor a
.data:000031cc 32 2d 2c                         ld (0x2c2d),a
.data:000031cf 32 0d 2c                         ld (0x2c0d),a
.data:000031d2 cd f8 58                         call 0x58f8
.data:000031d5 18 63                            jr 0x323a
.data:000031d7 fe 09                            cp 0x09
.data:000031d9 20 5f                            jr nz,0x323a
.data:000031db 7b                               ld a,e
.data:000031dc e6 03                            and 0x03
.data:000031de 20 5a                            jr nz,0x323a
.data:000031e0 af                               xor a
.data:000031e1 32 0d 2c                         ld (0x2c0d),a
.data:000031e4 06 0c                            ld b,0x0c
.data:000031e6 16 68                            ld d,0x68
.data:000031e8 1e 40                            ld e,0x40
.data:000031ea c5                               push bc
.data:000031eb d5                               push de
.data:000031ec 26 04                            ld h,0x04
.data:000031ee d1                               pop de
.data:000031ef 7a                               ld a,d
.data:000031f0 c6 fc                            add a,0xfc
.data:000031f2 57                               ld d,a
.data:000031f3 06 06                            ld b,0x06
.data:000031f5 af                               xor a
.data:000031f6 f5                               push af
.data:000031f7 e5                               push hl
.data:000031f8 d5                               push de
.data:000031f9 c5                               push bc
.data:000031fa 7c                               ld a,h
.data:000031fb cd ad 89                         call 0x89ad
.data:000031fe 3a c6 8e                         ld a,(0x8ec6)
.data:00003201 a7                               and a
.data:00003202 f5                               push af
.data:00003203 cc fe 51                         call z,0x51fe
.data:00003206 f1                               pop af
.data:00003207 f5                               push af
.data:00003208 cc a9 54                         call z,0x54a9
.data:0000320b f1                               pop af
.data:0000320c cc c0 55                         call z,0x55c0
.data:0000320f cd 82 57                         call 0x5782
.data:00003212 c1                               pop bc
.data:00003213 d1                               pop de
.data:00003214 e1                               pop hl
.data:00003215 f1                               pop af
.data:00003216 cc 40 84                         call z,0x8440
.data:00003219 cd a0 89                         call 0x89a0
.data:0000321c c1                               pop bc
.data:0000321d 10 cb                            djnz 0x31ea
.data:0000321f cd f8 58                         call 0x58f8
.data:00003222 3e 03                            ld a,0x03
.data:00003224 32 28 61                         ld (0x6128),a
.data:00003227 af                               xor a
.data:00003228 32 2d 2c                         ld (0x2c2d),a
.data:0000322b 3a 18 2c                         ld a,(0x2c18)
.data:0000322e 32 24 2c                         ld (0x2c24),a
.data:00003231 01 18 10                         ld bc,0x1018
.data:00003234 ed 43 16 2c                      ld (0x2c16),bc
.data:00003238 18 00                            jr 0x323a
.data:0000323a e5                               push hl
.data:0000323b 21 1b 2c                         ld hl,0x2c1b
.data:0000323e 7e                               ld a,(hl)
.data:0000323f a7                               and a
.data:00003240 28 03                            jr z,0x3245
.data:00003242 35                               dec (hl)
.data:00003243 18 07                            jr 0x324c
.data:00003245 32 1a 2c                         ld (0x2c1a),a
.data:00003248 af                               xor a
.data:00003249 32 1e 2c                         ld (0x2c1e),a
.data:0000324c e1                               pop hl
.data:0000324d f1                               pop af
.data:0000324e c1                               pop bc
.data:0000324f c3 37 2d                         jp 0x2d37
.data:00003252 f5                               push af
.data:00003253 3e 02                            ld a,0x02
.data:00003255 32 1a 2c                         ld (0x2c1a),a
.data:00003258 32 1e 2c                         ld (0x2c1e),a
.data:0000325b 7b                               ld a,e
.data:0000325c e6 03                            and 0x03
.data:0000325e fe 02                            cp 0x02
.data:00003260 20 33                            jr nz,0x3295
.data:00003262 3e 09                            ld a,0x09
.data:00003264 32 28 61                         ld (0x6128),a
.data:00003267 e5                               push hl
.data:00003268 c5                               push bc
.data:00003269 3e 4f                            ld a,0x4f
.data:0000326b 77                               ld (hl),a
.data:0000326c 01 05 04                         ld bc,0x0405
.data:0000326f cd 1b 8d                         call 0x8d1b
.data:00003272 2b                               dec hl
.data:00003273 3e 4e                            ld a,0x4e
.data:00003275 01 04 04                         ld bc,0x0404
.data:00003278 77                               ld (hl),a
.data:00003279 cd 1b 8d                         call 0x8d1b
.data:0000327c 01 e0 ff                         ld bc,0xffe0
.data:0000327f 09                               add hl,bc
.data:00003280 3e 4c                            ld a,0x4c
.data:00003282 77                               ld (hl),a
.data:00003283 01 04 03                         ld bc,0x0304
.data:00003286 cd 1b 8d                         call 0x8d1b
.data:00003289 23                               inc hl
.data:0000328a 3e 4d                            ld a,0x4d
.data:0000328c 77                               ld (hl),a
.data:0000328d 01 05 03                         ld bc,0x0305
.data:00003290 cd 1b 8d                         call 0x8d1b
.data:00003293 c1                               pop bc
.data:00003294 e1                               pop hl
.data:00003295 f1                               pop af
.data:00003296 c3 37 2d                         jp 0x2d37
.data:00003299 f5                               push af
.data:0000329a 3a 1a 2c                         ld a,(0x2c1a)
.data:0000329d a7                               and a
.data:0000329e 3e 01                            ld a,0x01
.data:000032a0 32 1a 2c                         ld (0x2c1a),a
.data:000032a3 32 1e 2c                         ld (0x2c1e),a
.data:000032a6 7b                               ld a,e
.data:000032a7 e6 03                            and 0x03
.data:000032a9 fe 02                            cp 0x02
.data:000032ab 20 e8                            jr nz,0x3295
.data:000032ad 3e 09                            ld a,0x09
.data:000032af 32 28 61                         ld (0x6128),a
.data:000032b2 e5                               push hl
.data:000032b3 3e 4e                            ld a,0x4e
.data:000032b5 77                               ld (hl),a
.data:000032b6 01 06 04                         ld bc,0x0406
.data:000032b9 cd 1b 8d                         call 0x8d1b
.data:000032bc 23                               inc hl
.data:000032bd 3e 4f                            ld a,0x4f
.data:000032bf 01 07 04                         ld bc,0x0407
.data:000032c2 77                               ld (hl),a
.data:000032c3 cd 1b 8d                         call 0x8d1b
.data:000032c6 01 e0 ff                         ld bc,0xffe0
.data:000032c9 09                               add hl,bc
.data:000032ca 3e 4d                            ld a,0x4d
.data:000032cc 77                               ld (hl),a
.data:000032cd 01 07 03                         ld bc,0x0307
.data:000032d0 cd 1b 8d                         call 0x8d1b
.data:000032d3 2b                               dec hl
.data:000032d4 3e 4c                            ld a,0x4c
.data:000032d6 77                               ld (hl),a
.data:000032d7 01 06 03                         ld bc,0x0306
.data:000032da cd 1b 8d                         call 0x8d1b
.data:000032dd e1                               pop hl
.data:000032de 06 01                            ld b,0x01
.data:000032e0 18 b3                            jr 0x3295
.data:000032e2 f5                               push af
.data:000032e3 3a 1e 2c                         ld a,(0x2c1e)
.data:000032e6 47                               ld b,a
.data:000032e7 7b                               ld a,e
.data:000032e8 e6 03                            and 0x03
.data:000032ea fe 02                            cp 0x02
.data:000032ec 20 a7                            jr nz,0x3295
.data:000032ee 3e 03                            ld a,0x03
.data:000032f0 32 1b 2c                         ld (0x2c1b),a
.data:000032f3 78                               ld a,b
.data:000032f4 fe 02                            cp 0x02
.data:000032f6 28 32                            jr z,0x332a
.data:000032f8 e5                               push hl
.data:000032f9 3e 44                            ld a,0x44
.data:000032fb 01 06 04                         ld bc,0x0406
.data:000032fe 77                               ld (hl),a
.data:000032ff cd 1b 8d                         call 0x8d1b
.data:00003302 2b                               dec hl
.data:00003303 3e 43                            ld a,0x43
.data:00003305 01 05 04                         ld bc,0x0405
.data:00003308 77                               ld (hl),a
.data:00003309 cd 1b 8d                         call 0x8d1b
.data:0000330c 01 e0 ff                         ld bc,0xffe0
.data:0000330f 09                               add hl,bc
.data:00003310 3e 4a                            ld a,0x4a
.data:00003312 77                               ld (hl),a
.data:00003313 01 05 03                         ld bc,0x0305
.data:00003316 cd 1b 8d                         call 0x8d1b
.data:00003319 23                               inc hl
.data:0000331a 3e 4b                            ld a,0x4b
.data:0000331c 77                               ld (hl),a
.data:0000331d 01 06 03                         ld bc,0x0306
.data:00003320 cd 1b 8d                         call 0x8d1b
.data:00003323 06 01                            ld b,0x01
.data:00003325 e1                               pop hl
.data:00003326 f1                               pop af
.data:00003327 c3 37 2d                         jp 0x2d37
.data:0000332a e5                               push hl
.data:0000332b 3e 49                            ld a,0x49
.data:0000332d 01 05 04                         ld bc,0x0405
.data:00003330 77                               ld (hl),a
.data:00003331 cd 1b 8d                         call 0x8d1b
.data:00003334 23                               inc hl
.data:00003335 3e 45                            ld a,0x45
.data:00003337 01 06 04                         ld bc,0x0406
.data:0000333a 77                               ld (hl),a
.data:0000333b cd 1b 8d                         call 0x8d1b
.data:0000333e 01 e0 ff                         ld bc,0xffe0
.data:00003341 09                               add hl,bc
.data:00003342 3e 48                            ld a,0x48
.data:00003344 77                               ld (hl),a
.data:00003345 01 06 03                         ld bc,0x0306
.data:00003348 cd 1b 8d                         call 0x8d1b
.data:0000334b 2b                               dec hl
.data:0000334c 3e 47                            ld a,0x47
.data:0000334e 77                               ld (hl),a
.data:0000334f 01 05 03                         ld bc,0x0305
.data:00003352 cd 1b 8d                         call 0x8d1b
.data:00003355 e1                               pop hl
.data:00003356 06 02                            ld b,0x02
.data:00003358 f1                               pop af
.data:00003359 c3 37 2d                         jp 0x2d37
.data:0000335c 09                               add hl,bc
.data:0000335d 05                               dec b
.data:0000335e 05                               dec b
.data:0000335f 05                               dec b
.data:00003360 05                               dec b
.data:00003361 05                               dec b
.data:00003362 05                               dec b
.data:00003363 05                               dec b
.data:00003364 05                               dec b
.data:00003365 05                               dec b
.data:00003366 05                               dec b
.data:00003367 05                               dec b
.data:00003368 0b                               dec bc
.data:00003369 05                               dec b
.data:0000336a 05                               dec b
.data:0000336b 05                               dec b
.data:0000336c 05                               dec b
.data:0000336d 05                               dec b
.data:0000336e 05                               dec b
.data:0000336f 05                               dec b
.data:00003370 05                               dec b
.data:00003371 05                               dec b
.data:00003372 05                               dec b
.data:00003373 05                               dec b
.data:00003374 0a                               ld a,(bc)
.data:00003375 42                               ld b,d
.data:00003376 42                               ld b,d
.data:00003377 42                               ld b,d
.data:00003378 42                               ld b,d
.data:00003379 42                               ld b,d
.data:0000337a 42                               ld b,d
.data:0000337b 42                               ld b,d
.data:0000337c 02                               ld (bc),a
.data:0000337d 2d                               dec l
.data:0000337e bf                               cp a
.data:0000337f 2d                               dec l
.data:00003380 bf                               cp a
.data:00003381 2d                               dec l
.data:00003382 bf                               cp a
.data:00003383 2d                               dec l
.data:00003384 bf                               cp a
.data:00003385 2d                               dec l
.data:00003386 bf                               cp a
.data:00003387 2d                               dec l
.data:00003388 02                               ld (bc),a
.data:00003389 2d                               dec l
.data:0000338a bf                               cp a
.data:0000338b 2d                               dec l
.data:0000338c bf                               cp a
.data:0000338d 2d                               dec l
.data:0000338e bf                               cp a
.data:0000338f 2d                               dec l
.data:00003390 bf                               cp a
.data:00003391 2d                               dec l
.data:00003392 bf                               cp a
.data:00003393 2d                               dec l
.data:00003394 02                               ld (bc),a
.data:00003395 42                               ld b,d
.data:00003396 42                               ld b,d
.data:00003397 42                               ld b,d
.data:00003398 42                               ld b,d
.data:00003399 42                               ld b,d
.data:0000339a 42                               ld b,d
.data:0000339b 42                               ld b,d
.data:0000339c 02                               ld (bc),a
.data:0000339d bf                               cp a
.data:0000339e 09                               add hl,bc
.data:0000339f 05                               dec b
.data:000033a0 0a                               ld a,(bc)
.data:000033a1 bf                               cp a
.data:000033a2 09                               add hl,bc
.data:000033a3 05                               dec b
.data:000033a4 05                               dec b
.data:000033a5 05                               dec b
.data:000033a6 0a                               ld a,(bc)
.data:000033a7 bf                               cp a
.data:000033a8 02                               ld (bc),a
.data:000033a9 bf                               cp a
.data:000033aa 09                               add hl,bc
.data:000033ab 05                               dec b
.data:000033ac 05                               dec b
.data:000033ad 05                               dec b
.data:000033ae 0a                               ld a,(bc)
.data:000033af bf                               cp a
.data:000033b0 09                               add hl,bc
.data:000033b1 05                               dec b
.data:000033b2 0a                               ld a,(bc)
.data:000033b3 bf                               cp a
.data:000033b4 02                               ld (bc),a
.data:000033b5 42                               ld b,d
.data:000033b6 42                               ld b,d
.data:000033b7 42                               ld b,d
.data:000033b8 54                               ld d,h
.data:000033b9 55                               ld d,l
.data:000033ba 42                               ld b,d
.data:000033bb 42                               ld b,d
.data:000033bc 02                               ld (bc),a
.data:000033bd 3c                               inc a
.data:000033be 07                               rlca
.data:000033bf 05                               dec b
.data:000033c0 08                               ex af,af'
.data:000033c1 2d                               dec l
.data:000033c2 07                               rlca
.data:000033c3 05                               dec b
.data:000033c4 05                               dec b
.data:000033c5 05                               dec b
.data:000033c6 08                               ex af,af'
.data:000033c7 2d                               dec l
.data:000033c8 03                               inc bc
.data:000033c9 2d                               dec l
.data:000033ca 07                               rlca
.data:000033cb 05                               dec b
.data:000033cc 05                               dec b
.data:000033cd 05                               dec b
.data:000033ce 08                               ex af,af'
.data:000033cf 2d                               dec l
.data:000033d0 07                               rlca
.data:000033d1 05                               dec b
.data:000033d2 08                               ex af,af'
.data:000033d3 3c                               inc a
.data:000033d4 02                               ld (bc),a
.data:000033d5 42                               ld b,d
.data:000033d6 42                               ld b,d
.data:000033d7 42                               ld b,d
.data:000033d8 56                               ld d,(hl)
.data:000033d9 57                               ld d,a
.data:000033da 42                               ld b,d
.data:000033db 42                               ld b,d
.data:000033dc 02                               ld (bc),a
.data:000033dd bf                               cp a
.data:000033de 2d                               dec l
.data:000033df bf                               cp a
.data:000033e0 2d                               dec l
.data:000033e1 bf                               cp a
.data:000033e2 2d                               dec l
.data:000033e3 bf                               cp a
.data:000033e4 2d                               dec l
.data:000033e5 bf                               cp a
.data:000033e6 2d                               dec l
.data:000033e7 bf                               cp a
.data:000033e8 2d                               dec l
.data:000033e9 bf                               cp a
.data:000033ea 2d                               dec l
.data:000033eb bf                               cp a
.data:000033ec 2d                               dec l
.data:000033ed bf                               cp a
.data:000033ee 2d                               dec l
.data:000033ef bf                               cp a
.data:000033f0 2d                               dec l
.data:000033f1 bf                               cp a
.data:000033f2 2d                               dec l
.data:000033f3 bf                               cp a
.data:000033f4 02                               ld (bc),a
.data:000033f5 42                               ld b,d
.data:000033f6 42                               ld b,d
.data:000033f7 42                               ld b,d
.data:000033f8 42                               ld b,d
.data:000033f9 42                               ld b,d
.data:000033fa 42                               ld b,d
.data:000033fb 42                               ld b,d
.data:000033fc 02                               ld (bc),a
.data:000033fd 2d                               dec l
.data:000033fe 04                               inc b
.data:000033ff 05                               dec b
.data:00003400 06 2d                            ld b,0x2d
.data:00003402 09                               add hl,bc
.data:00003403 0a                               ld a,(bc)
.data:00003404 bf                               cp a
.data:00003405 04                               inc b
.data:00003406 05                               dec b
.data:00003407 05                               dec b
.data:00003408 0b                               dec bc
.data:00003409 05                               dec b
.data:0000340a 05                               dec b
.data:0000340b 06 bf                            ld b,0xbf
.data:0000340d 09                               add hl,bc
.data:0000340e 0a                               ld a,(bc)
.data:0000340f 2d                               dec l
.data:00003410 04                               inc b
.data:00003411 05                               dec b
.data:00003412 06 2d                            ld b,0x2d
.data:00003414 02                               ld (bc),a
.data:00003415 42                               ld b,d
.data:00003416 42                               ld b,d
.data:00003417 42                               ld b,d
.data:00003418 42                               ld b,d
.data:00003419 42                               ld b,d
.data:0000341a 42                               ld b,d
.data:0000341b 42                               ld b,d
.data:0000341c 02                               ld (bc),a
.data:0000341d bf                               cp a
.data:0000341e 2d                               dec l
.data:0000341f bf                               cp a
.data:00003420 2d                               dec l
.data:00003421 bf                               cp a
.data:00003422 02                               ld (bc),a
.data:00003423 02                               ld (bc),a
.data:00003424 2d                               dec l
.data:00003425 bf                               cp a
.data:00003426 2d                               dec l
.data:00003427 bf                               cp a
.data:00003428 02                               ld (bc),a
.data:00003429 bf                               cp a
.data:0000342a 2d                               dec l
.data:0000342b bf                               cp a
.data:0000342c 2d                               dec l
.data:0000342d 02                               ld (bc),a
.data:0000342e 02                               ld (bc),a
.data:0000342f bf                               cp a
.data:00003430 2d                               dec l
.data:00003431 bf                               cp a
.data:00003432 2d                               dec l
.data:00003433 bf                               cp a
.data:00003434 02                               ld (bc),a
.data:00003435 42                               ld b,d
.data:00003436 42                               ld b,d
.data:00003437 42                               ld b,d
.data:00003438 42                               ld b,d
.data:00003439 42                               ld b,d
.data:0000343a 42                               ld b,d
.data:0000343b 42                               ld b,d
.data:0000343c 07                               rlca
.data:0000343d 05                               dec b
.data:0000343e 05                               dec b
.data:0000343f 05                               dec b
.data:00003440 0a                               ld a,(bc)
.data:00003441 2d                               dec l
.data:00003442 02                               ld (bc),a
.data:00003443 0d                               dec c
.data:00003444 05                               dec b
.data:00003445 05                               dec b
.data:00003446 06 2d                            ld b,0x2d
.data:00003448 03                               inc bc
.data:00003449 2d                               dec l
.data:0000344a 04                               inc b
.data:0000344b 05                               dec b
.data:0000344c 05                               dec b
.data:0000344d 0e 02                            ld c,0x02
.data:0000344f 2d                               dec l
.data:00003450 09                               add hl,bc
.data:00003451 05                               dec b
.data:00003452 05                               dec b
.data:00003453 05                               dec b
.data:00003454 08                               ex af,af'
.data:00003455 42                               ld b,d
.data:00003456 09                               add hl,bc
.data:00003457 05                               dec b
.data:00003458 05                               dec b
.data:00003459 05                               dec b
.data:0000345a 0a                               ld a,(bc)
.data:0000345b 42                               ld b,d
.data:0000345c 42                               ld b,d
.data:0000345d 42                               ld b,d
.data:0000345e 42                               ld b,d
.data:0000345f 42                               ld b,d
.data:00003460 02                               ld (bc),a
.data:00003461 bf                               cp a
.data:00003462 02                               ld (bc),a
.data:00003463 02                               ld (bc),a
.data:00003464 2d                               dec l
.data:00003465 bf                               cp a
.data:00003466 2d                               dec l
.data:00003467 bf                               cp a
.data:00003468 2d                               dec l
.data:00003469 bf                               cp a
.data:0000346a 2d                               dec l
.data:0000346b bf                               cp a
.data:0000346c 2d                               dec l
.data:0000346d 02                               ld (bc),a
.data:0000346e 02                               ld (bc),a
.data:0000346f bf                               cp a
.data:00003470 02                               ld (bc),a
.data:00003471 42                               ld b,d
.data:00003472 42                               ld b,d
.data:00003473 42                               ld b,d
.data:00003474 42                               ld b,d
.data:00003475 42                               ld b,d
.data:00003476 02                               ld (bc),a
.data:00003477 bf                               cp a
.data:00003478 bf                               cp a
.data:00003479 bf                               cp a
.data:0000347a 02                               ld (bc),a
.data:0000347b 42                               ld b,d
.data:0000347c 05                               dec b
.data:0000347d 05                               dec b
.data:0000347e 05                               dec b
.data:0000347f 05                               dec b
.data:00003480 08                               ex af,af'
.data:00003481 2d                               dec l
.data:00003482 07                               rlca
.data:00003483 08                               ex af,af'
.data:00003484 bf                               cp a
.data:00003485 09                               add hl,bc
.data:00003486 05                               dec b
.data:00003487 50                               ld d,b
.data:00003488 38 51                            jr c,0x34db
.data:0000348a 05                               dec b
.data:0000348b 0a                               ld a,(bc)
.data:0000348c bf                               cp a
.data:0000348d 07                               rlca
.data:0000348e 08                               ex af,af'
.data:0000348f 2d                               dec l
.data:00003490 07                               rlca
.data:00003491 05                               dec b
.data:00003492 05                               dec b
.data:00003493 05                               dec b
.data:00003494 05                               dec b
.data:00003495 05                               dec b
.data:00003496 08                               ex af,af'
.data:00003497 bf                               cp a
.data:00003498 00                               nop
.data:00003499 bf                               cp a
.data:0000349a 07                               rlca
.data:0000349b 05                               dec b
.data:0000349c bf                               cp a
.data:0000349d bf                               cp a
.data:0000349e bf                               cp a
.data:0000349f bf                               cp a
.data:000034a0 bf                               cp a
.data:000034a1 bf                               cp a
.data:000034a2 2d                               dec l
.data:000034a3 bf                               cp a
.data:000034a4 2d                               dec l
.data:000034a5 02                               ld (bc),a
.data:000034a6 bf                               cp a
.data:000034a7 bf                               cp a
.data:000034a8 bf                               cp a
.data:000034a9 bf                               cp a
.data:000034aa bf                               cp a
.data:000034ab 02                               ld (bc),a
.data:000034ac 2d                               dec l
.data:000034ad bf                               cp a
.data:000034ae 2d                               dec l
.data:000034af bf                               cp a
.data:000034b0 bf                               cp a
.data:000034b1 bf                               cp a
.data:000034b2 bf                               cp a
.data:000034b3 bf                               cp a
.data:000034b4 bf                               cp a
.data:000034b5 bf                               cp a
.data:000034b6 bf                               cp a
.data:000034b7 bf                               cp a
.data:000034b8 bf                               cp a
.data:000034b9 bf                               cp a
.data:000034ba bf                               cp a
.data:000034bb bf                               cp a
.data:000034bc 05                               dec b
.data:000034bd 05                               dec b
.data:000034be 05                               dec b
.data:000034bf 05                               dec b
.data:000034c0 0a                               ld a,(bc)
.data:000034c1 2d                               dec l
.data:000034c2 09                               add hl,bc
.data:000034c3 0a                               ld a,(bc)
.data:000034c4 bf                               cp a
.data:000034c5 07                               rlca
.data:000034c6 05                               dec b
.data:000034c7 05                               dec b
.data:000034c8 05                               dec b
.data:000034c9 05                               dec b
.data:000034ca 05                               dec b
.data:000034cb 08                               ex af,af'
.data:000034cc bf                               cp a
.data:000034cd 09                               add hl,bc
.data:000034ce 0a                               ld a,(bc)
.data:000034cf 2d                               dec l
.data:000034d0 09                               add hl,bc
.data:000034d1 05                               dec b
.data:000034d2 05                               dec b
.data:000034d3 05                               dec b
.data:000034d4 05                               dec b
.data:000034d5 05                               dec b
.data:000034d6 05                               dec b
.data:000034d7 05                               dec b
.data:000034d8 05                               dec b
.data:000034d9 05                               dec b
.data:000034da 05                               dec b
.data:000034db 05                               dec b
.data:000034dc 42                               ld b,d
.data:000034dd 42                               ld b,d
.data:000034de 42                               ld b,d
.data:000034df 42                               ld b,d
.data:000034e0 02                               ld (bc),a
.data:000034e1 bf                               cp a
.data:000034e2 02                               ld (bc),a
.data:000034e3 02                               ld (bc),a
.data:000034e4 2d                               dec l
.data:000034e5 bf                               cp a
.data:000034e6 2d                               dec l
.data:000034e7 bf                               cp a
.data:000034e8 bf                               cp a
.data:000034e9 bf                               cp a
.data:000034ea 2d                               dec l
.data:000034eb bf                               cp a
.data:000034ec 2d                               dec l
.data:000034ed 02                               ld (bc),a
.data:000034ee 02                               ld (bc),a
.data:000034ef bf                               cp a
.data:000034f0 02                               ld (bc),a
.data:000034f1 42                               ld b,d
.data:000034f2 42                               ld b,d
.data:000034f3 42                               ld b,d
.data:000034f4 42                               ld b,d
.data:000034f5 42                               ld b,d
.data:000034f6 42                               ld b,d
.data:000034f7 42                               ld b,d
.data:000034f8 42                               ld b,d
.data:000034f9 42                               ld b,d
.data:000034fa 42                               ld b,d
.data:000034fb 42                               ld b,d
.data:000034fc 09                               add hl,bc
.data:000034fd 05                               dec b
.data:000034fe 05                               dec b
.data:000034ff 05                               dec b
.data:00003500 08                               ex af,af'
.data:00003501 2d                               dec l
.data:00003502 07                               rlca
.data:00003503 08                               ex af,af'
.data:00003504 bf                               cp a
.data:00003505 04                               inc b
.data:00003506 05                               dec b
.data:00003507 05                               dec b
.data:00003508 0b                               dec bc
.data:00003509 05                               dec b
.data:0000350a 05                               dec b
.data:0000350b 06 bf                            ld b,0xbf
.data:0000350d 07                               rlca
.data:0000350e 08                               ex af,af'
.data:0000350f 2d                               dec l
.data:00003510 07                               rlca
.data:00003511 05                               dec b
.data:00003512 05                               dec b
.data:00003513 05                               dec b
.data:00003514 0a                               ld a,(bc)
.data:00003515 42                               ld b,d
.data:00003516 42                               ld b,d
.data:00003517 42                               ld b,d
.data:00003518 42                               ld b,d
.data:00003519 42                               ld b,d
.data:0000351a 42                               ld b,d
.data:0000351b 42                               ld b,d
.data:0000351c 02                               ld (bc),a
.data:0000351d bf                               cp a
.data:0000351e 2d                               dec l
.data:0000351f bf                               cp a
.data:00003520 2d                               dec l
.data:00003521 bf                               cp a
.data:00003522 2d                               dec l
.data:00003523 bf                               cp a
.data:00003524 2d                               dec l
.data:00003525 bf                               cp a
.data:00003526 2d                               dec l
.data:00003527 bf                               cp a
.data:00003528 02                               ld (bc),a
.data:00003529 bf                               cp a
.data:0000352a 2d                               dec l
.data:0000352b bf                               cp a
.data:0000352c 2d                               dec l
.data:0000352d bf                               cp a
.data:0000352e 2d                               dec l
.data:0000352f bf                               cp a
.data:00003530 2d                               dec l
.data:00003531 bf                               cp a
.data:00003532 2d                               dec l
.data:00003533 bf                               cp a
.data:00003534 02                               ld (bc),a
.data:00003535 42                               ld b,d
.data:00003536 42                               ld b,d
.data:00003537 42                               ld b,d
.data:00003538 42                               ld b,d
.data:00003539 42                               ld b,d
.data:0000353a 42                               ld b,d
.data:0000353b 42                               ld b,d
.data:0000353c 02                               ld (bc),a
.data:0000353d 2d                               dec l
.data:0000353e 04                               inc b
.data:0000353f 05                               dec b
.data:00003540 0a                               ld a,(bc)
.data:00003541 2d                               dec l
.data:00003542 04                               inc b
.data:00003543 05                               dec b
.data:00003544 05                               dec b
.data:00003545 05                               dec b
.data:00003546 06 2d                            ld b,0x2d
.data:00003548 03                               inc bc
.data:00003549 2d                               dec l
.data:0000354a 04                               inc b
.data:0000354b 05                               dec b
.data:0000354c 05                               dec b
.data:0000354d 05                               dec b
.data:0000354e 06 2d                            ld b,0x2d
.data:00003550 09                               add hl,bc
.data:00003551 05                               dec b
.data:00003552 06 2d                            ld b,0x2d
.data:00003554 02                               ld (bc),a
.data:00003555 42                               ld b,d
.data:00003556 42                               ld b,d
.data:00003557 42                               ld b,d
.data:00003558 42                               ld b,d
.data:00003559 42                               ld b,d
.data:0000355a 42                               ld b,d
.data:0000355b 42                               ld b,d
.data:0000355c 02                               ld (bc),a
.data:0000355d 3c                               inc a
.data:0000355e 2d                               dec l
.data:0000355f bf                               cp a
.data:00003560 02                               ld (bc),a
.data:00003561 bf                               cp a
.data:00003562 2d                               dec l
.data:00003563 bf                               cp a
.data:00003564 2d                               dec l
.data:00003565 bf                               cp a
.data:00003566 2d                               dec l
.data:00003567 bf                               cp a
.data:00003568 2d                               dec l
.data:00003569 bf                               cp a
.data:0000356a 2d                               dec l
.data:0000356b bf                               cp a
.data:0000356c 2d                               dec l
.data:0000356d bf                               cp a
.data:0000356e 2d                               dec l
.data:0000356f bf                               cp a
.data:00003570 02                               ld (bc),a
.data:00003571 bf                               cp a
.data:00003572 2d                               dec l
.data:00003573 3c                               inc a
.data:00003574 02                               ld (bc),a
.data:00003575 42                               ld b,d
.data:00003576 42                               ld b,d
.data:00003577 42                               ld b,d
.data:00003578 42                               ld b,d
.data:00003579 42                               ld b,d
.data:0000357a 42                               ld b,d
.data:0000357b 42                               ld b,d
.data:0000357c 0d                               dec c
.data:0000357d 05                               dec b
.data:0000357e 06 2d                            ld b,0x2d
.data:00003580 03                               inc bc
.data:00003581 2d                               dec l
.data:00003582 09                               add hl,bc
.data:00003583 0a                               ld a,(bc)
.data:00003584 bf                               cp a
.data:00003585 04                               inc b
.data:00003586 05                               dec b
.data:00003587 05                               dec b
.data:00003588 0b                               dec bc
.data:00003589 05                               dec b
.data:0000358a 05                               dec b
.data:0000358b 06 bf                            ld b,0xbf
.data:0000358d 09                               add hl,bc
.data:0000358e 0a                               ld a,(bc)
.data:0000358f 2d                               dec l
.data:00003590 03                               inc bc
.data:00003591 2d                               dec l
.data:00003592 04                               inc b
.data:00003593 05                               dec b
.data:00003594 0e 42                            ld c,0x42
.data:00003596 42                               ld b,d
.data:00003597 42                               ld b,d
.data:00003598 42                               ld b,d
.data:00003599 42                               ld b,d
.data:0000359a 42                               ld b,d
.data:0000359b 42                               ld b,d
.data:0000359c 02                               ld (bc),a
.data:0000359d bf                               cp a
.data:0000359e 2d                               dec l
.data:0000359f bf                               cp a
.data:000035a0 2d                               dec l
.data:000035a1 bf                               cp a
.data:000035a2 02                               ld (bc),a
.data:000035a3 02                               ld (bc),a
.data:000035a4 2d                               dec l
.data:000035a5 bf                               cp a
.data:000035a6 2d                               dec l
.data:000035a7 bf                               cp a
.data:000035a8 02                               ld (bc),a
.data:000035a9 bf                               cp a
.data:000035aa 2d                               dec l
.data:000035ab bf                               cp a
.data:000035ac 2d                               dec l
.data:000035ad 02                               ld (bc),a
.data:000035ae 02                               ld (bc),a
.data:000035af bf                               cp a
.data:000035b0 2d                               dec l
.data:000035b1 bf                               cp a
.data:000035b2 2d                               dec l
.data:000035b3 bf                               cp a
.data:000035b4 02                               ld (bc),a
.data:000035b5 42                               ld b,d
.data:000035b6 42                               ld b,d
.data:000035b7 42                               ld b,d
.data:000035b8 54                               ld d,h
.data:000035b9 55                               ld d,l
.data:000035ba 42                               ld b,d
.data:000035bb 42                               ld b,d
.data:000035bc 02                               ld (bc),a
.data:000035bd 2d                               dec l
.data:000035be 04                               inc b
.data:000035bf 05                               dec b
.data:000035c0 05                               dec b
.data:000035c1 05                               dec b
.data:000035c2 08                               ex af,af'
.data:000035c3 07                               rlca
.data:000035c4 05                               dec b
.data:000035c5 05                               dec b
.data:000035c6 06 2d                            ld b,0x2d
.data:000035c8 03                               inc bc
.data:000035c9 2d                               dec l
.data:000035ca 04                               inc b
.data:000035cb 05                               dec b
.data:000035cc 05                               dec b
.data:000035cd 08                               ex af,af'
.data:000035ce 07                               rlca
.data:000035cf 05                               dec b
.data:000035d0 05                               dec b
.data:000035d1 05                               dec b
.data:000035d2 06 2d                            ld b,0x2d
.data:000035d4 02                               ld (bc),a
.data:000035d5 42                               ld b,d
.data:000035d6 42                               ld b,d
.data:000035d7 42                               ld b,d
.data:000035d8 56                               ld d,(hl)
.data:000035d9 57                               ld d,a
.data:000035da 42                               ld b,d
.data:000035db 42                               ld b,d
.data:000035dc 02                               ld (bc),a
.data:000035dd bf                               cp a
.data:000035de 2d                               dec l
.data:000035df bf                               cp a
.data:000035e0 2d                               dec l
.data:000035e1 bf                               cp a
.data:000035e2 2d                               dec l
.data:000035e3 bf                               cp a
.data:000035e4 2d                               dec l
.data:000035e5 bf                               cp a
.data:000035e6 2d                               dec l
.data:000035e7 bf                               cp a
.data:000035e8 2d                               dec l
.data:000035e9 bf                               cp a
.data:000035ea 2d                               dec l
.data:000035eb bf                               cp a
.data:000035ec 2d                               dec l
.data:000035ed bf                               cp a
.data:000035ee 2d                               dec l
.data:000035ef bf                               cp a
.data:000035f0 2d                               dec l
.data:000035f1 bf                               cp a
.data:000035f2 2d                               dec l
.data:000035f3 bf                               cp a
.data:000035f4 02                               ld (bc),a
.data:000035f5 42                               ld b,d
.data:000035f6 42                               ld b,d
.data:000035f7 42                               ld b,d
.data:000035f8 42                               ld b,d
.data:000035f9 42                               ld b,d
.data:000035fa 42                               ld b,d
.data:000035fb 42                               ld b,d
.data:000035fc 07                               rlca
.data:000035fd 05                               dec b
.data:000035fe 05                               dec b
.data:000035ff 05                               dec b
.data:00003600 05                               dec b
.data:00003601 05                               dec b
.data:00003602 05                               dec b
.data:00003603 05                               dec b
.data:00003604 05                               dec b
.data:00003605 05                               dec b
.data:00003606 05                               dec b
.data:00003607 05                               dec b
.data:00003608 05                               dec b
.data:00003609 05                               dec b
.data:0000360a 05                               dec b
.data:0000360b 05                               dec b
.data:0000360c 05                               dec b
.data:0000360d 05                               dec b
.data:0000360e 05                               dec b
.data:0000360f 05                               dec b
.data:00003610 05                               dec b
.data:00003611 05                               dec b
.data:00003612 05                               dec b
.data:00003613 05                               dec b
.data:00003614 08                               ex af,af'
.data:00003615 42                               ld b,d
.data:00003616 42                               ld b,d
.data:00003617 42                               ld b,d
.data:00003618 42                               ld b,d
.data:00003619 42                               ld b,d
.data:0000361a 42                               ld b,d
.data:0000361b 42                               ld b,d
.data:0000361c 2b                               dec hl
.data:0000361d 25                               dec h
.data:0000361e 25                               dec h
.data:0000361f 25                               dec h
.data:00003620 25                               dec h
.data:00003621 25                               dec h
.data:00003622 25                               dec h
.data:00003623 25                               dec h
.data:00003624 25                               dec h
.data:00003625 25                               dec h
.data:00003626 25                               dec h
.data:00003627 25                               dec h
.data:00003628 25                               dec h
.data:00003629 25                               dec h
.data:0000362a 25                               dec h
.data:0000362b 25                               dec h
.data:0000362c 25                               dec h
.data:0000362d 25                               dec h
.data:0000362e 25                               dec h
.data:0000362f 25                               dec h
.data:00003630 25                               dec h
.data:00003631 25                               dec h
.data:00003632 25                               dec h
.data:00003633 25                               dec h
.data:00003634 25                               dec h
.data:00003635 25                               dec h
.data:00003636 25                               dec h
.data:00003637 25                               dec h
.data:00003638 25                               dec h
.data:00003639 25                               dec h
.data:0000363a 25                               dec h
.data:0000363b 25                               dec h
.data:0000363c 22 34 35                         ld (0x3534),hl
.data:0000363f 35                               dec (hl)
.data:00003640 35                               dec (hl)
.data:00003641 2e 3d                            ld l,0x3d
.data:00003643 2e c0                            ld l,0xc0
.data:00003645 2e 34                            ld l,0x34
.data:00003647 35                               dec (hl)
.data:00003648 35                               dec (hl)
.data:00003649 35                               dec (hl)
.data:0000364a 2e c0                            ld l,0xc0
.data:0000364c c0                               ret nz
.data:0000364d c0                               ret nz
.data:0000364e 2e 36                            ld l,0x36
.data:00003650 36 36                            ld (hl),0x36
.data:00003652 34                               inc (hl)
.data:00003653 c0                               ret nz
.data:00003654 2e c0                            ld l,0xc0
.data:00003656 2e 3d                            ld l,0x3d
.data:00003658 34                               inc (hl)
.data:00003659 35                               dec (hl)
.data:0000365a 35                               dec (hl)
.data:0000365b 35                               dec (hl)
.data:0000365c 22 34 29                         ld (0x2934),hl
.data:0000365f 2a 33 29                         ld hl,(0x2933)
.data:00003662 2a c0 29                         ld hl,(0x29c0)
.data:00003665 2a 34 29                         ld hl,(0x2934)
.data:00003668 2a 2e 29                         ld hl,(0x292e)
.data:0000366b 2a c0 29                         ld hl,(0x29c0)
.data:0000366e 2a 2e 29                         ld hl,(0x292e)
.data:00003671 2a 34 29                         ld hl,(0x2934)
.data:00003674 2a 2e 29                         ld hl,(0x292e)
.data:00003677 2a 34 29                         ld hl,(0x2934)
.data:0000367a 2a 33 22                         ld hl,(0x2233)
.data:0000367d 34                               inc (hl)
.data:0000367e 27                               daa
.data:0000367f 28 33                            jr z,0x36b4
.data:00003681 27                               daa
.data:00003682 28 2e                            jr z,0x36b2
.data:00003684 27                               daa
.data:00003685 28 34                            jr z,0x36bb
.data:00003687 27                               daa
.data:00003688 28 c0                            jr z,0x364a
.data:0000368a 27                               daa
.data:0000368b 28 2e                            jr z,0x36bb
.data:0000368d 27                               daa
.data:0000368e 28 c0                            jr z,0x3650
.data:00003690 27                               daa
.data:00003691 28 34                            jr z,0x36c7
.data:00003693 27                               daa
.data:00003694 28 c0                            jr z,0x3656
.data:00003696 27                               daa
.data:00003697 28 34                            jr z,0x36cd
.data:00003699 27                               daa
.data:0000369a 28 33                            jr z,0x36cf
.data:0000369c 22 36 36                         ld (0x3636),hl
.data:0000369f 36 33                            ld (hl),0x33
.data:000036a1 c0                               ret nz
.data:000036a2 2e 34                            ld l,0x34
.data:000036a4 35                               dec (hl)
.data:000036a5 35                               dec (hl)
.data:000036a6 35                               dec (hl)
.data:000036a7 2e c0                            ld l,0xc0
.data:000036a9 2e c0                            ld l,0xc0
.data:000036ab 2e c0                            ld l,0xc0
.data:000036ad 2e c0                            ld l,0xc0
.data:000036af 2e c0                            ld l,0xc0
.data:000036b1 2e 36                            ld l,0x36
.data:000036b3 36 36                            ld (hl),0x36
.data:000036b5 34                               inc (hl)
.data:000036b6 c0                               ret nz
.data:000036b7 2e 36                            ld l,0x36
.data:000036b9 36 36                            ld (hl),0x36
.data:000036bb 33                               inc sp
.data:000036bc 22 2e 29                         ld (0x292e),hl
.data:000036bf 2a c0 29                         ld hl,(0x29c0)
.data:000036c2 2a 34 29                         ld hl,(0x2934)
.data:000036c5 2a 2e 29                         ld hl,(0x292e)
.data:000036c8 2a c0 29                         ld hl,(0x29c0)
.data:000036cb 2a 2e 29                         ld hl,(0x292e)
.data:000036ce 2a c0 29                         ld hl,(0x29c0)
.data:000036d1 2a 2e 29                         ld hl,(0x292e)
.data:000036d4 2a 34 29                         ld hl,(0x2934)
.data:000036d7 2a 2e 29                         ld hl,(0x292e)
.data:000036da 2a c0 22                         ld hl,(0x22c0)
.data:000036dd c0                               ret nz
.data:000036de 27                               daa
.data:000036df 28 2e                            jr z,0x370f
.data:000036e1 27                               daa
.data:000036e2 28 34                            jr z,0x3718
.data:000036e4 27                               daa
.data:000036e5 28 c0                            jr z,0x36a7
.data:000036e7 27                               daa
.data:000036e8 28 2e                            jr z,0x3718
.data:000036ea 27                               daa
.data:000036eb 28 c0                            jr z,0x36ad
.data:000036ed 27                               daa
.data:000036ee 28 2e                            jr z,0x371e
.data:000036f0 27                               daa
.data:000036f1 28 c0                            jr z,0x36b3
.data:000036f3 27                               daa
.data:000036f4 28 34                            jr z,0x372a
.data:000036f6 27                               daa
.data:000036f7 28 c0                            jr z,0x36b9
.data:000036f9 27                               daa
.data:000036fa 28 2e                            jr z,0x372a
.data:000036fc 22 2e c0                         ld (0xc02e),hl
.data:000036ff 2e 3c                            ld l,0x3c
.data:00003701 35                               dec (hl)
.data:00003702 35                               dec (hl)
.data:00003703 35                               dec (hl)
.data:00003704 2e c0                            ld l,0xc0
.data:00003706 2e c0                            ld l,0xc0
.data:00003708 2e c0                            ld l,0xc0
.data:0000370a 2e c0                            ld l,0xc0
.data:0000370c 2e c0                            ld l,0xc0
.data:0000370e 2e c0                            ld l,0xc0
.data:00003710 2e c0                            ld l,0xc0
.data:00003712 2e c0                            ld l,0xc0
.data:00003714 2e 36                            ld l,0x36
.data:00003716 36 36                            ld (hl),0x36
.data:00003718 3c                               inc a
.data:00003719 c0                               ret nz
.data:0000371a 2e c0                            ld l,0xc0
.data:0000371c 22 c0 29                         ld (0x29c0),hl
.data:0000371f 2a 2e 29                         ld hl,(0x292e)
.data:00003722 2a 2e 29                         ld hl,(0x292e)
.data:00003725 2a c0 29                         ld hl,(0x29c0)
.data:00003728 2a 2e 29                         ld hl,(0x292e)
.data:0000372b 2a c0 29                         ld hl,(0x29c0)
.data:0000372e 2a 2e 29                         ld hl,(0x292e)
.data:00003731 2a c0 29                         ld hl,(0x29c0)
.data:00003734 2a 2e 29                         ld hl,(0x292e)
.data:00003737 2a c0 29                         ld hl,(0x29c0)
.data:0000373a 2a 2e 22                         ld hl,(0x222e)
.data:0000373d 2e 27                            ld l,0x27
.data:0000373f 28 c0                            jr z,0x3701
.data:00003741 27                               daa
.data:00003742 28 c0                            jr z,0x3704
.data:00003744 27                               daa
.data:00003745 28 2e                            jr z,0x3775
.data:00003747 27                               daa
.data:00003748 28 c0                            jr z,0x370a
.data:0000374a 27                               daa
.data:0000374b 28 2e                            jr z,0x377b
.data:0000374d 27                               daa
.data:0000374e 28 c0                            jr z,0x3710
.data:00003750 27                               daa
.data:00003751 28 2e                            jr z,0x3781
.data:00003753 27                               daa
.data:00003754 28 c0                            jr z,0x3716
.data:00003756 27                               daa
.data:00003757 28 2e                            jr z,0x3787
.data:00003759 27                               daa
.data:0000375a 28 c0                            jr z,0x371c
.data:0000375c 22 36 36                         ld (0x3636),hl
.data:0000375f 36 34                            ld (hl),0x34
.data:00003761 2e c0                            ld l,0xc0
.data:00003763 2e c0                            ld l,0xc0
.data:00003765 2e c0                            ld l,0xc0
.data:00003767 2e c0                            ld l,0xc0
.data:00003769 2e c0                            ld l,0xc0
.data:0000376b 2e 3c                            ld l,0x3c
.data:0000376d 2e c0                            ld l,0xc0
.data:0000376f 2e c0                            ld l,0xc0
.data:00003771 2e c0                            ld l,0xc0
.data:00003773 2e c0                            ld l,0xc0
.data:00003775 2e c0                            ld l,0xc0
.data:00003777 2e 34                            ld l,0x34
.data:00003779 35                               dec (hl)
.data:0000377a 35                               dec (hl)
.data:0000377b 35                               dec (hl)
.data:0000377c 22 33 29                         ld (0x2933),hl
.data:0000377f 2a c0 24                         ld hl,(0x24c0)
.data:00003782 25                               dec h
.data:00003783 25                               dec h
.data:00003784 25                               dec h
.data:00003785 25                               dec h
.data:00003786 25                               dec h
.data:00003787 25                               dec h
.data:00003788 26 c0                            ld h,0xc0
.data:0000378a 29                               add hl,hl
.data:0000378b 50                               ld d,b
.data:0000378c 38 51                            jr c,0x37df
.data:0000378e 2a c0 29                         ld hl,(0x29c0)
.data:00003791 2a 2e 29                         ld hl,(0x292e)
.data:00003794 2a c0 29                         ld hl,(0x29c0)
.data:00003797 2a 34 29                         ld hl,(0x2934)
.data:0000379a 2a 33 22                         ld hl,(0x2233)
.data:0000379d 33                               inc sp
.data:0000379e 27                               daa
.data:0000379f 28 c0                            jr z,0x3761
.data:000037a1 52                               ld d,d
.data:000037a2 3a 3a 3a                         ld a,(0x3a3a)
.data:000037a5 3a 3a 3a                         ld a,(0x3a3a)
.data:000037a8 53                               ld d,e
.data:000037a9 c0                               ret nz
.data:000037aa 22 bf bf                         ld (0xbfbf),hl
.data:000037ad bf                               cp a
.data:000037ae 22 2e 27                         ld (0x272e),hl
.data:000037b1 28 c0                            jr z,0x3773
.data:000037b3 27                               daa
.data:000037b4 28 2e                            jr z,0x37e4
.data:000037b6 27                               daa
.data:000037b7 28 34                            jr z,0x37ed
.data:000037b9 27                               daa
.data:000037ba 28 33                            jr z,0x37ef
.data:000037bc 22 33 35                         ld (0x3533),hl
.data:000037bf 35                               dec (hl)
.data:000037c0 35                               dec (hl)
.data:000037c1 29                               add hl,hl
.data:000037c2 25                               dec h
.data:000037c3 25                               dec h
.data:000037c4 25                               dec h
.data:000037c5 25                               dec h
.data:000037c6 25                               dec h
.data:000037c7 25                               dec h
.data:000037c8 25                               dec h
.data:000037c9 26 22                            ld h,0x22
.data:000037cb bf                               cp a
.data:000037cc bf                               cp a
.data:000037cd bf                               cp a
.data:000037ce 22 c0 2e                         ld (0x2ec0),hl
.data:000037d1 c0                               ret nz
.data:000037d2 2e c0                            ld l,0xc0
.data:000037d4 2e c0                            ld l,0xc0
.data:000037d6 2e c0                            ld l,0xc0
.data:000037d8 36 36                            ld (hl),0x36
.data:000037da 36 33                            ld (hl),0x33
.data:000037dc 2c                               inc l
.data:000037dd 25                               dec h
.data:000037de 25                               dec h
.data:000037df 25                               dec h
.data:000037e0 25                               dec h
.data:000037e1 28 42                            jr z,0x3825
.data:000037e3 42                               ld b,d
.data:000037e4 42                               ld b,d
.data:000037e5 42                               ld b,d
.data:000037e6 42                               ld b,d
.data:000037e7 42                               ld b,d
.data:000037e8 42                               ld b,d
.data:000037e9 42                               ld b,d
.data:000037ea 27                               daa
.data:000037eb 25                               dec h
.data:000037ec 25                               dec h
.data:000037ed 25                               dec h
.data:000037ee 2c                               inc l
.data:000037ef 25                               dec h
.data:000037f0 25                               dec h
.data:000037f1 25                               dec h
.data:000037f2 25                               dec h
.data:000037f3 25                               dec h
.data:000037f4 25                               dec h
.data:000037f5 25                               dec h
.data:000037f6 25                               dec h
.data:000037f7 25                               dec h
.data:000037f8 25                               dec h
.data:000037f9 25                               dec h
.data:000037fa 25                               dec h
.data:000037fb 25                               dec h
.data:000037fc 2b                               dec hl
.data:000037fd 25                               dec h
.data:000037fe 25                               dec h
.data:000037ff 25                               dec h
.data:00003800 47                               ld b,a
.data:00003801 48                               ld c,b
.data:00003802 25                               dec h
.data:00003803 25                               dec h
.data:00003804 25                               dec h
.data:00003805 25                               dec h
.data:00003806 25                               dec h
.data:00003807 25                               dec h
.data:00003808 25                               dec h
.data:00003809 25                               dec h
.data:0000380a 25                               dec h
.data:0000380b 25                               dec h
.data:0000380c 2b                               dec hl
.data:0000380d 25                               dec h
.data:0000380e 25                               dec h
.data:0000380f 25                               dec h
.data:00003810 25                               dec h
.data:00003811 25                               dec h
.data:00003812 25                               dec h
.data:00003813 25                               dec h
.data:00003814 25                               dec h
.data:00003815 25                               dec h
.data:00003816 25                               dec h
.data:00003817 4a                               ld c,d
.data:00003818 4b                               ld c,e
.data:00003819 25                               dec h
.data:0000381a 25                               dec h
.data:0000381b 25                               dec h
.data:0000381c 22 2d bf                         ld (0xbf2d),hl
.data:0000381f bf                               cp a
.data:00003820 49                               ld c,c
.data:00003821 45                               ld b,l
.data:00003822 bf                               cp a
.data:00003823 2d                               dec l
.data:00003824 bf                               cp a
.data:00003825 2d                               dec l
.data:00003826 bf                               cp a
.data:00003827 2d                               dec l
.data:00003828 bf                               cp a
.data:00003829 2d                               dec l
.data:0000382a bf                               cp a
.data:0000382b 2d                               dec l
.data:0000382c 22 2d bf                         ld (0xbf2d),hl
.data:0000382f 2d                               dec l
.data:00003830 bf                               cp a
.data:00003831 2d                               dec l
.data:00003832 bf                               cp a
.data:00003833 2d                               dec l
.data:00003834 bf                               cp a
.data:00003835 2d                               dec l
.data:00003836 bf                               cp a
.data:00003837 43                               ld b,e
.data:00003838 44                               ld b,h
.data:00003839 bf                               cp a
.data:0000383a bf                               cp a
.data:0000383b 2d                               dec l
.data:0000383c 22 bf 29                         ld (0x29bf),hl
.data:0000383f 25                               dec h
.data:00003840 25                               dec h
.data:00003841 25                               dec h
.data:00003842 25                               dec h
.data:00003843 25                               dec h
.data:00003844 25                               dec h
.data:00003845 25                               dec h
.data:00003846 26 bf                            ld h,0xbf
.data:00003848 24                               inc h
.data:00003849 25                               dec h
.data:0000384a 26 bf                            ld h,0xbf
.data:0000384c 23                               inc hl
.data:0000384d bf                               cp a
.data:0000384e 24                               inc h
.data:0000384f 25                               dec h
.data:00003850 26 bf                            ld h,0xbf
.data:00003852 24                               inc h
.data:00003853 25                               dec h
.data:00003854 25                               dec h
.data:00003855 25                               dec h
.data:00003856 25                               dec h
.data:00003857 25                               dec h
.data:00003858 25                               dec h
.data:00003859 25                               dec h
.data:0000385a 2a bf 22                         ld hl,(0x22bf)
.data:0000385d 2d                               dec l
.data:0000385e 22 2d bf                         ld (0xbf2d),hl
.data:00003861 2d                               dec l
.data:00003862 bf                               cp a
.data:00003863 2d                               dec l
.data:00003864 bf                               cp a
.data:00003865 2d                               dec l
.data:00003866 bf                               cp a
.data:00003867 2d                               dec l
.data:00003868 bf                               cp a
.data:00003869 2d                               dec l
.data:0000386a bf                               cp a
.data:0000386b 2d                               dec l
.data:0000386c bf                               cp a
.data:0000386d 2d                               dec l
.data:0000386e bf                               cp a
.data:0000386f 2d                               dec l
.data:00003870 bf                               cp a
.data:00003871 2d                               dec l
.data:00003872 bf                               cp a
.data:00003873 2d                               dec l
.data:00003874 bf                               cp a
.data:00003875 2d                               dec l
.data:00003876 bf                               cp a
.data:00003877 2d                               dec l
.data:00003878 bf                               cp a
.data:00003879 2d                               dec l
.data:0000387a 22 2d 22                         ld (0x222d),hl
.data:0000387d bf                               cp a
.data:0000387e 22 bf 29                         ld (0x29bf),hl
.data:00003881 25                               dec h
.data:00003882 26 bf                            ld h,0xbf
.data:00003884 24                               inc h
.data:00003885 25                               dec h
.data:00003886 25                               dec h
.data:00003887 25                               dec h
.data:00003888 25                               dec h
.data:00003889 25                               dec h
.data:0000388a 25                               dec h
.data:0000388b 25                               dec h
.data:0000388c 25                               dec h
.data:0000388d 25                               dec h
.data:0000388e 25                               dec h
.data:0000388f 25                               dec h
.data:00003890 25                               dec h
.data:00003891 25                               dec h
.data:00003892 25                               dec h
.data:00003893 25                               dec h
.data:00003894 26 bf                            ld h,0xbf
.data:00003896 24                               inc h
.data:00003897 25                               dec h
.data:00003898 2a bf 22                         ld hl,(0x22bf)
.data:0000389b bf                               cp a
.data:0000389c 22 2d 22                         ld (0x222d),hl
.data:0000389f 2d                               dec l
.data:000038a0 22 2d bf                         ld (0xbf2d),hl
.data:000038a3 2d                               dec l
.data:000038a4 bf                               cp a
.data:000038a5 2d                               dec l
.data:000038a6 bf                               cp a
.data:000038a7 2d                               dec l
.data:000038a8 bf                               cp a
.data:000038a9 2d                               dec l
.data:000038aa bf                               cp a
.data:000038ab 2d                               dec l
.data:000038ac bf                               cp a
.data:000038ad 2d                               dec l
.data:000038ae bf                               cp a
.data:000038af 2d                               dec l
.data:000038b0 bf                               cp a
.data:000038b1 2d                               dec l
.data:000038b2 bf                               cp a
.data:000038b3 2d                               dec l
.data:000038b4 bf                               cp a
.data:000038b5 2d                               dec l
.data:000038b6 bf                               cp a
.data:000038b7 2d                               dec l
.data:000038b8 22 2d 22                         ld (0x222d),hl
.data:000038bb 2d                               dec l
.data:000038bc 22 bf 22                         ld (0x22bf),hl
.data:000038bf bf                               cp a
.data:000038c0 22 bf 29                         ld (0x29bf),hl
.data:000038c3 26 2d                            ld h,0x2d
.data:000038c5 24                               inc h
.data:000038c6 25                               dec h
.data:000038c7 26 bf                            ld h,0xbf
.data:000038c9 24                               inc h
.data:000038ca 2b                               dec hl
.data:000038cb 50                               ld d,b
.data:000038cc 38 51                            jr c,0x391f
.data:000038ce 2b                               dec hl
.data:000038cf 26 2d                            ld h,0x2d
.data:000038d1 24                               inc h
.data:000038d2 25                               dec h
.data:000038d3 26 2d                            ld h,0x2d
.data:000038d5 24                               inc h
.data:000038d6 2a bf 22                         ld hl,(0x22bf)
.data:000038d9 bf                               cp a
.data:000038da 22 bf 23                         ld (0x23bf),hl
.data:000038dd 2d                               dec l
.data:000038de 23                               inc hl
.data:000038df 2d                               dec l
.data:000038e0 22 2d 22                         ld (0x222d),hl
.data:000038e3 3c                               inc a
.data:000038e4 bf                               cp a
.data:000038e5 2d                               dec l
.data:000038e6 bf                               cp a
.data:000038e7 2d                               dec l
.data:000038e8 bf                               cp a
.data:000038e9 2d                               dec l
.data:000038ea 22 bf bf                         ld (0xbfbf),hl
.data:000038ed bf                               cp a
.data:000038ee 22 2d bf                         ld (0xbf2d),hl
.data:000038f1 2d                               dec l
.data:000038f2 bf                               cp a
.data:000038f3 2d                               dec l
.data:000038f4 bf                               cp a
.data:000038f5 3c                               inc a
.data:000038f6 22 2d 22                         ld (0x222d),hl
.data:000038f9 2d                               dec l
.data:000038fa 23                               inc hl
.data:000038fb 2d                               dec l
.data:000038fc 2d                               dec l
.data:000038fd bf                               cp a
.data:000038fe 2d                               dec l
.data:000038ff bf                               cp a
.data:00003900 22 bf 27                         ld (0x27bf),hl
.data:00003903 26 2d                            ld h,0x2d
.data:00003905 24                               inc h
.data:00003906 47                               ld b,a
.data:00003907 48                               ld c,b
.data:00003908 26 bf                            ld h,0xbf
.data:0000390a 27                               daa
.data:0000390b 25                               dec h
.data:0000390c 25                               dec h
.data:0000390d 25                               dec h
.data:0000390e 28 bf                            jr z,0x38cf
.data:00003910 24                               inc h
.data:00003911 4a                               ld c,d
.data:00003912 4b                               ld c,e
.data:00003913 26 2d                            ld h,0x2d
.data:00003915 24                               inc h
.data:00003916 28 bf                            jr z,0x38d7
.data:00003918 22 bf 2d                         ld (0x2dbf),hl
.data:0000391b bf                               cp a
.data:0000391c 25                               dec h
.data:0000391d 25                               dec h
.data:0000391e 26 2d                            ld h,0x2d
.data:00003920 22 2d bf                         ld (0xbf2d),hl
.data:00003923 2d                               dec l
.data:00003924 bf                               cp a
.data:00003925 bf                               cp a
.data:00003926 49                               ld c,c
.data:00003927 45                               ld b,l
.data:00003928 bf                               cp a
.data:00003929 2d                               dec l
.data:0000392a bf                               cp a
.data:0000392b 2d                               dec l
.data:0000392c bf                               cp a
.data:0000392d 2d                               dec l
.data:0000392e bf                               cp a
.data:0000392f 2d                               dec l
.data:00003930 bf                               cp a
.data:00003931 43                               ld b,e
.data:00003932 44                               ld b,h
.data:00003933 bf                               cp a
.data:00003934 bf                               cp a
.data:00003935 2d                               dec l
.data:00003936 bf                               cp a
.data:00003937 2d                               dec l
.data:00003938 22 2d 24                         ld (0x242d),hl
.data:0000393b 25                               dec h
.data:0000393c 2d                               dec l
.data:0000393d bf                               cp a
.data:0000393e 2d                               dec l
.data:0000393f bf                               cp a
.data:00003940 22 3d 24                         ld (0x243d),hl
.data:00003943 25                               dec h
.data:00003944 25                               dec h
.data:00003945 25                               dec h
.data:00003946 25                               dec h
.data:00003947 25                               dec h
.data:00003948 25                               dec h
.data:00003949 25                               dec h
.data:0000394a 25                               dec h
.data:0000394b 25                               dec h
.data:0000394c 25                               dec h
.data:0000394d 25                               dec h
.data:0000394e 25                               dec h
.data:0000394f 25                               dec h
.data:00003950 25                               dec h
.data:00003951 25                               dec h
.data:00003952 25                               dec h
.data:00003953 25                               dec h
.data:00003954 25                               dec h
.data:00003955 25                               dec h
.data:00003956 26 3d                            ld h,0x3d
.data:00003958 22 bf 2d                         ld (0x2dbf),hl
.data:0000395b bf                               cp a
.data:0000395c 21 2d 21                         ld hl,0x212d
.data:0000395f 2d                               dec l
.data:00003960 27                               daa
.data:00003961 26 3c                            ld h,0x3c
.data:00003963 2d                               dec l
.data:00003964 bf                               cp a
.data:00003965 2d                               dec l
.data:00003966 bf                               cp a
.data:00003967 2d                               dec l
.data:00003968 bf                               cp a
.data:00003969 2d                               dec l
.data:0000396a bf                               cp a
.data:0000396b 36 36                            ld (hl),0x36
.data:0000396d 34                               inc (hl)
.data:0000396e bf                               cp a
.data:0000396f 2d                               dec l
.data:00003970 bf                               cp a
.data:00003971 2d                               dec l
.data:00003972 bf                               cp a
.data:00003973 2d                               dec l
.data:00003974 bf                               cp a
.data:00003975 2d                               dec l
.data:00003976 3c                               inc a
.data:00003977 24                               inc h
.data:00003978 28 2d                            jr z,0x39a7
.data:0000397a 21 2d 22                         ld hl,0x222d
.data:0000397d bf                               cp a
.data:0000397e 22 bf 2d                         ld (0x2dbf),hl
.data:00003981 bf                               cp a
.data:00003982 2d                               dec l
.data:00003983 29                               add hl,hl
.data:00003984 25                               dec h
.data:00003985 2a 2d 29                         ld hl,(0x292d)
.data:00003988 25                               dec h
.data:00003989 25                               dec h
.data:0000398a 2a 33 21                         ld hl,(0x2133)
.data:0000398d 34                               inc (hl)
.data:0000398e 29                               add hl,hl
.data:0000398f 25                               dec h
.data:00003990 25                               dec h
.data:00003991 2a 2d 29                         ld hl,(0x292d)
.data:00003994 25                               dec h
.data:00003995 2a 2d bf                         ld hl,(0xbf2d)
.data:00003998 2d                               dec l
.data:00003999 bf                               cp a
.data:0000399a 22 bf 22                         ld (0x22bf),hl
.data:0000399d 2d                               dec l
.data:0000399e 27                               daa
.data:0000399f 25                               dec h
.data:000039a0 25                               dec h
.data:000039a1 26 bf                            ld h,0xbf
.data:000039a3 27                               daa
.data:000039a4 25                               dec h
.data:000039a5 28 bf                            jr z,0x3966
.data:000039a7 27                               daa
.data:000039a8 25                               dec h
.data:000039a9 25                               dec h
.data:000039aa 28 33                            jr z,0x39df
.data:000039ac 22 34 27                         ld (0x2734),hl
.data:000039af 25                               dec h
.data:000039b0 25                               dec h
.data:000039b1 28 bf                            jr z,0x3972
.data:000039b3 27                               daa
.data:000039b4 25                               dec h
.data:000039b5 28 bf                            jr z,0x3976
.data:000039b7 24                               inc h
.data:000039b8 25                               dec h
.data:000039b9 25                               dec h
.data:000039ba 28 2d                            jr z,0x39e9
.data:000039bc 22 bf 2d                         ld (0x2dbf),hl
.data:000039bf bf                               cp a
.data:000039c0 2d                               dec l
.data:000039c1 bf                               cp a
.data:000039c2 2d                               dec l
.data:000039c3 bf                               cp a
.data:000039c4 2d                               dec l
.data:000039c5 bf                               cp a
.data:000039c6 2d                               dec l
.data:000039c7 bf                               cp a
.data:000039c8 2d                               dec l
.data:000039c9 bf                               cp a
.data:000039ca 36 33                            ld (hl),0x33
.data:000039cc 22 36 36                         ld (0x3636),hl
.data:000039cf bf                               cp a
.data:000039d0 2d                               dec l
.data:000039d1 bf                               cp a
.data:000039d2 2d                               dec l
.data:000039d3 bf                               cp a
.data:000039d4 2d                               dec l
.data:000039d5 bf                               cp a
.data:000039d6 2d                               dec l
.data:000039d7 bf                               cp a
.data:000039d8 2d                               dec l
.data:000039d9 bf                               cp a
.data:000039da 2d                               dec l
.data:000039db bf                               cp a
.data:000039dc 2c                               inc l
.data:000039dd 25                               dec h
.data:000039de 25                               dec h
.data:000039df 25                               dec h
.data:000039e0 25                               dec h
.data:000039e1 25                               dec h
.data:000039e2 25                               dec h
.data:000039e3 25                               dec h
.data:000039e4 25                               dec h
.data:000039e5 25                               dec h
.data:000039e6 25                               dec h
.data:000039e7 25                               dec h
.data:000039e8 25                               dec h
.data:000039e9 25                               dec h
.data:000039ea 25                               dec h
.data:000039eb 25                               dec h
.data:000039ec 2c                               inc l
.data:000039ed 25                               dec h
.data:000039ee 25                               dec h
.data:000039ef 25                               dec h
.data:000039f0 25                               dec h
.data:000039f1 25                               dec h
.data:000039f2 25                               dec h
.data:000039f3 25                               dec h
.data:000039f4 25                               dec h
.data:000039f5 25                               dec h
.data:000039f6 25                               dec h
.data:000039f7 25                               dec h
.data:000039f8 25                               dec h
.data:000039f9 25                               dec h
.data:000039fa 25                               dec h
.data:000039fb 25                               dec h
.data:000039fc 0b                               dec bc
.data:000039fd 05                               dec b
.data:000039fe 05                               dec b
.data:000039ff 05                               dec b
.data:00003a00 05                               dec b
.data:00003a01 05                               dec b
.data:00003a02 05                               dec b
.data:00003a03 05                               dec b
.data:00003a04 05                               dec b
.data:00003a05 05                               dec b
.data:00003a06 0b                               dec bc
.data:00003a07 05                               dec b
.data:00003a08 05                               dec b
.data:00003a09 05                               dec b
.data:00003a0a 05                               dec b
.data:00003a0b 05                               dec b
.data:00003a0c 05                               dec b
.data:00003a0d 05                               dec b
.data:00003a0e 05                               dec b
.data:00003a0f 05                               dec b
.data:00003a10 05                               dec b
.data:00003a11 05                               dec b
.data:00003a12 0b                               dec bc
.data:00003a13 05                               dec b
.data:00003a14 05                               dec b
.data:00003a15 05                               dec b
.data:00003a16 05                               dec b
.data:00003a17 05                               dec b
.data:00003a18 05                               dec b
.data:00003a19 05                               dec b
.data:00003a1a 05                               dec b
.data:00003a1b 05                               dec b
.data:00003a1c 02                               ld (bc),a
.data:00003a1d 3c                               inc a
.data:00003a1e 2e c0                            ld l,0xc0
.data:00003a20 2e c0                            ld l,0xc0
.data:00003a22 2e c0                            ld l,0xc0
.data:00003a24 2e c0                            ld l,0xc0
.data:00003a26 02                               ld (bc),a
.data:00003a27 c0                               ret nz
.data:00003a28 2e c0                            ld l,0xc0
.data:00003a2a 2e c0                            ld l,0xc0
.data:00003a2c 00                               nop
.data:00003a2d c0                               ret nz
.data:00003a2e 2e c0                            ld l,0xc0
.data:00003a30 2e c0                            ld l,0xc0
.data:00003a32 02                               ld (bc),a
.data:00003a33 c0                               ret nz
.data:00003a34 2e c0                            ld l,0xc0
.data:00003a36 2e c0                            ld l,0xc0
.data:00003a38 2e c0                            ld l,0xc0
.data:00003a3a 2e 3c                            ld l,0x3c
.data:00003a3c 02                               ld (bc),a
.data:00003a3d 2e 09                            ld l,0x09
.data:00003a3f 05                               dec b
.data:00003a40 05                               dec b
.data:00003a41 0a                               ld a,(bc)
.data:00003a42 c0                               ret nz
.data:00003a43 09                               add hl,bc
.data:00003a44 0a                               ld a,(bc)
.data:00003a45 2e 03                            ld l,0x03
.data:00003a47 2e 04                            ld l,0x04
.data:00003a49 06 c0                            ld b,0xc0
.data:00003a4b 00                               nop
.data:00003a4c 3c                               inc a
.data:00003a4d 00                               nop
.data:00003a4e c0                               ret nz
.data:00003a4f 04                               inc b
.data:00003a50 06 2e                            ld b,0x2e
.data:00003a52 03                               inc bc
.data:00003a53 2e 09                            ld l,0x09
.data:00003a55 0a                               ld a,(bc)
.data:00003a56 c0                               ret nz
.data:00003a57 09                               add hl,bc
.data:00003a58 05                               dec b
.data:00003a59 05                               dec b
.data:00003a5a 0a                               ld a,(bc)
.data:00003a5b 2e 03                            ld l,0x03
.data:00003a5d c0                               ret nz
.data:00003a5e 07                               rlca
.data:00003a5f 05                               dec b
.data:00003a60 05                               dec b
.data:00003a61 08                               ex af,af'
.data:00003a62 2e 07                            ld l,0x07
.data:00003a64 08                               ex af,af'
.data:00003a65 c0                               ret nz
.data:00003a66 2e c0                            ld l,0xc0
.data:00003a68 2e c0                            ld l,0xc0
.data:00003a6a 2e 00                            ld l,0x00
.data:00003a6c 2e 00                            ld l,0x00
.data:00003a6e 2e c0                            ld l,0xc0
.data:00003a70 2e c0                            ld l,0xc0
.data:00003a72 2e c0                            ld l,0xc0
.data:00003a74 07                               rlca
.data:00003a75 08                               ex af,af'
.data:00003a76 2e 07                            ld l,0x07
.data:00003a78 05                               dec b
.data:00003a79 05                               dec b
.data:00003a7a 08                               ex af,af'
.data:00003a7b c0                               ret nz
.data:00003a7c 34                               inc (hl)
.data:00003a7d 35                               dec (hl)
.data:00003a7e 35                               dec (hl)
.data:00003a7f 2e c0                            ld l,0xc0
.data:00003a81 2e c0                            ld l,0xc0
.data:00003a83 2e c0                            ld l,0xc0
.data:00003a85 2e 04                            ld l,0x04
.data:00003a87 05                               dec b
.data:00003a88 05                               dec b
.data:00003a89 0a                               ld a,(bc)
.data:00003a8a c0                               ret nz
.data:00003a8b 2e c0                            ld l,0xc0
.data:00003a8d 2e c0                            ld l,0xc0
.data:00003a8f 09                               add hl,bc
.data:00003a90 05                               dec b
.data:00003a91 05                               dec b
.data:00003a92 06 2e                            ld b,0x2e
.data:00003a94 c0                               ret nz
.data:00003a95 2e c0                            ld l,0xc0
.data:00003a97 2e c0                            ld l,0xc0
.data:00003a99 2e c0                            ld l,0xc0
.data:00003a9b 2e 37                            ld l,0x37
.data:00003a9d 01 33 04                         ld bc,0x0433
.data:00003aa0 05                               dec b
.data:00003aa1 05                               dec b
.data:00003aa2 06 c0                            ld b,0xc0
.data:00003aa4 01 c0 2e                         ld bc,0x2ec0
.data:00003aa7 c0                               ret nz
.data:00003aa8 2e 03                            ld l,0x03
.data:00003aaa 2e 04                            ld l,0x04
.data:00003aac 05                               dec b
.data:00003aad 06 2e                            ld b,0x2e
.data:00003aaf 03                               inc bc
.data:00003ab0 2e c0                            ld l,0xc0
.data:00003ab2 2e c0                            ld l,0xc0
.data:00003ab4 01 c0 04                         ld bc,0x04c0
.data:00003ab7 05                               dec b
.data:00003ab8 05                               dec b
.data:00003ab9 06 2e                            ld b,0x2e
.data:00003abb 01 37 02                         ld bc,0x0237
.data:00003abe 33                               inc sp
.data:00003abf 2e c0                            ld l,0xc0
.data:00003ac1 2e c0                            ld l,0xc0
.data:00003ac3 2e 02                            ld l,0x02
.data:00003ac5 2e 04                            ld l,0x04
.data:00003ac7 06 c0                            ld b,0xc0
.data:00003ac9 2e c0                            ld l,0xc0
.data:00003acb 2e c0                            ld l,0xc0
.data:00003acd 2e c0                            ld l,0xc0
.data:00003acf 2e c0                            ld l,0xc0
.data:00003ad1 04                               inc b
.data:00003ad2 06 2e                            ld b,0x2e
.data:00003ad4 02                               ld (bc),a
.data:00003ad5 2e c0                            ld l,0xc0
.data:00003ad7 2e c0                            ld l,0xc0
.data:00003ad9 2e c0                            ld l,0xc0
.data:00003adb 02                               ld (bc),a
.data:00003adc 37                               scf
.data:00003add 02                               ld (bc),a
.data:00003ade 33                               inc sp
.data:00003adf 04                               inc b
.data:00003ae0 05                               dec b
.data:00003ae1 05                               dec b
.data:00003ae2 06 c0                            ld b,0xc0
.data:00003ae4 03                               inc bc
.data:00003ae5 c0                               ret nz
.data:00003ae6 2e c0                            ld l,0xc0
.data:00003ae8 01 c0 09                         ld bc,0x09c0
.data:00003aeb 50                               ld d,b
.data:00003aec 38 51                            jr c,0x3b3f
.data:00003aee 0a                               ld a,(bc)
.data:00003aef c0                               ret nz
.data:00003af0 01 c0 2e                         ld bc,0x2ec0
.data:00003af3 c0                               ret nz
.data:00003af4 03                               inc bc
.data:00003af5 c0                               ret nz
.data:00003af6 04                               inc b
.data:00003af7 05                               dec b
.data:00003af8 05                               dec b
.data:00003af9 06 2e                            ld b,0x2e
.data:00003afb 02                               ld (bc),a
.data:00003afc 37                               scf
.data:00003afd 02                               ld (bc),a
.data:00003afe 33                               inc sp
.data:00003aff 2e c0                            ld l,0xc0
.data:00003b01 2e c0                            ld l,0xc0
.data:00003b03 2e c0                            ld l,0xc0
.data:00003b05 2e 01                            ld l,0x01
.data:00003b07 2e 03                            ld l,0x03
.data:00003b09 2e 02                            ld l,0x02
.data:00003b0b bf                               cp a
.data:00003b0c bf                               cp a
.data:00003b0d bf                               cp a
.data:00003b0e 02                               ld (bc),a
.data:00003b0f 2e 03                            ld l,0x03
.data:00003b11 2e 01                            ld l,0x01
.data:00003b13 2e c0                            ld l,0xc0
.data:00003b15 2e c0                            ld l,0xc0
.data:00003b17 2e c0                            ld l,0xc0
.data:00003b19 2e c0                            ld l,0xc0
.data:00003b1b 02                               ld (bc),a
.data:00003b1c 37                               scf
.data:00003b1d 0d                               dec c
.data:00003b1e 06 c0                            ld b,0xc0
.data:00003b20 04                               inc b
.data:00003b21 06 c0                            ld b,0xc0
.data:00003b23 04                               inc b
.data:00003b24 06 c0                            ld b,0xc0
.data:00003b26 02                               ld (bc),a
.data:00003b27 34                               inc (hl)
.data:00003b28 35                               dec (hl)
.data:00003b29 35                               dec (hl)
.data:00003b2a 07                               rlca
.data:00003b2b 05                               dec b
.data:00003b2c 05                               dec b
.data:00003b2d 05                               dec b
.data:00003b2e 08                               ex af,af'
.data:00003b2f 36 36                            ld (hl),0x36
.data:00003b31 34                               inc (hl)
.data:00003b32 02                               ld (bc),a
.data:00003b33 c0                               ret nz
.data:00003b34 04                               inc b
.data:00003b35 06 c0                            ld b,0xc0
.data:00003b37 04                               inc b
.data:00003b38 06 c0                            ld b,0xc0
.data:00003b3a 04                               inc b
.data:00003b3b 0e 37                            ld c,0x37
.data:00003b3d 02                               ld (bc),a
.data:00003b3e c0                               ret nz
.data:00003b3f 2e c0                            ld l,0xc0
.data:00003b41 2e c0                            ld l,0xc0
.data:00003b43 2e c0                            ld l,0xc0
.data:00003b45 2e 02                            ld l,0x02
.data:00003b47 34                               inc (hl)
.data:00003b48 01 33 35                         ld bc,0x3533
.data:00003b4b 35                               dec (hl)
.data:00003b4c c0                               ret nz
.data:00003b4d 36 36                            ld (hl),0x36
.data:00003b4f 33                               inc sp
.data:00003b50 01 34 02                         ld bc,0x0234
.data:00003b53 2e c0                            ld l,0xc0
.data:00003b55 2e c0                            ld l,0xc0
.data:00003b57 2e c0                            ld l,0xc0
.data:00003b59 2e 35                            ld l,0x35
.data:00003b5b 02                               ld (bc),a
.data:00003b5c 37                               scf
.data:00003b5d 02                               ld (bc),a
.data:00003b5e 2e 04                            ld l,0x04
.data:00003b60 05                               dec b
.data:00003b61 05                               dec b
.data:00003b62 06 c0                            ld b,0xc0
.data:00003b64 01 c0 03                         ld bc,0x03c0
.data:00003b67 34                               inc (hl)
.data:00003b68 07                               rlca
.data:00003b69 06 c0                            ld b,0xc0
.data:00003b6b 04                               inc b
.data:00003b6c 05                               dec b
.data:00003b6d 06 c0                            ld b,0xc0
.data:00003b6f 04                               inc b
.data:00003b70 08                               ex af,af'
.data:00003b71 34                               inc (hl)
.data:00003b72 03                               inc bc
.data:00003b73 c0                               ret nz
.data:00003b74 01 c0 04                         ld bc,0x04c0
.data:00003b77 05                               dec b
.data:00003b78 05                               dec b
.data:00003b79 06 33                            ld b,0x33
.data:00003b7b 02                               ld (bc),a
.data:00003b7c 37                               scf
.data:00003b7d 02                               ld (bc),a
.data:00003b7e c0                               ret nz
.data:00003b7f 2e c0                            ld l,0xc0
.data:00003b81 2e c0                            ld l,0xc0
.data:00003b83 2e 02                            ld l,0x02
.data:00003b85 34                               inc (hl)
.data:00003b86 35                               dec (hl)
.data:00003b87 35                               dec (hl)
.data:00003b88 c0                               ret nz
.data:00003b89 2e c0                            ld l,0xc0
.data:00003b8b 2e c0                            ld l,0xc0
.data:00003b8d 2e c0                            ld l,0xc0
.data:00003b8f 2e c0                            ld l,0xc0
.data:00003b91 36 36                            ld (hl),0x36
.data:00003b93 34                               inc (hl)
.data:00003b94 02                               ld (bc),a
.data:00003b95 2e c0                            ld l,0xc0
.data:00003b97 2e c0                            ld l,0xc0
.data:00003b99 2e 33                            ld l,0x33
.data:00003b9b 02                               ld (bc),a
.data:00003b9c 37                               scf
.data:00003b9d 03                               inc bc
.data:00003b9e 2e 04                            ld l,0x04
.data:00003ba0 05                               dec b
.data:00003ba1 05                               dec b
.data:00003ba2 06 c0                            ld b,0xc0
.data:00003ba4 03                               inc bc
.data:00003ba5 34                               inc (hl)
.data:00003ba6 09                               add hl,bc
.data:00003ba7 05                               dec b
.data:00003ba8 0a                               ld a,(bc)
.data:00003ba9 c0                               ret nz
.data:00003baa 09                               add hl,bc
.data:00003bab 0a                               ld a,(bc)
.data:00003bac 33                               inc sp
.data:00003bad 09                               add hl,bc
.data:00003bae 0a                               ld a,(bc)
.data:00003baf c0                               ret nz
.data:00003bb0 09                               add hl,bc
.data:00003bb1 05                               dec b
.data:00003bb2 0a                               ld a,(bc)
.data:00003bb3 34                               inc (hl)
.data:00003bb4 03                               inc bc
.data:00003bb5 c0                               ret nz
.data:00003bb6 04                               inc b
.data:00003bb7 05                               dec b
.data:00003bb8 05                               dec b
.data:00003bb9 06 33                            ld b,0x33
.data:00003bbb 03                               inc bc
.data:00003bbc c0                               ret nz
.data:00003bbd 2e c0                            ld l,0xc0
.data:00003bbf 2e c0                            ld l,0xc0
.data:00003bc1 2e c0                            ld l,0xc0
.data:00003bc3 2e c0                            ld l,0xc0
.data:00003bc5 34                               inc (hl)
.data:00003bc6 02                               ld (bc),a
.data:00003bc7 00                               nop
.data:00003bc8 02                               ld (bc),a
.data:00003bc9 2e 07                            ld l,0x07
.data:00003bcb 08                               ex af,af'
.data:00003bcc 33                               inc sp
.data:00003bcd 07                               rlca
.data:00003bce 08                               ex af,af'
.data:00003bcf 2e 02                            ld l,0x02
.data:00003bd1 00                               nop
.data:00003bd2 02                               ld (bc),a
.data:00003bd3 34                               inc (hl)
.data:00003bd4 c0                               ret nz
.data:00003bd5 2e c0                            ld l,0xc0
.data:00003bd7 2e c0                            ld l,0xc0
.data:00003bd9 2e 33                            ld l,0x33
.data:00003bdb 35                               dec (hl)
.data:00003bdc 01 c0 04                         ld bc,0x04c0
.data:00003bdf 05                               dec b
.data:00003be0 05                               dec b
.data:00003be1 06 2e                            ld b,0x2e
.data:00003be3 04                               inc b
.data:00003be4 06 34                            ld b,0x34
.data:00003be6 07                               rlca
.data:00003be7 05                               dec b
.data:00003be8 08                               ex af,af'
.data:00003be9 36 36                            ld (hl),0x36
.data:00003beb 36 33                            ld (hl),0x33
.data:00003bed 35                               dec (hl)
.data:00003bee 35                               dec (hl)
.data:00003bef 35                               dec (hl)
.data:00003bf0 07                               rlca
.data:00003bf1 05                               dec b
.data:00003bf2 08                               ex af,af'
.data:00003bf3 34                               inc (hl)
.data:00003bf4 04                               inc b
.data:00003bf5 06 c0                            ld b,0xc0
.data:00003bf7 04                               inc b
.data:00003bf8 05                               dec b
.data:00003bf9 05                               dec b
.data:00003bfa 06 c0                            ld b,0xc0
.data:00003bfc 02                               ld (bc),a
.data:00003bfd 3c                               inc a
.data:00003bfe c0                               ret nz
.data:00003bff 2e c0                            ld l,0xc0
.data:00003c01 2e c0                            ld l,0xc0
.data:00003c03 2e c0                            ld l,0xc0
.data:00003c05 36 36                            ld (hl),0x36
.data:00003c07 36 36                            ld (hl),0x36
.data:00003c09 33                               inc sp
.data:00003c0a 09                               add hl,bc
.data:00003c0b 05                               dec b
.data:00003c0c 05                               dec b
.data:00003c0d 05                               dec b
.data:00003c0e 0a                               ld a,(bc)
.data:00003c0f 33                               inc sp
.data:00003c10 35                               dec (hl)
.data:00003c11 35                               dec (hl)
.data:00003c12 35                               dec (hl)
.data:00003c13 35                               dec (hl)
.data:00003c14 c0                               ret nz
.data:00003c15 2e c0                            ld l,0xc0
.data:00003c17 2e c0                            ld l,0xc0
.data:00003c19 2e c0                            ld l,0xc0
.data:00003c1b 3c                               inc a
.data:00003c1c 0c                               inc c
.data:00003c1d 05                               dec b
.data:00003c1e 05                               dec b
.data:00003c1f 05                               dec b
.data:00003c20 05                               dec b
.data:00003c21 05                               dec b
.data:00003c22 05                               dec b
.data:00003c23 05                               dec b
.data:00003c24 05                               dec b
.data:00003c25 05                               dec b
.data:00003c26 05                               dec b
.data:00003c27 05                               dec b
.data:00003c28 05                               dec b
.data:00003c29 05                               dec b
.data:00003c2a 0c                               inc c
.data:00003c2b 05                               dec b
.data:00003c2c 05                               dec b
.data:00003c2d 05                               dec b
.data:00003c2e 0c                               inc c
.data:00003c2f 05                               dec b
.data:00003c30 05                               dec b
.data:00003c31 05                               dec b
.data:00003c32 05                               dec b
.data:00003c33 05                               dec b
.data:00003c34 05                               dec b
.data:00003c35 05                               dec b
.data:00003c36 05                               dec b
.data:00003c37 05                               dec b
.data:00003c38 05                               dec b
.data:00003c39 05                               dec b
.data:00003c3a 05                               dec b
.data:00003c3b 05                               dec b
.data:00003c3c 19                               add hl,de
.data:00003c3d 15                               dec d
.data:00003c3e 15                               dec d
.data:00003c3f 15                               dec d
.data:00003c40 15                               dec d
.data:00003c41 15                               dec d
.data:00003c42 15                               dec d
.data:00003c43 15                               dec d
.data:00003c44 15                               dec d
.data:00003c45 15                               dec d
.data:00003c46 15                               dec d
.data:00003c47 15                               dec d
.data:00003c48 1b                               dec de
.data:00003c49 15                               dec d
.data:00003c4a 15                               dec d
.data:00003c4b 15                               dec d
.data:00003c4c 15                               dec d
.data:00003c4d 15                               dec d
.data:00003c4e 1b                               dec de
.data:00003c4f 15                               dec d
.data:00003c50 15                               dec d
.data:00003c51 15                               dec d
.data:00003c52 15                               dec d
.data:00003c53 15                               dec d
.data:00003c54 15                               dec d
.data:00003c55 15                               dec d
.data:00003c56 15                               dec d
.data:00003c57 15                               dec d
.data:00003c58 15                               dec d
.data:00003c59 15                               dec d
.data:00003c5a 1a                               ld a,(de)
.data:00003c5b 42                               ld b,d
.data:00003c5c 12                               ld (de),a
.data:00003c5d 2d                               dec l
.data:00003c5e bf                               cp a
.data:00003c5f 2d                               dec l
.data:00003c60 3f                               ccf
.data:00003c61 2d                               dec l
.data:00003c62 3f                               ccf
.data:00003c63 2d                               dec l
.data:00003c64 bf                               cp a
.data:00003c65 2d                               dec l
.data:00003c66 bf                               cp a
.data:00003c67 2d                               dec l
.data:00003c68 13                               inc de
.data:00003c69 2d                               dec l
.data:00003c6a 3d                               dec a
.data:00003c6b 3e 3d                            ld a,0x3d
.data:00003c6d 2d                               dec l
.data:00003c6e 13                               inc de
.data:00003c6f 2d                               dec l
.data:00003c70 bf                               cp a
.data:00003c71 2d                               dec l
.data:00003c72 bf                               cp a
.data:00003c73 2d                               dec l
.data:00003c74 bf                               cp a
.data:00003c75 2d                               dec l
.data:00003c76 bf                               cp a
.data:00003c77 2d                               dec l
.data:00003c78 bf                               cp a
.data:00003c79 2d                               dec l
.data:00003c7a 12                               ld (de),a
.data:00003c7b 58                               ld e,b
.data:00003c7c 12                               ld (de),a
.data:00003c7d bf                               cp a
.data:00003c7e 19                               add hl,de
.data:00003c7f 1a                               ld a,(de)
.data:00003c80 3f                               ccf
.data:00003c81 19                               add hl,de
.data:00003c82 1a                               ld a,(de)
.data:00003c83 bf                               cp a
.data:00003c84 19                               add hl,de
.data:00003c85 15                               dec d
.data:00003c86 1a                               ld a,(de)
.data:00003c87 bf                               cp a
.data:00003c88 2d                               dec l
.data:00003c89 bf                               cp a
.data:00003c8a 14                               inc d
.data:00003c8b 15                               dec d
.data:00003c8c 16 bf                            ld d,0xbf
.data:00003c8e 2d                               dec l
.data:00003c8f bf                               cp a
.data:00003c90 19                               add hl,de
.data:00003c91 15                               dec d
.data:00003c92 1a                               ld a,(de)
.data:00003c93 bf                               cp a
.data:00003c94 19                               add hl,de
.data:00003c95 1a                               ld a,(de)
.data:00003c96 2d                               dec l
.data:00003c97 19                               add hl,de
.data:00003c98 1a                               ld a,(de)
.data:00003c99 bf                               cp a
.data:00003c9a 12                               ld (de),a
.data:00003c9b 59                               ld e,c
.data:00003c9c 18 2d                            jr 0x3ccb
.data:00003c9e 12                               ld (de),a
.data:00003c9f 12                               ld (de),a
.data:00003ca0 2d                               dec l
.data:00003ca1 17                               rla
.data:00003ca2 18 2d                            jr 0x3cd1
.data:00003ca4 12                               ld (de),a
.data:00003ca5 bf                               cp a
.data:00003ca6 12                               ld (de),a
.data:00003ca7 2d                               dec l
.data:00003ca8 11 2d bf                         ld de,0xbf2d
.data:00003cab 3f                               ccf
.data:00003cac bf                               cp a
.data:00003cad 2d                               dec l
.data:00003cae 11 2d 12                         ld de,0x122d
.data:00003cb1 bf                               cp a
.data:00003cb2 12                               ld (de),a
.data:00003cb3 2d                               dec l
.data:00003cb4 17                               rla
.data:00003cb5 18 bf                            jr 0x3c76
.data:00003cb7 12                               ld (de),a
.data:00003cb8 12                               ld (de),a
.data:00003cb9 2d                               dec l
.data:00003cba 17                               rla
.data:00003cbb 15                               dec d
.data:00003cbc 2d                               dec l
.data:00003cbd bf                               cp a
.data:00003cbe 17                               rla
.data:00003cbf 18 2d                            jr 0x3cee
.data:00003cc1 bf                               cp a
.data:00003cc2 2d                               dec l
.data:00003cc3 bf                               cp a
.data:00003cc4 17                               rla
.data:00003cc5 15                               dec d
.data:00003cc6 18 bf                            jr 0x3c87
.data:00003cc8 13                               inc de
.data:00003cc9 bf                               cp a
.data:00003cca 14                               inc d
.data:00003ccb 15                               dec d
.data:00003ccc 16 bf                            ld d,0xbf
.data:00003cce 13                               inc de
.data:00003ccf bf                               cp a
.data:00003cd0 17                               rla
.data:00003cd1 15                               dec d
.data:00003cd2 18 bf                            jr 0x3c93
.data:00003cd4 2d                               dec l
.data:00003cd5 bf                               cp a
.data:00003cd6 2d                               dec l
.data:00003cd7 17                               rla
.data:00003cd8 18 bf                            jr 0x3c99
.data:00003cda 2d                               dec l
.data:00003cdb bf                               cp a
.data:00003cdc 1a                               ld a,(de)
.data:00003cdd 2d                               dec l
.data:00003cde bf                               cp a
.data:00003cdf 2d                               dec l
.data:00003ce0 bf                               cp a
.data:00003ce1 19                               add hl,de
.data:00003ce2 1a                               ld a,(de)
.data:00003ce3 3c                               inc a
.data:00003ce4 bf                               cp a
.data:00003ce5 2d                               dec l
.data:00003ce6 bf                               cp a
.data:00003ce7 2d                               dec l
.data:00003ce8 bf                               cp a
.data:00003ce9 2d                               dec l
.data:00003cea bf                               cp a
.data:00003ceb 2d                               dec l
.data:00003cec bf                               cp a
.data:00003ced 2d                               dec l
.data:00003cee bf                               cp a
.data:00003cef 2d                               dec l
.data:00003cf0 bf                               cp a
.data:00003cf1 2d                               dec l
.data:00003cf2 bf                               cp a
.data:00003cf3 3c                               inc a
.data:00003cf4 19                               add hl,de
.data:00003cf5 1a                               ld a,(de)
.data:00003cf6 bf                               cp a
.data:00003cf7 2d                               dec l
.data:00003cf8 bf                               cp a
.data:00003cf9 2d                               dec l
.data:00003cfa 19                               add hl,de
.data:00003cfb 15                               dec d
.data:00003cfc 17                               rla
.data:00003cfd 15                               dec d
.data:00003cfe 15                               dec d
.data:00003cff 15                               dec d
.data:00003d00 15                               dec d
.data:00003d01 1c                               inc e
.data:00003d02 1c                               inc e
.data:00003d03 15                               dec d
.data:00003d04 15                               dec d
.data:00003d05 15                               dec d
.data:00003d06 15                               dec d
.data:00003d07 15                               dec d
.data:00003d08 15                               dec d
.data:00003d09 15                               dec d
.data:00003d0a 1a                               ld a,(de)
.data:00003d0b 34                               inc (hl)
.data:00003d0c 19                               add hl,de
.data:00003d0d 15                               dec d
.data:00003d0e 15                               dec d
.data:00003d0f 15                               dec d
.data:00003d10 15                               dec d
.data:00003d11 15                               dec d
.data:00003d12 15                               dec d
.data:00003d13 15                               dec d
.data:00003d14 1c                               inc e
.data:00003d15 1c                               inc e
.data:00003d16 15                               dec d
.data:00003d17 15                               dec d
.data:00003d18 15                               dec d
.data:00003d19 15                               dec d
.data:00003d1a 18 58                            jr 0x3d74
.data:00003d1c 42                               ld b,d
.data:00003d1d 58                               ld e,b
.data:00003d1e 42                               ld b,d
.data:00003d1f 58                               ld e,b
.data:00003d20 5a                               ld e,d
.data:00003d21 58                               ld e,b
.data:00003d22 42                               ld b,d
.data:00003d23 42                               ld b,d
.data:00003d24 59                               ld e,c
.data:00003d25 42                               ld b,d
.data:00003d26 42                               ld b,d
.data:00003d27 42                               ld b,d
.data:00003d28 58                               ld e,b
.data:00003d29 42                               ld b,d
.data:00003d2a 12                               ld (de),a
.data:00003d2b 34                               inc (hl)
.data:00003d2c 12                               ld (de),a
.data:00003d2d 42                               ld b,d
.data:00003d2e 42                               ld b,d
.data:00003d2f 59                               ld e,c
.data:00003d30 58                               ld e,b
.data:00003d31 42                               ld b,d
.data:00003d32 42                               ld b,d
.data:00003d33 5a                               ld e,d
.data:00003d34 42                               ld b,d
.data:00003d35 42                               ld b,d
.data:00003d36 58                               ld e,b
.data:00003d37 42                               ld b,d
.data:00003d38 42                               ld b,d
.data:00003d39 59                               ld e,c
.data:00003d3a 58                               ld e,b
.data:00003d3b 42                               ld b,d
.data:00003d3c 42                               ld b,d
.data:00003d3d 42                               ld b,d
.data:00003d3e 58                               ld e,b
.data:00003d3f 42                               ld b,d
.data:00003d40 42                               ld b,d
.data:00003d41 42                               ld b,d
.data:00003d42 42                               ld b,d
.data:00003d43 42                               ld b,d
.data:00003d44 42                               ld b,d
.data:00003d45 58                               ld e,b
.data:00003d46 42                               ld b,d
.data:00003d47 5a                               ld e,d
.data:00003d48 42                               ld b,d
.data:00003d49 59                               ld e,c
.data:00003d4a 12                               ld (de),a
.data:00003d4b 34                               inc (hl)
.data:00003d4c 12                               ld (de),a
.data:00003d4d 58                               ld e,b
.data:00003d4e 42                               ld b,d
.data:00003d4f 42                               ld b,d
.data:00003d50 42                               ld b,d
.data:00003d51 58                               ld e,b
.data:00003d52 42                               ld b,d
.data:00003d53 42                               ld b,d
.data:00003d54 58                               ld e,b
.data:00003d55 42                               ld b,d
.data:00003d56 42                               ld b,d
.data:00003d57 42                               ld b,d
.data:00003d58 58                               ld e,b
.data:00003d59 42                               ld b,d
.data:00003d5a 42                               ld b,d
.data:00003d5b 5a                               ld e,d
.data:00003d5c 19                               add hl,de
.data:00003d5d 15                               dec d
.data:00003d5e 15                               dec d
.data:00003d5f 15                               dec d
.data:00003d60 15                               dec d
.data:00003d61 15                               dec d
.data:00003d62 15                               dec d
.data:00003d63 15                               dec d
.data:00003d64 15                               dec d
.data:00003d65 15                               dec d
.data:00003d66 15                               dec d
.data:00003d67 15                               dec d
.data:00003d68 15                               dec d
.data:00003d69 15                               dec d
.data:00003d6a 18 34                            jr 0x3da0
.data:00003d6c 17                               rla
.data:00003d6d 15                               dec d
.data:00003d6e 15                               dec d
.data:00003d6f 15                               dec d
.data:00003d70 15                               dec d
.data:00003d71 15                               dec d
.data:00003d72 15                               dec d
.data:00003d73 15                               dec d
.data:00003d74 15                               dec d
.data:00003d75 15                               dec d
.data:00003d76 15                               dec d
.data:00003d77 15                               dec d
.data:00003d78 15                               dec d
.data:00003d79 15                               dec d
.data:00003d7a 1a                               ld a,(de)
.data:00003d7b 58                               ld e,b
.data:00003d7c 12                               ld (de),a
.data:00003d7d 2d                               dec l
.data:00003d7e bf                               cp a
.data:00003d7f 2d                               dec l
.data:00003d80 bf                               cp a
.data:00003d81 2d                               dec l
.data:00003d82 bf                               cp a
.data:00003d83 2d                               dec l
.data:00003d84 bf                               cp a
.data:00003d85 2d                               dec l
.data:00003d86 bf                               cp a
.data:00003d87 2d                               dec l
.data:00003d88 36 36                            ld (hl),0x36
.data:00003d8a 36 36                            ld (hl),0x36
.data:00003d8c 36 36                            ld (hl),0x36
.data:00003d8e 34                               inc (hl)
.data:00003d8f 2d                               dec l
.data:00003d90 bf                               cp a
.data:00003d91 2d                               dec l
.data:00003d92 bf                               cp a
.data:00003d93 2d                               dec l
.data:00003d94 bf                               cp a
.data:00003d95 2d                               dec l
.data:00003d96 bf                               cp a
.data:00003d97 2d                               dec l
.data:00003d98 bf                               cp a
.data:00003d99 2d                               dec l
.data:00003d9a 12                               ld (de),a
.data:00003d9b 42                               ld b,d
.data:00003d9c 12                               ld (de),a
.data:00003d9d bf                               cp a
.data:00003d9e bf                               cp a
.data:00003d9f bf                               cp a
.data:00003da0 bf                               cp a
.data:00003da1 bf                               cp a
.data:00003da2 bf                               cp a
.data:00003da3 bf                               cp a
.data:00003da4 bf                               cp a
.data:00003da5 bf                               cp a
.data:00003da6 bf                               cp a
.data:00003da7 bf                               cp a
.data:00003da8 33                               inc sp
.data:00003da9 19                               add hl,de
.data:00003daa 50                               ld d,b
.data:00003dab 38 51                            jr c,0x3dfe
.data:00003dad 1a                               ld a,(de)
.data:00003dae 34                               inc (hl)
.data:00003daf bf                               cp a
.data:00003db0 bf                               cp a
.data:00003db1 bf                               cp a
.data:00003db2 bf                               cp a
.data:00003db3 bf                               cp a
.data:00003db4 bf                               cp a
.data:00003db5 bf                               cp a
.data:00003db6 bf                               cp a
.data:00003db7 bf                               cp a
.data:00003db8 bf                               cp a
.data:00003db9 bf                               cp a
.data:00003dba 12                               ld (de),a
.data:00003dbb 58                               ld e,b
.data:00003dbc 18 2d                            jr 0x3deb
.data:00003dbe 54                               ld d,h
.data:00003dbf 55                               ld d,l
.data:00003dc0 bf                               cp a
.data:00003dc1 2d                               dec l
.data:00003dc2 bf                               cp a
.data:00003dc3 2d                               dec l
.data:00003dc4 bf                               cp a
.data:00003dc5 2d                               dec l
.data:00003dc6 bf                               cp a
.data:00003dc7 2d                               dec l
.data:00003dc8 33                               inc sp
.data:00003dc9 12                               ld (de),a
.data:00003dca bf                               cp a
.data:00003dcb bf                               cp a
.data:00003dcc bf                               cp a
.data:00003dcd 12                               ld (de),a
.data:00003dce 34                               inc (hl)
.data:00003dcf 2d                               dec l
.data:00003dd0 bf                               cp a
.data:00003dd1 2d                               dec l
.data:00003dd2 bf                               cp a
.data:00003dd3 2d                               dec l
.data:00003dd4 bf                               cp a
.data:00003dd5 2d                               dec l
.data:00003dd6 bf                               cp a
.data:00003dd7 54                               ld d,h
.data:00003dd8 55                               ld d,l
.data:00003dd9 2d                               dec l
.data:00003dda 17                               rla
.data:00003ddb 15                               dec d
.data:00003ddc 3d                               dec a
.data:00003ddd bf                               cp a
.data:00003dde 56                               ld d,(hl)
.data:00003ddf 57                               ld d,a
.data:00003de0 bf                               cp a
.data:00003de1 bf                               cp a
.data:00003de2 bf                               cp a
.data:00003de3 bf                               cp a
.data:00003de4 bf                               cp a
.data:00003de5 bf                               cp a
.data:00003de6 bf                               cp a
.data:00003de7 bf                               cp a
.data:00003de8 33                               inc sp
.data:00003de9 17                               rla
.data:00003dea 15                               dec d
.data:00003deb 15                               dec d
.data:00003dec 15                               dec d
.data:00003ded 18 34                            jr 0x3e23
.data:00003def bf                               cp a
.data:00003df0 bf                               cp a
.data:00003df1 bf                               cp a
.data:00003df2 bf                               cp a
.data:00003df3 bf                               cp a
.data:00003df4 bf                               cp a
.data:00003df5 bf                               cp a
.data:00003df6 bf                               cp a
.data:00003df7 56                               ld d,(hl)
.data:00003df8 57                               ld d,a
.data:00003df9 bf                               cp a
.data:00003dfa bf                               cp a
.data:00003dfb 3d                               dec a
.data:00003dfc 1a                               ld a,(de)
.data:00003dfd 2d                               dec l
.data:00003dfe bf                               cp a
.data:00003dff 2d                               dec l
.data:00003e00 bf                               cp a
.data:00003e01 2d                               dec l
.data:00003e02 bf                               cp a
.data:00003e03 2d                               dec l
.data:00003e04 bf                               cp a
.data:00003e05 2d                               dec l
.data:00003e06 bf                               cp a
.data:00003e07 2d                               dec l
.data:00003e08 33                               inc sp
.data:00003e09 35                               dec (hl)
.data:00003e0a 35                               dec (hl)
.data:00003e0b 35                               dec (hl)
.data:00003e0c 35                               dec (hl)
.data:00003e0d 35                               dec (hl)
.data:00003e0e 35                               dec (hl)
.data:00003e0f 2d                               dec l
.data:00003e10 bf                               cp a
.data:00003e11 2d                               dec l
.data:00003e12 bf                               cp a
.data:00003e13 2d                               dec l
.data:00003e14 bf                               cp a
.data:00003e15 2d                               dec l
.data:00003e16 bf                               cp a
.data:00003e17 2d                               dec l
.data:00003e18 bf                               cp a
.data:00003e19 2d                               dec l
.data:00003e1a 19                               add hl,de
.data:00003e1b 15                               dec d
.data:00003e1c 17                               rla
.data:00003e1d 15                               dec d
.data:00003e1e 15                               dec d
.data:00003e1f 15                               dec d
.data:00003e20 15                               dec d
.data:00003e21 15                               dec d
.data:00003e22 15                               dec d
.data:00003e23 15                               dec d
.data:00003e24 15                               dec d
.data:00003e25 15                               dec d
.data:00003e26 15                               dec d
.data:00003e27 15                               dec d
.data:00003e28 15                               dec d
.data:00003e29 15                               dec d
.data:00003e2a 15                               dec d
.data:00003e2b 15                               dec d
.data:00003e2c 15                               dec d
.data:00003e2d 15                               dec d
.data:00003e2e 15                               dec d
.data:00003e2f 15                               dec d
.data:00003e30 15                               dec d
.data:00003e31 15                               dec d
.data:00003e32 15                               dec d
.data:00003e33 15                               dec d
.data:00003e34 15                               dec d
.data:00003e35 15                               dec d
.data:00003e36 15                               dec d
.data:00003e37 15                               dec d
.data:00003e38 15                               dec d
.data:00003e39 15                               dec d
.data:00003e3a 18 58                            jr 0x3e94
.data:00003e3c 0b                               dec bc
.data:00003e3d 05                               dec b
.data:00003e3e 05                               dec b
.data:00003e3f 05                               dec b
.data:00003e40 05                               dec b
.data:00003e41 05                               dec b
.data:00003e42 05                               dec b
.data:00003e43 05                               dec b
.data:00003e44 05                               dec b
.data:00003e45 05                               dec b
.data:00003e46 05                               dec b
.data:00003e47 05                               dec b
.data:00003e48 0b                               dec bc
.data:00003e49 05                               dec b
.data:00003e4a 05                               dec b
.data:00003e4b 05                               dec b
.data:00003e4c 05                               dec b
.data:00003e4d 05                               dec b
.data:00003e4e 05                               dec b
.data:00003e4f 05                               dec b
.data:00003e50 0b                               dec bc
.data:00003e51 05                               dec b
.data:00003e52 05                               dec b
.data:00003e53 05                               dec b
.data:00003e54 05                               dec b
.data:00003e55 05                               dec b
.data:00003e56 05                               dec b
.data:00003e57 05                               dec b
.data:00003e58 05                               dec b
.data:00003e59 05                               dec b
.data:00003e5a 05                               dec b
.data:00003e5b 05                               dec b
.data:00003e5c 02                               ld (bc),a
.data:00003e5d 3c                               inc a
.data:00003e5e c0                               ret nz
.data:00003e5f 2e c0                            ld l,0xc0
.data:00003e61 2e c0                            ld l,0xc0
.data:00003e63 2e c0                            ld l,0xc0
.data:00003e65 2e c0                            ld l,0xc0
.data:00003e67 2e 02                            ld l,0x02
.data:00003e69 34                               inc (hl)
.data:00003e6a 35                               dec (hl)
.data:00003e6b 35                               dec (hl)
.data:00003e6c 35                               dec (hl)
.data:00003e6d 35                               dec (hl)
.data:00003e6e 35                               dec (hl)
.data:00003e6f 35                               dec (hl)
.data:00003e70 02                               ld (bc),a
.data:00003e71 2e c0                            ld l,0xc0
.data:00003e73 2e c0                            ld l,0xc0
.data:00003e75 2e c0                            ld l,0xc0
.data:00003e77 2e c0                            ld l,0xc0
.data:00003e79 2e 3d                            ld l,0x3d
.data:00003e7b 2e 02                            ld l,0x02
.data:00003e7d c0                               ret nz
.data:00003e7e 00                               nop
.data:00003e7f c0                               ret nz
.data:00003e80 04                               inc b
.data:00003e81 0b                               dec bc
.data:00003e82 06 c0                            ld b,0xc0
.data:00003e84 01 c0 01                         ld bc,0x01c0
.data:00003e87 c0                               ret nz
.data:00003e88 03                               inc bc
.data:00003e89 34                               inc (hl)
.data:00003e8a 09                               add hl,bc
.data:00003e8b 50                               ld d,b
.data:00003e8c 39                               add hl,sp
.data:00003e8d 51                               ld d,c
.data:00003e8e 0a                               ld a,(bc)
.data:00003e8f 33                               inc sp
.data:00003e90 03                               inc bc
.data:00003e91 c0                               ret nz
.data:00003e92 01 c0 01                         ld bc,0x01c0
.data:00003e95 c0                               ret nz
.data:00003e96 04                               inc b
.data:00003e97 0b                               dec bc
.data:00003e98 06 c0                            ld b,0xc0
.data:00003e9a 00                               nop
.data:00003e9b c0                               ret nz
.data:00003e9c 02                               ld (bc),a
.data:00003e9d 2e 00                            ld l,0x00
.data:00003e9f 2e c0                            ld l,0xc0
.data:00003ea1 02                               ld (bc),a
.data:00003ea2 c0                               ret nz
.data:00003ea3 2e 02                            ld l,0x02
.data:00003ea5 2e 02                            ld l,0x02
.data:00003ea7 2e 34                            ld l,0x34
.data:00003ea9 35                               dec (hl)
.data:00003eaa 02                               ld (bc),a
.data:00003eab bf                               cp a
.data:00003eac bf                               cp a
.data:00003ead bf                               cp a
.data:00003eae 02                               ld (bc),a
.data:00003eaf 33                               inc sp
.data:00003eb0 35                               dec (hl)
.data:00003eb1 2e 02                            ld l,0x02
.data:00003eb3 2e 02                            ld l,0x02
.data:00003eb5 2e c0                            ld l,0xc0
.data:00003eb7 02                               ld (bc),a
.data:00003eb8 c0                               ret nz
.data:00003eb9 2e 00                            ld l,0x00
.data:00003ebb 2e 02                            ld l,0x02
.data:00003ebd c0                               ret nz
.data:00003ebe 00                               nop
.data:00003ebf 00                               nop
.data:00003ec0 2e 03                            ld l,0x03
.data:00003ec2 2e 04                            ld l,0x04
.data:00003ec4 08                               ex af,af'
.data:00003ec5 c0                               ret nz
.data:00003ec6 07                               rlca
.data:00003ec7 06 34                            ld b,0x34
.data:00003ec9 04                               inc b
.data:00003eca 0c                               inc c
.data:00003ecb 05                               dec b
.data:00003ecc 05                               dec b
.data:00003ecd 05                               dec b
.data:00003ece 0c                               inc c
.data:00003ecf 06 33                            ld b,0x33
.data:00003ed1 04                               inc b
.data:00003ed2 08                               ex af,af'
.data:00003ed3 c0                               ret nz
.data:00003ed4 07                               rlca
.data:00003ed5 06 2e                            ld b,0x2e
.data:00003ed7 03                               inc bc
.data:00003ed8 2e 00                            ld l,0x00
.data:00003eda 00                               nop
.data:00003edb c0                               ret nz
.data:00003edc 02                               ld (bc),a
.data:00003edd 2e c0                            ld l,0xc0
.data:00003edf 2e c0                            ld l,0xc0
.data:00003ee1 2e c0                            ld l,0xc0
.data:00003ee3 2e c0                            ld l,0xc0
.data:00003ee5 2e c0                            ld l,0xc0
.data:00003ee7 2e 36                            ld l,0x36
.data:00003ee9 36 36                            ld (hl),0x36
.data:00003eeb 34                               inc (hl)
.data:00003eec c0                               ret nz
.data:00003eed 36 36                            ld (hl),0x36
.data:00003eef 36 33                            ld (hl),0x33
.data:00003ef1 2e c0                            ld l,0xc0
.data:00003ef3 2e c0                            ld l,0xc0
.data:00003ef5 2e c0                            ld l,0xc0
.data:00003ef7 2e c0                            ld l,0xc0
.data:00003ef9 2e c0                            ld l,0xc0
.data:00003efb 2e 02                            ld l,0x02
.data:00003efd c0                               ret nz
.data:00003efe 04                               inc b
.data:00003eff 0a                               ld a,(bc)
.data:00003f00 2e 04                            ld l,0x04
.data:00003f02 05                               dec b
.data:00003f03 05                               dec b
.data:00003f04 0a                               ld a,(bc)
.data:00003f05 c0                               ret nz
.data:00003f06 01 c0 04                         ld bc,0x04c0
.data:00003f09 05                               dec b
.data:00003f0a 0a                               ld a,(bc)
.data:00003f0b c0                               ret nz
.data:00003f0c 00                               nop
.data:00003f0d c0                               ret nz
.data:00003f0e 09                               add hl,bc
.data:00003f0f 05                               dec b
.data:00003f10 06 c0                            ld b,0xc0
.data:00003f12 01 c0 09                         ld bc,0x09c0
.data:00003f15 05                               dec b
.data:00003f16 05                               dec b
.data:00003f17 06 2e                            ld b,0x2e
.data:00003f19 09                               add hl,bc
.data:00003f1a 06 c0                            ld b,0xc0
.data:00003f1c 02                               ld (bc),a
.data:00003f1d 2e c0                            ld l,0xc0
.data:00003f1f 02                               ld (bc),a
.data:00003f20 c0                               ret nz
.data:00003f21 2e c0                            ld l,0xc0
.data:00003f23 2e 03                            ld l,0x03
.data:00003f25 2e 02                            ld l,0x02
.data:00003f27 2e c0                            ld l,0xc0
.data:00003f29 2e 03                            ld l,0x03
.data:00003f2b 2e 3c                            ld l,0x3c
.data:00003f2d 2e 03                            ld l,0x03
.data:00003f2f 2e c0                            ld l,0xc0
.data:00003f31 2e 02                            ld l,0x02
.data:00003f33 2e 03                            ld l,0x03
.data:00003f35 2e c0                            ld l,0xc0
.data:00003f37 2e c0                            ld l,0xc0
.data:00003f39 02                               ld (bc),a
.data:00003f3a c0                               ret nz
.data:00003f3b 2e 0c                            ld l,0x0c
.data:00003f3d 06 2e                            ld b,0x2e
.data:00003f3f 02                               ld (bc),a
.data:00003f40 2e 04                            ld l,0x04
.data:00003f42 06 c0                            ld b,0xc0
.data:00003f44 2e c0                            ld l,0xc0
.data:00003f46 03                               inc bc
.data:00003f47 c0                               ret nz
.data:00003f48 01 c0 2e                         ld bc,0x2ec0
.data:00003f4b c0                               ret nz
.data:00003f4c 00                               nop
.data:00003f4d c0                               ret nz
.data:00003f4e 2e c0                            ld l,0xc0
.data:00003f50 01 c0 03                         ld bc,0x03c0
.data:00003f53 c0                               ret nz
.data:00003f54 2e c0                            ld l,0xc0
.data:00003f56 04                               inc b
.data:00003f57 06 2e                            ld b,0x2e
.data:00003f59 02                               ld (bc),a
.data:00003f5a 2e 04                            ld l,0x04
.data:00003f5c 2e c0                            ld l,0xc0
.data:00003f5e c0                               ret nz
.data:00003f5f 02                               ld (bc),a
.data:00003f60 c0                               ret nz
.data:00003f61 2e c0                            ld l,0xc0
.data:00003f63 2e 00                            ld l,0x00
.data:00003f65 2e c0                            ld l,0xc0
.data:00003f67 2e 07                            ld l,0x07
.data:00003f69 05                               dec b
.data:00003f6a 06 2e                            ld b,0x2e
.data:00003f6c 3e 2e                            ld a,0x2e
.data:00003f6e 04                               inc b
.data:00003f6f 05                               dec b
.data:00003f70 08                               ex af,af'
.data:00003f71 2e c0                            ld l,0xc0
.data:00003f73 2e 00                            ld l,0x00
.data:00003f75 2e c0                            ld l,0xc0
.data:00003f77 2e c0                            ld l,0xc0
.data:00003f79 02                               ld (bc),a
.data:00003f7a c0                               ret nz
.data:00003f7b c0                               ret nz
.data:00003f7c 0b                               dec bc
.data:00003f7d 06 2e                            ld b,0x2e
.data:00003f7f 02                               ld (bc),a
.data:00003f80 2e 04                            ld l,0x04
.data:00003f82 06 c0                            ld b,0xc0
.data:00003f84 2e c0                            ld l,0xc0
.data:00003f86 01 c0 2e                         ld bc,0x2ec0
.data:00003f89 c0                               ret nz
.data:00003f8a 2e c0                            ld l,0xc0
.data:00003f8c 01 c0 2e                         ld bc,0x2ec0
.data:00003f8f c0                               ret nz
.data:00003f90 2e c0                            ld l,0xc0
.data:00003f92 01 c0 2e                         ld bc,0x2ec0
.data:00003f95 c0                               ret nz
.data:00003f96 04                               inc b
.data:00003f97 06 2e                            ld b,0x2e
.data:00003f99 02                               ld (bc),a
.data:00003f9a 2e 04                            ld l,0x04
.data:00003f9c 02                               ld (bc),a
.data:00003f9d c0                               ret nz
.data:00003f9e c0                               ret nz
.data:00003f9f 02                               ld (bc),a
.data:00003fa0 c0                               ret nz
.data:00003fa1 2e c0                            ld l,0xc0
.data:00003fa3 2e 01                            ld l,0x01
.data:00003fa5 2e 02                            ld l,0x02
.data:00003fa7 2e 00                            ld l,0x00
.data:00003fa9 c0                               ret nz
.data:00003faa 04                               inc b
.data:00003fab 05                               dec b
.data:00003fac 0c                               inc c
.data:00003fad 05                               dec b
.data:00003fae 06 c0                            ld b,0xc0
.data:00003fb0 00                               nop
.data:00003fb1 2e 02                            ld l,0x02
.data:00003fb3 2e 01                            ld l,0x01
.data:00003fb5 2e c0                            ld l,0xc0
.data:00003fb7 2e c0                            ld l,0xc0
.data:00003fb9 02                               ld (bc),a
.data:00003fba c0                               ret nz
.data:00003fbb c0                               ret nz
.data:00003fbc 02                               ld (bc),a
.data:00003fbd 2e 04                            ld l,0x04
.data:00003fbf 08                               ex af,af'
.data:00003fc0 2e 04                            ld l,0x04
.data:00003fc2 05                               dec b
.data:00003fc3 05                               dec b
.data:00003fc4 08                               ex af,af'
.data:00003fc5 c0                               ret nz
.data:00003fc6 03                               inc bc
.data:00003fc7 c0                               ret nz
.data:00003fc8 2e c0                            ld l,0xc0
.data:00003fca 52                               ld d,d
.data:00003fcb 3a 3a 3a                         ld a,(0x3a3a)
.data:00003fce 53                               ld d,e
.data:00003fcf c0                               ret nz
.data:00003fd0 2e c0                            ld l,0xc0
.data:00003fd2 03                               inc bc
.data:00003fd3 c0                               ret nz
.data:00003fd4 07                               rlca
.data:00003fd5 05                               dec b
.data:00003fd6 05                               dec b
.data:00003fd7 06 2e                            ld b,0x2e
.data:00003fd9 07                               rlca
.data:00003fda 06 2e                            ld b,0x2e
.data:00003fdc 02                               ld (bc),a
.data:00003fdd c0                               ret nz
.data:00003fde 2e c0                            ld l,0xc0
.data:00003fe0 c0                               ret nz
.data:00003fe1 2e c0                            ld l,0xc0
.data:00003fe3 2e c0                            ld l,0xc0
.data:00003fe5 2e c0                            ld l,0xc0
.data:00003fe7 2e 04                            ld l,0x04
.data:00003fe9 05                               dec b
.data:00003fea 05                               dec b
.data:00003feb 0b                               dec bc
.data:00003fec 05                               dec b
.data:00003fed 0b                               dec bc
.data:00003fee 05                               dec b
.data:00003fef 05                               dec b
.data:00003ff0 06 c0                            ld b,0xc0
.data:00003ff2 2e c0                            ld l,0xc0
.data:00003ff4 2e c0                            ld l,0xc0
.data:00003ff6 2e c0                            ld l,0xc0
.data:00003ff8 2e c0                            ld l,0xc0
.data:00003ffa 2e c0                            ld l,0xc0
.data:00003ffc 02                               ld (bc),a
.data:00003ffd 2e 00                            ld l,0x00
.data:00003fff 00                               nop
.data:00004000 00                               nop
.data:00004001 c0                               ret nz
.data:00004002 00                               nop
.data:00004003 00                               nop
.data:00004004 00                               nop
.data:00004005 c0                               ret nz
.data:00004006 01 c0 c0                         ld bc,0xc0c0
.data:00004009 2e c0                            ld l,0xc0
.data:0000400b 07                               rlca
.data:0000400c 0b                               dec bc
.data:0000400d 08                               ex af,af'
.data:0000400e c0                               ret nz
.data:0000400f 2e c0                            ld l,0xc0
.data:00004011 2e 01                            ld l,0x01
.data:00004013 c0                               ret nz
.data:00004014 00                               nop
.data:00004015 00                               nop
.data:00004016 00                               nop
.data:00004017 c0                               ret nz
.data:00004018 00                               nop
.data:00004019 00                               nop
.data:0000401a 00                               nop
.data:0000401b 2e 02                            ld l,0x02
.data:0000401d 3d                               dec a
.data:0000401e 00                               nop
.data:0000401f 00                               nop
.data:00004020 00                               nop
.data:00004021 c0                               ret nz
.data:00004022 00                               nop
.data:00004023 00                               nop
.data:00004024 00                               nop
.data:00004025 c0                               ret nz
.data:00004026 07                               rlca
.data:00004027 05                               dec b
.data:00004028 05                               dec b
.data:00004029 06 2e                            ld b,0x2e
.data:0000402b c0                               ret nz
.data:0000402c 03                               inc bc
.data:0000402d c0                               ret nz
.data:0000402e 2e 04                            ld l,0x04
.data:00004030 05                               dec b
.data:00004031 05                               dec b
.data:00004032 08                               ex af,af'
.data:00004033 c0                               ret nz
.data:00004034 00                               nop
.data:00004035 00                               nop
.data:00004036 00                               nop
.data:00004037 c0                               ret nz
.data:00004038 00                               nop
.data:00004039 00                               nop
.data:0000403a 00                               nop
.data:0000403b c0                               ret nz
.data:0000403c 02                               ld (bc),a
.data:0000403d 2e c0                            ld l,0xc0
.data:0000403f 2e c0                            ld l,0xc0
.data:00004041 2e c0                            ld l,0xc0
.data:00004043 2e c0                            ld l,0xc0
.data:00004045 2e c0                            ld l,0xc0
.data:00004047 2e c0                            ld l,0xc0
.data:00004049 2e c0                            ld l,0xc0
.data:0000404b 2e c0                            ld l,0xc0
.data:0000404d 2e c0                            ld l,0xc0
.data:0000404f 2e c0                            ld l,0xc0
.data:00004051 2e c0                            ld l,0xc0
.data:00004053 2e c0                            ld l,0xc0
.data:00004055 2e c0                            ld l,0xc0
.data:00004057 2e c0                            ld l,0xc0
.data:00004059 2e c0                            ld l,0xc0
.data:0000405b 3c                               inc a
.data:0000405c 07                               rlca
.data:0000405d 05                               dec b
.data:0000405e 05                               dec b
.data:0000405f 05                               dec b
.data:00004060 05                               dec b
.data:00004061 05                               dec b
.data:00004062 05                               dec b
.data:00004063 05                               dec b
.data:00004064 05                               dec b
.data:00004065 05                               dec b
.data:00004066 05                               dec b
.data:00004067 05                               dec b
.data:00004068 05                               dec b
.data:00004069 05                               dec b
.data:0000406a 05                               dec b
.data:0000406b 05                               dec b
.data:0000406c 05                               dec b
.data:0000406d 05                               dec b
.data:0000406e 05                               dec b
.data:0000406f 05                               dec b
.data:00004070 05                               dec b
.data:00004071 05                               dec b
.data:00004072 05                               dec b
.data:00004073 05                               dec b
.data:00004074 05                               dec b
.data:00004075 05                               dec b
.data:00004076 05                               dec b
.data:00004077 05                               dec b
.data:00004078 05                               dec b
.data:00004079 05                               dec b
.data:0000407a 05                               dec b
.data:0000407b 05                               dec b
.data:0000407c 2b                               dec hl
.data:0000407d 25                               dec h
.data:0000407e 25                               dec h
.data:0000407f 4a                               ld c,d
.data:00004080 4b                               ld c,e
.data:00004081 25                               dec h
.data:00004082 25                               dec h
.data:00004083 25                               dec h
.data:00004084 47                               ld b,a
.data:00004085 48                               ld c,b
.data:00004086 25                               dec h
.data:00004087 25                               dec h
.data:00004088 25                               dec h
.data:00004089 4a                               ld c,d
.data:0000408a 4b                               ld c,e
.data:0000408b 25                               dec h
.data:0000408c 25                               dec h
.data:0000408d 25                               dec h
.data:0000408e 47                               ld b,a
.data:0000408f 48                               ld c,b
.data:00004090 25                               dec h
.data:00004091 25                               dec h
.data:00004092 25                               dec h
.data:00004093 4a                               ld c,d
.data:00004094 4b                               ld c,e
.data:00004095 25                               dec h
.data:00004096 25                               dec h
.data:00004097 25                               dec h
.data:00004098 47                               ld b,a
.data:00004099 48                               ld c,b
.data:0000409a 25                               dec h
.data:0000409b 25                               dec h
.data:0000409c 22 bf 3f                         ld (0x3fbf),hl
.data:0000409f 43                               ld b,e
.data:000040a0 44                               ld b,h
.data:000040a1 3f                               ccf
.data:000040a2 bf                               cp a
.data:000040a3 3f                               ccf
.data:000040a4 49                               ld c,c
.data:000040a5 45                               ld b,l
.data:000040a6 3f                               ccf
.data:000040a7 bf                               cp a
.data:000040a8 3f                               ccf
.data:000040a9 43                               ld b,e
.data:000040aa 44                               ld b,h
.data:000040ab 3f                               ccf
.data:000040ac bf                               cp a
.data:000040ad 3f                               ccf
.data:000040ae 49                               ld c,c
.data:000040af 45                               ld b,l
.data:000040b0 3f                               ccf
.data:000040b1 bf                               cp a
.data:000040b2 3f                               ccf
.data:000040b3 43                               ld b,e
.data:000040b4 44                               ld b,h
.data:000040b5 2d                               dec l
.data:000040b6 bf                               cp a
.data:000040b7 3f                               ccf
.data:000040b8 49                               ld c,c
.data:000040b9 45                               ld b,l
.data:000040ba 3f                               ccf
.data:000040bb bf                               cp a
.data:000040bc 22 2d 29                         ld (0x292d),hl
.data:000040bf 25                               dec h
.data:000040c0 25                               dec h
.data:000040c1 2a 2d 29                         ld hl,(0x292d)
.data:000040c4 25                               dec h
.data:000040c5 25                               dec h
.data:000040c6 2a 2d 29                         ld hl,(0x292d)
.data:000040c9 25                               dec h
.data:000040ca 25                               dec h
.data:000040cb 2a 2d 29                         ld hl,(0x292d)
.data:000040ce 25                               dec h
.data:000040cf 25                               dec h
.data:000040d0 2a 2d 29                         ld hl,(0x292d)
.data:000040d3 25                               dec h
.data:000040d4 25                               dec h
.data:000040d5 2a 2d 29                         ld hl,(0x292d)
.data:000040d8 25                               dec h
.data:000040d9 25                               dec h
.data:000040da 2a 2d 23                         ld hl,(0x232d)
.data:000040dd bf                               cp a
.data:000040de 27                               daa
.data:000040df 25                               dec h
.data:000040e0 25                               dec h
.data:000040e1 28 3f                            jr z,0x4122
.data:000040e3 27                               daa
.data:000040e4 25                               dec h
.data:000040e5 25                               dec h
.data:000040e6 28 bf                            jr z,0x40a7
.data:000040e8 27                               daa
.data:000040e9 25                               dec h
.data:000040ea 25                               dec h
.data:000040eb 28 bf                            jr z,0x40ac
.data:000040ed 27                               daa
.data:000040ee 25                               dec h
.data:000040ef 25                               dec h
.data:000040f0 28 bf                            jr z,0x40b1
.data:000040f2 27                               daa
.data:000040f3 25                               dec h
.data:000040f4 25                               dec h
.data:000040f5 28 bf                            jr z,0x40b6
.data:000040f7 27                               daa
.data:000040f8 25                               dec h
.data:000040f9 25                               dec h
.data:000040fa 28 bf                            jr z,0x40bb
.data:000040fc bf                               cp a
.data:000040fd 2d                               dec l
.data:000040fe bf                               cp a
.data:000040ff 2d                               dec l
.data:00004100 bf                               cp a
.data:00004101 2d                               dec l
.data:00004102 bf                               cp a
.data:00004103 2d                               dec l
.data:00004104 bf                               cp a
.data:00004105 2d                               dec l
.data:00004106 bf                               cp a
.data:00004107 2d                               dec l
.data:00004108 bf                               cp a
.data:00004109 2d                               dec l
.data:0000410a bf                               cp a
.data:0000410b 2d                               dec l
.data:0000410c bf                               cp a
.data:0000410d 2d                               dec l
.data:0000410e bf                               cp a
.data:0000410f 2d                               dec l
.data:00004110 bf                               cp a
.data:00004111 2d                               dec l
.data:00004112 3f                               ccf
.data:00004113 2d                               dec l
.data:00004114 bf                               cp a
.data:00004115 2d                               dec l
.data:00004116 bf                               cp a
.data:00004117 2d                               dec l
.data:00004118 3c                               inc a
.data:00004119 34                               inc (hl)
.data:0000411a 35                               dec (hl)
.data:0000411b 35                               dec (hl)
.data:0000411c 29                               add hl,hl
.data:0000411d 25                               dec h
.data:0000411e 25                               dec h
.data:0000411f 25                               dec h
.data:00004120 25                               dec h
.data:00004121 26 37                            ld h,0x37
.data:00004123 24                               inc h
.data:00004124 25                               dec h
.data:00004125 25                               dec h
.data:00004126 25                               dec h
.data:00004127 25                               dec h
.data:00004128 25                               dec h
.data:00004129 2a bf 21                         ld hl,(0x21bf)
.data:0000412c 54                               ld d,h
.data:0000412d 55                               ld d,l
.data:0000412e 21 bf 29                         ld hl,0x29bf
.data:00004131 25                               dec h
.data:00004132 25                               dec h
.data:00004133 2a 2d 29                         ld hl,(0x292d)
.data:00004136 25                               dec h
.data:00004137 25                               dec h
.data:00004138 2a 34 20                         ld hl,(0x2034)
.data:0000413b 33                               inc sp
.data:0000413c 27                               daa
.data:0000413d 25                               dec h
.data:0000413e 25                               dec h
.data:0000413f 25                               dec h
.data:00004140 25                               dec h
.data:00004141 2a 37 29                         ld hl,(0x2937)
.data:00004144 25                               dec h
.data:00004145 25                               dec h
.data:00004146 25                               dec h
.data:00004147 25                               dec h
.data:00004148 25                               dec h
.data:00004149 28 bf                            jr z,0x410a
.data:0000414b 23                               inc hl
.data:0000414c 56                               ld d,(hl)
.data:0000414d 57                               ld d,a
.data:0000414e 23                               inc hl
.data:0000414f bf                               cp a
.data:00004150 27                               daa
.data:00004151 25                               dec h
.data:00004152 25                               dec h
.data:00004153 28 bf                            jr z,0x4114
.data:00004155 27                               daa
.data:00004156 25                               dec h
.data:00004157 25                               dec h
.data:00004158 28 34                            jr z,0x418e
.data:0000415a 20 33                            jr nz,0x418f
.data:0000415c 2d                               dec l
.data:0000415d bf                               cp a
.data:0000415e 2d                               dec l
.data:0000415f bf                               cp a
.data:00004160 3d                               dec a
.data:00004161 22 37 22                         ld (0x2237),hl
.data:00004164 bf                               cp a
.data:00004165 2d                               dec l
.data:00004166 bf                               cp a
.data:00004167 2d                               dec l
.data:00004168 bf                               cp a
.data:00004169 2d                               dec l
.data:0000416a bf                               cp a
.data:0000416b 2d                               dec l
.data:0000416c bf                               cp a
.data:0000416d 2d                               dec l
.data:0000416e bf                               cp a
.data:0000416f 2d                               dec l
.data:00004170 bf                               cp a
.data:00004171 2d                               dec l
.data:00004172 bf                               cp a
.data:00004173 2d                               dec l
.data:00004174 bf                               cp a
.data:00004175 2d                               dec l
.data:00004176 bf                               cp a
.data:00004177 34                               inc (hl)
.data:00004178 35                               dec (hl)
.data:00004179 35                               dec (hl)
.data:0000417a 36 33                            ld (hl),0x33
.data:0000417c 25                               dec h
.data:0000417d 2a bf 29                         ld hl,(0x29bf)
.data:00004180 26 22                            ld h,0x22
.data:00004182 37                               scf
.data:00004183 22 24 25                         ld (0x2524),hl
.data:00004186 25                               dec h
.data:00004187 2a bf 29                         ld hl,(0x29bf)
.data:0000418a 25                               dec h
.data:0000418b 25                               dec h
.data:0000418c 2a bf 29                         ld hl,(0x29bf)
.data:0000418f 25                               dec h
.data:00004190 25                               dec h
.data:00004191 2a bf 29                         ld hl,(0x29bf)
.data:00004194 25                               dec h
.data:00004195 25                               dec h
.data:00004196 2a 34 20                         ld hl,(0x2034)
.data:00004199 33                               inc sp
.data:0000419a 29                               add hl,hl
.data:0000419b 25                               dec h
.data:0000419c 25                               dec h
.data:0000419d 28 2d                            jr z,0x41cc
.data:0000419f 27                               daa
.data:000041a0 25                               dec h
.data:000041a1 28 37                            jr z,0x41da
.data:000041a3 27                               daa
.data:000041a4 25                               dec h
.data:000041a5 25                               dec h
.data:000041a6 25                               dec h
.data:000041a7 28 bf                            jr z,0x4168
.data:000041a9 27                               daa
.data:000041aa 25                               dec h
.data:000041ab 25                               dec h
.data:000041ac 28 bf                            jr z,0x416d
.data:000041ae 27                               daa
.data:000041af 25                               dec h
.data:000041b0 25                               dec h
.data:000041b1 28 bf                            jr z,0x4172
.data:000041b3 27                               daa
.data:000041b4 25                               dec h
.data:000041b5 25                               dec h
.data:000041b6 28 34                            jr z,0x41ec
.data:000041b8 20 33                            jr nz,0x41ed
.data:000041ba 27                               daa
.data:000041bb 25                               dec h
.data:000041bc 2d                               dec l
.data:000041bd bf                               cp a
.data:000041be bf                               cp a
.data:000041bf 2d                               dec l
.data:000041c0 bf                               cp a
.data:000041c1 2d                               dec l
.data:000041c2 bf                               cp a
.data:000041c3 2d                               dec l
.data:000041c4 bf                               cp a
.data:000041c5 2d                               dec l
.data:000041c6 bf                               cp a
.data:000041c7 2d                               dec l
.data:000041c8 bf                               cp a
.data:000041c9 2d                               dec l
.data:000041ca bf                               cp a
.data:000041cb 2d                               dec l
.data:000041cc bf                               cp a
.data:000041cd 2d                               dec l
.data:000041ce bf                               cp a
.data:000041cf 2d                               dec l
.data:000041d0 bf                               cp a
.data:000041d1 2d                               dec l
.data:000041d2 bf                               cp a
.data:000041d3 2d                               dec l
.data:000041d4 bf                               cp a
.data:000041d5 36 36                            ld (hl),0x36
.data:000041d7 34                               inc (hl)
.data:000041d8 36 33                            ld (hl),0x33
.data:000041da bf                               cp a
.data:000041db 2d                               dec l
.data:000041dc bf                               cp a
.data:000041dd 29                               add hl,hl
.data:000041de 25                               dec h
.data:000041df 25                               dec h
.data:000041e0 2a bf 29                         ld hl,(0x29bf)
.data:000041e3 25                               dec h
.data:000041e4 25                               dec h
.data:000041e5 2a bf 29                         ld hl,(0x29bf)
.data:000041e8 25                               dec h
.data:000041e9 50                               ld d,b
.data:000041ea 38 38                            jr c,0x4224
.data:000041ec 38 51                            jr c,0x423f
.data:000041ee 25                               dec h
.data:000041ef 2a bf 29                         ld hl,(0x29bf)
.data:000041f2 25                               dec h
.data:000041f3 25                               dec h
.data:000041f4 2a 33 21                         ld hl,(0x2133)
.data:000041f7 34                               inc (hl)
.data:000041f8 29                               add hl,hl
.data:000041f9 25                               dec h
.data:000041fa 25                               dec h
.data:000041fb 2a 2d 27                         ld hl,(0x272d)
.data:000041fe 47                               ld b,a
.data:000041ff 48                               ld c,b
.data:00004200 28 2d                            jr z,0x422f
.data:00004202 27                               daa
.data:00004203 4a                               ld c,d
.data:00004204 4b                               ld c,e
.data:00004205 28 2d                            jr z,0x4234
.data:00004207 22 bf bf                         ld (0xbfbf),hl
.data:0000420a bf                               cp a
.data:0000420b bf                               cp a
.data:0000420c bf                               cp a
.data:0000420d bf                               cp a
.data:0000420e bf                               cp a
.data:0000420f 22 2d 27                         ld (0x272d),hl
.data:00004212 47                               ld b,a
.data:00004213 48                               ld c,b
.data:00004214 28 33                            jr z,0x4249
.data:00004216 22 34 27                         ld (0x2734),hl
.data:00004219 47                               ld b,a
.data:0000421a 48                               ld c,b
.data:0000421b 28 bf                            jr z,0x41dc
.data:0000421d 3f                               ccf
.data:0000421e 49                               ld c,c
.data:0000421f 45                               ld b,l
.data:00004220 3f                               ccf
.data:00004221 bf                               cp a
.data:00004222 3f                               ccf
.data:00004223 43                               ld b,e
.data:00004224 44                               ld b,h
.data:00004225 bf                               cp a
.data:00004226 bf                               cp a
.data:00004227 22 bf bf                         ld (0xbfbf),hl
.data:0000422a bf                               cp a
.data:0000422b bf                               cp a
.data:0000422c bf                               cp a
.data:0000422d bf                               cp a
.data:0000422e bf                               cp a
.data:0000422f 22 bf bf                         ld (0xbfbf),hl
.data:00004232 49                               ld c,c
.data:00004233 45                               ld b,l
.data:00004234 bf                               cp a
.data:00004235 33                               inc sp
.data:00004236 22 36 bf                         ld (0xbf36),hl
.data:00004239 49                               ld c,c
.data:0000423a 45                               ld b,l
.data:0000423b bf                               cp a
.data:0000423c 25                               dec h
.data:0000423d 25                               dec h
.data:0000423e 25                               dec h
.data:0000423f 25                               dec h
.data:00004240 25                               dec h
.data:00004241 25                               dec h
.data:00004242 25                               dec h
.data:00004243 25                               dec h
.data:00004244 25                               dec h
.data:00004245 25                               dec h
.data:00004246 25                               dec h
.data:00004247 2c                               inc l
.data:00004248 25                               dec h
.data:00004249 25                               dec h
.data:0000424a 25                               dec h
.data:0000424b 25                               dec h
.data:0000424c 25                               dec h
.data:0000424d 25                               dec h
.data:0000424e 25                               dec h
.data:0000424f 2c                               inc l
.data:00004250 25                               dec h
.data:00004251 25                               dec h
.data:00004252 25                               dec h
.data:00004253 25                               dec h
.data:00004254 25                               dec h
.data:00004255 25                               dec h
.data:00004256 2c                               inc l
.data:00004257 25                               dec h
.data:00004258 25                               dec h
.data:00004259 25                               dec h
.data:0000425a 25                               dec h
.data:0000425b 25                               dec h
.data:0000425c 1b                               dec de
.data:0000425d 15                               dec d
.data:0000425e 15                               dec d
.data:0000425f 15                               dec d
.data:00004260 15                               dec d
.data:00004261 15                               dec d
.data:00004262 15                               dec d
.data:00004263 15                               dec d
.data:00004264 15                               dec d
.data:00004265 15                               dec d
.data:00004266 15                               dec d
.data:00004267 15                               dec d
.data:00004268 15                               dec d
.data:00004269 15                               dec d
.data:0000426a 15                               dec d
.data:0000426b 15                               dec d
.data:0000426c 15                               dec d
.data:0000426d 15                               dec d
.data:0000426e 15                               dec d
.data:0000426f 15                               dec d
.data:00004270 15                               dec d
.data:00004271 15                               dec d
.data:00004272 15                               dec d
.data:00004273 15                               dec d
.data:00004274 15                               dec d
.data:00004275 15                               dec d
.data:00004276 15                               dec d
.data:00004277 15                               dec d
.data:00004278 15                               dec d
.data:00004279 15                               dec d
.data:0000427a 15                               dec d
.data:0000427b 15                               dec d
.data:0000427c 12                               ld (de),a
.data:0000427d 2d                               dec l
.data:0000427e bf                               cp a
.data:0000427f 2d                               dec l
.data:00004280 bf                               cp a
.data:00004281 2d                               dec l
.data:00004282 bf                               cp a
.data:00004283 2d                               dec l
.data:00004284 bf                               cp a
.data:00004285 2d                               dec l
.data:00004286 bf                               cp a
.data:00004287 2d                               dec l
.data:00004288 bf                               cp a
.data:00004289 2d                               dec l
.data:0000428a bf                               cp a
.data:0000428b 3d                               dec a
.data:0000428c 3f                               ccf
.data:0000428d 3e bf                            ld a,0xbf
.data:0000428f 2d                               dec l
.data:00004290 bf                               cp a
.data:00004291 2d                               dec l
.data:00004292 bf                               cp a
.data:00004293 2d                               dec l
.data:00004294 bf                               cp a
.data:00004295 2d                               dec l
.data:00004296 bf                               cp a
.data:00004297 2d                               dec l
.data:00004298 bf                               cp a
.data:00004299 2d                               dec l
.data:0000429a bf                               cp a
.data:0000429b 2d                               dec l
.data:0000429c 12                               ld (de),a
.data:0000429d bf                               cp a
.data:0000429e 14                               inc d
.data:0000429f 16 bf                            ld d,0xbf
.data:000042a1 11 bf 14                         ld de,0x14bf
.data:000042a4 16 bf                            ld d,0xbf
.data:000042a6 11 bf 14                         ld de,0x14bf
.data:000042a9 16 bf                            ld d,0xbf
.data:000042ab 11 bf 14                         ld de,0x14bf
.data:000042ae 16 bf                            ld d,0xbf
.data:000042b0 11 bf 14                         ld de,0x14bf
.data:000042b3 16 bf                            ld d,0xbf
.data:000042b5 11 bf 14                         ld de,0x14bf
.data:000042b8 16 bf                            ld d,0xbf
.data:000042ba 11 bf 12                         ld de,0x12bf
.data:000042bd 2d                               dec l
.data:000042be bf                               cp a
.data:000042bf 2d                               dec l
.data:000042c0 bf                               cp a
.data:000042c1 12                               ld (de),a
.data:000042c2 2d                               dec l
.data:000042c3 bf                               cp a
.data:000042c4 2d                               dec l
.data:000042c5 bf                               cp a
.data:000042c6 12                               ld (de),a
.data:000042c7 2d                               dec l
.data:000042c8 bf                               cp a
.data:000042c9 2d                               dec l
.data:000042ca bf                               cp a
.data:000042cb 12                               ld (de),a
.data:000042cc 2d                               dec l
.data:000042cd bf                               cp a
.data:000042ce 2d                               dec l
.data:000042cf bf                               cp a
.data:000042d0 12                               ld (de),a
.data:000042d1 2d                               dec l
.data:000042d2 bf                               cp a
.data:000042d3 2d                               dec l
.data:000042d4 bf                               cp a
.data:000042d5 12                               ld (de),a
.data:000042d6 2d                               dec l
.data:000042d7 bf                               cp a
.data:000042d8 2d                               dec l
.data:000042d9 bf                               cp a
.data:000042da 12                               ld (de),a
.data:000042db 2d                               dec l
.data:000042dc 12                               ld (de),a
.data:000042dd bf                               cp a
.data:000042de 14                               inc d
.data:000042df 15                               dec d
.data:000042e0 15                               dec d
.data:000042e1 18 bf                            jr 0x42a2
.data:000042e3 14                               inc d
.data:000042e4 15                               dec d
.data:000042e5 15                               dec d
.data:000042e6 18 bf                            jr 0x42a7
.data:000042e8 14                               inc d
.data:000042e9 15                               dec d
.data:000042ea 15                               dec d
.data:000042eb 18 bf                            jr 0x42ac
.data:000042ed 14                               inc d
.data:000042ee 15                               dec d
.data:000042ef 15                               dec d
.data:000042f0 18 bf                            jr 0x42b1
.data:000042f2 14                               inc d
.data:000042f3 15                               dec d
.data:000042f4 15                               dec d
.data:000042f5 18 bf                            jr 0x42b6
.data:000042f7 14                               inc d
.data:000042f8 15                               dec d
.data:000042f9 15                               dec d
.data:000042fa 18 bf                            jr 0x42bb
.data:000042fc 12                               ld (de),a
.data:000042fd 3d                               dec a
.data:000042fe bf                               cp a
.data:000042ff 2d                               dec l
.data:00004300 bf                               cp a
.data:00004301 2d                               dec l
.data:00004302 bf                               cp a
.data:00004303 2d                               dec l
.data:00004304 bf                               cp a
.data:00004305 2d                               dec l
.data:00004306 bf                               cp a
.data:00004307 2d                               dec l
.data:00004308 bf                               cp a
.data:00004309 2d                               dec l
.data:0000430a bf                               cp a
.data:0000430b 2d                               dec l
.data:0000430c bf                               cp a
.data:0000430d 2d                               dec l
.data:0000430e bf                               cp a
.data:0000430f 2d                               dec l
.data:00004310 bf                               cp a
.data:00004311 2d                               dec l
.data:00004312 bf                               cp a
.data:00004313 2d                               dec l
.data:00004314 bf                               cp a
.data:00004315 2d                               dec l
.data:00004316 bf                               cp a
.data:00004317 2d                               dec l
.data:00004318 bf                               cp a
.data:00004319 2d                               dec l
.data:0000431a bf                               cp a
.data:0000431b 3d                               dec a
.data:0000431c 1f                               rra
.data:0000431d 15                               dec d
.data:0000431e 15                               dec d
.data:0000431f 15                               dec d
.data:00004320 15                               dec d
.data:00004321 15                               dec d
.data:00004322 15                               dec d
.data:00004323 15                               dec d
.data:00004324 15                               dec d
.data:00004325 15                               dec d
.data:00004326 15                               dec d
.data:00004327 15                               dec d
.data:00004328 15                               dec d
.data:00004329 15                               dec d
.data:0000432a 15                               dec d
.data:0000432b 16 bf                            ld d,0xbf
.data:0000432d 14                               inc d
.data:0000432e 15                               dec d
.data:0000432f 15                               dec d
.data:00004330 15                               dec d
.data:00004331 15                               dec d
.data:00004332 15                               dec d
.data:00004333 15                               dec d
.data:00004334 15                               dec d
.data:00004335 15                               dec d
.data:00004336 15                               dec d
.data:00004337 15                               dec d
.data:00004338 15                               dec d
.data:00004339 15                               dec d
.data:0000433a 15                               dec d
.data:0000433b 15                               dec d
.data:0000433c 12                               ld (de),a
.data:0000433d 2d                               dec l
.data:0000433e bf                               cp a
.data:0000433f 2d                               dec l
.data:00004340 bf                               cp a
.data:00004341 2d                               dec l
.data:00004342 bf                               cp a
.data:00004343 2d                               dec l
.data:00004344 bf                               cp a
.data:00004345 2d                               dec l
.data:00004346 bf                               cp a
.data:00004347 2d                               dec l
.data:00004348 bf                               cp a
.data:00004349 2d                               dec l
.data:0000434a bf                               cp a
.data:0000434b 2d                               dec l
.data:0000434c bf                               cp a
.data:0000434d 2d                               dec l
.data:0000434e bf                               cp a
.data:0000434f 2d                               dec l
.data:00004350 bf                               cp a
.data:00004351 2d                               dec l
.data:00004352 bf                               cp a
.data:00004353 2d                               dec l
.data:00004354 bf                               cp a
.data:00004355 2d                               dec l
.data:00004356 bf                               cp a
.data:00004357 2d                               dec l
.data:00004358 bf                               cp a
.data:00004359 2d                               dec l
.data:0000435a bf                               cp a
.data:0000435b 2d                               dec l
.data:0000435c 12                               ld (de),a
.data:0000435d bf                               cp a
.data:0000435e 14                               inc d
.data:0000435f 16 bf                            ld d,0xbf
.data:00004361 11 bf 11                         ld de,0x11bf
.data:00004364 3f                               ccf
.data:00004365 14                               inc d
.data:00004366 16 bf                            ld d,0xbf
.data:00004368 14                               inc d
.data:00004369 16 bf                            ld d,0xbf
.data:0000436b 11 bf 11                         ld de,0x11bf
.data:0000436e bf                               cp a
.data:0000436f 14                               inc d
.data:00004370 16 bf                            ld d,0xbf
.data:00004372 14                               inc d
.data:00004373 16 bf                            ld d,0xbf
.data:00004375 11 bf 11                         ld de,0x11bf
.data:00004378 bf                               cp a
.data:00004379 14                               inc d
.data:0000437a 16 bf                            ld d,0xbf
.data:0000437c 12                               ld (de),a
.data:0000437d 3c                               inc a
.data:0000437e 2d                               dec l
.data:0000437f bf                               cp a
.data:00004380 2d                               dec l
.data:00004381 12                               ld (de),a
.data:00004382 2d                               dec l
.data:00004383 12                               ld (de),a
.data:00004384 2d                               dec l
.data:00004385 bf                               cp a
.data:00004386 2d                               dec l
.data:00004387 bf                               cp a
.data:00004388 2d                               dec l
.data:00004389 bf                               cp a
.data:0000438a 2d                               dec l
.data:0000438b 12                               ld (de),a
.data:0000438c bf                               cp a
.data:0000438d 12                               ld (de),a
.data:0000438e 2d                               dec l
.data:0000438f bf                               cp a
.data:00004390 2d                               dec l
.data:00004391 bf                               cp a
.data:00004392 2d                               dec l
.data:00004393 bf                               cp a
.data:00004394 2d                               dec l
.data:00004395 12                               ld (de),a
.data:00004396 2d                               dec l
.data:00004397 12                               ld (de),a
.data:00004398 2d                               dec l
.data:00004399 bf                               cp a
.data:0000439a 2d                               dec l
.data:0000439b 3c                               inc a
.data:0000439c 12                               ld (de),a
.data:0000439d 2d                               dec l
.data:0000439e 14                               inc d
.data:0000439f 15                               dec d
.data:000043a0 15                               dec d
.data:000043a1 18 bf                            jr 0x4362
.data:000043a3 17                               rla
.data:000043a4 15                               dec d
.data:000043a5 15                               dec d
.data:000043a6 16 2d                            ld d,0x2d
.data:000043a8 14                               inc d
.data:000043a9 15                               dec d
.data:000043aa 15                               dec d
.data:000043ab 18 bf                            jr 0x436c
.data:000043ad 17                               rla
.data:000043ae 15                               dec d
.data:000043af 15                               dec d
.data:000043b0 16 bf                            ld d,0xbf
.data:000043b2 14                               inc d
.data:000043b3 15                               dec d
.data:000043b4 15                               dec d
.data:000043b5 18 bf                            jr 0x4376
.data:000043b7 17                               rla
.data:000043b8 15                               dec d
.data:000043b9 15                               dec d
.data:000043ba 16 bf                            ld d,0xbf
.data:000043bc 12                               ld (de),a
.data:000043bd bf                               cp a
.data:000043be 2d                               dec l
.data:000043bf bf                               cp a
.data:000043c0 2d                               dec l
.data:000043c1 bf                               cp a
.data:000043c2 2d                               dec l
.data:000043c3 bf                               cp a
.data:000043c4 2d                               dec l
.data:000043c5 bf                               cp a
.data:000043c6 2d                               dec l
.data:000043c7 bf                               cp a
.data:000043c8 2d                               dec l
.data:000043c9 bf                               cp a
.data:000043ca 2d                               dec l
.data:000043cb bf                               cp a
.data:000043cc bf                               cp a
.data:000043cd bf                               cp a
.data:000043ce 2d                               dec l
.data:000043cf bf                               cp a
.data:000043d0 2d                               dec l
.data:000043d1 bf                               cp a
.data:000043d2 2d                               dec l
.data:000043d3 bf                               cp a
.data:000043d4 2d                               dec l
.data:000043d5 bf                               cp a
.data:000043d6 2d                               dec l
.data:000043d7 3f                               ccf
.data:000043d8 2d                               dec l
.data:000043d9 bf                               cp a
.data:000043da 2d                               dec l
.data:000043db bf                               cp a
.data:000043dc 1c                               inc e
.data:000043dd 15                               dec d
.data:000043de 15                               dec d
.data:000043df 15                               dec d
.data:000043e0 15                               dec d
.data:000043e1 15                               dec d
.data:000043e2 15                               dec d
.data:000043e3 15                               dec d
.data:000043e4 15                               dec d
.data:000043e5 15                               dec d
.data:000043e6 16 2d                            ld d,0x2d
.data:000043e8 24                               inc h
.data:000043e9 47                               ld b,a
.data:000043ea 48                               ld c,b
.data:000043eb 50                               ld d,b
.data:000043ec 38 51                            jr c,0x443f
.data:000043ee 4a                               ld c,d
.data:000043ef 4b                               ld c,e
.data:000043f0 26 2d                            ld h,0x2d
.data:000043f2 14                               inc d
.data:000043f3 15                               dec d
.data:000043f4 15                               dec d
.data:000043f5 15                               dec d
.data:000043f6 15                               dec d
.data:000043f7 15                               dec d
.data:000043f8 15                               dec d
.data:000043f9 15                               dec d
.data:000043fa 15                               dec d
.data:000043fb 15                               dec d
.data:000043fc 3a 3a 3a                         ld a,(0x3a3a)
.data:000043ff 3a 3a 3a                         ld a,(0x3a3a)
.data:00004402 3a 3a 3a                         ld a,(0x3a3a)
.data:00004405 53                               ld d,e
.data:00004406 3f                               ccf
.data:00004407 bf                               cp a
.data:00004408 3f                               ccf
.data:00004409 49                               ld c,c
.data:0000440a 45                               ld b,l
.data:0000440b bf                               cp a
.data:0000440c 2d                               dec l
.data:0000440d bf                               cp a
.data:0000440e 43                               ld b,e
.data:0000440f 44                               ld b,h
.data:00004410 bf                               cp a
.data:00004411 bf                               cp a
.data:00004412 bf                               cp a
.data:00004413 52                               ld d,d
.data:00004414 3a 3a 3a                         ld a,(0x3a3a)
.data:00004417 3a 3a 3a                         ld a,(0x3a3a)
.data:0000441a 3a 3a 15                         ld a,(0x153a)
.data:0000441d 15                               dec d
.data:0000441e 15                               dec d
.data:0000441f 15                               dec d
.data:00004420 15                               dec d
.data:00004421 15                               dec d
.data:00004422 15                               dec d
.data:00004423 15                               dec d
.data:00004424 15                               dec d
.data:00004425 15                               dec d
.data:00004426 15                               dec d
.data:00004427 15                               dec d
.data:00004428 15                               dec d
.data:00004429 15                               dec d
.data:0000442a 15                               dec d
.data:0000442b 15                               dec d
.data:0000442c 15                               dec d
.data:0000442d 15                               dec d
.data:0000442e 15                               dec d
.data:0000442f 15                               dec d
.data:00004430 15                               dec d
.data:00004431 15                               dec d
.data:00004432 15                               dec d
.data:00004433 15                               dec d
.data:00004434 15                               dec d
.data:00004435 15                               dec d
.data:00004436 15                               dec d
.data:00004437 15                               dec d
.data:00004438 15                               dec d
.data:00004439 15                               dec d
.data:0000443a 15                               dec d
.data:0000443b 15                               dec d
.data:0000443c 19                               add hl,de
.data:0000443d 15                               dec d
.data:0000443e 15                               dec d
.data:0000443f 15                               dec d
.data:00004440 15                               dec d
.data:00004441 15                               dec d
.data:00004442 15                               dec d
.data:00004443 15                               dec d
.data:00004444 15                               dec d
.data:00004445 15                               dec d
.data:00004446 15                               dec d
.data:00004447 15                               dec d
.data:00004448 15                               dec d
.data:00004449 15                               dec d
.data:0000444a 15                               dec d
.data:0000444b 15                               dec d
.data:0000444c 15                               dec d
.data:0000444d 15                               dec d
.data:0000444e 1a                               ld a,(de)
.data:0000444f 42                               ld b,d
.data:00004450 58                               ld e,b
.data:00004451 19                               add hl,de
.data:00004452 15                               dec d
.data:00004453 15                               dec d
.data:00004454 15                               dec d
.data:00004455 15                               dec d
.data:00004456 15                               dec d
.data:00004457 15                               dec d
.data:00004458 15                               dec d
.data:00004459 15                               dec d
.data:0000445a 1a                               ld a,(de)
.data:0000445b 42                               ld b,d
.data:0000445c 12                               ld (de),a
.data:0000445d bf                               cp a
.data:0000445e 2d                               dec l
.data:0000445f bf                               cp a
.data:00004460 2d                               dec l
.data:00004461 bf                               cp a
.data:00004462 2d                               dec l
.data:00004463 bf                               cp a
.data:00004464 2d                               dec l
.data:00004465 3f                               ccf
.data:00004466 2d                               dec l
.data:00004467 bf                               cp a
.data:00004468 2d                               dec l
.data:00004469 bf                               cp a
.data:0000446a 2d                               dec l
.data:0000446b bf                               cp a
.data:0000446c 2d                               dec l
.data:0000446d bf                               cp a
.data:0000446e 12                               ld (de),a
.data:0000446f 42                               ld b,d
.data:00004470 42                               ld b,d
.data:00004471 12                               ld (de),a
.data:00004472 2d                               dec l
.data:00004473 bf                               cp a
.data:00004474 2d                               dec l
.data:00004475 bf                               cp a
.data:00004476 2d                               dec l
.data:00004477 bf                               cp a
.data:00004478 2d                               dec l
.data:00004479 bf                               cp a
.data:0000447a 12                               ld (de),a
.data:0000447b 42                               ld b,d
.data:0000447c 12                               ld (de),a
.data:0000447d 3f                               ccf
.data:0000447e 11 2d 11                         ld de,0x112d
.data:00004481 2d                               dec l
.data:00004482 19                               add hl,de
.data:00004483 15                               dec d
.data:00004484 1a                               ld a,(de)
.data:00004485 2d                               dec l
.data:00004486 14                               inc d
.data:00004487 15                               dec d
.data:00004488 15                               dec d
.data:00004489 1b                               dec de
.data:0000448a 15                               dec d
.data:0000448b 15                               dec d
.data:0000448c 16 2d                            ld d,0x2d
.data:0000448e 12                               ld (de),a
.data:0000448f 5a                               ld e,d
.data:00004490 42                               ld b,d
.data:00004491 12                               ld (de),a
.data:00004492 bf                               cp a
.data:00004493 19                               add hl,de
.data:00004494 16 2d                            ld d,0x2d
.data:00004496 14                               inc d
.data:00004497 15                               dec d
.data:00004498 1a                               ld a,(de)
.data:00004499 2d                               dec l
.data:0000449a 12                               ld (de),a
.data:0000449b 42                               ld b,d
.data:0000449c 12                               ld (de),a
.data:0000449d 37                               scf
.data:0000449e 12                               ld (de),a
.data:0000449f bf                               cp a
.data:000044a0 13                               inc de
.data:000044a1 bf                               cp a
.data:000044a2 12                               ld (de),a
.data:000044a3 3f                               ccf
.data:000044a4 12                               ld (de),a
.data:000044a5 bf                               cp a
.data:000044a6 36 36                            ld (hl),0x36
.data:000044a8 34                               inc (hl)
.data:000044a9 13                               inc de
.data:000044aa 36 36                            ld (hl),0x36
.data:000044ac 36 3f                            ld (hl),0x3f
.data:000044ae 12                               ld (de),a
.data:000044af 42                               ld b,d
.data:000044b0 42                               ld b,d
.data:000044b1 12                               ld (de),a
.data:000044b2 2d                               dec l
.data:000044b3 12                               ld (de),a
.data:000044b4 2d                               dec l
.data:000044b5 bf                               cp a
.data:000044b6 2d                               dec l
.data:000044b7 bf                               cp a
.data:000044b8 12                               ld (de),a
.data:000044b9 bf                               cp a
.data:000044ba 12                               ld (de),a
.data:000044bb 42                               ld b,d
.data:000044bc 12                               ld (de),a
.data:000044bd 37                               scf
.data:000044be 12                               ld (de),a
.data:000044bf 2d                               dec l
.data:000044c0 3f                               ccf
.data:000044c1 2d                               dec l
.data:000044c2 17                               rla
.data:000044c3 15                               dec d
.data:000044c4 18 2d                            jr 0x44f3
.data:000044c6 14                               inc d
.data:000044c7 16 34                            ld d,0x34
.data:000044c9 3e 33                            ld a,0x33
.data:000044cb 14                               inc d
.data:000044cc 16 2d                            ld d,0x2d
.data:000044ce 12                               ld (de),a
.data:000044cf 42                               ld b,d
.data:000044d0 58                               ld e,b
.data:000044d1 12                               ld (de),a
.data:000044d2 bf                               cp a
.data:000044d3 17                               rla
.data:000044d4 15                               dec d
.data:000044d5 16 bf                            ld d,0xbf
.data:000044d7 14                               inc d
.data:000044d8 18 2d                            jr 0x4507
.data:000044da 12                               ld (de),a
.data:000044db 42                               ld b,d
.data:000044dc 12                               ld (de),a
.data:000044dd 37                               scf
.data:000044de 12                               ld (de),a
.data:000044df bf                               cp a
.data:000044e0 11 bf 2d                         ld de,0x2dbf
.data:000044e3 bf                               cp a
.data:000044e4 2d                               dec l
.data:000044e5 bf                               cp a
.data:000044e6 35                               dec (hl)
.data:000044e7 35                               dec (hl)
.data:000044e8 35                               dec (hl)
.data:000044e9 11 33 35                         ld de,0x3533
.data:000044ec 35                               dec (hl)
.data:000044ed 3f                               ccf
.data:000044ee 12                               ld (de),a
.data:000044ef 42                               ld b,d
.data:000044f0 42                               ld b,d
.data:000044f1 12                               ld (de),a
.data:000044f2 2d                               dec l
.data:000044f3 bf                               cp a
.data:000044f4 2d                               dec l
.data:000044f5 bf                               cp a
.data:000044f6 2d                               dec l
.data:000044f7 bf                               cp a
.data:000044f8 2d                               dec l
.data:000044f9 bf                               cp a
.data:000044fa 12                               ld (de),a
.data:000044fb 42                               ld b,d
.data:000044fc 12                               ld (de),a
.data:000044fd 37                               scf
.data:000044fe 12                               ld (de),a
.data:000044ff 2d                               dec l
.data:00004500 13                               inc de
.data:00004501 2d                               dec l
.data:00004502 11 19 16                         ld de,0x1619
.data:00004505 bf                               cp a
.data:00004506 14                               inc d
.data:00004507 15                               dec d
.data:00004508 15                               dec d
.data:00004509 1c                               inc e
.data:0000450a 15                               dec d
.data:0000450b 15                               dec d
.data:0000450c 16 2d                            ld d,0x2d
.data:0000450e 12                               ld (de),a
.data:0000450f 42                               ld b,d
.data:00004510 42                               ld b,d
.data:00004511 12                               ld (de),a
.data:00004512 11 2d 11                         ld de,0x112d
.data:00004515 2d                               dec l
.data:00004516 14                               inc d
.data:00004517 1a                               ld a,(de)
.data:00004518 bf                               cp a
.data:00004519 11 12 42                         ld de,0x4212
.data:0000451c 12                               ld (de),a
.data:0000451d 37                               scf
.data:0000451e 12                               ld (de),a
.data:0000451f bf                               cp a
.data:00004520 2d                               dec l
.data:00004521 bf                               cp a
.data:00004522 12                               ld (de),a
.data:00004523 12                               ld (de),a
.data:00004524 2d                               dec l
.data:00004525 bf                               cp a
.data:00004526 52                               ld d,d
.data:00004527 3a 3a 3a                         ld a,(0x3a3a)
.data:0000452a 3a 3a 53                         ld a,(0x533a)
.data:0000452d bf                               cp a
.data:0000452e 12                               ld (de),a
.data:0000452f 59                               ld e,c
.data:00004530 42                               ld b,d
.data:00004531 12                               ld (de),a
.data:00004532 12                               ld (de),a
.data:00004533 bf                               cp a
.data:00004534 12                               ld (de),a
.data:00004535 bf                               cp a
.data:00004536 2d                               dec l
.data:00004537 12                               ld (de),a
.data:00004538 2d                               dec l
.data:00004539 12                               ld (de),a
.data:0000453a 12                               ld (de),a
.data:0000453b 42                               ld b,d
.data:0000453c 12                               ld (de),a
.data:0000453d 37                               scf
.data:0000453e 12                               ld (de),a
.data:0000453f 2d                               dec l
.data:00004540 11 2d 12                         ld de,0x122d
.data:00004543 12                               ld (de),a
.data:00004544 bf                               cp a
.data:00004545 19                               add hl,de
.data:00004546 15                               dec d
.data:00004547 15                               dec d
.data:00004548 15                               dec d
.data:00004549 15                               dec d
.data:0000454a 15                               dec d
.data:0000454b 15                               dec d
.data:0000454c 15                               dec d
.data:0000454d 15                               dec d
.data:0000454e 18 42                            jr 0x4592
.data:00004550 42                               ld b,d
.data:00004551 12                               ld (de),a
.data:00004552 13                               inc de
.data:00004553 2d                               dec l
.data:00004554 17                               rla
.data:00004555 16 bf                            ld d,0xbf
.data:00004557 13                               inc de
.data:00004558 bf                               cp a
.data:00004559 13                               inc de
.data:0000455a 12                               ld (de),a
.data:0000455b 42                               ld b,d
.data:0000455c 12                               ld (de),a
.data:0000455d bf                               cp a
.data:0000455e 13                               inc de
.data:0000455f bf                               cp a
.data:00004560 13                               inc de
.data:00004561 bf                               cp a
.data:00004562 17                               rla
.data:00004563 18 2d                            jr 0x4592
.data:00004565 12                               ld (de),a
.data:00004566 42                               ld b,d
.data:00004567 42                               ld b,d
.data:00004568 42                               ld b,d
.data:00004569 5a                               ld e,d
.data:0000456a 42                               ld b,d
.data:0000456b 42                               ld b,d
.data:0000456c 42                               ld b,d
.data:0000456d 59                               ld e,c
.data:0000456e 42                               ld b,d
.data:0000456f 42                               ld b,d
.data:00004570 5a                               ld e,d
.data:00004571 12                               ld (de),a
.data:00004572 2d                               dec l
.data:00004573 bf                               cp a
.data:00004574 2d                               dec l
.data:00004575 bf                               cp a
.data:00004576 2d                               dec l
.data:00004577 bf                               cp a
.data:00004578 2d                               dec l
.data:00004579 bf                               cp a
.data:0000457a 12                               ld (de),a
.data:0000457b 42                               ld b,d
.data:0000457c 12                               ld (de),a
.data:0000457d 2d                               dec l
.data:0000457e bf                               cp a
.data:0000457f 2d                               dec l
.data:00004580 bf                               cp a
.data:00004581 2d                               dec l
.data:00004582 bf                               cp a
.data:00004583 2d                               dec l
.data:00004584 bf                               cp a
.data:00004585 12                               ld (de),a
.data:00004586 58                               ld e,b
.data:00004587 42                               ld b,d
.data:00004588 19                               add hl,de
.data:00004589 15                               dec d
.data:0000458a 15                               dec d
.data:0000458b 15                               dec d
.data:0000458c 15                               dec d
.data:0000458d 15                               dec d
.data:0000458e 15                               dec d
.data:0000458f 15                               dec d
.data:00004590 15                               dec d
.data:00004591 18 bf                            jr 0x4552
.data:00004593 11 bf 14                         ld de,0x14bf
.data:00004596 15                               dec d
.data:00004597 15                               dec d
.data:00004598 1a                               ld a,(de)
.data:00004599 2d                               dec l
.data:0000459a 12                               ld (de),a
.data:0000459b 42                               ld b,d
.data:0000459c 1c                               inc e
.data:0000459d 15                               dec d
.data:0000459e 15                               dec d
.data:0000459f 15                               dec d
.data:000045a0 15                               dec d
.data:000045a1 16 2d                            ld d,0x2d
.data:000045a3 11 2d 12                         ld de,0x122d
.data:000045a6 42                               ld b,d
.data:000045a7 42                               ld b,d
.data:000045a8 12                               ld (de),a
.data:000045a9 bf                               cp a
.data:000045aa 2d                               dec l
.data:000045ab bf                               cp a
.data:000045ac 2d                               dec l
.data:000045ad bf                               cp a
.data:000045ae 2d                               dec l
.data:000045af bf                               cp a
.data:000045b0 2d                               dec l
.data:000045b1 bf                               cp a
.data:000045b2 2d                               dec l
.data:000045b3 12                               ld (de),a
.data:000045b4 2d                               dec l
.data:000045b5 34                               inc (hl)
.data:000045b6 35                               dec (hl)
.data:000045b7 35                               dec (hl)
.data:000045b8 13                               inc de
.data:000045b9 bf                               cp a
.data:000045ba 17                               rla
.data:000045bb 15                               dec d
.data:000045bc 3f                               ccf
.data:000045bd 2d                               dec l
.data:000045be bf                               cp a
.data:000045bf 2d                               dec l
.data:000045c0 bf                               cp a
.data:000045c1 2d                               dec l
.data:000045c2 bf                               cp a
.data:000045c3 12                               ld (de),a
.data:000045c4 bf                               cp a
.data:000045c5 12                               ld (de),a
.data:000045c6 42                               ld b,d
.data:000045c7 59                               ld e,c
.data:000045c8 12                               ld (de),a
.data:000045c9 2d                               dec l
.data:000045ca 14                               inc d
.data:000045cb 15                               dec d
.data:000045cc 15                               dec d
.data:000045cd 1b                               dec de
.data:000045ce 15                               dec d
.data:000045cf 15                               dec d
.data:000045d0 16 2d                            ld d,0x2d
.data:000045d2 14                               inc d
.data:000045d3 1c                               inc e
.data:000045d4 16 34                            ld d,0x34
.data:000045d6 11 33 35                         ld de,0x3533
.data:000045d9 2d                               dec l
.data:000045da 3f                               ccf
.data:000045db 2d                               dec l
.data:000045dc 1b                               dec de
.data:000045dd 15                               dec d
.data:000045de 15                               dec d
.data:000045df 15                               dec d
.data:000045e0 15                               dec d
.data:000045e1 16 2d                            ld d,0x2d
.data:000045e3 13                               inc de
.data:000045e4 2d                               dec l
.data:000045e5 12                               ld (de),a
.data:000045e6 5a                               ld e,d
.data:000045e7 42                               ld b,d
.data:000045e8 12                               ld (de),a
.data:000045e9 bf                               cp a
.data:000045ea 2d                               dec l
.data:000045eb 3f                               ccf
.data:000045ec 2d                               dec l
.data:000045ed 13                               inc de
.data:000045ee 2d                               dec l
.data:000045ef bf                               cp a
.data:000045f0 2d                               dec l
.data:000045f1 bf                               cp a
.data:000045f2 2d                               dec l
.data:000045f3 bf                               cp a
.data:000045f4 2d                               dec l
.data:000045f5 34                               inc (hl)
.data:000045f6 1d                               dec e
.data:000045f7 15                               dec d
.data:000045f8 16 bf                            ld d,0xbf
.data:000045fa 19                               add hl,de
.data:000045fb 15                               dec d
.data:000045fc 12                               ld (de),a
.data:000045fd 2d                               dec l
.data:000045fe bf                               cp a
.data:000045ff 2d                               dec l
.data:00004600 bf                               cp a
.data:00004601 2d                               dec l
.data:00004602 bf                               cp a
.data:00004603 2d                               dec l
.data:00004604 bf                               cp a
.data:00004605 12                               ld (de),a
.data:00004606 42                               ld b,d
.data:00004607 58                               ld e,b
.data:00004608 12                               ld (de),a
.data:00004609 2d                               dec l
.data:0000460a 14                               inc d
.data:0000460b 16 bf                            ld d,0xbf
.data:0000460d 2d                               dec l
.data:0000460e bf                               cp a
.data:0000460f 14                               inc d
.data:00004610 16 2d                            ld d,0x2d
.data:00004612 14                               inc d
.data:00004613 1b                               dec de
.data:00004614 16 34                            ld d,0x34
.data:00004616 13                               inc de
.data:00004617 36 36                            ld (hl),0x36
.data:00004619 bf                               cp a
.data:0000461a 12                               ld (de),a
.data:0000461b 42                               ld b,d
.data:0000461c 1d                               dec e
.data:0000461d 50                               ld d,b
.data:0000461e 38 51                            jr c,0x4671
.data:00004620 1a                               ld a,(de)
.data:00004621 bf                               cp a
.data:00004622 19                               add hl,de
.data:00004623 1a                               ld a,(de)
.data:00004624 2d                               dec l
.data:00004625 12                               ld (de),a
.data:00004626 42                               ld b,d
.data:00004627 42                               ld b,d
.data:00004628 12                               ld (de),a
.data:00004629 bf                               cp a
.data:0000462a 2d                               dec l
.data:0000462b bf                               cp a
.data:0000462c 2d                               dec l
.data:0000462d 11 2d bf                         ld de,0xbf2d
.data:00004630 2d                               dec l
.data:00004631 bf                               cp a
.data:00004632 2d                               dec l
.data:00004633 12                               ld (de),a
.data:00004634 2d                               dec l
.data:00004635 36 36                            ld (hl),0x36
.data:00004637 33                               inc sp
.data:00004638 11 bf 12                         ld de,0x12bf
.data:0000463b 42                               ld b,d
.data:0000463c 12                               ld (de),a
.data:0000463d bf                               cp a
.data:0000463e bf                               cp a
.data:0000463f bf                               cp a
.data:00004640 12                               ld (de),a
.data:00004641 2d                               dec l
.data:00004642 17                               rla
.data:00004643 18 3d                            jr 0x4682
.data:00004645 12                               ld (de),a
.data:00004646 5a                               ld e,d
.data:00004647 42                               ld b,d
.data:00004648 12                               ld (de),a
.data:00004649 bf                               cp a
.data:0000464a 14                               inc d
.data:0000464b 15                               dec d
.data:0000464c 15                               dec d
.data:0000464d 1c                               inc e
.data:0000464e 15                               dec d
.data:0000464f 15                               dec d
.data:00004650 16 bf                            ld d,0xbf
.data:00004652 bf                               cp a
.data:00004653 13                               inc de
.data:00004654 bf                               cp a
.data:00004655 14                               inc d
.data:00004656 15                               dec d
.data:00004657 15                               dec d
.data:00004658 18 2d                            jr 0x4687
.data:0000465a 12                               ld (de),a
.data:0000465b 42                               ld b,d
.data:0000465c 12                               ld (de),a
.data:0000465d bf                               cp a
.data:0000465e bf                               cp a
.data:0000465f bf                               cp a
.data:00004660 12                               ld (de),a
.data:00004661 bf                               cp a
.data:00004662 2d                               dec l
.data:00004663 bf                               cp a
.data:00004664 2d                               dec l
.data:00004665 12                               ld (de),a
.data:00004666 42                               ld b,d
.data:00004667 5a                               ld e,d
.data:00004668 12                               ld (de),a
.data:00004669 bf                               cp a
.data:0000466a 52                               ld d,d
.data:0000466b 3a 3a 3a                         ld a,(0x3a3a)
.data:0000466e 3a 3a 53                         ld a,(0x533a)
.data:00004671 bf                               cp a
.data:00004672 2d                               dec l
.data:00004673 bf                               cp a
.data:00004674 2d                               dec l
.data:00004675 bf                               cp a
.data:00004676 2d                               dec l
.data:00004677 bf                               cp a
.data:00004678 2d                               dec l
.data:00004679 3d                               dec a
.data:0000467a 12                               ld (de),a
.data:0000467b 42                               ld b,d
.data:0000467c 17                               rla
.data:0000467d 15                               dec d
.data:0000467e 15                               dec d
.data:0000467f 15                               dec d
.data:00004680 1c                               inc e
.data:00004681 15                               dec d
.data:00004682 15                               dec d
.data:00004683 15                               dec d
.data:00004684 15                               dec d
.data:00004685 18 42                            jr 0x46c9
.data:00004687 42                               ld b,d
.data:00004688 17                               rla
.data:00004689 15                               dec d
.data:0000468a 15                               dec d
.data:0000468b 15                               dec d
.data:0000468c 15                               dec d
.data:0000468d 15                               dec d
.data:0000468e 15                               dec d
.data:0000468f 15                               dec d
.data:00004690 15                               dec d
.data:00004691 15                               dec d
.data:00004692 15                               dec d
.data:00004693 15                               dec d
.data:00004694 15                               dec d
.data:00004695 15                               dec d
.data:00004696 15                               dec d
.data:00004697 15                               dec d
.data:00004698 15                               dec d
.data:00004699 15                               dec d
.data:0000469a 18 42                            jr 0x46de
.data:0000469c 25                               dec h
.data:0000469d 25                               dec h
.data:0000469e 25                               dec h
.data:0000469f 25                               dec h
.data:000046a0 25                               dec h
.data:000046a1 25                               dec h
.data:000046a2 25                               dec h
.data:000046a3 25                               dec h
.data:000046a4 25                               dec h
.data:000046a5 25                               dec h
.data:000046a6 25                               dec h
.data:000046a7 25                               dec h
.data:000046a8 25                               dec h
.data:000046a9 25                               dec h
.data:000046aa 25                               dec h
.data:000046ab 25                               dec h
.data:000046ac 2b                               dec hl
.data:000046ad 25                               dec h
.data:000046ae 25                               dec h
.data:000046af 25                               dec h
.data:000046b0 25                               dec h
.data:000046b1 25                               dec h
.data:000046b2 25                               dec h
.data:000046b3 25                               dec h
.data:000046b4 25                               dec h
.data:000046b5 25                               dec h
.data:000046b6 25                               dec h
.data:000046b7 25                               dec h
.data:000046b8 25                               dec h
.data:000046b9 25                               dec h
.data:000046ba 25                               dec h
.data:000046bb 25                               dec h
.data:000046bc 20 3c                            jr nz,0x46fa
.data:000046be bf                               cp a
.data:000046bf 2d                               dec l
.data:000046c0 bf                               cp a
.data:000046c1 2d                               dec l
.data:000046c2 bf                               cp a
.data:000046c3 2d                               dec l
.data:000046c4 bf                               cp a
.data:000046c5 2d                               dec l
.data:000046c6 bf                               cp a
.data:000046c7 2d                               dec l
.data:000046c8 bf                               cp a
.data:000046c9 2d                               dec l
.data:000046ca bf                               cp a
.data:000046cb 2d                               dec l
.data:000046cc 22 2d bf                         ld (0xbf2d),hl
.data:000046cf 2d                               dec l
.data:000046d0 bf                               cp a
.data:000046d1 2d                               dec l
.data:000046d2 bf                               cp a
.data:000046d3 2d                               dec l
.data:000046d4 bf                               cp a
.data:000046d5 2d                               dec l
.data:000046d6 bf                               cp a
.data:000046d7 2d                               dec l
.data:000046d8 bf                               cp a
.data:000046d9 2d                               dec l
.data:000046da bf                               cp a
.data:000046db 3c                               inc a
.data:000046dc 25                               dec h
.data:000046dd 26 2d                            ld h,0x2d
.data:000046df 20 2d                            jr nz,0x470e
.data:000046e1 21 37 29                         ld hl,0x2937
.data:000046e4 25                               dec h
.data:000046e5 26 2d                            ld h,0x2d
.data:000046e7 24                               inc h
.data:000046e8 26 bf                            ld h,0xbf
.data:000046ea 2d                               dec l
.data:000046eb bf                               cp a
.data:000046ec 22 bf 29                         ld (0x29bf),hl
.data:000046ef 25                               dec h
.data:000046f0 26 bf                            ld h,0xbf
.data:000046f2 24                               inc h
.data:000046f3 26 2d                            ld h,0x2d
.data:000046f5 21 37 21                         ld hl,0x2137
.data:000046f8 2d                               dec l
.data:000046f9 20 2d                            jr nz,0x4728
.data:000046fb 24                               inc h
.data:000046fc 20 3d                            jr nz,0x473b
.data:000046fe 3f                               ccf
.data:000046ff 2d                               dec l
.data:00004700 bf                               cp a
.data:00004701 22 37 22                         ld (0x2237),hl
.data:00004704 bf                               cp a
.data:00004705 2d                               dec l
.data:00004706 bf                               cp a
.data:00004707 2d                               dec l
.data:00004708 bf                               cp a
.data:00004709 2d                               dec l
.data:0000470a 21 2d 22                         ld hl,0x222d
.data:0000470d 2d                               dec l
.data:0000470e 23                               inc hl
.data:0000470f 2d                               dec l
.data:00004710 bf                               cp a
.data:00004711 2d                               dec l
.data:00004712 bf                               cp a
.data:00004713 2d                               dec l
.data:00004714 bf                               cp a
.data:00004715 22 37 22                         ld (0x2237),hl
.data:00004718 bf                               cp a
.data:00004719 bf                               cp a
.data:0000471a bf                               cp a
.data:0000471b 3e 25                            ld a,0x25
.data:0000471d 26 2d                            ld h,0x2d
.data:0000471f 20 2d                            jr nz,0x474e
.data:00004721 22 37 22                         ld (0x2237),hl
.data:00004724 2d                               dec l
.data:00004725 24                               inc h
.data:00004726 26 bf                            ld h,0xbf
.data:00004728 24                               inc h
.data:00004729 25                               dec h
.data:0000472a 28 bf                            jr z,0x46eb
.data:0000472c 22 bf 2d                         ld (0x2dbf),hl
.data:0000472f bf                               cp a
.data:00004730 24                               inc h
.data:00004731 26 2d                            ld h,0x2d
.data:00004733 24                               inc h
.data:00004734 26 22                            ld h,0x22
.data:00004736 37                               scf
.data:00004737 22 2d 20                         ld (0x202d),hl
.data:0000473a 2d                               dec l
.data:0000473b 24                               inc h
.data:0000473c 20 3e                            jr nz,0x477c
.data:0000473e bf                               cp a
.data:0000473f 2d                               dec l
.data:00004740 bf                               cp a
.data:00004741 22 37 22                         ld (0x2237),hl
.data:00004744 bf                               cp a
.data:00004745 2d                               dec l
.data:00004746 bf                               cp a
.data:00004747 2d                               dec l
.data:00004748 bf                               cp a
.data:00004749 2d                               dec l
.data:0000474a bf                               cp a
.data:0000474b 2d                               dec l
.data:0000474c 22 2d bf                         ld (0xbf2d),hl
.data:0000474f 2d                               dec l
.data:00004750 bf                               cp a
.data:00004751 2d                               dec l
.data:00004752 bf                               cp a
.data:00004753 2d                               dec l
.data:00004754 bf                               cp a
.data:00004755 22 37 22                         ld (0x2237),hl
.data:00004758 bf                               cp a
.data:00004759 bf                               cp a
.data:0000475a bf                               cp a
.data:0000475b 3d                               dec a
.data:0000475c 25                               dec h
.data:0000475d 26 2d                            ld h,0x2d
.data:0000475f 20 2d                            jr nz,0x478e
.data:00004761 22 37 22                         ld (0x2237),hl
.data:00004764 29                               add hl,hl
.data:00004765 25                               dec h
.data:00004766 25                               dec h
.data:00004767 25                               dec h
.data:00004768 2a 3f 2d                         ld hl,(0x2d3f)
.data:0000476b bf                               cp a
.data:0000476c 23                               inc hl
.data:0000476d bf                               cp a
.data:0000476e 2d                               dec l
.data:0000476f bf                               cp a
.data:00004770 29                               add hl,hl
.data:00004771 25                               dec h
.data:00004772 25                               dec h
.data:00004773 25                               dec h
.data:00004774 2a 22 37                         ld hl,(0x3722)
.data:00004777 22 2d 20                         ld (0x202d),hl
.data:0000477a 2d                               dec l
.data:0000477b 24                               inc h
.data:0000477c 20 3c                            jr nz,0x47ba
.data:0000477e bf                               cp a
.data:0000477f 2d                               dec l
.data:00004780 bf                               cp a
.data:00004781 22 37 22                         ld (0x2237),hl
.data:00004784 22 21 21                         ld (0x2121),hl
.data:00004787 21 22 2d                         ld hl,0x2d22
.data:0000478a bf                               cp a
.data:0000478b 2d                               dec l
.data:0000478c bf                               cp a
.data:0000478d 2d                               dec l
.data:0000478e bf                               cp a
.data:0000478f 2d                               dec l
.data:00004790 22 21 21                         ld (0x2121),hl
.data:00004793 21 22 22                         ld hl,0x2222
.data:00004796 37                               scf
.data:00004797 22 bf bf                         ld (0xbfbf),hl
.data:0000479a bf                               cp a
.data:0000479b 3c                               inc a
.data:0000479c 25                               dec h
.data:0000479d 26 2d                            ld h,0x2d
.data:0000479f 20 2d                            jr nz,0x47ce
.data:000047a1 23                               inc hl
.data:000047a2 37                               scf
.data:000047a3 23                               inc hl
.data:000047a4 23                               inc hl
.data:000047a5 22 22 22                         ld (0x2222),hl
.data:000047a8 22 bf 29                         ld (0x29bf),hl
.data:000047ab 50                               ld d,b
.data:000047ac 38 51                            jr c,0x47ff
.data:000047ae 2a bf 22                         ld hl,(0x22bf)
.data:000047b1 22 22 22                         ld (0x2222),hl
.data:000047b4 23                               inc hl
.data:000047b5 23                               inc hl
.data:000047b6 37                               scf
.data:000047b7 23                               inc hl
.data:000047b8 2d                               dec l
.data:000047b9 20 2d                            jr nz,0x47e8
.data:000047bb 24                               inc h
.data:000047bc bf                               cp a
.data:000047bd 2d                               dec l
.data:000047be bf                               cp a
.data:000047bf 2d                               dec l
.data:000047c0 bf                               cp a
.data:000047c1 2d                               dec l
.data:000047c2 bf                               cp a
.data:000047c3 2d                               dec l
.data:000047c4 bf                               cp a
.data:000047c5 23                               inc hl
.data:000047c6 22 22 22                         ld (0x2222),hl
.data:000047c9 2d                               dec l
.data:000047ca 22 bf bf                         ld (0xbfbf),hl
.data:000047cd bf                               cp a
.data:000047ce 22 2d 22                         ld (0x222d),hl
.data:000047d1 22 22 23                         ld (0x2322),hl
.data:000047d4 bf                               cp a
.data:000047d5 2d                               dec l
.data:000047d6 bf                               cp a
.data:000047d7 2d                               dec l
.data:000047d8 bf                               cp a
.data:000047d9 2d                               dec l
.data:000047da bf                               cp a
.data:000047db 3f                               ccf
.data:000047dc 25                               dec h
.data:000047dd 26 2d                            ld h,0x2d
.data:000047df 20 2d                            jr nz,0x480e
.data:000047e1 21 2d 21                         ld hl,0x212d
.data:000047e4 2d                               dec l
.data:000047e5 bf                               cp a
.data:000047e6 23                               inc hl
.data:000047e7 22 22 bf                         ld (0xbf22),hl
.data:000047ea 27                               daa
.data:000047eb 25                               dec h
.data:000047ec 2b                               dec hl
.data:000047ed 25                               dec h
.data:000047ee 28 bf                            jr z,0x47af
.data:000047f0 22 22 23                         ld (0x2322),hl
.data:000047f3 bf                               cp a
.data:000047f4 2d                               dec l
.data:000047f5 21 2d 21                         ld hl,0x212d
.data:000047f8 2d                               dec l
.data:000047f9 20 2d                            jr nz,0x4828
.data:000047fb 24                               inc h
.data:000047fc 20 3d                            jr nz,0x483b
.data:000047fe bf                               cp a
.data:000047ff 2d                               dec l
.data:00004800 bf                               cp a
.data:00004801 22 bf 22                         ld (0x22bf),hl
.data:00004804 21 2d bf                         ld hl,0xbf2d
.data:00004807 23                               inc hl
.data:00004808 22 2d bf                         ld (0xbf2d),hl
.data:0000480b 2d                               dec l
.data:0000480c 22 2d bf                         ld (0xbf2d),hl
.data:0000480f 2d                               dec l
.data:00004810 22 23 bf                         ld (0xbf23),hl
.data:00004813 2d                               dec l
.data:00004814 21 22 bf                         ld hl,0xbf22
.data:00004817 22 bf bf                         ld (0xbfbf),hl
.data:0000481a bf                               cp a
.data:0000481b 3e 25                            ld a,0x25
.data:0000481d 26 2d                            ld h,0x2d
.data:0000481f 20 2d                            jr nz,0x484e
.data:00004821 23                               inc hl
.data:00004822 2d                               dec l
.data:00004823 22 22 21                         ld (0x2122),hl
.data:00004826 2d                               dec l
.data:00004827 bf                               cp a
.data:00004828 23                               inc hl
.data:00004829 bf                               cp a
.data:0000482a 21 bf 22                         ld hl,0x22bf
.data:0000482d bf                               cp a
.data:0000482e 21 bf 23                         ld hl,0x23bf
.data:00004831 bf                               cp a
.data:00004832 2d                               dec l
.data:00004833 21 22 22                         ld hl,0x2222
.data:00004836 2d                               dec l
.data:00004837 23                               inc hl
.data:00004838 2d                               dec l
.data:00004839 20 2d                            jr nz,0x4868
.data:0000483b 24                               inc h
.data:0000483c 20 3e                            jr nz,0x487c
.data:0000483e bf                               cp a
.data:0000483f 2d                               dec l
.data:00004840 bf                               cp a
.data:00004841 2d                               dec l
.data:00004842 bf                               cp a
.data:00004843 22 23 23                         ld (0x2323),hl
.data:00004846 20 2d                            jr nz,0x4875
.data:00004848 bf                               cp a
.data:00004849 2d                               dec l
.data:0000484a 22 2d 22                         ld (0x222d),hl
.data:0000484d 2d                               dec l
.data:0000484e 22 2d bf                         ld (0xbf2d),hl
.data:00004851 2d                               dec l
.data:00004852 20 23                            jr nz,0x4877
.data:00004854 23                               inc hl
.data:00004855 22 bf 2d                         ld (0x2dbf),hl
.data:00004858 bf                               cp a
.data:00004859 bf                               cp a
.data:0000485a bf                               cp a
.data:0000485b 3d                               dec a
.data:0000485c 25                               dec h
.data:0000485d 26 2d                            ld h,0x2d
.data:0000485f 20 2d                            jr nz,0x488e
.data:00004861 21 2d 27                         ld hl,0x272d
.data:00004864 25                               dec h
.data:00004865 47                               ld b,a
.data:00004866 48                               ld c,b
.data:00004867 25                               dec h
.data:00004868 26 bf                            ld h,0xbf
.data:0000486a 23                               inc hl
.data:0000486b bf                               cp a
.data:0000486c 22 bf 23                         ld (0x23bf),hl
.data:0000486f bf                               cp a
.data:00004870 24                               inc h
.data:00004871 25                               dec h
.data:00004872 4a                               ld c,d
.data:00004873 4b                               ld c,e
.data:00004874 25                               dec h
.data:00004875 28 2d                            jr z,0x48a4
.data:00004877 21 2d 20                         ld hl,0x202d
.data:0000487a 2d                               dec l
.data:0000487b 24                               inc h
.data:0000487c 20 3c                            jr nz,0x48ba
.data:0000487e bf                               cp a
.data:0000487f 2d                               dec l
.data:00004880 bf                               cp a
.data:00004881 22 bf 2d                         ld (0x2dbf),hl
.data:00004884 bf                               cp a
.data:00004885 49                               ld c,c
.data:00004886 45                               ld b,l
.data:00004887 3f                               ccf
.data:00004888 bf                               cp a
.data:00004889 2d                               dec l
.data:0000488a bf                               cp a
.data:0000488b 2d                               dec l
.data:0000488c 22 2d bf                         ld (0xbf2d),hl
.data:0000488f 2d                               dec l
.data:00004890 bf                               cp a
.data:00004891 3f                               ccf
.data:00004892 43                               ld b,e
.data:00004893 44                               ld b,h
.data:00004894 bf                               cp a
.data:00004895 2d                               dec l
.data:00004896 bf                               cp a
.data:00004897 22 bf 2d                         ld (0x2dbf),hl
.data:0000489a bf                               cp a
.data:0000489b 3c                               inc a
.data:0000489c 25                               dec h
.data:0000489d 25                               dec h
.data:0000489e 25                               dec h
.data:0000489f 25                               dec h
.data:000048a0 25                               dec h
.data:000048a1 2c                               inc l
.data:000048a2 25                               dec h
.data:000048a3 25                               dec h
.data:000048a4 25                               dec h
.data:000048a5 25                               dec h
.data:000048a6 25                               dec h
.data:000048a7 25                               dec h
.data:000048a8 25                               dec h
.data:000048a9 25                               dec h
.data:000048aa 25                               dec h
.data:000048ab 25                               dec h
.data:000048ac 2c                               inc l
.data:000048ad 25                               dec h
.data:000048ae 25                               dec h
.data:000048af 25                               dec h
.data:000048b0 25                               dec h
.data:000048b1 25                               dec h
.data:000048b2 25                               dec h
.data:000048b3 25                               dec h
.data:000048b4 25                               dec h
.data:000048b5 25                               dec h
.data:000048b6 25                               dec h
.data:000048b7 2c                               inc l
.data:000048b8 25                               dec h
.data:000048b9 25                               dec h
.data:000048ba 25                               dec h
.data:000048bb 25                               dec h
.data:000048bc 42                               ld b,d
.data:000048bd 42                               ld b,d
.data:000048be 42                               ld b,d
.data:000048bf 09                               add hl,bc
.data:000048c0 05                               dec b
.data:000048c1 05                               dec b
.data:000048c2 05                               dec b
.data:000048c3 05                               dec b
.data:000048c4 05                               dec b
.data:000048c5 05                               dec b
.data:000048c6 05                               dec b
.data:000048c7 05                               dec b
.data:000048c8 05                               dec b
.data:000048c9 05                               dec b
.data:000048ca 05                               dec b
.data:000048cb 05                               dec b
.data:000048cc 05                               dec b
.data:000048cd 05                               dec b
.data:000048ce 05                               dec b
.data:000048cf 05                               dec b
.data:000048d0 05                               dec b
.data:000048d1 05                               dec b
.data:000048d2 05                               dec b
.data:000048d3 0b                               dec bc
.data:000048d4 05                               dec b
.data:000048d5 05                               dec b
.data:000048d6 05                               dec b
.data:000048d7 05                               dec b
.data:000048d8 0b                               dec bc
.data:000048d9 0a                               ld a,(bc)
.data:000048da 42                               ld b,d
.data:000048db 42                               ld b,d
.data:000048dc 42                               ld b,d
.data:000048dd 42                               ld b,d
.data:000048de 42                               ld b,d
.data:000048df 02                               ld (bc),a
.data:000048e0 2d                               dec l
.data:000048e1 bf                               cp a
.data:000048e2 2d                               dec l
.data:000048e3 bf                               cp a
.data:000048e4 2d                               dec l
.data:000048e5 bf                               cp a
.data:000048e6 2d                               dec l
.data:000048e7 bf                               cp a
.data:000048e8 2d                               dec l
.data:000048e9 36 36                            ld (hl),0x36
.data:000048eb 36 36                            ld (hl),0x36
.data:000048ed 36 36                            ld (hl),0x36
.data:000048ef 34                               inc (hl)
.data:000048f0 2d                               dec l
.data:000048f1 bf                               cp a
.data:000048f2 2d                               dec l
.data:000048f3 07                               rlca
.data:000048f4 0b                               dec bc
.data:000048f5 05                               dec b
.data:000048f6 0b                               dec bc
.data:000048f7 05                               dec b
.data:000048f8 0e 02                            ld c,0x02
.data:000048fa 42                               ld b,d
.data:000048fb 42                               ld b,d
.data:000048fc 42                               ld b,d
.data:000048fd 42                               ld b,d
.data:000048fe 42                               ld b,d
.data:000048ff 02                               ld (bc),a
.data:00004900 bf                               cp a
.data:00004901 09                               add hl,bc
.data:00004902 05                               dec b
.data:00004903 0b                               dec bc
.data:00004904 06 2d                            ld b,0x2d
.data:00004906 bf                               cp a
.data:00004907 36 36                            ld (hl),0x36
.data:00004909 33                               inc sp
.data:0000490a 09                               add hl,bc
.data:0000490b 05                               dec b
.data:0000490c 0b                               dec bc
.data:0000490d 05                               dec b
.data:0000490e 0a                               ld a,(bc)
.data:0000490f 36 36                            ld (hl),0x36
.data:00004911 34                               inc (hl)
.data:00004912 bf                               cp a
.data:00004913 2d                               dec l
.data:00004914 02                               ld (bc),a
.data:00004915 2d                               dec l
.data:00004916 02                               ld (bc),a
.data:00004917 2d                               dec l
.data:00004918 03                               inc bc
.data:00004919 02                               ld (bc),a
.data:0000491a 42                               ld b,d
.data:0000491b 42                               ld b,d
.data:0000491c 42                               ld b,d
.data:0000491d 42                               ld b,d
.data:0000491e 42                               ld b,d
.data:0000491f 02                               ld (bc),a
.data:00004920 2d                               dec l
.data:00004921 02                               ld (bc),a
.data:00004922 3c                               inc a
.data:00004923 02                               ld (bc),a
.data:00004924 2d                               dec l
.data:00004925 bf                               cp a
.data:00004926 36 33                            ld (hl),0x33
.data:00004928 09                               add hl,bc
.data:00004929 0b                               dec bc
.data:0000492a 08                               ex af,af'
.data:0000492b bf                               cp a
.data:0000492c 03                               inc bc
.data:0000492d bf                               cp a
.data:0000492e 07                               rlca
.data:0000492f 05                               dec b
.data:00004930 0a                               ld a,(bc)
.data:00004931 36 34                            ld (hl),0x34
.data:00004933 bf                               cp a
.data:00004934 02                               ld (bc),a
.data:00004935 bf                               cp a
.data:00004936 03                               inc bc
.data:00004937 bf                               cp a
.data:00004938 2d                               dec l
.data:00004939 02                               ld (bc),a
.data:0000493a 42                               ld b,d
.data:0000493b 42                               ld b,d
.data:0000493c 42                               ld b,d
.data:0000493d 42                               ld b,d
.data:0000493e 42                               ld b,d
.data:0000493f 02                               ld (bc),a
.data:00004940 bf                               cp a
.data:00004941 02                               ld (bc),a
.data:00004942 bf                               cp a
.data:00004943 03                               inc bc
.data:00004944 bf                               cp a
.data:00004945 36 33                            ld (hl),0x33
.data:00004947 09                               add hl,bc
.data:00004948 08                               ex af,af'
.data:00004949 02                               ld (bc),a
.data:0000494a bf                               cp a
.data:0000494b 2d                               dec l
.data:0000494c bf                               cp a
.data:0000494d 2d                               dec l
.data:0000494e bf                               cp a
.data:0000494f 2d                               dec l
.data:00004950 0d                               dec c
.data:00004951 06 34                            ld b,0x34
.data:00004953 2d                               dec l
.data:00004954 03                               inc bc
.data:00004955 2d                               dec l
.data:00004956 bf                               cp a
.data:00004957 2d                               dec l
.data:00004958 09                               add hl,bc
.data:00004959 0e 42                            ld c,0x42
.data:0000495b 42                               ld b,d
.data:0000495c 42                               ld b,d
.data:0000495d 42                               ld b,d
.data:0000495e 42                               ld b,d
.data:0000495f 02                               ld (bc),a
.data:00004960 2d                               dec l
.data:00004961 03                               inc bc
.data:00004962 2d                               dec l
.data:00004963 bf                               cp a
.data:00004964 2d                               dec l
.data:00004965 33                               inc sp
.data:00004966 09                               add hl,bc
.data:00004967 08                               ex af,af'
.data:00004968 2d                               dec l
.data:00004969 03                               inc bc
.data:0000496a 2d                               dec l
.data:0000496b 09                               add hl,bc
.data:0000496c 06 bf                            ld b,0xbf
.data:0000496e 2d                               dec l
.data:0000496f 09                               add hl,bc
.data:00004970 08                               ex af,af'
.data:00004971 34                               inc (hl)
.data:00004972 35                               dec (hl)
.data:00004973 bf                               cp a
.data:00004974 2d                               dec l
.data:00004975 bf                               cp a
.data:00004976 2d                               dec l
.data:00004977 04                               inc b
.data:00004978 0e 02                            ld c,0x02
.data:0000497a 42                               ld b,d
.data:0000497b 42                               ld b,d
.data:0000497c 42                               ld b,d
.data:0000497d 42                               ld b,d
.data:0000497e 42                               ld b,d
.data:0000497f 02                               ld (bc),a
.data:00004980 bf                               cp a
.data:00004981 2d                               dec l
.data:00004982 3f                               ccf
.data:00004983 2d                               dec l
.data:00004984 36 33                            ld (hl),0x33
.data:00004986 02                               ld (bc),a
.data:00004987 2d                               dec l
.data:00004988 bf                               cp a
.data:00004989 2d                               dec l
.data:0000498a bf                               cp a
.data:0000498b 03                               inc bc
.data:0000498c 00                               nop
.data:0000498d 2d                               dec l
.data:0000498e 09                               add hl,bc
.data:0000498f 08                               ex af,af'
.data:00004990 34                               inc (hl)
.data:00004991 35                               dec (hl)
.data:00004992 bf                               cp a
.data:00004993 2d                               dec l
.data:00004994 00                               nop
.data:00004995 2d                               dec l
.data:00004996 bf                               cp a
.data:00004997 2d                               dec l
.data:00004998 07                               rlca
.data:00004999 0e 42                            ld c,0x42
.data:0000499b 42                               ld b,d
.data:0000499c 42                               ld b,d
.data:0000499d 42                               ld b,d
.data:0000499e 42                               ld b,d
.data:0000499f 07                               rlca
.data:000049a0 0a                               ld a,(bc)
.data:000049a1 bf                               cp a
.data:000049a2 01 bf 33                         ld bc,0x33bf
.data:000049a5 09                               add hl,bc
.data:000049a6 08                               ex af,af'
.data:000049a7 bf                               cp a
.data:000049a8 09                               add hl,bc
.data:000049a9 06 2d                            ld b,0x2d
.data:000049ab bf                               cp a
.data:000049ac 2d                               dec l
.data:000049ad 09                               add hl,bc
.data:000049ae 08                               ex af,af'
.data:000049af 34                               inc (hl)
.data:000049b0 35                               dec (hl)
.data:000049b1 bf                               cp a
.data:000049b2 2d                               dec l
.data:000049b3 bf                               cp a
.data:000049b4 2d                               dec l
.data:000049b5 bf                               cp a
.data:000049b6 2d                               dec l
.data:000049b7 bf                               cp a
.data:000049b8 2d                               dec l
.data:000049b9 02                               ld (bc),a
.data:000049ba 42                               ld b,d
.data:000049bb 42                               ld b,d
.data:000049bc 05                               dec b
.data:000049bd 05                               dec b
.data:000049be 05                               dec b
.data:000049bf 05                               dec b
.data:000049c0 08                               ex af,af'
.data:000049c1 2d                               dec l
.data:000049c2 02                               ld (bc),a
.data:000049c3 2d                               dec l
.data:000049c4 bf                               cp a
.data:000049c5 02                               ld (bc),a
.data:000049c6 bf                               cp a
.data:000049c7 2d                               dec l
.data:000049c8 02                               ld (bc),a
.data:000049c9 2d                               dec l
.data:000049ca bf                               cp a
.data:000049cb 2d                               dec l
.data:000049cc 04                               inc b
.data:000049cd 08                               ex af,af'
.data:000049ce 34                               inc (hl)
.data:000049cf 35                               dec (hl)
.data:000049d0 bf                               cp a
.data:000049d1 2d                               dec l
.data:000049d2 09                               add hl,bc
.data:000049d3 50                               ld d,b
.data:000049d4 38 51                            jr c,0x4a27
.data:000049d6 0a                               ld a,(bc)
.data:000049d7 2d                               dec l
.data:000049d8 84                               add a,h
.data:000049d9 8c                               adc a,h
.data:000049da 85                               add a,l
.data:000049db 85                               add a,l
.data:000049dc 2d                               dec l
.data:000049dd 3f                               ccf
.data:000049de 2d                               dec l
.data:000049df 3f                               ccf
.data:000049e0 2d                               dec l
.data:000049e1 bf                               cp a
.data:000049e2 02                               ld (bc),a
.data:000049e3 bf                               cp a
.data:000049e4 2d                               dec l
.data:000049e5 02                               ld (bc),a
.data:000049e6 2d                               dec l
.data:000049e7 bf                               cp a
.data:000049e8 02                               ld (bc),a
.data:000049e9 bf                               cp a
.data:000049ea 2d                               dec l
.data:000049eb bf                               cp a
.data:000049ec 2d                               dec l
.data:000049ed bf                               cp a
.data:000049ee 34                               inc (hl)
.data:000049ef bf                               cp a
.data:000049f0 2d                               dec l
.data:000049f1 bf                               cp a
.data:000049f2 02                               ld (bc),a
.data:000049f3 bf                               cp a
.data:000049f4 bf                               cp a
.data:000049f5 bf                               cp a
.data:000049f6 02                               ld (bc),a
.data:000049f7 bf                               cp a
.data:000049f8 2d                               dec l
.data:000049f9 bf                               cp a
.data:000049fa 2d                               dec l
.data:000049fb bf                               cp a
.data:000049fc 05                               dec b
.data:000049fd 05                               dec b
.data:000049fe 05                               dec b
.data:000049ff 05                               dec b
.data:00004a00 0a                               ld a,(bc)
.data:00004a01 2d                               dec l
.data:00004a02 02                               ld (bc),a
.data:00004a03 2d                               dec l
.data:00004a04 33                               inc sp
.data:00004a05 07                               rlca
.data:00004a06 0a                               ld a,(bc)
.data:00004a07 2d                               dec l
.data:00004a08 07                               rlca
.data:00004a09 06 bf                            ld b,0xbf
.data:00004a0b 2d                               dec l
.data:00004a0c 04                               inc b
.data:00004a0d 0a                               ld a,(bc)
.data:00004a0e 36 34                            ld (hl),0x34
.data:00004a10 bf                               cp a
.data:00004a11 2d                               dec l
.data:00004a12 07                               rlca
.data:00004a13 05                               dec b
.data:00004a14 05                               dec b
.data:00004a15 05                               dec b
.data:00004a16 88                               adc a,b
.data:00004a17 2d                               dec l
.data:00004a18 04                               inc b
.data:00004a19 0b                               dec bc
.data:00004a1a 05                               dec b
.data:00004a1b 85                               add a,l
.data:00004a1c 42                               ld b,d
.data:00004a1d 42                               ld b,d
.data:00004a1e 42                               ld b,d
.data:00004a1f 09                               add hl,bc
.data:00004a20 08                               ex af,af'
.data:00004a21 bf                               cp a
.data:00004a22 03                               inc bc
.data:00004a23 bf                               cp a
.data:00004a24 33                               inc sp
.data:00004a25 35                               dec (hl)
.data:00004a26 02                               ld (bc),a
.data:00004a27 bf                               cp a
.data:00004a28 2d                               dec l
.data:00004a29 bf                               cp a
.data:00004a2a 2d                               dec l
.data:00004a2b bf                               cp a
.data:00004a2c 2d                               dec l
.data:00004a2d 07                               rlca
.data:00004a2e 0a                               ld a,(bc)
.data:00004a2f 36 34                            ld (hl),0x34
.data:00004a31 bf                               cp a
.data:00004a32 2d                               dec l
.data:00004a33 bf                               cp a
.data:00004a34 2d                               dec l
.data:00004a35 bf                               cp a
.data:00004a36 2d                               dec l
.data:00004a37 bf                               cp a
.data:00004a38 2d                               dec l
.data:00004a39 02                               ld (bc),a
.data:00004a3a 42                               ld b,d
.data:00004a3b 42                               ld b,d
.data:00004a3c 42                               ld b,d
.data:00004a3d 42                               ld b,d
.data:00004a3e 42                               ld b,d
.data:00004a3f 02                               ld (bc),a
.data:00004a40 bf                               cp a
.data:00004a41 2d                               dec l
.data:00004a42 bf                               cp a
.data:00004a43 2d                               dec l
.data:00004a44 bf                               cp a
.data:00004a45 33                               inc sp
.data:00004a46 07                               rlca
.data:00004a47 0a                               ld a,(bc)
.data:00004a48 bf                               cp a
.data:00004a49 2d                               dec l
.data:00004a4a 04                               inc b
.data:00004a4b 06 bf                            ld b,0xbf
.data:00004a4d 2d                               dec l
.data:00004a4e 07                               rlca
.data:00004a4f 0a                               ld a,(bc)
.data:00004a50 36 36                            ld (hl),0x36
.data:00004a52 34                               inc (hl)
.data:00004a53 2d                               dec l
.data:00004a54 81                               add a,c
.data:00004a55 2d                               dec l
.data:00004a56 81                               add a,c
.data:00004a57 2d                               dec l
.data:00004a58 04                               inc b
.data:00004a59 0e 42                            ld c,0x42
.data:00004a5b 42                               ld b,d
.data:00004a5c 42                               ld b,d
.data:00004a5d 42                               ld b,d
.data:00004a5e 42                               ld b,d
.data:00004a5f 02                               ld (bc),a
.data:00004a60 2d                               dec l
.data:00004a61 01 2d 01                         ld bc,0x012d
.data:00004a64 2d                               dec l
.data:00004a65 33                               inc sp
.data:00004a66 35                               dec (hl)
.data:00004a67 07                               rlca
.data:00004a68 0a                               ld a,(bc)
.data:00004a69 bf                               cp a
.data:00004a6a 2d                               dec l
.data:00004a6b bf                               cp a
.data:00004a6c 00                               nop
.data:00004a6d 3f                               ccf
.data:00004a6e 2d                               dec l
.data:00004a6f 07                               rlca
.data:00004a70 0b                               dec bc
.data:00004a71 06 34                            ld b,0x34
.data:00004a73 bf                               cp a
.data:00004a74 82                               add a,d
.data:00004a75 bf                               cp a
.data:00004a76 82                               add a,d
.data:00004a77 bf                               cp a
.data:00004a78 2d                               dec l
.data:00004a79 02                               ld (bc),a
.data:00004a7a 42                               ld b,d
.data:00004a7b 42                               ld b,d
.data:00004a7c 42                               ld b,d
.data:00004a7d 42                               ld b,d
.data:00004a7e 42                               ld b,d
.data:00004a7f 02                               ld (bc),a
.data:00004a80 bf                               cp a
.data:00004a81 02                               ld (bc),a
.data:00004a82 04                               inc b
.data:00004a83 08                               ex af,af'
.data:00004a84 bf                               cp a
.data:00004a85 2d                               dec l
.data:00004a86 33                               inc sp
.data:00004a87 35                               dec (hl)
.data:00004a88 07                               rlca
.data:00004a89 05                               dec b
.data:00004a8a 0a                               ld a,(bc)
.data:00004a8b 2d                               dec l
.data:00004a8c bf                               cp a
.data:00004a8d 2d                               dec l
.data:00004a8e 09                               add hl,bc
.data:00004a8f 05                               dec b
.data:00004a90 08                               ex af,af'
.data:00004a91 34                               inc (hl)
.data:00004a92 35                               dec (hl)
.data:00004a93 2d                               dec l
.data:00004a94 82                               add a,d
.data:00004a95 2d                               dec l
.data:00004a96 0d                               dec c
.data:00004a97 8a                               adc a,d
.data:00004a98 bf                               cp a
.data:00004a99 02                               ld (bc),a
.data:00004a9a 42                               ld b,d
.data:00004a9b 42                               ld b,d
.data:00004a9c 42                               ld b,d
.data:00004a9d 42                               ld b,d
.data:00004a9e 42                               ld b,d
.data:00004a9f 02                               ld (bc),a
.data:00004aa0 2d                               dec l
.data:00004aa1 07                               rlca
.data:00004aa2 05                               dec b
.data:00004aa3 05                               dec b
.data:00004aa4 06 bf                            ld b,0xbf
.data:00004aa6 2d                               dec l
.data:00004aa7 33                               inc sp
.data:00004aa8 35                               dec (hl)
.data:00004aa9 35                               dec (hl)
.data:00004aaa 07                               rlca
.data:00004aab 05                               dec b
.data:00004aac 05                               dec b
.data:00004aad 05                               dec b
.data:00004aae 08                               ex af,af'
.data:00004aaf 34                               inc (hl)
.data:00004ab0 35                               dec (hl)
.data:00004ab1 35                               dec (hl)
.data:00004ab2 2d                               dec l
.data:00004ab3 bf                               cp a
.data:00004ab4 82                               add a,d
.data:00004ab5 2d                               dec l
.data:00004ab6 82                               add a,d
.data:00004ab7 82                               add a,d
.data:00004ab8 2d                               dec l
.data:00004ab9 02                               ld (bc),a
.data:00004aba 42                               ld b,d
.data:00004abb 42                               ld b,d
.data:00004abc 42                               ld b,d
.data:00004abd 42                               ld b,d
.data:00004abe 42                               ld b,d
.data:00004abf 02                               ld (bc),a
.data:00004ac0 3e 2d                            ld a,0x2d
.data:00004ac2 bf                               cp a
.data:00004ac3 2d                               dec l
.data:00004ac4 bf                               cp a
.data:00004ac5 2d                               dec l
.data:00004ac6 bf                               cp a
.data:00004ac7 2d                               dec l
.data:00004ac8 bf                               cp a
.data:00004ac9 33                               inc sp
.data:00004aca 35                               dec (hl)
.data:00004acb 35                               dec (hl)
.data:00004acc 35                               dec (hl)
.data:00004acd 35                               dec (hl)
.data:00004ace 35                               dec (hl)
.data:00004acf 35                               dec (hl)
.data:00004ad0 bf                               cp a
.data:00004ad1 2d                               dec l
.data:00004ad2 bf                               cp a
.data:00004ad3 84                               add a,h
.data:00004ad4 8c                               adc a,h
.data:00004ad5 85                               add a,l
.data:00004ad6 88                               adc a,b
.data:00004ad7 82                               add a,d
.data:00004ad8 2d                               dec l
.data:00004ad9 02                               ld (bc),a
.data:00004ada 42                               ld b,d
.data:00004adb 42                               ld b,d
.data:00004adc 42                               ld b,d
.data:00004add 42                               ld b,d
.data:00004ade 42                               ld b,d
.data:00004adf 07                               rlca
.data:00004ae0 05                               dec b
.data:00004ae1 05                               dec b
.data:00004ae2 05                               dec b
.data:00004ae3 05                               dec b
.data:00004ae4 05                               dec b
.data:00004ae5 05                               dec b
.data:00004ae6 05                               dec b
.data:00004ae7 05                               dec b
.data:00004ae8 05                               dec b
.data:00004ae9 05                               dec b
.data:00004aea 05                               dec b
.data:00004aeb 05                               dec b
.data:00004aec 05                               dec b
.data:00004aed 05                               dec b
.data:00004aee 05                               dec b
.data:00004aef 05                               dec b
.data:00004af0 05                               dec b
.data:00004af1 05                               dec b
.data:00004af2 05                               dec b
.data:00004af3 05                               dec b
.data:00004af4 05                               dec b
.data:00004af5 05                               dec b
.data:00004af6 05                               dec b
.data:00004af7 0c                               inc c
.data:00004af8 05                               dec b
.data:00004af9 08                               ex af,af'
.data:00004afa 42                               ld b,d
.data:00004afb 42                               ld b,d
.data:00004afc 42                               ld b,d
.data:00004afd 58                               ld e,b
.data:00004afe 59                               ld e,c
.data:00004aff 42                               ld b,d
.data:00004b00 42                               ld b,d
.data:00004b01 42                               ld b,d
.data:00004b02 58                               ld e,b
.data:00004b03 42                               ld b,d
.data:00004b04 42                               ld b,d
.data:00004b05 58                               ld e,b
.data:00004b06 42                               ld b,d
.data:00004b07 59                               ld e,c
.data:00004b08 42                               ld b,d
.data:00004b09 42                               ld b,d
.data:00004b0a 58                               ld e,b
.data:00004b0b 59                               ld e,c
.data:00004b0c 42                               ld b,d
.data:00004b0d 42                               ld b,d
.data:00004b0e 42                               ld b,d
.data:00004b0f 59                               ld e,c
.data:00004b10 42                               ld b,d
.data:00004b11 42                               ld b,d
.data:00004b12 58                               ld e,b
.data:00004b13 58                               ld e,b
.data:00004b14 42                               ld b,d
.data:00004b15 42                               ld b,d
.data:00004b16 42                               ld b,d
.data:00004b17 5a                               ld e,d
.data:00004b18 42                               ld b,d
.data:00004b19 58                               ld e,b
.data:00004b1a 42                               ld b,d
.data:00004b1b 59                               ld e,c
.data:00004b1c 58                               ld e,b
.data:00004b1d 42                               ld b,d
.data:00004b1e 42                               ld b,d
.data:00004b1f 42                               ld b,d
.data:00004b20 5a                               ld e,d
.data:00004b21 42                               ld b,d
.data:00004b22 42                               ld b,d
.data:00004b23 42                               ld b,d
.data:00004b24 58                               ld e,b
.data:00004b25 42                               ld b,d
.data:00004b26 42                               ld b,d
.data:00004b27 42                               ld b,d
.data:00004b28 42                               ld b,d
.data:00004b29 42                               ld b,d
.data:00004b2a 42                               ld b,d
.data:00004b2b 42                               ld b,d
.data:00004b2c 42                               ld b,d
.data:00004b2d 5a                               ld e,d
.data:00004b2e 42                               ld b,d
.data:00004b2f 42                               ld b,d
.data:00004b30 42                               ld b,d
.data:00004b31 42                               ld b,d
.data:00004b32 42                               ld b,d
.data:00004b33 42                               ld b,d
.data:00004b34 59                               ld e,c
.data:00004b35 42                               ld b,d
.data:00004b36 58                               ld e,b
.data:00004b37 42                               ld b,d
.data:00004b38 42                               ld b,d
.data:00004b39 42                               ld b,d
.data:00004b3a 58                               ld e,b
.data:00004b3b 42                               ld b,d
.data:00004b3c 42                               ld b,d
.data:00004b3d 59                               ld e,c
.data:00004b3e 42                               ld b,d
.data:00004b3f 42                               ld b,d
.data:00004b40 58                               ld e,b
.data:00004b41 42                               ld b,d
.data:00004b42 42                               ld b,d
.data:00004b43 42                               ld b,d
.data:00004b44 42                               ld b,d
.data:00004b45 59                               ld e,c
.data:00004b46 42                               ld b,d
.data:00004b47 5a                               ld e,d
.data:00004b48 42                               ld b,d
.data:00004b49 58                               ld e,b
.data:00004b4a 42                               ld b,d
.data:00004b4b 42                               ld b,d
.data:00004b4c 42                               ld b,d
.data:00004b4d 42                               ld b,d
.data:00004b4e 58                               ld e,b
.data:00004b4f 42                               ld b,d
.data:00004b50 42                               ld b,d
.data:00004b51 42                               ld b,d
.data:00004b52 59                               ld e,c
.data:00004b53 42                               ld b,d
.data:00004b54 42                               ld b,d
.data:00004b55 5a                               ld e,d
.data:00004b56 42                               ld b,d
.data:00004b57 42                               ld b,d
.data:00004b58 58                               ld e,b
.data:00004b59 59                               ld e,c
.data:00004b5a 42                               ld b,d
.data:00004b5b 42                               ld b,d
.data:00004b5c 20 54                            jr nz,0x4bb2
.data:00004b5e 55                               ld d,l
.data:00004b5f 20 46                            jr nz,0x4ba7
.data:00004b61 46                               ld b,(hl)
.data:00004b62 46                               ld b,(hl)
.data:00004b63 46                               ld b,(hl)
.data:00004b64 46                               ld b,(hl)
.data:00004b65 46                               ld b,(hl)
.data:00004b66 46                               ld b,(hl)
.data:00004b67 46                               ld b,(hl)
.data:00004b68 46                               ld b,(hl)
.data:00004b69 46                               ld b,(hl)
.data:00004b6a 20 54                            jr nz,0x4bc0
.data:00004b6c 55                               ld d,l
.data:00004b6d 20 46                            jr nz,0x4bb5
.data:00004b6f 46                               ld b,(hl)
.data:00004b70 46                               ld b,(hl)
.data:00004b71 46                               ld b,(hl)
.data:00004b72 46                               ld b,(hl)
.data:00004b73 46                               ld b,(hl)
.data:00004b74 46                               ld b,(hl)
.data:00004b75 46                               ld b,(hl)
.data:00004b76 46                               ld b,(hl)
.data:00004b77 46                               ld b,(hl)
.data:00004b78 20 54                            jr nz,0x4bce
.data:00004b7a 55                               ld d,l
.data:00004b7b 20 20                            jr nz,0x4b9d
.data:00004b7d 56                               ld d,(hl)
.data:00004b7e 57                               ld d,a
.data:00004b7f 20 46                            jr nz,0x4bc7
.data:00004b81 46                               ld b,(hl)
.data:00004b82 46                               ld b,(hl)
.data:00004b83 46                               ld b,(hl)
.data:00004b84 46                               ld b,(hl)
.data:00004b85 46                               ld b,(hl)
.data:00004b86 46                               ld b,(hl)
.data:00004b87 46                               ld b,(hl)
.data:00004b88 46                               ld b,(hl)
.data:00004b89 24                               inc h
.data:00004b8a 26 56                            ld h,0x56
.data:00004b8c 57                               ld d,a
.data:00004b8d 24                               inc h
.data:00004b8e 26 46                            ld h,0x46
.data:00004b90 46                               ld b,(hl)
.data:00004b91 46                               ld b,(hl)
.data:00004b92 46                               ld b,(hl)
.data:00004b93 46                               ld b,(hl)
.data:00004b94 46                               ld b,(hl)
.data:00004b95 46                               ld b,(hl)
.data:00004b96 46                               ld b,(hl)
.data:00004b97 46                               ld b,(hl)
.data:00004b98 20 56                            jr nz,0x4bf0
.data:00004b9a 57                               ld d,a
.data:00004b9b 20 20                            jr nz,0x4bbd
.data:00004b9d 20 20                            jr nz,0x4bbf
.data:00004b9f 20 46                            jr nz,0x4be7
.data:00004ba1 46                               ld b,(hl)
.data:00004ba2 46                               ld b,(hl)
.data:00004ba3 46                               ld b,(hl)
.data:00004ba4 46                               ld b,(hl)
.data:00004ba5 46                               ld b,(hl)
.data:00004ba6 46                               ld b,(hl)
.data:00004ba7 46                               ld b,(hl)
.data:00004ba8 46                               ld b,(hl)
.data:00004ba9 46                               ld b,(hl)
.data:00004baa 20 20                            jr nz,0x4bcc
.data:00004bac 20 20                            jr nz,0x4bce
.data:00004bae 46                               ld b,(hl)
.data:00004baf 46                               ld b,(hl)
.data:00004bb0 46                               ld b,(hl)
.data:00004bb1 46                               ld b,(hl)
.data:00004bb2 46                               ld b,(hl)
.data:00004bb3 46                               ld b,(hl)
.data:00004bb4 46                               ld b,(hl)
.data:00004bb5 46                               ld b,(hl)
.data:00004bb6 46                               ld b,(hl)
.data:00004bb7 46                               ld b,(hl)
.data:00004bb8 20 20                            jr nz,0x4bda
.data:00004bba 20 20                            jr nz,0x4bdc
.data:00004bbc 0b                               dec bc
.data:00004bbd 05                               dec b
.data:00004bbe 05                               dec b
.data:00004bbf 05                               dec b
.data:00004bc0 05                               dec b
.data:00004bc1 05                               dec b
.data:00004bc2 05                               dec b
.data:00004bc3 05                               dec b
.data:00004bc4 05                               dec b
.data:00004bc5 05                               dec b
.data:00004bc6 05                               dec b
.data:00004bc7 05                               dec b
.data:00004bc8 05                               dec b
.data:00004bc9 05                               dec b
.data:00004bca 05                               dec b
.data:00004bcb 05                               dec b
.data:00004bcc 05                               dec b
.data:00004bcd 0b                               dec bc
.data:00004bce 05                               dec b
.data:00004bcf 05                               dec b
.data:00004bd0 05                               dec b
.data:00004bd1 05                               dec b
.data:00004bd2 05                               dec b
.data:00004bd3 05                               dec b
.data:00004bd4 05                               dec b
.data:00004bd5 05                               dec b
.data:00004bd6 05                               dec b
.data:00004bd7 05                               dec b
.data:00004bd8 05                               dec b
.data:00004bd9 05                               dec b
.data:00004bda 05                               dec b
.data:00004bdb 05                               dec b
.data:00004bdc 02                               ld (bc),a
.data:00004bdd 2e 40                            ld l,0x40
.data:00004bdf 2e 40                            ld l,0x40
.data:00004be1 2e 40                            ld l,0x40
.data:00004be3 2e 40                            ld l,0x40
.data:00004be5 2e 40                            ld l,0x40
.data:00004be7 2e 40                            ld l,0x40
.data:00004be9 2e 40                            ld l,0x40
.data:00004beb 2e 40                            ld l,0x40
.data:00004bed 03                               inc bc
.data:00004bee 3c                               inc a
.data:00004bef 2e 40                            ld l,0x40
.data:00004bf1 2e 40                            ld l,0x40
.data:00004bf3 2e 40                            ld l,0x40
.data:00004bf5 2e 40                            ld l,0x40
.data:00004bf7 2e 40                            ld l,0x40
.data:00004bf9 2e 40                            ld l,0x40
.data:00004bfb 2e 02                            ld l,0x02
.data:00004bfd 40                               ld b,b
.data:00004bfe 09                               add hl,bc
.data:00004bff 05                               dec b
.data:00004c00 05                               dec b
.data:00004c01 0a                               ld a,(bc)
.data:00004c02 2e 09                            ld l,0x09
.data:00004c04 05                               dec b
.data:00004c05 05                               dec b
.data:00004c06 0a                               ld a,(bc)
.data:00004c07 40                               ld b,b
.data:00004c08 09                               add hl,bc
.data:00004c09 05                               dec b
.data:00004c0a 05                               dec b
.data:00004c0b 0a                               ld a,(bc)
.data:00004c0c 2e 40                            ld l,0x40
.data:00004c0e 01 40 2e                         ld bc,0x2e40
.data:00004c11 40                               ld b,b
.data:00004c12 2e 40                            ld l,0x40
.data:00004c14 2e 40                            ld l,0x40
.data:00004c16 2e 40                            ld l,0x40
.data:00004c18 2e 40                            ld l,0x40
.data:00004c1a 2e 40                            ld l,0x40
.data:00004c1c 02                               ld (bc),a
.data:00004c1d 2e 02                            ld l,0x02
.data:00004c1f 40                               ld b,b
.data:00004c20 40                               ld b,b
.data:00004c21 02                               ld (bc),a
.data:00004c22 40                               ld b,b
.data:00004c23 02                               ld (bc),a
.data:00004c24 40                               ld b,b
.data:00004c25 2e 03                            ld l,0x03
.data:00004c27 2e 02                            ld l,0x02
.data:00004c29 bf                               cp a
.data:00004c2a bf                               cp a
.data:00004c2b 02                               ld (bc),a
.data:00004c2c 40                               ld b,b
.data:00004c2d 2e 02                            ld l,0x02
.data:00004c2f 2e 40                            ld l,0x40
.data:00004c31 2e 09                            ld l,0x09
.data:00004c33 06 50                            ld b,0x50
.data:00004c35 38 51                            jr c,0x4c88
.data:00004c37 04                               inc b
.data:00004c38 0a                               ld a,(bc)
.data:00004c39 2e 40                            ld l,0x40
.data:00004c3b 2e 02                            ld l,0x02
.data:00004c3d 40                               ld b,b
.data:00004c3e 0d                               dec c
.data:00004c3f 05                               dec b
.data:00004c40 0b                               dec bc
.data:00004c41 08                               ex af,af'
.data:00004c42 2e 02                            ld l,0x02
.data:00004c44 2e 40                            ld l,0x40
.data:00004c46 2e 40                            ld l,0x40
.data:00004c48 0d                               dec c
.data:00004c49 05                               dec b
.data:00004c4a 0b                               dec bc
.data:00004c4b 08                               ex af,af'
.data:00004c4c 2e 40                            ld l,0x40
.data:00004c4e 02                               ld (bc),a
.data:00004c4f 40                               ld b,b
.data:00004c50 2e 40                            ld l,0x40
.data:00004c52 02                               ld (bc),a
.data:00004c53 bf                               cp a
.data:00004c54 bf                               cp a
.data:00004c55 bf                               cp a
.data:00004c56 bf                               cp a
.data:00004c57 bf                               cp a
.data:00004c58 02                               ld (bc),a
.data:00004c59 40                               ld b,b
.data:00004c5a 2e 40                            ld l,0x40
.data:00004c5c 02                               ld (bc),a
.data:00004c5d 2e 02                            ld l,0x02
.data:00004c5f 2e 03                            ld l,0x03
.data:00004c61 40                               ld b,b
.data:00004c62 40                               ld b,b
.data:00004c63 02                               ld (bc),a
.data:00004c64 40                               ld b,b
.data:00004c65 04                               inc b
.data:00004c66 0a                               ld a,(bc)
.data:00004c67 2e 02                            ld l,0x02
.data:00004c69 2e 03                            ld l,0x03
.data:00004c6b 2e 40                            ld l,0x40
.data:00004c6d 2e 02                            ld l,0x02
.data:00004c6f 2e 40                            ld l,0x40
.data:00004c71 2e 07                            ld l,0x07
.data:00004c73 05                               dec b
.data:00004c74 05                               dec b
.data:00004c75 05                               dec b
.data:00004c76 05                               dec b
.data:00004c77 05                               dec b
.data:00004c78 08                               ex af,af'
.data:00004c79 2e 40                            ld l,0x40
.data:00004c7b 2e 02                            ld l,0x02
.data:00004c7d 40                               ld b,b
.data:00004c7e 03                               inc bc
.data:00004c7f 40                               ld b,b
.data:00004c80 2e 00                            ld l,0x00
.data:00004c82 2e 07                            ld l,0x07
.data:00004c84 05                               dec b
.data:00004c85 05                               dec b
.data:00004c86 08                               ex af,af'
.data:00004c87 40                               ld b,b
.data:00004c88 03                               inc bc
.data:00004c89 40                               ld b,b
.data:00004c8a 2e 00                            ld l,0x00
.data:00004c8c 2e 40                            ld l,0x40
.data:00004c8e 03                               inc bc
.data:00004c8f 40                               ld b,b
.data:00004c90 2e 40                            ld l,0x40
.data:00004c92 2e 40                            ld l,0x40
.data:00004c94 2e 40                            ld l,0x40
.data:00004c96 2e 40                            ld l,0x40
.data:00004c98 2e 40                            ld l,0x40
.data:00004c9a 2e 40                            ld l,0x40
.data:00004c9c 02                               ld (bc),a
.data:00004c9d 2e 40                            ld l,0x40
.data:00004c9f 2e 40                            ld l,0x40
.data:00004ca1 2e 40                            ld l,0x40
.data:00004ca3 2e 40                            ld l,0x40
.data:00004ca5 2e 40                            ld l,0x40
.data:00004ca7 2e 40                            ld l,0x40
.data:00004ca9 2e 40                            ld l,0x40
.data:00004cab 2e 40                            ld l,0x40
.data:00004cad 2e 40                            ld l,0x40
.data:00004caf 2e 40                            ld l,0x40
.data:00004cb1 2e 40                            ld l,0x40
.data:00004cb3 2e 40                            ld l,0x40
.data:00004cb5 2e 40                            ld l,0x40
.data:00004cb7 2e 40                            ld l,0x40
.data:00004cb9 2e 40                            ld l,0x40
.data:00004cbb 2e 02                            ld l,0x02
.data:00004cbd 40                               ld b,b
.data:00004cbe 09                               add hl,bc
.data:00004cbf 05                               dec b
.data:00004cc0 05                               dec b
.data:00004cc1 0a                               ld a,(bc)
.data:00004cc2 2e 40                            ld l,0x40
.data:00004cc4 2e 36                            ld l,0x36
.data:00004cc6 34                               inc (hl)
.data:00004cc7 40                               ld b,b
.data:00004cc8 2e 40                            ld l,0x40
.data:00004cca 36 34                            ld (hl),0x34
.data:00004ccc 2e 34                            ld l,0x34
.data:00004cce 35                               dec (hl)
.data:00004ccf 35                               dec (hl)
.data:00004cd0 35                               dec (hl)
.data:00004cd1 35                               dec (hl)
.data:00004cd2 35                               dec (hl)
.data:00004cd3 40                               ld b,b
.data:00004cd4 2e 40                            ld l,0x40
.data:00004cd6 35                               dec (hl)
.data:00004cd7 35                               dec (hl)
.data:00004cd8 35                               dec (hl)
.data:00004cd9 35                               dec (hl)
.data:00004cda 35                               dec (hl)
.data:00004cdb 40                               ld b,b
.data:00004cdc 02                               ld (bc),a
.data:00004cdd 2e 02                            ld l,0x02
.data:00004cdf 40                               ld b,b
.data:00004ce0 40                               ld b,b
.data:00004ce1 02                               ld (bc),a
.data:00004ce2 40                               ld b,b
.data:00004ce3 01 40 33                         ld bc,0x3340
.data:00004ce6 36 34                            ld (hl),0x34
.data:00004ce8 40                               ld b,b
.data:00004ce9 36 33                            ld (hl),0x33
.data:00004ceb 34                               inc (hl)
.data:00004cec 40                               ld b,b
.data:00004ced 36 40                            ld (hl),0x40
.data:00004cef 40                               ld b,b
.data:00004cf0 40                               ld b,b
.data:00004cf1 40                               ld b,b
.data:00004cf2 33                               inc sp
.data:00004cf3 35                               dec (hl)
.data:00004cf4 40                               ld b,b
.data:00004cf5 34                               inc (hl)
.data:00004cf6 40                               ld b,b
.data:00004cf7 40                               ld b,b
.data:00004cf8 40                               ld b,b
.data:00004cf9 40                               ld b,b
.data:00004cfa 33                               inc sp
.data:00004cfb 35                               dec (hl)
.data:00004cfc 02                               ld (bc),a
.data:00004cfd 40                               ld b,b
.data:00004cfe 0d                               dec c
.data:00004cff 05                               dec b
.data:00004d00 05                               dec b
.data:00004d01 08                               ex af,af'
.data:00004d02 2e 02                            ld l,0x02
.data:00004d04 2e 33                            ld l,0x33
.data:00004d06 2e 36                            ld l,0x36
.data:00004d08 36 33                            ld (hl),0x33
.data:00004d0a 2e 34                            ld l,0x34
.data:00004d0c 2e 36                            ld l,0x36
.data:00004d0e 36 36                            ld (hl),0x36
.data:00004d10 36 36                            ld (hl),0x36
.data:00004d12 34                               inc (hl)
.data:00004d13 33                               inc sp
.data:00004d14 2e 34                            ld l,0x34
.data:00004d16 40                               ld b,b
.data:00004d17 40                               ld b,b
.data:00004d18 40                               ld b,b
.data:00004d19 40                               ld b,b
.data:00004d1a 36 33                            ld (hl),0x33
.data:00004d1c 02                               ld (bc),a
.data:00004d1d 2e 02                            ld l,0x02
.data:00004d1f 2e 40                            ld l,0x40
.data:00004d21 2e 40                            ld l,0x40
.data:00004d23 02                               ld (bc),a
.data:00004d24 40                               ld b,b
.data:00004d25 33                               inc sp
.data:00004d26 40                               ld b,b
.data:00004d27 2e 40                            ld l,0x40
.data:00004d29 2e 40                            ld l,0x40
.data:00004d2b 34                               inc (hl)
.data:00004d2c 40                               ld b,b
.data:00004d2d 33                               inc sp
.data:00004d2e 40                               ld b,b
.data:00004d2f 2e 40                            ld l,0x40
.data:00004d31 2e 34                            ld l,0x34
.data:00004d33 33                               inc sp
.data:00004d34 40                               ld b,b
.data:00004d35 34                               inc (hl)
.data:00004d36 40                               ld b,b
.data:00004d37 40                               ld b,b
.data:00004d38 40                               ld b,b
.data:00004d39 40                               ld b,b
.data:00004d3a 33                               inc sp
.data:00004d3b 35                               dec (hl)
.data:00004d3c 02                               ld (bc),a
.data:00004d3d 40                               ld b,b
.data:00004d3e 03                               inc bc
.data:00004d3f 40                               ld b,b
.data:00004d40 2e 40                            ld l,0x40
.data:00004d42 2e 02                            ld l,0x02
.data:00004d44 3c                               inc a
.data:00004d45 33                               inc sp
.data:00004d46 2e 40                            ld l,0x40
.data:00004d48 2e 40                            ld l,0x40
.data:00004d4a 2e 36                            ld l,0x36
.data:00004d4c 2e 33                            ld l,0x33
.data:00004d4e 2e 40                            ld l,0x40
.data:00004d50 2e 40                            ld l,0x40
.data:00004d52 36 33                            ld (hl),0x33
.data:00004d54 2e 36                            ld l,0x36
.data:00004d56 36 36                            ld (hl),0x36
.data:00004d58 36 36                            ld (hl),0x36
.data:00004d5a 36 33                            ld (hl),0x33
.data:00004d5c 02                               ld (bc),a
.data:00004d5d 2e 40                            ld l,0x40
.data:00004d5f 2e 40                            ld l,0x40
.data:00004d61 2e 40                            ld l,0x40
.data:00004d63 02                               ld (bc),a
.data:00004d64 40                               ld b,b
.data:00004d65 2e 40                            ld l,0x40
.data:00004d67 2e 40                            ld l,0x40
.data:00004d69 2e 40                            ld l,0x40
.data:00004d6b 2e 40                            ld l,0x40
.data:00004d6d 2e 40                            ld l,0x40
.data:00004d6f 2e 40                            ld l,0x40
.data:00004d71 2e 40                            ld l,0x40
.data:00004d73 2e 40                            ld l,0x40
.data:00004d75 2e 40                            ld l,0x40
.data:00004d77 2e 40                            ld l,0x40
.data:00004d79 2e 40                            ld l,0x40
.data:00004d7b 2e 02                            ld l,0x02
.data:00004d7d 40                               ld b,b
.data:00004d7e 2e 04                            ld l,0x04
.data:00004d80 06 40                            ld b,0x40
.data:00004d82 2e 02                            ld l,0x02
.data:00004d84 2e 36                            ld l,0x36
.data:00004d86 34                               inc (hl)
.data:00004d87 40                               ld b,b
.data:00004d88 2e 40                            ld l,0x40
.data:00004d8a 36 34                            ld (hl),0x34
.data:00004d8c 2e 40                            ld l,0x40
.data:00004d8e 2e 34                            ld l,0x34
.data:00004d90 35                               dec (hl)
.data:00004d91 40                               ld b,b
.data:00004d92 2e 40                            ld l,0x40
.data:00004d94 2e 34                            ld l,0x34
.data:00004d96 35                               dec (hl)
.data:00004d97 40                               ld b,b
.data:00004d98 2e 40                            ld l,0x40
.data:00004d9a 35                               dec (hl)
.data:00004d9b 35                               dec (hl)
.data:00004d9c 02                               ld (bc),a
.data:00004d9d 2e 01                            ld l,0x01
.data:00004d9f 40                               ld b,b
.data:00004da0 40                               ld b,b
.data:00004da1 01 40 02                         ld bc,0x0240
.data:00004da4 40                               ld b,b
.data:00004da5 33                               inc sp
.data:00004da6 36 34                            ld (hl),0x34
.data:00004da8 40                               ld b,b
.data:00004da9 36 33                            ld (hl),0x33
.data:00004dab 34                               inc (hl)
.data:00004dac 40                               ld b,b
.data:00004dad 2e 40                            ld l,0x40
.data:00004daf 34                               inc (hl)
.data:00004db0 33                               inc sp
.data:00004db1 2e 40                            ld l,0x40
.data:00004db3 2e 40                            ld l,0x40
.data:00004db5 36 36                            ld (hl),0x36
.data:00004db7 36 34                            ld (hl),0x34
.data:00004db9 36 36                            ld (hl),0x36
.data:00004dbb 33                               inc sp
.data:00004dbc 02                               ld (bc),a
.data:00004dbd 40                               ld b,b
.data:00004dbe 0d                               dec c
.data:00004dbf 05                               dec b
.data:00004dc0 05                               dec b
.data:00004dc1 0e 2e                            ld c,0x2e
.data:00004dc3 02                               ld (bc),a
.data:00004dc4 2e 33                            ld l,0x33
.data:00004dc6 2e 36                            ld l,0x36
.data:00004dc8 36 33                            ld (hl),0x33
.data:00004dca 2e 34                            ld l,0x34
.data:00004dcc 2e 40                            ld l,0x40
.data:00004dce 2e 34                            ld l,0x34
.data:00004dd0 33                               inc sp
.data:00004dd1 40                               ld b,b
.data:00004dd2 2e 40                            ld l,0x40
.data:00004dd4 2e 40                            ld l,0x40
.data:00004dd6 2e 36                            ld l,0x36
.data:00004dd8 36 33                            ld (hl),0x33
.data:00004dda 2e 40                            ld l,0x40
.data:00004ddc 02                               ld (bc),a
.data:00004ddd 2e 02                            ld l,0x02
.data:00004ddf 2e 40                            ld l,0x40
.data:00004de1 02                               ld (bc),a
.data:00004de2 40                               ld b,b
.data:00004de3 02                               ld (bc),a
.data:00004de4 40                               ld b,b
.data:00004de5 33                               inc sp
.data:00004de6 40                               ld b,b
.data:00004de7 2e 40                            ld l,0x40
.data:00004de9 2e 40                            ld l,0x40
.data:00004deb 34                               inc (hl)
.data:00004dec 40                               ld b,b
.data:00004ded 2e 40                            ld l,0x40
.data:00004def 36 33                            ld (hl),0x33
.data:00004df1 2e 40                            ld l,0x40
.data:00004df3 2e 40                            ld l,0x40
.data:00004df5 34                               inc (hl)
.data:00004df6 36 33                            ld (hl),0x33
.data:00004df8 36 36                            ld (hl),0x36
.data:00004dfa 34                               inc (hl)
.data:00004dfb 33                               inc sp
.data:00004dfc 02                               ld (bc),a
.data:00004dfd 40                               ld b,b
.data:00004dfe 03                               inc bc
.data:00004dff 40                               ld b,b
.data:00004e00 2e 03                            ld l,0x03
.data:00004e02 2e 02                            ld l,0x02
.data:00004e04 3c                               inc a
.data:00004e05 33                               inc sp
.data:00004e06 2e 40                            ld l,0x40
.data:00004e08 2e 40                            ld l,0x40
.data:00004e0a 2e 36                            ld l,0x36
.data:00004e0c 2e 40                            ld l,0x40
.data:00004e0e 2e 36                            ld l,0x36
.data:00004e10 33                               inc sp
.data:00004e11 40                               ld b,b
.data:00004e12 2e 40                            ld l,0x40
.data:00004e14 2e 36                            ld l,0x36
.data:00004e16 33                               inc sp
.data:00004e17 40                               ld b,b
.data:00004e18 2e 40                            ld l,0x40
.data:00004e1a 36 33                            ld (hl),0x33
.data:00004e1c 02                               ld (bc),a
.data:00004e1d 2e 40                            ld l,0x40
.data:00004e1f 2e 40                            ld l,0x40
.data:00004e21 2e 40                            ld l,0x40
.data:00004e23 02                               ld (bc),a
.data:00004e24 40                               ld b,b
.data:00004e25 2e 40                            ld l,0x40
.data:00004e27 2e 40                            ld l,0x40
.data:00004e29 2e 40                            ld l,0x40
.data:00004e2b 2e 40                            ld l,0x40
.data:00004e2d 2e 40                            ld l,0x40
.data:00004e2f 2e 40                            ld l,0x40
.data:00004e31 2e 40                            ld l,0x40
.data:00004e33 2e 40                            ld l,0x40
.data:00004e35 2e 40                            ld l,0x40
.data:00004e37 2e 40                            ld l,0x40
.data:00004e39 2e 40                            ld l,0x40
.data:00004e3b 2e 0c                            ld l,0x0c
.data:00004e3d 05                               dec b
.data:00004e3e 05                               dec b
.data:00004e3f 05                               dec b
.data:00004e40 05                               dec b
.data:00004e41 05                               dec b
.data:00004e42 05                               dec b
.data:00004e43 0c                               inc c
.data:00004e44 05                               dec b
.data:00004e45 05                               dec b
.data:00004e46 05                               dec b
.data:00004e47 05                               dec b
.data:00004e48 05                               dec b
.data:00004e49 05                               dec b
.data:00004e4a 05                               dec b
.data:00004e4b 05                               dec b
.data:00004e4c 05                               dec b
.data:00004e4d 05                               dec b
.data:00004e4e 05                               dec b
.data:00004e4f 05                               dec b
.data:00004e50 05                               dec b
.data:00004e51 05                               dec b
.data:00004e52 05                               dec b
.data:00004e53 05                               dec b
.data:00004e54 05                               dec b
.data:00004e55 05                               dec b
.data:00004e56 05                               dec b
.data:00004e57 05                               dec b
.data:00004e58 05                               dec b
.data:00004e59 05                               dec b
.data:00004e5a 05                               dec b
.data:00004e5b 05                               dec b
.data:00004e5c 29                               add hl,hl
.data:00004e5d 25                               dec h
.data:00004e5e 25                               dec h
.data:00004e5f 25                               dec h
.data:00004e60 25                               dec h
.data:00004e61 25                               dec h
.data:00004e62 25                               dec h
.data:00004e63 25                               dec h
.data:00004e64 25                               dec h
.data:00004e65 25                               dec h
.data:00004e66 25                               dec h
.data:00004e67 25                               dec h
.data:00004e68 25                               dec h
.data:00004e69 25                               dec h
.data:00004e6a 25                               dec h
.data:00004e6b 25                               dec h
.data:00004e6c 25                               dec h
.data:00004e6d 25                               dec h
.data:00004e6e 25                               dec h
.data:00004e6f 25                               dec h
.data:00004e70 25                               dec h
.data:00004e71 25                               dec h
.data:00004e72 25                               dec h
.data:00004e73 25                               dec h
.data:00004e74 25                               dec h
.data:00004e75 25                               dec h
.data:00004e76 25                               dec h
.data:00004e77 25                               dec h
.data:00004e78 25                               dec h
.data:00004e79 25                               dec h
.data:00004e7a 25                               dec h
.data:00004e7b 2a 22 2f                         ld hl,(0x2f22)
.data:00004e7e c1                               pop bc
.data:00004e7f 2f                               cpl
.data:00004e80 c1                               pop bc
.data:00004e81 2f                               cpl
.data:00004e82 c1                               pop bc
.data:00004e83 2f                               cpl
.data:00004e84 c1                               pop bc
.data:00004e85 2f                               cpl
.data:00004e86 c1                               pop bc
.data:00004e87 2f                               cpl
.data:00004e88 c1                               pop bc
.data:00004e89 2f                               cpl
.data:00004e8a c1                               pop bc
.data:00004e8b 2f                               cpl
.data:00004e8c c1                               pop bc
.data:00004e8d 2f                               cpl
.data:00004e8e c1                               pop bc
.data:00004e8f 2f                               cpl
.data:00004e90 c1                               pop bc
.data:00004e91 2f                               cpl
.data:00004e92 c1                               pop bc
.data:00004e93 2f                               cpl
.data:00004e94 c1                               pop bc
.data:00004e95 2f                               cpl
.data:00004e96 c1                               pop bc
.data:00004e97 2f                               cpl
.data:00004e98 c1                               pop bc
.data:00004e99 2f                               cpl
.data:00004e9a c1                               pop bc
.data:00004e9b 22 22 c1                         ld (0xc122),hl
.data:00004e9e 2f                               cpl
.data:00004e9f c1                               pop bc
.data:00004ea0 2f                               cpl
.data:00004ea1 c1                               pop bc
.data:00004ea2 2f                               cpl
.data:00004ea3 41                               ld b,c
.data:00004ea4 2f                               cpl
.data:00004ea5 c1                               pop bc
.data:00004ea6 2f                               cpl
.data:00004ea7 c1                               pop bc
.data:00004ea8 2f                               cpl
.data:00004ea9 c1                               pop bc
.data:00004eaa 2f                               cpl
.data:00004eab c1                               pop bc
.data:00004eac 2f                               cpl
.data:00004ead c1                               pop bc
.data:00004eae 2f                               cpl
.data:00004eaf c1                               pop bc
.data:00004eb0 2f                               cpl
.data:00004eb1 c1                               pop bc
.data:00004eb2 2f                               cpl
.data:00004eb3 c1                               pop bc
.data:00004eb4 2f                               cpl
.data:00004eb5 c1                               pop bc
.data:00004eb6 2f                               cpl
.data:00004eb7 c1                               pop bc
.data:00004eb8 2f                               cpl
.data:00004eb9 c1                               pop bc
.data:00004eba 2f                               cpl
.data:00004ebb 22 22 2f                         ld (0x2f22),hl
.data:00004ebe c1                               pop bc
.data:00004ebf 2f                               cpl
.data:00004ec0 21 37 21                         ld hl,0x2137
.data:00004ec3 2f                               cpl
.data:00004ec4 c1                               pop bc
.data:00004ec5 2f                               cpl
.data:00004ec6 c1                               pop bc
.data:00004ec7 2f                               cpl
.data:00004ec8 c1                               pop bc
.data:00004ec9 2f                               cpl
.data:00004eca c1                               pop bc
.data:00004ecb 2f                               cpl
.data:00004ecc c1                               pop bc
.data:00004ecd 2f                               cpl
.data:00004ece c1                               pop bc
.data:00004ecf 2f                               cpl
.data:00004ed0 c1                               pop bc
.data:00004ed1 2f                               cpl
.data:00004ed2 c1                               pop bc
.data:00004ed3 2f                               cpl
.data:00004ed4 c1                               pop bc
.data:00004ed5 21 37 21                         ld hl,0x2137
.data:00004ed8 41                               ld b,c
.data:00004ed9 2f                               cpl
.data:00004eda 41                               ld b,c
.data:00004edb 22 22 41                         ld (0x4122),hl
.data:00004ede 2f                               cpl
.data:00004edf 41                               ld b,c
.data:00004ee0 22 37 22                         ld (0x2237),hl
.data:00004ee3 c1                               pop bc
.data:00004ee4 2f                               cpl
.data:00004ee5 c1                               pop bc
.data:00004ee6 2f                               cpl
.data:00004ee7 c1                               pop bc
.data:00004ee8 2f                               cpl
.data:00004ee9 c1                               pop bc
.data:00004eea 2f                               cpl
.data:00004eeb c1                               pop bc
.data:00004eec 2f                               cpl
.data:00004eed c1                               pop bc
.data:00004eee 2f                               cpl
.data:00004eef c1                               pop bc
.data:00004ef0 2f                               cpl
.data:00004ef1 c1                               pop bc
.data:00004ef2 2f                               cpl
.data:00004ef3 c1                               pop bc
.data:00004ef4 2f                               cpl
.data:00004ef5 22 37 22                         ld (0x2237),hl
.data:00004ef8 2f                               cpl
.data:00004ef9 41                               ld b,c
.data:00004efa 2f                               cpl
.data:00004efb 22 22 2f                         ld (0x2f22),hl
.data:00004efe 41                               ld b,c
.data:00004eff 2f                               cpl
.data:00004f00 22 37 22                         ld (0x2237),hl
.data:00004f03 2f                               cpl
.data:00004f04 c1                               pop bc
.data:00004f05 2f                               cpl
.data:00004f06 c1                               pop bc
.data:00004f07 2f                               cpl
.data:00004f08 c1                               pop bc
.data:00004f09 2f                               cpl
.data:00004f0a c1                               pop bc
.data:00004f0b 2f                               cpl
.data:00004f0c c1                               pop bc
.data:00004f0d c1                               pop bc
.data:00004f0e c1                               pop bc
.data:00004f0f 2f                               cpl
.data:00004f10 c1                               pop bc
.data:00004f11 2f                               cpl
.data:00004f12 c1                               pop bc
.data:00004f13 2f                               cpl
.data:00004f14 c1                               pop bc
.data:00004f15 22 37 22                         ld (0x2237),hl
.data:00004f18 41                               ld b,c
.data:00004f19 2f                               cpl
.data:00004f1a 41                               ld b,c
.data:00004f1b 22 22 41                         ld (0x4122),hl
.data:00004f1e 2f                               cpl
.data:00004f1f 41                               ld b,c
.data:00004f20 22 37 22                         ld (0x2237),hl
.data:00004f23 c1                               pop bc
.data:00004f24 2f                               cpl
.data:00004f25 c1                               pop bc
.data:00004f26 2f                               cpl
.data:00004f27 c1                               pop bc
.data:00004f28 2f                               cpl
.data:00004f29 c1                               pop bc
.data:00004f2a 2f                               cpl
.data:00004f2b 24                               inc h
.data:00004f2c 2a 38 29                         ld hl,(0x2938)
.data:00004f2f 26 2f                            ld h,0x2f
.data:00004f31 c1                               pop bc
.data:00004f32 2f                               cpl
.data:00004f33 c1                               pop bc
.data:00004f34 2f                               cpl
.data:00004f35 22 37 22                         ld (0x2237),hl
.data:00004f38 2f                               cpl
.data:00004f39 41                               ld b,c
.data:00004f3a 2f                               cpl
.data:00004f3b 22 22 2f                         ld (0x2f22),hl
.data:00004f3e 41                               ld b,c
.data:00004f3f 2f                               cpl
.data:00004f40 22 37 22                         ld (0x2237),hl
.data:00004f43 2f                               cpl
.data:00004f44 c1                               pop bc
.data:00004f45 2f                               cpl
.data:00004f46 c1                               pop bc
.data:00004f47 2f                               cpl
.data:00004f48 c1                               pop bc
.data:00004f49 2f                               cpl
.data:00004f4a c1                               pop bc
.data:00004f4b 2f                               cpl
.data:00004f4c 23                               inc hl
.data:00004f4d 3f                               ccf
.data:00004f4e 23                               inc hl
.data:00004f4f 2f                               cpl
.data:00004f50 c1                               pop bc
.data:00004f51 2f                               cpl
.data:00004f52 c1                               pop bc
.data:00004f53 2f                               cpl
.data:00004f54 c1                               pop bc
.data:00004f55 22 37 22                         ld (0x2237),hl
.data:00004f58 41                               ld b,c
.data:00004f59 2f                               cpl
.data:00004f5a 41                               ld b,c
.data:00004f5b 22 22 41                         ld (0x4122),hl
.data:00004f5e 2f                               cpl
.data:00004f5f 41                               ld b,c
.data:00004f60 22 37 22                         ld (0x2237),hl
.data:00004f63 c1                               pop bc
.data:00004f64 2f                               cpl
.data:00004f65 c1                               pop bc
.data:00004f66 2f                               cpl
.data:00004f67 c1                               pop bc
.data:00004f68 2f                               cpl
.data:00004f69 c1                               pop bc
.data:00004f6a 2f                               cpl
.data:00004f6b 23                               inc hl
.data:00004f6c 3f                               ccf
.data:00004f6d 3f                               ccf
.data:00004f6e 3f                               ccf
.data:00004f6f 23                               inc hl
.data:00004f70 2f                               cpl
.data:00004f71 c1                               pop bc
.data:00004f72 2f                               cpl
.data:00004f73 c1                               pop bc
.data:00004f74 2f                               cpl
.data:00004f75 22 37 22                         ld (0x2237),hl
.data:00004f78 2f                               cpl
.data:00004f79 41                               ld b,c
.data:00004f7a 2f                               cpl
.data:00004f7b 22 22 2f                         ld (0x2f22),hl
.data:00004f7e 41                               ld b,c
.data:00004f7f 2f                               cpl
.data:00004f80 22 37 22                         ld (0x2237),hl
.data:00004f83 2f                               cpl
.data:00004f84 c1                               pop bc
.data:00004f85 2f                               cpl
.data:00004f86 c1                               pop bc
.data:00004f87 2f                               cpl
.data:00004f88 c1                               pop bc
.data:00004f89 2f                               cpl
.data:00004f8a 21 3f 3f                         ld hl,0x3f3f
.data:00004f8d 3f                               ccf
.data:00004f8e 3f                               ccf
.data:00004f8f 3f                               ccf
.data:00004f90 21 2f c1                         ld hl,0xc12f
.data:00004f93 2f                               cpl
.data:00004f94 c1                               pop bc
.data:00004f95 22 37 22                         ld (0x2237),hl
.data:00004f98 41                               ld b,c
.data:00004f99 2f                               cpl
.data:00004f9a 41                               ld b,c
.data:00004f9b 22 22 41                         ld (0x4122),hl
.data:00004f9e 2f                               cpl
.data:00004f9f 41                               ld b,c
.data:00004fa0 22 37 22                         ld (0x2237),hl
.data:00004fa3 41                               ld b,c
.data:00004fa4 2f                               cpl
.data:00004fa5 c1                               pop bc
.data:00004fa6 2f                               cpl
.data:00004fa7 c1                               pop bc
.data:00004fa8 2f                               cpl
.data:00004fa9 c1                               pop bc
.data:00004faa 23                               inc hl
.data:00004fab 3f                               ccf
.data:00004fac 3f                               ccf
.data:00004fad 3f                               ccf
.data:00004fae 3f                               ccf
.data:00004faf 3f                               ccf
.data:00004fb0 23                               inc hl
.data:00004fb1 c1                               pop bc
.data:00004fb2 2f                               cpl
.data:00004fb3 c1                               pop bc
.data:00004fb4 2f                               cpl
.data:00004fb5 22 37 22                         ld (0x2237),hl
.data:00004fb8 2f                               cpl
.data:00004fb9 41                               ld b,c
.data:00004fba 2f                               cpl
.data:00004fbb 22 22 2f                         ld (0x2f22),hl
.data:00004fbe 41                               ld b,c
.data:00004fbf 2f                               cpl
.data:00004fc0 22 37 22                         ld (0x2237),hl
.data:00004fc3 2f                               cpl
.data:00004fc4 c1                               pop bc
.data:00004fc5 2f                               cpl
.data:00004fc6 c1                               pop bc
.data:00004fc7 2f                               cpl
.data:00004fc8 c1                               pop bc
.data:00004fc9 2f                               cpl
.data:00004fca c1                               pop bc
.data:00004fcb 20 3f                            jr nz,0x500c
.data:00004fcd 3f                               ccf
.data:00004fce 3f                               ccf
.data:00004fcf 20 c1                            jr nz,0x4f92
.data:00004fd1 2f                               cpl
.data:00004fd2 c1                               pop bc
.data:00004fd3 2f                               cpl
.data:00004fd4 c1                               pop bc
.data:00004fd5 22 37 22                         ld (0x2237),hl
.data:00004fd8 41                               ld b,c
.data:00004fd9 2f                               cpl
.data:00004fda 41                               ld b,c
.data:00004fdb 22 22 41                         ld (0x4122),hl
.data:00004fde 2f                               cpl
.data:00004fdf 41                               ld b,c
.data:00004fe0 22 37 22                         ld (0x2237),hl
.data:00004fe3 c1                               pop bc
.data:00004fe4 2f                               cpl
.data:00004fe5 c1                               pop bc
.data:00004fe6 2f                               cpl
.data:00004fe7 c1                               pop bc
.data:00004fe8 2f                               cpl
.data:00004fe9 c1                               pop bc
.data:00004fea 2f                               cpl
.data:00004feb c1                               pop bc
.data:00004fec 24                               inc h
.data:00004fed 25                               dec h
.data:00004fee 26 c1                            ld h,0xc1
.data:00004ff0 2f                               cpl
.data:00004ff1 c1                               pop bc
.data:00004ff2 2f                               cpl
.data:00004ff3 c1                               pop bc
.data:00004ff4 2f                               cpl
.data:00004ff5 22 37 22                         ld (0x2237),hl
.data:00004ff8 2f                               cpl
.data:00004ff9 41                               ld b,c
.data:00004ffa 2f                               cpl
.data:00004ffb 22 22 2f                         ld (0x2f22),hl
.data:00004ffe 41                               ld b,c
.data:00004fff 2f                               cpl
.data:00005000 22 37 22                         ld (0x2237),hl
.data:00005003 2f                               cpl
.data:00005004 c1                               pop bc
.data:00005005 2f                               cpl
.data:00005006 c1                               pop bc
.data:00005007 2f                               cpl
.data:00005008 c1                               pop bc
.data:00005009 2f                               cpl
.data:0000500a c1                               pop bc
.data:0000500b 2f                               cpl
.data:0000500c c1                               pop bc
.data:0000500d 2f                               cpl
.data:0000500e c1                               pop bc
.data:0000500f 2f                               cpl
.data:00005010 c1                               pop bc
.data:00005011 2f                               cpl
.data:00005012 c1                               pop bc
.data:00005013 2f                               cpl
.data:00005014 c1                               pop bc
.data:00005015 22 37 22                         ld (0x2237),hl
.data:00005018 41                               ld b,c
.data:00005019 2f                               cpl
.data:0000501a 41                               ld b,c
.data:0000501b 22 22 41                         ld (0x4122),hl
.data:0000501e 2f                               cpl
.data:0000501f 41                               ld b,c
.data:00005020 23                               inc hl
.data:00005021 37                               scf
.data:00005022 23                               inc hl
.data:00005023 c1                               pop bc
.data:00005024 2f                               cpl
.data:00005025 c1                               pop bc
.data:00005026 2f                               cpl
.data:00005027 c1                               pop bc
.data:00005028 2f                               cpl
.data:00005029 c1                               pop bc
.data:0000502a 2f                               cpl
.data:0000502b c1                               pop bc
.data:0000502c 2f                               cpl
.data:0000502d c1                               pop bc
.data:0000502e 2f                               cpl
.data:0000502f c1                               pop bc
.data:00005030 2f                               cpl
.data:00005031 c1                               pop bc
.data:00005032 2f                               cpl
.data:00005033 c1                               pop bc
.data:00005034 2f                               cpl
.data:00005035 23                               inc hl
.data:00005036 37                               scf
.data:00005037 23                               inc hl
.data:00005038 2f                               cpl
.data:00005039 c1                               pop bc
.data:0000503a 2f                               cpl
.data:0000503b 22 23 2f                         ld (0x2f23),hl
.data:0000503e c1                               pop bc
.data:0000503f 2f                               cpl
.data:00005040 c1                               pop bc
.data:00005041 2f                               cpl
.data:00005042 c1                               pop bc
.data:00005043 2f                               cpl
.data:00005044 c1                               pop bc
.data:00005045 2f                               cpl
.data:00005046 c1                               pop bc
.data:00005047 2f                               cpl
.data:00005048 c1                               pop bc
.data:00005049 2f                               cpl
.data:0000504a c1                               pop bc
.data:0000504b 2f                               cpl
.data:0000504c c1                               pop bc
.data:0000504d 2f                               cpl
.data:0000504e c1                               pop bc
.data:0000504f 2f                               cpl
.data:00005050 c1                               pop bc
.data:00005051 2f                               cpl
.data:00005052 c1                               pop bc
.data:00005053 2f                               cpl
.data:00005054 c1                               pop bc
.data:00005055 2f                               cpl
.data:00005056 c1                               pop bc
.data:00005057 2f                               cpl
.data:00005058 c1                               pop bc
.data:00005059 2f                               cpl
.data:0000505a c1                               pop bc
.data:0000505b 23                               inc hl
.data:0000505c 25                               dec h
.data:0000505d 25                               dec h
.data:0000505e 25                               dec h
.data:0000505f 25                               dec h
.data:00005060 25                               dec h
.data:00005061 25                               dec h
.data:00005062 25                               dec h
.data:00005063 25                               dec h
.data:00005064 25                               dec h
.data:00005065 25                               dec h
.data:00005066 25                               dec h
.data:00005067 25                               dec h
.data:00005068 25                               dec h
.data:00005069 25                               dec h
.data:0000506a 26 c1                            ld h,0xc1
.data:0000506c 2f                               cpl
.data:0000506d 3e 2f                            ld a,0x2f
.data:0000506f c1                               pop bc
.data:00005070 24                               inc h
.data:00005071 25                               dec h
.data:00005072 25                               dec h
.data:00005073 25                               dec h
.data:00005074 25                               dec h
.data:00005075 25                               dec h
.data:00005076 25                               dec h
.data:00005077 25                               dec h
.data:00005078 25                               dec h
.data:00005079 25                               dec h
.data:0000507a 25                               dec h
.data:0000507b 25                               dec h
.data:0000507c 3a 3a 3a                         ld a,(0x3a3a)
.data:0000507f 3a 3a 3a                         ld a,(0x3a3a)
.data:00005082 3a 3a 3a                         ld a,(0x3a3a)
.data:00005085 3a 3a 3a                         ld a,(0x3a3a)
.data:00005088 3a 53 c1                         ld a,(0xc153)
.data:0000508b 2f                               cpl
.data:0000508c c1                               pop bc
.data:0000508d 2f                               cpl
.data:0000508e c1                               pop bc
.data:0000508f 2f                               cpl
.data:00005090 c1                               pop bc
.data:00005091 52                               ld d,d
.data:00005092 3a 3a 3a                         ld a,(0x3a3a)
.data:00005095 3a 3a 3a                         ld a,(0x3a3a)
.data:00005098 3a 3a 3a                         ld a,(0x3a3a)
.data:0000509b 3a 25 25                         ld a,(0x2525)
.data:0000509e 25                               dec h
.data:0000509f 25                               dec h
.data:000050a0 25                               dec h
.data:000050a1 25                               dec h
.data:000050a2 25                               dec h
.data:000050a3 25                               dec h
.data:000050a4 25                               dec h
.data:000050a5 25                               dec h
.data:000050a6 25                               dec h
.data:000050a7 25                               dec h
.data:000050a8 25                               dec h
.data:000050a9 25                               dec h
.data:000050aa 25                               dec h
.data:000050ab 25                               dec h
.data:000050ac 25                               dec h
.data:000050ad 25                               dec h
.data:000050ae 25                               dec h
.data:000050af 25                               dec h
.data:000050b0 25                               dec h
.data:000050b1 25                               dec h
.data:000050b2 25                               dec h
.data:000050b3 25                               dec h
.data:000050b4 25                               dec h
.data:000050b5 25                               dec h
.data:000050b6 25                               dec h
.data:000050b7 25                               dec h
.data:000050b8 25                               dec h
.data:000050b9 25                               dec h
.data:000050ba 25                               dec h
.data:000050bb 25                               dec h
.data:000050bc 42                               ld b,d
.data:000050bd 42                               ld b,d
.data:000050be 42                               ld b,d
.data:000050bf 42                               ld b,d
.data:000050c0 42                               ld b,d
.data:000050c1 42                               ld b,d
.data:000050c2 42                               ld b,d
.data:000050c3 42                               ld b,d
.data:000050c4 42                               ld b,d
.data:000050c5 42                               ld b,d
.data:000050c6 42                               ld b,d
.data:000050c7 42                               ld b,d
.data:000050c8 42                               ld b,d
.data:000050c9 42                               ld b,d
.data:000050ca 42                               ld b,d
.data:000050cb 42                               ld b,d
.data:000050cc 42                               ld b,d
.data:000050cd 42                               ld b,d
.data:000050ce 42                               ld b,d
.data:000050cf 42                               ld b,d
.data:000050d0 42                               ld b,d
.data:000050d1 42                               ld b,d
.data:000050d2 42                               ld b,d
.data:000050d3 42                               ld b,d
.data:000050d4 42                               ld b,d
.data:000050d5 42                               ld b,d
.data:000050d6 42                               ld b,d
.data:000050d7 42                               ld b,d
.data:000050d8 42                               ld b,d
.data:000050d9 42                               ld b,d
.data:000050da 42                               ld b,d
.data:000050db 42                               ld b,d
.data:000050dc 42                               ld b,d
.data:000050dd 42                               ld b,d
.data:000050de 42                               ld b,d
.data:000050df 42                               ld b,d
.data:000050e0 42                               ld b,d
.data:000050e1 42                               ld b,d
.data:000050e2 42                               ld b,d
.data:000050e3 42                               ld b,d
.data:000050e4 42                               ld b,d
.data:000050e5 42                               ld b,d
.data:000050e6 42                               ld b,d
.data:000050e7 42                               ld b,d
.data:000050e8 42                               ld b,d
.data:000050e9 42                               ld b,d
.data:000050ea 42                               ld b,d
.data:000050eb 42                               ld b,d
.data:000050ec 42                               ld b,d
.data:000050ed 42                               ld b,d
.data:000050ee 42                               ld b,d
.data:000050ef 42                               ld b,d
.data:000050f0 42                               ld b,d
.data:000050f1 42                               ld b,d
.data:000050f2 42                               ld b,d
.data:000050f3 42                               ld b,d
.data:000050f4 42                               ld b,d
.data:000050f5 42                               ld b,d
.data:000050f6 42                               ld b,d
.data:000050f7 42                               ld b,d
.data:000050f8 42                               ld b,d
.data:000050f9 42                               ld b,d
.data:000050fa 42                               ld b,d
.data:000050fb 42                               ld b,d
.data:000050fc 42                               ld b,d
.data:000050fd 42                               ld b,d
.data:000050fe 42                               ld b,d
.data:000050ff 42                               ld b,d
.data:00005100 42                               ld b,d
.data:00005101 42                               ld b,d
.data:00005102 42                               ld b,d
.data:00005103 42                               ld b,d
.data:00005104 42                               ld b,d
.data:00005105 42                               ld b,d
.data:00005106 42                               ld b,d
.data:00005107 42                               ld b,d
.data:00005108 42                               ld b,d
.data:00005109 42                               ld b,d
.data:0000510a 42                               ld b,d
.data:0000510b 42                               ld b,d
.data:0000510c 42                               ld b,d
.data:0000510d 42                               ld b,d
.data:0000510e 42                               ld b,d
.data:0000510f 42                               ld b,d
.data:00005110 42                               ld b,d
.data:00005111 42                               ld b,d
.data:00005112 42                               ld b,d
.data:00005113 42                               ld b,d
.data:00005114 42                               ld b,d
.data:00005115 42                               ld b,d
.data:00005116 42                               ld b,d
.data:00005117 42                               ld b,d
.data:00005118 42                               ld b,d
.data:00005119 42                               ld b,d
.data:0000511a 42                               ld b,d
.data:0000511b 42                               ld b,d
.data:0000511c 20 10                            jr nz,0x512e
.data:0000511e 00                               nop
.data:0000511f 01 00 00                         ld bc,0x0000
.data:00005122 01 10 10                         ld bc,0x1010
.data:00005125 00                               nop
.data:00005126 01 00 00                         ld bc,0x0000
.data:00005129 02                               ld (bc),a
.data:0000512a 10 10                            djnz 0x513c
.data:0000512c 00                               nop
.data:0000512d 01 00 00                         ld bc,0x0000
.data:00005130 03                               inc bc
.data:00005131 10 10                            djnz 0x5143
.data:00005133 00                               nop
.data:00005134 01 00 00                         ld bc,0x0000
.data:00005137 01 10 10                         ld bc,0x1010
.data:0000513a 00                               nop
.data:0000513b 01 00 00                         ld bc,0x0000
.data:0000513e 02                               ld (bc),a
.data:0000513f 10 10                            djnz 0x5151
.data:00005141 00                               nop
.data:00005142 01 00 00                         ld bc,0x0000
.data:00005145 01 10 10                         ld bc,0x1010
.data:00005148 00                               nop
.data:00005149 01 00 00                         ld bc,0x0000
.data:0000514c 00                               nop
.data:0000514d 10 10                            djnz 0x515f
.data:0000514f 00                               nop
.data:00005150 01 00 00                         ld bc,0x0000
.data:00005153 01 56 51                         ld bc,0x5156
.data:00005156 1b                               dec de
.data:00005157 1b                               dec de
.data:00005158 1c                               inc e
.data:00005159 1c                               inc e
.data:0000515a 1b                               dec de
.data:0000515b 1b                               dec de
.data:0000515c 1c                               inc e
.data:0000515d 1c                               inc e
.data:0000515e 9b                               sbc a,e
.data:0000515f 9b                               sbc a,e
.data:00005160 9c                               sbc a,h
.data:00005161 9c                               sbc a,h
.data:00005162 1d                               dec e
.data:00005163 1d                               dec e
.data:00005164 1e 1e                            ld e,0x1e
.data:00005166 1f                               rra
.data:00005167 1f                               rra
.data:00005168 20 20                            jr nz,0x518a
.data:0000516a 21 21 22                         ld hl,0x2221
.data:0000516d 22 21 21                         ld (0x2121),hl
.data:00005170 22 22 a1                         ld (0xa122),hl
.data:00005173 a1                               and c
.data:00005174 a2                               and d
.data:00005175 a2                               and d
.data:00005176 23                               inc hl
.data:00005177 23                               inc hl
.data:00005178 24                               inc h
.data:00005179 24                               inc h
.data:0000517a 1f                               rra
.data:0000517b 1f                               rra
.data:0000517c 20 20                            jr nz,0x519e
.data:0000517e 01 01 01                         ld bc,0x0101
.data:00005181 01 01 01                         ld bc,0x0101
.data:00005184 01 01 01                         ld bc,0x0101
.data:00005187 01 01 01                         ld bc,0x0101
.data:0000518a 01 01 01                         ld bc,0x0101
.data:0000518d 01 02 02                         ld bc,0x0202
.data:00005190 02                               ld (bc),a
.data:00005191 02                               ld (bc),a
.data:00005192 02                               ld (bc),a
.data:00005193 02                               ld (bc),a
.data:00005194 02                               ld (bc),a
.data:00005195 02                               ld (bc),a
.data:00005196 01 01 02                         ld bc,0x0201
.data:00005199 02                               ld (bc),a
.data:0000519a 01 01 01                         ld bc,0x0101
.data:0000519d 01 04 04                         ld bc,0x0404
.data:000051a0 04                               inc b
.data:000051a1 04                               inc b
.data:000051a2 04                               inc b
.data:000051a3 04                               inc b
.data:000051a4 04                               inc b
.data:000051a5 04                               inc b
.data:000051a6 01 01 04                         ld bc,0x0401
.data:000051a9 04                               inc b
.data:000051aa 04                               inc b
.data:000051ab 04                               inc b
.data:000051ac 01 01 04                         ld bc,0x0401
.data:000051af 04                               inc b
.data:000051b0 02                               ld (bc),a
.data:000051b1 02                               ld (bc),a
.data:000051b2 04                               inc b
.data:000051b3 04                               inc b
.data:000051b4 02                               ld (bc),a
.data:000051b5 02                               ld (bc),a
.data:000051b6 01 04 02                         ld bc,0x0204
.data:000051b9 04                               inc b
.data:000051ba 01 02 01                         ld bc,0x0102
.data:000051bd 02                               ld (bc),a
.data:000051be 08                               ex af,af'
.data:000051bf 08                               ex af,af'
.data:000051c0 08                               ex af,af'
.data:000051c1 08                               ex af,af'
.data:000051c2 08                               ex af,af'
.data:000051c3 08                               ex af,af'
.data:000051c4 08                               ex af,af'
.data:000051c5 08                               ex af,af'
.data:000051c6 01 01 08                         ld bc,0x0801
.data:000051c9 08                               ex af,af'
.data:000051ca 01 01 08                         ld bc,0x0801
.data:000051cd 08                               ex af,af'
.data:000051ce 08                               ex af,af'
.data:000051cf 08                               ex af,af'
.data:000051d0 02                               ld (bc),a
.data:000051d1 02                               ld (bc),a
.data:000051d2 02                               ld (bc),a
.data:000051d3 02                               ld (bc),a
.data:000051d4 08                               ex af,af'
.data:000051d5 08                               ex af,af'
.data:000051d6 01 08 02                         ld bc,0x0208
.data:000051d9 08                               ex af,af'
.data:000051da 01 02 08                         ld bc,0x0802
.data:000051dd 08                               ex af,af'
.data:000051de 08                               ex af,af'
.data:000051df 04                               inc b
.data:000051e0 08                               ex af,af'
.data:000051e1 04                               inc b
.data:000051e2 04                               inc b
.data:000051e3 04                               inc b
.data:000051e4 08                               ex af,af'
.data:000051e5 08                               ex af,af'
.data:000051e6 01 01 08                         ld bc,0x0801
.data:000051e9 04                               inc b
.data:000051ea 04                               inc b
.data:000051eb 01 08 01                         ld bc,0x0108
.data:000051ee 08                               ex af,af'
.data:000051ef 04                               inc b
.data:000051f0 02                               ld (bc),a
.data:000051f1 02                               ld (bc),a
.data:000051f2 04                               inc b
.data:000051f3 02                               ld (bc),a
.data:000051f4 08                               ex af,af'
.data:000051f5 02                               ld (bc),a
.data:000051f6 01 01 02                         ld bc,0x0201
.data:000051f9 02                               ld (bc),a
.data:000051fa 04                               inc b
.data:000051fb 04                               inc b
.data:000051fc 08                               ex af,af'
.data:000051fd 08                               ex af,af'
.data:000051fe 2a 02 2c                         ld hl,(0x2c02)
.data:00005201 3e 10                            ld a,0x10
.data:00005203 84                               add a,h
.data:00005204 e6 7f                            and 0x7f
.data:00005206 67                               ld h,a
.data:00005207 3e 18                            ld a,0x18
.data:00005209 85                               add a,l
.data:0000520a e6 7f                            and 0x7f
.data:0000520c 6f                               ld l,a
.data:0000520d 22 1f 2c                         ld (0x2c1f),hl
.data:00005210 3a fb 2b                         ld a,(0x2bfb)
.data:00005213 a7                               and a
.data:00005214 ca 77 52                         jp z,0x5277
.data:00005217 47                               ld b,a
.data:00005218 dd 21 1c 51                      ld ix,0x511c
.data:0000521c c5                               push bc
.data:0000521d cd 78 52                         call 0x5278
.data:00005220 38 4b                            jr c,0x526d
.data:00005222 d5                               push de
.data:00005223 dd 7e 02                         ld a,(ix+2)
.data:00005226 e6 0f                            and 0x0f
.data:00005228 87                               add a,a
.data:00005229 21 54 51                         ld hl,0x5154
.data:0000522c 85                               add a,l
.data:0000522d 6f                               ld l,a
.data:0000522e 5e                               ld e,(hl)
.data:0000522f 23                               inc hl
.data:00005230 56                               ld d,(hl)
.data:00005231 3a 0d 2c                         ld a,(0x2c0d)
.data:00005234 a7                               and a
.data:00005235 28 11                            jr z,0x5248
.data:00005237 3a 0e 2c                         ld a,(0x2c0e)
.data:0000523a fe 32                            cp 0x32
.data:0000523c 30 04                            jr nc,0x5242
.data:0000523e cb 47                            bit 0,a
.data:00005240 28 06                            jr z,0x5248
.data:00005242 eb                               ex de,hl
.data:00005243 11 14 00                         ld de,0x0014
.data:00005246 19                               add hl,de
.data:00005247 eb                               ex de,hl
.data:00005248 dd 7e 06                         ld a,(ix+6)
.data:0000524b 3c                               inc a
.data:0000524c e6 03                            and 0x03
.data:0000524e dd 77 06                         ld (ix+6),a
.data:00005251 6f                               ld l,a
.data:00005252 79                               ld a,c
.data:00005253 87                               add a,a
.data:00005254 87                               add a,a
.data:00005255 85                               add a,l
.data:00005256 6f                               ld l,a
.data:00005257 26 00                            ld h,0x00
.data:00005259 19                               add hl,de
.data:0000525a 7e                               ld a,(hl)
.data:0000525b 57                               ld d,a
.data:0000525c e6 7f                            and 0x7f
.data:0000525e 47                               ld b,a
.data:0000525f 7a                               ld a,d
.data:00005260 e6 80                            and 0x80
.data:00005262 d1                               pop de
.data:00005263 dd e5                            push ix
.data:00005265 cd 40 84                         call 0x8440
.data:00005268 dd e1                            pop ix
.data:0000526a cd d8 57                         call 0x57d8
.data:0000526d 01 07 00                         ld bc,0x0007
.data:00005270 dd 09                            add ix,bc
.data:00005272 c1                               pop bc
.data:00005273 05                               dec b
.data:00005274 c2 1c 52                         jp nz,0x521c
.data:00005277 c9                               ret
.data:00005278 16 00                            ld d,0x00
.data:0000527a dd 4e 00                         ld c,(ix+0)
.data:0000527d dd 46 01                         ld b,(ix+1)
.data:00005280 2a 1f 2c                         ld hl,(0x2c1f)
.data:00005283 3a 0d 2c                         ld a,(0x2c0d)
.data:00005286 a7                               and a
.data:00005287 28 0a                            jr z,0x5293
.data:00005289 7c                               ld a,h
.data:0000528a ed 44                            neg
.data:0000528c 67                               ld h,a
.data:0000528d 7d                               ld a,l
.data:0000528e ed 44                            neg
.data:00005290 6f                               ld l,a
.data:00005291 18 0c                            jr 0x529f
.data:00005293 dd 7e 02                         ld a,(ix+2)
.data:00005296 a7                               and a
.data:00005297 20 2c                            jr nz,0x52c5
.data:00005299 3a 0f 2c                         ld a,(0x2c0f)
.data:0000529c a7                               and a
.data:0000529d 20 26                            jr nz,0x52c5
.data:0000529f 7d                               ld a,l
.data:000052a0 e6 fc                            and 0xfc
.data:000052a2 6f                               ld l,a
.data:000052a3 79                               ld a,c
.data:000052a4 e6 fc                            and 0xfc
.data:000052a6 bd                               cp l
.data:000052a7 20 0a                            jr nz,0x52b3
.data:000052a9 78                               ld a,b
.data:000052aa bc                               cp h
.data:000052ab 16 08                            ld d,0x08
.data:000052ad 30 16                            jr nc,0x52c5
.data:000052af 16 04                            ld d,0x04
.data:000052b1 18 12                            jr 0x52c5
.data:000052b3 7c                               ld a,h
.data:000052b4 e6 fc                            and 0xfc
.data:000052b6 67                               ld h,a
.data:000052b7 78                               ld a,b
.data:000052b8 e6 fc                            and 0xfc
.data:000052ba bc                               cp h
.data:000052bb 20 08                            jr nz,0x52c5
.data:000052bd 79                               ld a,c
.data:000052be bd                               cp l
.data:000052bf 16 02                            ld d,0x02
.data:000052c1 30 02                            jr nc,0x52c5
.data:000052c3 16 01                            ld d,0x01
.data:000052c5 dd 7e 00                         ld a,(ix+0)
.data:000052c8 dd b6 01                         or (ix+1)
.data:000052cb e6 03                            and 0x03
.data:000052cd dd 7e 03                         ld a,(ix+3)
.data:000052d0 20 6e                            jr nz,0x5340
.data:000052d2 42                               ld b,d
.data:000052d3 16 00                            ld d,0x00
.data:000052d5 3e 01                            ld a,0x01
.data:000052d7 cd 14 54                         call 0x5414
.data:000052da b2                               or d
.data:000052db 57                               ld d,a
.data:000052dc 3e 02                            ld a,0x02
.data:000052de cd 14 54                         call 0x5414
.data:000052e1 b2                               or d
.data:000052e2 57                               ld d,a
.data:000052e3 3e 04                            ld a,0x04
.data:000052e5 cd 14 54                         call 0x5414
.data:000052e8 b2                               or d
.data:000052e9 57                               ld d,a
.data:000052ea 3e 08                            ld a,0x08
.data:000052ec cd 14 54                         call 0x5414
.data:000052ef b2                               or d
.data:000052f0 57                               ld d,a
.data:000052f1 a0                               and b
.data:000052f2 28 0f                            jr z,0x5303
.data:000052f4 3a 0d 2c                         ld a,(0x2c0d)
.data:000052f7 a7                               and a
.data:000052f8 78                               ld a,b
.data:000052f9 20 45                            jr nz,0x5340
.data:000052fb cd 78 54                         call 0x5478
.data:000052fe e6 01                            and 0x01
.data:00005300 78                               ld a,b
.data:00005301 28 3d                            jr z,0x5340
.data:00005303 7a                               ld a,d
.data:00005304 87                               add a,a
.data:00005305 87                               add a,a
.data:00005306 87                               add a,a
.data:00005307 57                               ld d,a
.data:00005308 dd 7e 02                         ld a,(ix+2)
.data:0000530b a7                               and a
.data:0000530c dd 7e 03                         ld a,(ix+3)
.data:0000530f 28 0d                            jr z,0x531e
.data:00005311 dd 7e 04                         ld a,(ix+4)
.data:00005314 dd b6 05                         or (ix+5)
.data:00005317 cb 7f                            bit 7,a
.data:00005319 dd 7e 03                         ld a,(ix+3)
.data:0000531c 20 22                            jr nz,0x5340
.data:0000531e 21 38 2c                         ld hl,0x2c38
.data:00005321 85                               add a,l
.data:00005322 6f                               ld l,a
.data:00005323 7c                               ld a,h
.data:00005324 ce 00                            adc a,0x00
.data:00005326 67                               ld h,a
.data:00005327 7e                               ld a,(hl)
.data:00005328 d6 01                            sub 0x01
.data:0000532a 30 01                            jr nc,0x532d
.data:0000532c af                               xor a
.data:0000532d 87                               add a,a
.data:0000532e 5f                               ld e,a
.data:0000532f cd 78 54                         call 0x5478
.data:00005332 e6 01                            and 0x01
.data:00005334 b3                               or e
.data:00005335 b2                               or d
.data:00005336 21 7e 51                         ld hl,0x517e
.data:00005339 85                               add a,l
.data:0000533a 6f                               ld l,a
.data:0000533b 7c                               ld a,h
.data:0000533c ce 00                            adc a,0x00
.data:0000533e 67                               ld h,a
.data:0000533f 7e                               ld a,(hl)
.data:00005340 dd 77 03                         ld (ix+3),a
.data:00005343 4f                               ld c,a
.data:00005344 79                               ld a,c
.data:00005345 e6 0f                            and 0x0f
.data:00005347 21 38 2c                         ld hl,0x2c38
.data:0000534a 85                               add a,l
.data:0000534b 6f                               ld l,a
.data:0000534c 4e                               ld c,(hl)
.data:0000534d dd 7e 02                         ld a,(ix+2)
.data:00005350 a7                               and a
.data:00005351 79                               ld a,c
.data:00005352 dd 66 00                         ld h,(ix+0)
.data:00005355 dd 6e 04                         ld l,(ix+4)
.data:00005358 11 00 01                         ld de,0x0100
.data:0000535b 28 03                            jr z,0x5360
.data:0000535d 11 80 00                         ld de,0x0080
.data:00005360 3a 0d 2c                         ld a,(0x2c0d)
.data:00005363 a7                               and a
.data:00005364 28 03                            jr z,0x5369
.data:00005366 11 80 00                         ld de,0x0080
.data:00005369 79                               ld a,c
.data:0000536a fe 01                            cp 0x01
.data:0000536c 20 05                            jr nz,0x5373
.data:0000536e dd 36 05 00                      ld (ix+5),0x00
.data:00005372 19                               add hl,de
.data:00005373 fe 02                            cp 0x02
.data:00005375 20 06                            jr nz,0x537d
.data:00005377 dd 36 05 00                      ld (ix+5),0x00
.data:0000537b ed 52                            sbc hl,de
.data:0000537d dd 75 04                         ld (ix+4),l
.data:00005380 dd 74 00                         ld (ix+0),h
.data:00005383 dd 66 01                         ld h,(ix+1)
.data:00005386 dd 6e 05                         ld l,(ix+5)
.data:00005389 fe 03                            cp 0x03
.data:0000538b 20 05                            jr nz,0x5392
.data:0000538d dd 36 04 00                      ld (ix+4),0x00
.data:00005391 19                               add hl,de
.data:00005392 fe 04                            cp 0x04
.data:00005394 20 06                            jr nz,0x539c
.data:00005396 dd 36 04 00                      ld (ix+4),0x00
.data:0000539a ed 52                            sbc hl,de
.data:0000539c dd 75 05                         ld (ix+5),l
.data:0000539f dd 74 01                         ld (ix+1),h
.data:000053a2 c5                               push bc
.data:000053a3 01 00 00                         ld bc,0x0000
.data:000053a6 ed 5b 02 2c                      ld de,(0x2c02)
.data:000053aa cb bb                            res 7,e
.data:000053ac cb ba                            res 7,d
.data:000053ae 7b                               ld a,e
.data:000053af d6 08                            sub 0x08
.data:000053b1 cb bf                            res 7,a
.data:000053b3 fe 40                            cp 0x40
.data:000053b5 38 03                            jr c,0x53ba
.data:000053b7 0e 40                            ld c,0x40
.data:000053b9 91                               sub c
.data:000053ba 5f                               ld e,a
.data:000053bb 7a                               ld a,d
.data:000053bc d6 08                            sub 0x08
.data:000053be cb bf                            res 7,a
.data:000053c0 fe 40                            cp 0x40
.data:000053c2 38 03                            jr c,0x53c7
.data:000053c4 06 40                            ld b,0x40
.data:000053c6 90                               sub b
.data:000053c7 57                               ld d,a
.data:000053c8 dd 7e 01                         ld a,(ix+1)
.data:000053cb cb bf                            res 7,a
.data:000053cd 80                               add a,b
.data:000053ce cb bf                            res 7,a
.data:000053d0 92                               sub d
.data:000053d1 cb bf                            res 7,a
.data:000053d3 38 3c                            jr c,0x5411
.data:000053d5 fe 2c                            cp 0x2c
.data:000053d7 30 38                            jr nc,0x5411
.data:000053d9 d6 08                            sub 0x08
.data:000053db cb bf                            res 7,a
.data:000053dd 67                               ld h,a
.data:000053de dd 7e 00                         ld a,(ix+0)
.data:000053e1 cb bf                            res 7,a
.data:000053e3 81                               add a,c
.data:000053e4 cb bf                            res 7,a
.data:000053e6 93                               sub e
.data:000053e7 cb bf                            res 7,a
.data:000053e9 38 26                            jr c,0x5411
.data:000053eb fe 38                            cp 0x38
.data:000053ed 30 22                            jr nc,0x5411
.data:000053ef d6 08                            sub 0x08
.data:000053f1 cb bf                            res 7,a
.data:000053f3 6f                               ld l,a
.data:000053f4 87                               add a,a
.data:000053f5 c6 0e                            add a,0x0e
.data:000053f7 5f                               ld e,a
.data:000053f8 7c                               ld a,h
.data:000053f9 87                               add a,a
.data:000053fa 87                               add a,a
.data:000053fb c6 f8                            add a,0xf8
.data:000053fd 57                               ld d,a
.data:000053fe dd 7e 04                         ld a,(ix+4)
.data:00005401 07                               rlca
.data:00005402 7b                               ld a,e
.data:00005403 ce 00                            adc a,0x00
.data:00005405 5f                               ld e,a
.data:00005406 dd 7e 05                         ld a,(ix+5)
.data:00005409 07                               rlca
.data:0000540a 7a                               ld a,d
.data:0000540b ce 00                            adc a,0x00
.data:0000540d 57                               ld d,a
.data:0000540e c1                               pop bc
.data:0000540f a7                               and a
.data:00005410 c9                               ret
.data:00005411 c1                               pop bc
.data:00005412 37                               scf
.data:00005413 c9                               ret
.data:00005414 c5                               push bc
.data:00005415 d5                               push de
.data:00005416 dd 4e 00                         ld c,(ix+0)
.data:00005419 dd 46 01                         ld b,(ix+1)
.data:0000541c 1f                               rra
.data:0000541d 30 08                            jr nc,0x5427
.data:0000541f 0c                               inc c
.data:00005420 0c                               inc c
.data:00005421 0c                               inc c
.data:00005422 0c                               inc c
.data:00005423 3e 01                            ld a,0x01
.data:00005425 18 19                            jr 0x5440
.data:00005427 1f                               rra
.data:00005428 30 05                            jr nc,0x542f
.data:0000542a 0d                               dec c
.data:0000542b 3e 02                            ld a,0x02
.data:0000542d 18 11                            jr 0x5440
.data:0000542f 1f                               rra
.data:00005430 30 08                            jr nc,0x543a
.data:00005432 04                               inc b
.data:00005433 04                               inc b
.data:00005434 04                               inc b
.data:00005435 04                               inc b
.data:00005436 3e 04                            ld a,0x04
.data:00005438 18 06                            jr 0x5440
.data:0000543a 1f                               rra
.data:0000543b 30 03                            jr nc,0x5440
.data:0000543d 05                               dec b
.data:0000543e 3e 08                            ld a,0x08
.data:00005440 57                               ld d,a
.data:00005441 cd 5f 54                         call 0x545f
.data:00005444 cd da 8c                         call 0x8cda
.data:00005447 a7                               and a
.data:00005448 28 0c                            jr z,0x5456
.data:0000544a fe 08                            cp 0x08
.data:0000544c 28 08                            jr z,0x5456
.data:0000544e fe 07                            cp 0x07
.data:00005450 28 04                            jr z,0x5456
.data:00005452 fe 0a                            cp 0x0a
.data:00005454 20 04                            jr nz,0x545a
.data:00005456 af                               xor a
.data:00005457 37                               scf
.data:00005458 18 02                            jr 0x545c
.data:0000545a 7a                               ld a,d
.data:0000545b a7                               and a
.data:0000545c d1                               pop de
.data:0000545d c1                               pop bc
.data:0000545e c9                               ret
.data:0000545f 78                               ld a,b
.data:00005460 e6 7c                            and 0x7c
.data:00005462 0f                               rrca
.data:00005463 0f                               rrca
.data:00005464 47                               ld b,a
.data:00005465 79                               ld a,c
.data:00005466 e6 7c                            and 0x7c
.data:00005468 07                               rlca
.data:00005469 cb 18                            rr b
.data:0000546b 1f                               rra
.data:0000546c cb 18                            rr b
.data:0000546e 1f                               rra
.data:0000546f cb 18                            rr b
.data:00005471 1f                               rra
.data:00005472 4f                               ld c,a
.data:00005473 21 60 fc                         ld hl,0xfc60
.data:00005476 09                               add hl,bc
.data:00005477 c9                               ret
.data:00005478 e5                               push hl
.data:00005479 2a 22 2c                         ld hl,(0x2c22)
.data:0000547c ed 5f                            ld a,r
.data:0000547e 0f                               rrca
.data:0000547f 8d                               adc a,l
.data:00005480 ae                               xor (hl)
.data:00005481 6f                               ld l,a
.data:00005482 22 22 2c                         ld (0x2c22),hl
.data:00005485 e1                               pop hl
.data:00005486 c9                               ret
.data:00005487 27                               daa
.data:00005488 27                               daa
.data:00005489 27                               daa
.data:0000548a 27                               daa
.data:0000548b 27                               daa
.data:0000548c 27                               daa
.data:0000548d 27                               daa
.data:0000548e 27                               daa
.data:0000548f a7                               and a
.data:00005490 a7                               and a
.data:00005491 a7                               and a
.data:00005492 a7                               and a
.data:00005493 25                               dec h
.data:00005494 25                               dec h
.data:00005495 25                               dec h
.data:00005496 25                               dec h
.data:00005497 26 26                            ld h,0x26
.data:00005499 26 26                            ld h,0x26
.data:0000549b 20 10                            jr nz,0x54ad
.data:0000549d 01 01 00                         ld bc,0x0001
.data:000054a0 00                               nop
.data:000054a1 01 20 10                         ld bc,0x1020
.data:000054a4 01 01 00                         ld bc,0x0001
.data:000054a7 00                               nop
.data:000054a8 01 3a fc                         ld bc,0xfc3a
.data:000054ab 2b                               dec hl
.data:000054ac a7                               and a
.data:000054ad c8                               ret z
.data:000054ae 47                               ld b,a
.data:000054af dd 21 9b 54                      ld ix,0x549b
.data:000054b3 c5                               push bc
.data:000054b4 dd 4e 00                         ld c,(ix+0)
.data:000054b7 dd 46 01                         ld b,(ix+1)
.data:000054ba 2a 02 2c                         ld hl,(0x2c02)
.data:000054bd 78                               ld a,b
.data:000054be b1                               or c
.data:000054bf b4                               or h
.data:000054c0 b5                               or l
.data:000054c1 e6 03                            and 0x03
.data:000054c3 20 16                            jr nz,0x54db
.data:000054c5 cd 59 55                         call 0x5559
.data:000054c8 7e                               ld a,(hl)
.data:000054c9 cb 7f                            bit 7,a
.data:000054cb 28 0e                            jr z,0x54db
.data:000054cd cb bf                            res 7,a
.data:000054cf d6 3f                            sub 0x3f
.data:000054d1 38 08                            jr c,0x54db
.data:000054d3 fe 03                            cp 0x03
.data:000054d5 30 04                            jr nc,0x54db
.data:000054d7 c6 2d                            add a,0x2d
.data:000054d9 18 01                            jr 0x54dc
.data:000054db af                               xor a
.data:000054dc 32 56 55                         ld (0x5556),a
.data:000054df 22 57 55                         ld (0x5557),hl
.data:000054e2 c5                               push bc
.data:000054e3 cd 78 52                         call 0x5278
.data:000054e6 e1                               pop hl
.data:000054e7 38 62                            jr c,0x554b
.data:000054e9 e5                               push hl
.data:000054ea d5                               push de
.data:000054eb 11 87 54                         ld de,0x5487
.data:000054ee dd 7e 06                         ld a,(ix+6)
.data:000054f1 3c                               inc a
.data:000054f2 e6 03                            and 0x03
.data:000054f4 dd 77 06                         ld (ix+6),a
.data:000054f7 6f                               ld l,a
.data:000054f8 79                               ld a,c
.data:000054f9 87                               add a,a
.data:000054fa 87                               add a,a
.data:000054fb 85                               add a,l
.data:000054fc 6f                               ld l,a
.data:000054fd 26 00                            ld h,0x00
.data:000054ff 19                               add hl,de
.data:00005500 7e                               ld a,(hl)
.data:00005501 57                               ld d,a
.data:00005502 e6 7f                            and 0x7f
.data:00005504 47                               ld b,a
.data:00005505 7a                               ld a,d
.data:00005506 e6 80                            and 0x80
.data:00005508 d1                               pop de
.data:00005509 dd e5                            push ix
.data:0000550b cd 40 84                         call 0x8440
.data:0000550e dd e1                            pop ix
.data:00005510 dd 36 02 01                      ld (ix+2),0x01
.data:00005514 cd d8 57                         call 0x57d8
.data:00005517 d1                               pop de
.data:00005518 2a 02 2c                         ld hl,(0x2c02)
.data:0000551b cb bc                            res 7,h
.data:0000551d cb bd                            res 7,l
.data:0000551f 7b                               ld a,e
.data:00005520 95                               sub l
.data:00005521 e6 7c                            and 0x7c
.data:00005523 0f                               rrca
.data:00005524 0f                               rrca
.data:00005525 4f                               ld c,a
.data:00005526 fe 0c                            cp 0x0c
.data:00005528 30 21                            jr nc,0x554b
.data:0000552a 7a                               ld a,d
.data:0000552b 94                               sub h
.data:0000552c e6 7c                            and 0x7c
.data:0000552e 0f                               rrca
.data:0000552f 0f                               rrca
.data:00005530 47                               ld b,a
.data:00005531 fe 09                            cp 0x09
.data:00005533 30 16                            jr nc,0x554b
.data:00005535 3a 56 55                         ld a,(0x5556)
.data:00005538 a7                               and a
.data:00005539 28 10                            jr z,0x554b
.data:0000553b 21 08 2c                         ld hl,0x2c08
.data:0000553e 35                               dec (hl)
.data:0000553f 2a 57 55                         ld hl,(0x5557)
.data:00005542 77                               ld (hl),a
.data:00005543 cd ee 8c                         call 0x8cee
.data:00005546 3e 05                            ld a,0x05
.data:00005548 32 28 61                         ld (0x6128),a
.data:0000554b 01 07 00                         ld bc,0x0007
.data:0000554e dd 09                            add ix,bc
.data:00005550 c1                               pop bc
.data:00005551 05                               dec b
.data:00005552 c2 b3 54                         jp nz,0x54b3
.data:00005555 c9                               ret
.data:00005556 00                               nop
.data:00005557 00                               nop
.data:00005558 00                               nop
.data:00005559 c5                               push bc
.data:0000555a 78                               ld a,b
.data:0000555b e6 7c                            and 0x7c
.data:0000555d 0f                               rrca
.data:0000555e 0f                               rrca
.data:0000555f 47                               ld b,a
.data:00005560 79                               ld a,c
.data:00005561 e6 7c                            and 0x7c
.data:00005563 07                               rlca
.data:00005564 cb 18                            rr b
.data:00005566 1f                               rra
.data:00005567 cb 18                            rr b
.data:00005569 1f                               rra
.data:0000556a cb 18                            rr b
.data:0000556c 1f                               rra
.data:0000556d 4f                               ld c,a
.data:0000556e 21 60 fc                         ld hl,0xfc60
.data:00005571 09                               add hl,bc
.data:00005572 c1                               pop bc
.data:00005573 c9                               ret
.data:00005574 2f                               cpl
.data:00005575 2e 2d                            ld l,0x2d
.data:00005577 2e 2f                            ld l,0x2f
.data:00005579 2e 2d                            ld l,0x2d
.data:0000557b 2e af                            ld l,0xaf
.data:0000557d ae                               xor (hl)
.data:0000557e ad                               xor l
.data:0000557f ae                               xor (hl)
.data:00005580 32 31 30                         ld (0x3031),a
.data:00005583 31 33 34                         ld sp,0x3433
.data:00005586 35                               dec (hl)
.data:00005587 34                               inc (hl)
.data:00005588 20 10                            jr nz,0x559a
.data:0000558a 02                               ld (bc),a
.data:0000558b 01 00 00                         ld bc,0x0000
.data:0000558e 01 20 10                         ld bc,0x1020
.data:00005591 02                               ld (bc),a
.data:00005592 01 00 00                         ld bc,0x0000
.data:00005595 01 20 10                         ld bc,0x1020
.data:00005598 02                               ld (bc),a
.data:00005599 01 00 00                         ld bc,0x0000
.data:0000559c 01 20 10                         ld bc,0x1020
.data:0000559f 02                               ld (bc),a
.data:000055a0 01 00 00                         ld bc,0x0000
.data:000055a3 01 20 10                         ld bc,0x1020
.data:000055a6 02                               ld (bc),a
.data:000055a7 01 00 00                         ld bc,0x0000
.data:000055aa 01 20 10                         ld bc,0x1020
.data:000055ad 02                               ld (bc),a
.data:000055ae 01 00 00                         ld bc,0x0000
.data:000055b1 01 20 10                         ld bc,0x1020
.data:000055b4 02                               ld (bc),a
.data:000055b5 01 00 00                         ld bc,0x0000
.data:000055b8 01 20 10                         ld bc,0x1020
.data:000055bb 02                               ld (bc),a
.data:000055bc 01 00 00                         ld bc,0x0000
.data:000055bf 01 3a fd                         ld bc,0xfd3a
.data:000055c2 2b                               dec hl
.data:000055c3 a7                               and a
.data:000055c4 c8                               ret z
.data:000055c5 47                               ld b,a
.data:000055c6 dd 21 88 55                      ld ix,0x5588
.data:000055ca c5                               push bc
.data:000055cb dd 36 02 02                      ld (ix+2),0x02
.data:000055cf dd 4e 00                         ld c,(ix+0)
.data:000055d2 dd 46 01                         ld b,(ix+1)
.data:000055d5 2a 02 2c                         ld hl,(0x2c02)
.data:000055d8 78                               ld a,b
.data:000055d9 b1                               or c
.data:000055da b4                               or h
.data:000055db b5                               or l
.data:000055dc e6 03                            and 0x03
.data:000055de 20 14                            jr nz,0x55f4
.data:000055e0 cd 59 55                         call 0x5559
.data:000055e3 7e                               ld a,(hl)
.data:000055e4 cb 7f                            bit 7,a
.data:000055e6 20 0c                            jr nz,0x55f4
.data:000055e8 d6 2d                            sub 0x2d
.data:000055ea 38 08                            jr c,0x55f4
.data:000055ec fe 03                            cp 0x03
.data:000055ee 30 04                            jr nc,0x55f4
.data:000055f0 c6 30                            add a,0x30
.data:000055f2 18 01                            jr 0x55f5
.data:000055f4 af                               xor a
.data:000055f5 32 67 56                         ld (0x5667),a
.data:000055f8 22 68 56                         ld (0x5668),hl
.data:000055fb c5                               push bc
.data:000055fc cd 78 52                         call 0x5278
.data:000055ff e1                               pop hl
.data:00005600 38 5a                            jr c,0x565c
.data:00005602 e5                               push hl
.data:00005603 d5                               push de
.data:00005604 11 74 55                         ld de,0x5574
.data:00005607 dd 7e 06                         ld a,(ix+6)
.data:0000560a 3c                               inc a
.data:0000560b e6 03                            and 0x03
.data:0000560d dd 77 06                         ld (ix+6),a
.data:00005610 6f                               ld l,a
.data:00005611 79                               ld a,c
.data:00005612 87                               add a,a
.data:00005613 87                               add a,a
.data:00005614 85                               add a,l
.data:00005615 6f                               ld l,a
.data:00005616 26 00                            ld h,0x00
.data:00005618 19                               add hl,de
.data:00005619 7e                               ld a,(hl)
.data:0000561a 57                               ld d,a
.data:0000561b e6 7f                            and 0x7f
.data:0000561d 47                               ld b,a
.data:0000561e 7a                               ld a,d
.data:0000561f e6 80                            and 0x80
.data:00005621 d1                               pop de
.data:00005622 dd e5                            push ix
.data:00005624 cd 40 84                         call 0x8440
.data:00005627 dd e1                            pop ix
.data:00005629 cd d8 57                         call 0x57d8
.data:0000562c d1                               pop de
.data:0000562d 2a 02 2c                         ld hl,(0x2c02)
.data:00005630 cb bc                            res 7,h
.data:00005632 cb bd                            res 7,l
.data:00005634 7b                               ld a,e
.data:00005635 95                               sub l
.data:00005636 e6 7c                            and 0x7c
.data:00005638 0f                               rrca
.data:00005639 0f                               rrca
.data:0000563a 4f                               ld c,a
.data:0000563b fe 0c                            cp 0x0c
.data:0000563d 30 1d                            jr nc,0x565c
.data:0000563f 7a                               ld a,d
.data:00005640 94                               sub h
.data:00005641 e6 7c                            and 0x7c
.data:00005643 0f                               rrca
.data:00005644 0f                               rrca
.data:00005645 47                               ld b,a
.data:00005646 fe 09                            cp 0x09
.data:00005648 30 12                            jr nc,0x565c
.data:0000564a 3a 67 56                         ld a,(0x5667)
.data:0000564d a7                               and a
.data:0000564e 28 0c                            jr z,0x565c
.data:00005650 2a 68 56                         ld hl,(0x5668)
.data:00005653 77                               ld (hl),a
.data:00005654 cd ee 8c                         call 0x8cee
.data:00005657 3e 06                            ld a,0x06
.data:00005659 32 28 61                         ld (0x6128),a
.data:0000565c 01 07 00                         ld bc,0x0007
.data:0000565f dd 09                            add ix,bc
.data:00005661 c1                               pop bc
.data:00005662 05                               dec b
.data:00005663 c2 ca 55                         jp nz,0x55ca
.data:00005666 c9                               ret
.data:00005667 00                               nop
.data:00005668 00                               nop
.data:00005669 00                               nop
.data:0000566a dd e5                            push ix
.data:0000566c d5                               push de
.data:0000566d d9                               exx
.data:0000566e d1                               pop de
.data:0000566f d9                               exx
.data:00005670 06 03                            ld b,0x03
.data:00005672 21 2e 2c                         ld hl,0x2c2e
.data:00005675 c5                               push bc
.data:00005676 7e                               ld a,(hl)
.data:00005677 a7                               and a
.data:00005678 28 48                            jr z,0x56c2
.data:0000567a 23                               inc hl
.data:0000567b 56                               ld d,(hl)
.data:0000567c cb 42                            bit 0,d
.data:0000567e 28 0a                            jr z,0x568a
.data:00005680 2b                               dec hl
.data:00005681 d6 10                            sub 0x10
.data:00005683 57                               ld d,a
.data:00005684 1e 40                            ld e,0x40
.data:00005686 30 14                            jr nc,0x569c
.data:00005688 18 38                            jr 0x56c2
.data:0000568a cb 7e                            bit 7,(hl)
.data:0000568c 2b                               dec hl
.data:0000568d 28 05                            jr z,0x5694
.data:0000568f d6 08                            sub 0x08
.data:00005691 5f                               ld e,a
.data:00005692 18 05                            jr 0x5699
.data:00005694 c6 08                            add a,0x08
.data:00005696 5f                               ld e,a
.data:00005697 18 00                            jr 0x5699
.data:00005699 5f                               ld e,a
.data:0000569a 16 38                            ld d,0x38
.data:0000569c d9                               exx
.data:0000569d d5                               push de
.data:0000569e d9                               exx
.data:0000569f c1                               pop bc
.data:000056a0 79                               ld a,c
.data:000056a1 c6 fc                            add a,0xfc
.data:000056a3 bb                               cp e
.data:000056a4 30 1c                            jr nc,0x56c2
.data:000056a6 c6 0c                            add a,0x0c
.data:000056a8 bb                               cp e
.data:000056a9 38 17                            jr c,0x56c2
.data:000056ab 78                               ld a,b
.data:000056ac c6 f8                            add a,0xf8
.data:000056ae ba                               cp d
.data:000056af 30 11                            jr nc,0x56c2
.data:000056b1 c6 14                            add a,0x14
.data:000056b3 ba                               cp d
.data:000056b4 38 0c                            jr c,0x56c2
.data:000056b6 e5                               push hl
.data:000056b7 0e 4d                            ld c,0x4d
.data:000056b9 cd ca 56                         call 0x56ca
.data:000056bc 3e 07                            ld a,0x07
.data:000056be 32 28 61                         ld (0x6128),a
.data:000056c1 e1                               pop hl
.data:000056c2 23                               inc hl
.data:000056c3 23                               inc hl
.data:000056c4 c1                               pop bc
.data:000056c5 10 ae                            djnz 0x5675
.data:000056c7 dd e1                            pop ix
.data:000056c9 c9                               ret
.data:000056ca 21 73 57                         ld hl,0x5773
.data:000056cd 06 04                            ld b,0x04
.data:000056cf 7e                               ld a,(hl)
.data:000056d0 a7                               and a
.data:000056d1 20 1c                            jr nz,0x56ef
.data:000056d3 71                               ld (hl),c
.data:000056d4 cb 79                            bit 7,c
.data:000056d6 c0                               ret nz
.data:000056d7 23                               inc hl
.data:000056d8 dd 7e 00                         ld a,(ix+0)
.data:000056db 77                               ld (hl),a
.data:000056dc 23                               inc hl
.data:000056dd dd 7e 01                         ld a,(ix+1)
.data:000056e0 77                               ld (hl),a
.data:000056e1 2a 00 2c                         ld hl,(0x2c00)
.data:000056e4 dd 75 00                         ld (ix+0),l
.data:000056e7 dd 74 01                         ld (ix+1),h
.data:000056ea af                               xor a
.data:000056eb 32 0c 2c                         ld (0x2c0c),a
.data:000056ee c9                               ret
.data:000056ef 23                               inc hl
.data:000056f0 23                               inc hl
.data:000056f1 23                               inc hl
.data:000056f2 10 db                            djnz 0x56cf
.data:000056f4 c9                               ret
.data:000056f5 00                               nop
.data:000056f6 36 36                            ld (hl),0x36
.data:000056f8 36 36                            ld (hl),0x36
.data:000056fa 36 36                            ld (hl),0x36
.data:000056fc 36 36                            ld (hl),0x36
.data:000056fe 36 36                            ld (hl),0x36
.data:00005700 36 36                            ld (hl),0x36
.data:00005702 36 36                            ld (hl),0x36
.data:00005704 36 36                            ld (hl),0x36
.data:00005706 36 36                            ld (hl),0x36
.data:00005708 36 36                            ld (hl),0x36
.data:0000570a 36 36                            ld (hl),0x36
.data:0000570c 28 28                            jr z,0x5736
.data:0000570e 29                               add hl,hl
.data:0000570f 29                               add hl,hl
.data:00005710 2a 2b 38                         ld hl,(0x382b)
.data:00005713 38 38                            jr c,0x574d
.data:00005715 38 38                            jr c,0x574f
.data:00005717 38 38                            jr c,0x5751
.data:00005719 38 38                            jr c,0x5753
.data:0000571b 38 ff                            jr c,0x571c
.data:0000571d 0f                               rrca
.data:0000571e 8d                               adc a,l
.data:0000571f 0e 0d                            ld c,0x0d
.data:00005721 0f                               rrca
.data:00005722 03                               inc bc
.data:00005723 00                               nop
.data:00005724 06 80                            ld b,0x80
.data:00005726 03                               inc bc
.data:00005727 00                               nop
.data:00005728 06 80                            ld b,0x80
.data:0000572a 03                               inc bc
.data:0000572b 00                               nop
.data:0000572c 06 80                            ld b,0x80
.data:0000572e 03                               inc bc
.data:0000572f 00                               nop
.data:00005730 06 80                            ld b,0x80
.data:00005732 03                               inc bc
.data:00005733 00                               nop
.data:00005734 06 80                            ld b,0x80
.data:00005736 03                               inc bc
.data:00005737 00                               nop
.data:00005738 06 80                            ld b,0x80
.data:0000573a 3a 3a 3b                         ld a,(0x3b3a)
.data:0000573d 3b                               dec sp
.data:0000573e 3c                               inc a
.data:0000573f 3c                               inc a
.data:00005740 3d                               dec a
.data:00005741 3d                               dec a
.data:00005742 28 28                            jr z,0x576c
.data:00005744 29                               add hl,hl
.data:00005745 29                               add hl,hl
.data:00005746 2a 2b 2c                         ld hl,(0x2c2b)
.data:00005749 ff                               rst 0x38
.data:0000574a 3e 3e                            ld a,0x3e
.data:0000574c 3e 3e                            ld a,0x3e
.data:0000574e 3e 3e                            ld a,0x3e
.data:00005750 3e 3e                            ld a,0x3e
.data:00005752 3e 3e                            ld a,0x3e
.data:00005754 3e 3e                            ld a,0x3e
.data:00005756 3e 3e                            ld a,0x3e
.data:00005758 3e 3e                            ld a,0x3e
.data:0000575a 3e 3e                            ld a,0x3e
.data:0000575c 3e 3e                            ld a,0x3e
.data:0000575e 3e 3e                            ld a,0x3e
.data:00005760 3e 3e                            ld a,0x3e
.data:00005762 28 28                            jr z,0x578c
.data:00005764 29                               add hl,hl
.data:00005765 29                               add hl,hl
.data:00005766 2a 2b 37                         ld hl,(0x372b)
.data:00005769 37                               scf
.data:0000576a 37                               scf
.data:0000576b 37                               scf
.data:0000576c 37                               scf
.data:0000576d 37                               scf
.data:0000576e 37                               scf
.data:0000576f 37                               scf
.data:00005770 37                               scf
.data:00005771 37                               scf
.data:00005772 ff                               rst 0x38
.data:00005773 00                               nop
.data:00005774 00                               nop
.data:00005775 00                               nop
.data:00005776 00                               nop
.data:00005777 00                               nop
.data:00005778 00                               nop
.data:00005779 00                               nop
.data:0000577a 00                               nop
.data:0000577b 00                               nop
.data:0000577c 00                               nop
.data:0000577d 00                               nop
.data:0000577e 00                               nop
.data:0000577f 00                               nop
.data:00005780 00                               nop
.data:00005781 00                               nop
.data:00005782 06 04                            ld b,0x04
.data:00005784 dd 21 73 57                      ld ix,0x5773
.data:00005788 c5                               push bc
.data:00005789 dd 7e 00                         ld a,(ix+0)
.data:0000578c dd 23                            inc ix
.data:0000578e a7                               and a
.data:0000578f ca d0 57                         jp z,0x57d0
.data:00005792 dd 34 ff                         inc (ix-1)
.data:00005795 e6 7f                            and 0x7f
.data:00005797 4f                               ld c,a
.data:00005798 3a 0f 2c                         ld a,(0x2c0f)
.data:0000579b a7                               and a
.data:0000579c 28 0a                            jr z,0x57a8
.data:0000579e dd cb ff 7e                      bit 7,(ix-1)
.data:000057a2 16 38                            ld d,0x38
.data:000057a4 1e 40                            ld e,0x40
.data:000057a6 20 05                            jr nz,0x57ad
.data:000057a8 cd a2 53                         call 0x53a2
.data:000057ab cb 18                            rr b
.data:000057ad 21 f5 56                         ld hl,0x56f5
.data:000057b0 79                               ld a,c
.data:000057b1 85                               add a,l
.data:000057b2 6f                               ld l,a
.data:000057b3 7c                               ld a,h
.data:000057b4 ce 00                            adc a,0x00
.data:000057b6 67                               ld h,a
.data:000057b7 7e                               ld a,(hl)
.data:000057b8 e6 80                            and 0x80
.data:000057ba cb 10                            rl b
.data:000057bc 46                               ld b,(hl)
.data:000057bd cb b8                            res 7,b
.data:000057bf dd e5                            push ix
.data:000057c1 d4 40 84                         call nc,0x8440
.data:000057c4 dd e1                            pop ix
.data:000057c6 23                               inc hl
.data:000057c7 7e                               ld a,(hl)
.data:000057c8 fe ff                            cp 0xff
.data:000057ca 20 04                            jr nz,0x57d0
.data:000057cc dd 36 ff 00                      ld (ix-1),0x00
.data:000057d0 dd 23                            inc ix
.data:000057d2 dd 23                            inc ix
.data:000057d4 c1                               pop bc
.data:000057d5 10 b1                            djnz 0x5788
.data:000057d7 c9                               ret
.data:000057d8 3a 0f 2c                         ld a,(0x2c0f)
.data:000057db a7                               and a
.data:000057dc c0                               ret nz
.data:000057dd 7a                               ld a,d
.data:000057de fe 32                            cp 0x32
.data:000057e0 da 81 58                         jp c,0x5881
.data:000057e3 fe 3e                            cp 0x3e
.data:000057e5 d2 81 58                         jp nc,0x5881
.data:000057e8 7b                               ld a,e
.data:000057e9 fe 3c                            cp 0x3c
.data:000057eb da 81 58                         jp c,0x5881
.data:000057ee fe 44                            cp 0x44
.data:000057f0 d2 81 58                         jp nc,0x5881
.data:000057f3 dd 66 02                         ld h,(ix+2)
.data:000057f6 3a 2d 2c                         ld a,(0x2c2d)
.data:000057f9 6f                               ld l,a
.data:000057fa a7                               and a
.data:000057fb 20 36                            jr nz,0x5833
.data:000057fd 7c                               ld a,h
.data:000057fe fe 01                            cp 0x01
.data:00005800 28 7f                            jr z,0x5881
.data:00005802 3a 1e 2c                         ld a,(0x2c1e)
.data:00005805 a7                               and a
.data:00005806 20 79                            jr nz,0x5881
.data:00005808 3a ca 60                         ld a,(0x60ca)
.data:0000580b a7                               and a
.data:0000580c 20 73                            jr nz,0x5881
.data:0000580e 7d                               ld a,l
.data:0000580f fe 03                            cp 0x03
.data:00005811 3e 28                            ld a,0x28
.data:00005813 0e ad                            ld c,0xad
.data:00005815 20 04                            jr nz,0x581b
.data:00005817 3e 2d                            ld a,0x2d
.data:00005819 0e a7                            ld c,0xa7
.data:0000581b 32 0f 2c                         ld (0x2c0f),a
.data:0000581e cd ca 56                         call 0x56ca
.data:00005821 3e 08                            ld a,0x08
.data:00005823 32 28 61                         ld (0x6128),a
.data:00005826 3a 28 61                         ld a,(0x6128)
.data:00005829 fe ff                            cp 0xff
.data:0000582b 20 f9                            jr nz,0x5826
.data:0000582d 3e 0d                            ld a,0x0d
.data:0000582f 32 28 61                         ld (0x6128),a
.data:00005832 c9                               ret
.data:00005833 fe 01                            cp 0x01
.data:00005835 20 1f                            jr nz,0x5856
.data:00005837 7c                               ld a,h
.data:00005838 fe 02                            cp 0x02
.data:0000583a 30 45                            jr nc,0x5881
.data:0000583c fe 01                            cp 0x01
.data:0000583e 21 04 00                         ld hl,0x0004
.data:00005841 0e 6d                            ld c,0x6d
.data:00005843 20 05                            jr nz,0x584a
.data:00005845 21 06 00                         ld hl,0x0006
.data:00005848 0e 17                            ld c,0x17
.data:0000584a cd 70 8d                         call 0x8d70
.data:0000584d cd ca 56                         call 0x56ca
.data:00005850 3e 07                            ld a,0x07
.data:00005852 32 28 61                         ld (0x6128),a
.data:00005855 c9                               ret
.data:00005856 fe 02                            cp 0x02
.data:00005858 20 22                            jr nz,0x587c
.data:0000585a 7c                               ld a,h
.data:0000585b fe 01                            cp 0x01
.data:0000585d 21 06 00                         ld hl,0x0006
.data:00005860 0e 17                            ld c,0x17
.data:00005862 28 0c                            jr z,0x5870
.data:00005864 0e 55                            ld c,0x55
.data:00005866 21 04 00                         ld hl,0x0004
.data:00005869 38 05                            jr c,0x5870
.data:0000586b 21 06 00                         ld hl,0x0006
.data:0000586e 0e 01                            ld c,0x01
.data:00005870 cd 70 8d                         call 0x8d70
.data:00005873 cd ca 56                         call 0x56ca
.data:00005876 3e 07                            ld a,0x07
.data:00005878 32 28 61                         ld (0x6128),a
.data:0000587b c9                               ret
.data:0000587c fe 03                            cp 0x03
.data:0000587e ca fd 57                         jp z,0x57fd
.data:00005881 cd 6a 56                         call 0x566a
.data:00005884 c9                               ret
.data:00005885 dd 21 1c 51                      ld ix,0x511c
.data:00005889 ed 4b 00 2c                      ld bc,(0x2c00)
.data:0000588d 11 07 00                         ld de,0x0007
.data:00005890 3e 08                            ld a,0x08
.data:00005892 dd 71 00                         ld (ix+0),c
.data:00005895 dd 70 01                         ld (ix+1),b
.data:00005898 dd 36 04 00                      ld (ix+4),0x00
.data:0000589c dd 36 05 00                      ld (ix+5),0x00
.data:000058a0 dd 19                            add ix,de
.data:000058a2 3d                               dec a
.data:000058a3 20 ed                            jr nz,0x5892
.data:000058a5 dd 21 9b 54                      ld ix,0x549b
.data:000058a9 3e 02                            ld a,0x02
.data:000058ab dd 71 00                         ld (ix+0),c
.data:000058ae dd 70 01                         ld (ix+1),b
.data:000058b1 dd 36 04 00                      ld (ix+4),0x00
.data:000058b5 dd 36 05 00                      ld (ix+5),0x00
.data:000058b9 dd 19                            add ix,de
.data:000058bb 3d                               dec a
.data:000058bc 20 ed                            jr nz,0x58ab
.data:000058be dd 21 88 55                      ld ix,0x5588
.data:000058c2 3e 08                            ld a,0x08
.data:000058c4 dd 71 00                         ld (ix+0),c
.data:000058c7 dd 70 01                         ld (ix+1),b
.data:000058ca dd 36 04 00                      ld (ix+4),0x00
.data:000058ce dd 36 05 00                      ld (ix+5),0x00
.data:000058d2 dd 19                            add ix,de
.data:000058d4 3d                               dec a
.data:000058d5 20 ed                            jr nz,0x58c4
.data:000058d7 06 04                            ld b,0x04
.data:000058d9 21 73 57                         ld hl,0x5773
.data:000058dc 36 00                            ld (hl),0x00
.data:000058de 23                               inc hl
.data:000058df 23                               inc hl
.data:000058e0 10 fa                            djnz 0x58dc
.data:000058e2 3a 2d 2c                         ld a,(0x2c2d)
.data:000058e5 fe 03                            cp 0x03
.data:000058e7 3e 0e                            ld a,0x0e
.data:000058e9 28 01                            jr z,0x58ec
.data:000058eb af                               xor a
.data:000058ec 32 10 2c                         ld (0x2c10),a
.data:000058ef 32 1a 2c                         ld (0x2c1a),a
.data:000058f2 32 1b 2c                         ld (0x2c1b),a
.data:000058f5 32 0c 2c                         ld (0x2c0c),a
.data:000058f8 06 03                            ld b,0x03
.data:000058fa 21 2e 2c                         ld hl,0x2c2e
.data:000058fd 36 00                            ld (hl),0x00
.data:000058ff 23                               inc hl
.data:00005900 23                               inc hl
.data:00005901 10 fa                            djnz 0x58fd
.data:00005903 c9                               ret
.data:00005904 3a 07 2c                         ld a,(0x2c07)
.data:00005907 21 a9 59                         ld hl,0x59a9
.data:0000590a 01 14 00                         ld bc,0x0014
.data:0000590d a7                               and a
.data:0000590e 28 04                            jr z,0x5914
.data:00005910 09                               add hl,bc
.data:00005911 3d                               dec a
.data:00005912 20 fc                            jr nz,0x5910
.data:00005914 11 f3 2b                         ld de,0x2bf3
.data:00005917 ed b0                            ldir
.data:00005919 11 60 fc                         ld de,0xfc60
.data:0000591c 2a f5 2b                         ld hl,(0x2bf5)
.data:0000591f 01 60 00                         ld bc,0x0060
.data:00005922 ed b0                            ldir
.data:00005924 3a f9 2b                         ld a,(0x2bf9)
.data:00005927 6f                               ld l,a
.data:00005928 26 00                            ld h,0x00
.data:0000592a 29                               add hl,hl
.data:0000592b 29                               add hl,hl
.data:0000592c 29                               add hl,hl
.data:0000592d 29                               add hl,hl
.data:0000592e 29                               add hl,hl
.data:0000592f 4d                               ld c,l
.data:00005930 44                               ld b,h
.data:00005931 2a f3 2b                         ld hl,(0x2bf3)
.data:00005934 3a 2c 2c                         ld a,(0x2c2c)
.data:00005937 a7                               and a
.data:00005938 d9                               exx
.data:00005939 57                               ld d,a
.data:0000593a 1e 00                            ld e,0x00
.data:0000593c d9                               exx
.data:0000593d 20 0a                            jr nz,0x5949
.data:0000593f cb be                            res 7,(hl)
.data:00005941 ed a0                            ldi
.data:00005943 78                               ld a,b
.data:00005944 b1                               or c
.data:00005945 20 f8                            jr nz,0x593f
.data:00005947 18 1c                            jr 0x5965
.data:00005949 cb be                            res 7,(hl)
.data:0000594b 7e                               ld a,(hl)
.data:0000594c ed a0                            ldi
.data:0000594e fe 3c                            cp 0x3c
.data:00005950 20 0f                            jr nz,0x5961
.data:00005952 d9                               exx
.data:00005953 7b                               ld a,e
.data:00005954 e6 01                            and 0x01
.data:00005956 1c                               inc e
.data:00005957 ba                               cp d
.data:00005958 d9                               exx
.data:00005959 28 06                            jr z,0x5961
.data:0000595b 3a ff 2b                         ld a,(0x2bff)
.data:0000595e 1b                               dec de
.data:0000595f 12                               ld (de),a
.data:00005960 13                               inc de
.data:00005961 78                               ld a,b
.data:00005962 b1                               or c
.data:00005963 20 e4                            jr nz,0x5949
.data:00005965 2a f7 2b                         ld hl,(0x2bf7)
.data:00005968 01 60 00                         ld bc,0x0060
.data:0000596b ed b0                            ldir
.data:0000596d 21 00 00                         ld hl,0x0000
.data:00005970 22 08 2c                         ld (0x2c08),hl
.data:00005973 ed 4b 00 2c                      ld bc,(0x2c00)
.data:00005977 05                               dec b
.data:00005978 cd 5f 54                         call 0x545f
.data:0000597b 22 0a 2c                         ld (0x2c0a),hl
.data:0000597e af                               xor a
.data:0000597f 32 0f 2c                         ld (0x2c0f),a
.data:00005982 32 2d 2c                         ld (0x2c2d),a
.data:00005985 32 11 2c                         ld (0x2c11),a
.data:00005988 32 0e 2c                         ld (0x2c0e),a
.data:0000598b 32 0d 2c                         ld (0x2c0d),a
.data:0000598e 3e 78                            ld a,0x78
.data:00005990 32 24 2c                         ld (0x2c24),a
.data:00005993 32 18 2c                         ld (0x2c18),a
.data:00005996 32 48 91                         ld (0x9148),a
.data:00005999 3a 04 2c                         ld a,(0x2c04)
.data:0000599c 32 47 91                         ld (0x9147),a
.data:0000599f 21 18 10                         ld hl,0x1018
.data:000059a2 22 16 2c                         ld (0x2c16),hl
.data:000059a5 cd 85 58                         call 0x5885
.data:000059a8 c9                               ret
.data:000059a9 5c                               ld e,h
.data:000059aa 33                               inc sp
.data:000059ab bc                               cp h
.data:000059ac 50                               ld d,b
.data:000059ad bc                               cp h
.data:000059ae 50                               ld d,b
.data:000059af 16 00                            ld d,0x00
.data:000059b1 05                               dec b
.data:000059b2 00                               nop
.data:000059b3 00                               nop
.data:000059b4 fa 3f 30                         jp m,0x303f
.data:000059b7 34                               inc (hl)
.data:000059b8 18 2c                            jr 0x59e6
.data:000059ba 70                               ld (hl),b
.data:000059bb 72                               ld (hl),d
.data:000059bc 00                               nop
.data:000059bd 5c                               ld e,h
.data:000059be 33                               inc sp
.data:000059bf bc                               cp h
.data:000059c0 50                               ld d,b
.data:000059c1 bc                               cp h
.data:000059c2 50                               ld d,b
.data:000059c3 16 00                            ld d,0x00
.data:000059c5 05                               dec b
.data:000059c6 00                               nop
.data:000059c7 00                               nop
.data:000059c8 fa 3f 30                         jp m,0x303f
.data:000059cb 34                               inc (hl)
.data:000059cc 18 2c                            jr 0x59fa
.data:000059ce 70                               ld (hl),b
.data:000059cf 72                               ld (hl),d
.data:000059d0 00                               nop
.data:000059d1 1c                               inc e
.data:000059d2 36 bc                            ld (hl),0xbc
.data:000059d4 50                               ld d,b
.data:000059d5 bc                               cp h
.data:000059d6 50                               ld d,b
.data:000059d7 0f                               rrca
.data:000059d8 01 04 00                         ld bc,0x0004
.data:000059db 00                               nop
.data:000059dc fa 40 40                         jp m,0x4040
.data:000059df 3c                               inc a
.data:000059e0 28 00                            jr z,0x59e2
.data:000059e2 38 93                            jr c,0x5977
.data:000059e4 00                               nop
.data:000059e5 fc 37 bc                         call m,0xbc37
.data:000059e8 50                               ld d,b
.data:000059e9 bc                               cp h
.data:000059ea 50                               ld d,b
.data:000059eb 10 00                            djnz 0x59ed
.data:000059ed 04                               inc b
.data:000059ee 01 00 fa                         ld bc,0xfa00
.data:000059f1 3f                               ccf
.data:000059f2 40                               ld b,b
.data:000059f3 28 28                            jr z,0x5a1d
.data:000059f5 08                               ex af,af'
.data:000059f6 30 78                            jr nc,0x5a70
.data:000059f8 00                               nop
.data:000059f9 7c                               ld a,h
.data:000059fa 40                               ld b,b
.data:000059fb fc 4a fc                         call m,0xfc4a
.data:000059fe 4a                               ld c,d
.data:000059ff 0f                               rrca
.data:00005a00 00                               nop
.data:00005a01 03                               inc bc
.data:00005a02 01 00 fa                         ld bc,0xfa00
.data:00005a05 3f                               ccf
.data:00005a06 3c                               inc a
.data:00005a07 3c                               inc a
.data:00005a08 28 18                            jr z,0x5a22
.data:00005a0a 70                               ld (hl),b
.data:00005a0b 4f                               ld c,a
.data:00005a0c 00                               nop
.data:00005a0d 3c                               inc a
.data:00005a0e 3c                               inc a
.data:00005a0f fc 4a fc                         call m,0xfc4a
.data:00005a12 4a                               ld c,d
.data:00005a13 10 01                            djnz 0x5a16
.data:00005a15 03                               inc bc
.data:00005a16 00                               nop
.data:00005a17 01 fa 3f                         ld bc,0x3ffa
.data:00005a1a 3c                               inc a
.data:00005a1b 3c                               inc a
.data:00005a1c 24                               inc h
.data:00005a1d 08                               ex af,af'
.data:00005a1e 38 65                            jr c,0x5a85
.data:00005a20 00                               nop
.data:00005a21 3c                               inc a
.data:00005a22 3e bc                            ld a,0xbc
.data:00005a24 50                               ld d,b
.data:00005a25 bc                               cp h
.data:00005a26 50                               ld d,b
.data:00005a27 12                               ld (de),a
.data:00005a28 00                               nop
.data:00005a29 03                               inc bc
.data:00005a2a 00                               nop
.data:00005a2b 01 fa 40                         ld bc,0x40fa
.data:00005a2e 40                               ld b,b
.data:00005a2f 18 28                            jr 0x5a59
.data:00005a31 10 38                            djnz 0x5a6b
.data:00005a33 97                               sub a
.data:00005a34 00                               nop
.data:00005a35 3c                               inc a
.data:00005a36 44                               ld b,h
.data:00005a37 fc 4a fc                         call m,0xfc4a
.data:00005a3a 4a                               ld c,d
.data:00005a3b 13                               inc de
.data:00005a3c 00                               nop
.data:00005a3d 03                               inc bc
.data:00005a3e 00                               nop
.data:00005a3f 01 c8 3f                         ld bc,0x3fc8
.data:00005a42 08                               ex af,af'
.data:00005a43 4c                               ld c,h
.data:00005a44 f0                               ret p
.data:00005a45 34                               inc (hl)
.data:00005a46 60                               ld h,b
.data:00005a47 7e                               ld a,(hl)
.data:00005a48 00                               nop
.data:00005a49 5c                               ld e,h
.data:00005a4a 42                               ld b,d
.data:00005a4b 5c                               ld e,h
.data:00005a4c 4b                               ld c,e
.data:00005a4d 5c                               ld e,h
.data:00005a4e 4b                               ld c,e
.data:00005a4f 0f                               rrca
.data:00005a50 00                               nop
.data:00005a51 03                               inc bc
.data:00005a52 00                               nop
.data:00005a53 01 fa 3f                         ld bc,0x3ffa
.data:00005a56 40                               ld b,b
.data:00005a57 40                               ld b,b
.data:00005a58 28 18                            jr z,0x5a72
.data:00005a5a 70                               ld (hl),b
.data:00005a5b 5a                               ld e,d
.data:00005a5c 00                               nop
.data:00005a5d fc 39 bc                         call m,0xbc39
.data:00005a60 50                               ld d,b
.data:00005a61 bc                               cp h
.data:00005a62 50                               ld d,b
.data:00005a63 12                               ld (de),a
.data:00005a64 00                               nop
.data:00005a65 03                               inc bc
.data:00005a66 02                               ld (bc),a
.data:00005a67 00                               nop
.data:00005a68 fa 40 40                         jp m,0x4040
.data:00005a6b 2c                               inc l
.data:00005a6c 28 24                            jr z,0x5a92
.data:00005a6e 38 a8                            jr c,0x5a18
.data:00005a70 00                               nop
.data:00005a71 9c                               sbc a,h
.data:00005a72 46                               ld b,(hl)
.data:00005a73 bc                               cp h
.data:00005a74 50                               ld d,b
.data:00005a75 bc                               cp h
.data:00005a76 50                               ld d,b
.data:00005a77 11 00 03                         ld de,0x0300
.data:00005a7a 00                               nop
.data:00005a7b 02                               ld (bc),a
.data:00005a7c 32 3f 40                         ld (0x403f),a
.data:00005a7f 30 28                            jr nc,0x5aa9
.data:00005a81 18 60                            jr 0x5ae3
.data:00005a83 74                               ld (hl),h
.data:00005a84 00                               nop
.data:00005a85 bc                               cp h
.data:00005a86 4b                               ld c,e
.data:00005a87 bc                               cp h
.data:00005a88 50                               ld d,b
.data:00005a89 bc                               cp h
.data:00005a8a 50                               ld d,b
.data:00005a8b 15                               dec d
.data:00005a8c 00                               nop
.data:00005a8d 03                               inc bc
.data:00005a8e 01 00 ff                         ld bc,0xff00
.data:00005a91 40                               ld b,b
.data:00005a92 64                               ld h,h
.data:00005a93 1c                               inc e
.data:00005a94 08                               ex af,af'
.data:00005a95 28 70                            jr z,0x5b07
.data:00005a97 1f                               rra
.data:00005a98 01 5c 4e                         ld bc,0x4e5c
.data:00005a9b fc 4a fc                         call m,0xfc4a
.data:00005a9e 4a                               ld c,d
.data:00005a9f 13                               inc de
.data:00005aa0 01 03 01                         ld bc,0x0103
.data:00005aa3 01 fa 41                         ld bc,0x41fa
.data:00005aa6 44                               ld b,h
.data:00005aa7 28 2c                            jr z,0x5ad5
.data:00005aa9 10 70                            djnz 0x5b1b
.data:00005aab b0                               or b
.data:00005aac 00                               nop
.data:00005aad a4                               and h
.data:00005aae cf                               rst 0x08
.data:00005aaf fc 4a fc                         call m,0xfc4a
.data:00005ab2 4a                               ld c,d
.data:00005ab3 15                               dec d
.data:00005ab4 00                               nop
.data:00005ab5 02                               ld (bc),a
.data:00005ab6 00                               nop
.data:00005ab7 03                               inc bc
.data:00005ab8 50                               ld d,b
.data:00005ab9 3f                               ccf
.data:00005aba 40                               ld b,b
.data:00005abb 3c                               inc a
.data:00005abc 28 24                            jr z,0x5ae2
.data:00005abe 70                               ld (hl),b
.data:00005abf 69                               ld l,c
.data:00005ac0 00                               nop
.data:00005ac1 44                               ld b,h
.data:00005ac2 d2 bc 50                         jp nc,0x50bc
.data:00005ac5 bc                               cp h
.data:00005ac6 50                               ld d,b
.data:00005ac7 17                               rla
.data:00005ac8 01 02 01                         ld bc,0x0102
.data:00005acb 02                               ld (bc),a
.data:00005acc fa 3f 44                         jp m,0x443f
.data:00005acf 60                               ld h,b
.data:00005ad0 64                               ld h,h
.data:00005ad1 50                               ld d,b
.data:00005ad2 70                               ld (hl),b
.data:00005ad3 0b                               dec bc
.data:00005ad4 01 bc 48                         ld bc,0x48bc
.data:00005ad7 bc                               cp h
.data:00005ad8 50                               ld d,b
.data:00005ad9 bc                               cp h
.data:00005ada 50                               ld d,b
.data:00005adb 12                               ld (de),a
.data:00005adc 01 03 01                         ld bc,0x0103
.data:00005adf 01 96 3f                         ld bc,0x3f96
.data:00005ae2 60                               ld h,b
.data:00005ae3 30 48                            jr nc,0x5b2d
.data:00005ae5 10 70                            djnz 0x5b57
.data:00005ae7 a5                               and l
.data:00005ae8 00                               nop
.data:00005ae9 cd d8 10                         call 0x10d8
.data:00005aec cd 77 5f                         call 0x5f77
.data:00005aef cd de 10                         call 0x10de
.data:00005af2 06 46                            ld b,0x46
.data:00005af4 c5                               push bc
.data:00005af5 21 00 40                         ld hl,0x4000
.data:00005af8 5d                               ld e,l
.data:00005af9 54                               ld d,h
.data:00005afa 4d                               ld c,l
.data:00005afb 44                               ld b,h
.data:00005afc ed b0                            ldir
.data:00005afe c1                               pop bc
.data:00005aff af                               xor a
.data:00005b00 cd 0a 5d                         call 0x5d0a
.data:00005b03 20 30                            jr nz,0x5b35
.data:00005b05 10 ed                            djnz 0x5af4
.data:00005b07 cd 00 10                         call 0x1000
.data:00005b0a cd 8b cf                         call 0xcf8b
.data:00005b0d af                               xor a
.data:00005b0e 11 cb cd                         ld de,0xcdcb
.data:00005b11 cd a0 c4                         call 0xc4a0
.data:00005b14 3e 01                            ld a,0x01
.data:00005b16 11 ff cd                         ld de,0xcdff
.data:00005b19 cd a0 c4                         call 0xc4a0
.data:00005b1c 3e 02                            ld a,0x02
.data:00005b1e 11 0c ce                         ld de,0xce0c
.data:00005b21 cd a0 c4                         call 0xc4a0
.data:00005b24 01 10 27                         ld bc,0x2710
.data:00005b27 c5                               push bc
.data:00005b28 cd 0a 5d                         call 0x5d0a
.data:00005b2b c1                               pop bc
.data:00005b2c 20 22                            jr nz,0x5b50
.data:00005b2e 0b                               dec bc
.data:00005b2f fb                               ei
.data:00005b30 76                               halt
.data:00005b31 78                               ld a,b
.data:00005b32 b1                               or c
.data:00005b33 20 f2                            jr nz,0x5b27
.data:00005b35 fe eb                            cp 0xeb
.data:00005b37 20 17                            jr nz,0x5b50
.data:00005b39 79                               ld a,c
.data:00005b3a fe 07                            cp 0x07
.data:00005b3c 20 12                            jr nz,0x5b50
.data:00005b3e af                               xor a
.data:00005b3f 32 9a 90                         ld (0x909a),a
.data:00005b42 3e 06                            ld a,0x06
.data:00005b44 cd 8a 88                         call 0x888a
.data:00005b47 76                               halt
.data:00005b48 76                               halt
.data:00005b49 76                               halt
.data:00005b4a 76                               halt
.data:00005b4b 3e 01                            ld a,0x01
.data:00005b4d cd 8a 88                         call 0x888a
.data:00005b50 cd 04 5d                         call 0x5d04
.data:00005b53 cd 29 64                         call 0x6429
.data:00005b56 cd 8b cf                         call 0xcf8b
.data:00005b59 cd d8 10                         call 0x10d8
.data:00005b5c cd a0 5c                         call 0x5ca0
.data:00005b5f cd 7c 64                         call 0x647c
.data:00005b62 01 f4 01                         ld bc,0x01f4
.data:00005b65 ed 43 43 60                      ld (0x6043),bc
.data:00005b69 cd cc 5b                         call 0x5bcc
.data:00005b6c cd de 10                         call 0x10de
.data:00005b6f cd 80 5c                         call 0x5c80
.data:00005b72 7b                               ld a,e
.data:00005b73 f5                               push af
.data:00005b74 21 bc 5b                         ld hl,0x5bbc
.data:00005b77 e5                               push hl
.data:00005b78 cb 47                            bit 0,a
.data:00005b7a 28 2b                            jr z,0x5ba7
.data:00005b7c e1                               pop hl
.data:00005b7d f1                               pop af
.data:00005b7e cd 8c 5b                         call 0x5b8c
.data:00005b81 af                               xor a
.data:00005b82 32 04 2c                         ld (0x2c04),a
.data:00005b85 32 24 2c                         ld (0x2c24),a
.data:00005b88 cd a0 89                         call 0x89a0
.data:00005b8b c9                               ret
.data:00005b8c 11 04 de                         ld de,0xde04
.data:00005b8f 06 90                            ld b,0x90
.data:00005b91 c5                               push bc
.data:00005b92 d5                               push de
.data:00005b93 62                               ld h,d
.data:00005b94 6b                               ld l,e
.data:00005b95 13                               inc de
.data:00005b96 36 ff                            ld (hl),0xff
.data:00005b98 01 17 00                         ld bc,0x0017
.data:00005b9b ed b0                            ldir
.data:00005b9d e1                               pop hl
.data:00005b9e 01 20 00                         ld bc,0x0020
.data:00005ba1 09                               add hl,bc
.data:00005ba2 eb                               ex de,hl
.data:00005ba3 c1                               pop bc
.data:00005ba4 10 eb                            djnz 0x5b91
.data:00005ba6 c9                               ret
.data:00005ba7 cb 6f                            bit 5,a
.data:00005ba9 c2 53 5c                         jp nz,0x5c53
.data:00005bac cb 4f                            bit 1,a
.data:00005bae c2 3a 5c                         jp nz,0x5c3a
.data:00005bb1 cb 5f                            bit 3,a
.data:00005bb3 c2 60 5c                         jp nz,0x5c60
.data:00005bb6 cb 67                            bit 4,a
.data:00005bb8 c2 70 5c                         jp nz,0x5c70
.data:00005bbb e1                               pop hl
.data:00005bbc f1                               pop af
.data:00005bbd a7                               and a
.data:00005bbe 20 a2                            jr nz,0x5b62
.data:00005bc0 ed 4b 43 60                      ld bc,(0x6043)
.data:00005bc4 0b                               dec bc
.data:00005bc5 78                               ld a,b
.data:00005bc6 b1                               or c
.data:00005bc7 ca e9 5a                         jp z,0x5ae9
.data:00005bca 18 99                            jr 0x5b65
.data:00005bcc 21 48 05                         ld hl,0x0548
.data:00005bcf 11 f9 5b                         ld de,0x5bf9
.data:00005bd2 cd d1 5c                         call 0x5cd1
.data:00005bd5 21 48 07                         ld hl,0x0748
.data:00005bd8 11 06 5c                         ld de,0x5c06
.data:00005bdb cd d1 5c                         call 0x5cd1
.data:00005bde 21 48 0b                         ld hl,0x0b48
.data:00005be1 11 14 5c                         ld de,0x5c14
.data:00005be4 cd d1 5c                         call 0x5cd1
.data:00005be7 21 48 0d                         ld hl,0x0d48
.data:00005bea 11 27 5c                         ld de,0x5c27
.data:00005bed cd d1 5c                         call 0x5cd1
.data:00005bf0 21 48 10                         ld hl,0x1048
.data:00005bf3 11 2f 5c                         ld de,0x5c2f
.data:00005bf6 c3 d1 5c                         jp 0x5cd1
.data:00005bf9 0b                               dec bc
.data:00005bfa f1                               pop af
.data:00005bfb 31 20 54                         ld sp,0x5420
.data:00005bfe 45                               ld b,l
.data:00005bff 43                               ld b,e
.data:00005c00 4c                               ld c,h
.data:00005c01 41                               ld b,c
.data:00005c02 44                               ld b,h
.data:00005c03 4f                               ld c,a
.data:00005c04 20 20                            jr nz,0x5c26
.data:00005c06 0c                               inc c
.data:00005c07 91                               sub c
.data:00005c08 32 20 4a                         ld (0x4a20),a
.data:00005c0b 4f                               ld c,a
.data:00005c0c 59                               ld e,c
.data:00005c0d 53                               ld d,e
.data:00005c0e 54                               ld d,h
.data:00005c0f 49                               ld c,c
.data:00005c10 43                               ld b,e
.data:00005c11 4b                               ld c,e
.data:00005c12 20 20                            jr nz,0x5c34
.data:00005c14 11 31 33                         ld de,0x3331
.data:00005c17 20 52                            jr nz,0x5c6b
.data:00005c19 45                               ld b,l
.data:00005c1a 44                               ld b,h
.data:00005c1b 45                               ld b,l
.data:00005c1c 46                               ld b,(hl)
.data:00005c1d 49                               ld c,c
.data:00005c1e 4e                               ld c,(hl)
.data:00005c1f 45                               ld b,l
.data:00005c20 20 54                            jr nz,0x5c76
.data:00005c22 45                               ld b,l
.data:00005c23 43                               ld b,e
.data:00005c24 4c                               ld c,h
.data:00005c25 41                               ld b,c
.data:00005c26 53                               ld d,e
.data:00005c27 06 c1                            ld b,0xc1
.data:00005c29 34                               inc (hl)
.data:00005c2a 20 44                            jr nz,0x5c70
.data:00005c2c 45                               ld b,l
.data:00005c2d 4d                               ld c,l
.data:00005c2e 4f                               ld c,a
.data:00005c2f 09                               add hl,bc
.data:00005c30 b1                               or c
.data:00005c31 30 20                            jr nc,0x5c53
.data:00005c33 4a                               ld c,d
.data:00005c34 55                               ld d,l
.data:00005c35 47                               ld b,a
.data:00005c36 41                               ld b,c
.data:00005c37 52                               ld d,d
.data:00005c38 20 20                            jr nz,0x5c5a
.data:00005c3a cd 1f 5d                         call 0x5d1f
.data:00005c3d 3e f1                            ld a,0xf1
.data:00005c3f 32 fa 5b                         ld (0x5bfa),a
.data:00005c42 3e 91                            ld a,0x91
.data:00005c44 32 07 5c                         ld (0x5c07),a
.data:00005c47 3e 00                            ld a,0x00
.data:00005c49 32 27 84                         ld (0x8427),a
.data:00005c4c cd a0 5c                         call 0x5ca0
.data:00005c4f cd 7c 64                         call 0x647c
.data:00005c52 c9                               ret
.data:00005c53 cd 45 60                         call 0x6045
.data:00005c56 cd 8b cf                         call 0xcf8b
.data:00005c59 cd a0 5c                         call 0x5ca0
.data:00005c5c cd 7c 64                         call 0x647c
.data:00005c5f c9                               ret
.data:00005c60 3e 01                            ld a,0x01
.data:00005c62 32 27 84                         ld (0x8427),a
.data:00005c65 3e f1                            ld a,0xf1
.data:00005c67 32 07 5c                         ld (0x5c07),a
.data:00005c6a 3e 91                            ld a,0x91
.data:00005c6c 32 fa 5b                         ld (0x5bfa),a
.data:00005c6f c9                               ret
.data:00005c70 3e 00                            ld a,0x00
.data:00005c72 32 27 84                         ld (0x8427),a
.data:00005c75 3e f1                            ld a,0xf1
.data:00005c77 32 fa 5b                         ld (0x5bfa),a
.data:00005c7a 3e 91                            ld a,0x91
.data:00005c7c 32 07 5c                         ld (0x5c07),a
.data:00005c7f c9                               ret
.data:00005c80 dd 21 93 5c                      ld ix,0x5c93
.data:00005c84 e5                               push hl
.data:00005c85 21 9f 5c                         ld hl,0x5c9f
.data:00005c88 36 00                            ld (hl),0x00
.data:00005c8a 1e 00                            ld e,0x00
.data:00005c8c 06 06                            ld b,0x06
.data:00005c8e cd 5a 8e                         call 0x8e5a
.data:00005c91 e1                               pop hl
.data:00005c92 c9                               ret
.data:00005c93 f0                               ret p
.data:00005c94 10 f0                            djnz 0x5c86
.data:00005c96 02                               ld (bc),a
.data:00005c97 f0                               ret p
.data:00005c98 04                               inc b
.data:00005c99 f0                               ret p
.data:00005c9a 08                               ex af,af'
.data:00005c9b f0                               ret p
.data:00005c9c 08                               ex af,af'
.data:00005c9d f0                               ret p
.data:00005c9e 01 00 cd                         ld bc,0xcd00
.data:00005ca1 8c                               adc a,h
.data:00005ca2 5b                               ld e,e
.data:00005ca3 21 00 20                         ld hl,0x2000
.data:00005ca6 01 00 18                         ld bc,0x1800
.data:00005ca9 3e 01                            ld a,0x01
.data:00005cab cd 31 89                         call 0x8931
.data:00005cae c9                               ret
.data:00005caf c5                               push bc
.data:00005cb0 e5                               push hl
.data:00005cb1 6f                               ld l,a
.data:00005cb2 26 00                            ld h,0x00
.data:00005cb4 29                               add hl,hl
.data:00005cb5 29                               add hl,hl
.data:00005cb6 29                               add hl,hl
.data:00005cb7 11 5b 92                         ld de,0x925b
.data:00005cba 19                               add hl,de
.data:00005cbb d1                               pop de
.data:00005cbc 01 08 00                         ld bc,0x0008
.data:00005cbf cd 42 89                         call 0x8942
.data:00005cc2 eb                               ex de,hl
.data:00005cc3 cb ec                            set 5,h
.data:00005cc5 08                               ex af,af'
.data:00005cc6 f5                               push af
.data:00005cc7 01 08 00                         ld bc,0x0008
.data:00005cca cd 31 89                         call 0x8931
.data:00005ccd f1                               pop af
.data:00005cce 08                               ex af,af'
.data:00005ccf c1                               pop bc
.data:00005cd0 c9                               ret
.data:00005cd1 f3                               di
.data:00005cd2 1a                               ld a,(de)
.data:00005cd3 4f                               ld c,a
.data:00005cd4 13                               inc de
.data:00005cd5 08                               ex af,af'
.data:00005cd6 1a                               ld a,(de)
.data:00005cd7 08                               ex af,af'
.data:00005cd8 13                               inc de
.data:00005cd9 1a                               ld a,(de)
.data:00005cda fe 20                            cp 0x20
.data:00005cdc 38 15                            jr c,0x5cf3
.data:00005cde e5                               push hl
.data:00005cdf d5                               push de
.data:00005ce0 cd af 5c                         call 0x5caf
.data:00005ce3 d1                               pop de
.data:00005ce4 e1                               pop hl
.data:00005ce5 3e 08                            ld a,0x08
.data:00005ce7 85                               add a,l
.data:00005ce8 6f                               ld l,a
.data:00005ce9 7c                               ld a,h
.data:00005cea ce 00                            adc a,0x00
.data:00005cec 67                               ld h,a
.data:00005ced 13                               inc de
.data:00005cee 0d                               dec c
.data:00005cef 20 e8                            jr nz,0x5cd9
.data:00005cf1 fb                               ei
.data:00005cf2 c9                               ret
.data:00005cf3 f5                               push af
.data:00005cf4 3e 08                            ld a,0x08
.data:00005cf6 85                               add a,l
.data:00005cf7 6f                               ld l,a
.data:00005cf8 f1                               pop af
.data:00005cf9 3d                               dec a
.data:00005cfa 20 f7                            jr nz,0x5cf3
.data:00005cfc 18 ef                            jr 0x5ced
.data:00005cfe cd 0a 5d                         call 0x5d0a
.data:00005d01 28 fb                            jr z,0x5cfe
.data:00005d03 c9                               ret
.data:00005d04 cd 0a 5d                         call 0x5d0a
.data:00005d07 20 fb                            jr nz,0x5d04
.data:00005d09 c9                               ret
.data:00005d0a 0e 00                            ld c,0x00
.data:00005d0c db aa                            in a,(0xaa)
.data:00005d0e e6 f0                            and 0xf0
.data:00005d10 81                               add a,c
.data:00005d11 d3 aa                            out (0xaa),a
.data:00005d13 db a9                            in a,(0xa9)
.data:00005d15 fe ff                            cp 0xff
.data:00005d17 c0                               ret nz
.data:00005d18 0c                               inc c
.data:00005d19 3e 09                            ld a,0x09
.data:00005d1b b9                               cp c
.data:00005d1c c8                               ret z
.data:00005d1d 18 ed                            jr 0x5d0c
.data:00005d1f cd a0 5c                         call 0x5ca0
.data:00005d22 cd da 5e                         call 0x5eda
.data:00005d25 21 48 04                         ld hl,0x0448
.data:00005d28 11 0a 5e                         ld de,0x5e0a
.data:00005d2b cd d1 5c                         call 0x5cd1
.data:00005d2e cd eb 5e                         call 0x5eeb
.data:00005d31 3e f1                            ld a,0xf1
.data:00005d33 08                               ex af,af'
.data:00005d34 3a 76 5f                         ld a,(0x5f76)
.data:00005d37 21 a8 04                         ld hl,0x04a8
.data:00005d3a fe 24                            cp 0x24
.data:00005d3c f5                               push af
.data:00005d3d dc f1 5d                         call c,0x5df1
.data:00005d40 f1                               pop af
.data:00005d41 38 03                            jr c,0x5d46
.data:00005d43 cd af 5c                         call 0x5caf
.data:00005d46 21 48 06                         ld hl,0x0648
.data:00005d49 11 11 5e                         ld de,0x5e11
.data:00005d4c cd d1 5c                         call 0x5cd1
.data:00005d4f cd eb 5e                         call 0x5eeb
.data:00005d52 3e f1                            ld a,0xf1
.data:00005d54 08                               ex af,af'
.data:00005d55 3a 76 5f                         ld a,(0x5f76)
.data:00005d58 21 a8 06                         ld hl,0x06a8
.data:00005d5b fe 24                            cp 0x24
.data:00005d5d f5                               push af
.data:00005d5e dc f1 5d                         call c,0x5df1
.data:00005d61 f1                               pop af
.data:00005d62 38 03                            jr c,0x5d67
.data:00005d64 cd af 5c                         call 0x5caf
.data:00005d67 21 48 08                         ld hl,0x0848
.data:00005d6a 11 19 5e                         ld de,0x5e19
.data:00005d6d cd d1 5c                         call 0x5cd1
.data:00005d70 cd eb 5e                         call 0x5eeb
.data:00005d73 3e f1                            ld a,0xf1
.data:00005d75 08                               ex af,af'
.data:00005d76 3a 76 5f                         ld a,(0x5f76)
.data:00005d79 21 a8 08                         ld hl,0x08a8
.data:00005d7c fe 24                            cp 0x24
.data:00005d7e f5                               push af
.data:00005d7f dc f1 5d                         call c,0x5df1
.data:00005d82 f1                               pop af
.data:00005d83 38 03                            jr c,0x5d88
.data:00005d85 cd af 5c                         call 0x5caf
.data:00005d88 21 48 0a                         ld hl,0x0a48
.data:00005d8b 11 20 5e                         ld de,0x5e20
.data:00005d8e cd d1 5c                         call 0x5cd1
.data:00005d91 cd eb 5e                         call 0x5eeb
.data:00005d94 3e f1                            ld a,0xf1
.data:00005d96 08                               ex af,af'
.data:00005d97 3a 76 5f                         ld a,(0x5f76)
.data:00005d9a 21 a8 0a                         ld hl,0x0aa8
.data:00005d9d fe 24                            cp 0x24
.data:00005d9f f5                               push af
.data:00005da0 dc f1 5d                         call c,0x5df1
.data:00005da3 f1                               pop af
.data:00005da4 38 03                            jr c,0x5da9
.data:00005da6 cd af 5c                         call 0x5caf
.data:00005da9 21 48 0c                         ld hl,0x0c48
.data:00005dac 11 2b 5e                         ld de,0x5e2b
.data:00005daf cd d1 5c                         call 0x5cd1
.data:00005db2 cd eb 5e                         call 0x5eeb
.data:00005db5 3e f1                            ld a,0xf1
.data:00005db7 08                               ex af,af'
.data:00005db8 3a 76 5f                         ld a,(0x5f76)
.data:00005dbb 21 a8 0c                         ld hl,0x0ca8
.data:00005dbe fe 24                            cp 0x24
.data:00005dc0 f5                               push af
.data:00005dc1 dc f1 5d                         call c,0x5df1
.data:00005dc4 f1                               pop af
.data:00005dc5 38 03                            jr c,0x5dca
.data:00005dc7 cd af 5c                         call 0x5caf
.data:00005dca 21 48 0e                         ld hl,0x0e48
.data:00005dcd 11 03 5e                         ld de,0x5e03
.data:00005dd0 cd d1 5c                         call 0x5cd1
.data:00005dd3 cd eb 5e                         call 0x5eeb
.data:00005dd6 3e f1                            ld a,0xf1
.data:00005dd8 08                               ex af,af'
.data:00005dd9 3a 76 5f                         ld a,(0x5f76)
.data:00005ddc 21 a8 0e                         ld hl,0x0ea8
.data:00005ddf fe 24                            cp 0x24
.data:00005de1 f5                               push af
.data:00005de2 dc f1 5d                         call c,0x5df1
.data:00005de5 f1                               pop af
.data:00005de6 38 03                            jr c,0x5deb
.data:00005de8 cd af 5c                         call 0x5caf
.data:00005deb cd 04 5d                         call 0x5d04
.data:00005dee c3 fe 5c                         jp 0x5cfe
.data:00005df1 16 00                            ld d,0x00
.data:00005df3 e5                               push hl
.data:00005df4 47                               ld b,a
.data:00005df5 21 56 5e                         ld hl,0x5e56
.data:00005df8 5e                               ld e,(hl)
.data:00005df9 1c                               inc e
.data:00005dfa 1c                               inc e
.data:00005dfb 19                               add hl,de
.data:00005dfc 10 fa                            djnz 0x5df8
.data:00005dfe eb                               ex de,hl
.data:00005dff e1                               pop hl
.data:00005e00 c3 d1 5c                         jp 0x5cd1
.data:00005e03 05                               dec b
.data:00005e04 51                               ld d,c
.data:00005e05 50                               ld d,b
.data:00005e06 41                               ld b,c
.data:00005e07 55                               ld d,l
.data:00005e08 53                               ld d,e
.data:00005e09 41                               ld b,c
.data:00005e0a 05                               dec b
.data:00005e0b 61                               ld h,c
.data:00005e0c 46                               ld b,(hl)
.data:00005e0d 55                               ld d,l
.data:00005e0e 45                               ld b,l
.data:00005e0f 47                               ld b,a
.data:00005e10 4f                               ld c,a
.data:00005e11 06 21                            ld b,0x21
.data:00005e13 41                               ld b,c
.data:00005e14 52                               ld d,d
.data:00005e15 52                               ld d,d
.data:00005e16 49                               ld c,c
.data:00005e17 42                               ld b,d
.data:00005e18 41                               ld b,c
.data:00005e19 05                               dec b
.data:00005e1a 21 41 42                         ld hl,0x4241
.data:00005e1d 41                               ld b,c
.data:00005e1e 4a                               ld c,d
.data:00005e1f 4f                               ld c,a
.data:00005e20 09                               add hl,bc
.data:00005e21 21 49 5a                         ld hl,0x5a49
.data:00005e24 51                               ld d,c
.data:00005e25 55                               ld d,l
.data:00005e26 49                               ld c,c
.data:00005e27 45                               ld b,l
.data:00005e28 52                               ld d,d
.data:00005e29 44                               ld b,h
.data:00005e2a 41                               ld b,c
.data:00005e2b 07                               rlca
.data:00005e2c 21 44 45                         ld hl,0x4544
.data:00005e2f 52                               ld d,d
.data:00005e30 45                               ld b,l
.data:00005e31 43                               ld b,e
.data:00005e32 48                               ld c,b
.data:00005e33 41                               ld b,c
.data:00005e34 07                               rlca
.data:00005e35 f1                               pop af
.data:00005e36 45                               ld b,l
.data:00005e37 53                               ld d,e
.data:00005e38 50                               ld d,b
.data:00005e39 41                               ld b,c
.data:00005e3a 43                               ld b,e
.data:00005e3b 49                               ld c,c
.data:00005e3c 4f                               ld c,a
.data:00005e3d 07                               rlca
.data:00005e3e f1                               pop af
.data:00005e3f 53                               ld d,e
.data:00005e40 2e 53                            ld l,0x53
.data:00005e42 48                               ld c,b
.data:00005e43 49                               ld c,c
.data:00005e44 46                               ld b,(hl)
.data:00005e45 54                               ld d,h
.data:00005e46 07                               rlca
.data:00005e47 f1                               pop af
.data:00005e48 43                               ld b,e
.data:00005e49 2e 53                            ld l,0x53
.data:00005e4b 48                               ld c,b
.data:00005e4c 49                               ld c,c
.data:00005e4d 46                               ld b,(hl)
.data:00005e4e 54                               ld d,h
.data:00005e4f 05                               dec b
.data:00005e50 f1                               pop af
.data:00005e51 45                               ld b,l
.data:00005e52 4e                               ld c,(hl)
.data:00005e53 54                               ld d,h
.data:00005e54 45                               ld b,l
.data:00005e55 52                               ld d,d
.data:00005e56 01 01 01                         ld bc,0x0101
.data:00005e59 05                               dec b
.data:00005e5a f1                               pop af
.data:00005e5b 53                               ld d,e
.data:00005e5c 48                               ld c,b
.data:00005e5d 49                               ld c,c
.data:00005e5e 46                               ld b,(hl)
.data:00005e5f 54                               ld d,h
.data:00005e60 04                               inc b
.data:00005e61 f1                               pop af
.data:00005e62 43                               ld b,e
.data:00005e63 54                               ld d,h
.data:00005e64 52                               ld d,d
.data:00005e65 4c                               ld c,h
.data:00005e66 05                               dec b
.data:00005e67 f1                               pop af
.data:00005e68 47                               ld b,a
.data:00005e69 52                               ld d,d
.data:00005e6a 41                               ld b,c
.data:00005e6b 50                               ld d,b
.data:00005e6c 48                               ld c,b
.data:00005e6d 04                               inc b
.data:00005e6e f1                               pop af
.data:00005e6f 43                               ld b,e
.data:00005e70 41                               ld b,c
.data:00005e71 50                               ld d,b
.data:00005e72 53                               ld d,e
.data:00005e73 01 f1 20                         ld bc,0x20f1
.data:00005e76 03                               inc bc
.data:00005e77 f1                               pop af
.data:00005e78 46                               ld b,(hl)
.data:00005e79 20 31                            jr nz,0x5eac
.data:00005e7b 03                               inc bc
.data:00005e7c f1                               pop af
.data:00005e7d 46                               ld b,(hl)
.data:00005e7e 20 32                            jr nz,0x5eb2
.data:00005e80 03                               inc bc
.data:00005e81 f1                               pop af
.data:00005e82 46                               ld b,(hl)
.data:00005e83 20 33                            jr nz,0x5eb8
.data:00005e85 03                               inc bc
.data:00005e86 f1                               pop af
.data:00005e87 46                               ld b,(hl)
.data:00005e88 20 34                            jr nz,0x5ebe
.data:00005e8a 03                               inc bc
.data:00005e8b f1                               pop af
.data:00005e8c 46                               ld b,(hl)
.data:00005e8d 20 35                            jr nz,0x5ec4
.data:00005e8f 06 f1                            ld b,0xf1
.data:00005e91 45                               ld b,l
.data:00005e92 53                               ld d,e
.data:00005e93 43                               ld b,e
.data:00005e94 41                               ld b,c
.data:00005e95 50                               ld d,b
.data:00005e96 45                               ld b,l
.data:00005e97 03                               inc bc
.data:00005e98 f1                               pop af
.data:00005e99 54                               ld d,h
.data:00005e9a 41                               ld b,c
.data:00005e9b 42                               ld b,d
.data:00005e9c 04                               inc b
.data:00005e9d f1                               pop af
.data:00005e9e 53                               ld d,e
.data:00005e9f 54                               ld d,h
.data:00005ea0 4f                               ld c,a
.data:00005ea1 50                               ld d,b
.data:00005ea2 02                               ld (bc),a
.data:00005ea3 f1                               pop af
.data:00005ea4 42                               ld b,d
.data:00005ea5 53                               ld d,e
.data:00005ea6 06 f1                            ld b,0xf1
.data:00005ea8 53                               ld d,e
.data:00005ea9 45                               ld b,l
.data:00005eaa 4c                               ld c,h
.data:00005eab 45                               ld b,l
.data:00005eac 43                               ld b,e
.data:00005ead 54                               ld d,h
.data:00005eae 05                               dec b
.data:00005eaf f1                               pop af
.data:00005eb0 45                               ld b,l
.data:00005eb1 4e                               ld c,(hl)
.data:00005eb2 54                               ld d,h
.data:00005eb3 45                               ld b,l
.data:00005eb4 52                               ld d,d
.data:00005eb5 07                               rlca
.data:00005eb6 f1                               pop af
.data:00005eb7 45                               ld b,l
.data:00005eb8 53                               ld d,e
.data:00005eb9 50                               ld d,b
.data:00005eba 41                               ld b,c
.data:00005ebb 43                               ld b,e
.data:00005ebc 49                               ld c,c
.data:00005ebd 4f                               ld c,a
.data:00005ebe 04                               inc b
.data:00005ebf f1                               pop af
.data:00005ec0 48                               ld c,b
.data:00005ec1 4f                               ld c,a
.data:00005ec2 4d                               ld c,l
.data:00005ec3 45                               ld b,l
.data:00005ec4 03                               inc bc
.data:00005ec5 f1                               pop af
.data:00005ec6 49                               ld c,c
.data:00005ec7 4e                               ld c,(hl)
.data:00005ec8 53                               ld d,e
.data:00005ec9 03                               inc bc
.data:00005eca f1                               pop af
.data:00005ecb 44                               ld b,h
.data:00005ecc 45                               ld b,l
.data:00005ecd 4c                               ld c,h
.data:00005ece 01 f1 21                         ld bc,0x21f1
.data:00005ed1 01 f1 22                         ld bc,0x22f1
.data:00005ed4 01 f1 23                         ld bc,0x23f1
.data:00005ed7 01 f1 24                         ld bc,0x24f1
.data:00005eda 21 88 8e                         ld hl,0x8e88
.data:00005edd 22 74 5f                         ld (0x5f74),hl
.data:00005ee0 21 2c 5f                         ld hl,0x5f2c
.data:00005ee3 06 48                            ld b,0x48
.data:00005ee5 cb be                            res 7,(hl)
.data:00005ee7 23                               inc hl
.data:00005ee8 10 fb                            djnz 0x5ee5
.data:00005eea c9                               ret
.data:00005eeb 2a 74 5f                         ld hl,(0x5f74)
.data:00005eee cd 04 5d                         call 0x5d04
.data:00005ef1 11 00 f0                         ld de,0xf000
.data:00005ef4 7a                               ld a,d
.data:00005ef5 d3 aa                            out (0xaa),a
.data:00005ef7 db a9                            in a,(0xa9)
.data:00005ef9 06 08                            ld b,0x08
.data:00005efb 0f                               rrca
.data:00005efc 30 0b                            jr nc,0x5f09
.data:00005efe 1c                               inc e
.data:00005eff 10 fa                            djnz 0x5efb
.data:00005f01 14                               inc d
.data:00005f02 7a                               ld a,d
.data:00005f03 fe f9                            cp 0xf9
.data:00005f05 20 ed                            jr nz,0x5ef4
.data:00005f07 18 e8                            jr 0x5ef1
.data:00005f09 3e 00                            ld a,0x00
.data:00005f0b 37                               scf
.data:00005f0c 1f                               rra
.data:00005f0d 10 fd                            djnz 0x5f0c
.data:00005f0f 72                               ld (hl),d
.data:00005f10 23                               inc hl
.data:00005f11 77                               ld (hl),a
.data:00005f12 23                               inc hl
.data:00005f13 e5                               push hl
.data:00005f14 16 00                            ld d,0x00
.data:00005f16 21 2c 5f                         ld hl,0x5f2c
.data:00005f19 19                               add hl,de
.data:00005f1a 7e                               ld a,(hl)
.data:00005f1b cb 7f                            bit 7,a
.data:00005f1d 28 03                            jr z,0x5f22
.data:00005f1f e1                               pop hl
.data:00005f20 18 c9                            jr 0x5eeb
.data:00005f22 32 76 5f                         ld (0x5f76),a
.data:00005f25 cb fe                            set 7,(hl)
.data:00005f27 e1                               pop hl
.data:00005f28 22 74 5f                         ld (0x5f74),hl
.data:00005f2b c9                               ret
.data:00005f2c 30 31                            jr nc,0x5f5f
.data:00005f2e 32 33 34                         ld (0x3433),a
.data:00005f31 35                               dec (hl)
.data:00005f32 36 37                            ld (hl),0x37
.data:00005f34 38 39                            jr c,0x5f6f
.data:00005f36 2d                               dec l
.data:00005f37 3d                               dec a
.data:00005f38 5c                               ld e,h
.data:00005f39 7b                               ld a,e
.data:00005f3a 7d                               ld a,l
.data:00005f3b 3b                               dec sp
.data:00005f3c 3a 20 2c                         ld a,(0x2c20)
.data:00005f3f 2e 2f                            ld l,0x2f
.data:00005f41 5e                               ld e,(hl)
.data:00005f42 41                               ld b,c
.data:00005f43 42                               ld b,d
.data:00005f44 43                               ld b,e
.data:00005f45 44                               ld b,h
.data:00005f46 45                               ld b,l
.data:00005f47 46                               ld b,(hl)
.data:00005f48 47                               ld b,a
.data:00005f49 48                               ld c,b
.data:00005f4a 49                               ld c,c
.data:00005f4b 4a                               ld c,d
.data:00005f4c 4b                               ld c,e
.data:00005f4d 4c                               ld c,h
.data:00005f4e 4d                               ld c,l
.data:00005f4f 4e                               ld c,(hl)
.data:00005f50 4f                               ld c,a
.data:00005f51 50                               ld d,b
.data:00005f52 51                               ld d,c
.data:00005f53 52                               ld d,d
.data:00005f54 53                               ld d,e
.data:00005f55 54                               ld d,h
.data:00005f56 55                               ld d,l
.data:00005f57 56                               ld d,(hl)
.data:00005f58 57                               ld d,a
.data:00005f59 58                               ld e,b
.data:00005f5a 59                               ld e,c
.data:00005f5b 5a                               ld e,d
.data:00005f5c 01 02 03                         ld bc,0x0302
.data:00005f5f 04                               inc b
.data:00005f60 05                               dec b
.data:00005f61 06 07                            ld b,0x07
.data:00005f63 08                               ex af,af'
.data:00005f64 09                               add hl,bc
.data:00005f65 0a                               ld a,(bc)
.data:00005f66 0b                               dec bc
.data:00005f67 0c                               inc c
.data:00005f68 0d                               dec c
.data:00005f69 0e 0f                            ld c,0x0f
.data:00005f6b 10 11                            djnz 0x5f7e
.data:00005f6d 12                               ld (de),a
.data:00005f6e 13                               inc de
.data:00005f6f 14                               inc d
.data:00005f70 15                               dec d
.data:00005f71 16 17                            ld d,0x17
.data:00005f73 18 00                            jr 0x5f75
.data:00005f75 00                               nop
.data:00005f76 00                               nop
.data:00005f77 cd a0 5c                         call 0x5ca0
.data:00005f7a 11 35 60                         ld de,0x6035
.data:00005f7d 21 48 02                         ld hl,0x0248
.data:00005f80 cd d1 5c                         call 0x5cd1
.data:00005f83 11 c2 5f                         ld de,0x5fc2
.data:00005f86 21 20 05                         ld hl,0x0520
.data:00005f89 cd d1 5c                         call 0x5cd1
.data:00005f8c 11 d4 5f                         ld de,0x5fd4
.data:00005f8f 21 60 07                         ld hl,0x0760
.data:00005f92 cd d1 5c                         call 0x5cd1
.data:00005f95 11 e8 5f                         ld de,0x5fe8
.data:00005f98 21 20 09                         ld hl,0x0920
.data:00005f9b cd d1 5c                         call 0x5cd1
.data:00005f9e 11 fa 5f                         ld de,0x5ffa
.data:00005fa1 21 60 0b                         ld hl,0x0b60
.data:00005fa4 cd d1 5c                         call 0x5cd1
.data:00005fa7 11 0c 60                         ld de,0x600c
.data:00005faa 21 20 0d                         ld hl,0x0d20
.data:00005fad cd d1 5c                         call 0x5cd1
.data:00005fb0 11 19 60                         ld de,0x6019
.data:00005fb3 21 60 0f                         ld hl,0x0f60
.data:00005fb6 cd d1 5c                         call 0x5cd1
.data:00005fb9 11 24 60                         ld de,0x6024
.data:00005fbc 21 40 12                         ld hl,0x1240
.data:00005fbf c3 d1 5c                         jp 0x5cd1
.data:00005fc2 0f                               rrca
.data:00005fc3 61                               ld h,c
.data:00005fc4 50                               ld d,b
.data:00005fc5 4f                               ld c,a
.data:00005fc6 47                               ld b,a
.data:00005fc7 52                               ld d,d
.data:00005fc8 41                               ld b,c
.data:00005fc9 4d                               ld c,l
.data:00005fca 41                               ld b,c
.data:00005fcb 44                               ld b,h
.data:00005fcc 4f                               ld c,a
.data:00005fcd 20 42                            jr nz,0x6011
.data:00005fcf 59                               ld e,c
.data:00005fd0 3a 20 20                         ld a,(0x2020)
.data:00005fd3 20 0f                            jr nz,0x5fe4
.data:00005fd5 f1                               pop af
.data:00005fd6 52                               ld d,d
.data:00005fd7 41                               ld b,c
.data:00005fd8 50                               ld d,b
.data:00005fd9 48                               ld c,b
.data:00005fda 41                               ld b,c
.data:00005fdb 45                               ld b,l
.data:00005fdc 4c                               ld c,h
.data:00005fdd 20 47                            jr nz,0x6026
.data:00005fdf 4f                               ld c,a
.data:00005fe0 4d                               ld c,l
.data:00005fe1 45                               ld b,l
.data:00005fe2 5a                               ld e,d
.data:00005fe3 5a                               ld e,d
.data:00005fe4 5a                               ld e,d
.data:00005fe5 2e 2e                            ld l,0x2e
.data:00005fe7 20 0d                            jr nz,0x5ff6
.data:00005fe9 61                               ld h,c
.data:00005fea 47                               ld b,a
.data:00005feb 52                               ld d,d
.data:00005fec 41                               ld b,c
.data:00005fed 50                               ld d,b
.data:00005fee 48                               ld c,b
.data:00005fef 49                               ld c,c
.data:00005ff0 43                               ld b,e
.data:00005ff1 4f                               ld c,a
.data:00005ff2 53                               ld d,e
.data:00005ff3 20 42                            jr nz,0x6037
.data:00005ff5 59                               ld e,c
.data:00005ff6 20 3a                            jr nz,0x6032
.data:00005ff8 20 20                            jr nz,0x601a
.data:00005ffa 11 f1 52                         ld de,0x52f1
.data:00005ffd 4f                               ld c,a
.data:00005ffe 42                               ld b,d
.data:00005fff 45                               ld b,l
.data:00006000 52                               ld d,d
.data:00006001 54                               ld d,h
.data:00006002 4f                               ld c,a
.data:00006003 20 50                            jr nz,0x6055
.data:00006005 2e 41                            ld l,0x41
.data:00006007 43                               ld b,e
.data:00006008 45                               ld b,l
.data:00006009 42                               ld b,d
.data:0000600a 45                               ld b,l
.data:0000600b 53                               ld d,e
.data:0000600c 0b                               dec bc
.data:0000600d 61                               ld h,c
.data:0000600e 4d                               ld c,l
.data:0000600f 55                               ld d,l
.data:00006010 53                               ld d,e
.data:00006011 49                               ld c,c
.data:00006012 43                               ld b,e
.data:00006013 2d                               dec l
.data:00006014 41                               ld b,c
.data:00006015 20 42                            jr nz,0x6059
.data:00006017 59                               ld e,c
.data:00006018 3a 09 f1                         ld a,(0xf109)
.data:0000601b 43                               ld b,e
.data:0000601c 4f                               ld c,a
.data:0000601d 4d                               ld c,l
.data:0000601e 49                               ld c,c
.data:0000601f 4c                               ld c,h
.data:00006020 4f                               ld c,a
.data:00006021 4e                               ld c,(hl)
.data:00006022 41                               ld b,c
.data:00006023 53                               ld d,e
.data:00006024 0f                               rrca
.data:00006025 21 54 4f                         ld hl,0x4f54
.data:00006028 50                               ld d,b
.data:00006029 4f                               ld c,a
.data:0000602a 53                               ld d,e
.data:0000602b 48                               ld c,b
.data:0000602c 4f                               ld c,a
.data:0000602d 57                               ld d,a
.data:0000602e 20 2d                            jr nz,0x605d
.data:00006030 31 39 38                         ld sp,0x3839
.data:00006033 38 2d                            jr c,0x6062
.data:00006035 0c                               inc c
.data:00006036 a1                               and c
.data:00006037 4d                               ld c,l
.data:00006038 41                               ld b,c
.data:00006039 44                               ld b,h
.data:0000603a 24                               inc h
.data:0000603b 4d                               ld c,l
.data:0000603c 49                               ld c,c
.data:0000603d 58                               ld e,b
.data:0000603e 20 47                            jr nz,0x6087
.data:00006040 41                               ld b,c
.data:00006041 4d                               ld c,l
.data:00006042 45                               ld b,l
.data:00006043 00                               nop
.data:00006044 00                               nop
.data:00006045 af                               xor a
.data:00006046 32 ca 60                         ld (0x60ca),a
.data:00006049 32 01 fc                         ld (0xfc01),a
.data:0000604c 32 00 fc                         ld (0xfc00),a
.data:0000604f 21 ca 60                         ld hl,0x60ca
.data:00006052 7e                               ld a,(hl)
.data:00006053 34                               inc (hl)
.data:00006054 fe 04                            cp 0x04
.data:00006056 ca c5 60                         jp z,0x60c5
.data:00006059 6f                               ld l,a
.data:0000605a 87                               add a,a
.data:0000605b 85                               add a,l
.data:0000605c 21 d0 60                         ld hl,0x60d0
.data:0000605f 85                               add a,l
.data:00006060 6f                               ld l,a
.data:00006061 7c                               ld a,h
.data:00006062 ce 00                            adc a,0x00
.data:00006064 67                               ld h,a
.data:00006065 7e                               ld a,(hl)
.data:00006066 32 07 2c                         ld (0x2c07),a
.data:00006069 23                               inc hl
.data:0000606a 4e                               ld c,(hl)
.data:0000606b 23                               inc hl
.data:0000606c 46                               ld b,(hl)
.data:0000606d ed 43 cb 60                      ld (0x60cb),bc
.data:00006071 af                               xor a
.data:00006072 32 27 2c                         ld (0x2c27),a
.data:00006075 32 0f 2c                         ld (0x2c0f),a
.data:00006078 cd 04 59                         call 0x5904
.data:0000607b cd 85 58                         call 0x5885
.data:0000607e cd 34 8c                         call 0x8c34
.data:00006081 cd 54 64                         call 0x6454
.data:00006084 af                               xor a
.data:00006085 32 cd 60                         ld (0x60cd),a
.data:00006088 cd 3c 8e                         call 0x8e3c
.data:0000608b af                               xor a
.data:0000608c 32 0f 2c                         ld (0x2c0f),a
.data:0000608f dd 2a cb 60                      ld ix,(0x60cb)
.data:00006093 21 cd 60                         ld hl,0x60cd
.data:00006096 34                               inc (hl)
.data:00006097 7e                               ld a,(hl)
.data:00006098 dd be 00                         cp (ix+0)
.data:0000609b dd 7e 01                         ld a,(ix+1)
.data:0000609e 38 0d                            jr c,0x60ad
.data:000060a0 dd 23                            inc ix
.data:000060a2 dd 23                            inc ix
.data:000060a4 36 00                            ld (hl),0x00
.data:000060a6 dd 7e 01                         ld a,(ix+1)
.data:000060a9 dd 22 cb 60                      ld (0x60cb),ix
.data:000060ad fe ff                            cp 0xff
.data:000060af ca 4f 60                         jp z,0x604f
.data:000060b2 e6 1f                            and 0x1f
.data:000060b4 57                               ld d,a
.data:000060b5 cd 36 2c                         call 0x2c36
.data:000060b8 cd a0 89                         call 0x89a0
.data:000060bb cd 06 91                         call 0x9106
.data:000060be cd 0a 5d                         call 0x5d0a
.data:000060c1 20 02                            jr nz,0x60c5
.data:000060c3 18 c3                            jr 0x6088
.data:000060c5 af                               xor a
.data:000060c6 32 ca 60                         ld (0x60ca),a
.data:000060c9 c9                               ret
.data:000060ca 00                               nop
.data:000060cb 00                               nop
.data:000060cc 00                               nop
.data:000060cd 01 00 fc                         ld bc,0xfc00
.data:000060d0 01 24 d5                         ld bc,0xd524
.data:000060d3 02                               ld (bc),a
.data:000060d4 64                               ld h,h
.data:000060d5 d5                               push de
.data:000060d6 04                               inc b
.data:000060d7 d4 d5 05                         call nc,0x05d5
.data:000060da 44                               ld b,h
.data:000060db d6 21                            sub 0x21
.data:000060dd 28 61                            jr z,0x6140
.data:000060df 7e                               ld a,(hl)
.data:000060e0 fe ff                            cp 0xff
.data:000060e2 28 16                            jr z,0x60fa
.data:000060e4 36 ff                            ld (hl),0xff
.data:000060e6 21 fe 60                         ld hl,0x60fe
.data:000060e9 47                               ld b,a
.data:000060ea 87                               add a,a
.data:000060eb 80                               add a,b
.data:000060ec 85                               add a,l
.data:000060ed 6f                               ld l,a
.data:000060ee 7c                               ld a,h
.data:000060ef ce 00                            adc a,0x00
.data:000060f1 67                               ld h,a
.data:000060f2 7e                               ld a,(hl)
.data:000060f3 23                               inc hl
.data:000060f4 5e                               ld e,(hl)
.data:000060f5 23                               inc hl
.data:000060f6 56                               ld d,(hl)
.data:000060f7 cd a0 c4                         call 0xc4a0
.data:000060fa cd eb c4                         call 0xc4eb
.data:000060fd c9                               ret
.data:000060fe 00                               nop
.data:000060ff e2 ce 00                         jp po,0x00ce
.data:00006102 8b                               adc a,e
.data:00006103 ce 00                            adc a,0x00
.data:00006105 62                               ld h,d
.data:00006106 cf                               rst 0x08
.data:00006107 01 70 cf                         ld bc,0xcf70
.data:0000610a 00                               nop
.data:0000610b 72                               ld (hl),d
.data:0000610c ce 01                            adc a,0x01
.data:0000610e 44                               ld b,h
.data:0000610f cf                               rst 0x08
.data:00006110 01 ac ce                         ld bc,0xceac
.data:00006113 01 7e ce                         ld bc,0xce7e
.data:00006116 00                               nop
.data:00006117 07                               rlca
.data:00006118 cf                               rst 0x08
.data:00006119 00                               nop
.data:0000611a 5a                               ld e,d
.data:0000611b ce 00                            adc a,0x00
.data:0000611d f0                               ret p
.data:0000611e ce 02                            adc a,0x02
.data:00006120 9c                               sbc a,h
.data:00006121 ce 00                            adc a,0x00
.data:00006123 cb cd                            set 1,l
.data:00006125 02                               ld (bc),a
.data:00006126 27                               daa
.data:00006127 cf                               rst 0x08
.data:00006128 00                               nop
.data:00006129 07                               rlca
.data:0000612a 07                               rlca
.data:0000612b 07                               rlca
.data:0000612c 47                               ld b,a
.data:0000612d 47                               ld b,a
.data:0000612e 07                               rlca
.data:0000612f 3a 3a 3a                         ld a,(0x3a3a)
.data:00006132 3a 3a 3a                         ld a,(0x3a3a)
.data:00006135 3a 3a 3a                         ld a,(0x3a3a)
.data:00006138 3a 3a 3a                         ld a,(0x3a3a)
.data:0000613b 3a 3a 3a                         ld a,(0x3a3a)
.data:0000613e 3a 3a 3a                         ld a,(0x3a3a)
.data:00006141 3a 3a 07                         ld a,(0x073a)
.data:00006144 47                               ld b,a
.data:00006145 47                               ld b,a
.data:00006146 07                               rlca
.data:00006147 07                               rlca
.data:00006148 07                               rlca
.data:00006149 07                               rlca
.data:0000614a 07                               rlca
.data:0000614b 47                               ld b,a
.data:0000614c 47                               ld b,a
.data:0000614d 47                               ld b,a
.data:0000614e 07                               rlca
.data:0000614f 7a                               ld a,d
.data:00006150 7a                               ld a,d
.data:00006151 7a                               ld a,d
.data:00006152 7a                               ld a,d
.data:00006153 7a                               ld a,d
.data:00006154 7a                               ld a,d
.data:00006155 7a                               ld a,d
.data:00006156 7a                               ld a,d
.data:00006157 7a                               ld a,d
.data:00006158 7a                               ld a,d
.data:00006159 7a                               ld a,d
.data:0000615a 7a                               ld a,d
.data:0000615b 7a                               ld a,d
.data:0000615c 7a                               ld a,d
.data:0000615d 7a                               ld a,d
.data:0000615e 7a                               ld a,d
.data:0000615f 7a                               ld a,d
.data:00006160 7a                               ld a,d
.data:00006161 7a                               ld a,d
.data:00006162 7a                               ld a,d
.data:00006163 07                               rlca
.data:00006164 47                               ld b,a
.data:00006165 47                               ld b,a
.data:00006166 47                               ld b,a
.data:00006167 07                               rlca
.data:00006168 07                               rlca
.data:00006169 07                               rlca
.data:0000616a 07                               rlca
.data:0000616b 47                               ld b,a
.data:0000616c 47                               ld b,a
.data:0000616d 00                               nop
.data:0000616e 00                               nop
.data:0000616f 00                               nop
.data:00006170 00                               nop
.data:00006171 00                               nop
.data:00006172 00                               nop
.data:00006173 00                               nop
.data:00006174 00                               nop
.data:00006175 00                               nop
.data:00006176 00                               nop
.data:00006177 00                               nop
.data:00006178 00                               nop
.data:00006179 00                               nop
.data:0000617a 00                               nop
.data:0000617b 00                               nop
.data:0000617c 00                               nop
.data:0000617d 00                               nop
.data:0000617e 00                               nop
.data:0000617f 00                               nop
.data:00006180 00                               nop
.data:00006181 00                               nop
.data:00006182 00                               nop
.data:00006183 00                               nop
.data:00006184 00                               nop
.data:00006185 47                               ld b,a
.data:00006186 47                               ld b,a
.data:00006187 07                               rlca
.data:00006188 07                               rlca
.data:00006189 07                               rlca
.data:0000618a 07                               rlca
.data:0000618b 07                               rlca
.data:0000618c 07                               rlca
.data:0000618d 00                               nop
.data:0000618e 00                               nop
.data:0000618f 00                               nop
.data:00006190 00                               nop
.data:00006191 00                               nop
.data:00006192 00                               nop
.data:00006193 00                               nop
.data:00006194 00                               nop
.data:00006195 00                               nop
.data:00006196 00                               nop
.data:00006197 00                               nop
.data:00006198 00                               nop
.data:00006199 00                               nop
.data:0000619a 00                               nop
.data:0000619b 00                               nop
.data:0000619c 00                               nop
.data:0000619d 00                               nop
.data:0000619e 00                               nop
.data:0000619f 00                               nop
.data:000061a0 00                               nop
.data:000061a1 00                               nop
.data:000061a2 00                               nop
.data:000061a3 00                               nop
.data:000061a4 00                               nop
.data:000061a5 07                               rlca
.data:000061a6 07                               rlca
.data:000061a7 07                               rlca
.data:000061a8 07                               rlca
.data:000061a9 07                               rlca
.data:000061aa 07                               rlca
.data:000061ab 3a 7a 00                         ld a,(0x007a)
.data:000061ae 00                               nop
.data:000061af 00                               nop
.data:000061b0 00                               nop
.data:000061b1 00                               nop
.data:000061b2 00                               nop
.data:000061b3 00                               nop
.data:000061b4 00                               nop
.data:000061b5 00                               nop
.data:000061b6 00                               nop
.data:000061b7 00                               nop
.data:000061b8 00                               nop
.data:000061b9 00                               nop
.data:000061ba 00                               nop
.data:000061bb 00                               nop
.data:000061bc 00                               nop
.data:000061bd 00                               nop
.data:000061be 00                               nop
.data:000061bf 00                               nop
.data:000061c0 00                               nop
.data:000061c1 00                               nop
.data:000061c2 00                               nop
.data:000061c3 00                               nop
.data:000061c4 00                               nop
.data:000061c5 7a                               ld a,d
.data:000061c6 3a 07 07                         ld a,(0x0707)
.data:000061c9 07                               rlca
.data:000061ca 07                               rlca
.data:000061cb 3a 7a 00                         ld a,(0x007a)
.data:000061ce 00                               nop
.data:000061cf 00                               nop
.data:000061d0 00                               nop
.data:000061d1 00                               nop
.data:000061d2 00                               nop
.data:000061d3 00                               nop
.data:000061d4 00                               nop
.data:000061d5 00                               nop
.data:000061d6 00                               nop
.data:000061d7 00                               nop
.data:000061d8 00                               nop
.data:000061d9 00                               nop
.data:000061da 00                               nop
.data:000061db 00                               nop
.data:000061dc 00                               nop
.data:000061dd 00                               nop
.data:000061de 00                               nop
.data:000061df 00                               nop
.data:000061e0 00                               nop
.data:000061e1 00                               nop
.data:000061e2 00                               nop
.data:000061e3 00                               nop
.data:000061e4 00                               nop
.data:000061e5 7a                               ld a,d
.data:000061e6 3a 07 07                         ld a,(0x0707)
.data:000061e9 07                               rlca
.data:000061ea 07                               rlca
.data:000061eb 3a 7a 00                         ld a,(0x007a)
.data:000061ee 00                               nop
.data:000061ef 00                               nop
.data:000061f0 00                               nop
.data:000061f1 00                               nop
.data:000061f2 00                               nop
.data:000061f3 00                               nop
.data:000061f4 00                               nop
.data:000061f5 00                               nop
.data:000061f6 00                               nop
.data:000061f7 00                               nop
.data:000061f8 00                               nop
.data:000061f9 00                               nop
.data:000061fa 00                               nop
.data:000061fb 00                               nop
.data:000061fc 00                               nop
.data:000061fd 00                               nop
.data:000061fe 00                               nop
.data:000061ff 00                               nop
.data:00006200 00                               nop
.data:00006201 00                               nop
.data:00006202 00                               nop
.data:00006203 00                               nop
.data:00006204 00                               nop
.data:00006205 7a                               ld a,d
.data:00006206 3a 07 07                         ld a,(0x0707)
.data:00006209 07                               rlca
.data:0000620a 07                               rlca
.data:0000620b 3a 7a 00                         ld a,(0x007a)
.data:0000620e 00                               nop
.data:0000620f 00                               nop
.data:00006210 00                               nop
.data:00006211 00                               nop
.data:00006212 00                               nop
.data:00006213 00                               nop
.data:00006214 00                               nop
.data:00006215 00                               nop
.data:00006216 00                               nop
.data:00006217 00                               nop
.data:00006218 00                               nop
.data:00006219 00                               nop
.data:0000621a 00                               nop
.data:0000621b 00                               nop
.data:0000621c 00                               nop
.data:0000621d 00                               nop
.data:0000621e 00                               nop
.data:0000621f 00                               nop
.data:00006220 00                               nop
.data:00006221 00                               nop
.data:00006222 00                               nop
.data:00006223 00                               nop
.data:00006224 00                               nop
.data:00006225 7a                               ld a,d
.data:00006226 3a 07 07                         ld a,(0x0707)
.data:00006229 07                               rlca
.data:0000622a 07                               rlca
.data:0000622b 3a 7a 00                         ld a,(0x007a)
.data:0000622e 00                               nop
.data:0000622f 00                               nop
.data:00006230 00                               nop
.data:00006231 00                               nop
.data:00006232 00                               nop
.data:00006233 00                               nop
.data:00006234 00                               nop
.data:00006235 00                               nop
.data:00006236 00                               nop
.data:00006237 00                               nop
.data:00006238 00                               nop
.data:00006239 00                               nop
.data:0000623a 00                               nop
.data:0000623b 00                               nop
.data:0000623c 00                               nop
.data:0000623d 00                               nop
.data:0000623e 00                               nop
.data:0000623f 00                               nop
.data:00006240 00                               nop
.data:00006241 00                               nop
.data:00006242 00                               nop
.data:00006243 00                               nop
.data:00006244 00                               nop
.data:00006245 7a                               ld a,d
.data:00006246 3a 07 07                         ld a,(0x0707)
.data:00006249 07                               rlca
.data:0000624a 07                               rlca
.data:0000624b 3a 7a 00                         ld a,(0x007a)
.data:0000624e 00                               nop
.data:0000624f 00                               nop
.data:00006250 00                               nop
.data:00006251 00                               nop
.data:00006252 00                               nop
.data:00006253 00                               nop
.data:00006254 00                               nop
.data:00006255 00                               nop
.data:00006256 00                               nop
.data:00006257 00                               nop
.data:00006258 00                               nop
.data:00006259 00                               nop
.data:0000625a 00                               nop
.data:0000625b 00                               nop
.data:0000625c 00                               nop
.data:0000625d 00                               nop
.data:0000625e 00                               nop
.data:0000625f 00                               nop
.data:00006260 00                               nop
.data:00006261 00                               nop
.data:00006262 00                               nop
.data:00006263 00                               nop
.data:00006264 00                               nop
.data:00006265 7a                               ld a,d
.data:00006266 3a 07 07                         ld a,(0x0707)
.data:00006269 07                               rlca
.data:0000626a 07                               rlca
.data:0000626b 3a 7a 00                         ld a,(0x007a)
.data:0000626e 00                               nop
.data:0000626f 00                               nop
.data:00006270 00                               nop
.data:00006271 00                               nop
.data:00006272 00                               nop
.data:00006273 00                               nop
.data:00006274 00                               nop
.data:00006275 00                               nop
.data:00006276 00                               nop
.data:00006277 00                               nop
.data:00006278 00                               nop
.data:00006279 00                               nop
.data:0000627a 00                               nop
.data:0000627b 00                               nop
.data:0000627c 00                               nop
.data:0000627d 00                               nop
.data:0000627e 00                               nop
.data:0000627f 00                               nop
.data:00006280 00                               nop
.data:00006281 00                               nop
.data:00006282 00                               nop
.data:00006283 00                               nop
.data:00006284 00                               nop
.data:00006285 7a                               ld a,d
.data:00006286 3a 07 07                         ld a,(0x0707)
.data:00006289 07                               rlca
.data:0000628a 07                               rlca
.data:0000628b 3a 7a 00                         ld a,(0x007a)
.data:0000628e 00                               nop
.data:0000628f 00                               nop
.data:00006290 00                               nop
.data:00006291 00                               nop
.data:00006292 00                               nop
.data:00006293 00                               nop
.data:00006294 00                               nop
.data:00006295 00                               nop
.data:00006296 00                               nop
.data:00006297 00                               nop
.data:00006298 00                               nop
.data:00006299 00                               nop
.data:0000629a 00                               nop
.data:0000629b 00                               nop
.data:0000629c 00                               nop
.data:0000629d 00                               nop
.data:0000629e 00                               nop
.data:0000629f 00                               nop
.data:000062a0 00                               nop
.data:000062a1 00                               nop
.data:000062a2 00                               nop
.data:000062a3 00                               nop
.data:000062a4 00                               nop
.data:000062a5 7a                               ld a,d
.data:000062a6 3a 07 07                         ld a,(0x0707)
.data:000062a9 07                               rlca
.data:000062aa 07                               rlca
.data:000062ab 3a 7a 00                         ld a,(0x007a)
.data:000062ae 00                               nop
.data:000062af 00                               nop
.data:000062b0 00                               nop
.data:000062b1 00                               nop
.data:000062b2 00                               nop
.data:000062b3 00                               nop
.data:000062b4 00                               nop
.data:000062b5 00                               nop
.data:000062b6 00                               nop
.data:000062b7 00                               nop
.data:000062b8 00                               nop
.data:000062b9 00                               nop
.data:000062ba 00                               nop
.data:000062bb 00                               nop
.data:000062bc 00                               nop
.data:000062bd 00                               nop
.data:000062be 00                               nop
.data:000062bf 00                               nop
.data:000062c0 00                               nop
.data:000062c1 00                               nop
.data:000062c2 00                               nop
.data:000062c3 00                               nop
.data:000062c4 00                               nop
.data:000062c5 7a                               ld a,d
.data:000062c6 3a 07 07                         ld a,(0x0707)
.data:000062c9 07                               rlca
.data:000062ca 02                               ld (bc),a
.data:000062cb 3a 7a 00                         ld a,(0x007a)
.data:000062ce 00                               nop
.data:000062cf 00                               nop
.data:000062d0 00                               nop
.data:000062d1 00                               nop
.data:000062d2 00                               nop
.data:000062d3 00                               nop
.data:000062d4 00                               nop
.data:000062d5 00                               nop
.data:000062d6 00                               nop
.data:000062d7 00                               nop
.data:000062d8 00                               nop
.data:000062d9 00                               nop
.data:000062da 00                               nop
.data:000062db 00                               nop
.data:000062dc 00                               nop
.data:000062dd 00                               nop
.data:000062de 00                               nop
.data:000062df 00                               nop
.data:000062e0 00                               nop
.data:000062e1 00                               nop
.data:000062e2 00                               nop
.data:000062e3 00                               nop
.data:000062e4 00                               nop
.data:000062e5 7a                               ld a,d
.data:000062e6 3a 02 07                         ld a,(0x0702)
.data:000062e9 07                               rlca
.data:000062ea 07                               rlca
.data:000062eb 3a 7a 00                         ld a,(0x007a)
.data:000062ee 00                               nop
.data:000062ef 00                               nop
.data:000062f0 00                               nop
.data:000062f1 00                               nop
.data:000062f2 00                               nop
.data:000062f3 00                               nop
.data:000062f4 00                               nop
.data:000062f5 00                               nop
.data:000062f6 00                               nop
.data:000062f7 00                               nop
.data:000062f8 00                               nop
.data:000062f9 00                               nop
.data:000062fa 00                               nop
.data:000062fb 00                               nop
.data:000062fc 00                               nop
.data:000062fd 00                               nop
.data:000062fe 00                               nop
.data:000062ff 00                               nop
.data:00006300 00                               nop
.data:00006301 00                               nop
.data:00006302 00                               nop
.data:00006303 00                               nop
.data:00006304 00                               nop
.data:00006305 7a                               ld a,d
.data:00006306 3a 07 07                         ld a,(0x0707)
.data:00006309 07                               rlca
.data:0000630a 07                               rlca
.data:0000630b 3a 7a 00                         ld a,(0x007a)
.data:0000630e 00                               nop
.data:0000630f 00                               nop
.data:00006310 00                               nop
.data:00006311 00                               nop
.data:00006312 00                               nop
.data:00006313 00                               nop
.data:00006314 00                               nop
.data:00006315 00                               nop
.data:00006316 00                               nop
.data:00006317 00                               nop
.data:00006318 00                               nop
.data:00006319 00                               nop
.data:0000631a 00                               nop
.data:0000631b 00                               nop
.data:0000631c 00                               nop
.data:0000631d 00                               nop
.data:0000631e 00                               nop
.data:0000631f 00                               nop
.data:00006320 00                               nop
.data:00006321 00                               nop
.data:00006322 00                               nop
.data:00006323 00                               nop
.data:00006324 00                               nop
.data:00006325 7a                               ld a,d
.data:00006326 3a 07 07                         ld a,(0x0707)
.data:00006329 07                               rlca
.data:0000632a 07                               rlca
.data:0000632b 3a 7a 00                         ld a,(0x007a)
.data:0000632e 00                               nop
.data:0000632f 00                               nop
.data:00006330 00                               nop
.data:00006331 00                               nop
.data:00006332 00                               nop
.data:00006333 00                               nop
.data:00006334 00                               nop
.data:00006335 00                               nop
.data:00006336 00                               nop
.data:00006337 00                               nop
.data:00006338 00                               nop
.data:00006339 00                               nop
.data:0000633a 00                               nop
.data:0000633b 00                               nop
.data:0000633c 00                               nop
.data:0000633d 00                               nop
.data:0000633e 00                               nop
.data:0000633f 00                               nop
.data:00006340 00                               nop
.data:00006341 00                               nop
.data:00006342 00                               nop
.data:00006343 00                               nop
.data:00006344 00                               nop
.data:00006345 7a                               ld a,d
.data:00006346 3a 07 07                         ld a,(0x0707)
.data:00006349 07                               rlca
.data:0000634a 07                               rlca
.data:0000634b 3a 7a 00                         ld a,(0x007a)
.data:0000634e 00                               nop
.data:0000634f 00                               nop
.data:00006350 00                               nop
.data:00006351 00                               nop
.data:00006352 00                               nop
.data:00006353 00                               nop
.data:00006354 00                               nop
.data:00006355 00                               nop
.data:00006356 00                               nop
.data:00006357 00                               nop
.data:00006358 00                               nop
.data:00006359 00                               nop
.data:0000635a 00                               nop
.data:0000635b 00                               nop
.data:0000635c 00                               nop
.data:0000635d 00                               nop
.data:0000635e 00                               nop
.data:0000635f 00                               nop
.data:00006360 00                               nop
.data:00006361 00                               nop
.data:00006362 00                               nop
.data:00006363 00                               nop
.data:00006364 00                               nop
.data:00006365 7a                               ld a,d
.data:00006366 3a 07 07                         ld a,(0x0707)
.data:00006369 07                               rlca
.data:0000636a 07                               rlca
.data:0000636b 07                               rlca
.data:0000636c 47                               ld b,a
.data:0000636d 00                               nop
.data:0000636e 00                               nop
.data:0000636f 00                               nop
.data:00006370 00                               nop
.data:00006371 00                               nop
.data:00006372 00                               nop
.data:00006373 00                               nop
.data:00006374 00                               nop
.data:00006375 00                               nop
.data:00006376 00                               nop
.data:00006377 00                               nop
.data:00006378 00                               nop
.data:00006379 00                               nop
.data:0000637a 00                               nop
.data:0000637b 00                               nop
.data:0000637c 00                               nop
.data:0000637d 00                               nop
.data:0000637e 00                               nop
.data:0000637f 00                               nop
.data:00006380 00                               nop
.data:00006381 00                               nop
.data:00006382 00                               nop
.data:00006383 00                               nop
.data:00006384 00                               nop
.data:00006385 47                               ld b,a
.data:00006386 07                               rlca
.data:00006387 07                               rlca
.data:00006388 07                               rlca
.data:00006389 07                               rlca
.data:0000638a 07                               rlca
.data:0000638b 47                               ld b,a
.data:0000638c 47                               ld b,a
.data:0000638d 00                               nop
.data:0000638e 00                               nop
.data:0000638f 00                               nop
.data:00006390 00                               nop
.data:00006391 00                               nop
.data:00006392 00                               nop
.data:00006393 00                               nop
.data:00006394 00                               nop
.data:00006395 00                               nop
.data:00006396 00                               nop
.data:00006397 00                               nop
.data:00006398 00                               nop
.data:00006399 00                               nop
.data:0000639a 00                               nop
.data:0000639b 00                               nop
.data:0000639c 00                               nop
.data:0000639d 00                               nop
.data:0000639e 00                               nop
.data:0000639f 00                               nop
.data:000063a0 00                               nop
.data:000063a1 00                               nop
.data:000063a2 00                               nop
.data:000063a3 00                               nop
.data:000063a4 00                               nop
.data:000063a5 47                               ld b,a
.data:000063a6 47                               ld b,a
.data:000063a7 07                               rlca
.data:000063a8 07                               rlca
.data:000063a9 07                               rlca
.data:000063aa 07                               rlca
.data:000063ab 47                               ld b,a
.data:000063ac 47                               ld b,a
.data:000063ad 47                               ld b,a
.data:000063ae 07                               rlca
.data:000063af 7a                               ld a,d
.data:000063b0 7a                               ld a,d
.data:000063b1 7a                               ld a,d
.data:000063b2 7a                               ld a,d
.data:000063b3 7a                               ld a,d
.data:000063b4 7a                               ld a,d
.data:000063b5 7a                               ld a,d
.data:000063b6 7a                               ld a,d
.data:000063b7 7a                               ld a,d
.data:000063b8 7a                               ld a,d
.data:000063b9 7a                               ld a,d
.data:000063ba 7a                               ld a,d
.data:000063bb 7a                               ld a,d
.data:000063bc 7a                               ld a,d
.data:000063bd 7a                               ld a,d
.data:000063be 7a                               ld a,d
.data:000063bf 7a                               ld a,d
.data:000063c0 7a                               ld a,d
.data:000063c1 7a                               ld a,d
.data:000063c2 7a                               ld a,d
.data:000063c3 07                               rlca
.data:000063c4 47                               ld b,a
.data:000063c5 47                               ld b,a
.data:000063c6 47                               ld b,a
.data:000063c7 07                               rlca
.data:000063c8 07                               rlca
.data:000063c9 07                               rlca
.data:000063ca 07                               rlca
.data:000063cb 47                               ld b,a
.data:000063cc 47                               ld b,a
.data:000063cd 47                               ld b,a
.data:000063ce 07                               rlca
.data:000063cf 3a 3a 3a                         ld a,(0x3a3a)
.data:000063d2 3a 3a 3a                         ld a,(0x3a3a)
.data:000063d5 3a 3a 3a                         ld a,(0x3a3a)
.data:000063d8 3a 3a 3a                         ld a,(0x3a3a)
.data:000063db 3a 3a 3a                         ld a,(0x3a3a)
.data:000063de 3a 3a 3a                         ld a,(0x3a3a)
.data:000063e1 3a 3a 07                         ld a,(0x073a)
.data:000063e4 47                               ld b,a
.data:000063e5 47                               ld b,a
.data:000063e6 47                               ld b,a
.data:000063e7 07                               rlca
.data:000063e8 07                               rlca
.data:000063e9 28 28                            jr z,0x6413
.data:000063eb 28 28                            jr z,0x6415
.data:000063ed 28 28                            jr z,0x6417
.data:000063ef 28 78                            jr z,0x6469
.data:000063f1 38 30                            jr c,0x6423
.data:000063f3 30 30                            jr nc,0x6425
.data:000063f5 30 30                            jr nc,0x6427
.data:000063f7 30 30                            jr nc,0x6429
.data:000063f9 30 30                            jr nc,0x642b
.data:000063fb 30 30                            jr nc,0x642d
.data:000063fd 20 20                            jr nz,0x641f
.data:000063ff 20 20                            jr nz,0x6421
.data:00006401 20 20                            jr nz,0x6423
.data:00006403 20 20                            jr nz,0x6425
.data:00006405 20 20                            jr nz,0x6427
.data:00006407 20 20                            jr nz,0x6429
.data:00006409 68                               ld l,b
.data:0000640a 68                               ld l,b
.data:0000640b 68                               ld l,b
.data:0000640c 68                               ld l,b
.data:0000640d 68                               ld l,b
.data:0000640e 68                               ld l,b
.data:0000640f 68                               ld l,b
.data:00006410 78                               ld a,b
.data:00006411 68                               ld l,b
.data:00006412 70                               ld (hl),b
.data:00006413 70                               ld (hl),b
.data:00006414 70                               ld (hl),b
.data:00006415 70                               ld (hl),b
.data:00006416 70                               ld (hl),b
.data:00006417 70                               ld (hl),b
.data:00006418 70                               ld (hl),b
.data:00006419 70                               ld (hl),b
.data:0000641a 70                               ld (hl),b
.data:0000641b 70                               ld (hl),b
.data:0000641c 70                               ld (hl),b
.data:0000641d 60                               ld h,b
.data:0000641e 60                               ld h,b
.data:0000641f 60                               ld h,b
.data:00006420 60                               ld h,b
.data:00006421 60                               ld h,b
.data:00006422 60                               ld h,b
.data:00006423 60                               ld h,b
.data:00006424 60                               ld h,b
.data:00006425 60                               ld h,b
.data:00006426 60                               ld h,b
.data:00006427 60                               ld h,b
.data:00006428 60                               ld h,b
.data:00006429 f3                               di
.data:0000642a 21 00 20                         ld hl,0x2000
.data:0000642d 01 f8 17                         ld bc,0x17f8
.data:00006430 3e 01                            ld a,0x01
.data:00006432 cd 31 89                         call 0x8931
.data:00006435 11 00 00                         ld de,0x0000
.data:00006438 21 b6 d6                         ld hl,0xd6b6
.data:0000643b 01 66 03                         ld bc,0x0366
.data:0000643e c5                               push bc
.data:0000643f 7e                               ld a,(hl)
.data:00006440 23                               inc hl
.data:00006441 4e                               ld c,(hl)
.data:00006442 06 00                            ld b,0x00
.data:00006444 23                               inc hl
.data:00006445 eb                               ex de,hl
.data:00006446 c5                               push bc
.data:00006447 cd 31 89                         call 0x8931
.data:0000644a c1                               pop bc
.data:0000644b 09                               add hl,bc
.data:0000644c eb                               ex de,hl
.data:0000644d c1                               pop bc
.data:0000644e 0b                               dec bc
.data:0000644f 78                               ld a,b
.data:00006450 b1                               or c
.data:00006451 20 eb                            jr nz,0x643e
.data:00006453 c9                               ret
.data:00006454 01 00 03                         ld bc,0x0300
.data:00006457 11 00 20                         ld de,0x2000
.data:0000645a 21 29 61                         ld hl,0x6129
.data:0000645d af                               xor a
.data:0000645e 32 88 88                         ld (0x8888),a
.data:00006461 c5                               push bc
.data:00006462 7e                               ld a,(hl)
.data:00006463 cd 84 64                         call 0x6484
.data:00006466 23                               inc hl
.data:00006467 01 08 00                         ld bc,0x0008
.data:0000646a eb                               ex de,hl
.data:0000646b c5                               push bc
.data:0000646c cd 31 89                         call 0x8931
.data:0000646f c1                               pop bc
.data:00006470 09                               add hl,bc
.data:00006471 eb                               ex de,hl
.data:00006472 c1                               pop bc
.data:00006473 0b                               dec bc
.data:00006474 78                               ld a,b
.data:00006475 b1                               or c
.data:00006476 20 e9                            jr nz,0x6461
.data:00006478 cd de 10                         call 0x10de
.data:0000647b c9                               ret
.data:0000647c cd d8 10                         call 0x10d8
.data:0000647f 01 c0 02                         ld bc,0x02c0
.data:00006482 18 d3                            jr 0x6457
.data:00006484 e5                               push hl
.data:00006485 c5                               push bc
.data:00006486 47                               ld b,a
.data:00006487 e6 07                            and 0x07
.data:00006489 4f                               ld c,a
.data:0000648a 78                               ld a,b
.data:0000648b e6 78                            and 0x78
.data:0000648d 0f                               rrca
.data:0000648e 0f                               rrca
.data:0000648f 0f                               rrca
.data:00006490 6f                               ld l,a
.data:00006491 e6 08                            and 0x08
.data:00006493 b1                               or c
.data:00006494 4f                               ld c,a
.data:00006495 7d                               ld a,l
.data:00006496 21 78 89                         ld hl,0x8978
.data:00006499 85                               add a,l
.data:0000649a 6f                               ld l,a
.data:0000649b 46                               ld b,(hl)
.data:0000649c 21 78 89                         ld hl,0x8978
.data:0000649f 79                               ld a,c
.data:000064a0 85                               add a,l
.data:000064a1 6f                               ld l,a
.data:000064a2 7e                               ld a,(hl)
.data:000064a3 07                               rlca
.data:000064a4 07                               rlca
.data:000064a5 07                               rlca
.data:000064a6 07                               rlca
.data:000064a7 b0                               or b
.data:000064a8 c1                               pop bc
.data:000064a9 e1                               pop hl
.data:000064aa c9                               ret
.data:000064ab f3                               di
.data:000064ac 3e 55                            ld a,0x55
.data:000064ae d3 a8                            out (0xa8),a
.data:000064b0 21 00 84                         ld hl,0x8400
.data:000064b3 11 00 10                         ld de,0x1000
.data:000064b6 01 ab 54                         ld bc,0x54ab
.data:000064b9 ed b0                            ldir
.data:000064bb cd 00 10                         call 0x1000
.data:000064be 3e 50                            ld a,0x50
.data:000064c0 d3 a8                            out (0xa8),a
.data:000064c2 fb                               ei
.data:000064c3 c9                               ret
.data:000064c4 ff                               rst 0x38
.data:000064c5 ff                               rst 0x38
.data:000064c6 00                               nop
.data:000064c7 00                               nop
.data:000064c8 00                               nop
.data:000064c9 ff                               rst 0x38
.data:000064ca 00                               nop
.data:000064cb 00                               nop
.data:000064cc ff                               rst 0x38
.data:000064cd 00                               nop
.data:000064ce 00                               nop
.data:000064cf ff                               rst 0x38
.data:000064d0 00                               nop
.data:000064d1 00                               nop
.data:000064d2 ff                               rst 0x38
.data:000064d3 00                               nop
.data:000064d4 00                               nop
.data:000064d5 ff                               rst 0x38
.data:000064d6 00                               nop
.data:000064d7 00                               nop
.data:000064d8 ff                               rst 0x38
.data:000064d9 00                               nop
.data:000064da 00                               nop
.data:000064db ff                               rst 0x38
.data:000064dc 8c                               adc a,h
.data:000064dd 00                               nop
.data:000064de ff                               rst 0x38
.data:000064df 00                               nop
.data:000064e0 00                               nop
.data:000064e1 ff                               rst 0x38
.data:000064e2 00                               nop
.data:000064e3 00                               nop
.data:000064e4 ff                               rst 0x38
.data:000064e5 00                               nop
.data:000064e6 00                               nop
.data:000064e7 ff                               rst 0x38
.data:000064e8 00                               nop
.data:000064e9 00                               nop
.data:000064ea ff                               rst 0x38
.data:000064eb 00                               nop
.data:000064ec d3 ff                            out (0xff),a
.data:000064ee 00                               nop
.data:000064ef 00                               nop
.data:000064f0 ff                               rst 0x38
.data:000064f1 00                               nop
.data:000064f2 00                               nop
.data:000064f3 ff                               rst 0x38
.data:000064f4 00                               nop
.data:000064f5 00                               nop
.data:000064f6 ff                               rst 0x38
.data:000064f7 00                               nop
.data:000064f8 00                               nop
.data:000064f9 ff                               rst 0x38
.data:000064fa 00                               nop
.data:000064fb 00                               nop
.data:000064fc ff                               rst 0x38
.data:000064fd 00                               nop
.data:000064fe 00                               nop
.data:000064ff ff                               rst 0x38
.data:00006500 0d                               dec c
