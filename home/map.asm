INCLUDE "constants.asm"

SECTION "Map functions", ROM0[$20FF]

; Runs a map script indexed by wMapScriptNumber
RunMapScript:: ; 20ff
	push hl
	push de
	push bc
	ld a, [wMapScriptNumber]
	add a, a
	add a, a
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .return
	push de
	jp hl
.return
	pop bc
	pop de
	pop hl
	ret
