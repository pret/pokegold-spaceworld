HealParty:
	ld hl, wPartySpecies
	ld de, wPartyMons

.party_loop
	ld a, [hli]
	cp -1
	jr z, .party_done
	push hl
	push de

; Clear the status
	ld hl, MON_STATUS
	add hl, de
	xor a
	ld [hli], a
	ld [hl], a

; Reset the PP
	ld hl, MON_MOVES
	add hl, de
	ld b, NUM_MOVES

.move_loop
	push hl
	push bc
	ld a, [hl]
	and a
	jr z, .next_move
	dec a
	push hl
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop hl
	ld bc, MON_PP - MON_MOVES
	add hl, bc
	ld b, a
	ld a, [hl]
	and PP_UP_MASK
	add b
	ld [hl], a

.next_move
	pop bc
	pop hl
	inc hl
	dec b
	jr nz, .move_loop

; Reset the HP
	pop de
	push de
	ld hl, MON_MAXHP
	add hl, de
	ld b, h
	ld c, l
	dec bc
	dec bc
	ld a, [hli]
	ld [bc], a
	inc bc
	ld a, [hl]
	ld [bc], a
	pop de
	pop hl
	push hl
	ld hl, PARTYMON_STRUCT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	pop hl
	jr .party_loop

.party_done
	xor a
	ld [wCurPartyMon], a
	ld [wTempSpecies], a
	ld a, [wPartyCount]
	ld b, a

.pp_up
	push bc
	call ApplyPPUp
	pop bc
	ld hl, wCurPartyMon
	inc [hl]
	dec b
	jr nz, .pp_up
	ret
