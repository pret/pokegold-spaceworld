DoSpriteAnimFrame:
	ld hl, SPRITEANIMSTRUCT_ANIM_SEQ_ID
	add hl, bc
	ld e, [hl]
	ld d, $00
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable:
	dw AnimSeq_Null
	dw AnimSeq_PartyMon
	dw AnimSeq_PartyMonSwitch
	dw AnimSeq_PartyMonSelected
	dw AnimSeq_GSIntroBubble
	dw AnimSeq_GSIntroOmanyte
	dw AnimSeq_GSIntroMagikarp
	dw AnimSeq_UnusedIntroAerodactyl
	dw AnimSeq_GSIntroLapras
	dw AnimSeq_GSIntroNote
	dw AnimSeq_GSIntroJigglypuff
	dw AnimSeq_GSIntroPikachu
	dw AnimSeq_GSIntroPikachuTail
	dw AnimSeq_GSIntroFireball
	dw AnimSeq_GSIntroBlastoise
	dw AnimSeq_GSIntroVenusaur
	dw AnimSeq_GSTitleFlameNote
	dw AnimSeq_MinigamePikachu
	dw AnimSeq_MinigamePikachuTail
	dw AnimSeq_MinigameNote
	dw AnimSeq_MinigameJigglypuff
	dw AnimSeq_MinigamePicrossCursor
	dw AnimSeq_MinigamePicrossDust
	dw AnimSeq_PokedexHandCursor
	dw AnimSeq_PokedexCursor
	dw AnimSeq_PokedexSlowpoke
	dw AnimSeq_NamingScreenCursor
	dw AnimSeq_GameFreakLogo
	dw AnimSeq_GSGameFreakLogoStar
	dw AnimSeq_GSGameFreakLogoSparkle
	dw AnimSeq_SlotsGolem
	dw AnimSeq_SlotsChansey
	dw AnimSeq_SlotsChanseyEgg
	dw AnimSeq_MailCursor
	dw AnimSeq_PokerCursor
	dw AnimSeq_MemoryGameCursor
	dw AnimSeq_TrainerGearPointer
	dw AnimSeq_TradePokeBall
	dw AnimSeq_TradeTubeBulge
	dw AnimSeq_TrademonInTube
	dw AnimSeq_Unknown
	dw AnimSeq_RadioFrequencyMeter

AnimSeq_Null:
	ret

AnimSeq_PartyMon:
	ld a, [wMenuCursorY]

	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	cp [hl]
	jr z, AnimSeq_PartyMonSwitch

	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], 2 * TILE_WIDTH
	
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], 0
	ret

AnimSeq_PartyMonSwitch:
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], 3 * TILE_WIDTH

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	and $f
	ret nz

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	xor $4
	ld [hl], a
	ret

AnimSeq_PartyMonSelected:
	ld a, [wMenuCursorY]

	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	cp [hl]
	jr z, .three_offset_right

	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], 2 * TILE_WIDTH
	ret

.three_offset_right
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], 3 * TILE_WIDTH
	ret

AnimSeq_GSIntroBubble:
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	inc [hl]
	cp $40
	jr nc, .delete

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	dec [hl]
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	add 2
	ld [hl], a
	ld d, 8
	call AnimSeqs_Sine
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.delete
	call DeinitializeSprite
	ret

AnimSeq_GSIntroOmanyte:
	ld a, [wGlobalAnimYOffset]
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	add [hl]
	cp $b0
	ret c
	call DeinitializeSprite
	ret

AnimSeq_GSIntroMagikarp:
	call AnimSeqs_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one

.zero:
	call AnimSeqs_IncAnonJumptableIndex

	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	ld a, [hl]

	and $3
	swap a
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
.one
	lb de, 2, 1
	ld a, [wSGB]
	and a
	jr z, .sgb
	lb de, 4, 2
.sgb
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	cp $f0
	jr nc, .delete

	add d
	ld [hl], a
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	add e
	ld [hl], a
	ld d, 8
	call AnimSeqs_Sine
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

.delete
	call DeinitializeSprite
	ret

AnimSeq_UnusedIntroAerodactyl:
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $b0
	jr nc, .delete

	inc [hl]
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	and $1
	ret z

	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	inc [hl]
	ret

.delete
	call DeinitializeSprite
	ret

AnimSeq_GSIntroLapras:
	call AnimSeqs_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw .two

.zero
	call .update_y_offset
	ret z
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $58
	jr c, .next1

	dec [hl]
	ret

.next1
	call AnimSeqs_IncAnonJumptableIndex
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $80
	ret

.one
	call .update_y_offset
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next2

	dec [hl]
	ret

.next2
	call AnimSeqs_IncAnonJumptableIndex
	ret

.two
	call .update_y_offset
	ret z

	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $D0
	jr z, .delete
	dec [hl]
	ret

.delete
	call DeinitializeSprite
	ld a, TRUE
	ld [wIntroSpriteStateFlag], a
	ret

.update_y_offset
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld d, 8
	call AnimSeqs_Sine
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and $1
	ret

AnimSeq_GSIntroNote:
	call AnimSeqs_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one

.zero
	call AnimSeqs_IncAnonJumptableIndex
	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	ld a, [hl]
	and $1
	swap a
	sla a

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
.one
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	cp $80
	jr nc, .delete
	inc [hl]

	ld d, 4
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	add 2
	ld [hl], a
	call AnimSeqs_Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	and $2
	ret z

	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	ret

.delete
	call DeinitializeSprite
	ret

AnimSeq_GSIntroJigglypuff:
	ld a, [wIntroSpriteStateFlag]
	and a
	ret z

	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $d0
	jr z, .delete

	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]
	ret

.delete
	call DeinitializeSprite
	ret

AnimSeq_GSIntroPikachu:
	call AnimSeqs_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw .two

.zero
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $80
	jr z, .next1
	dec [hl]
	ret

.next1
	call AnimSeqs_IncAnonJumptableIndex
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $40
	ld a, $0b ; SPRITE_ANIM_FRAMESET_GS_INTRO_PIKACHU_2
	call _ReinitSpriteAnimFrame
	ret

.one
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next2
	dec [hl]
	ret

.next2
	call AnimSeqs_IncAnonJumptableIndex
	ld a, $0a ; SPRITE_ANIM_FRAMESET_GS_INTRO_PIKACHU
	call _ReinitSpriteAnimFrame
	ret

.two
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	add 4
	ld [hl], a
	ld d, 4
	call AnimSeqs_Sine

	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $d0
	jr z, .delete
	cp $50
	jr z, .intro_sprite_state

	dec [hl]
	dec [hl]
	ret

.intro_sprite_state
	dec [hl]
	dec [hl]
	ld a, TRUE
	ld [wIntroSpriteStateFlag], a
	ret

.delete
	call DeinitializeSprite
	ret

AnimSeq_GSIntroPikachuTail:
	call AnimSeqs_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw .two

.zero
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $80
	jr z, .next1
	dec [hl]
	ret

.next1
	call AnimSeqs_IncAnonJumptableIndex

	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $40
	ld a, $0d ; SPRITE_ANIM_FRAMESET_GS_INTRO_PIKACHU_TAIL_2
	call _ReinitSpriteAnimFrame
	ret

.one
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next2

	dec [hl]
	cp $20
	ret nz
	ld a, $0c ; SPRITE_ANIM_FRAMESET_GS_INTRO_PIKACHU_TAIL
	call _ReinitSpriteAnimFrame
	ret

.next2
	call AnimSeqs_IncAnonJumptableIndex
	ret

.two
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	add $04
	ld [hl], a
	ld d, $04
	call AnimSeqs_Sine

	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a

	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $d0
	jr z, .delete
	dec [hl]
	dec [hl]
	ret

.delete
	call DeinitializeSprite
	ret

AnimSeq_GSIntroFireball:
	call AnimSeqs_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one

.zero
	call AnimSeqs_IncAnonJumptableIndex
	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	ld a, [hl]
	and $4
	sla a
	ld e, a
	ld a, [hl]
	and $3
	swap a
	add e
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	ret

.one
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	dec [hl]
	dec [hl]
	dec [hl]
	dec [hl]

	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	ld d, a
	add 8
	ld [hl], a
	
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	push af
	push de
	call AnimSeqs_Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call AnimSeqs_Cosine

	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

AnimSeq_GSIntroBlastoise:
	call AnimSeqs_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one

.zero
	call AnimSeqs_IncAnonJumptableIndex
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $30
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $30
	ret

.one
; flash down/right
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $3c
	ret nc

	inc [hl]
	inc [hl]
	ld d, $90
	call AnimSeqs_Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a

	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	ld d, $90
	call AnimSeqs_Cosine

	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

AnimSeq_GSIntroVenusaur:
	call AnimSeqs_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one

.zero
	call AnimSeqs_IncAnonJumptableIndex
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $30
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $10
	ret

.one
; flash down/left
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $3c
	ret nc

	inc [hl]
	inc [hl]
	ld d, $90
	call AnimSeqs_Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a

	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]

	inc [hl]
	inc [hl]
	ld d, $90
	call AnimSeqs_Cosine
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

AnimSeq_GSTitleFlameNote:
	call AnimSeqs_AnonJumptable
	jp hl

.anon_dw
	dw .zero
	dw .one

.zero
	call AnimSeqs_IncAnonJumptableIndex
	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	ld a, [hl]

	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	and $3
	ld [hl], a
	inc [hl]
	swap a

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a

.one
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]

	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	sub [hl]

	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], a

	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	sla a
	sla a

	ld d, a
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	add 2
	ld [hl], a
	call AnimSeqs_Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

AnimSeq_MinigamePikachu:
	push bc
	farcall MinigamePikachuDoMovement
	pop bc
	ld hl, wPikachuMinigamePikachuNextAnim
	ld a, [hl]
	and $3
	ret z

	ld [hl], 0
	ld e, a
	ld d, $00
	ld hl, Data8d40b
	add hl, de
	ld a, [hl]
	call _ReinitSpriteAnimFrame
	ret

; Data from 8D40B to 8D40E (4 bytes)
Data8d40b:
	db $12, $13, $12, $14

AnimSeq_MinigamePikachuTail:
	farcall CopyPikachuObjDataToTailObj
	ret

AnimSeq_MinigameNote:
	call AnimSeqs_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one

.zero
	call .BounceNotes
	ld a, [wPikachuMinigameScrollSpeed]
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	add [hl]
	ld [hl], a
	cp $c0
	ret nc

	cp $a8
	ret c
.one
	call DeinitializeSprite
	ld hl, wSpriteAnimCount
	dec [hl]
	ret

.BounceNotes:
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]

	and $1f
	srl a
	ld e, a
	ld d, $00
	ld hl, .YOffsets
	add hl, de
	ld a, [hl]
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

.YOffsets:
	db 4, 7, 9, 10, 9, 7, 4, 0, -4, -7, -9, -10, -9, -7, -4, 0

AnimSeq_MinigameJigglypuff:
	ld a, [wPikachuMinigameScrollSpeed]
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	add [hl]
	ld [hl], a
	cp $30
	ret nz

	xor a
	ld [wPikachuMinigameScrollSpeed], a
	ret

AnimSeq_MinigamePicrossCursor:
	ld hl, wPicrossJoyStateBuffer
	ld a, [hl]
	and D_UP
	jr nz, .Up

	ld a, [hl]
	and D_DOWN
	jr nz, .Down

	ld a, [hl]
	and D_LEFT
	jr nz, .Left

	ld a, [hl]
	and D_RIGHT
	jr nz, .Right
	ret

.Up
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $40
	ret z
	sub 6
	jr .done

.Down
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $9a
	ret z
	add 6
	jr .done

.Left
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $40
	ret z
	sub 6
	jr .done

.Right
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $9a
	ret z
	add 6
	jr .done

.done
	ld [hl], a
	ld a, 8
	ld [wPicrossCursorMovementDelay], a

	ld hl, hJoypadState
	ld a, [hl]
	and ~(A_BUTTON | B_BUTTON)
	ld [hl], a
	ret

AnimSeq_MinigamePicrossDust:
	ld hl, wPicrossAnimateDust
	ld a, [hl]
	and a
	ret z
	
	ld [hl], $00
	ld a, $18 ; SPRITE_ANIM_FRAMESET_MINIGAME_PICROSS_DUST
	call _ReinitSpriteAnimFrame
	ret

AnimSeq_PokedexHandCursor:
	callfar Pokedex_HandCursorControls
	ret

AnimSeq_PokedexCursor:
	callfar Pokedex_CursorControls
	ret

AnimSeq_PokedexSlowpoke:
	call AnimSeqs_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw .two

.zero
	call AnimSeqs_IncAnonJumptableIndex
	ld a, [wPokedexSlowpokeNumSearchEntries]
	cp $08
	jr c, .init_slow

	cp $20
	jr c, .init_medium
	ld a, $20
	jr .init_fast

.init_medium
	ld a, $40
	jr .init_fast

.init_slow
	ld a, $80
.init_fast
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	ret

.one
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .check_results

	dec [hl]
	ret

.check_results
	ld a, [wPokedexSlowpokeNumSearchEntries]
	and a
	jr z, .nothing_found

	ld a, $1b ; SPRITE_ANIM_FRAMESET_POKEDEX_SLOWPOKE_FOUND
	jr .reinit_sprite

.nothing_found
	ld a, $1c ; SPRITE_ANIM_FRAMESET_POKEDEX_SLOWPOKE_NOT_FOUND
.reinit_sprite
	call _ReinitSpriteAnimFrame
	call AnimSeqs_IncAnonJumptableIndex
.two
	ret

AnimSeq_NamingScreenCursor:
	callfar NamingScreen_AnimateCursor
	ret

AnimSeq_MailCursor:
	callfar ComposeMail_AnimateCursor
	ret

AnimSeq_GameFreakLogo:
	callfar GameFreakPresents_UpdateLogoPal
	ret

AnimSeq_GSGameFreakLogoStar:
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .delete

	dec [hl]
	dec [hl]
	ld d, a
	and $1f
	jr nz, .stay
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	dec [hl]
.stay
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld a, [hl]
	push af
	push de
	call AnimSeqs_Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call AnimSeqs_Cosine

	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a

	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]

	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	add [hl]
	ld [hl], a
	ret

.delete
	ld a, 1
	ld [wIntroSceneFrameCounter], a
	call DeinitializeSprite
	ret

AnimSeq_GSGameFreakLogoSparkle:
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	or [hl]
	jr z, .delete

	ld hl, SPRITEANIMSTRUCT_VAR4
	add hl, bc
	ld d, [hl]

	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld a, [hl]
	push af
	push de
	call AnimSeqs_Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call AnimSeqs_Cosine

	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]

	ld hl, SPRITEANIMSTRUCT_VAR3
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h

	ld hl, SPRITEANIMSTRUCT_VAR3
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, -$10
	add hl, de
	ld e, l
	ld d, h

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d

	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld a, [hl]
	xor $20
	ld [hl], a
	ret

.delete
	call DeinitializeSprite
	ret

AnimSeq_SlotsGolem:
	callfar Slots_AnimateGolem
	ret

AnimSeq_SlotsChansey:
	callfar Slots_AnimateChansey
	ld hl, wSlotsDelay
	ld a, [hl]
	cp $2
	ret nz
	ld [hl], $03
	ld a, $23 ; SPRITE_ANIM_FRAMESET_SLOTS_CHANSEY_2
	call _ReinitSpriteAnimFrame
	ret

AnimSeq_SlotsChanseyEgg:
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld a, [hl]
	dec [hl]
	ld e, a
	and $01
	jr z, .move_vertical

	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp 15 * TILE_WIDTH
	jr c, .move_right

	call DeinitializeSprite
	ld a, 4
	ld [wSlotsDelay], a
	ret

.move_right
	inc [hl]
.move_vertical
	ld a, e
	ld d, 32
	call AnimSeqs_Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

AnimSeq_PokerCursor:
	callfar Functione1054
	ret

AnimSeq_TrainerGearPointer:
	callfar AnimateTrainerGearModeIndicatorPointer
	ret

AnimSeq_MemoryGameCursor:
	callfar MemoryGame_AnimateCursor
	ret

AnimSeq_TradePokeBall:
	call AnimSeqs_AnonJumptable
	jp hl
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .three
	dw .four
	dw .delete

.zero
	ld a, $28 ; SPRITE_ANIM_FRAMESET_TRADE_POKE_BALL_WOBBLE
	call _ReinitSpriteAnimFrame
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], 2 ; .two

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $20
	ret

.two
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next
	dec [hl]
	ret

.next
	call AnimSeqs_IncAnonJumptableIndex
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $40

.three
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp 48
	jr c, .delete
	dec [hl]
	ld d, 40
	call AnimSeqs_Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

.one
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], 4

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $30
	
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $24
	ret

.four
	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and a
	jr z, .done2

	ld d, a
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	call Sprites_Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $3f
	ret nz

	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $20

	ld hl, SPRITEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	sub $c
	ld [hl], a
	ret

.done2
	xor a
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	call AnimSeqs_IncAnonJumptableIndex
	ret

.delete
	call DeinitializeSprite
	ret

AnimSeq_TradeTubeBulge:
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	inc [hl]
	cp $b0
	ret c
	call DeinitializeSprite
	ret

AnimSeq_TrademonInTube:
	callfar TradeAnim_AnimateTrademonInTube
	ret

; Appears to resemble the final game's AnimSeq_RevealNewMon, but it doesn't seem to be used in this build...
; Who knows what it was used for?
AnimSeq_Unknown:
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $50
	jr nc, .finish_EggShell
	ld d, a
	add 8
	ld [hl], a

	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld a, [hl]
	push af
	push de
	call AnimSeqs_Sine

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call AnimSeqs_Cosine
	
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.finish_EggShell
	call DeinitializeSprite
	ret

AnimSeq_RadioFrequencyMeter:
	callfar TrainerGear_RadioJumptable
	ret

AnimSeqs_AnonJumptable:
	ld hl, sp+0
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de

	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld l, [hl]
	ld h, 0
	add hl, hl
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

AnimSeqs_IncAnonJumptableIndex:
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ret

AnimSeqs_Sine:
	call Sprites_Sine
	ret

AnimSeqs_Cosine:
	call Sprites_Cosine
	ret
