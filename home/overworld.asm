INCLUDE "constants.asm"

if DEBUG
SECTION "Install StartMenu Hook Function", ROM0[$35EC]
else
SECTION "Install StartMenu Hook Function", ROM0[$35B0]
endc

InstallStartmenuCloseAndSelectHook::
; Install a function that is called as soon as
; the start menu is closed or directly after
; the select button function ran
	ld [StartmenuCloseAndSelectHookBank], a
	ld a, l
	ld [StartmenuCloseAndSelectHookPtr], a
	ld a, h
	ld [StartmenuCloseAndSelectHookPtr + 1], a
	ret
