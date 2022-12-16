MACRO queue_ab
	ld hl, \1
	ldh a, [hROMBank]
	call QueueScript
ENDM

MACRO queue_ba
	ldh a, [hROMBank]
	ld hl, \1
	call QueueScript
ENDM

MACRO far_queue
	ld hl, \1
	ld a, BANK(\1)
	call QueueScript
ENDM
