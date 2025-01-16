
INCLUDE "constants.asm"

; TODO - need to constantize tile ids, movements

SECTION "engine/events/field_moves.asm", ROMX

CutFunction:
	call .ResetScriptID
.next
	call .ExecScript
	jr nc, .next
	ld [wFieldMoveSucceeded], a
	ret
.ResetScriptID
	xor a
	ld [wFieldMoveScriptID], a
	ret
.ExecScript
	ld a, [wFieldMoveScriptID]
	ld hl, .CutScriptTable
	jp CallJumptable

.CutScriptTable
	init_script_table
	add_script TryCut
	add_script CheckCuttableBlock
	add_script CheckCuttableTile
	add_script DoCut
	add_script DoCut2
	add_script FailCut

TryCut:
	call GetMapEnvironment
	cp ROUTE
	jr z, .success
	cp TOWN
	jr z, .success
	set_script FailCut
	xor a
	ret
.success
	set_script CheckCuttableBlock
	xor a
	ret

CheckCuttableBlock:
	call GetFacingTileCoord
	cp $80
	jr nz, .fail
	call GetBlockLocation
	ld a, l
	ld [wMapBlocksAddress], a
	ld a, h
	ld [wMapBlocksAddress + 1], a
	ld a, [hl]
	call GetCutReplacementBlock
	jr nc, .fail
	dec hl
	ld a, [hl]
	ld [wReplacementBlock], a
	set_script DoCut2
	xor a
	ret
.fail
	set_script CheckCuttableTile
	xor a
	ret

GetCutReplacementBlock:
	ld c, a
	ld hl, CutReplacementBlocks
.loop
	ld a, [hli]
	cp -1
	ret z
	inc hl
	cp c
	jr nz, .loop
	scf
	ret

CutReplacementBlocks:
; replacement block, facing block
	db $30, $25
	db $31, $2A
	db $32, $34
	db $33, $35
	db -1

CheckCuttableTile:
	call GetFacingTileCoord
	call IsCuttableTile
	jr nc, .fail
	call GetBlockLocation
	ld a, [hl]
	cp $3b
	jr nz, .fail
	ld a, l
	ld [wMapBlocksAddress], a
	ld a, h
	ld [wMapBlocksAddress + 1], a
	ld a, $04
	ld [wReplacementBlock], a
	set_script DoCut
	xor a
	ret
.fail
	set_script FailCut
	xor a
	ret

IsCuttableTile:
	ld hl, CuttableTiles
	ld c, a
.loop
	ld a, [hli]
	cp -1
	ret z
	cp c
	jr nz, .loop
	scf
	ret

CuttableTiles:
	db $81
	db $82
	db $8A
	db $8B
	db -1

FailCut:
	ld hl, Text_CantUseCutHere
	call MenuTextBoxBackup
	scf
	ld a, SCRIPT_FAIL
	ret

Text_CantUseCutHere:
	text "ここでは　つかえません"
	prompt

DoCut:
DoCut2:
	far_queue CutScript
	scf
	ld a, SCRIPT_SUCCESS
	ret

CutScript:
	call RefreshScreen
	ld hl, wPartyMonNicknames
	ld a, BOXMON
	ld [wMonType], a
	ld a, [wCurPartyMon]
	call GetNick
	call CopyStringToStringBuffer2
	ld hl, Text_CutItDown
	call MenuTextBoxBackup
	ld de, MUSIC_SURF
	call PlaySFX
	ld hl, wMapBlocksAddress
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wReplacementBlock]
	ld [hl], a
	call LoadMapPart
	call UpdateSprites
	call WaitBGMap
	call Function1fea
	scf
	ret

Text_CutItDown:
	text_from_ram wStringBuffer2
	text "　は　"
	line "くさかりを　つかった！"
	prompt

SurfFunction:
	call .ResetScriptID
.next
	call .ExecScript
	jr nc, .next
	ld [wFieldMoveSucceeded], a
	ret
.ResetScriptID
	xor a
	ld [wFieldMoveScriptID], a
	ret
.ExecScript
	ld a, [wFieldMoveScriptID]
	ld hl, .SurfScriptTable
	jp CallJumptable

.SurfScriptTable:
	init_script_table
	add_script TrySurf
	add_script DoSurf
	add_script FailSurf

TrySurf:
	call GetFacingTileCoord
	and $f0
	cp $20
	jr z, .success
	cp $40
	jr z, .success
	set_script FailSurf
	xor a
	ret
.success
	set_script DoSurf
	xor a
	ret

DoSurf:
	queue_ba SurfScript
	ld a, -1
	ld [wFieldMoveScriptID], a
	scf
	ld a, SCRIPT_SUCCESS
	ret

FailSurf:
	ld hl, Text_CantSurfHere
	call MenuTextBoxBackup
	ld a, -1
	ld [wFieldMoveScriptID], a
	scf
	ld a, SCRIPT_FAIL
	ret

Text_CantSurfHere:
	text "ここでは　のることが"
	next "できません"
	prompt

SurfScript:
	call RefreshScreen
	ld hl, wPartyMonNicknames
	ld a, BOXMON
	ld [wMonType], a
	ld a, [wCurPartyMon]
	call GetNick
	call CopyStringToStringBuffer2
	ld hl, Text_UsedSurf
	call MenuTextBoxBackup
	ld a, PLAYER_SURF
	ld [wPlayerState], a
	call RedrawPlayerSprite
	call PlayMapMusic
	call MovePlayerIntoWater
	call Function1fea
	ret

Text_UsedSurf:
	text_from_ram wStringBuffer2
	text "　は　"
	line "@"
	text_from_ram wPlayerName
	text "を　のせた！"
	prompt

MovePlayerIntoWater:
	call InitMovementBuffer
	call .get_movement_direction
	call AppendToMovementBuffer
	ld a, $32
	call AppendToMovementBuffer
	ld a, 0
	ld hl, wMovementBuffer
	call LoadMovementDataPointer
.get_movement_direction
	ld a, [wPlayerDirection]
	srl a
	srl a
	ld e, a
	ld d, $00
	ld hl, SurfMovementDirections
	add hl, de
	ld a, [hl]
	ret

; Direction to move player, mapped to facing direction
SurfMovementDirections:
	db 4, 5, 6, 7


FlyFunction:
	call .ResetScriptID
.next
	call .ExecScript
	jr nc, .next
	ld [wFieldMoveSucceeded], a
	ret
.ResetScriptID
	xor a
	ld [wFieldMoveScriptID], a
	ret
.ExecScript
	ld a, [wFieldMoveScriptID]
	ld hl, .FlyScriptTable
	jp CallJumptable

.FlyScriptTable:
	init_script_table
	add_script TryFly
	add_script ShowFlyMap
	add_script DoFly
	add_script FailFly

TryFly:
	call GetMapEnvironment
	cp TOWN
	jr z, .success
	cp ROUTE
	jr z, .success
	set_script FailFly
	xor a
	ret
.success
	set_script ShowFlyMap
	xor a
	ret

ShowFlyMap:
	call LoadStandardMenuHeader
	call ClearSprites
	callfar FlyMap
	call ClearPalettes
	call GetMemSGBLayout
	call ExitMenu
	ld a, [wFlyDestination]
	cp -1
	jr z, .dont_fly
	cp NUM_SPAWNS
	jr nc, .dont_fly
	set_script DoFly
	xor a
	ret
.dont_fly
	call UpdateTimePals
	ld a, -1
	ld [wFieldMoveScriptID], a
	scf
	ld a, SCRIPT_FAIL
	ret

DoFly:
	ld a, [wFlyDestination]
	inc a
	ld [wDefaultSpawnPoint], a
	queue_ba FlyScript
	ld a, -1
	ld [wFieldMoveScriptID], a
	scf
	ld a, SCRIPT_SUCCESS
	ret

FailFly:
	ld hl, Text_CantUseFlyHere
	call MenuTextBoxBackup
	ld a, -1
	ld [wFieldMoveScriptID], a
	scf
	ld a, SCRIPT_FAIL
	ret

Text_CantUseFlyHere:
	text "ここでは　つかえません！"
	prompt

FlyScript:
	ld a, MAPSETUP_TELEPORT
	ldh [hMapEntryMethod], a
	jpfar Functionfcc24


DigFunction:
	call .ResetScriptID
.next
	ld a, [wFieldMoveScriptID]
	bit SCRIPT_FINISHED_F, a
	jr nz, .finish
	ld hl, .DigScriptTable
	call CallJumptable
	jr .next

; Finish by returning only the low nibble
.finish
	and $FF - SCRIPT_FINISHED_MASK
	ld [wFieldMoveSucceeded], a
	ret

.ResetScriptID
	xor a
	ld [wFieldMoveScriptID], a
	ret

.DigScriptTable:
	init_script_table
	add_script CheckCanDig
	add_script DoDig
	add_script FailDig

CheckCanDig:
	call GetMapEnvironment
	cp INDOOR
	jr z, .success
	cp CAVE
	jr z, .success
	set_script FailDig
	ret
.success
	set_script DoDig
	ret

DoDig:
	queue_ab DigScript
	ld a, SCRIPT_FINISHED_MASK | SCRIPT_SUCCESS
	ld [wFieldMoveScriptID], a
	ret

FailDig:
	ld hl, Text_CantUseDigHere
	call MenuTextBoxBackup
	ld a, SCRIPT_FINISHED_MASK | SCRIPT_FAIL
	ld [wFieldMoveScriptID], a
	ret

Text_CantUseDigHere:
	text "ここでは　つかえません！"
	prompt

DigScript:
	ld hl, wDigWarpNumber
	ld de, wNextWarp
	ld bc, 3
	call CopyBytes
	ld a, MAPSETUP_WARP
	ldh [hMapEntryMethod], a
	jpfar Functionfcc24

EmptyFunctiond2da:
	ret

TeleportFunction:
	xor a
	ld [wFieldMoveScriptID], a
.next
	ld a, [wFieldMoveScriptID]
	bit SCRIPT_FINISHED_F, a
	jr nz, .finish
	ld hl, .TeleportScriptTable
	call CallJumptable
	jr .next

; Finish by returning only the low nibble
.finish
	and $FF - SCRIPT_FINISHED_MASK
	ld [wFieldMoveSucceeded], a
	ret

.TeleportScriptTable
	init_script_table
	add_script TryTeleport
	add_script DoTeleport
	add_script FailTeleport
	add_script CheckIfSpawnPoint

TryTeleport:
	call GetMapEnvironment
	cp TOWN
	jr z, .success
	cp ROUTE
	jr z, .success
	set_script FailTeleport
	ret
.success
	set_script CheckIfSpawnPoint
	ret

CheckIfSpawnPoint:
	ld a, [wLastSpawnMapGroup]
	ld d, a
	ld a, [wLastSpawnMapNumber]
	ld e, a
	callfar IsSpawnPoint
	jr c, .not_spawn
	ld hl, Text_CantFindDestination
	call MenuTextBoxBackup
	ld a, SCRIPT_FINISHED_MASK | SCRIPT_FAIL
	ld [wFieldMoveScriptID], a
	ret
.not_spawn
	ld a, c
	ld [wDefaultSpawnPoint], a
	set_script DoTeleport
	ret

Text_CantFindDestination:
	text "とびさきが　みつかりません"
	para ""
	done

DoTeleport:
	queue_ba TeleportScript
	ld a, SCRIPT_FINISHED_MASK | SCRIPT_SUCCESS
	ld [wFieldMoveScriptID], a
	ret

FailTeleport:
	ld hl, Text_CantUseTeleportHere
	call MenuTextBoxBackup
	ld a, SCRIPT_FINISHED_MASK | SCRIPT_FAIL
	ld [wFieldMoveScriptID], a
	scf
	ret

Text_CantUseTeleportHere:
	text "ここでは　つかえません！"
	para ""
	done

TeleportScript:
	call RefreshScreen
	ld hl, Text_ReturnToLastMonCenter
	call MenuTextBox
	ld c, 60
	call DelayFrames
	call CloseWindow
	call Function1fea
	ld a, MAPSETUP_TELEPORT
	ldh [hMapEntryMethod], a
	jpfar Functionfcc24

Text_ReturnToLastMonCenter:
	text "さいごに　たちよった"
	line "#センターにもどります"
	done
