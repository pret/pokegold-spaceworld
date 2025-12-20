INCLUDE "constants.asm"

SECTION "engine/items/tm_holder.asm", ROMX

_TMHolder:
	ld a, 1
	ldh [hInMenu], a

	call TM_HolderLoop

	ld a, 0
	ldh [hInMenu], a
	ret nc

	call PlaceHollowCursor
	call WaitBGMap
	ld a, 1
	ldh [hBGMapMode], a

	ld a, [wCurItem]
	cp NUM_TM_HM + 1
	ret nc

	ld [wTempTMHM], a
	predef GetTMHMMove
	ld a, [wTempTMHM]
	ld [wPutativeTMHMMove], a
	call GetMoveName
	call CopyStringToStringBuffer2
	
	ld hl, BootedTMText
	call PrintText
	ld hl, ContainedMoveText
	call PrintText
	call YesNoBox
	jp c, .cancel

.AskTeachTMHM:
.loopback
	ld hl, wStringBuffer2
	ld de, wTMHMMoveNameBackup
	ld bc, MOVE_NAME_LENGTH
	call CopyBytes

	ld hl, wStateFlags
	res SPRITE_UPDATES_DISABLED_F, [hl]
	ld a, PARTYMENUACTION_TEACH_TMHM
	ld [wPartyMenuActionText], a
	predef OpenPartyMenu_ClearGraphics
	push af

	ld hl, wTMHMMoveNameBackup
	ld de, wStringBuffer2
	ld bc, MOVE_NAME_LENGTH
	call CopyBytes

	pop af
	jr nc, .TeachTMHM
	jp .done

.TeachTMHM:
	predef CanLearnTMHMMove
	push bc
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	pop bc

	ld a, c
	and a
	jr nz, .compatible
	push de
	ld de, SFX_WRONG
	call PlaySFX
	pop de
	ld hl, TMHMNotCompatibleText
	call PrintText
	jr .loopback

.compatible
	callfar KnowsMove
	jr c, .loopback
	predef LearnMove
	ld a, b
	and a
	jr z, .cancel
	call ConsumeTM
	jr .done

.cancel
	ld a, $2
	ld [wItemEffectSucceeded], a
.done
	call ClearBGPalettes
	call ClearSprites
	ld hl, wStateFlags
	set SPRITE_UPDATES_DISABLED_F, [hl]
	call RestoreScreenAndReloadTiles
	call GetMemSGBLayout
	ret

BootedTMText:
	text "<TM>を　きどうした！"
	prompt

Unreferenced_BootedHMText:
	text "ひでんマシンを　きどうした！"

ContainedMoveText:
	text "なかには　@"
	text_from_ram wStringBuffer2
	text "が"
	line "きろくされていた！"

	para "@"
	text_from_ram wStringBuffer2
	text "を"
	line "#に　おぼえさせますか？"
	done

TMHMNotCompatibleText:
	text_from_ram wStringBuffer1
	text "と　@"
	text_from_ram wStringBuffer2
	text "は"
	line "あいしょうが　わるかった！"

	para "@"
	text_from_ram wStringBuffer2
	text "は　おぼえられない！"
	prompt
	db $02, $04, $00, $01
	db $0c, $20
	db $c3

TM_HolderLoop:
	xor a
	ldh [hBGMapMode], a
	call TMHolder_DisplayItems
	ld a, 2
	ld [w2DMenuCursorInitY], a
	ld a, 4
	ld [w2DMenuCursorInitX], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld a, 4
	sub d
	inc a
	cp 5
	jr nz, .okay
	dec a

.okay
	ld [w2DMenuNumRows], a
	ld a, _2DMENU_EXIT_UP | _2DMENU_EXIT_DOWN
	ld [w2DMenuFlags1], a
	xor a
	ld [w2DMenuFlags2], a
	ld a, $20
	ld [w2DMenuCursorOffsets], a
	ld a, D_UP | D_DOWN | A_BUTTON | B_BUTTON
	ld [wMenuJoypadFilter], a
	ld a, [wTMHolderCursor]
	inc a
	ld [wMenuCursorY], a
	ld a, 1
	ld [wMenuCursorX], a
	jr TMHolder_ShowTMMoveDescription

TMHolder_JoypadLoop:
	call TMHolder_DisplayItems

TMHolder_JoypadLoop_SkipDisplay:
	call WaitBGMap
	ld a, $1
	ldh [hBGMapMode], a
	call StaticMenuJoypad
	ld b, a
	ld a, [wMenuCursorY]
	dec a
	ld [wTMHolderCursor], a
	xor a
	ldh [hBGMapMode], a
	ld a, [w2DMenuFlags2]
	bit _2DMENU_EXITING_F, a
	jp nz, TMHM_ScrollHolder
	ld a, b
	bit A_BUTTON_F, a
	jp nz, TMHM_CheckHoveringOverCancel
	bit B_BUTTON_F, a
	jp nz, ExitTMHolder

TMHolder_ShowTMMoveDescription:
	call TMHM_CheckHoveringOverCancel
	hlcoord 0, 10
	ld b, 6
	ld c, SCREEN_WIDTH - 2
	call DrawTextBox
	call UpdateSprites

	ld a, [wCurItem]
	cp NUM_TM_HM + 1
	jr nc, TMHolder_JoypadLoop_SkipDisplay

	ld [wTempTMHM], a
	hlcoord 1, 12
	ld de, TMHM_TypeString
	call PlaceString
	predef GetTMHMMove
	ld a, [wTempTMHM]

	ld [wSelectedItem], a
	ld b, a
	hlcoord 5, 12
	predef PrintMoveType
	hlcoord 1, 14
	call PrintMoveDescription

	hlcoord 11, 12
	ld de, TMHM_PowerString
	call PlaceString

	ld a, [wSelectedItem]
	dec a
	ld hl, Moves + MOVE_POWER
	ld bc, MOVE_LENGTH
	call AddNTimes

	ld a, BANK(Moves)
	call GetFarByte
	hlcoord 16, 12
	cp 2
	jr c, .no_power
; Store the power of the move in wTempByteValue.
	ld [wTempByteValue], a
	ld de, wTempByteValue
	lb bc, 1, 3
	call PrintNumber
	jp TMHolder_JoypadLoop

.no_power
	ld de, TMHM_ThreeDashesString
	call PlaceString
	jp TMHolder_JoypadLoop

TMHM_CheckHoveringOverCancel:
	call TMHM_GetCurrentHolderPosition
	ld a, [wMenuCursorY]
	ld b, a

.loop
	inc c
	ld a, c
	cp NUM_TM_HM + 1
	jr nc, .okay
	ld a, [hli]
	and a
	jr z, .loop
	dec b
	jr nz, .loop
	ld a, c

.okay
	ld [wCurItem], a
	cp -1
	ret

ExitTMHolder:
	and a
	ret

TMHM_ScrollHolder:
	ld a, b
	bit D_DOWN_F, a
	jr nz, .down
	ld hl, wTMHolderScrollPosition
	ld a, [hl]
	and a
	jp z, TMHolder_JoypadLoop
	dec [hl]
	call TMHolder_DisplayItems
	jp TMHolder_ShowTMMoveDescription

.down
	call TMHM_GetCurrentHolderPosition
	ld b, $5
.loop:
	inc c
	ld a, c
	cp NUM_TM_HM + 1
	jp nc, TMHolder_JoypadLoop
	ld a, [hli]
	and a
	jr z, .loop
	dec b
	jr nz, .loop
	ld hl, wTMHolderScrollPosition
	inc [hl]
	call TMHolder_DisplayItems
	jp TMHolder_ShowTMMoveDescription

TMHM_PowerString:
	db "いりょく／@"

TMHM_ThreeDashesString:
	db "ーーー@"

TMHM_TypeString:
	db "タイプ／@"

TMHolder_DisplayItems:
	hlcoord 3, 0
	ld b, 8
	ld c, 15
	call DrawTextBox
	call TMHM_GetCurrentHolderPosition
	ld d, 4

.next
	inc c
	ld a, c
	cp NUM_TM_HM + 1
	jr nc, .cancel
	ld a, [hli]
	and a
	jr z, .next

	ld b, a
	ld a, c
	ld [wTempTMHM], a
	push hl
	push de
	push bc
	call .GetCurrentLineCoord
	push hl

	ld de, wTempTMHM
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNumber
	predef GetTMHMMove
	ld a, [wTempTMHM]
	ld [wPutativeTMHMMove], a
	call GetMoveName

	pop hl
	ld bc, $3
	add hl, bc
	push hl
	call PlaceString

	pop hl
	ld bc, $8
	add hl, bc
	ld [hl], '×'
	inc hl
	ld a, '０'

	pop bc
	push bc
	ld a, b
	ld [wTempTMHM], a
	ld de, wTempTMHM
	lb bc, 1, 2
	call PrintNumber

	pop bc
	pop de
	pop hl
	dec d
	jr nz, .next
	jr .done

.cancel
	call .GetCurrentLineCoord
; Write "CANCEL"
	ld a, 'や'
	ld [hli], a
	ld a, 'め'
	ld [hli], a
	ld [hl], 'る'
.done
	ret

.GetCurrentLineCoord:
	hlcoord 5, 0
	ld bc, SCREEN_WIDTH * 2
	ld a, 5
	sub d
	ld d, a
.line_loop
	add hl, bc
	dec d
	jr nz, .line_loop
	ret

TMHM_GetCurrentHolderPosition:
	ld hl, wTMsHMs
	ld a, [wTMHolderScrollPosition]
	ld b, a
	inc b
	ld c, 0
.loop
	inc c
	ld a, [hli]
	and a
	jr z, .loop
	dec b
	jr nz, .loop
	dec hl
	dec c
	ret

Unreferenced_VerboseReceiveTMHM_Old:
	call .CheckHaveRoomForTMHM
	ld hl, .NoRoomTMHMText
	jr nc, .full
	ld hl, .ReceivedTMHMText

.full
	jp PrintText

.NoRoomTMHMText:
	text_from_ram wStringBuffer1
	text "は　これいじょう"
	line "もてません！"
	prompt

.ReceivedTMHMText:
	text_from_ram wStringBuffer1
	text "を　てにいれた！"
	prompt

.CheckHaveRoomForTMHM:
	ld a, [wCurItem]
	dec a
	ld hl, wTMsHMs
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	inc a
	cp 10
	ret nc
	ld [hl], a
	ret

ConsumeTM:
	ld a, [wCurItem]
	dec a
	ld hl, wTMsHMs
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	and a
	ret z
	dec a
	ld [hl], a
	ret nz
	ld [wTMHolderScrollPosition], a
	ret
