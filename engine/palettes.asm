INCLUDE "constants.asm"

SECTION "engine/palettes.asm@Overworld fade", ROMX

OverworldFadeIn:: ; 23:433e
	ld c, 0
	call GetFadeStep
	ld b, 4
	call FadeTowardsWhite
	ret

OverworldFadeOut:: ; 23:4349
	ld c, 9
	call GetFadeStep
	ld b, 4
	call FadeTowardsBlack
	ret


; TODO: merge this
SECTION "engine/palettes.asm@Palette fading, part 2?", ROMX

ApplyPalettesAtHL:: ; 23:43d1
	push hl
	ld a, [hli]
	ld [rBGP], a
	ld a, [hli]
	ld [rOBP0], a
	ld a, [hli]
	ld [rOBP1], a
	pop hl
	ret

FadeTowardsWhite:: ; 23:43dd
	call ApplyPalettesAtHL
	inc hl
	inc hl
	inc hl
	ld c, 8
	call DelayFrames
	dec b
	jr nz, FadeTowardsWhite
	ret

FadeTowardsBlack:: ; 23:43ec
	call ApplyPalettesAtHL
	dec hl
	dec hl
	dec hl
	ld c, 8
	call DelayFrames
	dec b
	jr nz, FadeTowardsBlack
	ret

GetFadeStep:: ; 23:43fb
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
