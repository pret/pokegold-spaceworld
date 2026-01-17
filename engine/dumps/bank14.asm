INCLUDE "constants.asm"

SECTION "engine/dumps/bank14.asm@CopyMonToTempMon", ROMX

CopyMonToTempMon::
	ld a, [wCurPartyMon]
	ld e, a
	call GetMonSpecies
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData

	ld a, [wMonType]
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	and a
	jr z, .getmonaddress
	ld hl, wOTPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	cp OTPARTYMON
	jr z, .getmonaddress
	ld hl, wBoxMons
	ld bc, BOXMON_STRUCT_LENGTH
	cp BOXMON
	jr z, .getmonaddress
	ld hl, wBufferMon
	jr .copywholestruct

.getmonaddress
	ld a, [wCurPartyMon]
	call AddNTimes
.copywholestruct
	ld de, wTempMon
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes
	ret

GetMonSpecies::
	ld a, [wMonType]
	and a ; PARTYMON
	jr z, .partymon
	cp OTPARTYMON
	jr z, .otpartymon
	cp BOXMON
	jr z, .boxmon
	cp TEMPMON
	jr z, .buffermon
	; WILDMON

.partymon
	ld hl, wPartySpecies
	jr .done

.otpartymon
	ld hl, wOTPartySpecies
	jr .done

.boxmon
	ld hl, wBoxSpecies
	jr .done

.buffermon
	ld a, [wBufferMonSpecies]
	jr .done2

.done
	ld d, 0
	add hl, de
	ld a, [hl]

.done2
	ld [wCurPartySpecies], a
	ret

PrintMonTypes::
; Print one or both types of [wCurSpecies]
; on the stats screen at hl.

	push hl
	call GetBaseData
	pop hl

	push hl
	ld a, [wMonHType1]
	call .Print

	ld a, [wMonHType1]
	ld b, a
	ld a, [wMonHType2]
	cp b
	pop hl
	jr z, .hide_type_2
	ld bc, SCREEN_WIDTH * 2
	add hl, bc

.Print
	push hl
	jr PrintType

.hide_type_2
	ld a, '　'
	ld bc, SCREEN_WIDTH - 3
	add hl, bc
	ld [hl], a
	inc bc
	add hl, bc
	ld bc, PLAYER_NAME_LENGTH - 1
	jp ByteFill

PrintMoveType::
; Print the type of move b at hl.

	push hl
	ld a, b
	dec a
	ld bc, MOVE_LENGTH
	ld hl, Moves
	call AddNTimes
	ld de, wStringBuffer1
	ld a, BANK(Moves)
	call FarCopyBytes
	ld a, [wStringBuffer1 + MOVE_TYPE]

PrintType::
; Print type a to stack pointer.
	add a
	ld hl, TypeNames
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl

	jp PlaceString

GetTypeName::
; Copy the name of type [wMoveGrammar] to wStringBuffer1.

	ld a, [wMoveGrammar]
	ld hl, TypeNames
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wStringBuffer1
	ld bc, TYPE_NAME_LENGTH
	jp CopyBytes

SECTION "engine/dumps/bank14.asm@GetTrainerClassName_Old", ROMX

GetTrainerClassName_Old::
; Seemingly unreferenced.
; Loads a name to wStringBuffer1 from a partial list of Trainer classes leftover from Red/Green.
	ld hl, .name_table
	ld a, [wTrainerClass]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wStringBuffer1
.copy_byte
	ld a, [hli]
	ld [de], a
	inc de
	cp '@'
	jr nz, .copy_byte
	ret

.name_table:
	dw .youngster, .bug_catcher, .lass, wOTClassName
	dw .jr_trainer_male, .jr_trainer_female, .pokemaniac, .super_nerd
	dw wOTClassName, wOTClassName, .burglar, .engineer
	dw .jack, wOTClassName, .swimmer, wOTClassName
	dw wOTClassName, .beauty, wOTClassName, .rocker
	dw .juggler, wOTClassName, wOTClassName, .blackbelt
	dw wOTClassName, .prof_oak, .chief, .scientist
	dw wOTClassName, .rocket, .cooltrainer_male, .cooltrainer_female
	dw wOTClassName, wOTClassName, wOTClassName, wOTClassName
	dw wOTClassName, wOTClassName, wOTClassName, wOTClassName
	dw wOTClassName, wOTClassName, wOTClassName, wOTClassName
	dw wOTClassName, wOTClassName, wOTClassName


.youngster
	db "たんパン@"

.bug_catcher
	db "むしとり@"

.lass
	db "ミニスカ@"

.jr_trainer_male
	db "ボーイ@"

.jr_trainer_female
	db "ガール@"

.pokemaniac
	db "マニア@"

.super_nerd
	db "りかけい@"

.burglar
	db "どろぼう@"

.engineer
	db "オヤジ@"

.jack
; Removed trainer class from original game, whose name string didn't make it to Gen I but somehow ended up in Gen II.
	db "ジャック@"

.swimmer
	db "かいパン@"

.beauty
	db "おねえさん@"

.rocker
	db "グループ@"

.juggler
	db "ジャグラー@"

.blackbelt
	db "からて@"

.prof_oak
	db "オーキド@"

.chief
	db "チーフ@"

.scientist
	db "けんきゅういん@"

.rocket
	db "だんいん@"

.cooltrainer_male
	db "エリート♂@"

.cooltrainer_female
	db "エリート♀@"

DrawPlayerHP::
	ld a, 1
	jr DrawHP

DrawEnemyHP:
	ld a, 2

DrawHP:
	ld [wWhichHPBar], a
	push hl
	push bc
	; box mons have full HP
	ld a, [wMonType]
	cp BOXMON
	jr z, .at_least_1_hp

	ld a, [wTempMonHP]
	ld b, a
	ld a, [wTempMonHP + 1]
	ld c, a

; Any HP?
	or b
	jr nz, .at_least_1_hp

	xor a
	ld c, a
	ld e, a
	ld a, 6
	ld d, a
	jp .fainted

.at_least_1_hp
	ld a, [wTempMonMaxHP]
	ld d, a
	ld a, [wTempMonMaxHP + 1]
	ld e, a
	ld a, [wMonType]
	cp BOXMON
	jr nz, .not_boxmon

	ld b, d
	ld c, e

.not_boxmon
	predef ComputeHPBarPixels
	ld a, 6
	ld d, a
	ld c, a

.fainted
	ld a, c
	pop bc
	ld c, a
	pop hl
	push de
	push hl
	push hl
	call DrawBattleHPBar
	pop hl

; Print HP
	bccoord 1, 1, 0
	add hl, bc
	ld de, wTempMonHP
	ld a, [wMonType]
	cp BOXMON
	jr nz, .not_boxmon_2
	ld de, wTempMonMaxHP
.not_boxmon_2
	lb bc, 2, 3
	call PrintNumber

	ld a, '／' ; $f3
	ld [hli], a

; Print max HP
	ld de, wTempMonMaxHP
	lb bc, 2, 3
	call PrintNumber
	pop hl
	pop de
	ret

; TODO: Finish this baby up.
StatsScreenMain::
	ld a, [wCurPartySpecies]
	cp DEX_EGG
	jr z, .got_stats

	call CopyMonToTempMon
	ld a, [wMonType]
	cp BOXMON
	jr c, .got_stats

	ld a, [wTempMonLevel]
	ld [wCurPartyLevel], a
	ld hl, wTempMonExp + 2
	ld de, wTempMonMaxHP
	ld b, 1
	predef CalcMonStats

.got_stats
	ld hl, wd4a7
	set 1, [hl]
	call ClearBGPalettes
	call ClearTileMap
	call UpdateSprites
	callfar LoadPokemonStatsGraphics

	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	ld c, 1
	ld b, 0
	ld hl, Function50340
.asm_502fc
	push bc
	ld de, .asm_50302
	push de
	jp hl

.asm_50302
	pop bc
.asm_50303
	call GetJoypadDebounced
	ldh a, [hJoySum]
	and (D_LEFT | D_RIGHT | B_BUTTON | A_BUTTON)
	jr z, .asm_50303
	bit B_BUTTON_F, a
	jr nz, .asm_50333
	bit D_LEFT_F, a
	jr nz, .asm_5031e
	inc c
	ld a, 3
	cp c
	jr nc, .asm_50323
	ld c, 1
	jr .asm_50323

.asm_5031e
	dec c
	jr nz, .asm_50323
	ld c, 3
.asm_50323
	ld hl, .data_5033a
	dec c
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc c
	ld b, 1
	jr .asm_502fc

.asm_50333
	call ClearBGPalettes
	pop af
	ldh [hMapAnims], a
	ret

.data_5033a
	dw Function50340, Function504e5, Function50562

Function50340::
	call WaitBGMap
	xor a
	ldh [hBGMapMode], a
	ld a, [wMonHIndex]
	ld [wMoveGrammar], a
	ld [wCurSpecies], a
	ld a, b
	and a
	jr nz, .asm_503b3
	push bc
	hlcoord 1, 0
	ld [hl], $74
	inc hl
	ld [hl], $f2
	inc hl

	ld de, wMoveGrammar
	ld bc, $8103
	call PrintNumber
	hlcoord 1, 8
	call PrintLevel

	ld hl, NicknamePointers
	call GetNicknamePointer
	ld d, h
	ld e, l
	hlcoord 1, 10
	call PlaceString
	push bc
	call GetGender
	ld a, '♂'
	jr c, .asm_50384
	ld a, '♀'
.asm_50384
	pop hl
	ld [hl], a
	hlcoord 1, 12
	ld a, '／'
	ld [hli], a
	ld a, [wMonHIndex]
	ld [wMoveGrammar], a
	call GetPokemonName
	call PlaceString
	hlcoord 7, 0
	ld bc, SCREEN_WIDTH
	ld d, SCREEN_HEIGHT

.place_vertical_divider
	ld a, $31
	ld [hl], a
	add hl, bc
	dec d
	jr nz, .place_vertical_divider

	inc a
	hlcoord 2, 16
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	pop bc
.asm_503b3
	push bc
	ld b, 1
	call Function505d9
	hlcoord 8, 0
	ld bc, TextCommands
	call ClearBox

	hlcoord 10, 1
	ld b, 0
	call DrawPlayerHP

	hlcoord 18, 1
	ld [hl], $41

	ld hl, wCurHPPal
	call SetHPPal
	ld b, SGB_STATS_SCREEN_HP_PALS
	call GetSGBLayout

	hlcoord 9, 4
	ld de, StatusText_StatusType
	call PlaceString

	hlcoord 15, 4
	ld a, [wMonType]
	cp 2
	jr z, .asm_503f5
	push hl
	ld de, wTempMonStatus
	call PlaceStatusString
	pop hl
.asm_503f5
	ld de, StatusText_OK
	call z, PlaceString
	hlcoord 14, 6
	call PrintMonTypes

	hlcoord 8, 10
	ld b, 6
	ld c, 10
	call DrawTextBox

	hlcoord 10, 10
	ld de, StatusText_ExpPoints
	call PlaceString

	ld a, [wTempMonLevel]
	push af
	cp 100
	jr z, .asm_50420

	inc a
	ld [wTempMonLevel], a
.asm_50420
	hlcoord 16, 14
	call PrintLevel

	pop af
	ld [wTempMonLevel], a
	ld de, wTempMonExp
	hlcoord 12, 11
	ld bc, $0307
	call PrintNumber

	call .CalcExpToNextLevel
	ld de, wExpToNextLevel
	hlcoord 10, 13
	ld bc, $0307
	call PrintNumber

	hlcoord 9, 13
	ld de, StatusText_Ato
	call PlaceString

	hlcoord 17, 13
	ld de, StatusText_De
	call PlaceString

	ld a, [wTempMonLevel]
	ld b, a
	ld de, wTempMonExp + 2
	hlcoord 10, 16
	predef CalcAndPlaceExpBar

	hlcoord 9, 16
	ld [hl], $40
	hlcoord 18, 16
	ld [hl], $41
	call WaitBGMap

	ld a, 1
	ldh [hBGMapMode], a
	pop bc
	ld a, b
	and a
	ret nz

	call SetPalettes
	ld hl, wTempMonDVs
	call GetUnownLetter

	hlcoord 0, 1
	call PrepMonFrontpic
	ld a, [wCurPartySpecies]
	call PlayCry
	ret

.CalcExpToNextLevel::
	ld a, [wTempMonLevel]
	cp MAX_LEVEL
	jr z, .AlreadyAtMaxLevel
	inc a
	ld d, a
	call CalcExpAtLevel
	ld hl, wTempMonExp + 2
	ld hl, wTempMonExp + 2    ; Seemingly an unnecessary duplicate line
	ldh a, [hQuotient + 3]
	sub [hl]
	dec hl
	ld [wExpToNextLevel + 2], a
	ldh a, [hQuotient + 2]
	sbc [hl]
	dec hl
	ld [wExpToNextLevel + 1], a
	ldh a, [hQuotient + 1]
	sbc [hl]
	ld [wExpToNextLevel], a
	ret

.AlreadyAtMaxLevel
	ld hl, wExpToNextLevel
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

NicknamePointers:
	dw wPartyMonNicknames, wOTPartyMonNicknames, wBoxMonNicknames, wBufferMonNickname

StatusText_StatusType:
	db   "じょうたい／"
	next "タイプ／@"

StatusText_OK:
	db "ふつう@"

StatusText_ExpPoints:
	db "　けいけんち　@"

StatusText_Ato:
; This string and the one below are used to present the
; remaining amount of EXP to level up in a grammatical manner.
; Equivalent to the English version's "LEVEL UP - <amount> to :L<level>".
	db "あと@"

StatusText_De:
	db "で@"

Function504e5::
	call WaitBGMap
	xor a
	ldh [hBGMapMode], a
	ld b, 2
	call Function505d9

	hlcoord 8, 0
	ld bc, TextCommands
	call ClearBox

	hlcoord 8, 1
	ld de, .Item
	call PlaceString

	ld a, [wTempMonItem]
	and a
	ld de, .NoItem
	jr z, .asm_50511
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
.asm_50511
	hlcoord 11, 2
	call PlaceString

	ld hl, wTempMonMoves
	ld de, wListMoves_MoveIndicesBuffer
	ld bc, $0004
	call CopyBytes

	hlcoord 8, 4
	ld b, 12
	ld c, 10
	call DrawTextBox

	hlcoord 11, 4
	ld de, .Moves
	call PlaceString

	hlcoord 9, 6
	ld a, $3c
	ld [wcdc3], a
	call ListMoves

	hlcoord 11, 7
	ld a, $3c
	ld [wcdc3], a
	call ListMovePP

	call WaitBGMap
	ld a, 1
	ldh [hBGMapMode], a
	ret

.Item
	db "そうび@"

.NoItem
	db "なし@"

.Moves
	db "　もちわざ　@"

Function50562::
	call WaitBGMap
	xor a
	ldh [hBGMapMode], a
	ld b, 3
	call Function505d9

	hlcoord 8, 0
	ld bc, TextCommands
	call ClearBox

	hlcoord 9, 1
	ld de, .IDNo_OT
	call PlaceString

	hlcoord 12, 1
	ld de, wTempMonID
	ld bc, $8205
	call PrintNumber

	ld hl, .OTPointers
	call GetNicknamePointer

	ld de, wStringBuffer1
	push de
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	pop de
	callfar CorrectNickErrors
	hlcoord 12, 3
	call PlaceString

	ld d, 0
	call PrintTempMonStats
	hlcoord 10, 6
	ld de, .Parameters
	call PlaceString

	call WaitBGMap
	ld a, 1
	ldh [hBGMapMode], a
	ret

.IDNo_OT
	db   "<ID>№／"
	next "おや／"
	next "@"

.Parameters
	db "　パラメータ　@"

.OTPointers
	dw wPartyMonOTs
	dw wOTPartyMonOT
	dw wBoxMonOTs
	dw wBufferMonOT

Function505d9::
	hlcoord 1, 14
	ld a, $36
	call .load_square
	hlcoord 3, 14
	ld a, $36
	call .load_square
	hlcoord 5, 14
	ld a, $36
	call .load_square
	ld a, b
	cp 2
	ld a, $3a
	hlcoord 3, 14
	jr c, .load_square
	hlcoord 5, 14
	jr z, .load_square
	hlcoord 1, 14
.load_square
	ld [hli], a
	inc a
	ld [hld], a
	push bc
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	ret

GetNicknamePointer::
	ld a, [wMonType]
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMonType]
	cp 3
	ret z
	ld a, [wCurPartyMon]
	jp SkipNames

; Prints a text box containing wTempMon's stats.
; If d = 0, print it closer to the middle. Else, print it on the side.
PrintTempMonStats::
	ld a, d
	and a
	jr nz, .level_up_screen

	hlcoord 8, 6
	ld b, 10
	ld c, 10
	call DrawTextBox

	hlcoord 9, 8
	lb bc, 0, 6
	jr .next

.level_up_screen
	hlcoord 9, 0
	ld b, 10
	ld c, 9
	call DrawTextBox

	hlcoord 11, 2
	lb bc, 0, 4

.next
	push bc
	push hl
	ld de, .StatNames
	call PlaceString

	pop hl
	pop bc
	add hl, bc
	ld de, wTempMonAttack
	lb bc, 2, 3
	call .PrintStat

	ld de, wTempMonDefense
	call .PrintStat

	ld de, wTempMonSpclAtk
	call .PrintStat

	ld de, wTempMonSpclDef
	call .PrintStat

	ld de, wTempMonSpeed
	jp PrintNumber

.PrintStat
	push hl
	call PrintNumber
	pop hl
	; Print next numbers two tiles lower
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	ret

.StatNames:
	db   "こうげき" ; "ATTACK"
	next "ぼうぎょ" ; "DEFENSE"
	next "とくこう" ; "SPCL.ATK"
	next "とくぼう" ; "SPCL.DEF"
	next "すばやさ" ; "SPEED"
	next "@"

GetGender::

; 0: PartyMon
	ld hl, wPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wMonType]
	and a
	jr z, .PartyMon

; 1: OTPartyMon
	ld hl, wOTPartyMon1DVs
	dec a
	jr z, .PartyMon

; 2: wBoxMon
	ld hl, wBoxMon1DVs
	ld bc, BOXMON_STRUCT_LENGTH
	dec a
	jr z, .wBoxMon

; else: WildMon
	ld hl, wEnemyMonDVs
	jr .DVs

.PartyMon
.wBoxMon
	ld a, [wCurPartyMon]
	call AddNTimes

.DVs
; Attack DV
	ld a, [hli]
	and $f0
	ld b, a
; Speed DV
	ld a, [hl]
	and $f0
	swap a

; Put our DVs together.
	or b
	ld b, a

; BUG: No handling for genderless Pokémon, despite already being defined in base stats.
; As a result, they're always considered as female here.

; Also, due to GENDER_FEMALE not truly being 100%, an always-female
; Pokémon can be male if it has max Attack and Speed DVs.
; Final game adds a check to guarantee that those Pokémon will be female.

	ld a, [wMonHGenderRatio]
	cp b
	ret

ListMovePP::
	ld a, [wNumMoves]
	inc a
	ld c, a
	ld a, NUM_MOVES
	sub c
	ld b, a
	push hl
	ld a, [wcdc3]
	ld e, a
	ld d, 0
	ld a, $3e ; P
	call .load_loop
	ld a, b
	and a
	jr z, .skip
	ld c, a
	ld a, 'ー'
	call .load_loop

.skip
	pop hl
	inc hl
	inc hl
	inc hl
	ld d, h
	ld e, l
	ld hl, wTempMonMoves
	ld b, 0
.loop
	ld a, [hli]
	and a
	jr z, .done
	push bc
	push hl
	push de
	ld hl, wMenuCursorY
	ld a, [hl]
	push af
	ld [hl], b
	push hl
	callfar GetMaxPPOfMove
	pop hl
	pop af
	ld [hl], a
	pop de
	pop hl
	push hl
	ld bc, $0014
	add hl, bc
	ld a, [hl]
	and $3f
	ld [wStringBuffer1 + 4], a
	ld h, d
	ld l, e
	push hl
	ld de, wStringBuffer1 + 4
	lb bc, 1, 2
	call PrintNumber
	ld a, '／'
	ld [hli], a
	ld de, wNamedObjectIndexBuffer
	lb bc, 1, 2
	call PrintNumber
	pop hl
	ld a, [wcdc3]
	ld e, a
	ld d, 0
	add hl, de
	ld d, h
	ld e, l
	pop hl
	pop bc
	inc b
	ld a, b
	cp NUM_MOVES
	jr nz, .loop
.done
	ret

.load_loop::
	ld [hli], a
	ld [hld], a
	add hl, de
	dec c
	jr nz, .load_loop
	ret

SECTION "engine/dumps/bank14.asm@Party Menu Routines", ROMX

ClearGraphicsForPartyMenu::
	ldh a, [rLCDC]
	bit rLCDC_ENABLE, a
	jr z, .asm_5075f
	call ClearBGPalettes

.asm_5075f
	ld hl, wStateFlags
	res SPRITE_UPDATES_DISABLED_F, [hl]
	call ClearSprites
	xor a
	ldh [hBGMapMode], a
	call ClearTileMap
	call UpdateSprites
	ret

OpenPartyMenu_ClearGraphics::
	call ClearGraphicsForPartyMenu
	; Fallthrough
OpenPartyMenu::
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	ld hl, wOptions
	set NO_TEXT_SCROLL_F, [hl]

	call .SetMenuAttributes
	call InitPartyMenuLayout
	call PartyMenuSelect

	ld hl, wOptions
	res NO_TEXT_SCROLL_F, [hl]
	pop bc
	ld a, b
	ldh [hMapAnims], a
	ret

.SetMenuAttributes:
	call LoadFontsBattleExtra
	xor a
	ld [wMonType], a
	ld de, Data_507c7
	call SetMenuAttributes

	ld a, [wPartyCount]
	ld [w2DMenuNumRows], a

	ld b, a
	ld a, [wFailedToFlee]
	and a
	ld a, $03
	jr z, .asm_507b4
	xor a ; FALSE
	ld [wFailedToFlee], a
	ld a, $01
.asm_507b4
	ld [wMenuJoypadFilter], a
	ld a, [wPartyMenuCursor]
	and a
	jr z, .asm_507c1
	inc b
	cp b
	jr c, .asm_507c3
.asm_507c1
	ld a, $01
.asm_507c3
	ld [wMenuCursorY], a
	ret

Data_507c7:
	db $01, $00, $00, $01, $60, $00, $20, $00

PartyMenuSelect::
	call StaticMenuJoypad
	call PlaceHollowCursor
	ld a, [wMenuCursorY]
	ld [wPartyMenuCursor], a
	ldh a, [hJoySum]
	ld b, a
	ld a, [wSelectedSwapPosition]
	and a
	jp nz, .asm_50808
	ld a, [wPartyCount]
	and a
	jr z, .asm_50806
	bit 1, b
	jr nz, .asm_50806

	ld a, [wMenuCursorY]
	dec a
	ld [wCurPartyMon], a

	ld c, a
	ld b, $00
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl]
	ld [wCurPartySpecies], a
	ld [wTempBattleMonSpecies], a
	and a
	ret

.asm_50806
	scf
	ret
.asm_50808
	bit 1, b
	jr nz, .asm_5080f
	call _SwitchPartyMons
.asm_5080f
	call PartyMenu_ClearCursor
	xor a
	ld [wSelectedSwapPosition], a
	ld [wPartyMenuActionText], a
	call InitPartyMenuLayout
	jp PartyMenuSelect

InitPartyMenuLayout::
	ld a, [wPartyMenuActionText]
	cp PARTYMENUACTION_MOVE
	jp z, PrintPartyMenuText

	callfar LoadOverworldMonIcon
	call PartyMenu_ClearCursor
	callfar InitPartyMenuPalettes
	hlcoord 3, 1
	ld de, wPartySpecies
	ld a, [wCurPartyMon]
	push af
	xor a
	ld [wCurPartyMon], a
	ld [wcce1], a
.loop
	ld a, [de]
	cp -1
	jp z, .done
	push de
	call PlacePartyMember
	pop de
	ld a, [wCurPartyMon]
	ldh [hObjectStructIndex], a
	push hl
	push de

	ld hl, LoadMenuMonIcon
	ld a, BANK(LoadMenuMonIcon)
	ld e, MONICON_PARTYMENU
	call FarCall_hl

	pop de
	inc de
	pop hl
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	ld a, [wCurPartyMon]
	inc a
	ld [wCurPartyMon], a
	jr .loop

.done
	pop af
	ld [wCurPartyMon], a
	jp PrintPartyText_GetSGBLayout

WritePartyMenuTilemapAndText::
	ld a, [wPartyMenuActionText]
	cp PARTYMENUACTION_MOVE
	jp z, PrintPartyMenuText

	callfar InitPartyMenuPalettes
	hlcoord 3, 1
	ld de, wPartySpecies
	ld a, [wCurPartyMon]
	push af
	xor a
	ld [wCurPartyMon], a
	ld [wcce1], a
.loop
	ld a, [de]
	cp -1
	jp z, .done
	push de
	call PlacePartyMember
	pop de
	ld a, [wCurPartyMon]
	ldh [hEventID], a
	inc de
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	ld a, [wCurPartyMon] ; redundant
	inc a
	ld [wCurPartyMon], a
	jr .loop

.done
	pop af
	ld [wCurPartyMon], a
	jp PrintPartyText_GetSGBLayout

; Places the tilemap of the party member at wCurPartyMon.
PlacePartyMember::
	push bc
	push hl
	push hl
	ld hl, wPartyMonNicknames
	ld a, [wCurPartyMon]
	call GetNick
	pop hl
	call PlaceString
	call CopyMonToTempMon
	pop hl

	push hl
	ld a, [wSelectedSwapPosition]
	and a
	jr z, .not_switching

	dec a
	ld b, a
	ld a, [wCurPartyMon]
	cp b
	jr nz, .not_switching

	dec hl
	dec hl
	dec hl
	ld a, '▷'
	ld [hli], a
	inc hl
	inc hl

.not_switching
	ld a, [wPartyMenuActionText]
	cp PARTYMENUACTION_TEACH_TMHM
	jr z, .PlacePartyMonTMHMCompatibility
	cp PARTYMENUACTION_EVO_STONE
	jr z, .PlacePartyMonEvoStoneCompatibility
	cp PARTYMENUACTION_GIVE_MON
	jp z, .PlacePartyMonGender
	cp PARTYMENUACTION_GIVE_MON_FEMALE
	jp z, .PlacePartyMonGender
	push hl
	ld bc, -15
	add hl, bc
	ld de, wTempMonStatus
	call PlaceStatusString
	pop hl
	push hl
	ld bc, -12
	add hl, bc
	ld b, 0
	call DrawEnemyHP
	push de
	call SetPartyHPBarPalette
	pop de
	pop hl
	jr .PrintLevel

.PlacePartyMonTMHMCompatibility
	push hl
	predef CanLearnTMHMMove
	pop hl
	ld de, .string_able
	ld a, c
	and a
	jr nz, .able
	ld de, .string_not_able
.able
	push hl
	ld bc, 9
	add hl, bc
	call PlaceString
	pop hl
.PrintLevel
	ld bc, 5
	add hl, bc
	push de
	call PrintLevel
	pop de
	pop hl
	pop bc
	ret

.string_able:
	db "おぼえられる@" ; "ABLE"

.string_not_able:
	db "おぼえられない@" ; "NOT ABLE"

.PlacePartyMonEvoStoneCompatibility:
	push hl
	ld hl, EvosAttacksPointers
	ld a, [wTempMonSpecies]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
; BUG: Only the first three evolution entries can have Stone compatibility reported correctly.
; While this never comes up in the final game, this prototype has Espeon and Umbreon evolving from
; Heart Stones and Poison Stones respectively, making it five evolution stone entries for Eevee.
	ld de, wStringBuffer1
	ld a, BANK(EvosAttacksPointers)
	ld bc, 2
	call FarCopyBytes
	ld hl, wStringBuffer1
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wStringBuffer1
	ld a, BANK(EvosAttacks)
	ld bc, 10
	call FarCopyBytes
	ld hl, wStringBuffer1
	ld de, .string_cant_use

.loop
	ld a, [hli]
	and a
	jr z, .nope
	inc hl
	inc hl
	cp EVOLVE_STONE
	jr nz, .loop
	dec hl
	dec hl
	ld b, [hl]
	ld a, [wCurItem]
	inc hl
	inc hl
	cp b
	jr nz, .loop
	ld de, .string_can_use

.nope
	pop hl
	push hl
	ld bc, 9
	add hl, bc
	call PlaceString
	pop hl
	jr .PrintLevel

.string_can_use
	db "つかえる@" ; "ABLE"
.string_cant_use
	db "つかえない@" ; "NOT ABLE"

.PlacePartyMonGender
	xor a
	ld [wMonType], a
	push hl
	call GetGender
	pop hl
	ld de, .male
	jr c, .got_gender
	ld de, .female
.got_gender
	push hl
	ld bc, 9
	add hl, bc
	call PlaceString
	pop hl
	jp .PrintLevel

.male
	db "オス@"

.female
	db "メス@"

PrintPartyText_GetSGBLayout::
	ld b, SGB_PARTY_MENU
	call GetSGBLayout
PrintPartyMenuText::
	ld hl, wOptions
	ld a, [hl]
	push af
	push hl
	set NO_TEXT_SCROLL_F, [hl]

	ld a, [wPartyMenuActionText]
	cp PARTYMENUTEXT_HEAL_PSN
	jr nc, .heal

	add a
	ld c, a
	ld b, 0
	ld hl, .PartyMenuStrings
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	jr .done

.heal
	and $f
	add a
	ld c, a
	ld b, 0
	ld hl, .MenuActionStrings
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	pop hl
	call PrintText
.done
	pop hl
	pop af
	ld [hl], a
	call WaitBGMap
	call SetPalettes
	ret

.MenuActionStrings
	dw CuredOfPoisonText
	dw BurnWasHealedText
	dw _WasDefrostedText
	dw _WokeUpText
	dw RidOfParalysisText
	dw RecoveredSomeHPText
	dw HealthReturnedText
	dw RevitalizedText
	dw _GrewToLevelText

.PartyMenuStrings
	dw ChooseAMonString
	dw UseOnWhichPKMNString
	dw WhichPKMNString
	dw TeachWhichPKMNString
	dw MoveToWhereString
	dw UseOnWhichPKMNString
	dw ChooseFirstMonString
	dw ChooseSecondMonString

ChooseAMonString:
	text "#を　えらんで　ください"
	done

UseOnWhichPKMNString:
	text "どの#に　つかいますか？"
	done

WhichPKMNString:
	text "どの#を　だしますか？"
	done

TeachWhichPKMNString:
	text "どの#に　おしえますか？"
	done

MoveToWhereString:
	text "どこに　いどうしますか？"
	done

ChooseFirstMonString:
	text "１ぴきめの　#を"
	line "えらんで　ください"
	done

ChooseSecondMonString:
	text "２ひきめの　#を"
	line "えらんで　ください"
	done

RecoveredSomeHPText:
	text_from_ram wStringBuffer1
	text "の　たいりょくが"
	line "@"
	deciram wHPBarHPDifference, 2, 3
	text "　かいふくした"
	done

CuredOfPoisonText:
	text_from_ram wStringBuffer1
	text "の　どくは"
	line "きれい　さっぱり　なくなった！"
	done

RidOfParalysisText:
	text_from_ram wStringBuffer1
	text "の　からだの"
	line "しびれが　とれた"
	done

BurnWasHealedText:
	text_from_ram wStringBuffer1
	text "の"
	line "やけどが　なおった"
	done

_WasDefrostedText:
	text_from_ram wStringBuffer1
	text "の　からだの"
	line "こおりが　とけた"
	done

_WokeUpText:
	text_from_ram wStringBuffer1
	text "は"
	line "めを　さました"
	done

HealthReturnedText:
	text_from_ram wStringBuffer1
	text "は"
	line "けんこうになった！"
	done

RevitalizedText:
	text_from_ram wStringBuffer1
	text "は"
	line "げんきを　とりもどした！"
	done

_GrewToLevelText:
	text_from_ram wStringBuffer1
	text "の　レベルが@"
	deciram wCurPartyLevel, 1, 3
	text "になった@"
	sound_dex_fanfare_50_79
	text_waitbutton
	text_end
	
SetPartyHPBarPalette::
	ld hl, wHPPals
	ld a, [wcce1]
	ld c, a
	ld b, 0
	add hl, bc
	call SetHPPal
	ld b, SGB_PARTY_MENU_HP_PALS
	call GetSGBLayout
	ld hl, wcce1
	inc [hl]
	ret

PlaceStatusString::
	push de
	inc de
	inc de
	ld a, [de]
	ld b, a
	inc de
	ld a, [de]
	or b
	pop de
	jr nz, PlaceNonFaintStatus
	; "FNT" equivalent string
	ld a, 'ひ'
	ld [hli], a
	ld a, 'ん'
	ld [hli], a
	ld [hl], 'し'
	and a
	ret

PlaceNonFaintStatus::
	ld a, [de]
	bit PSN, a
	jr nz, .PsnString
	bit BRN, a
	jr nz, .BrnString
	bit FRZ, a
	jr nz, .FrzString
	bit PAR, a
	jr nz, .ParString
	and SLP
	ret z
	; "SLP" equivalent string
	ld a, 'ね'
	ld [hli], a
	ld a, 'む'
	ld [hli], a
	ld [hl], 'り'
	ret

.PsnString
	ld a, '<DO>'
	ld [hli], a
	ld [hl], 'く'
	ret

.BrnString
	ld a, 'や'
	ld [hli], a
	ld a, 'け'
	ld [hli], a
	ld [hl], '<DO>'
	ret

.FrzString
	ld a, 'こ'
	ld [hli], a
	ld a, 'お'
	ld [hli], a
	ld [hl], 'り'
	ret

.ParString
	ld a, 'ま'
	ld [hli], a
	ld [hl], 'ひ'
	ret

GetMonBackpic::
	ld a, $00
	call OpenSRAM
	push hl
	ld hl, sSpriteBuffer1
	ld de, sSpriteBuffer0
	ld bc, SPRITEBUFFERSIZE
	call CopyBytes

	ld hl, sSpriteBuffer2
	ld de, sSpriteBuffer1
	ld bc, SPRITEBUFFERSIZE
	call CopyBytes
	
	call _InterlaceMergeSpriteBuffers
	
	pop hl
	ld de, sSpriteBuffer1
	ld c, 6 * 6
	ldh a, [hROMBank]
	ld b, a
	call Get2bpp
	call CloseSRAM
	ret

ListMoves::
	ld de, wListMoves_MoveIndicesBuffer
	ld b, $00
.asm_50c03
	ld a, [de]
	inc de
	and a
	jr z, .asm_50c36
	push de
	push hl
	push hl
	ld [wCurSpecies], a
	ld a, MOVE_NAME
	ld [wNamedObjectTypeBuffer], a
	call GetName
	ld de, wStringBuffer1
	pop hl
	push bc
	call PlaceString
	pop bc
	ld a, b
	ld [wNumMoves], a
	inc b
	pop hl
	push bc
	ld a, [wHPBarMaxHP]
	ld c, a
	ld b, $00
	add hl, bc
	pop bc
	pop de
	ld a, b
	cp $04
	jr z, .asm_50c47
	jr .asm_50c03

.asm_50c36
	ld a, b
.asm_50c37
	push af
	ld [hl], $e3
	ld a, [wHPBarMaxHP]
	ld c, a
	ld b, $00
	add hl, bc
	pop af
	inc a
	cp $04
	jr nz, .asm_50c37
.asm_50c47
	ret

Function50c48::
	ld a, [wce34]
	cp $01
	jr nz, .asm_50c59
	ld hl, wOTPartyCount
	ld de, wOTPartyMonOT
	ld a, ENEMY_OT_NAME
	jr .asm_50c8b


.asm_50c59
	cp $04
	jr nz, .asm_50c67
	ld hl, wPartyCount
	ld de, wPartyMonOTs
	ld a, PARTY_OT_NAME
	jr .asm_50c8b


.asm_50c67
	cp $05
	jr nz, .asm_50c75
	ld hl, wcd60
	ld de, PokemonNames
	ld a, MON_NAME
	jr .asm_50c8b


.asm_50c75
	cp $02
	jr nz, .asm_50c83

	ld hl, wItems
	ld de, ItemNames
	ld a, ITEM_NAME
	jr .asm_50c8b


.asm_50c83
	ld hl, wcd60
	ld de, ItemNames
	ld a, ITEM_NAME
.asm_50c8b
	ld [wNamedObjectTypeBuffer], a
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	ld a, e
	ld [wNamesPointer], a
	ld a, d
	ld [wNamesPointer + 1], a
	ld bc, ItemAttributes
	ld a, c
	ld [wItemAttributesPointer], a
	ld a, b
	ld [wItemAttributesPointer + 1], a
	ret

CalcLevel::
	ld a, [wTempMonSpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld d, 1
.next_level
	inc d
	call CalcExpAtLevel
	push hl
	ld hl, wTempMonExp + 2
	ldh a, [hQuotient + 3]
	ld c, a
	ld a, [hld]
	sub c
	ldh a, [hQuotient + 2]
	ld c, a
	ld a, [hld]
	sbc c
	ldh a, [hQuotient + 1]
	ld c, a
	ld a, [hl]
	sbc c
	pop hl
	jr nc, .next_level

.got_level
	dec d
	ret

CalcExpAtLevel::
	ld a, [wMonHGrowthRate]
	add a
	add a
	ld c, a
	ld b, 0
	ld hl, GrowthRates
	add hl, bc
; Cube the level
	call .LevelSquared
	ld a, d
	ldh [hMultiplier], a
	call Multiply

; Multiply by a
	ld a, [hl]
	and $f0
	swap a
	ldh [hMultiplier], a
	call Multiply
; Divide by b
	ld a, [hli]
	and $f
	ldh [hDivisor], a
	ld b, 4
	call Divide
; Push the cubic term to the stack
	ldh a, [hQuotient + 1]
	push af
	ldh a, [hQuotient + 2]
	push af
	ldh a, [hQuotient + 3]
	push af
; Square the level and multiply by the lower 7 bits of c
	call .LevelSquared
	ld a, [hl]
	and $7f
	ldh [hPrintNumDivisor], a
	call Multiply
; Push the absolute value of hte quadratic term to the stack
	ldh a, [hProduct + 1]
	push af
	ldh a, [hProduct + 2]
	push af
	ldh a, [hProduct + 3]
	push af
	ld a, [hli]
	push af
; Multiply the level by d
	xor a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	ld a, d
	ldh [hMultiplicand + 2], a
	ld a, [hli]
	ldh [hMultiplier], a
	call Multiply
; Subtract e
	ld b, [hl]
	ldh a, [hProduct + 3]
	sub b
	ldh [hMultiplicand + 2], a
	ld b, 0
	ldh a, [hProduct + 2]
	sbc b
	ldh [hMultiplicand + 1], a
	ldh a, [hProduct + 1]
	sbc b
	ldh [hMultiplicand], a
; If bit 7 of c is set, c is negative; otherwise, it's positive
	pop af
	and $80
	jr nz, .subtract
; Add c*n**2 to (d*n - e)
	pop bc
	ldh a, [hProduct + 3]
	add b
	ldh [hMultiplicand + 2], a
	pop bc
	ldh a, [hProduct + 2]
	adc b
	ldh [hMultiplicand + 1], a
	pop bc
	ldh a, [hProduct + 1]
	adc b
	ldh [hMultiplicand], a
	jr .done_quadratic

.subtract
; Subtract c*n**2 from (d*n - e)
	pop bc
	ldh a, [hProduct + 3]
	sub b
	ldh [hMultiplicand + 2], a
	pop bc
	ldh a, [hProduct + 2]
	sbc b
	ldh [hMultiplicand + 1], a
	pop bc
	ldh a, [hProduct + 1]
	sbc b
	ldh [hMultiplicand], a

.done_quadratic
; Add (a/b)*n**3 to (d*n - e +/- c*n**2)
	pop bc
	ldh a, [hProduct + 3]
	add b
	ldh [hMultiplicand + 2], a
	pop bc
	ldh a, [hProduct + 2]
	adc b
	ldh [hMultiplicand + 1], a
	pop bc
	ldh a, [hProduct + 1]
	adc b
	ldh [hMultiplicand], a
	ret

.LevelSquared::
	xor a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	ld a, d
	ldh [hMultiplicand + 2], a
	ldh [hMultiplier], a
	jp Multiply

MACRO growth_rate
; [1]/[2]*n**3 + [3]*n**2 + [4]*n - [5]
	dn \1, \2
	if \3 < 0
		db -\3 | $80 ; signed magnitude
	else
		db \3
	endc
	db \4, \5
ENDM

GrowthRates:
; entries correspond to GROWTH_* (see constants/pokemon_data_constants.asm)
	growth_rate 1, 1,   0,   0,   0 ; Medium Fast
	growth_rate 3, 4,  10,   0,  30 ; Slightly Fast
	growth_rate 3, 4,  20,   0,  70 ; Slightly Slow
	growth_rate 6, 5, -15, 100, 140 ; Medium Slow
	growth_rate 4, 5,   0,   0,   0 ; Fast
	growth_rate 5, 4,   0,   0,   0 ; Slow

_SwitchPartyMons::
	; replace instances of wHPBarOldHP with wcdc5, perhaps?
	ld a, [wSelectedSwapPosition]
	dec a
	ld [wHPBarOldHP], a
	ld b, a
	ld a, [wMenuCursorY]
	dec a
	ld [wcdc4], a
	cp b
	jr z, .skip
	call .SwapMonAndMail
	ld a, [wcdc5]
	call .ClearSprite
	ld a, [wcdc4]
	call .ClearSprite
.skip
	ret

.ClearSprite:
	push af
	hlcoord 0, 0
	ld bc, 2 * SCREEN_WIDTH
	call AddNTimes
	ld bc, 2 * SCREEN_WIDTH
	ld a, '　'
	call ByteFill
	pop af
	ld hl, wShadowOAMSprite00
	ld bc, 4 * SPRITEOAMSTRUCT_LENGTH
	call AddNTimes
	ld de, SPRITEOAMSTRUCT_LENGTH
	ld c, 4
.gfx_loop
	ld [hl], OAM_YCOORD_HIDDEN
	add hl, de
	dec c
	jr nz, .gfx_loop
	ld de, SFX_SWITCH_POKEMON
	call WaitPlaySFX
	ret

.SwapMonAndMail::
	push hl
	push de
	push bc
	ld bc, wPartySpecies
	ld a, [wcdc4]
	ld l, a
	ld h, 0
	add hl, bc
	ld d, h
	ld e, l
	ld a, [wcdc5]
	ld l, a
	ld h, 0
	add hl, bc
	ld a, [hl]
	push af
	ld a, [de]
	ld [hl], a
	pop af
	ld [de], a
	ld a, [wcdc4]
	ld hl, wPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	push hl
	ld de, wcc3a
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes
	ld a, [wcdc5]
	ld hl, wPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	pop de
	push hl
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes
	pop de
	ld hl, wcc3a
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes
	ld a, [wcdc4]
	ld hl, wPartyMonOTs
	call SkipNames
	push hl
	call .CopyNameToSwitchMonBuffer
	ld a, [wcdc5]
	ld hl, wPartyMonOTs
	call SkipNames
	pop de
	push hl
	call .CopyName
	pop de
	ld hl, wcc3a
	call .CopyName
	ld hl, wPartyMonNicknames
	ld a, [wcdc4]
	call SkipNames
	push hl
	call .CopyNameToSwitchMonBuffer
	ld hl, wPartyMonNicknames
	ld a, [wcdc5]
	call SkipNames
	pop de
	push hl
	call .CopyName
	pop de
	ld hl, wcc3a
	call .CopyName
	ld hl, $ba68    ; Buffer somewhere in SRAM. Needs investigation
	ld a, [wcdc4]
	ld bc, $0028    ; todo: Constantify this
	call AddNTimes
	push hl
	ld de, wcc3a
	ld bc, $0028
	ld a, $02
	call OpenSRAM
	call CopyBytes
	ld hl, $ba68
	ld a, [wcdc5]
	ld bc, $0028
	call AddNTimes
	pop de
	push hl
	ld bc, $0028
	call CopyBytes
	pop de
	ld hl, wcc3a
	ld bc, $0028
	call CopyBytes
	call CloseSRAM
	pop bc
	pop de
	pop hl
	ret

.CopyNameToSwitchMonBuffer
	ld de, wcc3a

.CopyName
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes
	ret

PartyMenu_ClearCursor::
	hlcoord 0, 1
	ld bc, 2 * SCREEN_WIDTH
	ld a, PARTY_LENGTH
.next
	ld [hl], '　'
	add hl, bc
	dec a
	jr nz, .next
	ret

GetUnownLetter::
; Return Unown letter in wUnownLetter based on DVs at hl

; Take the middle 2 bits of each DV and place them in order:
;	atk  def  spd  spc
;	.ww..xx.  .yy..zz.

	; atk
	ld a, [hl]
	and %01100000
	sla a
	ld b, a
	; def
	ld a, [hli]
	and %00000110
	swap a
	srl a
	or b
	ld b, a

	; spd
	ld a, [hl]
	and %01100000
	swap a
	sla a
	or b
	ld b, a
	; spc
	ld a, [hl]
	and %00000110
	srl a
	or b

; Divide by 10 to get 0-25
	ldh [hDividend + 3], a
	xor a
	ldh [hDividend], a
	ldh [hDividend + 1], a
	ldh [hDividend + 2], a
	ld a, $0a
	ldh [hDivisor], a
	ld b, 4
	call Divide

; Increment to get 1-26
	ldh a, [hQuotient + 3]
	inc a
	ld [wAnnonID], a
	ret
