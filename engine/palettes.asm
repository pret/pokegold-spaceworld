INCLUDE "constants.asm"

SECTION "engine/palettes.asm", ROMX

UpdateTimeOfDayPal:
	call UpdateTime
	call GetTimePalette
	ret

_TimeOfDayPals:
	ld hl, wTimeOfDayPalFlags
	bit CLEAR_PALSET_F, [hl]
	ret nz

	ld a, [wTimeOfDay]
	ld hl, wCurTimeOfDay
	cp [hl]
	ret z

	call OverworldFadeOut
	call GetTimePalette
	call RestoreOverworldMapTiles
	call OverworldFadeIn
	ret

_LABEL_8C2FE_:
	ld hl, wTimeOfDayPalFlags
	res CLEAR_PALSET_F, [hl]
	call OverworldFadeOut
	call UpdateTime
	call GetTimePalette
	call RestoreOverworldMapTiles
	call OverworldFadeIn
	ret

_LABEL_8C313_:
	ld hl, wTimeOfDayPalFlags
	set CLEAR_PALSET_F, [hl]
	call OverworldFadeOut
	call GetTimePalette
	call RestoreOverworldMapTiles
	call OverworldFadeIn
	ret

Function8c325:
	call OverworldFadeOut
	call UpdateTime
	call GetTimePalette
	call RestoreOverworldMapTiles
	call OverworldFadeIn
	ret

_UpdateTimePals:
	ld c, $09
	call GetFadeStep
	call ApplyPalettesAtHL
	ret

OverworldFadeIn::
	ld c, 0
	call GetFadeStep
	ld b, 4
	call FadeTowardsWhite
	ret

OverworldFadeOut::
	ld c, 9
	call GetFadeStep
	ld b, 4
	call FadeTowardsBlack
	ret

ReplaceTimeOfDayPals::
	ld hl, TimeOfDayPalsets
	ld a, [wMapPermissions]	; wMapPermissions = $D661
	cp TOWN
	jr z, .get_palset

	cp ROUTE
	jr z, .get_palset

	inc hl
	cp CAVE
	jr z, .get_palset

	; INDOOR, ENVIRONMENT_5, GATE, DUNGEON
	inc hl
.get_palset
	ld a, [hl]
	ld [wTimeOfDayPalset], a
	ret

TimeOfDayPalsets:
db %11100100, %11100100, %01100000

GetTimePalette::
	ld hl, wTimeOfDayPalFlags
	bit CLEAR_PALSET_F, [hl]
	jr nz, .ClearPalset

	ld a, [wTimeOfDay]
	ld [wCurTimeOfDay], a
	ld e, a
	ld d, $00
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable:
dw .Day, .Night, .Darkness, .Morning

.Day:
	xor a
	ldh [hOverworldFlashlightEffect], a
	ld a, [wTimeOfDayPalset]
	and %00000011
	ld [wTimeOfDayPal], a
	ret

.Night:
	xor a
	ldh [hOverworldFlashlightEffect], a
	ld a, [wTimeOfDayPalset]
	and %00001100
	srl a
	srl a
	ld [wTimeOfDayPal], a
	ret

.Darkness:
	ld a, $03
	ldh [hOverworldFlashlightEffect], a
	ld a, [wTimeOfDayPalset]
	and %00110000
	swap a
	ld [wTimeOfDayPal], a
	ret

.Morning:
	xor a
	ldh [hOverworldFlashlightEffect], a
	ld a, [wTimeOfDayPalset]
	and %11000000
	rlca
	rlca
	ld [wTimeOfDayPal], a
	ret

.ClearPalset:
	xor a
	ldh [hOverworldFlashlightEffect], a
	ld [wTimeOfDayPal], a
	ret

ApplyPalettesAtHL::
	push hl
	ld a, [hli]
	ldh [rBGP], a
	ld a, [hli]
	ldh [rOBP0], a
	ld a, [hli]
	ldh [rOBP1], a
	pop hl
	ret

FadeTowardsWhite::
	call ApplyPalettesAtHL
	inc hl
	inc hl
	inc hl
	ld c, 8
	call DelayFrames
	dec b
	jr nz, FadeTowardsWhite
	ret

FadeTowardsBlack::
	call ApplyPalettesAtHL
	dec hl
	dec hl
	dec hl
	ld c, 8
	call DelayFrames
	dec b
	jr nz, FadeTowardsBlack
	ret

GetFadeStep::
	ld a, [wTimeOfDayPal]
	and 3
	push bc
	ld c, a
	ld b, 0
	ld hl, .sequences
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop bc
	ld b, 0
	add hl, bc
	ret

.sequences
	dw .sequence0
	dw .sequence1
	dw .sequence2
	dw .sequence3

.sequence0
	db $ff, $ff, $ff
	db $fe, $fe, $fe
	db $f9, $e4, $e4
	db $e4, $d0, $d0
	db $90, $80, $80
	db $40, $40, $40
	db $00, $00, $00

.sequence1
	db $ff, $ff, $ff
	db $fe, $fe, $fe
	db $f9, $e4, $e4
	db $e9, $d0, $d0
	db $90, $80, $80
	db $40, $40, $40
	db $00, $00, $00

.sequence2
	db $ff, $ff, $ff
	db $fe, $fe, $ff
	db $f9, $e4, $ff
	db $f9, $d0, $ff
	db $90, $80, $90
	db $40, $40, $40
	db $00, $00, $00

.sequence3
	db $ff, $ff, $ff
	db $fe, $fe, $fe
	db $f9, $e4, $e4
	db $e8, $d0, $d0
	db $90, $80, $80
	db $40, $40, $40
	db $00, $00, $00
