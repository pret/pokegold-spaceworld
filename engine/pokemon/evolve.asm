INCLUDE "constants.asm"

SECTION "engine/pokemon/evolve.asm", ROMX

EvolvePokemon::
	ld hl, wEvolvableFlags
	xor a
	ld [hl], a
	ld a, [wCurPartyMon]
	ld c, a
	ld b, SET_FLAG
	call EvoFlagAction
EvolveAfterBattle::
	ldh a, [hMapAnims]
	push af
	xor a

	ld [wMonTriedToEvolve], a
	dec a
	ld [wCurPartyMon], a
	push hl
	push bc
	push de
	ld hl, wPartyCount

	push hl

EvolveAfterBattle_MasterLoop:
	ld hl, wCurPartyMon
	inc [hl]

	pop hl
	inc hl

	ld a, [hl]
	cp -1
	jp z, .ReturnToMap

	ld [wEvolutionOldSpecies], a
	push hl

	ld a, [wCurPartyMon]
	ld c, a
	ld hl, wEvolvableFlags
	ld b, CHECK_FLAG
	call EvoFlagAction
	ld a, c
	and a
	jp z, EvolveAfterBattle_MasterLoop

	ld a, [wEvolutionOldSpecies]
	dec a
	ld b, 0
	ld c, a
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a

	push hl
	xor a
	ld [wMonType], a
	predef CopyMonToTempMon
	pop hl

.loop
	ld a, [hli]
	and a
	jr z, EvolveAfterBattle_MasterLoop

	ld b, a

	cp EVOLVE_ITEM
	jr z, .trade

	ld a, [wLinkMode]
	and a
	jr nz, EvolveAfterBattle_MasterLoop

	ld a, b
	cp EVOLVE_STONE
	jr z, .item

	ld a, [wForceEvolution]
	and a
	jr nz, EvolveAfterBattle_MasterLoop

	ld a, b
	cp EVOLVE_LEVEL
	jr z, .level

	; EVOLVE_TRADE
.trade
	ld a, [wLinkMode]
	and a
	jp z, .dont_evolve_1

	ld a, [hli]
	ld b, a
	ld a, [wTempMonLevel]
	cp b
	jp c, EvolveAfterBattle_MasterLoop

	ld a, [hli]
	ld b, a
	and a
	jr z, .proceed
	ld a, [wTempMonItem]
	cp b
	jp nz, EvolveAfterBattle_MasterLoop
	jr .proceed

.item
	ld a, [hli]
	ld b, a
	ld a, [wTempMonLevel]
	cp b
	jp c, .dont_evolve_2

	ld a, [hli]
	ld b, a
	ld a, [wCurItem]
	cp b
	jp nz, .dont_evolve_3

	jr .proceed

.level
	ld a, [hli]
	ld b, a
	ld a, [wTempMonLevel]
	cp b
	jp c, .dont_evolve_3

.proceed
	ld a, [wTempMonLevel]
	ld [wCurPartyLevel], a
	ld a, 1
	ld [wMonTriedToEvolve], a

	push hl

	ld a, [hl]
	ld [wEvolutionNewSpecies], a
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	call CopyStringToStringBuffer2
	ld hl, EvolvingText
	call PrintText

	ld c, 50
	call DelayFrames

	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	lb bc, 12, 20
	call ClearBox

	ld a, $1
	ldh [hBGMapMode], a
	call ClearSprites

	call EvolutionAnimation
	jp c, CancelEvolution

	ld hl, CongratulationsYourPokemonText
	call PrintText

	pop hl

	ld a, [hl]
	ld [wCurSpecies], a
	ld [wTempMonSpecies], a
	ld [wEvolutionNewSpecies], a
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName

	push hl

	ld hl, EvolvedIntoText
	call PrintTextBoxText
	push de
	ld de, MUSIC_NONE
	call PlayMusic
	ld de, SFX_GET_KEY_ITEM_RG
	call PlaySFX
	call WaitSFX
	pop de

	ld c, 40
	call DelayFrames

	call ClearTileMap
	call UpdateSpeciesNameIfNotNicknamed
	call GetBaseData

	ld hl, wTempMonExp + 2
	ld de, wTempMonMaxHP
	ld b, TRUE
	predef CalcMonStats

	ld a, [wCurPartyMon]
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld e, l
	ld d, h
	ld bc, MON_MAXHP
	add hl, bc
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wTempMonMaxHP + 1
	ld a, [hld]
	sub c
	ld c, a
	ld a, [hl]
	sbc b
	ld b, a
	ld hl, wTempMonHP + 1
	ld a, [hl]
	add c
	ld [hld], a
	ld a, [hl]
	adc b
	ld [hl], a

	ld hl, wTempMonSpecies
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes

	ld a, [wCurSpecies]
	ld [wTempSpecies], a
	xor a
	ld [wMonType], a
	call LearnLevelMoves

	ld a, [wBattleMode]
	and a
	call z, Evolve_ReloadTilesetIfNotLinked

	ld a, [wTempSpecies]
	dec a
	ld c, a
	ld b, SET_FLAG
	ld hl, wPokedexCaught
	push bc
	call EvoFlagAction
	pop bc
	ld hl, wPokedexSeen
	call EvoFlagAction
	pop de
	pop hl

	ld a, [wTempMon]
	ld [hl], a
	push hl
	ld l, e
	ld h, d
	jr .dont_evolve_3

.dont_evolve_1
	inc hl
.dont_evolve_2
	inc hl
.dont_evolve_3
	inc hl
	jp .loop

.ReturnToMap:
	pop de
	pop bc
	pop hl
	pop af
	ldh [hMapAnims], a
	ld a, [wLinkMode]
	and a
	ret nz
	ld a, [wBattleMode]
	and a
	ret nz
	ld a, [wMonTriedToEvolve]
	and a
	call nz, PlayMapMusic
	ret

UpdateSpeciesNameIfNotNicknamed:
	ld a, [wCurSpecies]
	push af
	ld a, [wMonHIndex]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	pop af
	ld [wCurSpecies], a
	ld hl, wStringBuffer1
	ld de, wStringBuffer2
.loop
	ld a, [de]
	inc de
	cp [hl]
	inc hl
	ret nz
	cp "@"
	jr nz, .loop

	ld a, [wCurPartyMon]
	ld bc, MON_NAME_LENGTH
	ld hl, wPartyMonNicknames
	call AddNTimes
	push hl
	ld a, [wCurSpecies]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, wStringBuffer1
	pop de
	ld bc, MON_NAME_LENGTH
	jp CopyBytes

CancelEvolution:
	ld hl, StoppedEvolvingText
	call PrintText
	call ClearTileMap
	pop hl
	call Evolve_ReloadTilesetIfNotLinked
	jp EvolveAfterBattle_MasterLoop

CongratulationsYourPokemonText:
	text "おめでとう！　@"
	text_from_ram wStringBuffer2
	text "は"
	done

EvolvedIntoText:
	text "<LINE>@"
	text_from_ram wStringBuffer1
	text "に　しんかした"
	done

StoppedEvolvingText:
	text "あれ<⋯⋯>？"
	line "@"
	text_from_ram wStringBuffer2
	text "の　へんかが　とまった！"
	prompt

EvolvingText:
	text "<⋯⋯>　おや！？"
	line "@"
	text_from_ram wStringBuffer2
	text "の　ようすが<⋯⋯>！"
	done

Evolve_ReloadTilesetIfNotLinked:
	ld a, [wLinkMode]
	and a
	ret nz
	jp LoadTilesetGFX_LCDOff

LearnLevelMoves::
	ld a, [wTempSpecies]
	ld [wCurPartySpecies], a
	dec a
	ld b, 0
	ld c, a
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a

.skip_evos
	ld a, [hli]
	and a
	jr nz, .skip_evos

.find_move
	ld a, [hli]
	and a
	jr z, .done

	ld b, a
	ld a, [wCurPartyLevel]
	cp b
	ld a, [hli]
	jr nz, .find_move

	push hl
	ld d, a
	ld hl, wPartyMon1Moves
	ld a, [wCurPartyMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes

	ld b, NUM_MOVES
.check_move
	ld a, [hli]
	cp d
	jr z, .has_move
	dec b
	jr nz, .check_move
	jr .learn
.has_move

	pop hl
	jr .find_move

.learn
	ld a, d
	ld [wPutativeTMHMMove], a
	ld [wNamedObjectIndexBuffer], a
	call GetMoveName
	call CopyStringToStringBuffer2
	predef LearnMove
	pop hl
	jr .find_move

.done
	ld a, [wCurPartySpecies]
	ld [wTempSpecies], a
	ret

FillMoves:
; Fill in moves at de for wCurPartySpecies at wCurPartyLevel

	push hl
	push de
	push bc
	ld hl, EvosAttacksPointers
	ld b, 0
	ld a, [wCurPartySpecies]
	dec a
	add a
	rl b
	ld c, a
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
.GoToAttacks:
	ld a, [hli]
	and a
	jr nz, .GoToAttacks
	jr .GetLevel

.NextMove:
	pop de
.GetMove:
	inc hl
.GetLevel:
	ld a, [hli]
	and a
	jp z, .done
	ld b, a
	ld a, [wCurPartyLevel]
	cp b
	jp c, .done
	ld a, [wSkipMovesBeforeLevelUp]
	and a
	jr z, .CheckMove
	ld a, [wPrevPartyLevel]
	cp b
	jr nc, .GetMove

.CheckMove:
	push de
	ld c, NUM_MOVES
.CheckRepeat:
	ld a, [de]
	inc de
	cp [hl]
	jr z, .NextMove
	dec c
	jr nz, .CheckRepeat
	pop de
	push de
	ld c, NUM_MOVES
.CheckSlot:
	ld a, [de]
	and a
	jr z, .LearnMove
	inc de
	dec c
	jr nz, .CheckSlot
	pop de
	push de
	push hl
	ld h, d
	ld l, e
	call ShiftMoves
	ld a, [wEvolutionOldSpecies]
	and a
	jr z, .ShiftedMove
	push de
	ld bc, wPartyMon1PP - (wPartyMon1Moves + NUM_MOVES - 1)
	add hl, bc
	ld d, h
	ld e, l
	call ShiftMoves
	pop de

.ShiftedMove:
	pop hl

.LearnMove:
	ld a, [hl]
	ld [de], a
	ld a, [wEvolutionOldSpecies]
	and a
	jr z, .NextMove
	push hl
	ld a, [hl]
	ld hl, MON_PP - MON_MOVES
	add hl, de
	push hl
	dec a
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop hl
	ld [hl], a
	pop hl
	jr .NextMove

.done
	pop bc
	pop de
	pop hl
	ret

ShiftMoves:
	ld c, NUM_MOVES - 1
.loop
	inc de
	ld a, [de]
	ld [hli], a
	dec c
	jr nz, .loop
	ret

EvoFlagAction:
	push de
	ld d, $0
	predef SmallFarFlagAction
	pop de
	ret

INCLUDE "engine/movie/evolution_animation.inc"
