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

	ld a, LOW($4842)
	ld [$c625], a
	ld a, HIGH($4842)	; XXX
	ld [$c626], a	; subroutine pointer?

	ld hl, vBGMap0
	ld a, l
	ld [wPikachuMinigameBGMapPointer], a
	ld a, h
	ld [wPikachuMinigameBGMapPointer + 1], a	; bgmap pointer?

	ld de, $47b2	; XXX
	ld a, e
	ld [$c623], a
	ld a, d
	ld [$c624], a
	call Call_038_4197

	ld hl, wSpriteAnimDict
	ld a, $22	; anim dict values?
	ld [hli], a
	ld a, SPRITE_ANIM_DICT_DEFAULT
	ld [hli], a
	call PikachuMiniGame_LoadFont

	xor a
	ldh [hSCY], a
	ld [wc4c7], a
	ldh [hSCX], a
	ld [wc4c8], a
	ld [wPikachuMinigameJumptableIndex], a
	ld [wPikachuMinigameScrollSpeed], a
	ld [wPikachuMinigameScore], a
	ld [wPikachuMinigameScore + 1], a
	ld [$c60b], a
	ld [$c60c], a
	ld [wPikachuMinigameTimeFrames], a
	ld [wPikachuMinigameTimeSeconds], a
	ld [$c613], a
	ld [$c614], a
	ld [$c608], a
	ld [$c60d], a
	ld [$c60e], a
	ld [$c615], a
	ld [$c618], a
	ld [$c619], a
	ld [$c61a], a
	ld [$c61d], a
	ld [$c61e], a

	ld a, LOW($479e)	; XXX
	ld [$c61b], a
	ld a, HIGH($479e)	; XXX
	ld [$c61c], a

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
	jr .next

.not_sgb
; Normal palette if on GB / GBC
	ld a, %11100100
	ldh [rBGP], a
	ldh [rOBP0], a

.next
	ld de, $7058
	ld a, SPRITE_ANIM_INDEX_2F
	call InitSpriteAnimStruct

	ld a, c
	ld [wLYOverrides], a
	ld a, b
	ld [$c601], a

	ld de, $7058
	ld a, SPRITE_ANIM_INDEX_30
	call InitSpriteAnimStruct

	ld a, c
	ld [$c602], a
	ld a, b
	ld [$c603], a
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

	add $10	; tiles are shifted
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

Func418b:
	ld bc, $0800
jr_038_418e:
	ld a, [de]
	inc de
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, jr_038_418e

	ret


Call_038_4197:
	ld b, $10

jr_038_4199:
	push hl
	ld c, $10

jr_038_419c:
	call Call_038_41ad
	dec c
	jr nz, jr_038_419c

	pop hl
	push bc
	ld bc, $0040
	add hl, bc
	pop bc
	dec b
	jr nz, jr_038_4199

	ret


Call_038_41ad:
	push bc
	push de
	push hl
	push hl
	push hl
	ld a, [de]
	ld l, a
	ld h, $00
	ld a, [$c625]
	ld e, a
	ld a, [$c626]
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
	ld bc, $0020
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


PikachuMiniGame_ReloadCollisions:
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
	ld d, $00
	ld hl, $9900
	add hl, de
	ld de, $c627
	ld a, e
	ld [wVBCopyDst], a
	ld a, d
	ld [$cb66], a
	ld a, l
	ld [wVBCopySrc], a
	ld a, h
	ld [$cb64], a
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
	dw Func4309
	dw Func4389
	dw PikachuMiniGame_SetNextSceneTimer
	dw PikachuMiniGame_WaitAndGotoNextScene
	dw PikachuMiniGame_ShowJigglypuff
	dw PikachuMiniGame_FadeOut

Func4309:
; Set scroll speed here
	ld a, 4
	ld [wPikachuMinigameScrollSpeed], a
	ld a, $31
	ld [wc605], a
	ld hl, wPikachuMinigameJumptableIndex
	inc [hl]
	ret

PikachuMiniGame_SetNextSceneTimer:
	ld a, $40
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
	ld de, $70c0
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

Func4389:
	call PikachuMiniGame_RunTimer
	ldh a, [hSCX]
	and $20
	ld hl, $c608
	cp [hl]
	jr nz, .jump4397
	ret
.jump4397
	ld a, [hl]
	xor $20
	ld [hl], a
	call Call_038_43d0
	jr c, .next_scene
	call Call_038_43f4
	ret c
	ldh a, [hSCX]
	and $1f
	ld e, a
	ld a, $00
	sub e
	ld e, a
	ld a, $03
	ld [$c4bc], a
	ld a, $31
	call InitSpriteAnimStruct
	ld hl, $c60b
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, $01
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
.next_scene
	ld hl, wPikachuMinigameJumptableIndex
	inc [hl]
	ret


Call_038_43d0:
	ld a, [$c60d]
	ld l, a
	ld h, $00
	ld de, .data43e5
	add hl, de
	ld a, [hl]
	cp $ff
	jr nz, .jr_038_43e3
	xor a
	ld [$c60d], a
.jr_038_43e3
	and a
	ret
.data43e5
	db $00, $01, $02, $03, $04, $05, $06, $00, $01, $02, $03, $04, $05, $06, $ff

Call_038_43f4:
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, $441f
	add hl, de
	ld a, [$c60e]
	and $07
	ld e, a
	inc a
	cp $08
	jr c, jr_038_440f

	push hl
	ld hl, $c60d
	inc [hl]
	pop hl

jr_038_440f:
	ld [$c60e], a
	ld d, $00
	add hl, de
	ld a, [hl]
	cp $ff
	jr z, jr_038_441d

	ld d, a
	and a
	ret


jr_038_441d:
	scf
	ret


	db $70, $60, $50, $48, $48, $48, $48, $38, $28, $20, $28, $ff, $ff, $ff, $48, $48
	db $70, $70, $ff, $58, $ff, $ff, $48, $38, $28, $20, $28, $38, $48, $ff, $ff, $ff
	db $70, $70, $70, $70, $60, $50, $48, $38, $ff, $28, $30, $38, $48, $48, $48, $48
	db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

	ld a, [wLYOverrides]
	ld c, a
	ld a, [$c601]
	ld b, a
	call Call_038_459c
	call Call_038_44df
	ld hl, $000b
	add hl, bc
	ld e, [hl]
	ld d, $00
	ld hl, $4475
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl


	db $7d, $44, $89, $44, $b4, $44, $d6, $44

	ld hl, $000b
	add hl, bc
	ld [hl], $01
	ld a, $02
	ld [$c604], a
	ret


	ldh a, [hJoyState]
	ld hl, wc605
	and [hl]
	ld d, a
	and $01
	jr nz, jr_038_449f

	ld a, [wPikachuMinigameScrollSpeed]
	and a
	ret nz

	ld a, $01
	ld [$c604], a
	ret


jr_038_449f:
	ld hl, $000b
	add hl, bc
	inc [hl]
	ld a, $40
	ld [$c607], a
	ld a, $03
	ld [$c604], a
	ld a, $10
	ld [$c606], a
	ret


	ld hl, $c607
	ld a, [hl]
	cp $20
	jr c, jr_038_44cf

	dec [hl]
	ld d, $30
	ld e, a
	ld a, $33
	ld hl, $625d
	call FarCall_hl
	ld a, e
	ld hl, $0007
	add hl, bc
	ld [hl], a
	ret


jr_038_44cf:
	ld hl, $000b
	add hl, bc
	ld [hl], $03
	ret


	ld hl, $0005
	add hl, bc
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	ret


Call_038_44df:
	xor a
	ld [$c60f], a
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
	ld bc, $c41c
	ld a, $0a

jr_038_44f9:
	push af
	push de
	ld hl, $0000
	add hl, bc

Jump_038_44ff:
	ld a, [hl]
	and a
	jr z, jr_038_450f

	ld hl, $0001
	add hl, bc
	ld a, [hl]
	cp $07
	jr nz, jr_038_450f

	call Call_038_451f

jr_038_450f:
	ld hl, $0010
	add hl, bc
	ld c, l
	ld b, h
	pop de
	pop af
	dec a
	jr nz, jr_038_44f9

	pop bc
	call Call_038_4544
	ret


Call_038_451f:
	ld a, $48
	ld hl, $0004
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

	ld a, $01
	ld [wPikachuMinigameNoteCaught], a
	ld hl, $000b
	add hl, bc
	inc [hl]
	ld hl, $c60f
	inc [hl]
	ret


Call_038_4544:
	ld hl, wPikachuMinigameScore
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, [$c60f]
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


	ld a, [wLYOverrides]
	ld e, a
	ld a, [$c601]
	ld d, a
	ld a, [$c602]
	ld c, a
	ld a, [$c603]
	ld b, a
	ld hl, $0009
	add hl, de
	ld a, [hl]
	ld hl, $0009
	add hl, bc
	ld [hl], a
	ld hl, $0005
	add hl, de
	ld a, [hl]
	ld hl, $0005
	add hl, bc
	ld [hl], a
	ld hl, $0007
	add hl, de
	ld a, [hl]
	ld hl, $0007
	add hl, bc
	ld [hl], a
	ld hl, $0004
	add hl, de
	ld a, [hl]
	ld hl, $0004
	add hl, bc
	ld [hl], a
	ld hl, $0006
	add hl, de
	ld a, [hl]
	ld hl, $0006
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
	jr z, jr_038_45c3

	cp $03
	jr z, jr_038_45e3

	ld a, d
	cp $70
	ret z

	call Call_038_4602
	ret nz

	ld hl, $000b
	add hl, bc
	ld [hl], $03
	ret


jr_038_45c3:
	ld a, [$c607]
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


jr_038_45e3:
	ld a, d
	cp $70
	jr z, jr_038_45ec

	call Call_038_4602
	ret z

jr_038_45ec:
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
	jr z, jr_038_4609

	xor a
	ret


jr_038_4609:
	ld hl, $c627
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
	ld hl, $c615
	cp [hl]
	jr nz, jr_038_4627

	ret


jr_038_4627:
	ld a, [hl]
	xor $10
	ld [hl], a
	xor a
	ldh [hBGMapMode], a
	call Call_038_464d
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


Call_038_464d:
	call Call_038_46b4
	ret nc

	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, $4661
	add hl, de
	ld e, l
	ld d, h
	call Call_038_4681
	ret


	db $05, $0d, $02, $09, $14, $14, $14, $0b, $04, $0c, $02, $08, $14, $14, $14, $0b
	db $05, $0d, $02, $09, $15, $14, $14, $0b, $04, $0c, $02, $08, $15, $14, $14, $0b

Call_038_4681:
	push de
	ld hl, wRedrawFlashlightDst0
	ld c, $08

jr_038_4687:
	ld a, [de]
	call Call_038_4691
	inc de
	dec c
	jr nz, jr_038_4687

	pop de
	ret


Call_038_4691:
	push bc
	push de
	push hl
	ld l, a
	ld h, $00
	ld a, [$c625]
	ld e, a
	ld a, [$c626]
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


Call_038_46b4:
jr_038_46b4:
	call Call_038_478e
	cp $f0
	ret c

	call Call_038_46bf
	jr jr_038_46b4

Call_038_46bf:
	sub $f0
	ld e, a
	ld d, $00
	ld hl, $46cd
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl


	db $ed
	ld b, [hl]
	db $ed
	ld b, [hl]
	db $ed
	ld b, [hl]
	db $ed
	ld b, [hl]
	db $ed
	ld b, [hl]
	db $ed
	ld b, [hl]
	db $ed
	ld b, [hl]
	db $ed
	ld b, [hl]
	db $ed
	ld b, [hl]
	ld e, h
	ld b, a
	ld h, e
	ld b, a
	ld l, b
	ld b, a

	db $1e, $47

	dec hl
	ld b, a
	nop
	ld b, a
	xor $46
	ret


	ld hl, $c618
	res 0, [hl]
	ld hl, $c619
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $c61b
	ld [hl], e
	inc hl
	ld [hl], d
	ret


	call Call_038_478e
	ld e, a
	call Call_038_478e
	ld hl, $c61b
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, $c619
	ld [hl], c
	inc hl
	ld [hl], b
	ld hl, $c61c
	ld [hld], a
	ld [hl], e
	ld hl, $c618
	set 0, [hl]
	ret


	call Call_038_478e
	ld e, a
	call Call_038_478e
	ld hl, $c61c
	ld [hld], a
	ld [hl], e
	ret


	call Call_038_478e
	ld hl, $c618
	bit 1, [hl]
	jr nz, jr_038_473e

	and a
	jr z, jr_038_4746

	dec a
	ld [$c61d], a
	set 1, [hl]

jr_038_473e:
	ld hl, $c61d
	ld a, [hl]
	and a
	jr z, jr_038_4753

	dec [hl]

jr_038_4746:
	call Call_038_478e
	ld e, a
	call Call_038_478e
	ld hl, $c61c
	ld [hld], a
	ld [hl], e
	ret


jr_038_4753:
	ld hl, $c618
	res 2, [hl]
	call Call_038_4782
	ret



	call Call_038_478e
	ld [$c61e], a
	ret


	ld hl, $c61e
	inc [hl]
	ret


	call Call_038_478e
	ld hl, $c61e
	cp [hl]
	jr z, jr_038_4775

	call Call_038_4782
	ret


jr_038_4775:
	call Call_038_478e
	ld e, a
	call Call_038_478e
	ld hl, $c61c
	ld [hld], a
	ld [hl], e
	ret


Call_038_4782:
	ld hl, $c61b
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret


Call_038_478e:
	push hl
	push de
	ld hl, $c61b
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

; Map 479e
