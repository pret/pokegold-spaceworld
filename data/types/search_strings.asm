INCLUDE "constants.asm"

SECTION "PokedexTypeSearchStrings", ROMX[$4ECC], BANK[$10]

PokedexTypeSearchStrings::
	db "ノーマル@" ; NORMAL
	db "ほのお　@" ; FIRE
	db "みず　　@" ; WATER
	db "くさ　　@" ; GRASS
	db "でんき　@" ; ELECTRIC
	db "こおり　@" ; ICE
	db "かくとう@" ; FIGHTING
	db "どく　　@" ; POISON
	db "じめん　@" ; GROUND
	db "ひこう　@" ; FLYING
	db "エスパー@" ; PSYCHIC
	db "むし　　@" ; BUG
	db "いわ　　@" ; ROCK
	db "ゴースト@" ; GHOST
	db "ドラゴン@" ; DRAGON
