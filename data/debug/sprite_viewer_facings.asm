SpriteViewerSpriteTilemap::
	dw .FacingStepDown0
	dw .FacingStepDown1
	dw .FacingStepDown2
	dw .FacingStepDown3

	dw .FacingStepUp0
	dw .FacingStepUp1
	dw .FacingStepUp2
	dw .FacingStepUp3

	dw .FacingStepLeft0
	dw .FacingStepLeft1
	dw .FacingStepLeft2
	dw .FacingStepLeft3

	dw .FacingStepRight0
	dw .FacingStepRight1
	dw .FacingStepRight2
	dw .FacingStepRight3

.FacingStepDown0:
.FacingStepDown2: ; standing down
	db 0, 0, $00, $00
	db 0, 8, $01, $00
	db 8, 0, $02, RELATIVE_ATTRIBUTES
	db 8, 8, $03, RELATIVE_ATTRIBUTES | FACING_DONE

.FacingStepDown1: ; walking down 1
	db 0, 0, $0c, 0
	db 0, 8, $0d, 0
	db 8, 0, $0e, RELATIVE_ATTRIBUTES
	db 8, 8, $0f, RELATIVE_ATTRIBUTES | FACING_DONE

.FacingStepDown3: ; walking down 2
	db 0, 8, $0c, X_FLIP
	db 0, 0, $0d, X_FLIP
	db 8, 8, $0e, RELATIVE_ATTRIBUTES | X_FLIP
	db 8, 0, $0f, RELATIVE_ATTRIBUTES | X_FLIP | FACING_DONE

.FacingStepUp0:
.FacingStepUp2: ; standing up
	db 0, 0, $04, $00
	db 0, 8, $05, $00
	db 8, 0, $06, RELATIVE_ATTRIBUTES
	db 8, 8, $07, RELATIVE_ATTRIBUTES | FACING_DONE

.FacingStepUp1: ; walking up 1
	db 0, 0, $10, $00
	db 0, 8, $11, $00
	db 8, 0, $12, RELATIVE_ATTRIBUTES
	db 8, 8, $13, RELATIVE_ATTRIBUTES | FACING_DONE

.FacingStepUp3: ; walking up 2
	db 0, 8, $10, X_FLIP
	db 0, 0, $11, X_FLIP
	db 8, 8, $12, RELATIVE_ATTRIBUTES | X_FLIP
	db 8, 0, $13, RELATIVE_ATTRIBUTES | X_FLIP | FACING_DONE

.FacingStepLeft0:
.FacingStepLeft2: ; standing left
	db 0, 0, $08, $00
	db 0, 8, $09, $00
	db 8, 0, $0a, RELATIVE_ATTRIBUTES
	db 8, 8, $0b, RELATIVE_ATTRIBUTES | FACING_DONE

.FacingStepRight0:
.FacingStepRight2: ; standing right
	db 0, 8, $08, X_FLIP
	db 0, 0, $09, X_FLIP
	db 8, 8, $0a, RELATIVE_ATTRIBUTES | X_FLIP
	db 8, 0, $0b, RELATIVE_ATTRIBUTES | X_FLIP | FACING_DONE

.FacingStepLeft1:
.FacingStepLeft3: ; walking left
	db 0, 0, $14, $00
	db 0, 8, $15, $00
	db 8, 0, $16, RELATIVE_ATTRIBUTES
	db 8, 8, $17, RELATIVE_ATTRIBUTES | FACING_DONE

.FacingStepRight1:
.FacingStepRight3: ; walking right
	db 0, 8, $14, X_FLIP
	db 0, 0, $15, X_FLIP
	db 8, 8, $16, RELATIVE_ATTRIBUTES | X_FLIP
	db 8, 0, $17, RELATIVE_ATTRIBUTES | X_FLIP | FACING_DONE
