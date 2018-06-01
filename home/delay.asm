INCLUDE "constants.asm"

SECTION "Delay", ROM0[$0317]

DelayFrame::
; Wait for one frame
	ld a, 1
	ld [wVBlankOccurred], a
.halt
; Wait for the next VBlank, halting to conserve battery
	halt ; rgbasm adds a nop after this instruction by default
	ld a, [wVBlankOccurred]
	and a
	jr nz, .halt
	ret

DelayFrames::
; Wait c frames
	call DelayFrame
	dec c
	jr nz, DelayFrames
	ret
