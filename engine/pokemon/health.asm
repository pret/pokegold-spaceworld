INCLUDE "constants.asm"

SECTION "engine/pokemon/health.asm@HealParty", ROMX

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

SECTION "engine/pokemon/health.asm@HP Bar", ROMX

ComputeHPBarPixels:
	push hl
	xor a
	ldh [hMultiplicand], a
	ld a, b
	ldh [hMultiplicand + 1], a
	ld a, c
	ldh [hMultiplicand + 2], a
	ld a, HP_BAR_LENGTH_PX
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

UpdateHPBar:
	ld a, [wHPBarOldHP]
	ld c, a
	ld a, [wHPBarOldHP + 1]
	ld b, a
	ld a, [wHPBarNewHP]
	ld e, a
	ld a, [wHPBarNewHP + 1]
	ld d, a
	push de
	push bc
	call UpdateHPBar_CalcHPDifference
	ld a, e
	ld [wHPBarHPDifference + 1], a
	ld a, d
	ld [wHPBarHPDifference], a
	pop bc
	pop de
	call UpdateHPBar_CompareNewHPToOldHP
	ret z
	ld a, -1
	jr c, .hp_decrease
	ld a, 1
.hp_decrease
	ld [wHPBarDelta], a
	ld a, [wHPBarNewHP]
	ld e, a
	ld a, [wHPBarNewHP + 1]
	ld d, a
.animate_hp_bar_loop
	push de
	ld a, [wHPBarOldHP]
	ld c, a
	ld a, [wHPBarOldHP + 1]
	ld b, a
	call UpdateHPBar_CompareNewHPToOldHP
	jr z, .animate_hp_bar_done
	jr nc, .hp_increase

;hp_decrease
	dec bc
	ld a, c
	ld [wHPBarNewHP], a
	ld a, b
	ld [wHPBarNewHP + 1], a
	call UpdateHPBar_CalcOldNewHPBarPixels
	ld a, e
	sub d
	jr .apply
.hp_increase
	inc bc
	ld a, c
	ld [wHPBarNewHP], a
	ld a, b
	ld [wHPBarNewHP + 1], a
	call UpdateHPBar_CalcOldNewHPBarPixels
	ld a, d
	sub e
.apply
	call UpdateHPBar_PrintHPNumber
	and a
	jr z, .no_pixel_difference
	call UpdateHPBar_AnimateHPBar
.no_pixel_difference
	ld a, [wHPBarNewHP]
	ld [wHPBarOldHP], a
	ld a, [wHPBarNewHP + 1]
	ld [wHPBarOldHP + 1], a
	pop de
	jr .animate_hp_bar_loop
.animate_hp_bar_done
	pop de
	ld a, e
	ld [wHPBarOldHP], a
	ld a, d
	ld [wHPBarOldHP + 1], a
	or e
	jr z, .mon_fainted
	call UpdateHPBar_CalcOldNewHPBarPixels
	ld d, e
.mon_fainted
	call UpdateHPBar_PrintHPNumber
	ld a, 1
	call UpdateHPBar_AnimateHPBar
	jp WaitBGMap

; animates the HP bar going up or down for (a) ticks (two waiting frames each)
; stops prematurely if bar is filled up
; e: current health (in pixels) to start with
UpdateHPBar_AnimateHPBar:
	push hl

.bar_animation_loop
	push af
	push de
	ld d, HP_BAR_LENGTH
	ld a, [wHPBarType]
	and BATTLE_HP_BAR
	ld b, a
	call DrawBattleHPBar
	ld c, 2
	call DelayFrames
	pop de
	ld a, [wHPBarDelta]
	add e
	cp HP_BAR_LENGTH_PX + 1
	jr nc, .bar_filled_up
	ld e, a
	pop af
	dec a
	jr nz, .bar_animation_loop
	pop hl
	ret
.bar_filled_up
	pop af
	pop hl
	ret

; compares old HP and new HP and sets c and z flags accordingly
UpdateHPBar_CompareNewHPToOldHP:
	ld a, d
	sub b
	ret nz
	ld a, e
	sub c
	ret

; calcs HP difference between bc and de (into de)
UpdateHPBar_CalcHPDifference:
	ld a, d
	sub b
	jr c, .old_hp_greater
	jr z, .test_lower_byte
.new_hp_greater
	ld a, e
	sub c
	ld e, a
	ld a, d
	sbc b
	ld d, a
	ret
.old_hp_greater
	ld a, c
	sub e
	ld e, a
	ld a, b
	sbc d
	ld d, a
	ret
.test_lower_byte
	ld a, e
	sub c
	jr c, .old_hp_greater
	jr nz, .new_hp_greater
	ld de, 0
	ret

UpdateHPBar_PrintHPNumber:
	push af
	push de
	ld a, [wHPBarType]
	and a
	jr z, .done
	ld a, [wHPBarOldHP]
	ld [wHPBarTempHP + 1], a
	ld a, [wHPBarOldHP + 1]
	ld [wHPBarTempHP], a
	push hl
	ld de, SCREEN_WIDTH + 1
	add hl, de
	push hl
	ld a, "　"
	ld [hli], a
	ld [hli], a
	ld [hli], a
	pop hl
	ld de, wHPBarTempHP
	lb bc, 2, 3
	call PrintNumber
	call DelayFrame
	pop hl
.done
	pop de
	pop af
	ret

; calcs number of HP bar pixels for old and new HP value
; d: new pixels
; e: old pixels
UpdateHPBar_CalcOldNewHPBarPixels:
	push hl
	ld hl, wHPBarMaxHP
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	push de
	call ComputeHPBarPixels
	ld a, e
	pop de
	pop bc
	push af
	call ComputeHPBarPixels
	pop af
	ld d, e
	ld e, a
	pop hl
	ret
