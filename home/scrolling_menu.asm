INCLUDE "constants.asm"

SECTION "home/scrolling_menu.asm", ROM0

; Runs a scrolling menu from a table with the following:
; 1. A pointer to the menu header.
; 2. Pointer to the cursor in RAM.
; 3. Pointer to the menu scroll position in RAM.
ScrollingMenu_FromTable::
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
	ld [wMenuCursorPosition], a
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

PartyMenu_TextboxBackup::
	push hl
	jr .continue

.unreferenced_385d:
	callfar FreezeMonIcons
.continue
	pop hl
	call MenuTextBox
	ld c, 0
	call PartyMenu_WaitForAorB
	call CloseWindow
	ret

; BUG: Supposed to wait for at most c frames until the player pushes a button. If c is 0, then wait indefinitely.
; However, there is a bit of a problem: it doesn't actually call DelayFrames at any point.
; Presumably, this function was intended to loop at .unreferenced_3875 at one point,
; but they forgot to add a DelayFrame when they added the jump at the beginning.
;
; TLDR: The Softboiled heal message only shows up for one frame due to a combination of two oversights.
PartyMenu_WaitForAorB::
.loop
	push bc
	jr .continue

.unreferenced_3875:
	callfar PlaySpriteAnimationsAndDelayFrame
.continue
	pop bc
	call GetJoypad
	ldh a, [hJoyDown]
	and A_BUTTON | B_BUTTON
	jr nz, .done
	ld a, c
	and a
	jr z, .loop
	dec c
; BUG: This is supposed to be a jr nz, not jr z
	jr z, .loop
.done
	ret
