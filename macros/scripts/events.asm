;\1 = event index
MACRO CheckEvent
	DEF event_byte = ((\1) / 8)
	ld hl, wEventFlags + event_byte
	bit (\1) % 8, [hl]
ENDM

;\1 = event index
MACRO SetEvent
	DEF event_byte = ((\1) / 8)
	ld hl, wEventFlags + event_byte
	set (\1) % 8, [hl]
ENDM
