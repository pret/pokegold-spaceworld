INCLUDE "constants.asm"

SECTION "TeleportFunction", ROMX[$52db], BANK[$03]

; Sets wFieldMoveSucceeded to $f if successful, $0 if not
TeleportFunction: ; 03:52db
	xor a
	ld [wFieldMoveScriptID], a
.loop
	ld a, [wFieldMoveScriptID]
	bit SCRIPT_FINISHED, a
	jr nz, .finish
	ld hl, .JumpTable
	call CallJumptable
	jr .loop

; Finish by returning only the low nibble
.finish
	and $FF - SCRIPT_FINISHED_MASK
	ld [wFieldMoveSucceeded], a
	ret
	
.JumpTable
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
	ld a, SCRIPT_FAIL
	ld [wFieldMoveScriptID], a
	ret
.not_spawn
	ld a, c
	ld [wDefaultSpawnpoint], a
	ld a, SCRIPT_ID_01
	ld [wFieldMoveScriptID], a
	ret

.Text_CantFindDestination:
	text "とびさきが　みつかりません"
	para
	done

.DoTeleport: ; 03:534b
	ldh a, [hROMBank]
	ld hl, .TeleportScript
	call QueueScript
	ld a, SCRIPT_SUCCESS
	ld [wFieldMoveScriptID], a
	ret

.FailTeleport: ; 03:5359
	ld hl, .Text_CantUseHere
	call MenuTextBoxBackup
	ld a, SCRIPT_FAIL
	ld [wFieldMoveScriptID], a
	scf
	ret

.Text_CantUseHere:
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
	
.Text_ReturnToLastMonCenter:
	text "さいごに　たちよった"
	line "#センターにもどります"
	done