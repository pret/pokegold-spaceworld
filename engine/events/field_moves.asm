INCLUDE "constants.asm"

; TODO - need to constantize tile ids, movements

SECTION "Field Moves", ROMX[$4fab], BANK[$03]

CutFunction: ; 03:4fab
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
	
.CutScriptTable ; 03:4fc5
	init_script_table
	add_script TryCut
	add_script CheckCuttableBlock
	add_script CheckCuttableTile
	add_script DoCut
	add_script DoCut2
	add_script FailCut

TryCut: ; 03:4fd1
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

CheckCuttableBlock: ; 03:4fea
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

GetCutReplacementBlock: ; 03:5015
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
	
CutReplacementBlocks: ; 03:5023
; replacement block, facing block
	db $30, $25
	db $31, $2A
	db $32, $34
	db $33, $35
	db -1

CheckCuttableTile: ; 03:502c
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
	
IsCuttableTile: ; 03:5057
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
	
CuttableTiles: ; 03:5064
	db $81
	db $82
	db $8A
	db $8B
	db -1

FailCut: ; 03:5069
	ld hl, Text_CantUseCutHere
	call MenuTextBoxBackup
	scf
	ld a, SCRIPT_FAIL
	ret
	
Text_CantUseCutHere: ; 03:5073
	text "ここでは　つかえません"
	prompt

DoCut:
DoCut2: ; 03:5080
	far_queue CutScript
	scf
	ld a, SCRIPT_SUCCESS
	ret

CutScript: ; 03:508C
	call RefreshScreen
	ld hl, wPartyMonNicknames
	ld a, BOXMON
	ld [wMonType], a
	ld a, [wWhichPokemon]
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
	
Text_CutItDown ; 03:50c4
	text_from_ram wStringBuffer2
	text "　は　"
	line "くさかりを　つかった！"
	prompt	

SurfFunction: ; 03:50d8
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

.SurfScriptTable: ; 03:50f2
	init_script_table
	add_script TrySurf
	add_script DoSurf
	add_script FailSurf

TrySurf: ; 03:50f8
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

DoSurf: ; 03:5113
	queue_ba SurfScript
	ld a, -1
	ld [wFieldMoveScriptID], a
	scf
	ld a, SCRIPT_SUCCESS
	ret

FailSurf: ; 03:5124
	ld hl, Text_CantSurfHere
	call MenuTextBoxBackup
	ld a, -1
	ld [wFieldMoveScriptID], a
	scf
	ld a, SCRIPT_FAIL
	ret

Text_CantSurfHere: ; 03:5133
	text "ここでは　のることが"
	next "できません"
	prompt
	
SurfScript: ; 03:5145
	call RefreshScreen
	ld hl, wPartyMonNicknames
	ld a, BOXMON
	ld [wMonType], a
	ld a, [wWhichPokemon]
	call GetNick
	call CopyStringToStringBuffer2
	ld hl, Text_UsedSurf
	call MenuTextBoxBackup
	ld a, PLAYER_SURF
	ld [wPlayerState], a
	call Function0d02
	call PlayMapMusic
	call MovePlayerIntoWater
	call Function1fea
	ret

Text_UsedSurf: ; 03:5171
	text_from_ram wStringBuffer2
	text "　は　"
	line "@"
	text_from_ram wPlayerName
	text "を　のせた！"
	prompt
	
MovePlayerIntoWater: ; 03:5185
	call InitMovementBuffer
	call .get_movement_direction
	call AppendToMovementBuffer
	ld a, $32
	call AppendToMovementBuffer
	ld a, 0
	ld hl, wMovementBuffer
	call LoadMovementDataPointer
.get_movement_direction
	ld a, [wPlayerWalking]
	srl a
	srl a
	ld e, a
	ld d, $00
	ld hl, SurfMovementDirections
	add hl, de
	ld a, [hl]
	ret

; Direction to move player, mapped to facing direction
SurfMovementDirections: ; 03:51ab
	db 4, 5, 6, 7


FlyFunction: ; 03:51af
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

.FlyScriptTable: ; 03:51c9
	init_script_table
	add_script TryFly
	add_script ShowFlyMap
	add_script DoFly
	add_script FailFly

TryFly: ; 03:51d1
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

ShowFlyMap: ; 03:51ea
	call LoadStandardMenuHeader
	call ClearSprites
	callab FlyMap
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

DoFly: ; 03:521f
	ld a, [wFlyDestination]
	inc a
	ld [wDefaultSpawnPoint], a
	queue_ba FlyScript
	ld a, -1
	ld [wFieldMoveScriptID], a
	scf
	ld a, SCRIPT_SUCCESS
	ret

FailFly: ; 03:5237
	ld hl, Text_CantUseFlyHere
	call MenuTextBoxBackup
	ld a, -1
	ld [wFieldMoveScriptID], a
	scf
	ld a, SCRIPT_FAIL
	ret

Text_CantUseFlyHere: ; 03:5246
	text "ここでは　つかえません！"
	prompt

FlyScript: ; 03:5254
	ld a, MAPSETUP_TELEPORT
	ldh [hMapEntryMethod], a
	jpab Functionfcc24

	
DigFunction: ; 03:5260
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

.DigScriptTable: ; 03:527D
	init_script_table
	add_script CheckCanDig
	add_script DoDig
	add_script FailDig

CheckCanDig: ; 03:5283
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

DoDig: ; 03:529a
	queue_ab DigScript
	ld a, SCRIPT_FINISHED_MASK | SCRIPT_SUCCESS
	ld [wFieldMoveScriptID], a
	ret

FailDig: ; 03:52a8
	ld hl, Text_CantUseDigHere
	call MenuTextBoxBackup
	ld a, SCRIPT_FINISHED_MASK | SCRIPT_FAIL
	ld [wFieldMoveScriptID], a
	ret

Text_CantUseDigHere: ; 03:52b4
	text "ここでは　つかえません！"
	prompt
	
DigScript: ; 03:52c2
	ld hl, wDigWarpNumber
	ld de, wNextWarp
	ld bc, 3
	call CopyBytes
	ld a, MAPSETUP_WARP
	ldh [hMapEntryMethod], a
	jpab Functionfcc24

EmptyFunctiond2da: ; 03:52da
	ret
	
TeleportFunction: ; 03:52db
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

TryTeleport: ; 03:52fc
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
	
CheckIfSpawnPoint ; 03:5313
	ld a, [wLastSpawnMapGroup]
	ld d, a
	ld a, [wLastSpawnMapNumber]
	ld e, a
	callab IsSpawnPoint
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

Text_CantFindDestination: ; 03:533B
	text "とびさきが　みつかりません"
	para ""
	done

DoTeleport: ; 03:534b
	queue_ba TeleportScript
	ld a, SCRIPT_FINISHED_MASK | SCRIPT_SUCCESS
	ld [wFieldMoveScriptID], a
	ret

FailTeleport: ; 03:5359
	ld hl, Text_CantUseTeleportHere
	call MenuTextBoxBackup
	ld a, SCRIPT_FINISHED_MASK | SCRIPT_FAIL
	ld [wFieldMoveScriptID], a
	scf
	ret

Text_CantUseTeleportHere: ; 03:5366
	text "ここでは　つかえません！"
	para ""
	done

TeleportScript: ; 03:5375
	call RefreshScreen
	ld hl, Text_ReturnToLastMonCenter
	call MenuTextBox
	ld c, 60
	call DelayFrames
	call CloseWindow
	call Function1fea
	ld a, MAPSETUP_TELEPORT
	ldh [hMapEntryMethod], a
	jpab Functionfcc24
	
Text_ReturnToLastMonCenter: ; 03:5395
	text "さいごに　たちよった"
	line "#センターにもどります"
	done
