INCLUDE "constants.asm"

SECTION "home/scrolling_menu.asm", ROM0

Function3810::
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl
	ld h, d
	ld l, e
	call CopyMenuHeader
	pop hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, [de]
	ld [wMenuCursorBuffer], a
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, [de]
	ld [wMenuScrollPosition], a
	push de
	call ScrollingMenu
	pop de
	ld a, [wMenuScrollPosition]
	ld [de], a
	pop de
	ld a, [wMenuCursorY]
	ld [de], a
	ld a, [wMenuJoypad]
	ret

ScrollingMenu::
	call CopyMenuData
	ldh a, [hROMBank]
	push af

	ld a, BANK(_InitScrollingMenu) ; and BANK(_ScrollingMenu)
	call Bankswitch

	call _InitScrollingMenu
	call SetPalettes
	call _ScrollingMenu

	pop af
	call Bankswitch

	ld a, [wMenuJoypad]
	ret

Function385a::
	push hl
	jr asm_3865

Function385d::
	callfar FreezeMonIcons
asm_3865:
	pop hl
	call MenuTextBox
	ld c, $0
	call Function3872
	call CloseWindow
	ret

Function3872::
	push bc
	jr asm_387d

Function3875::
	callfar PlaySpriteAnimationsAndDelayFrame
asm_387d:
	pop bc
	call GetJoypad
	ldh a, [hJoyDown]
	and A_BUTTON | B_BUTTON
	jr nz, .done
	ld a, c
	and a
	jr z, Function3872
	dec c
	jr z, Function3872
.done:
	ret
