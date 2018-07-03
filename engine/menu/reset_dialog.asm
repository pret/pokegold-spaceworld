INCLUDE "constants.asm"

SECTION "engine/menu/reset_dialog.asm", ROMX

DisplayResetDialog:: ; fc362 (3f:4362)
	ld hl, _ResetConfirmText
	call MenuTextBox
	call YesNoBox
	jp nc, Reset
	call CloseWindow
	ret

_ResetConfirmText::
	text "ほんとにりセットしますか？"
	done