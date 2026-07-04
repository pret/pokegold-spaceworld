QueueScript::
; Install a function that is called as soon as
; the start menu is closed or directly after
; the select button function ran
	ld [wQueuedScriptBank], a
	ld a, l
	ld [wQueuedScriptAddr], a
	ld a, h
	ld [wQueuedScriptAddr + 1], a
	ret
