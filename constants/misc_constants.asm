; joypad

	const_def
	const A_BUTTON_F
	const B_BUTTON_F
	const SELECT_F
	const START_F
	const D_RIGHT_F
	const D_LEFT_F
	const D_UP_F
	const D_DOWN_F

NO_INPUT   EQU %00000000
A_BUTTON   EQU 1 << A_BUTTON_F
B_BUTTON   EQU 1 << B_BUTTON_F
SELECT     EQU 1 << SELECT_F
START      EQU 1 << START_F
D_RIGHT    EQU 1 << D_RIGHT_F
D_LEFT     EQU 1 << D_LEFT_F
D_UP       EQU 1 << D_UP_F
D_DOWN     EQU 1 << D_DOWN_F

BUTTONS    EQU A_BUTTON | B_BUTTON | SELECT | START
D_PAD      EQU D_RIGHT | D_LEFT | D_UP | D_DOWN

; Boolean values
FALSE EQU 0
TRUE EQU 1

; RedrawRowOrColumn functions
REDRAW_COL EQU 1
REDRAW_ROW EQU 2
