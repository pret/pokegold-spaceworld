INCLUDE "constants.asm"

SECTION "engine/games/pikachu_minigame.asm@Pikachu Minigame", ROMX

PikachuMiniGame::
	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	call .Init
	call DelayFrame
.loop
	call PikachuMiniGame_RunFrame
	jr nc, .loop

; exit
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	ld de, MUSIC_NONE
	call PlayMusic
	ret

.Init:
	call DisableLCD
	ld b, SGB_BETA_PIKACHU_MINIGAME
	call GetSGBLayout

	callab InitEffectObject

	call PikachuMiniGame_ClearBothTilemaps

	ld hl, IntroForestGFX
	ld de, vChars2
	ld bc, $80 tiles
	ld a, BANK(IntroForestGFX)
	call FarCopyData

	ld hl, IntroJigglypuffPikachuGFX
	ld de, vChars0
	ld bc, $90 tiles
	ld a, BANK(IntroJigglypuffPikachuGFX)
	call FarCopyData

; Metatiles
	ld a, LOW(PikachuMiniGame_Meta)
	ld [wPikachuMinigameTilesPointer], a
	ld a, HIGH(PikachuMiniGame_Meta)
	ld [wPikachuMinigameTilesPointer + 1], a

; BG map destination
	ld hl, vBGMap0
	ld a, l
	ld [wPikachuMinigameBGMapPointer], a
	ld a, h
	ld [wPikachuMinigameBGMapPointer + 1], a

; Block map
	ld de, PikachuMiniGame_Blockmap
	ld a, e
	ld [wPikachuMinigameTilemapPointer], a
	ld a, d
	ld [wPikachuMinigameTilemapPointer + 1], a
	call PikachuMiniGame_DrawBackground

	ld hl, wSpriteAnimDict
	ld a, $22	; anim dict values?
	ld [hli], a
	ld a, SPRITE_ANIM_DICT_DEFAULT
	ld [hli], a
	call PikachuMiniGame_LoadFont

	xor a
	ldh [hSCY], a
	ld [wGlobalAnimYOffset], a
	ldh [hSCX], a
	ld [wGlobalAnimXOffset], a
	ld [wPikachuMinigameJumptableIndex], a
	ld [wPikachuMinigameScrollSpeed], a
	ld [wPikachuMinigameScore], a
	ld [wPikachuMinigameScore + 1], a
	ld [wPikachuMinigameNoteCounter], a
	ld [wPikachuMinigameNoteCounter + 1], a
	ld [wPikachuMinigameTimeFrames], a
	ld [wPikachuMinigameTimeSeconds], a
	ld [wc613], a
	ld [wc614], a
	ld [wPikachuMinigameNoteTimer], a
	ld [wPikachuMinigameSpawnTypeIndex], a
	ld [wPikachuMinigameSpawnDataIndex], a
	ld [wPikachuMinigameRedrawTimer], a
	ld [wc618], a
	ld [wc619], a
	ld [wc61a], a
	ld [wPikachuMinigameSavedColumnPointer], a
	ld [wPikachuMinigameSavedColumnPointer + 1], a

	ld a, LOW(PikachuMiniGame_Columns)
	ld [wPikachuMinigameColumnPointer], a
	ld a, HIGH(PikachuMiniGame_Columns)
	ld [wPikachuMinigameColumnPointer + 1], a

	ld a, $7c
	ldh [hWY], a

	ld a, $e3
	ldh [rLCDC], a

	ld a, [wSGB]
	and a
	jr nz, .not_sgb

	ld a, %10010100
	ldh [rBGP], a
	ld a, %11100100
	ldh [rOBP0], a
	jr .load_pikachu

.not_sgb

; Normal palette if on GB / GBC
	ld a, %11100100
	ldh [rBGP], a
	ldh [rOBP0], a

.load_pikachu
	depixel 14, 11
	ld a, SPRITE_ANIM_INDEX_MINIGAME_PIKACHU
	call InitSpriteAnimStruct

	ld a, c
	ld [wPikachuMinigamePikachuObjectPointer], a
	ld a, b
	ld [wPikachuMinigamePikachuObjectPointer + 1], a

; load Pikachu's tail object
	depixel 14, 11
	ld a, SPRITE_ANIM_INDEX_MINIGAME_PIKACHU_TAIL
	call InitSpriteAnimStruct

	ld a, c
	ld [wPikachuMinigamePikachuTailObjectPointer], a
	ld a, b
	ld [wPikachuMinigamePikachuTailObjectPointer + 1], a
	ret

PikachuMiniGame_ClearBothTilemaps:
	ld hl, vBGMap1
	ld bc, $0280
.clear_bgmap
	ld [hl], 0
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .clear_bgmap

	ld hl, wTileMap
	ld bc, $0168
.clear_tilemap
	ld [hl], 0
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .clear_tilemap

	ld a, 7
	ldh [hWX], a
	ret

PikachuMiniGame_LoadFont:
	ld hl, FontGFX
	ld de, vFont tile $10
	ld bc, (112 / 2) tiles
	ld a, BANK(FontGFX)
	call FarCopyDataDouble

	ld hl, FontGFX tile $39
	ld de, vChars2 tile $32
	ld bc, ( (14 / 2) + 1) tiles
	ld a, BANK(FontGFX)
	call FarCopyDataDouble
	ret

PikachuMiniGame_BlinkText:
; Blink the window text according to the current X scroll position.
; 00 - 7f = hide text
; 80 - ff = show text

	ldh a, [hSCX]
	ld d, a
	and $7f
	ret nz
	bit 7, d
	jr nz, .DisplayText

; clear dakutens
	xor a
	hlcoord 5, 0
	ld [hl], a
	hlcoord 13, 0
	ld [hl], a

; clear text
	hlcoord 1, 1
	ld c, 15
.text_clear
	ld [hli], a
	dec c
	jr nz, .text_clear
	ret

.DisplayText:
	decoord 1, 1
	ld hl, .text
.render_text
	ld a, [hli]
	and a
	jr z, .render_dakutens

; Tiles are shifted so add $10 to each character
	add $10
	ld [de], a
	inc de
	jr .render_text

.render_dakutens
; Render dakuten marks separately
	ld a, "ﾞ" + $10

	hlcoord 5, 0
	ld [hl], a

	hlcoord 13, 0
	ld [hl], a

	ret

.text
	db "スタートホタン▶タイトルかめん"
	;  "スタートボタン▶タイトルがめん"
	db 0	; terminator

Func418b:	; unreferenced?
	ld bc, $0800
.loop
	ld a, [de]
	inc de
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop
	ret

PikachuMiniGame_DrawBackground:
	ld b, $10
.outer_loop
	push hl
	ld c, $10
.inner_loop
	call PikachuMiniGame_Draw2x2Tile
	dec c
	jr nz, .inner_loop
	pop hl
	push bc
	ld bc, BG_MAP_HEIGHT * 2
	add hl, bc
	pop bc
	dec b
	jr nz, .outer_loop
	ret

PikachuMiniGame_Draw2x2Tile:
	push bc
	push de
	push hl

	push hl

	push hl
	ld a, [de]
	ld l, a
	ld h, 0
	ld a, [wPikachuMinigameTilesPointer]
	ld e, a
	ld a, [wPikachuMinigameTilesPointer + 1]
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


PikachuMiniGame_RunFrame:
; Run a single frame of the minigame

	call GetJoypad
	ld hl, hJoyState
	ld a, [hl]
	and %00001000	; Start button
	jr nz, .Done

	ld a, [wPikachuMinigameJumptableIndex]
	bit 7, a
	jr nz, .Done

	ld a, [wPikachuMinigameNoteCaught]
	and a
	jr z, .skip_playing_sfx

	xor a
	ld [wPikachuMinigameNoteCaught], a
	ld de, $30	; PAY_DAY
	call PlaySFX

.skip_playing_sfx
	call PikachuMiniGame_PerformGameFunction
	callba EffectObjectJumpNoDelay

	ld a, 1
	ldh [hBGMapMode], a

	call PikachuMiniGame_ScrollScene
	call PikachuMiniGame_ReloadCollisions

	decoord  18, 1	; last digit
	ld hl, wPikachuMinigameScore
	call PikachuMiniGame_PrintBCD

	call PikachuMiniGame_BlinkText

	call DelayFrame
	and a
	ret

.Done:
	callab InitEffectObject

	ld hl, wVirtualOAM
	ld c, $a0
	xor a
.clear_oam
	ld [hli], a
	dec c
	jr nz, .clear_oam

	call DelayFrame

	xor a
	ldh [hSCX], a
	ldh [hSCY], a

	ld a, 144
	ldh [hWY], a
	scf
	ret


PikachuMiniGame_RunTimer:
	ld hl, wPikachuMinigameTimeFrames
	ld a, [hl]
	add 1
	daa
	ld [hl], a
	cp $60	; 1 second = 60 frames
	ret c

	ld [hl], 0	; reset frame counter
	ld hl, wPikachuMinigameTimeSeconds
	ld a, [hl]
	add 1
	daa
	ld [hl], a
	cp $60	; 1 minute
	ret c

; end game here
	ld a, $02
	ld [wPikachuMinigameJumptableIndex], a
	ret


PikachuMiniGame_ReloadCollisions: ; XXX ?
	ldh a, [hSCX]
	ld e, a
	and $07
	ret nz

	ld a, $48
	add e
	and $f8
	ld e, a
	srl e
	srl e
	srl e
	ld d, 0
	hlbgcoord 0, 8
	add hl, de
	ld de, wPikachuMinigameColumnBuffer
	ld a, e
	ld [wVBCopyDst], a
	ld a, d
	ld [wVBCopyDst + 1], a
	ld a, l
	ld [wVBCopySrc], a
	ld a, h
	ld [wVBCopySrc + 1], a
	ld a, $01
	ld [wVBCopySize], a
	ret


PikachuMiniGame_PrintBCD:
; Print the BCD number in HL to DE, least-significant
; digit first.

	push hl
	push de
	push bc

	ld c, [hl]
	inc hl
	ld b, [hl]

	ld l, e
	ld h, d

	ld a, b
	swap a
	and %00001111	; in the thousandths range?
	jr nz, .four_digits

	ld a, b
	and %00001111	; in the hundreds range?
	jr nz, .three_digits

	ld a, c
	swap a
	and %00001111	; in the tens range?
	jr nz, .two_digits

; got one digit
	ld a, c
	call .PlaceDigit
	jr .finished

.two_digits
	ld a, c
	call .PlaceDigit
	ld a, c
	swap a
	call .PlaceDigit
	jr .finished

.three_digits
	ld a, c
	call .PlaceDigit
	ld a, c
	swap a
	call .PlaceDigit
	ld a, b
	call .PlaceDigit
	jr .finished

.four_digits
	ld a, c
	call .PlaceDigit
	ld a, c
	swap a
	call .PlaceDigit
	ld a, b
	call .PlaceDigit
	ld a, b
	swap a
	call .PlaceDigit

.finished
	pop bc
	pop de
	pop hl
	ret


.PlaceDigit:
	and $0f
	add $36
	ld [hld], a
	ret


PikachuMiniGame_PerformGameFunction:
	jumptable .jumptable, wPikachuMinigameJumptableIndex

.jumptable
; jumptable here
	dw PikachuMiniGame_SetupScene
	dw PikachuMiniGame_NoteSpawner
	dw PikachuMiniGame_SetNextSceneTimer
	dw PikachuMiniGame_WaitAndGotoNextScene
	dw PikachuMiniGame_ShowJigglypuff
	dw PikachuMiniGame_FadeOut

PikachuMiniGame_SetupScene:
; Set scroll speed and joypad enable here
	ld a, 4
	ld [wPikachuMinigameScrollSpeed], a

	ld a, %00110001
	ld [wPikachuMinigameControlEnable], a

	ld hl, wPikachuMinigameJumptableIndex
	inc [hl]
	ret

PikachuMiniGame_SetNextSceneTimer:
	ld a, 64
	ld [wPikachuMinigameSceneTimer], a
	ld hl, wPikachuMinigameJumptableIndex
	inc [hl]

PikachuMiniGame_WaitAndGotoNextScene:
	ld hl, wPikachuMinigameSceneTimer
	ld a, [hl]
	and a
	jr z, .next_scene
	dec [hl]
	ret

.next_scene
	ld hl, wPikachuMinigameJumptableIndex
	inc [hl]

PikachuMiniGame_ShowJigglypuff:
	depixel 14, 24
	ld a, $32
	call InitSpriteAnimStruct

	xor a
	ld [wPikachuMinigameSceneTimer], a
	ld hl, wPikachuMinigameJumptableIndex
	inc [hl]

PikachuMiniGame_FadeOut:
	ld a, [wPikachuMinigameScrollSpeed]
	and a
	ret nz

	ld a, [wPikachuMinigameSceneTimer]
	srl a
	srl a
	srl a
	srl a

	ld e, a
	ld d, 0
	ld hl, .DMGPals
	add hl, de

	ld a, [hl]
	cp -1
	jr z, .end_minigame

	ldh [rBGP], a

	ld hl, .Obj_SGBPals
	add hl, de

	ld a, [wSGB]
	and a
	jr z, .not_sgb

	ld a, [hl]
	ldh [rBGP], a

.not_sgb
	ld a, [hl]
	ldh [rOBP0], a

; from this point, the timer *increments* instead
	ld hl, wPikachuMinigameSceneTimer
	inc [hl]
	ret

.end_minigame
; once everything fades out, the minigame ends here
; leading to the title screen

	ld hl, wPikachuMinigameJumptableIndex
	set 7, [hl]
	ret

.DMGPals:
	db $94, $94
	db $94, $94
	db $94, $50
	db $40, $00
	db -1

.Obj_SGBPals:
	db $e4, $e4
	db $e4, $e4
	db $e4, $90
	db $40, $00
	db -1

PikachuMiniGame_NoteSpawner:
	call PikachuMiniGame_RunTimer
	ldh a, [hSCX]
	and $20
	ld hl, wPikachuMinigameNoteTimer
	cp [hl]
	jr nz, .spawn_note
	ret

.spawn_note
	ld a, [hl]
	xor $20
	ld [hl], a

	call .DetermineSpawnType
	jr c, .next_scene

	call .DetermineSpawnParameters
	ret c	; skip spawning if y = $FF

	ldh a, [hSCX]
	and $1f
	ld e, a
	ld a, $00
	sub e
	ld e, a
	ld a, $03
	ld [$c4bc], a	; Hardcoded object loc

	ld a, $31	; NOTE
	call InitSpriteAnimStruct

; add one to the note counter
	ld hl, wPikachuMinigameNoteCounter
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, 1
	add e
	daa
	ld e, a
	ld a, d
	adc 0
	daa
	ld d, a
	ld [hl], d
	dec hl
	ld [hl], e
	ret

.next_scene	; can this be reached?
	ld hl, wPikachuMinigameJumptableIndex
	inc [hl]
	ret


.DetermineSpawnType:
	ld a, [wPikachuMinigameSpawnTypeIndex]
	ld l, a
	ld h, 0
	ld de, .SpawnTypes
	add hl, de
	ld a, [hl]
	cp -1
	jr nz, .got_type
	xor a
	ld [wPikachuMinigameSpawnTypeIndex], a
.got_type
	and a
	ret

.SpawnTypes:
; or .SpawnParameters indices
	db $00, $01, $02, $03, $04, $05, $06, $00, $01, $02, $03, $04, $05, $06
	db -1

.DetermineSpawnParameters:
; a = spawn type (index of spawn data)

; returns d = Y-starting position of a note
;         carry, if no note is to be spawned ($FF)

	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, .SpawnParameters
	add hl, de

	ld a, [wPikachuMinigameSpawnDataIndex]
	and $07
	ld e, a
	inc a
	cp $08
	jr c, .determine_y_coords

; next spawn type
	push hl
	ld hl, wPikachuMinigameSpawnTypeIndex
	inc [hl]
	pop hl

.determine_y_coords
	ld [wPikachuMinigameSpawnDataIndex], a
	ld d, 0
	add hl, de
	ld a, [hl]
	cp $ff
	jr z, .skip_spawning_note
	ld d, a
	and a
	ret

.skip_spawning_note
	scf
	ret

.SpawnParameters:
	db $70, $60, $50, $48, $48, $48, $48, $38 ; 00
	db $28, $20, $28, $ff, $ff, $ff, $48, $48 ; 01
	db $70, $70, $ff, $58, $ff, $ff, $48, $38 ; 02
	db $28, $20, $28, $38, $48, $ff, $ff, $ff ; 03
	db $70, $70, $70, $70, $60, $50, $48, $38 ; 04
	db $ff, $28, $30, $38, $48, $48, $48, $48 ; 05
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff ; 06

MinigamePikachuDoMovement::
; called from sprite animation routine
	ld a, [wPikachuMinigamePikachuObjectPointer]
	ld c, a
	ld a, [wPikachuMinigamePikachuObjectPointer + 1]
	ld b, a
	call Call_038_459c
	call .ResetScoreModifiersAndCheckNoteCollision
	ld hl, $000b
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, .jump
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
.jump
	dw .Func447d
	dw .Func4489
	dw .Func44b4
	dw .Func44d6

.Func447d:
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], $01
	ld a, $02
	ld [wPikachuMinigamePikachuNextAnim], a
	ret

.Func4489:
	ldh a, [hJoyState]
	ld hl, wPikachuMinigameControlEnable
	and [hl]
	ld d, a
	and $01
	jr nz, .jr_038_449f
	ld a, [wPikachuMinigameScrollSpeed]
	and a
	ret nz
	ld a, $01
	ld [wPikachuMinigamePikachuNextAnim], a
	ret
.jr_038_449f
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ld a, $40
	ld [wPikachuMinigamePikachuYOffset], a
	ld a, $03
	ld [wPikachuMinigamePikachuNextAnim], a
	ld a, $10
	ld [wc606], a
	ret

.Func44b4:
	ld hl, wPikachuMinigamePikachuYOffset
	ld a, [hl]
	cp $20
	jr c, .jr_038_44cf
	dec [hl]
	ld d, $30
	ld e, a
	callba BattleAnim_Sine_e
	ld a, e
	ld hl, $0007
	add hl, bc
	ld [hl], a
	ret
.jr_038_44cf
	ld hl, $000b
	add hl, bc
	ld [hl], $03
	ret
.Func44d6:
	ld hl, $0005
	add hl, bc
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	ret

.ResetScoreModifiersAndCheckNoteCollision:
	xor a
	ld [wPikachuMinigameScoreModifier], a
	ld hl, $0005
	add hl, bc
	ld a, [hl]
	ld hl, $0007
	add hl, bc
	add [hl]
	add $10
	ld e, a
	sub $20
	ld d, a
	push bc
	ld bc, $c41c	; Pikachu object, hardcoded
	ld a, $0a
.jr_038_44f9
	push af
	push de
	ld hl, $0000
	add hl, bc
	ld a, [hl]
	and a
	jr z, .jr_038_450f
	ld hl, $0001
	add hl, bc
	ld a, [hl]
	cp $07
	jr nz, .jr_038_450f
	call .Call_038_451f
.jr_038_450f
	ld hl, $0010
	add hl, bc
	ld c, l
	ld b, h
	pop de
	pop af
	dec a
	jr nz, .jr_038_44f9
	pop bc
	call PikachuMiniGame_AddToScore
	ret
.Call_038_451f:
	ld a, $48
	ld hl, $4
	add hl, bc
	cp [hl]
	ret nc
	ld a, $68
	cp [hl]
	ret c
	ld a, d
	ld hl, $0005
	add hl, bc
	cp [hl]
	ret nc
	ld a, e
	cp [hl]
	ret c

; Pikachu caught a note
	ld a, 1
	ld [wPikachuMinigameNoteCaught], a

	ld hl, $b
	add hl, bc
	inc [hl]
	ld hl, wPikachuMinigameScoreModifier
	inc [hl]
	ret


PikachuMiniGame_AddToScore:
	ld hl, wPikachuMinigameScore
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, [wPikachuMinigameScoreModifier]
	add e
	daa
	ld e, a
	ld a, d
	adc $00
	daa
	ld d, a
	ld [hl], d
	dec hl
	ld [hl], e
	ret

CopyPikachuObjDataToTailObj::
; copies the object data for Pikachu to Pikachu's tail object
; called from sprite animation routine

	ld a, [wPikachuMinigamePikachuObjectPointer]
	ld e, a
	ld a, [wPikachuMinigamePikachuObjectPointer + 1]
	ld d, a

	ld a, [wPikachuMinigamePikachuTailObjectPointer]
	ld c, a
	ld a, [wPikachuMinigamePikachuTailObjectPointer + 1]
	ld b, a

	ld hl, SPRITEANIMSTRUCT_DURATIONOFFSET
	add hl, de
	ld a, [hl]

	ld hl, SPRITEANIMSTRUCT_DURATIONOFFSET
	add hl, bc
	ld [hl], a

	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, de
	ld a, [hl]

	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], a

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, de
	ld a, [hl]

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a

	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, de
	ld a, [hl]

	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], a

	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, de
	ld a, [hl]

	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

Call_038_459c:
	ld hl, $0007
	add hl, bc
	ld a, [hl]
	ld hl, $0005
	add hl, bc
	add [hl]
	ld d, a
	ld hl, $000b
	add hl, bc
	ld a, [hl]
	cp $02
	jr z, .jr_038_45c3
	cp $03
	jr z, .jr_038_45e3
	ld a, d
	cp $70
	ret z
	call Call_038_4602
	ret nz
	ld hl, $000b
	add hl, bc
	ld [hl], $03
	ret


.jr_038_45c3
	ld a, [wPikachuMinigamePikachuYOffset]
	cp $3e
	ret nc
	call Call_038_4602
	ret z
	ld hl, $000b
	add hl, bc
	ld [hl], $00
	ld hl, $0007
	add hl, bc
	ld a, [hl]
	ld [hl], $00
	ld hl, $0005
	add hl, bc
	add [hl]
	and $f8
	ld [hl], a
	ret
.jr_038_45e3
	ld a, d
	cp $70
	jr z, .jr_038_45ec
	call Call_038_4602
	ret z
.jr_038_45ec
	ld hl, $000b
	add hl, bc
	ld [hl], $00
	ld hl, $0007
	add hl, bc
	ld a, [hl]
	ld [hl], $00
	ld hl, $0005
	add hl, bc
	add [hl]
	and $f8
	ld [hl], a
	ret


Call_038_4602:
	ld a, d
	cp $40
	jr z, .jr_038_4609
	xor a
	ret
.jr_038_4609
	ld hl, wPikachuMinigameColumnBuffer
	ld a, $16
	cp [hl]
	ret nz
	inc hl
	cp [hl]
	ret nz
	inc hl
	cp [hl]
	ret


PikachuMiniGame_ScrollScene:
	ld hl, wPikachuMinigameScrollSpeed
	ldh a, [hSCX]
	sub [hl]
	ldh [hSCX], a
	and $10
	ld hl, wPikachuMinigameRedrawTimer
	cp [hl]
	jr nz, .new_column
	ret
.new_column
	ld a, [hl]
	xor $10
	ld [hl], a
	xor a
	ldh [hBGMapMode], a
	call PikachuMiniGame_RenderColumn
	ldh a, [hSCX]
	and $f0
	srl a
	srl a
	srl a
	ld e, a
	ld d, $00
	ld hl, vBGMap0
	add hl, de
	ld a, l
	ldh [hRedrawRowOrColumnDest], a
	ld a, h
	ldh [$ffe7], a
	ld a, $01
	ldh [hRedrawRowOrColumnMode], a
	ret


PikachuMiniGame_RenderColumn:
	call PikachuMiniGame_GetNextColumn
	ret nc

	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, .ColumnSet
	add hl, de
	ld e, l
	ld d, h
	call PikachuMiniGame_UpdateColumn
	ret

.ColumnSet:
; The "level" block set
; top to bottom

	db $05, $0d, $02, $09, $14, $14, $14, $0b ; 00
	db $04, $0c, $02, $08, $14, $14, $14, $0b ; 01
	db $05, $0d, $02, $09, $15, $14, $14, $0b ; 02
	db $04, $0c, $02, $08, $15, $14, $14, $0b ; 03

PikachuMiniGame_UpdateColumn:
	push de
	ld hl, wRedrawRowOrColumnSrcTiles
	ld c, 8
.update
	ld a, [de]
	call PikachuMiniGame_DrawTileToBuffer
	inc de
	dec c
	jr nz, .update
	pop de
	ret

PikachuMiniGame_DrawTileToBuffer:
	push bc
	push de
	push hl
	ld l, a
	ld h, 0
	ld a, [wPikachuMinigameTilesPointer]
	ld e, a
	ld a, [wPikachuMinigameTilesPointer + 1]
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
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	pop de
	pop bc
	ret

PikachuMiniGame_GetNextColumn:
	call .GetNextByte
	cp $f0
	ret c

	call .GetColumnCommand
	jr PikachuMiniGame_GetNextColumn

.GetColumnCommand:
	sub $f0
	ld e, a
	ld d, 0
	ld hl, .table
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.table
	dw .DummyCommand	; f0
	dw .DummyCommand	; f1
	dw .DummyCommand	; f2
	dw .DummyCommand	; f3
	dw .DummyCommand	; f4
	dw .DummyCommand	; f5
	dw .DummyCommand	; f6
	dw .DummyCommand	; f7
	dw .DummyCommand	; f8
	dw .CommandF9	; f9
	dw .CommandFA	; fa
	dw .CommandFB	; fb
	dw .JumpCommand	; fc
	dw .CommandFD	; fd
	dw .CommandFE	; fe
	dw .CommandFF	; ff

.DummyCommand:
	ret

.CommandFF:
	ld hl, wc618
	res 0, [hl]
	ld hl, wc619
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, wPikachuMinigameColumnPointer
	ld [hl], e
	inc hl
	ld [hl], d
	ret

.CommandFE:
	call .GetNextByte
	ld e, a
	call .GetNextByte
	ld hl, wPikachuMinigameColumnPointer
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, wc619
	ld [hl], c
	inc hl
	ld [hl], b
	ld hl, wPikachuMinigameColumnPointer + 1
	ld [hld], a
	ld [hl], e
	ld hl, wc618
	set 0, [hl]
	ret

.JumpCommand:
	call .GetNextByte
	ld e, a
	call .GetNextByte
	ld hl, wPikachuMinigameColumnPointer + 1
	ld [hld], a
	ld [hl], e
	ret

.CommandFD:
	call .GetNextByte
	ld hl, wc618
	bit 1, [hl]
	jr nz, .jr_038_473e
	and a
	jr z, .jr_038_4746
	dec a
	ld [wPikachuMinigameSavedColumnPointer], a
	set 1, [hl]
.jr_038_473e
	ld hl, wPikachuMinigameSavedColumnPointer
	ld a, [hl]
	and a
	jr z, .jr_038_4753
	dec [hl]
.jr_038_4746
	call .GetNextByte
	ld e, a
	call .GetNextByte
	ld hl, wPikachuMinigameColumnPointer + 1
	ld [hld], a
	ld [hl], e
	ret
.jr_038_4753
	ld hl, wc618
	res 2, [hl]
	call .ReplaceColumnPointer
	ret

.CommandF9:
	call .GetNextByte
	ld [wPikachuMinigameSavedColumnPointer + 1], a
	ret

.CommandFA:
	ld hl, wPikachuMinigameSavedColumnPointer + 1
	inc [hl]
	ret

.CommandFB:
	call .GetNextByte
	ld hl, wPikachuMinigameSavedColumnPointer + 1
	cp [hl]
	jr z, .jr_038_4775
	call .ReplaceColumnPointer
	ret
.jr_038_4775
	call .GetNextByte
	ld e, a
	call .GetNextByte
	ld hl, wPikachuMinigameColumnPointer + 1
	ld [hld], a
	ld [hl], e
	ret

.ReplaceColumnPointer:
	ld hl, wPikachuMinigameColumnPointer
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret

.GetNextByte:
	push hl
	push de
	ld hl, wPikachuMinigameColumnPointer
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, [de]
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	pop de
	pop hl
	ret

PikachuMiniGame_Columns:
; Essentially the "level design" of the minigame
; Also see PikachuMiniGame_RenderColumn.ColumnSet

	db $00, $01
	db $00, $01
	db $00, $01
	db $00, $01
	db $02, $03
	db $02, $03
	db $02, $03
	db $02, $03
	db $FC
	dw PikachuMiniGame_Columns
	db $FF

PikachuMiniGame_Blockmap:
INCBIN "gfx/minigames/pikachu_blockmap.bin"

PikachuMiniGame_Meta:
INCBIN "gfx/minigames/pikachu_blockset.bin"
