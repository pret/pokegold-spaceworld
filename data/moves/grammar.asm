MoveGrammar:
; Each move is given an identifier for what usedmovetext to use (0-4).
; Made redundant in English localization, where all are just "[mon]<LINE>used [move]!"
; In this prototype, no new moves have been added to the list yet.
;
; 0: "[mon]の<LINE>[move]を　つかった!" ("[mon]<LINE>used [move]!")
	db MOVE_SWORDS_DANCE
	db MOVE_GROWTH
	db 0 ; end set

; 1: "[mon]の<LINE>[move]した!" ("[mon]<LINE>did [move]!")
	db MOVE_RECOVER
	db MOVE_BIDE
	db MOVE_SELFDESTRUCT
	db MOVE_AMNESIA
	db 0 ; end set

; 2: "[mon]の<LINE>[move]を　した!" ("[mon]<LINE>did [move]!")
	db MOVE_MEDITATE
	db MOVE_AGILITY
	db MOVE_TELEPORT
	db MOVE_MIMIC
	db MOVE_DOUBLE_TEAM
	db MOVE_BARRAGE
	db 0 ; end set

; 3: "[mon]の<LINE>[move]　こうげき!" ("[mon]'s<LINE>[move] attack!")
	db MOVE_POUND
	db MOVE_SCRATCH
	db MOVE_VICEGRIP
	db MOVE_WING_ATTACK
	db MOVE_FLY
	db MOVE_BIND
	db MOVE_SLAM
	db MOVE_HORN_ATTACK
	db MOVE_BODY_SLAM
	db MOVE_WRAP
	db MOVE_THRASH
	db MOVE_TAIL_WHIP
	db MOVE_LEER
	db MOVE_BITE
	db MOVE_GROWL
	db MOVE_ROAR
	db MOVE_SING
	db MOVE_PECK
	db MOVE_COUNTER
	db MOVE_STRENGTH
	db MOVE_ABSORB
	db MOVE_STRING_SHOT
	db MOVE_EARTHQUAKE
	db MOVE_FISSURE
	db MOVE_DIG
	db MOVE_TOXIC
	db MOVE_SCREECH
	db MOVE_HARDEN
	db MOVE_MINIMIZE
	db MOVE_WITHDRAW
	db MOVE_DEFENSE_CURL
	db MOVE_METRONOME
	db MOVE_LICK
	db MOVE_CLAMP
	db MOVE_CONSTRICT
	db MOVE_POISON_GAS
	db MOVE_LEECH_LIFE
	db MOVE_BUBBLE
	db MOVE_FLASH
	db MOVE_SPLASH
	db MOVE_ACID_ARMOR
	db MOVE_FURY_SWIPES
	db MOVE_REST
	db MOVE_SHARPEN
	db MOVE_SLASH
	db MOVE_SUBSTITUTE
	db 0 ; end set

; 4: "[mon]の<LINE>[move]!" ("[mon]'s<LINE>[move]!")
; Any move not listed above uses this grammar.
	db -1 ; end
