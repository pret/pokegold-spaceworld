INCLUDE "constants.asm"

; MinigamePikachuDoMovement.Jumptable constants
	const_def
	const MINIGAME_PIKACHU_INIT    ; 00
	const MINIGAME_PIKACHU_CONTROL ; 01
	const MINIGAME_PIKACHU_JUMPING ; 02
	const MINIGAME_PIKACHU_FALLING ; 03

; PikachuMiniGame_PerformGameFunction.Jumptable constants
	const_def
	const PIKACHU_MINIGAME_SETUP                ; 00
	const PIKACHU_MINIGAME_NOTE_SPAWNER         ; 01
	const PIKACHU_MINIGAME_SET_NEXT_SCENE_TIMER ; 02
	const PIKACHU_MINIGAME_WAIT_AND_GOTO_NEXT   ; 03
	const PIKACHU_MINIGAME_SHOW_JIGGLYPUFF      ; 04
	const PIKACHU_MINIGAME_FADE_OUT             ; 05

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
	ld b, SGB_PIKACHU_MINIGAME
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
	ld a, SPRITE_ANIM_INDEX_GS_INTRO_OMANYTE
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
	ld [wPikachuMinigameColumnFlags], a
	ld [wPikachuMinigameSavedColumnPointer], a
	ld [wPikachuMinigameSavedColumnPointer + 1], a
	ld [wPikachuMinigameRepeatColumnCounter], a
	ld [wPikachuMinigameRepeatColumnCounter2], a

	ld a, LOW(PikachuMiniGame_Columns)
	ld [wPikachuMinigameColumnPointer], a
	ld a, HIGH(PikachuMiniGame_Columns)
	ld [wPikachuMinigameColumnPointer + 1], a

; Set status bar position
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

; Save pointer to the newly initialized Pikachu object
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
	ld bc, SCREEN_WIDTH * BG_MAP_HEIGHT
.clear_bgmap
	ld [hl], 0
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .clear_bgmap

	ld hl, wTileMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
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
	ld bc, 112 * LEN_1BPP_TILE
	ld a, BANK(FontGFX)
	call FarCopyDataDouble

	ld hl, FontGFX tile $39
	ld de, vChars2 tile $32
	ld bc, 16 * LEN_1BPP_TILE
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
	db 0	; terminator

PikachuMiniGame_Copy128Tiles:	; unreferenced?
	ld bc, $80 tiles
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
	ld b, BG_MAP_HEIGHT / 2

.outer_loop
	push hl
	ld c, BG_MAP_WIDTH / 2

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

; Skip minigame on pressing Start
	and START
	jr nz, .Done

	ld a, [wPikachuMinigameJumptableIndex]
	bit 7, a
	jr nz, .Done

	ld a, [wPikachuMinigameNoteCaught]
	and a
	jr z, .skip_playing_sfx

	xor a
	ld [wPikachuMinigameNoteCaught], a
	ld de, SFX_PAY_DAY
	call PlaySFX

.skip_playing_sfx
	call PikachuMiniGame_PerformGameFunction
	callba EffectObjectJumpNoDelay

	ld a, 1
	ldh [hBGMapMode], a

	call PikachuMiniGame_ScrollScene
	call PikachuMiniGame_UpdateBlocks

; Print minigame score, starting from the last digit
	decoord  18, 1
	ld hl, wPikachuMinigameScore
	call PikachuMiniGame_PrintBCD

	call PikachuMiniGame_BlinkText

	call DelayFrame
	and a
	ret

.Done:
	callab InitEffectObject

	ld hl, wVirtualOAM
	ld c, SPRITEOAMSTRUCT_LENGTH * NUM_SPRITE_OAM_STRUCTS
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

; Run BCD frame counter
	ld a, [hl]
	add 1
	daa
	ld [hl], a
	cp $60
	ret c

; Clear frame counter upon passing one second and increment the
; seconds counter instead
	ld [hl], 0
	ld hl, wPikachuMinigameTimeSeconds
	ld a, [hl]
	add 1
	daa
	ld [hl], a
	cp $60
	ret c

; When gameplay time reaches 1 minute, end the game here
	ld a, PIKACHU_MINIGAME_SET_NEXT_SCENE_TIMER
	ld [wPikachuMinigameJumptableIndex], a
	ret


PikachuMiniGame_UpdateBlocks:
	ldh a, [hSCX]
	ld e, a
	and 7
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
	ld a, 1
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

; in the thousandths range?
	ld a, b
	swap a
	and $f
	jr nz, .four_digits

; in the hundredths range?
	ld a, b
	and $f
	jr nz, .three_digits

; in the tenths range?
	ld a, c
	swap a
	and $f
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
	jumptable .Jumptable, wPikachuMinigameJumptableIndex

.Jumptable:
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

	ld a, D_LEFT | D_RIGHT | A_BUTTON
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
	ld a, SPRITE_ANIM_INDEX_MINIGAME_JIGGLYPUFF
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

; from this point, the timer increments*instead
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
; Spawn notes from the left side of the screen.
;
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

; Skip spawning if y = $FF
	call .DetermineSpawnPosition
	ret c

	ldh a, [hSCX]
	and $1f
	ld e, a
	ld a, 0
	sub e
	ld e, a
	ld a, 3
	ld [wSpriteAnimCount], a

	ld a, SPRITE_ANIM_INDEX_MINIGAME_NOTE
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
; or .SpawnPositions indices
	db $00, $01, $02, $03, $04, $05, $06, $00, $01, $02, $03, $04, $05, $06
	db -1

.DetermineSpawnPosition:
; a = spawn type (index of spawn data)

; returns d = Y-starting position of a note
;         carry, if no note is to be spawned

	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, .SpawnPositions
	add hl, de

	ld a, [wPikachuMinigameSpawnDataIndex]
	and 7
	ld e, a
	inc a
	cp 8
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

.SpawnPositions:
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
	call MinigamePikachuCheckFloorCollision
	call .ResetScoreModifiersAndCheckNoteCollision

	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable:
	dw .InitPikachuMovement
	dw .ControlPikachu
	dw .PikachuJumping
	dw .FallDown

.InitPikachuMovement:
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], MINIGAME_PIKACHU_CONTROL
	ld a, 2
	ld [wPikachuMinigamePikachuNextAnim], a
	ret

.ControlPikachu:
	ldh a, [hJoyState]
	ld hl, wPikachuMinigameControlEnable
	and [hl]
	ld d, a

	and A_BUTTON
	jr nz, .do_jump

; Don't animate Pikachu when the screen is still
	ld a, [wPikachuMinigameScrollSpeed]
	and a
	ret nz

	ld a, 1
	ld [wPikachuMinigamePikachuNextAnim], a
	ret

.do_jump
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ld a, 64
	ld [wPikachuMinigamePikachuYOffset], a
	ld a, 3
	ld [wPikachuMinigamePikachuNextAnim], a
	ld a, $10
	ld [wc606], a
	ret

.PikachuJumping:
	ld hl, wPikachuMinigamePikachuYOffset
	ld a, [hl]
	cp 32
	jr c, .fall_down_from_jump
	dec [hl]
	ld d, $30
	ld e, a
	callba BattleAnim_Sine_e
	ld a, e
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret
.fall_down_from_jump
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], MINIGAME_PIKACHU_FALLING
	ret

.FallDown:
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	ret

.ResetScoreModifiersAndCheckNoteCollision:
	xor a
	ld [wPikachuMinigameScoreModifier], a

	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	add [hl]

; Set the Y-collision range between Pikachu and note
; between y-$10 and y+$10

	add $10
	ld e, a
	sub $10 * 2
	ld d, a
	push bc

; Check if the Pikachu object collides with any of the note
; objects.

	ld bc, wSpriteAnim1
	ld a, NUM_SPRITE_ANIM_STRUCTS
.check_note_object
	push af
	push de
	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	ld a, [hl]
	and a
; Deinitialized object, get the next object
	jr z, .get_next_object

; Is the current object a note?
	ld hl, SPRITEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld a, [hl]
	cp 7
	jr nz, .get_next_object

; Check if note collides with Pikachu
	call .IsNoteColliding

.get_next_object
	ld hl, SPRITEANIMSTRUCT_LENGTH
	add hl, bc
	ld c, l
	ld b, h
	pop de
	pop af
	dec a
	jr nz, .check_note_object
	pop bc
	call PikachuMiniGame_AddToScore
	ret

.IsNoteColliding:
; Is the note object within $48 - $68 (middle of the screen)?
	ld a, $48
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	cp [hl]
	ret nc

	ld a, $68
	cp [hl]
	ret c

; Is the note object within collision range?
	ld a, d
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	cp [hl]
	ret nc

	ld a, e
	cp [hl]
	ret c

; Pikachu caught a note
	ld a, 1
	ld [wPikachuMinigameNoteCaught], a

; Delete the note object
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
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
	adc 0
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

MinigamePikachuCheckFloorCollision:
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	add [hl]
	ld d, a

	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld a, [hl]

; Pikachu is jumping
	cp MINIGAME_PIKACHU_JUMPING
	jr z, .jumping

; Pikachu is falling
	cp MINIGAME_PIKACHU_FALLING
	jr z, .falling

	ld a, d
	cp $70
	ret z

	call .CheckCollidingFloor
	ret nz

	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], MINIGAME_PIKACHU_FALLING
	ret

.jumping
	ld a, [wPikachuMinigamePikachuYOffset]
	cp $3e
	ret nc

	call .CheckCollidingFloor
	ret z

	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], MINIGAME_PIKACHU_INIT
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	ld [hl], 0
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	add [hl]
	and %11111000
	ld [hl], a
	ret

.falling
	ld a, d
	cp $70
	jr z, .landed
	call .CheckCollidingFloor
	ret z

.landed
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], MINIGAME_PIKACHU_INIT
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	ld [hl], 0
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	add [hl]
	and %11111000
	ld [hl], a
	ret

.CheckCollidingFloor:
; Returns z if we collided with a platform.

	ld a, d
	cp 64
	jr z, .check_tile_below
	xor a
	ret
.check_tile_below
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
	ld d, 0
	ld hl, vBGMap0
	add hl, de
	ld a, l
	ldh [hRedrawRowOrColumnDest], a
	ld a, h
	ldh [hRedrawRowOrColumnDest + 1], a
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
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable:
	dw .DummyCommand  ; f0
	dw .DummyCommand  ; f1
	dw .DummyCommand  ; f2
	dw .DummyCommand  ; f3
	dw .DummyCommand  ; f4
	dw .DummyCommand  ; f5
	dw .DummyCommand  ; f6
	dw .DummyCommand  ; f7
	dw .DummyCommand  ; f8
	dw .CommandF9	  ; f9
	dw .CommandFA	  ; fa
	dw .CommandFB	  ; fb
	dw .JumpCommand	  ; fc
	dw .CommandFD	  ; fd
	dw .CallCommand	  ; fe
	dw .ReturnCommand ; ff

.DummyCommand:
	ret

.ReturnCommand:
; End level subpart

	ld hl, wPikachuMinigameColumnFlags
	res 0, [hl]

	ld hl, wPikachuMinigameSavedColumnPointer
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, wPikachuMinigameColumnPointer
	ld [hl], e
	inc hl
	ld [hl], d
	ret

.CallCommand:
; Call a level subpart

	call .GetNextByte
	ld e, a
	call .GetNextByte
	ld hl, wPikachuMinigameColumnPointer
	ld c, [hl]
	inc hl
	ld b, [hl]

	ld hl, wPikachuMinigameSavedColumnPointer
	ld [hl], c
	inc hl
	ld [hl], b

	ld hl, wPikachuMinigameColumnPointer + 1
	ld [hld], a
	ld [hl], e

	ld hl, wPikachuMinigameColumnFlags
	set 0, [hl]
	ret

.JumpCommand:
; Jump to another part of the level

	call .GetNextByte
	ld e, a
	call .GetNextByte
	ld hl, wPikachuMinigameColumnPointer + 1
	ld [hld], a
	ld [hl], e
	ret

.CommandFD:
	call .GetNextByte
	ld hl, wPikachuMinigameColumnFlags
	bit 1, [hl]
	jr nz, .flag_set
	and a
	jr z, .update_pointer
	dec a
	ld [wPikachuMinigameRepeatColumnCounter], a
	set 1, [hl]
.flag_set
	ld hl, wPikachuMinigameRepeatColumnCounter
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
.update_pointer
	call .GetNextByte
	ld e, a
	call .GetNextByte
	ld hl, wPikachuMinigameColumnPointer + 1
	ld [hld], a
	ld [hl], e
	ret
.done
	ld hl, wPikachuMinigameColumnFlags
	res 2, [hl]
	call .ReplaceColumnPointer
	ret

.CommandF9:
	call .GetNextByte
	ld [wPikachuMinigameRepeatColumnCounter2], a
	ret

.CommandFA:
	ld hl, wPikachuMinigameRepeatColumnCounter2
	inc [hl]
	ret

.CommandFB:
	call .GetNextByte
	ld hl, wPikachuMinigameRepeatColumnCounter2
	cp [hl]
	jr z, .got_match
	call .ReplaceColumnPointer
	ret
.got_match
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
; See also PikachuMiniGame_RenderColumn.ColumnSet

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
