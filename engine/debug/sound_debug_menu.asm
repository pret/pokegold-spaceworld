_DebugMenuSoundTest::
	call ClearTileMap
	call LoadFontExtra
	call ClearSprites
	call GetMemSGBLayout
	xor a
	ldh [hDebugMenuSoundMenuIndex], a
	call .DetermineDescriptionPointer

.RefreshScreenAndLoop:
	call WaitBGMap

.Loop:
	call ClearJoypad
	call GetJoypad
	ldh a, [hJoyDown]
	and a
	jr z, .Loop

	bit A_BUTTON_F, a
	jr nz, .a_pressed

	bit B_BUTTON_F, a
	jr nz, .b_pressed

	bit START_F, a
	jr nz, .start_pressed

	bit D_UP_F, a
	jr nz, .up_pressed

	bit D_DOWN_F, a
	jr nz, .down_pressed

	ret

.a_pressed
; BUG: The selected sound won't play as the PlaySFX call isn't present.
; Loading the soundbank is pointless as all sounds share the same bank, this would be correct in pokered.
	ldh a, [hDebugMenuSoundBank]
	ld c, a
	ldh a, [hDebugMenuSoundID]
;	ld e, a
;	ld d, 0
;	callfar PlaySFX
	jr .RefreshScreenAndLoop

.up_pressed
	ldh a, [hDebugMenuSoundMenuIndex]
	inc a
	cp 55
	jr nz, .SetIndex

	xor a

.SetIndex:
	ldh [hDebugMenuSoundMenuIndex], a
	call .DetermineDescriptionPointer
	jr .RefreshScreenAndLoop

.down_pressed
	ldh a, [hDebugMenuSoundMenuIndex]
	dec a
	cp -1
	jr nz, .SetIndex2

	ld a, 54

.SetIndex2:
	ldh [hDebugMenuSoundMenuIndex], a
	call .DetermineDescriptionPointer
	jr .RefreshScreenAndLoop

.start_pressed
	ldh a, [hDebugMenuSoundBank]
	ld c, a
	ld a, -1
	jr .RefreshScreenAndLoop

.b_pressed
	ldh a, [hDebugMenuSoundBank]
	ld c, a
	ld a, 10
	ld [wAudioFadeOutCounterReloadValue], a
	ld [wAudioFadeOutCounter], a
	ld a, $ff
	ld [wAudioFadeOutControl], a
	jr .RefreshScreenAndLoop

.DetermineDescriptionPointer:
	ld hl, SoundTestTextPointers
	ldh a, [hDebugMenuSoundMenuIndex]
	add a
	add a ; a * 4
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hli]
	ldh [hDebugMenuSoundID], a
	ld a, [hli]
	ldh [hDebugMenuSoundBank], a
	ld a, [hli]
	ld e, a
	ld d, [hl]
	call CopyStringToStringBuffer2
	call .DisplayText
	ret

.DisplayText:
	ld hl, hDebugMenuSoundMenuIndex
	inc [hl]
	ld hl, .String
	call PrintText
	ld hl, hDebugMenuSoundMenuIndex
	dec [hl]
	ld c, 3
	call DelayFrames
	ret

.String:
	deciram hDebugMenuSoundMenuIndex, 1, 1
	text_start
	line "@"
	text_from_ram wStartDay
	text "　"
	done

INCLUDE "data/debug/sound_test_text_pointers.asm"
