INCLUDE "constants.asm"

SECTION "engine/movie/opening_cutscene.asm", ROMX

OpeningCutscene::
	call .Init
.loop
	call .PlayFrame
	jr nc, .loop
	ret

.Init:
	farcall ClearSpriteAnims
	xor a
	ld [wIntroJumptableIndex], a
	ldh [hBGMapMode], a
	ret

.PlayFrame:
	ld hl, hJoypadDown
	ld a, [hl]
	and $f
	jr nz, .Finish

; check done flag
	ld a, [wIntroJumptableIndex]
	bit 7, a
	jr nz, .Finish

	farcall PlaySpriteAnimations
	call IntroSceneJumper
	call DelayFrame
	and a
	ret

.Finish:
	callfar ClearSpriteAnims
	call ClearSprites
	call DelayFrame
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ldh [hLCDCPointer], a
	ldh [hLYOverrideStart], a
	ldh [hLYOverrideEnd], a
	ld a, %11100100
	ldh [rBGP], a
	ldh [rOBP0], a
	scf
	ret

IntroSceneJumper:
	jumptable .scenes, wIntroJumptableIndex
.scenes
	dw IntroScene1
	dw IntroScene2
	dw IntroScene3
	dw IntroScene4
	dw IntroScene5
	dw IntroScene6
	dw IntroScene7
	dw IntroScene8
	dw IntroScene9
	dw IntroScene10
	dw IntroScene11
	dw IntroScene12
	dw IntroScene13
	dw IntroScene14
	dw IntroScene15
	dw IntroScene16
	dw IntroScene17

IntroScene1:
; Set up water cutscene
	ld hl, wIntroJumptableIndex
	inc [hl]
	call DisableLCD

	ld b, SGB_GS_INTRO
	ld c, 0
	call GetSGBLayout

	callfar ClearSpriteAnims

	call Intro_ResetLYOverrides

	ld hl, vChars2
	ld de, IntroUnderwaterGFX
	call Intro_Copy128Tiles

; Load water metatiles
	ld a, LOW(Intro_WaterMeta)
	ld [wIntroTilesPointer + 0], a
	ld a, HIGH(Intro_WaterMeta)
	ld [wIntroTilesPointer + 1], a

; Set destination BG map pointer
	ld hl, vBGMap0
	ld a, l
	ld [wIntroBGMapPointer + 0], a
	ld a, h
	ld [wIntroBGMapPointer + 1], a

; Load water tilemap (shifted to starting position)
	ld de, Intro_WaterTilemap + $F0
	ld a, e
	ld [wIntroTilemapPointer + 0], a
	ld a, d
	ld [wIntroTilemapPointer + 1], a
	call Intro_DrawBackground

; draw GFX
	ld hl, IntroWaterPokemonGFX
	ld de, vChars0
	ld bc, $80 tiles
.draw_gfx
	ld a, [hli]
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .draw_gfx

	ld hl, wSpriteAnimDict
	ld a, SPRITE_ANIM_OBJ_GS_INTRO_BUBBLE
	ld [hli], a
	ld a, SPRITE_ANIM_DICT_NULL
	ld [hli], a

	xor a
	ldh [hSCY], a
	ld [wGlobalAnimYOffset], a
	ld [wGlobalAnimXOffset], a

	ld a, $58
	ldh [hSCX], a

; setup counter for the first scene
	xor a
	ld [wIntroFrameCounter2], a
	ld a, $80
	ld [wIntroFrameCounter1], a

	ld a, LOW(rSCY)
	ldh [hLCDCPointer], a
	call Intro_InitSineLYOverrides

	xor a	; FALSE
	ld [wIntroSpriteStateFlag], a

	call EnableLCD
	call DelayFrame

	ld a, %11100100
	ldh [rBGP], a
	ld a, %11100000
	ldh [rOBP0], a
	call Intro_InitOmanyte
	ret

IntroScene2:
	call Intro_UpdateLYOverrides
	ld hl, wIntroFrameCounter1
	ld a, [hl]
	and a
	jr z, .skip_intro
	dec [hl]
	call Intro_InitBubble
	ret

.skip_intro
	ld [hl], $10
	ld hl, wIntroJumptableIndex
	inc [hl]

IntroScene3:
; rise towards the surface
	call IntroScene3_Jumper
	call IntroScene3_ScrollToSurface
	ret nc
; next scene if carry flag is set
	call Intro_ResetLYOverrides
	ld hl, hSCY
	inc [hl]
	ld hl, wIntroJumptableIndex
	inc [hl]

IntroScene4:
; at surface; Lapras surfs to left of screen
	ld a, [wIntroSpriteStateFlag]
	and a
	jr nz, .next
	ld hl, wIntroFrameCounter2
	inc [hl]
	ld a, [hl]
	and $7
	jr nz, .skip_move_left
	ld hl, hSCX
	dec [hl]

.skip_move_left
	call Intro_AnimateOceanWaves
	ret

.next
	ld hl, wIntroJumptableIndex
	inc [hl]
	xor a
	ld [wIntroFrameCounter1], a

IntroScene5:
; scroll right and fade out to white
	ld hl, wIntroFrameCounter1
	ld a, [hl]
	inc [hl]
	swap a
	and $f
	ld e, a
	ld d, 0
	ld hl, .palettes
	add hl, de
	ld a, [hl]
	cp -1
	jr z, .next
	ldh [rBGP], a
	call Intro_AnimateOceanWaves
	ld hl, hSCX
	dec [hl]
	dec [hl]
	ret
.next
	ld hl, wIntroJumptableIndex
	inc [hl]
	ret

.palettes:
	dc 3, 2, 1, 0
	dc 3, 2, 1, 0
	dc 2, 1, 0, 0
	dc 1, 0, 0, 0
	dc 0, 0, 0, 0
	db -1

IntroScene17:
; delay a bit before leading into the title screen
	ld c, 64
.loop
	call DelayFrame
	dec c
	jr nz, .loop
; set done flag
	ld hl, wIntroJumptableIndex
	set 7, [hl]
	ret

IntroScene3_ScrollToSurface:
	ld hl, wIntroFrameCounter2
	inc [hl]
	ld a, [hl]
	and %00000011
	jr nz, .skip_move_left
	ld hl, hSCX
	dec [hl]

.skip_move_left
	and 1
	jr nz, .no_carry
	ld hl, wGlobalAnimYOffset
	inc [hl]
	ld hl, hSCY
	ld a, [hl]
	dec [hl]
	and $f
	call z, Intro_UpdateTilemapAndBGMap
	ld a, [wIntroFrameCounter1]
	and a
	jr z, .carry

.no_carry
	and a
	ret

.carry
	scf
	ret

IntroScene3_Jumper:
	jumptable .subroutines, wIntroFrameCounter1

.subroutines:
	dw .scene3_2
	dw .scene3_2
	dw .scene3_2
	dw .scene3_1
	dw .scene3_2
	dw .scene3_2
	dw .scene3_3
	dw .scene3_3
	dw .scene3_3
	dw .scene3_4
	dw .scene3_5
	dw .scene3_6
	dw .scene3_6
	dw .scene3_6
	dw .scene3_6
	dw .scene3_6
	dw .scene3_6

.scene3_1:
	call Intro_InitLapras
	ld a, %11100100
	ldh [rOBP0], a
; fallthrough

.scene3_2:
	call Intro_AnimateOceanWaves
	ret

.scene3_3:
	call Intro_InitMagikarps
	call Intro_AnimateOceanWaves
	ret

.scene3_4:
	ld hl, wIntroFrameCounter2
	ld a, [hl]
	and %00011111
	jr z, .load_palettes
	call Intro_InitMagikarps
	ret
.load_palettes
	callfar LoadMagikarpPalettes_Intro
	ret

.scene3_5:
	xor a
	ldh [hLCDCPointer], a
	ret

.scene3_6:
	call Intro_UpdateLYOverrides
	ret

Intro_InitBubble:
	ld hl, wIntroFrameCounter1
	ld a, [hl]
	and $f
	ret nz

	ld a, [hl]
	and $70
	swap a
	ld e, a
	ld d, 0
	ld hl, .pixel_table
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, SPRITE_ANIM_OBJ_GS_INTRO_BUBBLE
	call InitSpriteAnimStruct
	ret

.pixel_table:
	dbpixel  6, 14,  0,  4
	dbpixel 14, 18,  0,  4
	dbpixel 10, 16,  0,  4
	dbpixel 12, 15,  0,  0
	dbpixel  4, 13,  0,  0
	dbpixel  8, 17,  0,  0

Intro_InitMagikarps:
	depixel 8, 7, 0, 7
	ld a, [wSGB]
	and a
	jr z, .ok
	depixel 4, 3, 0, 7

.ok
	ld hl, wIntroFrameCounter2
	ld a, [hl]
	and e
	ret nz
	ld a, [hl]
	and d
	jr nz, .alternate_frame

	depixel 29, 28
	call .PlaceMagikarp

	depixel 26, 0
	call .PlaceMagikarp

	depixel 0, 24
	call .PlaceMagikarp
	ret

.alternate_frame
	depixel 28, 30
	call .PlaceMagikarp

	depixel 31, 24
	call .PlaceMagikarp

	depixel 2, 28
	call .PlaceMagikarp
	ret

.PlaceMagikarp:
	ld a, SPRITE_ANIM_OBJ_GS_INTRO_MAGIKARP
	call InitSpriteAnimStruct
	ret

Intro_InitOmanyte:
	depixel 18, 7
	call .PlaceOmanyte
	depixel 14, 10
	call .PlaceOmanyte
	depixel 16, 15
; fallthrough

.PlaceOmanyte:
	ld a, SPRITE_ANIM_OBJ_GS_INTRO_OMANYTE
	call InitSpriteAnimStruct
	ret

Intro_InitLapras:
	ld a, [wIntroFrameCounter2]
	and %00011111
	ret nz
	depixel 16, 24
	ld a, SPRITE_ANIM_OBJ_GS_INTRO_LAPRAS
	call InitSpriteAnimStruct
	ret

Intro_UnusedInitAerodactyl:	; unreferenced
	depixel 2, 0
	ld a, SPRITE_ANIM_OBJ_UNUSED_INTRO_AERODACTYL
	call InitSpriteAnimStruct
	ret

Intro_UpdateTilemapAndBGMap:
; add new tiles to top as water scene scrolls up to surface
	push hl
	push de

	ld a, [wIntroTilemapPointer + 0]
	ld e, a
	ld a, [wIntroTilemapPointer + 1]
	ld d, a
	ld hl, -BG_MAP_WIDTH / 2
	add hl, de
	ld a, l
	ld e, l
	ld [wIntroTilemapPointer + 0], a
	ld a, h
	ld d, h
	ld [wIntroTilemapPointer + 1], a

	hlcoord 0, 0
	ld c, BG_MAP_WIDTH / 2
.loop
	call Intro_Draw2x2Tiles
	dec c
	jr nz, .loop

	ld a, [wIntroBGMapPointer + 0]
	ld e, a
	ld a, [wIntroBGMapPointer + 1]
	ld d, a
	ld hl, -2 * BG_MAP_WIDTH
	add hl, de
	ld a, l
	ld [wIntroBGMapPointer + 0], a
	ld [wVBCopyDst], a
	ld a, h
	and %11111011
	or %00001000
	ld [wIntroBGMapPointer + 1], a
	ld [wVBCopyDst + 1], a
	ld a, LOW(wTileMap)
	ld [wVBCopySrc], a
	ld a, HIGH(wTileMap)
	ld [wVBCopySrc + 1], a
	ld a, 4
	ld [wVBCopySize], a
	ld hl, wIntroFrameCounter1
	dec [hl]
	pop de
	pop hl
	ret

Intro_AnimateOceanWaves:
; uses a 2bpp request to copy tile IDs to the BG map
	ld hl, wIntroFrameCounter2
	ld a, [hl]
	and 3
	cp 3
	ret z

	ld a, [hl]
	and $30
	swap a
	ld l, a
	ld h, 0
rept 5
	add hl, hl
endr
	ld de, .wave_tiles
	add hl, de
	ld a, l
	ld [wVBCopySrc], a
	ld a, h
	ld [wVBCopySrc + 1], a
	ld a, LOW(vBGMap0 + 15 * BG_MAP_WIDTH)
	ld [wVBCopyDst], a
	ld a, HIGH(vBGMap0 + 15 * BG_MAP_WIDTH)
	ld [wVBCopyDst + 1], a
	ld a, 2
	ld [wVBCopySize], a
	ret

.wave_tiles:
; Fill an entire bg map row with each frame
rept 8
	db $70, $71, $72, $73	; frame 1
endr

rept 8
	db $74, $75, $76, $77	; frame 2
endr

rept 8
	db $78, $79, $7a, $7b	; frame 3
endr

rept 8
	db $7c, $7d, $7e, $7f	; frame 4
endr

Intro_InitSineLYOverrides:
	ld bc, wLYOverrides2
	ld a, SCREEN_HEIGHT_PX
	ld de, BG_MAP_WIDTH * BG_MAP_HEIGHT
.loop
	push af
	push de
	farcall BattleAnim_Sine_e
	ld a, e
	ld [bc], a
	inc bc
	pop de
	inc e
	pop af
	dec a
	jr nz, .loop
	ret

Intro_UpdateLYOverrides:
	ld bc, wLYOverrides
	ld e, $10

.loop1
	ldh a, [hSCY]
	ld [bc], a
	inc bc
	dec e
	jr nz, .loop1

	ld hl, wLYOverrides2
	ld de, wLYOverrides2 + 1
	ld a, [hl]
	push af
	ld a, $80

.loop2
	push af
	ld a, [de]
	inc de
	ld [hli], a
	push hl
	ld hl, hSCY
	add [hl]
	ld [bc], a
	inc bc
	pop hl
	pop af
	dec a
	jr nz, .loop2

	pop af
	ld [hl], a
	ret

IntroScene6:
; Set up grass cutscene (Pikachu / Jigglypuff)
	ld hl, wIntroJumptableIndex
	inc [hl]
	call DisableLCD
	ld b, SGB_GS_INTRO
	ld c, 1
	call GetSGBLayout
	callfar ClearSpriteAnims
	call Intro_ResetLYOverrides
	ld hl, vChars2
	ld de, IntroForestGFX
	call Intro_Copy128Tiles
	ld a, LOW(Intro_GrassMeta)
	ld [wIntroTilesPointer + 0], a
	ld a, HIGH(Intro_GrassMeta)
	ld [wIntroTilesPointer + 1], a
	ld hl, vBGMap0
	ld a, l
	ld [wIntroBGMapPointer + 0], a
	ld a, h
	ld [wIntroBGMapPointer + 1], a
	ld de, Intro_GrassTilemap
	ld a, e
	ld [wIntroTilemapPointer + 0], a
	ld a, d
	ld [wIntroTilemapPointer + 1], a
	call Intro_DrawBackground
	ld hl, IntroJigglypuffPikachuGFX
	ld de, vChars0
	ld bc, 160 tiles ; last 16 tiles actually belong to charizard's gfx

.load
	ld a, [hli]
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .load

	ld hl, wSpriteAnimDict
	ld a, SPRITE_ANIM_OBJ_GS_INTRO_OMANYTE
	ld [hli], a
	ld a, SPRITE_ANIM_DICT_NULL
	ld [hli], a
	xor a
	ldh [hSCY], a
	ld [wGlobalAnimYOffset], a
	ld a, $60
	ldh [hSCX], a
	ld a, $a0
	ld [wGlobalAnimXOffset], a
	xor a
	ld [wIntroFrameCounter2], a
	call EnableLCD
	ld a, %11100100
	ldh [rBGP], a
	ldh [rOBP0], a
	call Intro_InitJigglypuff
	xor a
	ld [wIntroSpriteStateFlag], a
	ret

IntroScene7:
	call Intro_InitNote
	ld hl, wIntroFrameCounter2
	ld a, [hl]
	inc [hl]
	and $3
	ret z

	ld hl, hSCX
	ld a, [hl]
	and a
	jr z, .next

	dec [hl]
	ld hl, wGlobalAnimXOffset
	inc [hl]
	ret

.next
	ld a, $ff
	ld [wIntroFrameCounter1], a
	call Intro_InitPikachu
	ld hl, wIntroJumptableIndex
	inc [hl]
	ret

IntroScene8:
	ld hl, wIntroFrameCounter1
	ld a, [hl]
	and a
	jr z, .next
	dec [hl]
	call Intro_InitNote
	ld hl, wIntroFrameCounter2
	inc [hl]
	ret

.next
	xor a
	ld [wIntroFrameCounter1], a
	ld hl, wIntroJumptableIndex
	inc [hl]
	callfar LoadForestPalettes2_Intro
	ret

IntroScene9:
	ld hl, wIntroFrameCounter1
	ld a, [hl]
	inc [hl]
	swap a
	and $f
	ld e, a
	ld d, 0
	ld hl, .palettes
	add hl, de
	ld a, [hl]
	and a
	jr z, .next

	ldh [rBGP], a
	ld hl, hSCY
	inc [hl]
	ld hl, wGlobalAnimYOffset
	dec [hl]
	ret

.next:
	ld hl, wIntroJumptableIndex
	inc [hl]
	ret

.palettes:
; fade out to black
	dc 3, 2, 1, 0
	dc 3, 2, 1, 0
	dc 3, 2, 1, 0
	dc 3, 2, 1, 0
	dc 3, 2, 1, 0
	dc 3, 3, 2, 1
	dc 3, 3, 3, 2
	dc 3, 3, 3, 3
	db 0

Intro_DummyFunction:
	ret

Intro_InitNote:
	ld a, [wIntroSpriteStateFlag]
	and a
	ret nz

	ld hl, wIntroFrameCounter2
	ld a, [hl]
	and $3f
	ret nz

	ld a, [hl]
	and $7f
	jr z, .SmallerNote

	depixel 11, 6, 4, 0
	ld a, SPRITE_ANIM_OBJ_GS_INTRO_NOTE
	call InitSpriteAnimStruct
	ret

.SmallerNote:
	depixel 10, 6, 4, 0
	ld a, SPRITE_ANIM_OBJ_GS_INTRO_SMALLER_NOTE
	call InitSpriteAnimStruct
	ret

Intro_InitJigglypuff:
	depixel 14, 6
	ld a, SPRITE_ANIM_OBJ_GS_INTRO_JIGGLYPUFF
	call InitSpriteAnimStruct
	ret

Intro_InitPikachu:
	depixel 14, 24
	ld a, SPRITE_ANIM_OBJ_GS_INTRO_PIKACHU
	call InitSpriteAnimStruct
	depixel 14, 24
	ld a, SPRITE_ANIM_OBJ_GS_INTRO_PIKACHU_TAIL
	call InitSpriteAnimStruct
	ret

IntroScene10:
; Set up fireball cutscene (evolved Kanto starters)
	ld hl, wIntroJumptableIndex
	inc [hl]
	ld b, SGB_GS_INTRO
	ld c, 2
	call GetSGBLayout
	callfar ClearSpriteAnims
	call Intro_ResetLYOverrides
	call Intro_BlankTilemapAndBGMap

	ld hl, vChars2
	ld de, IntroCharizard1GFX
	lb bc, BANK(IntroCharizard1GFX), 8 tiles
	call Request2bpp

	ld hl, vFont
	ld de, IntroCharizard2GFX tile $40
	lb bc, BANK(IntroCharizard2GFX), 8 tiles
	call Request2bpp

	ld hl, vChars0
	ld de, IntroCharizardFlamesGFX
	lb bc, BANK(IntroCharizardFlamesGFX), 8 tiles
	call Request2bpp

	ld hl, wSpriteAnimDict
	ld a, SPRITE_ANIM_OBJ_GS_INTRO_OMANYTE
	ld [hli], a
	ld a, SPRITE_ANIM_DICT_NULL
	ld [hli], a

	ld a, 0
	call DrawIntroCharizardGraphic

	ld a, $80
	ldh [hSCY], a

	xor a
	ldh [hSCX], a
	ld [wGlobalAnimYOffset], a
	ld [wGlobalAnimXOffset], a

	xor a
	ld [wIntroFrameCounter2], a
	ld a, %00111111
	ldh [rBGP], a
	ld a, %11111111
	ldh [rOBP0], a
	ret

IntroScene11:
; scroll up to Charizard silhoutte, flash Blastoise and Venusaur
	ld hl, wIntroFrameCounter2
	ld a, [hl]
	inc [hl]
	and 1
	ret z
	call Intro_CheckSCYEvent
	ld hl, hSCY
	ld a, [hl]
	and a
	jr z, .next
	inc [hl]
	ret

.next
	ld hl, wIntroJumptableIndex
	inc [hl]
	xor a
	ld [wIntroFrameCounter1], a

IntroScene12:
; load Charizard palettes
	ld hl, wIntroFrameCounter1
	ld a, [hl]
	inc [hl]
	srl a
	srl a
	and 3
	ld e, a
	ld d, 0
	ld hl, .palettes
	add hl, de
	ld a, [hl]
	and a
	jr z, .next
	ldh [rBGP], a
	ldh [rOBP0], a
	ret

.next
	ld hl, wIntroJumptableIndex
	inc [hl]
	ld a, $80
	ld [wIntroFrameCounter1], a
	ret

.palettes:
	dc 1, 2, 2, 2
	dc 2, 2, 1, 1
	dc 3, 2, 1, 0
	dc 0, 0, 0, 0

IntroScene13:
; Charizard mouth open
	ld hl, wIntroFrameCounter1
	ld a, [hl]
	and a
	jr z, .next

	dec [hl]
	ret

.next
	ld hl, wIntroJumptableIndex
	inc [hl]
	ld a, 1
	call DrawIntroCharizardGraphic
	ld a, 4
	ld [wIntroFrameCounter1], a
	ret

IntroScene14:
; Charizard breathing fire
	ld hl, wIntroFrameCounter1
	ld a, [hl]
	and a
	jr z, .next
	dec [hl]
	ret

.next
	ld hl, wIntroJumptableIndex
	inc [hl]
	ld a, 2
	call DrawIntroCharizardGraphic
	ld a, 64
	ld [wIntroFrameCounter1], a
	xor a
	ld [wIntroFrameCounter2], a
; fallthrough

IntroScene15:
; Charizard mouth wide open / fireball starts
	call Intro_AnimateFireball
	ld hl, wIntroFrameCounter1
	ld a, [hl]
	and a
	jr z, .next
	dec [hl]
	ret
.next
	ld hl, wIntroJumptableIndex
	inc [hl]
	xor a
	ld [wIntroFrameCounter1], a
	ret

IntroScene16:
; continue fireball / fade out palettes
	call Intro_AnimateFireball
	ld hl, wIntroFrameCounter1
	ld a, [hl]
	inc [hl]
	swap a
	and $7
	ld e, a
	ld d, 0
	ld hl, .palettes
	add hl, de
	ld a, [hl]
	cp -1
	jr z, .next
	ldh [rBGP], a
	ldh [rOBP0], a
	ret
.next
	ld hl, wIntroJumptableIndex
	inc [hl]
	ret

.palettes:
	dc 3, 2, 1, 0
	dc 2, 1, 0, 0
	dc 1, 0, 0, 0
	dc 0, 0, 0, 0
	db -1

Intro_BlankTilemapAndBGMap:
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT

.blank_tilemap
	ld [hl], 0
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .blank_tilemap

	ld hl, wc600
	ld bc, BG_MAP_WIDTH * BG_MAP_HEIGHT

.blank_bgmap
	ld [hl], 0
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .blank_bgmap

	ld hl, vBGMap0
	ld de, wc600
	lb bc, BANK(@), $40
	call Request2bpp
	ret

Intro_CheckSCYEvent:
	ldh a, [hSCY]
	ld c, a
	ld hl, .Cuelist

.loop
	ld a, [hli]
	cp -1
	ret z
	cp c
	jr z, .value_found
	inc hl
	inc hl
	jr .loop

.value_found
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Cuelist:
	dbw $87, Intro_BlastoiseAppears
	dbw $88, Intro_FlashMonPalette
	dbw $98, Intro_FlashSilhouette
	dbw $99, Intro_LoadVenusaurPalette
	dbw $bf, Intro_VenusaurAppears
	dbw $c0, Intro_FlashMonPalette
	dbw $d0, Intro_FlashSilhouette
	dbw $d1, Intro_LoadCharizardPalette
	db -1

Intro_BlastoiseAppears:
	call Intro_LoadBlastoiseObject
	ret

Intro_VenusaurAppears:
	call Intro_LoadVenusaurObject
	ret

Intro_FlashMonPalette:
	ld a, %11100100
	ldh [rOBP0], a
	xor a
	ldh [rBGP], a
	ret

Intro_FlashSilhouette:
	ld a, %11111111
	ldh [rOBP0], a
	ld a, %00111111
	ldh [rBGP], a
	ret

Intro_LoadVenusaurPalette:
	callfar LoadVenusaurPalettes_Intro
	ret

Intro_LoadCharizardPalette:
	callfar LoadCharizardPalettes_Intro
	ret

DrawIntroCharizardGraphic:
	push af
	hlcoord 0, 6
	ld c, SCREEN_WIDTH * 8
	xor a
.loop1
	ld [hli], a
	dec c
	jr nz, .loop1

	pop af
	ld e, a
	ld d, 0
	ld hl, .charizard_data
rept 5
	add hl, de
endr
	ld e, [hl]
	inc hl
	ld c, [hl]
	inc hl
	ld b, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, e

.loop2_outer
	push bc
	push hl
.loop2_inner
	ld [hli], a
	inc a
	dec c
	jr nz, .loop2_inner

	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .loop2_outer

	ld a, 1
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	call DelayFrame
	xor a
	ldh [hBGMapMode], a
	ret

.charizard_data:
MACRO intro_graphic_def
	db \1
	db \2, \3
	dwcoord \4, \5
ENDM
	intro_graphic_def $00, 8, 8, 10, 6
	intro_graphic_def $40, 9, 8,  9, 6
	intro_graphic_def $88, 9, 8,  8, 6

Intro_AnimateFireball:
	ld hl, wIntroFrameCounter2
	ld a, [hl]
	inc [hl]
	and 3
	ret nz
	depixel 12, 10, 4, 4
	ld a, SPRITE_ANIM_OBJ_GS_INTRO_FIREBALL
	call InitSpriteAnimStruct
	ld hl, hSCX
	dec [hl]
	ld hl, wGlobalAnimXOffset
	inc [hl]
	ret

Intro_LoadBlastoiseObject:
	depixel 22, 1
	ld a, SPRITE_ANIM_OBJ_GS_INTRO_BLASTOISE
	call InitSpriteAnimStruct
	ret

Intro_LoadVenusaurObject:
	depixel 22, 20
	ld a, SPRITE_ANIM_OBJ_GS_INTRO_VENUSAUR
	call InitSpriteAnimStruct
	ret

Intro_Copy128Tiles:
	ld bc, 128 tiles
.loop
	ld a, [de]
	inc de
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop
	ret

Intro_DrawBackground:
	ld b, BG_MAP_WIDTH / 2
.outer_loop
	push hl
	ld c, BG_MAP_HEIGHT / 2
.inner_loop
	call Intro_Draw2x2Tiles
	dec c
	jr nz, .inner_loop
	pop hl
	push bc
	ld bc, 2 * BG_MAP_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .outer_loop
	ret

Intro_Draw2x2Tiles:
	push bc
	push de
	push hl
	push hl
	push hl
	ld a, [de]
	ld l, a
	ld h, 0
	ld a, [wIntroTilesPointer + 0]
	ld e, a
	ld a, [wIntroTilesPointer + 1]
	ld d, a
	add hl, hl
	add hl, hl
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	pop hl
	ld bc, BG_MAP_WIDTH
	add hl, bc
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	pop hl
	inc hl
	inc hl
	pop de
	inc de
	pop bc
	ret

Intro_ResetLYOverrides:
	ld hl, wLYOverrides
	xor a
	ld c, wLYOverrides2 - wLYOverrides
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ret
