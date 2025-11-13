INCLUDE "constants.asm"

SECTION "engine/menu_options_menu.asm", ROMX

DEF OPT_TEXT_SPEED_ROW EQU 3
DEF OPT_BATTLE_ANIM_ROW EQU 7
DEF OPT_BATTLE_STYLE_ROW EQU 11
DEF OPT_SOUND_ROW EQU 13
DEF OPT_BOTTOM_ROW EQU 16

OptionsMenu::
	ld a, [wStateFlags]
	push af
	xor a
	ld [wStateFlags], a
.ReinitDisplay:
	call DisplayOptionsMenu
.Loop:
	call GetOptionsMenuCursorPos
	ld [hl], '▶'
	call SetOptionsFromCursorPositions
	call WaitBGMap
.wait_joy_loop
	call DelayFrame
	call GetJoypadDebounced
	ldh a, [hJoySum]
	ld b, a
	and a
	jr z, .wait_joy_loop
	ld a, b
	and START | B_BUTTON
	jr nz, .ExitOptions
	ld a, b
	and SELECT
	jr nz, .SwitchSGBBorder
	ld a, b
	and A_BUTTON
	jr z, .CheckDPad

	ld a, [wOptionsMenuCursorY]
	cp OPT_BOTTOM_ROW
	jr nz, .Loop

	ld a, [wOptionsMenuCursorX]
	cp 7
	jr z, .SwitchActiveFrame
.ExitOptions:
	push de
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	pop de
	pop af
	ld [wStateFlags], a
	ld hl, wd4a9
	bit 0, [hl]
	jp z, TitleSequenceStart
	ret

.SwitchSGBBorder:
	ld hl, wOptions
	ld a, [hl]
	xor SGB_BORDER
	ld [hl], a
	callfar UpdateSGBBorder
	call LoadFont
	call LoadFontExtra
	ld c, 112
	call DelayFrames
	jp .ReinitDisplay

.SwitchActiveFrame
	ld a, [wActiveFrame]
	inc a
	and 7
	ld [wActiveFrame], a
	hlcoord 17, 16
	add '１'
	ld [hl], a
	call LoadFontExtra
	jr .Loop

.ClearOldMenuCursor:
	push af
	call GetOptionsMenuCursorPos
	ld [hl], '　'
	pop af
	ld [wOptionsMenuCursorX], a
	jp .Loop

.CheckDPad:
	ld a, [wOptionsMenuCursorY]
	bit D_DOWN_F, b
	jr nz, .down_pressed
	bit D_UP_F, b
	jr nz, .up_pressed

	cp OPT_BATTLE_ANIM_ROW
	jp z, .Cursor_BattleAnimation
	cp OPT_BATTLE_STYLE_ROW
	jp z, .Cursor_BattleStyle
	cp OPT_SOUND_ROW
	jp z, .Cursor_Audio
	cp OPT_BOTTOM_ROW
	jp z, .Cursor_BottomRow

.Cursor_TextSpeed:
	bit D_LEFT_F, b
	jp nz, .text_speed_left
	jp .text_speed_right

.down_pressed
	cp OPT_BOTTOM_ROW
	ld b, OPT_TEXT_SPEED_ROW - OPT_BOTTOM_ROW
	ld hl, wOptionsTextSpeedCursorX
	jr z, .update_cursor

	cp OPT_TEXT_SPEED_ROW
	ld b, OPT_BATTLE_ANIM_ROW - OPT_TEXT_SPEED_ROW
	inc hl ; wOptionsBattleAnimCursorX
	jr z, .update_cursor

	cp OPT_BATTLE_ANIM_ROW
	ld b, OPT_BATTLE_STYLE_ROW - OPT_BATTLE_ANIM_ROW
	inc hl ; wOptionsBattleStyleCursorX
	jr z, .update_cursor

	cp OPT_BATTLE_STYLE_ROW
	ld b, OPT_SOUND_ROW - OPT_BATTLE_STYLE_ROW
	inc hl ; wOptionsAudioSettingsCursorX
	jr z, .update_cursor

	ld b, OPT_BOTTOM_ROW - OPT_SOUND_ROW
	inc hl ; wOptionsBottomRowCursorX
	jr .update_cursor

.up_pressed
	cp OPT_BATTLE_ANIM_ROW
	ld b, OPT_TEXT_SPEED_ROW - OPT_BATTLE_ANIM_ROW
	ld hl, wOptionsTextSpeedCursorX
	jr z, .update_cursor

	cp OPT_BATTLE_STYLE_ROW
	ld b, OPT_BATTLE_ANIM_ROW - OPT_BATTLE_STYLE_ROW
	inc hl ; wOptionsBattleAnimCursorX
	jr z, .update_cursor

	cp OPT_SOUND_ROW
	ld b, OPT_BATTLE_STYLE_ROW - OPT_SOUND_ROW
	inc hl ; wOptionsBattleStyleCursorX
	jr z, .update_cursor

	cp OPT_BOTTOM_ROW
	ld b, OPT_SOUND_ROW - OPT_BOTTOM_ROW
	inc hl ; wOptionsAudioSettingsCursorX
	jr z, .update_cursor

	ld b, OPT_BOTTOM_ROW - OPT_TEXT_SPEED_ROW
	inc hl ; wOptionsBottomRowCursorX
.update_cursor
	add b
	push af
	ld a, [hl]
	push af
	call GetOptionsMenuCursorPos
	ld [hl], '▷'
	pop af
	ld [wOptionsMenuCursorX], a
	pop af
	ld [wOptionsMenuCursorY], a
	jp .Loop

.text_speed_left
	ld a, [wOptionsTextSpeedCursorX]
	cp 1
	jr z, .update_text_speed
	sub 7
	jr .update_text_speed

.text_speed_right
	ld a, [wOptionsTextSpeedCursorX]
	cp 15
	jr z, .update_text_speed
	add 7
.update_text_speed
	ld [wOptionsTextSpeedCursorX], a
	jp .ClearOldMenuCursor

.Cursor_BattleAnimation:
	ld a, [wOptionsBattleAnimCursorX]
	xor %1011 ; 1 <-> 10
	ld [wOptionsBattleAnimCursorX], a
	jp .ClearOldMenuCursor

.Cursor_BattleStyle:
	ld a, [wOptionsBattleStyleCursorX]
	xor %1011 ; 1 <-> 10
	ld [wOptionsBattleStyleCursorX], a
	jp .ClearOldMenuCursor
	
.Cursor_Audio:
	ld a, [wOptionsAudioSettingsCursorX]
	xor %1011 ; 1 <-> 10
	ld [wOptionsAudioSettingsCursorX], a
	jp .ClearOldMenuCursor

.Cursor_BottomRow:
	call GetOptionsMenuCursorPos
	ld [hl], '▷'
	ld a, [wOptionsMenuCursorX]
	xor %110 ; 1 <-> 7
	ld [wOptionsMenuCursorX], a
	jp .Loop

GetOptionsMenuCursorPos:
	ld a, [wOptionsMenuCursorY]
	ld hl, wTileMap
	ld bc, SCREEN_WIDTH
	call AddNTimes
	ld a, [wOptionsMenuCursorX]
	ld b, 0
	ld c, a
	add hl, bc
	ret

SetOptionsFromCursorPositions:
	ld hl, TextSpeedOptionData
	ld a, [wOptionsTextSpeedCursorX]
	ld c, a
.loop
	ld a, [hli]
	cp c
	jr z, .found
	inc hl
	jr .loop

.found
	ld a, [hl]
	ld d, a
	ld a, [wOptionsBattleAnimCursorX]
	dec a
	jr z, .battle_anim_off
	set BATTLE_SCENE_F, d
	jr .battle_anim_on

.battle_anim_off
	res BATTLE_SCENE_F, d
.battle_anim_on
	ld a, [wOptionsBattleStyleCursorX]
	dec a
	jr z, .battle_shift_off
	set BATTLE_SHIFT_F, d
	jr .battle_shift_on

.battle_shift_off
	res BATTLE_SHIFT_F, d
.battle_shift_on
	ld a, [wOptionsAudioSettingsCursorX]
	dec a
	jr z, .mono
	set STEREO_F, d
	jr .stereo

.mono
	res STEREO_F, d
.stereo
	ld a, [wOptions]
	and SGB_BORDER
	or d
	ld [wOptions], a
	ret

DisplayOptionsMenu:
	call ClearBGPalettes
	call DisableLCD
	xor a
	ldh [hBGMapMode], a
	call .LoadGFX_DrawDisplay
	xor a
	ld hl, wOptionsTextSpeedCursorX
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	assert FAST_TEXT_DELAY_F == 0
	inc a ; 1 << FAST_TEXT_DELAY_F
	ld [wTextboxFlags], a
	ld hl, TextSpeedOptionData + 1
	ld a, [wOptions]
	ld c, a
	and TEXT_DELAY_MASK
	push bc
	ld de, 2
	call FindItemInTable
	pop bc
	dec hl
	ld a, [hl]
	ld [wOptionsTextSpeedCursorX], a ;
	hlcoord 0, OPT_TEXT_SPEED_ROW
	call .PlaceUnfilledRightArrow
	sla c
	ld a, 1 ; On
	jr nc, .battle_anim
	ld a, 10 ; Off
.battle_anim
	ld [wOptionsBattleAnimCursorX], a
	hlcoord 0, OPT_BATTLE_ANIM_ROW
	call .PlaceUnfilledRightArrow
	sla c
	ld a, 1 ; Shift
	jr nc, .battle_style
	ld a, 10 ; Set
.battle_style
	ld [wOptionsBattleStyleCursorX], a
	hlcoord 0, OPT_BATTLE_STYLE_ROW
	call .PlaceUnfilledRightArrow
	sla c
	ld a, 1 ; Mono
	jr nc, .mono_stereo
	ld a, 10 ; Stereo
.mono_stereo
	ld [wOptionsAudioSettingsCursorX], a
	hlcoord 0, OPT_SOUND_ROW
	call .PlaceUnfilledRightArrow
	ld a, 1
	ld [wOptionsBottomRowCursorX], a
; Cursor in front of "Cancel"
	hlcoord 1, OPT_BOTTOM_ROW
	ld [hl], '▷'
; Cursor in front of frame options
	hlcoord 7, OPT_BOTTOM_ROW
	ld [hl], '▷'
	ld a, [wOptionsTextSpeedCursorX]
	ld [wOptionsMenuCursorX], a
	ld a, 3
	ld [wOptionsMenuCursorY], a
	call EnableLCD
	call WaitBGMap
	call SetPalettes
	ret

.PlaceUnfilledRightArrow
	ld e, a
	ld d, 0
	add hl, de
	ld [hl], '▷'
	ret

.LoadGFX_DrawDisplay
	ld de, vChars1 tile $70
	ld hl, TrainerCardGFX
	ld bc, 1 tiles
	ld a, BANK(TrainerCardGFX)
	call FarCopyData
	ld hl, wTileMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, $f0 ; checkered square tile
	call ByteFill
; Text Speed
	hlcoord 1, OPT_TEXT_SPEED_ROW - 2
	lb bc, 3, 18
	call ClearBox
; Battle Scene
	hlcoord 1, OPT_BATTLE_ANIM_ROW - 2
	lb bc, 3, 18
	call ClearBox
; Battle Style
	hlcoord 1, OPT_BATTLE_STYLE_ROW - 2
	lb bc, 3, 18
	call ClearBox
; Sound
	hlcoord 1, OPT_SOUND_ROW
	lb bc, 1, 18
	call ClearBox

	hlcoord 1, OPT_TEXT_SPEED_ROW - 2
	ld de, .OptionsText_TextSpeed
	call PlaceString

	hlcoord 1, OPT_BATTLE_ANIM_ROW - 2
	ld de, .OptionsText_BattleScene
	call PlaceString

	hlcoord 1, OPT_BATTLE_STYLE_ROW - 2
	ld de, .OptionsText_BattleStyle
	call PlaceString

	hlcoord 1, OPT_SOUND_ROW
	ld de, .OptionsText_Sound
	call PlaceString

	hlcoord 1, OPT_BOTTOM_ROW
	ld de, .OptionsText_Cancel
	call PlaceString
; Draw the text box for the frame options
	hlcoord 6, OPT_BOTTOM_ROW - 1
	ld b, 1
	ld c, 11
	call DrawTextBox

	hlcoord 7, OPT_BOTTOM_ROW
	ld de, .OptionsText_FrameType
	call PlaceString
; Place # of active frame
	ld a, [wActiveFrame]
	hlcoord 17, 16
	add '１'
	ld [hl], a
	ret

.OptionsText_TextSpeed:
	db "はなしの　はやさ"
	next "　はやい　　　　ふつう　　　　おそい"
	text_end

.OptionsText_BattleScene:
	db "せんとう　アニメーション"
	next "　じっくり　みる　　とばして　みる"
	text_end

.OptionsText_BattleStyle:
	db "しあいの　ルール"
	next "　いれかえタイプ　　かちぬきタイプ"
	text_end

.OptionsText_Sound:
	db "　モノラル　　　　　ステレオ"
	text_end

.OptionsText_Cancel:
	db "　おわり"
	text_end

.OptionsText_FrameType:
	db "　わく　を　かえる　"
	text_end

; Table that indicates how the 3 text speed options affect frame delays.
; Format:
; 00: X coordinate of menu cursor.
; 01: delay after printing a letter (in frames).
TextSpeedOptionData:
	db 15, TEXT_DELAY_SLOW
	db  8, TEXT_DELAY_MED
	db  1, TEXT_DELAY_FAST
	db  8, -1

Unknown7c2a:
rept 491
	db $39, $00
endr
