; Unreferenced overworld sprite table leftover from Generation I.
; Pseudo-OAM flags originally used by game logic
	const_def
	const BIT_END_OF_OAM_DATA    ; 0
	const BIT_SPRITE_UNDER_GRASS ; 1

; Used in SpriteFacingAndAnimationTable
DEF FACING_END  EQU 1 << BIT_END_OF_OAM_DATA
DEF UNDER_GRASS EQU 1 << BIT_SPRITE_UNDER_GRASS

Unreferenced_OldSpriteFacingAndAnimationTable:
; This table is used for overworld sprites $1-$9.
	dw .StandingDown, .NormalOAM  ; facing down, walk animation frame 0
	dw .WalkingDown,  .NormalOAM  ; facing down, walk animation frame 1
	dw .StandingDown, .NormalOAM  ; facing down, walk animation frame 2
	dw .WalkingDown,  .FlippedOAM ; facing down, walk animation frame 3
	dw .StandingUp,   .NormalOAM  ; facing up, walk animation frame 0
	dw .WalkingUp,    .NormalOAM  ; facing up, walk animation frame 1
	dw .StandingUp,   .NormalOAM  ; facing up, walk animation frame 2
	dw .WalkingUp,    .FlippedOAM ; facing up, walk animation frame 3
	dw .StandingLeft, .NormalOAM  ; facing left, walk animation frame 0
	dw .WalkingLeft,  .NormalOAM  ; facing left, walk animation frame 1
	dw .StandingLeft, .NormalOAM  ; facing left, walk animation frame 2
	dw .WalkingLeft,  .NormalOAM  ; facing left, walk animation frame 3
	dw .StandingLeft, .FlippedOAM ; facing right, walk animation frame 0
	dw .WalkingLeft,  .FlippedOAM ; facing right, walk animation frame 1
	dw .StandingLeft, .FlippedOAM ; facing right, walk animation frame 2
	dw .WalkingLeft,  .FlippedOAM ; facing right, walk animation frame 3
; The rest of this table is used for sprites $a and $b.
; All orientation and animation parameters lead to the same result.
; Used for immobile sprites like items on the ground.
	dw .StandingDown, .NormalOAM  ; facing down, walk animation frame 0
	dw .StandingDown, .NormalOAM  ; facing down, walk animation frame 1
	dw .StandingDown, .NormalOAM  ; facing down, walk animation frame 2
	dw .StandingDown, .NormalOAM  ; facing down, walk animation frame 3
	dw .StandingDown, .NormalOAM  ; facing up, walk animation frame 0
	dw .StandingDown, .NormalOAM  ; facing up, walk animation frame 1
	dw .StandingDown, .NormalOAM  ; facing up, walk animation frame 2
	dw .StandingDown, .NormalOAM  ; facing up, walk animation frame 3
	dw .StandingDown, .NormalOAM  ; facing left, walk animation frame 0
	dw .StandingDown, .NormalOAM  ; facing left, walk animation frame 1
	dw .StandingDown, .NormalOAM  ; facing left, walk animation frame 2
	dw .StandingDown, .NormalOAM  ; facing left, walk animation frame 3
	dw .StandingDown, .NormalOAM  ; facing right, walk animation frame 0
	dw .StandingDown, .NormalOAM  ; facing right, walk animation frame 1
	dw .StandingDown, .NormalOAM  ; facing right, walk animation frame 2
	dw .StandingDown, .NormalOAM  ; facing right, walk animation frame 3

; four tile ids compose an overworld sprite
.StandingDown: db $00, $01, $02, $03
.WalkingDown:  db $80, $81, $82, $83
.StandingUp:   db $04, $05, $06, $07
.WalkingUp:    db $84, $85, $86, $87
.StandingLeft: db $08, $09, $0a, $0b
.WalkingLeft:  db $88, $89, $8a, $8b

.NormalOAM:
	; y, x, attributes
	db 0, 0, $00 ; top left
	db 0, 8, $00 ; top right
	db 8, 0, UNDER_GRASS ; bottom left
	db 8, 8, UNDER_GRASS | FACING_END ; bottom right

.FlippedOAM:
	; y, x, attributes
	db 0, 8, X_FLIP ; top left
	db 0, 0, X_FLIP ; top right
	db 8, 8, X_FLIP | UNDER_GRASS ; bottom left
	db 8, 0, X_FLIP | UNDER_GRASS | FACING_END ; bottom right
