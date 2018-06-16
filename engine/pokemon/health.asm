INCLUDE "constants.asm"

SECTION "HealParty", ROMX[$4d6f], BANK[$03]

HealParty: ; 03:4d6f
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
	ld hl, MON_MAXHP - MON_HP ; TODO - This should point to the MOVES, not max HP...
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
	ld hl, Moves
	ld bc, MOVE_DATA_SIZE
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
	ld [wWhichPokemon], a
	ld [wce37], a
	ld a, [wPartyCount]
	ld b, a

.pp_up
	push bc
	call ApplyPPUp
	pop bc
	ld hl, wWhichPokemon
	inc [hl]
	dec b
	jr nz, .pp_up
	ret
	
SECTION "ComputeHPBarPixels", ROMX[$4e3c], BANK[$03]
	
ComputeHPBarPixels: ; 03:4e3c
	push hl
	xor a
	ldh [hMultiplicand], a
	ld a, b
	ldh [hMultiplicand + 1], a
	ld a, c
	ldh [hMultiplicand + 2], a
	ld a, 6 * 8
	ldh [hMultiplier], a
	call Multiply
	; We need de to be under 256 because hDivisor is only 1 byte.
	ld a, d
	and a
	jr z, .divide
	; divide de and hProduct by 4
	srl d
	rr e
	srl d
	rr e
	ldh a, [hProduct + 2]
	ld b, a
	ldh a, [hProduct + 3]
	srl b
	rr a
	srl b
	rr a
	ldh [hDividend + 3], a
	ld a, b
	ldh [hDividend + 2], a
.divide
	ld a, e
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 2]
	ld e, a
	pop hl
	and a
	ret nz
	ld e, 1
	ret