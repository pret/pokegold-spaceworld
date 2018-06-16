INCLUDE "constants.asm"

SECTION "FlyFunction", ROMX[$51af], BANK[$03]

; Sets wFieldMoveSucceeded to $f if successful, $0 if not
FlyFunction: ; 03:51af
	call .reset
.loop
	call .next
	jr nc, .loop
	ld [wFieldMoveSucceeded], a
	ret
.reset
	xor a
	ld [wFieldMoveScriptID], a
	ret
.next
	ld a, [wFieldMoveScriptID]
	ld hl, .FlyTable
	jp CallJumptable

.FlyTable ; 03:51c9
	dw .TryFly
	dw .ShowFlyMap
	dw .DoFly
	dw .FailFly

.TryFly: ; 03:51d1
	call GetMapEnvironment
	cp TOWN
	jr z, .success
	cp ROUTE
	jr z, .success
	ld a, SCRIPT_ID_03
	ld [wFieldMoveScriptID], a
	xor a
	ret
.success: ; 03:51e3
	ld a, SCRIPT_ID_01
	ld [wFieldMoveScriptID], a
	xor a
	ret

.ShowFlyMap: ; 03:51ea
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
	ld a, SCRIPT_ID_02
	ld [wFieldMoveScriptID], a
	xor a
	ret

.dont_fly: ; 03:5213
	call UpdateTimePals
	ld a, SCRIPT_FINISHED
	ld [wFieldMoveScriptID], a
	scf
	ld a, SCRIPT_FAIL
	ret

.DoFly: ; 03:521f
	ld a, [wFlyDestination]
	inc a
	ld [wDefaultSpawnPoint], a
	ldh a, [hROMBank]
	ld hl, .FlyScript
	call QueueScript
	ld a, -1
	ld [wFieldMoveScriptID], a
	scf
	ld a, SCRIPT_SUCCESS
	ret

.FailFly: ; 03:5237
	ld hl, .Text_CantUseFlyHere
	call MenuTextBoxBackup
	ld a, SCRIPT_FINISHED
	ld [wFieldMoveScriptID], a
	scf
	ld a, SCRIPT_FAIL
	ret

.Text_CantUseFlyHere: ; 03:5246
	text "ここでは　つかえません！"
	prompt

.FlyScript: ; 03:5254
	ld a, MAPSETUP_TELEPORT
	ldh [hMapEntryMethod], a
	jpab Functionfcc24

	
	
; Sets wFieldMoveSucceeded to $f if successful, $0 if not
DigFunction: ; 03:5260
	call .reset
.loop
	ld a, [wFieldMoveScriptID]
	bit SCRIPT_FINISHED_FLAG, a
	jr nz, .finish
	ld hl, .DigTable
	call CallJumptable
	jr .loop

; Finish by returning only the low nibble
.finish
	and $FF - SCRIPT_FINISHED_MASK
	ld [wFieldMoveSucceeded], a
	ret
	
.reset
	xor a
	ld [wFieldMoveScriptID], a
	ret

.DigTable: ; 03:527D
	dw .CheckCanDig
	dw .DoDig
	dw .FailDig

.CheckCanDig: ; 03:5283
	call GetMapEnvironment
	cp INDOOR
	jr z, .fail
	cp CAVE
	jr z, .fail
	ld a, SCRIPT_ID_02
	ld [wFieldMoveScriptID], a
	ret
.fail
	ld a, SCRIPT_ID_01
	ld [wFieldMoveScriptID], a
	ret

.DoDig: ; 03:529a
	ld hl, .DigScript
	ldh a, [hROMBank]
	call QueueScript
	ld a, SCRIPT_FINISHED_MASK | SCRIPT_SUCCESS
	ld [wFieldMoveScriptID], a
	ret

.FailDig: ; 03:52a8
	ld hl, .Text_CantUseDigHere
	call MenuTextBoxBackup
	ld a, SCRIPT_FINISHED_MASK | SCRIPT_FAIL
	ld [wFieldMoveScriptID], a
	ret

.Text_CantUseDigHere: ; 03:52b4
	text "ここでは　つかえません！"
	prompt
	
.DigScript: ; 03:52c2
	ld hl, wDigWarpNumber
	ld de, wNextWarp
	ld bc, 3
	call CopyBytes
	ld a, MAPSETUP_WARP
	ldh [hMapEntryMethod], a
	jpab Functionfcc24

EmptyFunctiond2da: ; 03:52da
	ret
	
	
	
; Sets wFieldMoveSucceeded to $f if successful, $0 if not
TeleportFunction: ; 03:52db
	xor a
	ld [wFieldMoveScriptID], a
.loop
	ld a, [wFieldMoveScriptID]
	bit SCRIPT_FINISHED_FLAG, a
	jr nz, .finish
	ld hl, .TeleportTable
	call CallJumptable
	jr .loop

; Finish by returning only the low nibble
.finish
	and $FF - SCRIPT_FINISHED_MASK
	ld [wFieldMoveSucceeded], a
	ret
	
.TeleportTable
	dw .TryTeleport
	dw .DoTeleport
	dw .FailTeleport
	dw .CheckIfSpawnPoint

.TryTeleport: ; 03:52fc
	call GetMapEnvironment
	cp TOWN
	jr z, .success
	cp ROUTE
	jr z, .success
	ld a, SCRIPT_ID_02
	ld [wFieldMoveScriptID], a
	ret
.success
	ld a, SCRIPT_ID_03
	ld [wFieldMoveScriptID], a
	ret
	
.CheckIfSpawnPoint ; 03:5313
	ld a, [wLastSpawnMapGroup]
	ld d, a
	ld a, [wLastSpawnMapNumber]
	ld e, a
	callab IsSpawnPoint
	jr c, .not_spawn
	ld hl, .Text_CantFindDestination
	call MenuTextBoxBackup
	ld a, SCRIPT_FINISHED_MASK | SCRIPT_FAIL
	ld [wFieldMoveScriptID], a
	ret
.not_spawn
	ld a, c
	ld [wDefaultSpawnPoint], a
	ld a, SCRIPT_ID_01
	ld [wFieldMoveScriptID], a
	ret

.Text_CantFindDestination: ; 03:533B
	text "とびさきが　みつかりません"
	para
	done

.DoTeleport: ; 03:534b
	ldh a, [hROMBank]
	ld hl, .TeleportScript
	call QueueScript
	ld a, SCRIPT_FINISHED_MASK | SCRIPT_SUCCESS
	ld [wFieldMoveScriptID], a
	ret

.FailTeleport: ; 03:5359
	ld hl, .Text_CantUseTeleportHere
	call MenuTextBoxBackup
	ld a, SCRIPT_FINISHED_MASK | SCRIPT_FAIL
	ld [wFieldMoveScriptID], a
	scf
	ret

.Text_CantUseTeleportHere: ; 03:5366
	text "ここでは　つかえません！"
	para
	done

.TeleportScript: ; 03:5375
	call RefreshScreen
	ld hl, .Text_ReturnToLastMonCenter
	call MenuTextBox
	ld c, 60
	call DelayFrames
	call CloseWindow
	call Function1fea
	ld a, MAPSETUP_TELEPORT
	ldh [hMapEntryMethod], a
	jpab Functionfcc24
	
.Text_ReturnToLastMonCenter: ; 03:5395
	text "さいごに　たちよった"
	line "#センターにもどります"
	done