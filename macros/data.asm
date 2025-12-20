; Value macros

DEF percent EQUS "* $ff / 100"


; Constant data (db, dw, dl) macros

MACRO? dwb
	dw \1
	db \2
ENDM

MACRO? dbw
	db \1
	dw \2
ENDM

MACRO? dbbw
	db \1, \2
	dw \3
ENDM

MACRO? dbww
	db \1
	dw \2, \3
ENDM

MACRO? dbwww
	db \1
	dw \2, \3, \4
ENDM

MACRO? dn ; nybbles
rept _NARG / 2
	db ((\1) << 4) | (\2)
	shift 2
endr
ENDM

MACRO? nybble_array
	DEF CURRENT_NYBBLE_ARRAY_VALUE = 0
	DEF CURRENT_NYBBLE_ARRAY_LENGTH = 0
	IF _NARG == 1
		REDEF CURRENT_NYBBLE_ARRAY_START EQUS "\1"
	ELSE
		REDEF CURRENT_NYBBLE_ARRAY_START EQUS "._nybble_array\@"
	{CURRENT_NYBBLE_ARRAY_START}:
	ENDC
ENDM

MACRO? nybble ; For vertical lists of nybbles
	ASSERT 0 <= (\1) && (\1) < $10, "nybbles must be 0-15"
	DEF CURRENT_NYBBLE_ARRAY_VALUE = (\1) | (CURRENT_NYBBLE_ARRAY_VALUE << 4)
	DEF CURRENT_NYBBLE_ARRAY_LENGTH += 1
	IF CURRENT_NYBBLE_ARRAY_LENGTH % 2 == 0
		db CURRENT_NYBBLE_ARRAY_VALUE
		DEF CURRENT_NYBBLE_ARRAY_VALUE = 0
	ENDC
ENDM

MACRO? end_nybble_array
	IF CURRENT_NYBBLE_ARRAY_LENGTH % 2
		db CURRENT_NYBBLE_ARRAY_VALUE << 4
	ENDC
	IF _NARG == 1
		DEF x = \1
		ASSERT x == CURRENT_NYBBLE_ARRAY_LENGTH, \
			"{CURRENT_NYBBLE_ARRAY_START}: expected {d:x} nybbles, got {d:CURRENT_NYBBLE_ARRAY_LENGTH}"
		DEF x = (x + 1) / 2
		ASSERT x == @ - {CURRENT_NYBBLE_ARRAY_START}, \
			"{CURRENT_NYBBLE_ARRAY_START}: expected {d:x} bytes"
	ENDC
ENDM

MACRO? dc ; "crumbs"
rept _NARG / 4
	db ((\1) << 6) | ((\2) << 4) | ((\3) << 2) | (\4)
	shift 4
endr
ENDM

MACRO? dx
DEF x = 8 * ((\1) - 1)
rept \1
	db LOW((\2) >> x)
DEF x = x - 8
endr
ENDM

MACRO? dt ; three-byte (big-endian)
	dx 3, \1
ENDM

MACRO? dd ; four-byte (big-endian)
	dx 4, \1
ENDM

MACRO? littledt ; three-byte (little-endian)
    db low(\1), high(\1), low((\1) >> 16)
ENDM

MACRO? bigdw ; big-endian word
	dx 2, \1
ENDM

MACRO? dba ; dbw bank, address
rept _NARG
	dbw BANK(\1), \1
	shift
endr
ENDM

MACRO? dab ; dwb address, bank
rept _NARG
	dwb \1, BANK(\1)
	shift
endr
ENDM

MACRO? dba_pic ; dbw bank, address
	db BANK(\1) - PICS_FIX
	dw \1
ENDM


MACRO? dbpixel
if _NARG >= 4
; x tile, x pxl, y tile, y pxl
	db \1 * 8 + \3, \2 * 8 + \4
else
; x, y
	db \1 * 8, \2 * 8
endc
ENDM

MACRO? dsprite
; y tile, y pxl, x tile, x pxl, vtile offset, flags, attributes
	db LOW(\1 * 8) + \2, LOW(\3 * 8) + \4, \5, \6
ENDM


MACRO? menu_coords
; x1, y1, x2, y2
	db \2, \1 ; start coords
	db \4, \3 ; end coords
ENDM


MACRO? bcd
rept _NARG
	dn LOW(\1) / 10, (\1) % 10
	shift
endr
ENDM


MACRO? sine_table
; \1 samples of sin(x) from x=0 to x<32768 (pi radians)
DEF x = 0
rept \1
	dw (sin(x) + LOW(sin(x))) >> 8 ; round up
DEF x = x + 32768 / \1 ; a circle has 65536 "degrees"
endr
ENDM
