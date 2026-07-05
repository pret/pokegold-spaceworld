; AI_OPPORTUNIST discourages these moves
; when the player's HP is low.

; BUG: Contains Flame Wheel, ostensibly an attacking move.
; It was presumably intended to be Nightmare, the move occupying the previous slot.
; Also, the list does not include any other new moves, despite the addition of more stall-enabling
; moves such as Protect and Encore. Both oddities still exist in the final game.
StallMoves:
	db MOVE_SWORDS_DANCE
	db MOVE_TAIL_WHIP
	db MOVE_LEER
	db MOVE_GROWL
	db MOVE_DISABLE
	db MOVE_MIST
	db MOVE_COUNTER
	db MOVE_LEECH_SEED
	db MOVE_GROWTH
	db MOVE_STRING_SHOT
	db MOVE_MEDITATE
	db MOVE_AGILITY
	db MOVE_RAGE
	db MOVE_MIMIC
	db MOVE_SCREECH
	db MOVE_HARDEN
	db MOVE_WITHDRAW
	db MOVE_DEFENSE_CURL
	db MOVE_BARRIER
	db MOVE_LIGHT_SCREEN
	db MOVE_HAZE
	db MOVE_REFLECT
	db MOVE_FOCUS_ENERGY
	db MOVE_BIDE
	db MOVE_AMNESIA
	db MOVE_TRANSFORM
	db MOVE_SPLASH
	db MOVE_ACID_ARMOR
	db MOVE_SHARPEN
	db MOVE_CONVERSION
	db MOVE_SUBSTITUTE
	db MOVE_FLAME_WHEEL
	db -1 ; end
