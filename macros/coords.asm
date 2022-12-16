hlcoord EQUS "coord hl,"
bccoord EQUS "coord bc,"
decoord EQUS "coord de,"

MACRO coord
; register, x, y[, origin]
	if _NARG < 4
	ld \1, (\3) * SCREEN_WIDTH + (\2) + wTileMap
	else
	ld \1, (\3) * SCREEN_WIDTH + (\2) + \4
	endc
ENDM

hlbgcoord EQUS "bgcoord hl,"
bcbgcoord EQUS "bgcoord bc,"
debgcoord EQUS "bgcoord de,"

MACRO bgcoord
; register, x, y[, origin]
	if _NARG < 4
	ld \1, (\3) * BG_MAP_WIDTH + (\2) + vBGMap0
	else
	ld \1, (\3) * BG_MAP_WIDTH + (\2) + \4
	endc
ENDM

MACRO dwcoord
; x, y
rept _NARG / 2
	dw (\2) * SCREEN_WIDTH + (\1) + wTileMap
	shift
	shift
endr
ENDM

MACRO ldcoord_a
; x, y[, origin]
	if _NARG < 3
	ld [(\2) * SCREEN_WIDTH + (\1) + wTileMap], a
	else
	ld [(\2) * SCREEN_WIDTH + (\1) + \3], a
	endc
ENDM

MACRO ldbgcoord_a
; x, y[, origin]
	if _NARG < 3
	ld [(\2) * BG_MAP_WIDTH + (\1) + vBGMap0], a
	else
	ld [(\2) * BG_MAP_WIDTH + (\1) + \3], a
	endc
ENDM

MACRO lda_coord
; x, y[, origin]
	if _NARG < 3
	ld a, [(\2) * SCREEN_WIDTH + (\1) + wTileMap]
	else
	ld a, [(\2) * SCREEN_WIDTH + (\1) + \3]
	endc
ENDM

MACRO lda_bgcoord
; x, y[, origin]
	if _NARG < 3
	ld a, [(\2) * BG_MAP_WIDTH + (\1) + vBGMap0]
	else
	ld a, [(\2) * BG_MAP_WIDTH + (\1) + \3]
	endc
ENDM
