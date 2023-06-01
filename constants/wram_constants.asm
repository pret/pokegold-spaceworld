; wWalkingDirection::
	const_def -1
	const STANDING ; -1
	const DOWN     ; 0
	const UP       ; 1
	const LEFT     ; 2
	const RIGHT    ; 3
DEF NUM_DIRECTIONS EQU const_value

; wMonType::
	const_def
	const PARTYMON   ; 0
	const OTPARTYMON ; 1
	const BOXMON     ; 2
	const TEMPMON    ; 3
	const WILDMON    ; 4

; wPlayerState::
DEF PLAYER_NORMAL    EQU 0
DEF PLAYER_BIKE      EQU 1
DEF PLAYER_SKATE     EQU 2
DEF PLAYER_SURF      EQU 4
DEF PLAYER_SURF_PIKA EQU 8

; wDebugFlags::
	const_def
	const DEBUG_BATTLE_F
	const DEBUG_FIELD_F
	const CONTINUED_F


; wToolgearFlags::
DEF SHOW_TOOLGEAR_F      EQU 0
DEF TOOLGEAR_TO_WINDOW_F EQU 2
DEF HIDE_TOOLGEAR_F      EQU 7

; wd153::
DEF TOOLGEAR_COORDS_F       EQU 0
DEF OVERWORLD_MINUTE_TIME_F EQU 7
