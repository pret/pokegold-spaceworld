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
