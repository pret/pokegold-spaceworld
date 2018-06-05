INCLUDE "constants.asm"

if DEBUG
SECTION "Startmenu and Select Button Check", ROM0[$2C05]
else
SECTION "Startmenu and Select Button Check", ROM0[$2BDF]
endc

OverworldStartButtonCheck:: ; 2c05 (0:2c05)
	ldh a, [hJoyState]
	bit START_F, a
	ret z
if DEBUG
	and (START | B_BUTTON)
	cp (START | B_BUTTON)
	jr nz, .regularMenu
	ld a, [wce63]
	bit 1, a
	ret z              ; debug disabled
	callba InGameDebugMenu
	jr CheckStartmenuSelectHook
.regularMenu
endc
	callba DisplayStartMenu
	jr CheckStartmenuSelectHook
SelectButtonFunction:: ; 2c2a (0:2c2a)
	callab CheckRegisteredItem
CheckStartmenuSelectHook:
	ldh a, [hStartmenuCloseAndSelectHookEnable]
	and a
	ret z          ; hook is disabled
	ld hl, StartmenuCloseAndSelectHookPtr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [StartmenuCloseAndSelectHookBank]
	call FarCall_hl
	ld hl, hStartmenuCloseAndSelectHookEnable
	xor a
	ld [hli], a    ; clear hook enable and ???
	ld [hl], a
	dec a
	ret

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
