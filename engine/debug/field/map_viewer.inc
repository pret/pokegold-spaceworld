; DebugMapViewer.Jumptable constants
	const_def
	const DEBUGMAPVIEWER_EMPTY                 ; 0
	const DEBUGMAPVIEWER_INIT                  ; 1
	const DEBUGMAPVIEWER_CONTROL_CURSOR        ; 2
	const DEBUGMAPVIEWER_MOVE_CURSOR_TO_PLAYER ; 3
	const DEBUGMAPVIEWER_WAIT_FINISHED_MOVING  ; 4
	const DEBUGMAPVIEWER_CLEANUP               ; 5

FieldDebug_OpenMapViewer:
	call .DoOpen
	jr c, .done
	ld a, FIELDDEBUG_RETURN_EXIT
	ret

.done
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.DoOpen:
	ld hl, .MapViewPrompt
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	ret c

	ldh a, [hROMBank]
	ld hl, .MapViewScript
	call QueueScript
	ret

.MapViewPrompt:
	text "マップビューワーを"
	line "しようしますか？"
	done

.MapViewScript:
	ld a, MAPSTATUS_DEBUG_MAP_VIEWER
	call SetMapStatus
	xor a
	ldh [hJoypadSum], a
	ld a, DEBUGMAPVIEWER_INIT
	ldh [hDebugMapViewerJumptable], a
	ret

DebugMapViewer::
	ld a, [wd153]
	ld b, a
	ld a, [wToolgearFlags]
	ld c, a
	push bc
	call EnableToolgearCoords
	call InitToolgearBuffer
.loop
	call GetJoypad
	call .do_jumptable
	jr c, .continue
	call HandleMapObjects
	jr nc, .loop
	callfar CheckObjectEnteringVisibleRange
	jr .loop

.continue
	ld a, MAPSTATUS_RETURN_TO_MAIN
	call SetMapStatus
	pop bc
	ld a, b
	ld [wd153], a
	ld a, c
	ld [wToolgearFlags], a
	ret

.do_jumptable
	ld a, [wDebugFlags]
	bit DEBUG_FIELD_F, a
	ret z
	ldh a, [hDebugMapViewerJumptable]
	and a
	ret z
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable:
	dw .Empty
	dw .Init
	dw .ControlCursor
	dw .MoveCursorToPlayer
	dw .WaitFinishedMoving
	dw .Cleanup

.Empty:
	ret

.Init:
	call FreezePlayer
	call DebugMapViewer_LoadCursorSprite
	call DebugMapViewer_ReplacePlayerObject
	ld a, movement_step_sleep
	ld [wMovementObject], a
	ld a, DEBUGMAPVIEWER_CONTROL_CURSOR
	ldh [hDebugMapViewerJumptable], a
	and a
	ret

.ControlCursor:
	ldh a, [hJoypadSum]
	ld b, a
	xor a
	ldh [hJoypadSum], a
	ld a, b
	and START
	jr nz, .start_pressed
	ldh a, [hJoyState]
	and A_BUTTON
	jr nz, .a_pressed
	call DebugMapViewer_DoMovement
	jr .apply_movement
.start_pressed
	call DebugMapViewer_ShowViewerPrompt
	ld a, movement_step_sleep
	jr .apply_movement
.a_pressed
	call DebugMapViewer_ShowSelectedDetails
	ld a, movement_step_sleep
.apply_movement
	ld [wMovementObject], a
	and a
	ret

.MoveCursorToPlayer:
	ld a, MAP_VIEWER_CURSOR
	ld hl, wMovementBuffer
	call LoadMovementDataPointer
	ld d, STEP_BIKE
	ld b, MAP_VIEWER_CURSOR
	ld c, PLAYER
	callfar ObjectWalkToPlayer
	ld a, DEBUGMAPVIEWER_WAIT_FINISHED_MOVING
	ldh [hDebugMapViewerJumptable], a
	and a
	ret

.WaitFinishedMoving:
	ld hl, wStateFlags
	bit SCRIPTED_MOVEMENT_STATE_F, [hl]
	jr nz, .skip
	ld a, DEBUGMAPVIEWER_CLEANUP
	ldh [hDebugMapViewerJumptable], a
.skip
	and a
	ret

.Cleanup:
	ld a, MAP_VIEWER_CURSOR
	call DeleteMapObject
	call UnfreezePlayer
	ld a, PLAYER
	call CenterObject
	xor a
	ldh [hDebugMapViewerJumptable], a
	scf
	ret

DebugMapViewer_ShowViewerPrompt:
	call RefreshScreen
	ld hl, .ChangeViewerPrompt
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	jr c, .no
	ld a, DEBUGMAPVIEWER_MOVE_CURSOR_TO_PLAYER
	ldh [hDebugMapViewerJumptable], a
.no
	call ScreenCleanup
	ret

.ChangeViewerPrompt:
	text "ビューワーモードを"
	line "かいじょ　しますか？"
	done

DebugMapViewer_ShowSelectedDetails:
	ld a, 0
	ldh [hTextBoxCursorBlinkInterval], a
	ld bc, wObjectStructs
	callfar WillObjectBumpIntoSomeoneElse
	jr nc, .skip
	call RefreshScreen
	call .DisplayActorCastID
	call ScreenCleanup
	ret
.skip
	call DisplayBGEventDetails
	ret

.DisplayActorCastID:
	ld hl, .ActorCastText
	call MenuTextBox

; Display index of selected object from map objects
; (referred to as "actor number")
	ld de, hEventID
	hlcoord 10, 14
	lb bc, 1, 2
	call PrintNumber

; Display index of selected object from visible objects
; (referred to as "cast number")
	ldh a, [hEventID]
	call GetObjectStruct
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	cp NUM_OBJECTS
	jr nc, .invalid_index
	ld d, h
	ld e, l
	hlcoord 10, 16
	lb bc, 1, 2
	call PrintNumber
	jr .wait

.invalid_index
	hlcoord 10, 16
	ld de, .NoneText
	call PlaceString

.wait
	ld a, BUTTONS
	call FieldDebug_WaitJoypadInput
	call CloseWindow
	ret

.ActorCastText:
	text "アクターナンバー　　　　"
	line "キャストナンバー　　　　"
	done

.NoneText:
	db "なし@"

DebugMapViewer_DoMovement:
	ld bc, wObjectStructs
	ldh a, [hJoyState]
	ld d, a
	bit D_DOWN_F, a
	jr nz, .down
	bit D_UP_F, a
	jr nz, .up
	bit D_LEFT_F, a
	jr nz, .left
	bit D_RIGHT_F, a
	jr nz, .right
.done
	ld a, movement_step_sleep
	ret

.down
	ld a, [wMapHeight]
	add a
	add 4
	ld e, a
	ld hl, $11
	add hl, bc
	ld a, [hl]
	inc a
	cp e
	jr nc, .done
	bit 1, d
	ld a, $c
	ret nz
	ld a, 8
	ret

.up
	ld hl, $11
	add hl, bc
	ld a, [hl]
	dec a
	cp 4
	jr c, .done
	bit 1, d
	ld a, $d
	ret nz
	ld a, 9
	ret

.left
	ld hl, $10
	add hl, bc
	ld a, [hl]
	dec a
	cp 4
	jr c, .done
	bit 1, d
	ld a, $e
	ret nz
	ld a, $a
	ret

.right
	ld a, [wMapWidth]
	add a
	add 4
	ld e, a
	ld hl, $10
	add hl, bc
	ld a, [hl]
	inc a
	cp e
	jr nc, .done
	bit 1, d
	ld a, $f
	ret nz
	ld a, $b
	ret

DebugMapViewer_ReplacePlayerObject:
	callfar DebugMapViewer_SetupCursor
	ld a, MAP_VIEWER_CURSOR
	call CopyMapObjectToReservedObjectStruct
	ld a, MAP_VIEWER_CURSOR
	call CenterObject
	ld bc, wReservedObjectStruct
	ld hl, OBJECT_FLAGS1
	add hl, bc
	set SLIDING_F, [hl]
	set FIXED_FACING_F, [hl]
	set WONT_DELETE_F, [hl]
	ret

; Already handled by DebugMapViewer_SetupCursor
.Unreferenced_CursorObjectTemplate:
	object_event -4, -4, SPRITE_GOLD, $17, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0
	ds 2

DebugMapViewer_LoadCursorSprite:
	ldh a, [hBGMapMode]
	push af
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hBGMapMode], a
	ld de, TownMapCursorGFX
	ld hl, vChars0 tile $0c
	lb bc, BANK(TownMapCursorGFX), 4
	call Get2bpp
	pop af
	ldh [hMapAnims], a
	pop af
	ldh [hBGMapMode], a
	ret

SECTION "engine/debug/field/map_viewer.inc@DisplayBGEventDetails", ROMX

DisplayBGEventDetails:
	call GetBGEvent
	ret nc
	call .Functionfd0cc
	call RefreshScreen
	ld hl, .TableText
	call MenuTextBox
	call .PrintTableDetails
	call .WaitInput
	call CloseWindow
	call ScreenCleanup
	ret

.Functionfd0cc:
	ld a, [hld]
	ld [wFieldMoveScriptID], a
	ld a, [hl]
	ld [wcdc8], a
	ld a, d
	ld [wMapBlocksAddress], a
	ld a, e
	ld [wHPBarOldHP], a
	ld a, b
	ld [wReplacementBlock], a
	ld a, [wCurMapBGEventCount]
	sub c
	inc a
	ld [wHPBarNewHP], a
	ret

.TableText:
	text "テーブル"
	done

.PrintTableDetails:
	hlcoord 8, 14
	ld de, wMapBlocksAddress
	call PrintHexByte

	hlcoord 11, 14
	ld de, wHPBarOldHP
	call PrintHexByte

	hlcoord 14, 14
	ld de, wcdc8
	call PrintHexByte

	hlcoord 17, 14
	ld de, wFieldMoveScriptID
	ld bc, $8102
	call PrintNumber

	hlcoord 14, 16
	ld de, wReplacementBlock
	call PrintHexByte

	hlcoord 17, 16
	ld de, wHPBarNewHP
	ld bc, $8102
	call PrintNumber

	ret

.WaitInput:
	call GetJoypad
	ldh a, [hJoyDown]
	and A_BUTTON | B_BUTTON | SELECT
	jr z, .WaitInput
	ret

