INCLUDE "constants.asm"

SECTION "TeleportFunction", ROMX[$52db], BANK[$03]

TeleportFunction: ; 03:52db
	xor a
	ld [wFieldMoveScriptID], a
.loop
	ld a, [wFieldMoveScriptID]
	bit 7, a
	jr nz, .finish
	ld hl, .JumpTable
	call CallJumptable
	jr .loop
.finish
	and $7f
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
	ld a, $02
	ld [wFieldMoveScriptID], a
	ret
.success
	ld a, $03
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
	ld a, $80
	ld [wFieldMoveScriptID], a
	ret
.not_spawn
	ld a, c
	ld [wDefaultSpawnpoint], a
	ld a, $01
	ld [wFieldMoveScriptID], a
	ret

.Text_CantFindDestination:
	text "とびさきが　みつかりません"
	para_done

.DoTeleport: ; 03:534b
	ldh a, [hROMBank]
	ld hl, .TeleportScript
	call QueueScript
	ld a, $8f
	ld [wFieldMoveScriptID], a
	ret

.FailTeleport: ; 03:5359
	ld hl, .Text_CantUseHere
	call MenuTextBoxBackup
	ld a, $80
	ld [wFieldMoveScriptID], a
	scf
	ret

.Text_CantUseHere:
	text "ここでは　つかえません！"
	para_done

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