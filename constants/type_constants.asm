	const_def

DEF PHYSICAL_TYPES EQU const_value ; 00
	const TYPE_NORMAL   ; 00
	const TYPE_FIGHTING ; 01
	const TYPE_FLYING   ; 02
	const TYPE_POISON   ; 03
	const TYPE_GROUND   ; 04
	const TYPE_ROCK     ; 05
	const TYPE_BIRD     ; 06
	const TYPE_BUG      ; 07
	const TYPE_GHOST    ; 08
	const TYPE_METAL    ; 09 STEEL

DEF UNUSED_TYPES EQU const_value ; 0a
	const TYPE_0A       ; 0a
	const TYPE_0B       ; 0b
	const TYPE_0C       ; 0c
	const TYPE_0D       ; 0d
	const TYPE_0E       ; 0e
	const TYPE_0F       ; 0f
	const TYPE_10       ; 10
	const TYPE_11       ; 11
	const TYPE_12       ; 12
	const TYPE_UNKNOWN  ; 13 (used for Metronome, not Curse)
DEF UNUSED_TYPES_END EQU const_value ; 14

DEF SPECIAL_TYPES EQU const_value ; 14
	const TYPE_FIRE     ; 14
	const TYPE_WATER    ; 15
	const TYPE_GRASS    ; 16
	const TYPE_ELECTRIC ; 17
	const TYPE_PSYCHIC  ; 18
	const TYPE_ICE      ; 19
	const TYPE_DRAGON   ; 1a
	const TYPE_DARK     ; 1b
DEF TYPES_END EQU const_value ; 1c

DEF NUM_TYPES EQU TYPES_END + UNUSED_TYPES - UNUSED_TYPES_END ; 12

DEF POKEDEX_TYPE_STRING_LENGTH EQU 5