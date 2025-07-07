INCLUDE "constants.asm"

SECTION "home/print_text.asm", ROM0

PrintLetterDelay::
	ld a, [wOptions]
	bit NO_TEXT_SCROLL_F, a
	ret nz
	ld a, [wTextboxFlags]
	bit TEXT_DELAY_F, a
	ret z
	push hl
	push de
	push bc
	ld a, [wTextboxFlags]
	bit FAST_TEXT_DELAY_F, a
	jr z, .waitOneFrame
	ld a, [wOptions]
	and TEXT_DELAY_MASK
	jr .initFrameCnt
.waitOneFrame
	ld a, 1
.initFrameCnt
	ld [wVBlankJoyFrameCounter], a
.checkButtons
	call GetJoypad
	ldh a, [hJoyState]
.checkAButton
	bit A_BUTTON_F, a
	jr z, .checkBButton
	jr .endWait
.checkBButton
	bit B_BUTTON_F, a
	jr z, .buttonsNotPressed
.endWait
	call DelayFrame
	jr .done
.buttonsNotPressed ; if neither A nor B is pressed
	ld a, [wVBlankJoyFrameCounter]
	and a
	jr nz, .checkButtons
.done
	pop bc
	pop de
	pop hl
	ret

CopyDataUntil::
; Copy [hl .. bc) to de.

; In other words, the source data is
; from hl up to but not including bc,
; and the destination is de.

.loop:
	ld a, [hli]
	ld [de], a
	inc de
	ld a, h
	cp b
	jr nz, .loop
	ld a, l
	cp c
	jr nz, .loop
	ret
