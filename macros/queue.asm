queue_ab: MACRO
	ld hl, \1
	ldh a, [hROMBank]
	call QueueScript
ENDM

queue_ba: MACRO
	ldh a, [hROMBank]
	ld hl, \1
	call QueueScript
ENDM

far_queue: MACRO
	ld hl, \1
	ld a, BANK(\1)
	call QueueScript
ENDM