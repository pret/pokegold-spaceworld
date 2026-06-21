INCLUDE "constants.asm"

SECTION "engine/pokemon/mon_stats.asm", ROMX

DrawPlayerHP::
	ld a, $1
	jr DrawHP

DrawEnemyHP:
	ld a, $2

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

	ld a, '／'
	ld [hli], a

; Print max HP
	ld de, wTempMonMaxHP
	lb bc, 2, 3
	call PrintNumber
	pop hl
	pop de
	ret

INCLUDE "engine/pokemon/stats_screen.inc"

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
	ld de, SCREEN_WIDTH * 2
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
	ld a, [wListMovesLineSpacing]
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
	ld a, [wListMovesLineSpacing]
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

SECTION "engine/pokemon/mon_stats.asm@ListMoves", ROMX

ListMoves::
	ld de, wListMoves_MoveIndicesBuffer
	ld b, $00
.moves_loop
	ld a, [de]
	inc de
	and a
	jr z, .no_more_moves
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
	cp NUM_MOVES
	jr z, .done
	jr .moves_loop

.no_more_moves
	ld a, b
.nonmove_loop
	push af
	ld [hl], $e3
	ld a, [wHPBarMaxHP]
	ld c, a
	ld b, $00
	add hl, bc
	pop af
	inc a
	cp NUM_MOVES
	jr nz, .nonmove_loop
.done
	ret
