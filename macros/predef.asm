MACRO predef_id
; Some functions load the predef id
; without immediately calling Predef.
	ld a, (\1Predef - PredefPointers) / 3
ENDM

MACRO predef
	predef_id \1
	call Predef
ENDM

MACRO predef_jump
	predef_id \1
	jp Predef
ENDM
