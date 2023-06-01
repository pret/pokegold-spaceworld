; Value macros

DEF percent EQUS "* $ff / 100"


; Constant data (db, dw, dl) macros

MACRO dwb
	dw \1
	db \2
ENDM

MACRO dbw
	db \1
	dw \2
ENDM

MACRO dbbw
	db \1, \2
	dw \3
ENDM

MACRO dbww
	db \1
	dw \2, \3
ENDM

MACRO dbwww
	db \1
	dw \2, \3, \4
ENDM

MACRO dn ; nybbles
rept _NARG / 2
	db ((\1) << 4) | (\2)
	shift 2
endr
ENDM

MACRO dc ; "crumbs"
rept _NARG / 4
	db ((\1) << 6) | ((\2) << 4) | ((\3) << 2) | (\4)
	shift 4
endr
ENDM

MACRO dx
DEF x = 8 * ((\1) - 1)
rept \1
	db LOW((\2) >> x)
DEF x = x - 8
endr
ENDM

MACRO dt ; three-byte (big-endian)
	dx 3, \1
ENDM

MACRO dd ; four-byte (big-endian)
	dx 4, \1
ENDM

MACRO bigdw ; big-endian word
	dx 2, \1
ENDM

MACRO dba ; dbw bank, address
rept _NARG
	dbw BANK(\1), \1
	shift
endr
ENDM

MACRO dab ; dwb address, bank
rept _NARG
	dwb \1, BANK(\1)
	shift
endr
ENDM

MACRO dba_pic ; dbw bank, address
	db BANK(\1) - PICS_FIX
	dw \1
ENDM


MACRO dbpixel
if _NARG >= 4
; x tile, x pxl, y tile, y pxl
	db \1 * 8 + \3, \2 * 8 + \4
else
; x, y
	db \1 * 8, \2 * 8
endc
ENDM

MACRO dsprite
; y tile, y pxl, x tile, x pxl, vtile offset, flags, attributes
	db LOW(\1 * 8) + \2, LOW(\3 * 8) + \4, \5, \6
ENDM


MACRO menu_coords
; x1, y1, x2, y2
	db \2, \1 ; start coords
	db \4, \3 ; end coords
ENDM


MACRO bcd
rept _NARG
	dn LOW(\1) / 10, (\1) % 10
	shift
endr
ENDM


MACRO sine_table
; \1 samples of sin(x) from x=0 to x<32768 (pi radians)
DEF x = 0
rept \1
	dw (sin(x) + LOW(sin(x))) >> 8 ; round up
DEF x = x + 32768 / \1 ; a circle has 65536 "degrees"
endr
ENDM
