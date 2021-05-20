; wWalkingDirection::
	const_def -1
	const STANDING ; -1
	const DOWN     ; 0
	const UP       ; 1
	const LEFT     ; 2
	const RIGHT    ; 3
NUM_DIRECTIONS EQU const_value

; wMonType::
	const_def
	const PARTYMON   ; 0
	const OTPARTYMON ; 1
	const BOXMON     ; 2
	const TEMPMON    ; 3
	const WILDMON    ; 4

; wPlayerState::
PLAYER_NORMAL    EQU 0
PLAYER_BIKE      EQU 1
PLAYER_SKATE     EQU 2
PLAYER_SURF      EQU 4
PLAYER_SURF_PIKA EQU 8

; wDebugFlags::
	const_def
	const DEBUG_BATTLE_F
	const DEBUG_FIELD_F
	const CONTINUED_F


; wToolgearFlags::
SHOW_TOOLGEAR_F      EQU 0
TOOLGEAR_TO_WINDOW_F EQU 2
HIDE_TOOLGEAR_F      EQU 7

; wd153::
TOOLGEAR_COORDS_F       EQU 0
OVERWORLD_MINUTE_TIME_F EQU 7
