INCLUDE "constants.asm"

SECTION "data/types/names.asm", ROMX

TypeNames::
	dw .Normal   ; NORMAL
	dw .Fighting ; FIGHTING
	dw .Flying   ; FLYING
	dw .Poison   ; POISON
	dw .Ground   ; GROUND
	dw .Rock     ; ROCK
	dw .Bird     ; BIRD
	dw .Bug      ; BUG
	dw .Ghost    ; GHOST
	dw .Metal    ; METAL
	dw .Normal   ; 0A
	dw .Normal   ; 0B
	dw .Normal   ; 0C
	dw .Normal   ; 0D
	dw .Normal   ; 0E
	dw .Normal   ; 0F
	dw .Normal   ; 10
	dw .Normal   ; 11
	dw .Normal   ; 12
	dw .Unknown  ; UNKNOWN
	dw .Fire     ; FIRE
	dw .Water    ; WATER
	dw .Grass    ; GRASS
	dw .Electric ; ELECTRIC
	dw .Psychic  ; PSYCHIC
	dw .Ice      ; ICE
	dw .Dragon   ; DRAGON
	dw .Dark     ; DARK

.Normal:   db "ノーマル@"
.Fighting: db "かくとう@"
.Flying:   db "ひこう@"
.Poison:   db "どく　@"
.Unknown:  db "？？？@"
.Fire:     db "ほのお@"
.Water:    db "みず　@"
.Grass:    db "くさ　@"
.Electric: db "でんき@"
.Psychic:  db "エスパー@"
.Ice:      db "こおり@"
.Ground:   db "じめん@"
.Rock:     db "いわ@"
.Bird:     db "とり@"
.Bug:      db "むし@"
.Ghost:    db "ゴースト@"
.Metal:    db "メタル@"
.Dragon:   db "ドラゴン@"
.Dark:     db "あく@"
