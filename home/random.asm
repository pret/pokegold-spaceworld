include "constants.asm"

if DEBUG
SECTION "Random Number Generation", ROM0 [$3270]
else
SECTION "Random Number Generation", ROM0 [$3234]
endc

Random::
	push bc
	ldh a, [rLY]
	ld c, a
	swap a
	ld b, a
	ldh a, [rDIV]
	adc b
	ld b, a
	ldh a, [hRandomAdd]
	adc b
	ldh [hRandomAdd], a
	ldh a, [rLY]
	swap a
	ld b, a
	ldh a, [rDIV]
	adc b
	adc c
	ld b, a
	ldh a, [hRandomSub]
	sbc b
	ldh [hRandomSub], a
	pop bc
	ret

BattleRandom::
	ldh a, [hROMBank]
	push af
	ld a, BANK(_BattleRandom)
	call Bankswitch
	call _BattleRandom
	ld [wPredefHL + 1], a
	pop af
	call Bankswitch
	ld a, [wPredefHL + 1]
	ret
