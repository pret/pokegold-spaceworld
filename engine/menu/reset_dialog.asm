INCLUDE "constants.asm"

SECTION "Debug Reset Menu", ROMX[$4362], BANK[$3F]

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
