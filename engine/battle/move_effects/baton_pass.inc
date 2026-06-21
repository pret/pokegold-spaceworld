BattleCommand_BatonPass:
	ldh a, [hBattleTurn]
	and a
	jp nz, .Enemy

	ld de, wPartySpecies
	ld hl, wPartyMon1HP
	ld bc, 0

.CheckAnyOtherAlivePartyMons:
	ld a, [de]
	inc de
	cp $ff
	jr z, .player_done

	ld a, [wCurBattleMon]
	cp c
	jr z, .player_next

	ld a, [hli]
	or b
	ld b, a
	ld a, [hld]
	or b
	ld b, a

.player_next
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	inc c
	jr .CheckAnyOtherAlivePartyMons

.player_done
	ld a, b
	and a
	jp z, .FailedBatonPass

	call LoadMoveAnim

	call LoadStandardMenuHeader
	ld a, PARTYMENUACTION_SWITCH
	ld [wPartyMenuActionText], a
	predef OpenPartyMenu_ClearGraphics

.player_loop
	jr c, .pressed_b
	ld hl, wCurBattleMon
	ld a, [wCurPartyMon]
	cp [hl]
	jr nz, .picked_mon

	ld hl, BattleText_MonIsAlreadyOut_0d
	call PrintText

.pressed_b
	predef OpenPartyMenu
	jr .player_loop

.picked_mon
	callfar CheckIfCurPartyMonIsFitToFight
	jr z, .pressed_b

	call ClearPalettes
	callfar _LoadHPBar
	call CloseWindow
	call ClearSprites
	hlcoord 1, 0
	lb bc, 4, 10
	call ClearBox
	ld b, SGB_BATTLE_COLORS
	call GetSGBLayout
	call SetPalettes
	call .BatonPass_LinkPlayerSwitch

	callfar PassedBattleMonEntrance
	jr .return

.Enemy
	ld a, [wBattleMode]
	dec a
	jr z, .FailedBatonPass

	ld de, wOTPartySpecies
	ld hl, wOTPartyMon1HP
	ld bc, 0

.CheckAnyOtherAliveEnemyMons
	ld a, [de]
	inc de
	cp $ff
	jr z, .enemy_done

	ld a, [wCurOTMon]
	cp c
	jr z, .enemy_next

	ld a, [hli]
	or b
	ld b, a
	ld a, [hld]
	or b
	ld b, a

.enemy_next
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	inc c
	jr .CheckAnyOtherAliveEnemyMons

.enemy_done
	ld a, b
	and a
	jr z, .FailedBatonPass
	call LoadMoveAnim
	call .BatonPass_LinkPlayerSwitch
	callfar EnemySwitch

	ld a, 1
	ld [wApplyStatLevelMultipliersToEnemy], a
	callfar ApplyStatLevelMultiplierOnAllStats

; BUG: No spikes damage when Baton Pass is used by the enemy

.return
	ret

.BatonPass_LinkPlayerSwitch:
	ld a, [wLinkMode]
	and a
	ret z
	ld a, 1
	ld [wBattlePlayerAction], a

	callfar LinkBattleSendRecieveAction
	xor a
	ld [wBattlePlayerAction], a
	ret

.FailedBatonPass:
	call BattleCommand_MoveDelay
	jp PrintButItFailed

BattleText_MonIsAlreadyOut_0d:
	text_from_ram wBattleMonNickname
	text "はもうでています"
	prompt
