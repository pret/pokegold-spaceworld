INCLUDE "constants.asm"

SECTION "data/sprites/facings.asm", ROMX

INCLUDE "data/sprites/old_facings.inc"

Facings:
	dw FacingStepDown0
	dw FacingStepDown1
	dw FacingStepDown2
	dw FacingStepDown3

	dw FacingStepUp0
	dw FacingStepUp1
	dw FacingStepUp2
	dw FacingStepUp3

	dw FacingStepLeft0
	dw FacingStepLeft1
	dw FacingStepLeft2
	dw FacingStepLeft3

	dw FacingStepRight0
	dw FacingStepRight1
	dw FacingStepRight2
	dw FacingStepRight3

FacingStepDown0:
FacingStepDown2: ; standing down
	db 0, 0, $00, $00
	db 0, 8, $01, $00
	db 8, 0, $02, RELATIVE_ATTRIBUTES
	db 8, 8, $03, RELATIVE_ATTRIBUTES | FACING_DONE

FacingStepDown1: ; walking down 1
	db 0, 0, $80, $00
	db 0, 8, $81, $00
	db 8, 0, $82, RELATIVE_ATTRIBUTES
	db 8, 8, $83, RELATIVE_ATTRIBUTES | FACING_DONE

FacingStepDown3: ; walking down 2
	db 0, 8, $80, X_FLIP
	db 0, 0, $81, X_FLIP
	db 8, 8, $82, RELATIVE_ATTRIBUTES | X_FLIP
	db 8, 0, $83, RELATIVE_ATTRIBUTES | X_FLIP | FACING_DONE

FacingStepUp0:
FacingStepUp2: ; standing up
	db 0, 0, $04, $00
	db 0, 8, $05, $00
	db 8, 0, $06, RELATIVE_ATTRIBUTES
	db 8, 8, $07, RELATIVE_ATTRIBUTES | FACING_DONE

FacingStepUp1: ; walking up 1
	db 0, 0, $84, $00
	db 0, 8, $85, $00
	db 8, 0, $86, RELATIVE_ATTRIBUTES
	db 8, 8, $87, RELATIVE_ATTRIBUTES | FACING_DONE

FacingStepUp3: ; walking up 2
	db 0, 8, $84, X_FLIP
	db 0, 0, $85, X_FLIP
	db 8, 8, $86, RELATIVE_ATTRIBUTES | X_FLIP
	db 8, 0, $87, RELATIVE_ATTRIBUTES | X_FLIP | FACING_DONE

FacingStepLeft0:
FacingStepLeft2: ; standing left
	db 0, 0, $08, $00
	db 0, 8, $09, $00
	db 8, 0, $0a, RELATIVE_ATTRIBUTES
	db 8, 8, $0b, RELATIVE_ATTRIBUTES | FACING_DONE

FacingStepRight0:
FacingStepRight2: ; standing right
	db 0, 8, $08, X_FLIP
	db 0, 0, $09, X_FLIP
	db 8, 8, $0a, RELATIVE_ATTRIBUTES | X_FLIP
	db 8, 0, $0b, RELATIVE_ATTRIBUTES | X_FLIP | FACING_DONE

FacingStepLeft1:
FacingStepLeft3: ; walking left
	db 0, 0, $88, $00
	db 0, 8, $89, $00
	db 8, 0, $8a, RELATIVE_ATTRIBUTES
	db 8, 8, $8b, RELATIVE_ATTRIBUTES | FACING_DONE

FacingStepRight1:
FacingStepRight3: ; walking right
	db 0, 8, $88, X_FLIP
	db 0, 0, $89, X_FLIP
	db 8, 8, $8a, RELATIVE_ATTRIBUTES | X_FLIP
	db 8, 0, $8b, RELATIVE_ATTRIBUTES | X_FLIP | FACING_DONE
