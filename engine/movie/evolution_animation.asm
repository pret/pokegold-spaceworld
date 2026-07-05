EvolutionAnimation::
	push hl
	push de
	push bc
	ld a, [wCurSpecies]
	push af

	ld de, MUSIC_NONE
	call PlayMusic

	xor a
	ld [wLowHealthAlarm], a

	ld a, 1
	ldh [hBGMapMode], a

	call WaitBGMap
	xor a
	ldh [hBGMapMode], a
	ldh [hMapAnims], a

	ld a, [wEvolutionOldSpecies]
	ld [wPlayerHPPal], a

	ld c, FALSE
	call .GetSGBLayout

	ld a, [wEvolutionNewSpecies]
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call .PlaceFrontpic

	ld de, vChars2
	ld hl, vChars2 tile $31
	ld bc, 7 * 7
	call Request2bpp

	ld a, [wEvolutionOldSpecies]
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call .PlaceFrontpic

	ld a, 1
	ldh [hBGMapMode], a

	ld a, [wEvolutionOldSpecies]
	call PlayCry

	ld de, MUSIC_EVOLUTION
	call PlayMusic

	ld c, 80
	call DelayFrames

	ld c, TRUE
	call .GetSGBLayout

	lb bc, 1, 16 ; flash b times, wait c frames in between
.loop
	push bc
	call .WaitFrames_CheckPressedB
	jr c, .cancel_evo
	call .Flash
	pop bc
	inc b
	dec c
	dec c
	jr nz, .loop

	xor a
	ld [wEvolutionCanceled], a

	ld a, 7 * 7
	ld [wEvolutionPicOffset], a
	call .ReplaceFrontpic

	ld a, [wEvolutionNewSpecies]
.return
	ld [wPlayerHPPal], a

	ld a, [wPlayerHPPal]
	call PlayCry

	ld c, FALSE
	call .GetSGBLayout

	call .PlayEvolvedSFX

	pop af
	ld [wCurSpecies], a
	pop bc
	pop de
	pop hl

	ld a, [wEvolutionCanceled]
	and a
	ret z

	scf
	ret

.cancel_evo
	pop bc
	ld a, TRUE
	ld [wEvolutionCanceled], a

	ld a, [wEvolutionOldSpecies]
	jr .return

.GetSGBLayout:
	ld b, SGB_EVOLUTION
	jp GetSGBLayout

.PlaceFrontpic:
	call GetBaseData
	hlcoord 7, 2
	jp PrepMonFrontpic

.Flash:
	ld a, 7 * 7 ; previous stage
	ld [wEvolutionPicOffset], a
	call .ReplaceFrontpic
	ld a, -7 * 7 ; new stage
	ld [wEvolutionPicOffset], a
	call .ReplaceFrontpic
	dec b
	jr nz, .Flash
	ret

.ReplaceFrontpic:
	push bc
	xor a
	ldh [hBGMapMode], a
	hlcoord 7, 2
	lb bc, 7, 7
	ld de, SCREEN_WIDTH - 7
.loop1
	push bc
.loop2
	ld a, [wEvolutionPicOffset]
	add [hl]
	ld [hli], a
	dec c
	jr nz, .loop2
	pop bc
	add hl, de
	dec b
	jr nz, .loop1
	ld a, $1
	ldh [hBGMapMode], a
	call WaitBGMap
	pop bc
	ret

.WaitFrames_CheckPressedB:
	call DelayFrame
	push bc
	call GetJoypadDebounced
	ldh a, [hJoySum]
	pop bc
	and B_BUTTON
	jr nz, .pressed_b
.loop3
	dec c
	jr nz, .WaitFrames_CheckPressedB
	and a
	ret

.pressed_b
	ld a, [wForceEvolution]
	and a
	jr nz, .loop3
	scf
	ret

.PlayEvolvedSFX:
	ret

	ld a, [wEvolutionCanceled]
	and a
	ret nz
	ldh a, [rOBP0]
	push af
	ld a, %11100100
	ldh [rOBP0], a
	callfar ClearSpriteAnims
	ld de, .GFX
	ld hl, vChars0
	lb bc, BANK(.GFX), 2
	call Request2bpp
	xor a
	ld [wJumptableIndex], a
.loop4
	call .balls_of_light
	jr nc, .done
	call .AnimateBallsOfLight
	jr .loop4

.done
	ld c, 16 ; half as much as final
.loop5
	call .AnimateBallsOfLight
	dec c
	jr nz, .loop5
	pop af
	ldh [rOBP0], a
	ret

.balls_of_light
	ld hl, wJumptableIndex
	ld a, [hl]
	cp 64
	ret nc
	inc [hl]
	depixel 9, 11
	ld a, SPRITE_ANIM_OBJ_EVOLUTION_BALL_OF_LIGHT
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], 0
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld a, [wJumptableIndex]
	and %1110
	sla a
	sla a
	ld [hl], a
	scf
	ret

.AnimateBallsOfLight:
	push bc
	callfar PlaySpriteAnimations
	pop bc
	call DelayFrame
	ret

.GFX:
	INCBIN "gfx/evo/bubbles.2bpp"
