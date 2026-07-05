DisplayResetDialog::
	ld hl, _ResetConfirmText
	call MenuTextBox
	call YesNoBox
	jp nc, Reset
	call CloseWindow
	ret

_ResetConfirmText::
	text "ほんとにリセットしますか？"
	done
