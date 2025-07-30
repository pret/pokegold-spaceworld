INCLUDE "constants.asm"

SECTION "engine/pokemon/move_mon.asm", ROMX

TryAddMonToParty::
; Check if to copy wild mon or generate a new one
	; Whose is it?
	ld de, wPartyCount
	ld a, [wMonType]
	and $f
	jr z, .getpartylocation ; PARTYMON
	ld de, wOTPartyCount

.getpartylocation
	; Do we have room for it?
	ld a, [de]
	inc a
	cp PARTY_LENGTH + 1
	ret nc
	; Increase the party count
	ld [de], a
	ld a, [de] ; Why are we doing this?
	ldh [hMoveMon], a ; HRAM backup
	add e
	ld e, a
	jr nc, .loadspecies
	inc d

.loadspecies
	; Load the species of the Pokemon into the party list.
	; The terminator is usually here, but it'll be back.
	ld a, [wCurPartySpecies]
	ld [de], a
	; Load the terminator into the next slot.
	inc de
	ld a, -1
	ld [de], a
	; Now let's load the OT name.
	ld hl, wPartyMonOTs
	ld a, [wMonType]
	and $f
	jr z, .loadOTname
	ld hl, wOTPartyMonOT

.loadOTname
	ldh a, [hMoveMon] ; Restore index from backup
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wPlayerName
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes
	; Only initialize the nickname for party mon
	ld a, [wMonType]
	and a
	jr nz, .skipnickname
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, wPartyMonNicknames
	ldh a, [hMoveMon]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes

.skipnickname
	ld hl, wPartyMon1
	ld a, [wMonType]
	and $f
	jr z, .initializeStats
	ld hl, wOTPartyMons

.initializeStats
	ldh a, [hMoveMon]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld e, l
	ld d, h
	push hl
	; Initialize the species
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld a, [wMonHIndex]
	ld [de], a
	inc de

	; Copy the item if it's a wild mon
	ld a, [wBattleMode]
	and a
	jr z, .skipitem
	ld a, [wEnemyMonItem]
	ld [de], a
.skipitem
	inc de

	; Copy the moves if it's a wild mon
	push de
	xor a
	ld [wFieldMoveScriptID], a
	predef FillMoves
	pop de
rept NUM_MOVES
	inc de
endr

	; Initialize ID.
	ld a, [wPlayerID]
	ld [de], a
	inc de
	ld a, [wPlayerID + 1]
	ld [de], a
	inc de

	; Initialize Exp.
	push de
	ld a, [wCurPartyLevel]
	ld d, a
	callfar CalcExpAtLevel
	pop de
	ldh a, [hProduct + 1]
	ld [de], a
	inc de
	ldh a, [hProduct + 2]
	ld [de], a
	inc de
	ldh a, [hProduct + 3]
	ld [de], a
	inc de

	; Initialize stat experience.
	xor a
	ld b, MON_DVS - MON_STAT_EXP

.loop
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	pop hl
	push hl
	ld a, [wMonType]
	and $f
	ln a, 9, 8
	ln b, 8, 8
	jr nz, .initializeDVs

; Check if mon is caught
	ld a, [wCurPartySpecies]
	ld [wTempSpecies], a
	dec a
	ld c, a
	ld b, CHECK_FLAG
	ld hl, wPokedexCaught
	push de
	ld d, 3
	call SmallFarFlagAction
	pop de

; Set the mon's caught and seen flags
	ld a, c
	ld a, [wTempSpecies]
	dec a
	ld c, a
	ld b, SET_FLAG
	push bc
	call SmallFarFlagAction
	pop bc
	ld hl, wPokedexSeen
	call SmallFarFlagAction
	pop hl
	push hl
	ld a, [wBattleMode]
	and a
	jr nz, .copywildmonDVs
	call Random
	ld b, a
	call Random
.initializeDVs
	ld [de], a
	inc de
	ld a, b
	ld [de], a
	inc de

	; Initialize PP.
	push hl
	push de
	inc hl
	inc hl
	call FillPP
	pop de
	pop hl
rept NUM_MOVES
	inc de
endr

	; Initialize happiness.
	ld a, BASE_HAPPINESS
	ld [de], a
	inc de

	; Doesn't initialize these three values whatsoever. (Unused1 - Unused3)
	inc de
	inc de
	inc de

	; Initialize level.
	ld a, [wCurPartyLevel]
	ld [de], a
	inc de

	xor a
	; Status
	ld [de], a
	inc de
	; Unused
	ld [de], a
	inc de

	; Initialize HP.
	ld bc, MON_STAT_EXP - 1
	add hl, bc
	ld a, 1
	ld c, a
	xor a ; FALSE
	ld b, a
	call CalcMonStatC
	ldh a, [hProduct + 2]
	ld [de], a
	inc de
	ldh a, [hProduct + 3]
	ld [de], a
	inc de
	jr .initstats

.copywildmonDVs
	ld a, [wEnemyMonDVs]
	ld [de], a
	inc de
	ld a, [wEnemyMonDVs + 1]
	ld [de], a
	inc de

	push hl
	ld hl, wEnemyMonPP
	ld b, NUM_MOVES
.wildmonpploop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .wildmonpploop
	pop hl

	; Initialize happiness.
	ld a, BASE_HAPPINESS
	ld [de], a
	inc de

	; Doesn't initialize these three values whatsoever. (Unused1 - Unused3)
	inc de
	inc de
	inc de

	; Initialize level.
	ld a, [wCurPartyLevel]
	ld [de], a
	inc de

	ld a, [wEnemyMonStatus]
	; Copy wEnemyMonStatus
	ld [de], a
	inc de
	ld a, [wEnemyMonStatus + 1]
	; Copy EnemyMonUnused
	ld [de], a
	inc de
	; Copy wEnemyMonHP
	ld a, [wEnemyMonHP]
	ld [de], a
	inc de
	ld a, [wEnemyMonHP + 1]
	ld [de], a
	inc de

.initstats
	ld a, [wBattleMode]
	dec a
	jr nz, .generatestats
	ld hl, wEnemyMonMaxHP
	ld bc, PARTYMON_STRUCT_LENGTH - MON_MAXHP
	call CopyBytes
	pop hl
	jr .done

.generatestats
	pop hl
	ld bc, MON_STAT_EXP - 1
	add hl, bc
	ld b, FALSE
	call CalcMonStats
.done
	scf
	ret

FillPP::
	ld b, NUM_MOVES
.loop
	ld a, [hli]
	and a
	jr z, .next
	dec a
	push hl
	push de
	push bc
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wStringBuffer1
	ld a, BANK(Moves)
	call FarCopyBytes
	pop bc
	pop de
	pop hl
	ld a, [wStringBuffer1 + MOVE_PP]
.next
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	ret


AddTempmonToParty:
	ld hl, wPartyCount
	ld a, [hl]
	cp PARTY_LENGTH
	scf
	ret z

	inc a
	ld [hl], a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wCurPartySpecies]
	ld [hli], a
	ld [hl], $ff

	ld hl, wPartyMon1Species
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld e, l
	ld d, h
	ld hl, wTempMonSpecies
	call CopyBytes

	ld hl, wPartyMonOTs
	ld a, [wPartyCount]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wOTPartyMonOT
	ld a, [wCurPartyMon]
	call SkipNames
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wOTPartyMonNicknames
	ld a, [wCurPartyMon]
	call SkipNames
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndexBuffer], a
	dec a
	ld c, a
	ld b, SET_FLAG
	ld hl, wPokedexCaught
	push bc
	call SmallFarFlagAction
	pop bc
	ld hl, wPokedexSeen
	call SmallFarFlagAction
	and a
	ret

; Sents/Gets mon into/from Box depending on Parameter.
; wPokemonWithdrawDepositParameter == 0: get mon into Party.
; wPokemonWithdrawDepositParameter == 1: sent mon into Box.
; wPokemonWithdrawDepositParameter == 2: get mon from wBufferMon into Party.
; wPokemonWithdrawDepositParameter == 3: put mon into wBufferMon.
SendGetMonIntoFromBox::
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .check_IfPartyIsFull
	cp BUFFERMON_WITHDRAW
	jr z, .check_IfPartyIsFull
	cp BUFFERMON_DEPOSIT
	ld hl, wBufferMon
	jr z, .buffermon

	; we want to sent a mon into the Box
	; so check if there's enough space
	ld hl, wBoxCount
	ld a, [hl]
	cp MONS_PER_BOX
	jr nz, .there_is_room
	jr .full
	
.check_IfPartyIsFull
	ld hl, wPartyCount
	ld a, [hl]
	cp PARTY_LENGTH
	jr nz, .there_is_room

.full
	scf
	ret
.there_is_room
	inc a
	ld [hl], a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wPokemonWithdrawDepositParameter]
	cp BUFFERMON_WITHDRAW
	ld a, [wBufferMonSpecies]
	jr z, .okay1
	ld a, [wCurPartySpecies]

.okay1
	ld [hli], a
	ld [hl], -1
	ld a, [wPokemonWithdrawDepositParameter]
	dec a
	ld hl, wPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wPartyCount]
	jr nz, .okay2
	ld hl, wBoxMon1
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, [wBoxCount]

.okay2
	dec a ; wPartyCount - 1
	call AddNTimes
.buffermon
	push hl
	ld e, l
	ld d, h
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	ld hl, wBoxMon1
	ld bc, BOXMON_STRUCT_LENGTH
	jr z, .okay3
	cp BUFFERMON_WITHDRAW
	ld hl, wBufferMon
	jr z, .okay4
	ld hl, wPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH

.okay3
	ld a, [wCurPartyMon]
	call AddNTimes

.okay4
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes
	ld a, [wPokemonWithdrawDepositParameter]
	cp BUFFERMON_DEPOSIT
	ld de, wBufferMonOT
	jr z, .okay5
	dec a
	ld hl, wPartyMonOTs
	ld a, [wPartyCount]
	jr nz, .okay6
	ld hl, wBoxMonOTs
	ld a, [wBoxCount]

.okay6
	dec a
	call SkipNames
	ld d, h
	ld e, l

.okay5
	ld hl, wBoxMonOTs
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .okay7
	ld hl, wBufferMonOT
	cp BUFFERMON_WITHDRAW
	jr z, .okay8
	ld hl, wPartyMonOTs

.okay7
	ld a, [wCurPartyMon]
	call SkipNames

.okay8
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes
	ld a, [wPokemonWithdrawDepositParameter]
	cp BUFFERMON_DEPOSIT
	ld de, wBufferMonNickname
	jr z, .okay9
	dec a
	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	jr nz, .okay10
	ld hl, wBoxMonNicknames
	ld a, [wBoxCount]

.okay10
	dec a
	call SkipNames
	ld d, h
	ld e, l

.okay9
	ld hl, wBoxMonNicknames
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .okay11
	ld hl, wBufferMonNickname
	cp BUFFERMON_WITHDRAW
	jr z, .okay12
	ld hl, wPartyMonNicknames

.okay11
	ld a, [wCurPartyMon]
	call SkipNames
.okay12
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	pop hl

	ld a, [wPokemonWithdrawDepositParameter]
	cp PC_DEPOSIT
	jr z, .done_clear_carry
	cp BUFFERMON_DEPOSIT
	jr z, .done_clear_carry

	push hl
	srl a
	add $2
	ld [wMonType], a
	predef CopyMonToTempMon
	farcall CalcLevel
	ld a, d
	ld [wCurPartyLevel], a
	pop hl
	ld b, h
	ld c, l
	ld hl, MON_LEVEL
	add hl, bc
	ld [hl], a
	ld hl, MON_MAXHP
	add hl, bc
	ld d, h
	ld e, l
	ld hl, MON_STAT_EXP - 1
	add hl, bc

	push bc
	ld b, TRUE
	call CalcMonStats
	pop bc

	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr nz, .done_clear_carry
	ld hl, MON_HP
	add hl, bc
	ld d, h
	ld e, l
	inc hl
	inc hl
	ld a, [hli]
	ld [de], a
	ld a, [hl]
	inc de
	ld [de], a
.done_clear_carry
	and a
	ret

; TODO: Might not be for breedmon?
RetrieveBreedmonOrBuffermon:
	ld hl, wPartyCount
	ld a, [hl]
	cp PARTY_LENGTH
	push af
	jr nz, .room_in_party_or_box
	ld hl, wBoxCount
	ld a, [hl]
	cp MONS_PER_BOX
	jr nz, .room_in_party_or_box
	pop af
	scf
	ret

.room_in_party_or_box
	inc a
	ld [hl], a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	ld a, [wBufferMonSpecies]
	ld de, wBufferMonNickname
	jr z, .okay ; unused in practice

	ld a, [wBreedMon1Species]
	ld de, wBreedMon1Nickname

.okay
	ld [hli], a
	ld [wCurSpecies], a
	ld a, -1
	ld [hl], a
	pop af ; if wPartyCount = PARTY_LENGTH
	jr z, .party_full

	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	dec a
	ld bc, MON_NAME_LENGTH
	call AddNTimes
	push hl
	ld h, d
	ld l, e
	pop de
	call CopyBytes
	push hl

	ld hl, wPartyMonOTs
	ld a, [wPartyCount]
	dec a
	ld bc, PLAYER_NAME_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	call CopyBytes
	push hl

	ld hl, wPartyMons
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes
	call GetBaseData

	ld h, d
	ld l, e
	dec hl
	ld a, [hl]
	ld [wCurPartyLevel], a
	inc de
	inc de
	push de
	inc de
	inc de
	push de
	ld bc, -(BOXMON_STRUCT_LENGTH - MON_STAT_EXP)
	add hl, bc
	ld b, TRUE
	call CalcMonStats
	pop hl
	pop de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	jr .done

.party_full
	ld hl, wBoxMonNicknames
	ld a, [wBoxCount]
	ld bc, MON_NAME_LENGTH
	call AddNTimes
	push hl
	ld h, d
	ld l, e
	pop de
	call CopyBytes
	push hl

	ld hl, wBoxMonOTs
	ld a, [wBoxCount]
	ld bc, PLAYER_NAME_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	call CopyBytes
	push hl
	
	ld hl, wBoxMons
	ld a, [wBoxCount]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes

.done
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	ret z
	ld hl, wBreedMon2Nickname
	ld de, wBreedMon1Nickname
	ld bc, MON_NAME_LENGTH + PLAYER_NAME_LENGTH + BOXMON_STRUCT_LENGTH
	call CopyBytes
	and a
	ret

DepositBreedmonOrBuffermon::
	ld a, [wPokemonWithdrawDepositParameter]
	ld de, wBufferMonNickname
	and a
	jr z, .buffer_mon

	ld hl, wBreedMon1Nickname
	ld de, wBreedMon2Nickname
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	ld hl, wBreedMon1OT
	ld de, wBreedMon2OT
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes

	ld hl, wBreedMon1
	ld de, wBreedMon2
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes
	ld de, wBreedMon1Nickname

.buffer_mon
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call AddNTimes
	call CopyBytes

	ld a, [wCurPartyMon]
	ld hl, wPartyMonOTs
	ld bc, PLAYER_NAME_LENGTH
	call AddNTimes
	call CopyBytes

	ld a, [wCurPartyMon]
	ld hl, wPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld bc, BOXMON_STRUCT_LENGTH
	jp CopyBytes

; Sends the mon into one of ???'s Boxes.
; The data comes mainly from 'wEnemyMon'.
SendMonIntoBox::
	ld de, wBoxCount
	ld a, [de]
	cp MONS_PER_BOX
	ret nc
	inc a
	ld [de], a

	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld c, a
.loop
	inc de ; wBoxSpecies
	ld a, [de]
	ld b, a
	ld a, c
	ld c, b
	ld [de], a
	cp -1
	jr nz, .loop

	call GetBaseData
	ld hl, wBoxMonOTs
	ld bc, PLAYER_NAME_LENGTH
	ld a, [wBoxCount]
	dec a
	jr z, .copy_ot
	dec a
	call AddNTimes
	push hl

	ld bc, PLAYER_NAME_LENGTH
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wBoxCount]
	dec a
	ld b, a

.shift_mon_ot
	push bc
	push hl
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes
	pop hl
	ld d, h
	ld e, l
	ld bc, -(PLAYER_NAME_LENGTH)
	add hl, bc
	pop bc
	dec b
	jr nz, .shift_mon_ot

.copy_ot
	ld hl, wPlayerName
	ld de, wBoxMonOTs
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes

	ld a, [wBoxCount]
	dec a
	jr z, .copy_nickname

	ld hl, wBoxMonNicknames
	ld bc, MON_NAME_LENGTH
	dec a
	call AddNTimes
	push hl

	ld bc, MON_NAME_LENGTH
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wBoxCount]
	dec a
	ld b, a

.shift_loop_mon_name
	push bc
	push hl
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	pop hl
	ld d, h
	ld e, l
	ld bc, -(MON_NAME_LENGTH)
	add hl, bc
	pop bc
	dec b
	jr nz, .shift_loop_mon_name

.copy_nickname
	ld a, [wCurPartySpecies]
	ld [wTempSpecies], a
	call GetPokemonName
	ld de, wBoxMonNicknames
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	ld a, [wBoxCount]
	dec a
	jr z, .copy_boxmon

	ld hl, wBoxMon1
	ld bc, BOXMON_STRUCT_LENGTH
	dec a
	call AddNTimes
	push hl
	ld bc, BOXMON_STRUCT_LENGTH
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wBoxCount]
	dec a
	ld b, a

.shift_loop_boxmon
	push bc
	push hl
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes
	pop hl
	ld d, h
	ld e, l
	ld bc, -(BOXMON_STRUCT_LENGTH)
	add hl, bc
	pop bc
	dec b
	jr nz, .shift_loop_boxmon

.copy_boxmon
	ld hl, wEnemyMon
	ld de, wBoxMons
	ld bc, (wEnemyMonMovesEnd - wEnemyMon)
	call CopyBytes

	; Copy player ID
	ld hl, wPlayerID
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	push de

	; Get experience points
	ld a, [wCurPartyLevel]
	ld d, a
	callfar CalcExpAtLevel
	pop de
	ldh a, [hProduct + 1]
	ld [de], a
	inc de
	ldh a, [hProduct + 2]
	ld [de], a
	inc de
	ldh a, [hProduct + 3]
	ld [de], a
	inc de
	xor a
	ld b, (NUM_EXP_STATS * 2)
.skip_stat_exp
	ld [de], a
	inc de
	dec b
	jr nz, .skip_stat_exp
	ld hl, wEnemyMonDVs
	ld b, (wBoxMon1Happiness - wBoxMon1DVs) + 1
.copy_dvs_pp_happiness
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copy_dvs_pp_happiness

	xor a
	ld [de], a
	inc de
	ld [de], a
	inc de
	ld [de], a
	inc de
	ld a, [wCurPartyLevel]
	ld [de], a
	scf
	ret

; Generates a hybrid of the most recently deposited BreedMon and DEX_EGG.
GiveEgg::
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr z, .party_full
	call TryAddMonToParty
	ld de, wPartyMonNicknames
	ld hl, wPartyCount
	jr .next

.party_full
	ld a, [wBoxCount]
	cp MONS_PER_BOX
	scf
	ret z
	ld a, [wCurPartySpecies]
	ld [wTempEnemyMonSpecies], a
	xor a
	ld [wEnemySubStatus5], a ; ???
	callfar LoadEnemyMon
	call SendMonIntoBox
	ld de, wBoxMonNicknames
	ld hl, wBoxCount

.next
	ld a, [hl]
	push af
	ld b, 0
	ld c, a
	add hl, bc
	ld a, DEX_EGG
	ld [hl], a
	pop af

	dec a
	ld h, d
	ld l, e
	ld bc, MON_NAME_LENGTH
	call AddNTimes

; Print "EGG" as its name
	ld a, "た"
	ld [hli], a
	ld a, "ま"
	ld [hli], a
	ld a, "ご"
	ld [hli], a
	ld [hl], "@"
	and a
	ret

RemoveMonFromPartyOrBox:
	ld hl, wPartyCount

	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .okay

	ld hl, wBoxCount

.okay
	ld a, [hl]
	dec a
	ld [hli], a
	ld a, [wCurPartyMon]
	ld c, a
	ld b, 0
	add hl, bc
	ld e, l
	ld d, h
	inc de
.loop
	ld a, [de]
	inc de
	ld [hli], a
	inc a
	jr nz, .loop
	ld hl, wPartyMonOTs
	ld d, PARTY_LENGTH - 1
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .party
	ld hl, wBoxMonOTs
	ld d, MONS_PER_BOX - 1

.party
	; If this is the last mon in our party (box),
	; shift all the other mons up to close the gap.
	ld a, [wCurPartyMon]
	call SkipNames
	ld a, [wCurPartyMon]
	cp d
	jr nz, .delete_inside
	ld [hl], -1
	ret

.delete_inside
	; Shift the OT names
	ld d, h
	ld e, l
	ld bc, MON_NAME_LENGTH
	add hl, bc
	ld bc, wPartyMonNicknames
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .party2
	ld bc, wBoxMonNicknames
.party2
	call CopyDataUntil
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .party3
	ld hl, wBoxMons
	ld bc, BOXMON_STRUCT_LENGTH
.party3
	ld a, [wCurPartyMon]
	call AddNTimes
	ld d, h
	ld e, l
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .party4
	ld bc, BOXMON_STRUCT_LENGTH
	add hl, bc
	ld bc, wBoxMonOTs
	jr .copy

.party4
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	ld bc, wPartyMonOTs
.copy
	call CopyDataUntil
	ld hl, wPartyMonNicknames
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .party5
	ld hl, wBoxMonNicknames
.party5
	ld bc, MON_NAME_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld d, h
	ld e, l
	ld bc, MON_NAME_LENGTH
	add hl, bc
	ld bc, wPartyMonNicknamesEnd
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .party6
	ld bc, wBoxMonNicknamesEnd
.party6
	jp CopyDataUntil

CalcMonStats::
	ld c, $00
.loop
	inc c
	call CalcMonStatC
	ldh a, [hProduct + 2]
	ld [de], a
	inc de
	ldh a, [hProduct + 3]
	ld [de], a
	inc de
	ld a, c
	cp STAT_SDEF
	jr nz, .loop
	ret

CalcMonStatC::
; 'c' is 1-6 and points to the BaseStat
; 1: HP
; 2: Attack
; 3: Defense
; 4: Speed
; 5: SpAtk
; 6: SpDef
	push hl
	push de
	push bc
	ld a, b
	ld d, a

	push hl
	ld hl, wMonHBaseStats
	dec hl
	ld b, $0
	add hl, bc
	ld a, [hl]
	ld e, a
	pop hl
	push hl
	ld a, c
; Special defense shares stat exp with special attack
	cp STAT_SDEF
	jr nz, .not_spdef
	dec hl
	dec hl
	
.not_spdef
	sla c
	ld a, d
	and a
	jr z, .no_stat_exp
	add hl, bc

.sqrt_loop
	xor a
	ldh [hMultiplicand], a
	ldh [hMultiplicand + 1], a
	inc b
	ld a, b
	cp -1
	jr z, .no_stat_exp

	ldh [hMultiplicand + 2], a
	ldh [hMultiplier], a
	call Multiply

	ld a, [hld]
	ld d, a
	ldh a, [hProduct + 3]
	sub d
	ld a, [hli]
	ld d, a
	ldh a, [hProduct + 2]
	sbc d
	jr c, .sqrt_loop

.no_stat_exp
	srl c
	pop hl
	push bc
	ld bc, MON_DVS - MON_HP_EXP + 1
	add hl, bc
	pop bc
	ld a, c
	cp STAT_ATK
	jr z, .Attack
	cp STAT_DEF
	jr z, .Defense
	cp STAT_SPD
	jr z, .Speed
	cp STAT_SATK
	jr z, .Special
	cp STAT_SDEF
	jr z, .Special
; DV_HP = (DV_ATK & 1) << 3 | (DV_DEF & 1) << 2 | (DV_SPD & 1) << 1 | (DV_SPC & 1)
	push bc
	ld a, [hl]
	swap a
	and $01
	add a
	add a
	add a
	ld b, a
	ld a, [hli]
	and $01
	add a
	add a
	add b
	ld b, a
	ld a, [hl]
	swap a
	and $01
	add b
	add b
	ld b, a
	ld a, [hl]
	and $01
	add b
	pop bc
	jr .GotDV

.Attack
	ld a, [hl]
	swap a
	and $f
	jr .GotDV

.Defense
	ld a, [hl]
	and $f
	jr .GotDV

.Speed
	inc hl
	ld a, [hl]
	swap a
	and $f
	jr .GotDV

.Special
	inc hl
	ld a, [hl]
	and $f

.GotDV
	ld d, $00
	add e
	ld e, a
	jr nc, .no_overflow_1
	inc d

.no_overflow_1
	sla e
	rl d
	srl b
	srl b
	ld a, b
	add e
	jr nc, .no_overflow_2
	inc d
	
.no_overflow_2
	ldh [hMultiplicand + 2], a
	ld a, d
	ldh [hMultiplicand + 1], a
	xor a
	ldh [hMultiplicand], a
	ld a, [wCurPartyLevel]
	ldh [hMultiplier], a
	call Multiply

	ldh a, [hProduct + 1]
	ldh [hDividend], a
	ldh a, [hMultiplicand + 1]
	ldh [hDividend + 1], a
	ldh a, [hMultiplicand + 2]
	ldh [hDividend + 2], a
	ld a, MAX_LEVEL
	ldh [hDivisor], a
	ld a, 3
	ld b, a
	call Divide

	ld a, c
	cp STAT_HP
	ld a, STAT_MIN_NORMAL
	jr nz, .not_hp
	ld a, [wCurPartyLevel]
	ld b, a
	ldh a, [hDividend+3]
	add b
	ldh [hDividend+3], a
	jr nc, .no_overflow_3
	ldh a, [hDividend+2]
	inc a
	ldh [hDividend+2], a

.no_overflow_3
	ld a, STAT_MIN_HP

.not_hp
	ld b, a
	ldh a, [hDividend+3]
	add b
	ldh [hDividend+3], a
	jr nc, .no_overflow_4
	ldh a, [hDividend+2]
	inc a
	ldh [hDividend+2], a

.no_overflow_4
	ldh a, [hDividend+2]
	cp HIGH(MAX_STAT_VALUE + 1) + 1
	jr nc, .max_stat
	cp HIGH(MAX_STAT_VALUE + 1)
	jr c, .stat_value_okay
	ldh a, [hDividend+3]
	cp LOW(MAX_STAT_VALUE + 1)
	jr c, .stat_value_okay

.max_stat
	ld a, HIGH(MAX_STAT_VALUE)
	ldh [hDividend+2], a
	ld a, LOW(MAX_STAT_VALUE)
	ldh [hDividend+3], a

.stat_value_okay
	pop bc
	pop de
	pop hl
	ret

GivePoke::
	ld a, [wCurPartySpecies]
	dec a
	ld c, a
	ld d, 0
	ld hl, wPokedexCaught
	ld b, CHECK_FLAG
	predef SmallFarFlagAction

	push bc
	xor a ; PARTYMON
	ld [wMonType], a
	call TryAddMonToParty
	jr nc, .party_full
	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	dec a
	ld bc, MON_NAME_LENGTH
	call AddNTimes

	ld d, h
	ld e, l
	pop bc
	ld a, c
	ld b, 0
	push bc
	push de
	jr .give_mon_success

.party_full
	call SendMonIntoBox
	pop bc
	jp nc, .give_mon_failure
	ld a, c
	ld de, wBoxMonNicknames
	ld b, 1
	push bc
	push de
.give_mon_success
	push af
	ld a, [wCurPartySpecies]
	ld [wTempSpecies], a
	call GetPokemonName
	pop af
	and a
	jr nz, .skip_pokedex

	ld hl, wd41c
	bit 4, [hl] ; flag for obtaining the pokedex
	jr z, .skip_pokedex

	ld hl, NewDexDataText
	call PrintText
	call ClearSprites
	ld a, [wCurPartySpecies]
	ld [wTempSpecies], a
	predef NewPokedexEntry
	call LoadTilesetGFX_LCDOff
.skip_pokedex
	ld hl, GotItText
	call PrintText
	call YesNoBox
	pop de
	jr c, .done

	push de
	ld b, NAME_MON
	farcall NamingScreen
	pop de
	ld a, [de]
	cp "@"
	jr nz, .not_empty

	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes
.not_empty
	call ClearBGPalettes
	ld hl, wSpriteFlags
	ld a, [hl]
	push af
	res SPRITES_SKIP_STANDING_GFX_F, [hl]
	set SPRITES_SKIP_WALKING_GFX_F, [hl]
	call RedrawPlayerSprite
	pop af
	ld [wSpriteFlags], a
	call LoadFontExtra
	call LoadMapPart
	call GetMemSGBLayout
	call WaitBGMap
	call GBFadeInFromWhite
.done
	pop bc
	ld a, b
	and a
	ret z
	ld hl, WasSentToBillsPCText
	ld hl, WasSentToSomeonesPCText
	call PrintText
	ld b, 1
	ret

.give_mon_failure
	ld b, 2
	ret

WasSentToBillsPCText:
	text_from_ram wStringBuffer1
	text "は　マサキの　ところへ"
	line "てんそうされた！"
	prompt

WasSentToSomeonesPCText:
	text_from_ram wStringBuffer1
	text "は　だれかの　<PC>に" ; "was transferred to"
	line "てんそうされた！" ; "Someone's PC!"
	prompt

NewDexDataText:
	text_from_ram wStringBuffer1
	text "の　データが　あたらしく" ; "New Dex data will"
	line "#ずかんに　セーブされます！@" ; "be added for (MON)!"
	sound_slot_machine_start
	text_waitbutton
	text_end

GotItText:
	text "ゲットした　@" ; "Got it!"

AskGiveNicknameText:
	text_from_ram wStringBuffer1
	text "に" ; "Would you like to"
	line "なまえを　つけますか？" ; "give it a name?"
	done
