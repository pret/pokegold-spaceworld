GetBaseData::
; copies the base stat data of a pokemon to wMonHeader
; INPUT:
; [wCurSpecies] = pokemon ID in dex order
	push bc
	push de
	push hl
	ldh a, [hROMBank]
	push af
	ld a, BANK(BaseData)
	call Bankswitch

; Egg doesn't have BaseData
	ld a, [wCurSpecies]
	cp DEX_EGG
	jr z, .egg

; Get BaseData
	dec a
	ld bc, BaseData.FirstEntryEnd - BaseData
	ld hl, BaseData
	call AddNTimes
	ld de, wMonHeader
	ld bc, BaseData.FirstEntryEnd - BaseData
	call CopyBytes
	jr .end

.egg
	ld de, EggPicFront

; Sprite dimensions
	ln b, 5, 5 ; egg sprite dimension
	ld hl, wMonHSpriteDim
	ld [hl], b

; front sprite
	ld hl, wMonHFrontSprite
	ld [hl], e
	inc hl
	ld [hl], d
	jr .end ; useless

.end
	ld a, [wCurSpecies]
	ld [wMonHIndex], a

	pop af
	call Bankswitch
	pop hl
	pop de
	pop bc
	ret
