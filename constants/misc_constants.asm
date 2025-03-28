; Boolean values
DEF FALSE EQU 0
DEF TRUE EQU 1

; time of day boundaries
DEF MORN_HOUR EQU 6  ; 6 AM
DEF DAY_HOUR  EQU 9  ; 9 AM
DEF NITE_HOUR EQU 15 ; 3 PM
DEF NOON_HOUR EQU 12 ; 12 PM
DEF MAX_HOUR  EQU 24 ; 12 AM

; wTimeOfDay::
const_def
	shift_const DAY      ; 0
	shift_const NITE     ; 1
	shift_const DARKNESS ; 2
	shift_const MORN     ; 3
DEF NUM_DAYTIMES EQU const_value

; FlagAction arguments (see home/flag.asm)
const_def
const RESET_FLAG
const SET_FLAG
const CHECK_FLAG

; RedrawRowOrColumn functions
DEF REDRAW_COL EQU 1
DEF REDRAW_ROW EQU 2

; significant money values
DEF MAX_COINS EQU 9999

; LoadMenuMonIcon.Jumptable indexes (see engine/gfx/mon_icons.asm)
const_def
const MONICON_PARTYMENU
const MONICON_NAMINGSCREEN
const MONICON_MOVES
const MONICON_TRADE
