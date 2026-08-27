MACRO def_field_scripts
	DEF field_script_id = 0
ENDM

MACRO field_script
	dw \1
	DEF \1ScriptID = field_script_id
	DEF field_script_id += 1
ENDM

MACRO set_field_script
	ld a, \1ScriptID
	ld [wFieldMoveScriptID], a
ENDM

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
	ld hl, CutScriptTable
	jp CallJumptable

CutScriptTable:
	def_field_scripts
	field_script TryCut
	field_script CheckCuttableBlock
	field_script CheckCuttableTile
	field_script DoCut
	field_script DoCut2
	field_script FailCut

TryCut:
	call GetMapEnvironment
	cp ROUTE
	jr z, .success
	cp TOWN
	jr z, .success
	set_field_script FailCut
	xor a
	ret

.success
	set_field_script CheckCuttableBlock
	xor a
	ret

CheckCuttableBlock:
	call GetFacingTileCoord
	cp COLL_OLD_CUT_TREE
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
	set_field_script DoCut2
	xor a
	ret

.fail
	set_field_script CheckCuttableTile
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

INCLUDE "data/collision/cut_blocks.asm"

CheckCuttableTile:
	call GetFacingTileCoord
	call IsCuttableTile
	jr nc, .fail
	call GetBlockLocation
	ld a, [hl]
	cp BLOCK_TALL_GRASS
	jr nz, .fail
	ld a, l
	ld [wMapBlocksAddress], a
	ld a, h
	ld [wMapBlocksAddress + 1], a
	ld a, BLOCK_GRASS
	ld [wReplacementBlock], a
	set_field_script DoCut
	xor a
	ret

.fail
	set_field_script FailCut
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
	db COLL_OLD_GRASS_81
	db COLL_OLD_GRASS_82
	db COLL_OLD_GRASS_82 | COLLFLAG_ENCOUNTER
	db COLL_OLD_GRASS    | COLLFLAG_ENCOUNTER
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
	ld hl, CutScript
	ld a, BANK(CutScript)
	call QueueScript
	scf
	ld a, SCRIPT_SUCCESS
	ret

CutScript:
	call ReanchorMap
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
	call CloseText
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
	def_field_scripts
	field_script TrySurf
	field_script DoSurf
	field_script FailSurf

TrySurf:
	call GetFacingTileCoord
	and COLLMASK_TYPE
	cp COLLMASK_TYPE_OLD_WATER
	jr z, .success
	cp COLLMASK_TYPE_OLD_WATER_ALT
	jr z, .success
	set_field_script FailSurf
	xor a
	ret

.success
	set_field_script DoSurf
	xor a
	ret

DoSurf:
	ldh a, [hROMBank]
	ld hl, SurfScript
	call QueueScript
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
	call ReanchorMap
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
	call CloseText
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
	ld a, movement_step_end
	call AppendToMovementBuffer
	ld a, 0
	ld hl, wMovementBuffer
	call LoadMovementDataPointer
.get_movement_direction
	ld a, [wPlayerDirection]
	srl a
	srl a
	ld e, a
	ld d, 0
	ld hl, SurfMovementSteps
	add hl, de
	ld a, [hl]
	ret

SurfMovementSteps:
	db movement_slow_step | DOWN
	db movement_slow_step | UP
	db movement_slow_step | LEFT
	db movement_slow_step | RIGHT

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
	def_field_scripts
	field_script TryFly
	field_script ShowFlyMap
	field_script DoFly
	field_script FailFly

TryFly:
	call GetMapEnvironment
	cp TOWN
	jr z, .success
	cp ROUTE
	jr z, .success
	set_field_script FailFly
	xor a
	ret

.success
	set_field_script ShowFlyMap
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
	cp FLY_POINT_N_A
	jr z, .dont_fly
	cp NUM_FLYPOINTS
	jr nc, .dont_fly
	set_field_script DoFly
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
	ldh a, [hROMBank]
	ld hl, FlyScript
	call QueueScript
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
	jpfar DoTeleportAnimation

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
	and ~SCRIPT_FINISHED_MASK
	ld [wFieldMoveSucceeded], a
	ret

.ResetScriptID
	xor a
	ld [wFieldMoveScriptID], a
	ret

.DigScriptTable:
	def_field_scripts
	field_script CheckCanDig
	field_script DoDig
	field_script FailDig

CheckCanDig:
	call GetMapEnvironment
	cp INDOOR
	jr z, .success
	cp CAVE
	jr z, .success
	set_field_script FailDig
	ret

.success
	set_field_script DoDig
	ret

DoDig:
	ld hl, DigScript
	ldh a, [hROMBank]
	call QueueScript
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
	jpfar DoTeleportAnimation
	ret ; useless ret

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
	and ~SCRIPT_FINISHED_MASK
	ld [wFieldMoveSucceeded], a
	ret

.TeleportScriptTable
	def_field_scripts
	field_script TryTeleport
	field_script DoTeleport
	field_script FailTeleport
	field_script CheckIfSpawnPoint

TryTeleport:
	call GetMapEnvironment
	cp TOWN
	jr z, .success
	cp ROUTE
	jr z, .success
	set_field_script FailTeleport
	ret

.success
	set_field_script CheckIfSpawnPoint
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
	set_field_script DoTeleport
	ret

Text_CantFindDestination:
	text "とびさきが　みつかりません"

	para ""
	done

DoTeleport:
	ldh a, [hROMBank]
	ld hl, TeleportScript
	call QueueScript
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
	call ReanchorMap
	ld hl, Text_ReturnToLastMonCenter
	call MenuTextBox
	ld c, 60
	call DelayFrames
	call CloseWindow
	call CloseText
	ld a, MAPSETUP_TELEPORT
	ldh [hMapEntryMethod], a
	jpfar DoTeleportAnimation

Text_ReturnToLastMonCenter:
	text "さいごに　たちよった"
	line "#センターにもどります"
	done
