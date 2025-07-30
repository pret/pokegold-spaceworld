INCLUDE "constants.asm"

SECTION "engine/dumps/bank0f.asm@StartBattle", ROMX
StartBattle:
	xor a
	ld [wBattleParticipantsNotFainted], a
	ld [wBattleParticipantsIncludingFainted], a
	ld [wFieldMoveSucceeded], a
	inc a
	ld [wBattleHasJustStarted], a
	ld hl, wOTPartyMon1HP
	ld bc, $2f
	ld d, 3
.find_first_enemy_alive_loop
	inc d
	ld a, [hli]
	or [hl]
	jr nz, .found_first_enemy_alive
	add hl, bc
	jr .find_first_enemy_alive_loop
.found_first_enemy_alive
	ld a, d
	ld [wOtherPlayerLinkAction], a
	ld a, [wLinkMode]
	and a
	jr z, .asm_3c02e
	ldh a, [hLinkPlayerNumber]
	cp 2
	jr z, .asm_3c03f
.asm_3c02e
	ld a, [wBattleMode]
	dec a
	jr z, .asm_3c03a
	call EnemySwitch
	call sub_3d071
.asm_3c03a
	ld c, 40
	call DelayFrames
.asm_3c03f
	call BackUpTilesToBuffer
.check_any_alive
	call AnyPartyAlive
	ld a, d
	and a
	jp z, asm_3cc56
	call ReloadTilesFromBuffer
	ld a, [wBattleType]
	and a
	jp nz, .asm_3c0d2
	xor a
	ld [wCurPartyMon], a
.find_first_alive_loop
	call HasMonFainted
	jr nz, .found_first_alive
	ld hl, wCurPartyMon
	inc [hl]
	jr .find_first_alive_loop
.found_first_alive
	ld a, [wCurPartyMon]
	ld [wCurBattleMon], a
	inc a
	ld hl, wPartyCount
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wCurPartySpecies], a
	ld [wTempBattleMonSpecies], a
	ld hl, $c305
	ld a, 9
	call SlideBattlePicOut
	call BackUpTilesToBuffer
	ld a, [wCurPartyMon]
	ld c, a
	ld b, 1
	push bc
	ld hl, wBattleParticipantsNotFainted
	predef SmallFarFlagAction
	ld hl, wBattleParticipantsIncludingFainted
	pop bc
	predef SmallFarFlagAction
	call LoadBattleMonFromParty
	call ApplyStatMods
	call PrintSendOutMonMessage
	call sub_3d387
	call SendOutPlayerMon
	call PrintEmptyString
	call BackUpTilesToBuffer
	xor a
	ldh [hBattleTurn], a
	call SpikesDamage
	ld a, [wLinkMode]
	and a
	jr z, .to_battle
	ldh a, [hLinkPlayerNumber]
	cp 2
	jr nz, .to_battle
	call EnemySwitch
	call sub_3d071
	ld a, 1
	ldh [hBattleTurn], a
	call SpikesDamage
.to_battle
	jp asm_3c183

.asm_3c0d2
	call DisplayBattleMenu
	ret c
	ld a, [wFieldMoveSucceeded]
	and a
	jr z, .asm_3c0d2
	call ReloadTilesFromBuffer
	ld hl, SafariZonePAText
	jp PrintText

	call sub_3e81b
	ld a, [wEnemyMonSpeed + 1]
	add a
	ld b, a
	jp c, asm_3c132
	ld a, [wcace]
	and a
	jr z, .asm_3c0fa
	srl b
	srl b
.asm_3c0fa
	ld a, [wcacd]
	and a
	jr z, .asm_3c106
	sla b
	jr nc, .asm_3c106
	ld b, $ff
.asm_3c106
	call BattleRandom
	cp b
	jp nc, .check_any_alive
	jr asm_3c132

SafariZonePAText:
	text "アナウンス『ピンポーン！"

	para "サファり　ボールを"
	line "ぜんぶ　なげました！"
	prompt


asm_3c132:
	call ReloadTilesFromBuffer
	ld a, 2
	ld [wcd5d], a
	ld a, [wLinkMode]
	and a
	ld hl, WildPokemonFledText
	jr z, asm_3c14a
	xor a
	ld [wcd5d], a
	ld hl, EnemyPokemonFledText

asm_3c14a:
	call PrintText
	ld de, SFX_RUN
	call PlaySFX
	xor a
	ldh [hBattleTurn], a
	jpfar Functioncc000

WildPokemonFledText:
	text "やせいの@"
	text_from_ram wEnemyMonNickname
	text "は　にげだした！"
	prompt

EnemyPokemonFledText:
	text "てきの@"
	text_from_ram wEnemyMonNickname
	text "は　にげだした！"
	prompt

asm_3c183:
	call UpdateBattleMonInParty
	ldh a, [hLinkPlayerNumber]
	cp 1
	jr z, asm_3c1a9
	call sub_3c492
	jp z, asm_3caf3
	call sub_3c48d
	jp z, asm_3c883
	call sub_3c61e
	call sub_3c492
	jp z, asm_3caf3
	call sub_3c48d
	jp z, asm_3c883
	jr asm_3c1c4

asm_3c1a9:
	call sub_3c48d
	jp z, asm_3c883
	call sub_3c492
	jp z, asm_3caf3
	call sub_3c61e
	call sub_3c48d
	jp z, asm_3c883
	call sub_3c492
	jp z, asm_3caf3

asm_3c1c4:
	call sub_3c6b8
	call sub_3c704
	call sub_3d50b
	call sub_3d40b
	call UpdateBattleMonInParty
	call BackUpTilesToBuffer
	call sub_3c399
	jp c, asm_3c132
	xor a
	ld [wBattleHasJustStarted], a
	ld a, [wPlayerSubStatus4]
	and $60
	jp nz, asm_3c281
	ld hl, wEnemySubStatus3
	res 3, [hl]
	ld hl, wPlayerSubStatus3
	res 3, [hl]
	ld a, [hl]
	and $12
	jp nz, asm_3c281
	ld hl, wPlayerSubStatus1
	bit 6, [hl]
	jp nz, asm_3c281

asm_3c200:
	call DisplayBattleMenu
	ret c
	ld a, [wBattleResult]
	and a
	ret nz
	ld hl, wPlayerSubStatus5
	bit 4, [hl]
	jr z, asm_3c246
	ld a, [wPlayerEncoreCount]
	dec a
	ld [wPlayerEncoreCount], a
	jr nz, asm_3c229

asm_3c219:
	ld hl, wPlayerSubStatus5
	res 4, [hl]
	xor a
	ldh [hBattleTurn], a
	ld hl, BattleText_TargetsEncoreEnded
	call PrintText
	jr asm_3c246

asm_3c229:
	ld a, [wCurPlayerMove]
	and a
	jr z, asm_3c219
	ld a, [wCurMoveNum]
	ld c, a
	ld b, 0
	ld hl, wBattleMonPP
	add hl, bc
	ld a, [hl]
	and PP_MASK
	jr z, asm_3c219
	ld a, [wCurPlayerMove]
	ld [wCurPlayerSelectedMove], a
	jr asm_3c269

asm_3c246:
	ld a, [wPlayerSubStatus3]
	and $21
	jr nz, asm_3c281
	ld a, [wFieldMoveSucceeded]
	and a
	jr nz, asm_3c281
	xor a
	ld [wMoveSelectionMenuType], a
	inc a
	ld [wFXAnimID], a
	call MoveSelectionScreen
	push af
	call ReloadTilesFromBuffer
	call DrawHUDsAndHPBars
	pop af
	jp nz, asm_3c200

asm_3c269:
	xor a
	ldh [hBattleTurn], a
	callfar UpdateMoveData
	ld a, [wPlayerMoveStructEffect]
	cp $77
	jr z, asm_3c285
	xor a
	ld [wPlayerFuryCutterCount], a
	jr asm_3c285

asm_3c281:
	xor a
	ld [wPlayerFuryCutterCount], a

asm_3c285:
	call sub_3de6e
	ld a, [wLinkMode]
	and a
	jr z, asm_3c2cd
	ld a, [wOtherPlayerLinkAction]
	cp $f
	jp z, asm_3c132
	cp $e
	jr z, asm_3c2cd
	cp $d
	jr z, asm_3c2cd
	sub 4
	jr c, asm_3c2cd
	ld a, [wPlayerSubStatus3]
	bit 5, a
	jr z, asm_3c2bb
	ld a, [wCurMoveNum]
	ld hl, wBattleMonMoves
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	cp $76
	jr nz, asm_3c2bb
	ld [wCurPlayerSelectedMove], a

asm_3c2bb:
	callfar Function38220
	ld a, 1
	ldh [hBattleTurn], a
	call SpikesDamage
	jp asm_3c3c7

asm_3c2cd:
	ld a, [wCurPlayerSelectedMove]
	call sub_3c3b8
	cp $67
	jr nz, asm_3c2e4
	ld a, [wCurEnemySelectedMove]
	call sub_3c3b8
	cp $67
	jr z, asm_3c311
	jp asm_3c41d

asm_3c2e4:
	ld a, [wCurEnemySelectedMove]
	call sub_3c3b8
	cp $67
	jp z, asm_3c3c7
	ld a, [wCurPlayerSelectedMove]
	call sub_3c3b8
	cp $59
	jr nz, asm_3c306
	ld a, [wCurEnemySelectedMove]
	call sub_3c3b8
	cp $59
	jr z, asm_3c311
	jp asm_3c3c7

asm_3c306:
	ld a, [wCurEnemySelectedMove]
	call sub_3c3b8
	cp $59
	jp z, asm_3c41d

asm_3c311:
	xor a
	ldh [hBattleTurn], a
	callfar GetUserItem
	push bc
	callfar GetOpponentItem
	pop de
	ld a, d
	cp $4a
	jr nz, asm_3c339
	ld a, b
	cp $4a
	jr z, asm_3c347
	call BattleRandom
	cp e
	jr nc, asm_3c36d
	jp asm_3c41d

asm_3c339:
	ld a, b
	cp $4a
	jr nz, asm_3c36d
	call BattleRandom
	cp c
	jr nc, asm_3c36d
	jp asm_3c3c7

asm_3c347:
	ldh a, [hLinkPlayerNumber]
	cp 2
	jr z, asm_3c35d
	call BattleRandom
	cp c
	jp c, asm_3c3c7
	call BattleRandom
	cp e
	jp c, asm_3c41d
	jr asm_3c36d

asm_3c35d:
	call BattleRandom
	cp e
	jp c, asm_3c41d
	call BattleRandom
	cp c
	jp c, asm_3c3c7
	jr asm_3c36d

asm_3c36d:
	ld de, wBattleMonSpeed
	ld hl, wEnemyMonSpeed
	ld c, 2
	call memcmp
	jr z, asm_3c37f
	jp nc, asm_3c41d
	jr asm_3c3c7

asm_3c37f:
	ldh a, [hLinkPlayerNumber]
	cp 2
	jr z, asm_3c38f
	call BattleRandom
	cp $80
	jp c, asm_3c41d
	jr asm_3c3c7

asm_3c38f:
	call BattleRandom
	cp $80
	jr c, asm_3c3c7
	jp asm_3c41d

sub_3c399:
	ld a, [wBattleMode]
	dec a
	jr nz, asm_3c3b6
	ld a, [wDebugFlags]
	bit 0, a
	jr nz, asm_3c3b6
	ld a, [wEnemySubStatus5]
	bit 7, a
	jr nz, asm_3c3b6
	call BattleRandom
	cp $a
	jr nc, asm_3c3b6
	scf
	ret

asm_3c3b6:
	and a
	ret

sub_3c3b8:
	dec a
	ld hl, Moves + 1
	ld bc, 7
	call AddNTimes
	ld a, BANK(Moves)
	jp GetFarByte

asm_3c3c7:
	ld a, 1
	ldh [hBattleTurn], a
	callfar Function38000
	jr c, asm_3c3eb
	callfar DoEnemyTurn
	call sub_3c473
	ld a, [wBattleResult]
	and a
	ret nz
	call sub_3c492
	jp z, asm_3caf3

asm_3c3eb:
	call sub_3c498
	jp z, asm_3c883
	call DrawHUDsAndHPBars
	callfar DoPlayerTurn
	call sub_3c473
	ld a, [wBattleResult]
	and a
	ret nz
	call sub_3c48d
	jp z, asm_3c883
	call sub_3c498
	jp z, asm_3caf3
	call DrawHUDsAndHPBars
	call sub_3c86d
	xor a
	ld [wFieldMoveSucceeded], a
	jp asm_3c183

asm_3c41d:
	callfar DoPlayerTurn
	call sub_3c473
	ld a, [wBattleResult]
	and a
	ret nz
	call sub_3c48d
	jp z, asm_3c883
	call sub_3c498
	jp z, asm_3caf3
	call DrawHUDsAndHPBars
	ld a, 1
	ldh [hBattleTurn], a
	callfar Function38000
	jr c, asm_3c460
	callfar DoEnemyTurn
	call sub_3c473
	ld a, [wBattleResult]
	and a
	ret nz
	call sub_3c492
	jp z, asm_3caf3

asm_3c460:
	call sub_3c498
	jp z, asm_3c883
	call DrawHUDsAndHPBars
	call sub_3c86d
	xor a
	ld [wFieldMoveSucceeded], a
	jp asm_3c183

sub_3c473:
	ld hl, wEnemySubStatus5
	ld de, wEnemySubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c484
	ld hl, wPlayerSubStatus5
	ld de, wPlayerSubStatus1

asm_3c484:
	res 6, [hl]
	ld a, [de]
	res 2, a
	res 5, a
	ld [de], a
	ret

sub_3c48d:
	ld hl, wEnemyMonHP
	jr asm_3c495

sub_3c492:
	ld hl, wBattleMonHP

asm_3c495:
	ld a, [hli]
	or [hl]
	ret

sub_3c498:
	ld hl, wBattleMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c4a3
	ld hl, wEnemyMonStatus

asm_3c4a3:
	ld a, [hl]
	and $18
	jr z, asm_3c4eb
	ld hl, HurtByPoisonText
	ld de, ANIM_PSN
	and $10
	jr z, asm_3c4b8
	ld hl, HurtByBurnText
	ld de, ANIM_BRN

asm_3c4b8:
	push de
	call PrintText
	pop de
	xor a
	ld [wNumHits], a
	call PlayMoveAnimation
	call GetEighthMaxHP
	ld hl, wPlayerSubStatus5
	ld de, wPlayerToxicCount
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c4d8
	ld hl, wEnemySubStatus5
	ld de, wEnemyToxicCount

asm_3c4d8:
	bit 0, [hl]
	jr z, asm_3c4e8
	ld a, [de]
	inc a
	ld [de], a
	ld hl, 0

asm_3c4e2:
	add hl, bc
	dec a
	jr nz, asm_3c4e2
	ld b, h
	ld c, l

asm_3c4e8:
	call SubtractHPFromUser

asm_3c4eb:
	ld hl, wPlayerSubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c4f6
	ld hl, wEnemySubStatus4

asm_3c4f6:
	bit 7, [hl]
	jr z, asm_3c51d
	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	xor a
	ld [wNumHits], a
	ld de, ANIM_SAP
	call PlayMoveAnimation
	pop af
	ldh [hBattleTurn], a
	call GetEighthMaxHP
	call SubtractHPFromUser
	call RestoreHP
	ld hl, LeechSeedSapsText
	call PrintText

asm_3c51d:
	ld hl, wPlayerSubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c528
	ld hl, wEnemySubStatus1

asm_3c528:
	bit 0, [hl]
	jr z, asm_3c542
	xor a
	ld [wNumHits], a
	ld de, ANIM_IN_NIGHTMARE
	call PlayMoveAnimation
	call GetQuarterMaxHP
	call SubtractHPFromUser
	ld hl, HasANightmareText
	call PrintText

asm_3c542:
	ld hl, wPlayerSubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c54d
	ld hl, wEnemySubStatus1

asm_3c54d:
	bit 1, [hl]
	jr z, asm_3c567
	xor a
	ld [wNumHits], a
	ld de, ANIM_IN_NIGHTMARE
	call PlayMoveAnimation
	call GetQuarterMaxHP
	call SubtractHPFromUser
	ld hl, HurtByCurseText
	call PrintText

asm_3c567:
	ld hl, wPlayerScreens
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c572
	ld hl, wEnemyScreens

asm_3c572:
	bit SCREENS_SANDSTORM, [hl]
	jr z, asm_3c596
	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	xor a
	ld [wNumHits], a
	ld de, ANIM_IN_SANDSTORM
	call PlayMoveAnimation
	pop af
	ldh [hBattleTurn], a
	call GetEighthMaxHP
	call SubtractHPFromUser
	ld hl, SandstormHitsText
	call PrintText

asm_3c596:
	ld hl, wBattleMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c5a1
	ld hl, wEnemyMonHP

asm_3c5a1:
	ld a, [hli]
	or [hl]
	ret nz
	call DrawHUDsAndHPBars
	ld c, 20
	call DelayFrames
	xor a
	ret

HurtByPoisonText:
	text "<USER>は"
	line "どくの　ダメージを　うけている！"
	prompt

HurtByBurnText:
	text "<USER>は"
	line "やけどの　ダメージを　うけている！"
	prompt

LeechSeedSapsText:
	text "やどりぎが　<USER>の"
	line "たいりょくを　うばう！"
	prompt

HasANightmareText:
	text "<USER>は"
	line "あくむに　うなされている！"
	prompt

HurtByCurseText:
	text "<USER>は"
	line "のろわれている！"
	prompt

SandstormHitsText:
	text "すなあらしが　<USER>を"
	line "おそう！"
	prompt

sub_3c61e:
	ldh a, [hLinkPlayerNumber]
	cp 1
	jr z, asm_3c632
	xor a
	ldh [hBattleTurn], a
	call sub_3c640
	ld a, 1
	ldh [hBattleTurn], a
	call sub_3c640
	ret

asm_3c632:
	ld a, 1
	ldh [hBattleTurn], a
	call sub_3c640
	xor a
	ldh [hBattleTurn], a
	call sub_3c640
	ret

sub_3c640:
	ld hl, wPlayerSubStatus1
	ld de, wPlayerPerishCount
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c651
	ld hl, wEnemySubStatus1
	ld de, wEnemyPerishCount

asm_3c651:
	bit 4, [hl]
	ret z
	ld a, [de]
	dec a
	ld [de], a
	ld [wNumSetBits], a
	push af
	push hl
	ld hl, PerishCountText
	call PrintText
	pop hl
	pop af
	ret nz
	res 4, [hl]
	ldh a, [hBattleTurn]
	and a
	jr nz, asm_3c682
	ld hl, wBattleMonHP
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, wPartyMon1HP
	ld a, [wCurBattleMon]
	ld bc, $30
	call AddNTimes
	xor a
	ld [hli], a
	ld [hl], a
	ret

asm_3c682:
	ld hl, wEnemyMonHP
	xor a
	ld [hli], a
	ld [hl], a
	ld a, [wBattleMode]
	dec a
	ret z
	ld hl, wOTPartyMon1HP
	ld a, [wCurOTMon]
	ld bc, $30
	call AddNTimes
	xor a
	ld [hli], a
	ld [hl], a
	ret

PerishCountText:
	text "<USER>の　ほろびの"
	line "カウントが　@"
	deciram wNumSetBits, 1, 1
	text "になった！"
	prompt

sub_3c6b8:
	ld a, [wcadd]
	bit 2, a
	jr z, asm_3c6ce
	ld hl, wPlayerSafeguardCount
	dec [hl]
	jr nz, asm_3c6ce
	res 2, a
	ld [wcadd], a
	xor a
	call sub_3c6e0

asm_3c6ce:
	ld a, [wcade]
	bit 2, a
	ret z
	ld hl, wEnemySafeguardCount
	dec [hl]
	ret nz
	res 2, a
	ld [wcade], a
	ld a, 1

sub_3c6e0:
	ldh [hBattleTurn], a
	ld hl, EndPsychicVeilText
	jp PrintText

EndPsychicVeilText:
	text "<USER>を　つつんでいた"
	line "しんぴの　べールが　なくなった！"
	prompt

sub_3c704:
	ld a, [wBattleWeather]
	and a
	ret z
	dec a
	ld c, a
	ld hl, wWeatherCount
	dec [hl]
	ld hl, TextPointers3c726
	jr nz, asm_3c71b
	xor a
	ld [wBattleWeather], a
	ld hl, TextPointers3c72a

asm_3c71b:
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	ret

TextPointers3c726:
	dw RainingText
	dw SunlightIsStrongText

TextPointers3c72a:
	dw RainStoppedText
	dw SunlightFadedText

RainingText:
	text "あめが　ふりつずいている"
	prompt

SunlightIsStrongText:
	text "ひざしが　つよい"
	prompt

RainStoppedText:
	text "あめが　やんだ！"
	prompt

SunlightFadedText:
	text "ひざしが　よわくなった！"
	prompt

; Subtract c HP from mon
SubtractHPFromUser:
	ld hl, wBattleMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_mon_hp
	ld hl, wEnemyMonHP

.got_mon_hp
	inc hl
	ld a, [hl]
	ld [wHPBarOldHP], a
	sub c
	ld [hld], a
	ld [wHPBarNewHP], a

	ld a, [hl]
	ld [wHPBarOldHP + 1], a
	sbc b
	ld [hl], a
	ld [wHPBarNewHP + 1], a
	jr nc, .end

	xor a
	ld [hli], a
	ld [hl], a
	ld [wHPBarNewHP], a
	ld [wHPBarNewHP + 1], a

.end
	call UpdateHPBarBattleHuds
	ret

; Output: bc
GetEighthMaxHP:
	ld hl, wBattleMonMaxHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_max_hp
	ld hl, wEnemyMonMaxHP

.got_max_hp
	ld a, [hli]
	ld [wHPBarMaxHP + 1], a
	ld b, a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld c, a
; Quarter result.
	srl b
	rr c
	srl b
	rr c
; Assumes nothing can have 1024 or more HP.
; Halve result.
	srl c

; Make sure the amount is at least 1.
	ld a, c
	and a
	jr nz, .end
	inc c
.end
	ret

; Output: bc
GetQuarterMaxHP:
	ld hl, wBattleMonMaxHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_max_hp
	ld hl, wEnemyMonMaxHP
.got_max_hp
	ld a, [hli]
	ld [wHPBarMaxHP + 1], a
	ld b, a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld c, a

; Quarter result
	srl b
	rr c
	srl b
	rr c

; Assumes nothing can have 1024 or more hp.
; Make sure the amount is at least 1.
	ld a, c
	and a
	jr nz, .end
	inc c
.end
	ret

; Output: bc
GetHalfMaxHP:
	ld hl, wBattleMonMaxHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_max_hp
	ld hl, wEnemyMonMaxHP
.got_max_hp
	ld a, [hli]
	ld [wHPBarMaxHP + 1], a
	ld b, a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld c, a

; Half result
	srl b
	rr c

; MINOR BUG: If something has a multiple of 512 HP, then the HP amount will be increased by 1.
; This amount is achievable by using monsters with high base HP, e.g. Chansey.

	ld a, c
	and a
	jr nz, .end
	inc c
.end
	ret

GetMaxHP:
	ld hl, wBattleMonMaxHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_max_hp
	ld hl, wEnemyMonMaxHP
.got_max_hp
	ld a, [hli]
	ld [wHPBarMaxHP + 1], a
	ld b, a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld c, a
	ret

RestoreHP:
	ld hl, wEnemyMonMaxHP
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wBattleMonMaxHP

.ok
	ld a, [hli]
	ld [wHPBarMaxHP + 1], a
	ld a, [hld]
	ld [wHPBarMaxHP], a
	dec hl
	ld a, [hl]
	ld [wHPBarOldHP], a
	add c
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [hl]
	ld [wHPBarOldHP + 1], a
	adc b
	ld [hli], a
	ld [wHPBarNewHP + 1], a

	ld a, [wHPBarMaxHP]
	ld c, a
	ld a, [hld]
	sub c
	ld a, [wHPBarMaxHP + 1]
	ld b, a
	ld a, [hl]
	sbc b
	jr c, .overflow
	ld a, b
	ld [hli], a
	ld [wHPBarNewHP + 1], a
	ld a, c
	ld [hl], a
	ld [wHPBarNewHP], a

.overflow
	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	call UpdateHPBarBattleHuds
	pop af
	ldh [hBattleTurn], a
	ret

UpdateHPBarBattleHuds:
	hlcoord 10, 9
	ldh a, [hBattleTurn]
	and a
	ld a, 1
	jr z, .ok
	hlcoord 2, 2
	xor a
.ok
	push bc
	ld [wWhichHPBar], a
	predef UpdateHPBar
	pop bc
	ret

sub_3c86d:
	ld a, [wPlayerRolloutCount]
	and a
	jr nz, asm_3c878
	ld hl, wPlayerSubStatus3
	res 5, [hl]

asm_3c878:
	ld a, [wEnemyRolloutCount]
	and a
	ret nz
	ld hl, wEnemySubStatus3
	res 5, [hl]
	ret

asm_3c883:
	xor a
	ld [wcad5], a
	call sub_3c8ca
	call AnyPartyAlive
	ld a, d
	and a
	jp z, asm_3cc56
	ld hl, wBattleMonHP
	ld a, [hli]
	or [hl]
	call nz, UpdatePlayerHUD
	ld c, $3c
	call DelayFrames
	ld a, [wBattleMode]
	dec a
	ret z
	call sub_3c9ad
	jp z, asm_3c9fd
	ld hl, wBattleMonHP
	ld a, [hli]
	or [hl]
	jr nz, asm_3c8b8
	call sub_3cb9d
	ret c
	call sub_3cbdb

asm_3c8b8:
	ld a, 1
	ld [wFieldMoveSucceeded], a
	call sub_3c9c2
	jp z, asm_3c132
	xor a
	ld [wFieldMoveSucceeded], a
	jp asm_3c183

sub_3c8ca:
	call UpdateBattleMonInParty
	ld a, [wBattleMode]
	dec a
	jr z, asm_3c8e2
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1HP
	ld bc, $30
	call AddNTimes
	xor a
	ld [hli], a
	ld [hl], a

asm_3c8e2:
	ld hl, wPlayerSubStatus3
	res 2, [hl]
	xor a
	ld hl, wPlayerDamageTaken
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld hl, wEnemySubStatus1
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wEnemyDisableCount], a
	ld [wEnemyDisabledMove], a
	ld [wEnemyMinimized], a
	ld hl, wCurPlayerMove
	ld [hli], a
	ld [hl], a
	ld hl, $c310
	ld de, $c324
	call sub_3ccef
	ld hl, $c2a1
	ld bc, $040a
	call ClearBox
	ld a, [wBattleMode]
	dec a
	jr z, asm_3c935
	push de
	ld de, SFX_KINESIS
	call PlaySFX
	call WaitSFX
	pop de
	push de
	ld de, SFX_FAINT
	call PlaySFX
	call WaitSFX
	pop de
	jr asm_3c93d

asm_3c935:
	call sub_3c9a8
	ld a, 0
	call sub_3cae1

asm_3c93d:
	ld hl, wBattleMonHP
	ld a, [hli]
	or [hl]
	jr nz, asm_3c94d
	ld a, [wcad5]
	and a
	jr nz, asm_3c94d
	call sub_3cb34

asm_3c94d:
	call AnyPartyAlive
	ld a, d
	and a
	ret z
	ld hl, EnemyMonFainted
	call PrintText
	call PrintEmptyString
	call BackUpTilesToBuffer
	xor a
	ld [wcd5d], a
	ld b, $4b
	call Function32c8
	push af
	jr z, asm_3c976
	ld hl, wEnemyMonBaseStats
	ld b, 7

asm_3c970:
	srl [hl]
	inc hl
	dec b
	jr nz, asm_3c970

asm_3c976:
	xor a
	ld [wHPBarMaxHP], a
	call sub_3e421
	pop af
	ret z
	ld a, 1
	ld [wHPBarMaxHP], a
	ld a, [wPartyCount]
	ld b, 0

asm_3c989:
	scf
	rl b
	dec a
	jr nz, asm_3c989
	ld a, b
	ld [wBattleParticipantsNotFainted], a
	jp sub_3e421

EnemyMonFainted:
	text "てきの　@"
	text_from_ram wEnemyMonNickname
	text "は　たおれた！"
	prompt

sub_3c9a8:
	inc a
	ld [wBattleLowHealthAlarm], a
	ret

sub_3c9ad:
	ld a, [wOTPartyCount]
	ld b, a
	xor a
	ld hl, wOTPartyMon1HP
	ld de, $30

asm_3c9b8:
	or [hl]
	inc hl
	or [hl]
	dec hl
	add hl, de
	dec b
	jr nz, asm_3c9b8
	and a
	ret

sub_3c9c2:
	ld hl, wEnemyHPPal
	ld e, $30
	call UpdateHPPal
	callfar Function3834e
	ld a, [wLinkMode]
	and a
	jr z, asm_3c9e4
	call LinkBattleSendRecieveAction
	ld a, [wOtherPlayerLinkAction]
	cp $f
	ret z
	call ReloadTilesFromBuffer

asm_3c9e4:
	call EnemySwitch
	call sub_3d071
	ld a, 1
	ldh [hBattleTurn], a
	call SpikesDamage
	xor a
	ld [wEnemyMoveStruct], a
	ld [wFieldMoveSucceeded], a
	ld [wcaba], a
	inc a
	ret

asm_3c9fd:
	call sub_3c9a8
	ld b, 0
	ld a, [wce04]
	and a
	jr nz, asm_3ca0a
	ld b, $b

asm_3ca0a:
	ld a, [wca22]
	cp $2b
	jr nz, asm_3ca18
	ld b, 0
	ld hl, wDebugFlags
	set 1, [hl]

asm_3ca18:
	ld a, [wLinkMode]
	and a
	ld a, b
	call z, sub_3cae1
	callfar Battle_GetTrainerName
	ld hl, BattleText_EnemyWasDefeated
	call PrintText
	ld a, [wLinkMode]
	cp 3
	ret z
	call sub_3e201
	ld c, 40
	call DelayFrames
	ld a, [wOtherTrainerClass]
	cp 9
	jr nz, asm_3ca51
	ld hl, RivalLossText
	call PrintText
	callfar HealParty

asm_3ca51:
	ld a, [wBattleMonItem]
	ld b, a
	callfar GetItemHeldEffect
	ld a, b
	cp HELD_AMULET_COIN
	jr nz, asm_3ca74
	ld hl, wBattleReward + 2
	sla [hl]
	dec hl
	rl [hl]
	dec hl
	rl [hl]
	jr nc, asm_3ca74
	ld a, $ff
	ld [hli], a
	ld [hli], a
	ld [hl], a

asm_3ca74:
	ld de, wMoney + 2
	ld hl, wBattleReward + 2
	ld c, 3
	and a

asm_3ca7d:
	ld a, [de]
	adc [hl]
	ld [de], a
	dec de
	dec hl
	dec c
	jr nz, asm_3ca7d
	ld hl, GotMoneyForWinningText
	call PrintText
	ret

GotMoneyForWinningText:
	text "<PLAYER>は　しょうきんとして"
	line "@"
	deciram wBattleReward, 3, 6
	text "円　てにいれた！"
	prompt

BattleText_EnemyWasDefeated:
	text_from_ram wca2b
	text "の　@"
	text_from_ram wStringBuffer1
	text ""
	line "との　しょうぶに　かった！"
	prompt

RivalLossText:
	text "<RIVAL>『あれー？"
	line "おまえの　#に"
	cont "すりゃあ　よかったのかなあ？"
	prompt

sub_3cae1:
	push de
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld de, MUSIC_VICTORY_TRAINER
	call PlayMusic
	pop de
	ret

asm_3caf3:
	ld a, 1
	ld [wcad5], a
	call sub_3cb34
	call AnyPartyAlive
	ld a, d
	and a
	jp z, asm_3cc56
	ld hl, wEnemyMonHP
	ld a, [hli]
	or [hl]
	jr nz, asm_3cb18
	call sub_3c8ca
	ld a, [wBattleMode]
	dec a
	ret z
	call sub_3c9ad
	jp z, asm_3c9fd

asm_3cb18:
	call sub_3cb9d
	ret c
	call sub_3cbdb
	jp nz, asm_3c183
	ld a, 1
	ld [wFieldMoveSucceeded], a
	call sub_3c9c2
	jp z, asm_3c132
	xor a
	ld [wFieldMoveSucceeded], a
	jp asm_3c183

sub_3cb34:
	ld a, [wCurBattleMon]
	ld c, a
	ld hl, wBattleParticipantsNotFainted
	ld b, 0
	predef SmallFarFlagAction
	ld hl, wEnemySubStatus3
	res SUBSTATUS_IN_LOOP, [hl]
	ld a, [wLowHealthAlarmBuffer]
	bit 7, a
	jr z, asm_3cb56
	ld a, $ff
	ld [wLowHealthAlarmBuffer], a
	call WaitSFX

asm_3cb56:
	ld hl, wEnemyDamageTaken
	ld [hli], a
	ld [hl], a
	ld [wBattleMonStatus], a
	ld [wBattleMonStatus + 1], a
	call UpdateBattleMonInParty
	ld hl, $c335
	ld bc, $050b
	call ClearBox
	ld hl, $c369
	ld de, $c37d
	call sub_3ccef
	ld a, 1
	ld [wcd5d], a
	ld a, [wcad5]
	and a
	ret z
	ld a, $f0
	ld [wCryTracks], a
	ld a, [wBattleMonSpecies]
	call PlayStereoCry
	ld hl, FaintedText
	jp PrintText

FaintedText:
	text_from_ram wBattleMonNickname
	text "は　たおれた！"
	prompt

sub_3cb9d:
	call PrintEmptyString
	call BackUpTilesToBuffer
	ld a, [wBattleMode]
	and a
	dec a
	ret nz
	ld hl, UseNextMonText
	call PrintText

asm_3cbaf:
	ld bc, $0107
	call PlaceYesNoBox
	ld a, [wMenuCursorY]
	jr c, asm_3cbbc
	and a
	ret

asm_3cbbc:
	ld a, [wMenuCursorY]
	cp 1
	jr z, asm_3cbaf
	ld hl, wPartyMon1Speed
	ld de, wEnemyMonSpeed
	jp TryRunningFromBattle

UseNextMonText:
	text "つぎの　#をつかいますか？"
	done

sub_3cbdb:
	call LoadStandardMenuHeader
	ld a, PARTYMENUACTION_SWITCH
	ld [wPartyMenuActionText], a
	predef OpenPartyMenu_ClearGraphics

asm_3cbe8:
	jr nc, asm_3cbf1

asm_3cbea:
	predef OpenPartyMenu
	jr asm_3cbe8

asm_3cbf1:
	call HasMonFainted
	jr z, asm_3cbea
	ld a, [wLinkMode]
	cp 3
	jr nz, asm_3cc04
	inc a
	ld [wFieldMoveSucceeded], a
	call LinkBattleSendRecieveAction

asm_3cc04:
	xor a
	ld [wFieldMoveSucceeded], a
	call ClearSprites
	ld a, [wCurPartyMon]
	ld [wCurBattleMon], a
	ld c, a
	ld hl, wBattleParticipantsNotFainted
	ld b, 1
	push bc
	predef SmallFarFlagAction
	pop bc
	ld hl, wBattleParticipantsIncludingFainted
	predef SmallFarFlagAction
	call LoadBattleMonFromParty
	call ApplyStatMods
	call ClearPalettes
	call _LoadHPBar
	call CloseWindow
	call GetMemSGBLayout
	call SetPalettes
	call PrintSendOutMonMessage
	call sub_3d387
	call SendOutPlayerMon
	call PrintEmptyString
	call BackUpTilesToBuffer
	xor a
	ldh [hBattleTurn], a
	call SpikesDamage
	ld hl, wEnemyMonHP
	ld a, [hli]
	or [hl]
	ret

asm_3cc56:
	ld a, [wLinkMode]
	and a
	jr nz, asm_3cc83
	ld a, [wOtherTrainerClass]
	cp 9
	jr nz, asm_3cc83
	ld hl, wTileMap
	ld bc, $0815
	call ClearBox
	call sub_3e201
	ld c, 40
	call DelayFrames
	ld hl, RivalWinText
	call PrintText
	callfar HealParty
	ret

asm_3cc83:
	ld b, 0
	call GetSGBLayout
	ld hl, OutOfUsableMonsText
	ld a, [wLinkMode]
	cp 3
	jr nz, asm_3cc95
	ld hl, Data3ccdd

asm_3cc95:
	call PrintText
	call ClearTileMap
	scf
	ret

RivalWinText:
	text "<RIVAL>『やった！"
	line "いい#　えらんだかも！"
	prompt

OutOfUsableMonsText:
	text "<PLAYER>の　てもとには"
	line "たたかえる　#が　いない！"
	para "<PLAYER>は"
	line "めのまえが　まっくらに　なった！"
	prompt

Data3ccdd:
	text_from_ram wca2b
	text "との"
	line "しょうぶに　まけた！"
	prompt

sub_3ccef:
	ld a, [wJoypadFlags]
	push af
	set 6, a
	ld [wJoypadFlags], a
	ld b, 7

asm_3ccfa:
	push bc
	push de
	push hl
	ld b, 6

asm_3ccff:
	push bc
	push hl
	push de
	ld bc, 7
	call CopyBytes
	pop de
	pop hl
	ld bc, hFFEC
	add hl, bc
	push hl
	ld h, d
	ld l, e
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	pop bc
	dec b
	jr nz, asm_3ccff
	ld bc, $14
	add hl, bc
	ld de, SevenBlankSpacesString
	call PlaceString
	ld c, 2
	call DelayFrames
	pop hl
	pop de
	pop bc
	dec b
	jr nz, asm_3ccfa
	pop af
	ld [wJoypadFlags], a
	ret

SevenBlankSpacesString:
	db "　　　　　　　@"

SlideBattlePicOut:
	ldh [hSpriteWidth], a
	ld c, a

.loop
	push bc
	push hl
	ld b, 7

.loop2
	push hl
	call .DoFrame
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	dec b
	jr nz, .loop2
	ld c, 2
	call DelayFrames
	pop hl
	pop bc
	dec c
	jr nz, .loop
	ret

.DoFrame:
	ldh a, [hTextBoxCursorBlinkInterval]
	ld c, a
	cp 8
	jr nz, .back

.forward
	ld a, [hli]
	ld [hld], a
	dec hl
	dec c
	jr nz, .forward
	ret

.back
	ld a, [hld]
	ld [hli], a
	inc hl
	dec c
	jr nz, .back
	ret

EnemySwitch:
	ld hl, wBattleParticipantsNotFainted
	xor a
	ld [hl], a

	ld a, [wCurBattleMon]
	ld c, a
	ld b, SET_FLAG
	push bc
	predef SmallFarFlagAction
	ld hl, wBattleParticipantsIncludingFainted
	xor a
	ld [hl], a
	pop bc
	predef SmallFarFlagAction

	xor a
	ld hl, wCurPlayerMove
	ld [hli], a
	ld [hl], a
	dec a
	ld [wEnemyItemState], a
	ld hl, wPlayerSubStatus3
	res SUBSTATUS_USING_TRAPPING_MOVE, [hl]

	hlcoord 18, 0
	ld a, 8
	call SlideBattlePicOut
	call PrintEmptyString
	call LoadStandardMenuHeader

	ld a, [wLinkMode]
	and a
	jr z, FindMonInOTPartyToSwitchIntoBattle

	ld a, [wOtherPlayerLinkAction]
	sub BATTLEACTION_SWITCH1
	ld b, a
	jp LoadEnemyMonToSwitchTo

FindMonInOTPartyToSwitchIntoBattle:
	ld a, [wBattleHasJustStarted]
	and a
	jp nz, GetRandomOTPartyMon

	ld b, -1
	ld a, 1
	ld [wEnemyEffectivenessVsPlayerMons], a
	ld [wPlayerEffectivenessVsEnemyMons], a
.loop
	ld hl, wEnemyEffectivenessVsPlayerMons
	sla [hl]
	inc hl
	sla [hl]
	inc b
	ld a, [wOTPartyCount]
	cp b
	jp z, ScoreMonTypeMatchups
	
	ld a, [wCurOTMon]
	cp b
	jr z, .discourage

	ld hl, wOTPartyMon1HP
	push bc
	ld a, b
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [hli]
	ld c, a
	ld a, [hl]
	or c
	pop bc
	jr z, .discourage
	call LookUpTheEffectivenessOfEveryMove
	call IsThePlayerMonTypesEffectiveAgainstOTMon
	jr .loop

.discourage
	ld hl, wPlayerEffectivenessVsEnemyMons
	set 0, [hl]
	jr .loop

LookUpTheEffectivenessOfEveryMove:
	push bc
	ld hl, wOTPartyMon1Moves
	ld a, b
	ld bc, $30
	call AddNTimes
	pop bc
	ld e, 5
.loop
	dec e
	jr z, .done
	ld a, [hli]
	and a
	jr z, .done
	push hl
	push de
	push bc
	dec a
	ld hl, Moves
	ld bc, 7
	call AddNTimes
	ld de, wEnemyMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes
	ld a, 1
	ldh [hBattleTurn], a
	callfar BattleCheckTypeMatchup
	pop bc
	pop de
	pop hl
	ld a, [wNumSetBits]
	cp $b
	jr c, .loop
	ld hl, wEnemyEffectivenessVsPlayerMons
	set 0, [hl]
	ret
.done
	ret

IsThePlayerMonTypesEffectiveAgainstOTMon:
	push bc
	ld hl, wOTPartyCount
	ld a, b
	inc a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	dec a
	ld hl, BaseData + (wMonHTypes - wMonHeader)
	ld bc, (wMonHeaderEnd - wMonHeader)
	call AddNTimes
	ld de, wEnemyMonType
	ld bc, 2
	ld a, BANK(BaseData)
	call FarCopyBytes
	ld a, [wBattleMonType1]
	ld [wPlayerMoveStructType], a
	xor a
	ldh [hBattleTurn], a
	callfar BattleCheckTypeMatchup
	ld a, [wNumSetBits]
	cp $b
	jr nc, .super_effective
	ld a, [wBattleMonType2]
	ld [wPlayerMoveStructType], a
	callfar BattleCheckTypeMatchup
	ld a, [wNumSetBits]
	cp $b
	jr nc, .super_effective
	pop bc
	ret

.super_effective
	pop bc
	ld hl, wEnemyEffectivenessVsPlayerMons
	bit 0, [hl]
	jr nz, .reset
	inc hl
	set 0, [hl]
	ret

.reset
	res 0, [hl]
	ret

ScoreMonTypeMatchups:
.loop1
	ld hl, wEnemyEffectivenessVsPlayerMons
	sla [hl]
	inc hl
	sla [hl]
	jr nc, .loop1
	ld a, [wOTPartyCount]
	ld b, a
	ld c, [hl]
.loop2
	sla c
	jr nc, .okay
	dec b
	jr z, GetRandomOTPartyMon
	jr .loop2

.okay
	ld a, [wEnemyEffectivenessVsPlayerMons]
	and a
	jr z, .okay2
	ld b, -1
	ld c, a
.loop3
	inc b
	sla c
	jr nc, .loop3
	jr LoadEnemyMonToSwitchTo

.okay2
	ld b, -1
	ld a, [wPlayerEffectivenessVsEnemyMons]
	ld c, a
.loop4
	inc b
	sla c
	jr c, .loop4
	jr LoadEnemyMonToSwitchTo

GetRandomOTPartyMon:
.loop
	call BattleRandom
	maskbits PARTY_LENGTH
	cp PARTY_LENGTH
	jr nc, .loop

	ld b, a
	ld a, [wCurOTMon]
	cp b
	jr z, .loop

	ld hl, wOTPartyMon1HP
	push bc
	ld a, b
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	pop bc

	ld a, [hli]
	ld c, a
	ld a, [hl]
	or c
	jr z, .loop

LoadEnemyMonToSwitchTo:
	; 'b' contains the PartyNr of the mon the AI will switch to
	ld a, b
	ld [wCurPartyMon], a
	ld hl, wOTPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes

	ld a, [hl]
	ld [wCurPartyLevel], a
	ld a, [wCurPartyMon]
	inc a
	ld hl, wOTPartySpecies - 1
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]

	ld [wTempEnemyMonSpecies], a
	ld [wCurPartySpecies], a
	call LoadEnemyMon

	ld hl, wEnemyMonHP
	ld a, [hli]
	ld [wEnemyHPAtTimeOfPlayerSwitch], a
	ld a, [hl]
	ld [wEnemyHPAtTimeOfPlayerSwitch + 1], a

	ld a, 1
	ld [wMenuCursorY], a
	ld a, [wBattleHasJustStarted]
	dec a
	jr z, EnemySendOutFirstMon

	ld a, [wPartyCount]
	dec a
	jr z, EnemySendOutFirstMon

	ld a, [wLinkMode]
	and a
	jr nz, EnemySendOutFirstMon

	ld a, [wOptions]
	bit BATTLE_SHIFT_F, a
	jr nz, EnemySendOutFirstMon

	callfar Battle_GetTrainerName
	ld hl, TrainerAboutToUseText
	call PrintText

	lb bc, 1, 7
	call PlaceYesNoBox
	ld a, [wMenuCursorY]
	dec a
	jr nz, EnemySendOutFirstMon

	ld a, PARTYMENUACTION_SWITCH
	ld [wPartyMenuActionText], a
	predef OpenPartyMenu_ClearGraphics

.pick
	ld a, 1
	ld [wMenuCursorY], a
	jr c, .canceled_switch

	ld hl, wCurBattleMon
	ld a, [wCurPartyMon]
	cp [hl]
	jr nz, .notout

	ld hl, IsAlreadyOutText
	call PrintText

.fainted
	predef OpenPartyMenu
	jr .pick

.notout
	call HasMonFainted
	jr z, .fainted
	xor a
	ld [wMenuCursorY], a

.canceled_switch
	call ClearPalettes
	call _LoadHPBar

EnemySendOutFirstMon:
	call CloseWindow
	call ClearSprites
	hlcoord 1, 0
	lb bc, 4, 10
	call ClearBox

	ld b, SGB_BATTLE_COLORS
	call GetSGBLayout
	call SetPalettes
	callfar Battle_GetTrainerName

	ld hl, TrainerSentOutText
	call PrintText

	ld a, [wTempEnemyMonSpecies]
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call GetBaseData

	ld a, OTPARTYMON
	ld [wMonType], a
	predef CopyMonToTempMon
	ld hl, wTempMonDVs
	predef GetUnownLetter
	ld de, vFrontPic
	call LoadMonFrontSprite
	xor a
	ld [wNumHits], a
	inc a
	ldh [hBattleTurn], a

; Play shiny animation for Sunflora and Pikachu
	ld b, 1
	ld a, [wCurPartySpecies]
	cp DEX_SUNNY
	jr z, .apply_animation
	cp DEX_PIKACHU
	jr z, .apply_animation

; Play scanline fade animation for Hoothoot
	ld b, 2
	cp DEX_HOHO
	jr z, .apply_animation

; Play normal send out animation for everyone else
	ld b, 0

.apply_animation
	ld a, b
	ld [wBattleAnimParam], a
	ld de, ANIM_SEND_OUT_MON
	call PlayMoveAnimation

; mon on the right side
	ld a, $f
	ld [wCryTracks], a
	ld a, [wTempEnemyMonSpecies]
	call PlayStereoCry
	call UpdateEnemyHUD

; If battle has just started, go ahead and switch in your monster
	ld a, [wMenuCursorY]
	and a
	ret nz
	xor a
	ld [wBattleParticipantsNotFainted], a
	ld [wBattleParticipantsIncludingFainted], a
	call BackUpTilesToBuffer
	jp SwitchPlayerMon

; BUG: They forgot to terminate the line immediately after StringBuffer1.
; This makes the game halt the script early and throw up an error handler,
; due to reading the start of the following 'text' line as a <NULL> character.
TrainerAboutToUseText:
	text_from_ram wca2b
	text "の　@"
	text_from_ram wStringBuffer1
	text "は<LINE>"
	text_from_ram wEnemyMonNickname
	text "を　くりだそうと　している"

	para "<PLAYER>も　#を"
	line "とりかえますか？"
	done

TrainerSentOutText:
	text_from_ram wca2b
	text "の　@"
	text_from_ram wStringBuffer1
	text "は"
	line "@"
	text_from_ram wEnemyMonNickname
	text "を　くりだした！"
	done

sub_3d071:
	xor a
	ld hl, wCurEnemyMove
	ld [hli], a
	ld [hl], a
	ld hl, wEnemySubStatus1
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wEnemyDisableCount], a
	ld [wEnemyFuryCutterCount], a
	ld [wEnemyDisabledMove], a
	ld [wEnemyMinimized], a
	ret

AnyPartyAlive:
	ld a, [wPartyCount]
	ld e, a
	xor a
	ld hl, wPartyMon1HP
	ld bc, $2f
.loop
	or [hl]
	inc hl
	or [hl]
	add hl, bc
	dec e
	jr nz, .loop
	ld d, a
	ret

HasMonFainted:
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1HP
	ld bc, (wPartyMon2 - wPartyMon1)
	call AddNTimes
	ld a, [hli]
	or [hl]
	ret nz
	ld a, [wBattleHasJustStarted]
	and a
	jr nz, .has_hp
	ld hl, BattleText_TheresNoWillToBattle
	call PrintText
.has_hp
	xor a
	ret

BattleText_TheresNoWillToBattle:
	text "たたかう　きりょくが　ない！"
	prompt

TryRunningFromBattle:
	ld a, [wBattleType]
	cp 2
	jp z, .can_escape
	ld a, [wLinkMode]
	and a
	jp nz, .can_escape
	ld a, [wBattleMode]
	dec a
	jp nz, .trainer_battle
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_CANT_RUN, a
	jp nz, .cannot_escape

	push hl
	push de
	ld a, [wBattleMonItem]
	ld [wNamedObjectIndexBuffer], a
	ld b, a
	callfar GetItemHeldEffect

	ld a, b
	cp HELD_ESCAPE
	pop de
	pop hl
	jr nz, .no_flee_item

	call GetItemName
	ld hl, EscapedUsingItemText
	call PrintText
	jp .can_escape

.no_flee_item
	ld a, [wNumFleeAttempts]
	inc a
	ld [wNumFleeAttempts], a
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ldh [hMultiplicand + 2], a
	ld a, [de]
	inc de
	ldh [hEnemyMonSpeed], a
	ld a, [de]
	ldh [hEnemyMonSpeed + 1], a
	call ReloadTilesFromBuffer
	ld de, hMultiplicand + 1
	ld hl, hEnemyMonSpeed
	ld c, 2
	call memcmp
	jr nc, .can_escape
	
	xor a
	ldh [hMultiplicand], a
	ld a, $20
	ldh [hMultiplier], a
	call Multiply
	ldh a, [hProduct + 2]
	ldh [hDividend], a
	ldh a, [hProduct + 3]
	ldh [hDividend + 1], a
	ldh a, [hEnemyMonSpeed]
	ld b, a
	ldh a, [hEnemyMonSpeed + 1]
	srl b
	rr a
	srl b
	rr a
	and a
	jr z, .can_escape
	ldh [hDivisor], a
	ld b, 2
	call Divide
	ldh a, [hMultiplicand + 1]
	and a
	jr nz, .can_escape
	ld a, [wce39]
	ld c, a
.asm_3d165
	dec c
	jr z, .asm_3d173
	ld b, $1e
	ldh a, [hMultiplicand + 2]
	add b
	ldh [hMultiplicand + 2], a
	jr c, .can_escape
	jr .asm_3d165

.asm_3d173
	call BattleRandom
	ld b, a
	ldh a, [hMultiplicand + 2]
	cp b
	jr nc, .can_escape
	ld a, 1
	ld [wFieldMoveSucceeded], a
.cannot_escape
	ld hl, CantEscapeText
	jr .print_text

.trainer_battle
	ld hl, NoRunningText
.print_text
	call PrintText
	ld a, 1
	ld [wce38], a
	call BackUpTilesToBuffer
	and a
	ret

.can_escape
	ld a, [wLinkMode]
	and a
	ld a, 2
	jr z, .play_sound
	call BackUpTilesToBuffer
	xor a
	ld [wFieldMoveSucceeded], a
	ld a, $f
	ld [wCurMoveNum], a
	call LinkBattleSendRecieveAction
	call ReloadTilesFromBuffer
	ld a, [wOtherPlayerLinkAction]
	cp $f
	ld a, 2
	jr z, .play_sound
	dec a
.play_sound
	ld [wcd5d], a
	push de
	ld de, SFX_RUN
	call WaitPlaySFX
	pop de
	call WaitSFX
	ld hl, GotAwayText
	call PrintText
	call WaitSFX
	call BackUpTilesToBuffer
	scf
	ret

CantEscapeText:
	text "にげられない！"
	prompt

NoRunningText:
	text "ダメだ！"
	line "しょうぶの　さいちゅうに"
	cont "あいてに　せなかは　みせられない！"
	prompt

GotAwayText:
	text "うまく　にげきれた！"
	prompt

EscapedUsingItemText:
	text "<TARGET>は　そうびしていた"
	line "@"
	text_from_ram wStringBuffer1
	text "を　つかって　にげた"
	prompt

LoadBattleMonFromParty:
	ld a, [wCurPartyMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1
	call AddNTimes
	; Copy species, held item, and move
	ld de, wBattleMon
	ld bc, (wPartyMon1ID - wPartyMon1Species)	; 6
	call CopyBytes
	; Skip ID, experience, and stat experience
	ld bc, (wPartyMon1DVs - wPartyMon1ID)	; 15
	add hl, bc
	; Copy DVs, PP, and happiness
	ld de, wBattleMonDVs
	ld bc, (wPartyMon1PokerusStatus - wPartyMon1DVs)	; 7
	call CopyBytes
	; Copy level, status, current and max HP, and stats
	inc hl
	inc hl
	inc hl
	ld de, wBattleMonLevel
	ld bc, (wPartyMon1StatsEnd - wPartyMon1Level)	; 17
	call CopyBytes
	; Copy both types
	ld a, [wTempBattleMonSpecies]
	ld [wCurSpecies], a
	call GetBaseData

	ld a, [wMonHType1]
	ld [wBattleMonType1], a
	ld a, [wMonHType2]
	ld [wBattleMonType2], a

	ld hl, wPartyMonNicknames
	ld a, [wCurBattleMon]
	call SkipNames

	ld de, wBattleMonNickname
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	ld hl, wBattleMonStats
	ld de, wPlayerStats
	ld bc, 2 * NUM_BATTLE_STATS
	call CopyBytes
	call ApplyStatusEffectOnPlayerStats
	call BadgeStatBoosts

	xor a
	ldh [hBattleTurn], a
	callfar GetMonSGBPaletteFlags
	ret

ApplyStatMods:
	ld a, 7
	ld b, 8
	ld hl, wPlayerStatLevels
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret

LoadEnemyMonFromParty:
	ld a, [wCurPartyMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wOTPartyMons
	call AddNTimes
	; Copy species, held item, and move
	ld de, wEnemyMon
	ld bc, (wPartyMon1ID - wPartyMon1Species)	; 6
	call CopyBytes
	; Skip ID, experience, and stat experience
	ld bc, (wPartyMon1DVs - wPartyMon1ID)	; 15
	add hl, bc
	; Copy DVs, PP, and happiness
	ld de, wEnemyMonDVs
	ld bc, (wPartyMon1PokerusStatus - wPartyMon1DVs)	; 7
	call CopyBytes
	; Copy level, status, current and max HP, and stats
	inc hl
	inc hl
	inc hl
	ld de, wEnemyMonLevel
	ld bc, (wPartyMon1StatsEnd - wPartyMon1Level)	; 17
	call CopyBytes

	ld a, [wEnemyMonSpecies]
	ld [wCurSpecies], a
	call GetBaseData

	ld hl, wOTPartyMonNicknames
	ld a, [wCurPartyMon]
	call SkipNames

	ld de, wEnemyMonNickname
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	ld hl, wEnemyMonStats
	ld de, wEnemyStats
	ld bc, 2 * NUM_BATTLE_STATS
	call CopyBytes

	call ApplyStatusEffectOnEnemyStats
	ld hl, wMonHType1
	ld de, wEnemyMonType1
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ld hl, wMonHBaseStats
	ld de, wEnemyMonBaseStats
	ld b, 5
.base_stats_loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .base_stats_loop
	ld a, 7
	ld b, 8
	ld hl, wEnemyStatLevels
.stat_mod_loop
	ld [hli], a
	dec b
	jr nz, .stat_mod_loop
	ld a, [wCurPartyMon]
	ld [wCurOTMon], a
	ret

SendOutPlayerMon:
	ld hl, wBattleMonDVs
	predef GetUnownLetter
	predef LoadMonBackPic
	xor a
	ldh [hGraphicStartTile], a

	ld hl, wBattleMenuCursorPosition
	ld [hli], a
	ld [hl], a
	ld [wTypeModifier], a
	ld [wPlayerMoveStruct + MOVE_ANIM], a
	ld b, SGB_BATTLE_COLORS
	call GetSGBLayout

	ld hl, wEnemySubStatus3
	res SUBSTATUS_USING_TRAPPING_MOVE, [hl]
	xor a
	ldh [hBattleTurn], a
	ld [wNumHits], a

; Play shiny animation for Sunflora and Pikachu
	ld b, 1
	ld a, [wCurPartySpecies]
	cp DEX_SUNNY
	jr z, .apply_animation
	cp DEX_PIKACHU
	jr z, .apply_animation

; Play scanline fade animation for Hoothoot
	ld b, 2
	cp DEX_HOHO
	jr z, .apply_animation

; Play send out animation for everyone else
	ld b, 0

.apply_animation
	ld a, b
	ld [wBattleAnimParam], a
	ld de, ANIM_SEND_OUT_MON
	call PlayMoveAnimation

; mon on the left side
	ld a, $f0
	ld [wCryTracks], a
	ld a, [wCurPartySpecies]
	call PlayStereoCry
	call UpdatePlayerHUD
	ret

sub_3d387:
	xor a
	ld hl, wCurPlayerMove
	ld [hli], a
	ld [hl], a
	ld hl, wPlayerSubStatus1
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wPlayerDisableCount], a
	ld [wPlayerFuryCutterCount], a
	ld [wDisabledMove], a
	ld [wPlayerMinimized], a
	ret

SpikesDamage:
	ld hl, wPlayerScreens
	ld de, wBattleMonType
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyScreens
	ld de, wEnemyMonType

.ok
	bit SCREENS_SPIKES, [hl]
	ret z
	
; Flying-types aren't affected by Spikes.
	ld a, [de]
	cp TYPE_FLYING
	ret z
	inc de
	ld a, [de]
	cp TYPE_FLYING
	ret z

	ld hl, BattleText_UserHurtBySpikes
	call PrintText

	call GetEighthMaxHP
	call SubtractHPFromUser

	ret

BattleText_UserHurtBySpikes:
	text "<USER>は　まきびしの"
	line "ダメージを　うけた！"
	prompt

RecallPlayerMon:
	ldh a, [hBattleTurn]
	push af
	xor a
	ldh [hBattleTurn], a
	ld [wNumHits], a
	ld de, ANIM_RETURN_MON
	call PlayMoveAnimation
	pop af
	ldh [hBattleTurn], a
	ret

; Update level, status, current HP
UpdateBattleMonInParty:
	ld a, [wCurBattleMon]
	ld hl, wPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes

	ld d, h
	ld e, l
	ld hl, wBattleMonLevel
	ld bc, (wBattleMonHP - wBattleMonLevel) + 2
	jp CopyBytes

sub_3d40b:
	ldh a, [hLinkPlayerNumber]
	cp 1
	jr z, asm_3d418
	call sub_3d41f
	call sub_3d42d
	ret

asm_3d418:
	call sub_3d42d
	call sub_3d41f
	ret

sub_3d41f:
	xor a
	ldh [hBattleTurn], a
	call sub_3d43b
	ld a, 1
	ldh [hBattleTurn], a
	call sub_3d43b
	ret

sub_3d42d:
	ld a, 1
	ldh [hBattleTurn], a
	call sub_3d43b
	xor a
	ldh [hBattleTurn], a
	call sub_3d43b
	ret

sub_3d43b:
	callfar GetOpponentItem
	ld a, b
	cp 1
	ret nz
	ld de, wEnemyMonHP + 1
	ld hl, wEnemyMonMaxHP + 1
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3d458
	ld de, wBattleMonHP + 1
	ld hl, wBattleMonMaxHP + 1

asm_3d458:
	push bc
	ld a, [de]
	ld [wHPBarOldHP], a
	add a
	ld c, a
	dec de
	ld a, [de]
	inc de
	ld [wReplacementBlock], a
	adc a
	ld b, a
	ld a, c
	cp [hl]
	dec hl
	ld a, b
	sbc [hl]
	pop bc
	ret nc
	ld a, [hli]
	ld [wMapBlocksAddress], a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld a, [de]
	add c
	ld [wHPBarNewHP], a
	ld c, a
	dec de
	ld a, [de]
	adc 0
	ld [wcdc8], a
	ld b, a
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	jr nc, asm_3d492
	ld a, [hli]
	ld [wcdc8], a
	ld a, [hl]
	ld [wHPBarNewHP], a

asm_3d492:
	ld a, [wcdc8]
	ld [de], a
	inc de
	ld a, [wHPBarNewHP]
	ld [de], a
	call sub_3d4d4
	ldh a, [hBattleTurn]
	ld [wWhichHPBar], a
	and a
	ld hl, $c2ca
	jr z, asm_3d4ac
	ld hl, $c35e

asm_3d4ac:
	ld [wWhichHPBar], a
	predef UpdateHPBar
	call DrawHUDsAndHPBars
	callfar GetOpponentItem
	ld a, [hl]
	ld [wNumSetBits], a
	call GetItemName
	callfar ConsumeHeldItem
	ld hl, RecoveredWithItemText
	jp PrintText

sub_3d4d4:
	ld a, $69
	ld [wFXAnimID], a
	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	predef PlayBattleAnim
	pop af
	ldh [hBattleTurn], a
	ret

RecoveredWithItemText:
	text "<TARGET>は　そうびしていた"
	line "@"
	text_from_ram wStringBuffer1
	text "で　かいふくした！"
	prompt

sub_3d50b:
	ldh a, [hLinkPlayerNumber]
	cp 1
	jr z, asm_3d518
	call sub_3d51f
	call sub_3d537
	ret

asm_3d518:
	call sub_3d537
	call sub_3d51f
	ret

sub_3d51f:
	ld hl, wPartyMon1Item
	ld a, [wCurBattleMon]
	ld bc, $30
	call AddNTimes
	ld bc, wBattleMonItem
	ld de, wPlayerMoveStruct
	ld a, 0
	call sub_3d54f
	ret

sub_3d537:
	ld hl, wOTPartyMon1Item
	ld a, [wCurOTMon]
	ld bc, $30
	call AddNTimes
	ld bc, wEnemyMonItem
	ld de, wEnemyMoveStruct
	ld a, 1
	call sub_3d54f
	ret

sub_3d54f:
	ldh [hBattleTurn], a
	push hl
	push bc
	ld a, [bc]
	ld b, a
	callfar GetItemHeldEffect
	ld hl, Data3d59f

asm_3d560:
	ld a, [hli]
	cp $ff
	jr z, asm_3d59c
	inc hl
	cp b
	jr nz, asm_3d560
	pop bc
	ld a, [bc]
	ld [wNumSetBits], a
	xor a
	ld [bc], a
	dec hl
	ld b, [hl]
	pop hl
	ld [hl], 0
	push de
	push bc
	call GetItemName
	ld hl, UseItemFailedText
	call PrintText
	pop bc
	pop de
	ld a, [de]
	push af
	ld a, $4a
	ld [de], a
	inc de
	ld a, [de]
	push af
	push de
	ld a, b
	ld [de], a
	callfar BattleCommand_StatUp
	pop de
	pop af
	ld [de], a
	pop af
	dec de
	ld [de], a
	ret

asm_3d59c:
	pop bc
	pop hl
	ret

Data3d59f:
	db $1f, $a
	db $20, $b
	db $21, $c
	db $22, $d
	db $23, $e
	db $24, $f
	db $25, $10
	db -1

UseItemFailedText:
	text "<USER>が　そうびしていた"
	line "@"
	text_from_ram wStringBuffer1
	text "が　さどうした！"
	prompt

DrawHUDsAndHPBars:
	call UpdatePlayerHUD
	jp UpdateEnemyHUD

UpdatePlayerHUD:
	xor a
	ldh [hBGMapMode], a
	hlcoord 9, 7
	lb bc, 5, 11
	call ClearBox
	callfar DrawPlayerHUDBorder

	hlcoord 18, 9
	ld [hl], $73
	ld de, wBattleMonNickname
	hlcoord 10, 8
	call CenterMonName
	call PlaceString

	push bc
	ld hl, wBattleMon
	ld de, wTempMon
	ld bc, (wBattleMonMovesEnd - wBattleMonSpecies)
	call CopyBytes

	ld hl, wBattleMonLevel
	ld de, wTempMonLevel
	ld bc, (wBattleMonStatsEnd - wBattleMonLevel)
	call CopyBytes

	ld a, [wTempMonSpecies]
	ld [wCurSpecies], a
	call GetBaseData

	pop hl
	push hl
	inc hl
	ld de, wTempMonStatus
	predef PlaceNonFaintStatus
	pop hl
	jr nz, .dont_print_level
	call PrintLevel

.dont_print_level
	ld a, [wTempMonSpecies]
	ld [wCurPartySpecies], a
	hlcoord 10, 9
	ld b, 1
	predef DrawPlayerHP

	push de
	ld a, [wCurBattleMon]
	ld hl, wPartyMon1Exp + 2
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes

	ld d, h
	ld e, l
	hlcoord 10, 11
	ld a, [wTempMonLevel]
	ld b, a
	call CalcAndPlaceExpBar

	ld a, 1
	ldh [hBGMapMode], a
	pop de
	ld hl, wPlayerHPPal
	call UpdateHPPal

	ld hl, wBattleMonHP
	ld a, [hli]
	or [hl]
	jr z, .no_danger
	ld a, [wBattleLowHealthAlarm]
	and a
	ret nz
	ld a, [wPlayerHPPal]
	cp HP_RED
	jr z, .danger

.no_danger
	ld hl, wLowHealthAlarmBuffer
	bit DANGER_ON_F, [hl]
	ld [hl], 0
	ret z
	ret

.danger
	ld hl, wLowHealthAlarmBuffer
	set DANGER_ON_F, [hl]
	ret

UpdateEnemyHUD:
	xor a
	ldh [hBGMapMode], a
	hlcoord 1, 0
	lb bc, 4, 11
	call ClearBox
	callfar DrawEnemyHUDBorder

	ld de, wEnemyMonNickname
	hlcoord 2, 1
	call CenterMonName
	call PlaceString

	ld h, b
	ld l, c
	push hl
	inc hl
	ld de, wEnemyMonStatus
	predef PlaceNonFaintStatus

	pop hl
	jr nz, .dont_print_level
	ld a, [wEnemyMonLevel]
	ld [wTempMonLevel], a
	call PrintLevel

.dont_print_level
	ld hl, wEnemyMonHP
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hld]
	ldh [hMultiplicand + 2], a
	or [hl]
	jr nz, .hp_not_zero

	ld c, a
	ld e, a
	ld d, 6
	jp .draw_hp_bar

.hp_not_zero
	xor a
	ldh [hMultiplicand], a
	ld a, 48
	ldh [hMultiplier], a
	call Multiply

	ld hl, wEnemyMonMaxHP
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ldh [hDivisor], a
	ld a, b
	and a
	jr z, .do_divide
; if max HP > 255, scale both (current HP * 48) and max HP by dividing by 4 so that max HP fits in one byte
; (it needs to be one byte so it can be used as the divisor for the Divide function)
	ldh a, [hDivisor]
	srl b
	rr a
	srl b
	rr a
	ldh [hDivisor], a
	ldh a, [hProduct + 2]
	ld b, a
	srl b
	ldh a, [hProduct + 3]
	rr a
	srl b
	rr a
	ldh [hDividend + 3], a
	ld a, b
	ldh [hDividend + 2], a
.do_divide
	ldh a, [hDividend + 2]
	ldh [hDividend], a
	ldh a, [hDividend + 3]
	ldh [hDividend + 1], a
	ld a, 2
	ld b, a
	call Divide
	ldh a, [hQuotient + 3]
	ld e, a
	ld a, 6
	ld d, a
	ld c, a
.draw_hp_bar
	xor a
	ld [wWhichHPBar], a
	hlcoord 2, 2
	ld b, 0
	call DrawBattleHPBar
	ld a, 1
	ldh [hBGMapMode], a
	ld hl, wEnemyHPPal
	; fallthrough

UpdateHPPal:
	ld b, [hl]
	call SetHPPal
	ld a, [hl]
	cp b
	ret z
	ld b, SGB_BATTLE_COLORS
	jp GetSGBLayout

; center's mon's name on the battle screen
; if the name is 1 or 2 letters long, it is printed 2 spaces more to the right than usual
; (i.e. for names longer than 4 letters)
; if the name is 3 or 4 letters long, it is printed 1 space more to the right than usual
; (i.e. for names longer than 4 letters)
CenterMonName:
; Function is dummied out in the final game. See "Battle_DummyFunction" in pokegold.
	push de
	inc hl
	inc hl
	ld b, 2
.loop:
	inc de
	ld a, [de]
	cp "@"
	jr z, .done
	inc de
	ld a, [de]
	cp "@"
	jr z, .done
	dec hl
	dec b
	jr nz, .loop
.done:
	pop de
	ret

DisplayBattleMenu:
	call ReloadTilesFromBuffer
	ld a, [wBattleType]
	and a
	jr nz, .menu_loop
	call DrawHUDsAndHPBars
	call PrintEmptyString
	call BackUpTilesToBuffer

.menu_loop:
	callfar LoadBattleMenu
	jr c, .menu_loop
	ld a, [wStartmenuCursor]
	cp 1
	jp z, BattleMenu_Fight
	cp 2
	jp z, BattleMenu_Pack
	cp 3
	jp z, BattleMenu_PKMN
	cp 4
	jp z, BattleMenu_Run
	jr .menu_loop

BattleMenu_Fight:
	xor a
	ld [wNumFleeAttempts], a
	call ReloadTilesFromBuffer
	and a
	ret

BattleMenu_Pack:
	ld a, [wLinkMode]
	and a
	jp nz, .ItemsCantBeUsed
	call LoadStandardMenuHeader
	callfar GetPocket2Status
	xor a
	ld [wSelectedSwapPosition], a
	call ClearPalettes
	callfar DrawBackpack

.item_menu_loop
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	hlcoord 2, 2
	ld b, 8
	ld c, 15
	call DrawTextBox
	call Call_DebugBackpackLoop
	jr c, .didnt_use_item
	call BattleMenuPack_SelectItem
	ld a, [wItemEffectSucceeded]
	and a
	jr z, .item_menu_loop
	call Call_LoadBattleFontsHPBar
	call ClearSprites
	ld a, 1
	ld [wMenuCursorY], a
	call sub_3d832
	ld a, [wWildMon]
	and a
	jr nz, .asm_3d7eb
	call CloseWindow
	call BackUpTilesToBuffer
	call DrawHUDsAndHPBars
	call WaitBGMap
	call ClearWindowData
	call SetPalettes
	and a
	ret

.asm_3d7eb
	xor a
	ld [wWildMon], a
	ld a, 2
	ld [wcd5d], a
	call ClearWindowData
	call SetPalettes
	scf
	ret

.didnt_use_item
	call ClearPalettes
	call DelayFrame
	call Call_LoadBattleFontsHPBar
	call CloseWindow
	call BackUpTilesToBuffer
	call SetPalettes
	jp DisplayBattleMenu

.ItemsCantBeUsed
	ld hl, BattleText_ItemsCantBeUsedHere
	call PrintText
	jp DisplayBattleMenu

BattleText_ItemsCantBeUsedHere:
	text "ここでは　どうぐを"
	line "つかうことは　できません"
	prompt

sub_3d832:
	ld a, [wPlayerSubStatus3]
	bit 5, a
	jr z, .ok
	ld hl, wPlayerRolloutCount
	dec [hl]
	jr nz, .ok
	ld hl, wPlayerSubStatus3
	res 5, [hl]
.ok
	ret

Call_DebugBackpackLoop:
	callfar DebugBackpackLoop
	ret

BattleMenuPack_SelectItem:
	callfar ScrollingMenu_ClearLeftColumn
	call PlaceHollowCursor
	predef LoadItemData
	callfar CheckItemContext
	ld a, [wItemAttributeValue]
	ld hl, .item_attribute_jump_table
	call CallJumptable
	ret

.item_attribute_jump_table:
	dw .cant_use	; ITEMMENU_NOUSE
	dw .cant_use	; TM_HOLDER
	dw .ball_holder	; BALL_HOLDER
	dw .other_bags	; IMPORTANT_BAG/ITEM_BAG
	dw .menu_close	; ITEMMENU_CURRENT
	dw .normal_item_effect	; ITEMMENU_PARTY
	dw .menu_close	; ITEMMENU_CLOSE

.cant_use:
	callfar PrintCantUseText
	xor a
	ld [wItemEffectSucceeded], a
	ret

.ball_holder:
	callfar BallPocket
	jr nc, .menu_close
	xor a
	ld [wItemEffectSucceeded], a
	ret

.other_bags:
	callfar FlipPocket2Status
	xor a
	ld [wSelectedSwapPosition], a
	ld [wItemEffectSucceeded], a
	ret

.normal_item_effect:
	call DoItemEffect
	call ClearPalettes
	callfar DrawBackpack
	ret

.menu_close:
	call DoItemEffect
	ret

BattleMenu_PKMN:
	call LoadStandardMenuHeader

asm_3d8c0:
	call ExitMenu
	call LoadStandardMenuHeader
	xor a
	ld [wPartyMenuActionText], a
	predef OpenPartyMenu_ClearGraphics
	jp c, asm_3d918
	jp asm_3d8eb

asm_3d8d5:
	ld hl, $c387
	ld bc, $81
	ld a, "　"
	call ByteFill
	xor a
	ld [wPartyMenuActionText], a
	predef OpenPartyMenu
	jr c, asm_3d918

asm_3d8eb:
	callfar FreezeMonIcons
	callfar BattleMonMenu
	jr c, asm_3d8d5
	call PlaceHollowCursor
	ld a, [wMenuCursorY]
	cp 1
	jp z, asm_3d982
	cp 2
	jr z, asm_3d912
	cp 3
	jr z, asm_3d918
	jr asm_3d8eb

asm_3d912:
	call sub_3d930
	jp asm_3d8c0

asm_3d918:
	call ClearSprites
	call ClearPalettes
	call _LoadHPBar
	call CloseWindow
	call BackUpTilesToBuffer
	call GetMemSGBLayout
	call SetPalettes
	jp DisplayBattleMenu

sub_3d930:
	call DisableLCD
	ld hl, $9310
	ld de, vSprites
	ld bc, $0110
	call CopyBytes
	ld hl, vFrontPic
	ld de, $8110
	ld bc, $0310
	call CopyBytes
	call EnableLCD
	call ClearSprites
	call LowVolume
	xor a
	ld [wMonType], a
	ld hl, wPartyMon1Species
	predef StatsScreenMain
	call MaxVolume
	call DisableLCD
	ld hl, vSprites
	ld de, $9310
	ld bc, $0110
	call CopyBytes
	ld hl, $8110
	ld de, vFrontPic
	ld bc, $0310
	call CopyBytes
	call EnableLCD
	ret

asm_3d982:
	ld a, [wPlayerSubStatus5]
	bit 7, a
	jr z, asm_3d992
	ld hl, CantBringBackText
	call PrintText
	jp asm_3d8d5

asm_3d992:
	ld a, [wCurBattleMon]
	ld d, a
	ld a, [wCurPartyMon]
	cp d
	jr nz, asm_3d9a5
	ld hl, IsAlreadyOutText
	call PrintText
	jp asm_3d8d5

asm_3d9a5:
	call HasMonFainted
	jp z, asm_3d8d5
	ld a, 1
	ld [wFieldMoveSucceeded], a
	call ClearPalettes
	call ClearSprites
	call _LoadHPBar
	call CloseWindow
	call GetMemSGBLayout
	call SetPalettes

SwitchPlayerMon:
	ld a, [wLinkMode]
	and a
	jr z, asm_3d9cb
	call LinkBattleSendRecieveAction

asm_3d9cb:
	call RetreatMon
	ld c, 50
	call DelayFrames
	call RecallPlayerMon
	hlcoord 9, 7
	lb bc, 5, 11
	call ClearBox
	ld a, [wCurPartyMon]
	ld [wCurBattleMon], a
	ld c, a
	ld b, 1
	push bc
	ld hl, wBattleParticipantsNotFainted
	predef SmallFarFlagAction
	pop bc
	ld hl, wBattleParticipantsIncludingFainted
	predef SmallFarFlagAction
	call LoadBattleMonFromParty
	call ApplyStatMods
	call PrintSendOutMonMessage
	call sub_3d387
	call SendOutPlayerMon
	call PrintEmptyString
	call BackUpTilesToBuffer
	xor a
	ldh [hBattleTurn], a
	call SpikesDamage
	ld a, 2
	ld [wMenuCursorY], a
	and a
	ret

PassedBattleMonEntrance:
	ld c, 50
	call DelayFrames

	ld a, [wLinkMode]
	and a
	jr z, .not_link_battle

	call LinkBattleSendRecieveAction

.not_link_battle
	hlcoord 9, 7
	lb bc, 5, 11
	call ClearBox

	ld a, [wCurPartyMon]
	ld [wCurBattleMon], a
	ld c, a
	ld b, SET_FLAG
	push bc
	ld hl, wBattleParticipantsNotFainted
	predef SmallFarFlagAction
	pop bc
	ld hl, wBattleParticipantsIncludingFainted
	predef SmallFarFlagAction

	call LoadBattleMonFromParty
	xor a
	ld [wApplyStatLevelMultipliersToEnemy], a
	call ApplyStatLevelMultiplierOnAllStats
	call SendOutPlayerMon
	call PrintEmptyString
	call BackUpTilesToBuffer
	xor a
	ldh [hBattleTurn], a
	call SpikesDamage
	ret

IsAlreadyOutText:
	text_from_ram wBattleMonNickname
	text "はもうでています"
	prompt

CantBringBackText:
	text_from_ram wBattleMonNickname
	text "を　もどすことが"
	line "できない！"
	prompt

BattleMenu_Run:
	call ReloadTilesFromBuffer
	ld a, 3
	ld [wMenuCursorY], a
	ld hl, wBattleMonSpeed
	ld de, wEnemyMonSpeed
	call TryRunningFromBattle
	ld a, 0
	ld [wce38], a
	ret c
	ld a, [wFieldMoveSucceeded]
	and a
	ret nz
	jp DisplayBattleMenu

MoveSelectionScreen::
	ld hl, wEnemyMonMoves
	ld a, [wMoveSelectionMenuType]
	dec a
	jr z, .got_menu_type
	dec a
	jr z, .ether_elixer_menu
	call .CheckPlayerHasUsableMoves
	ret z
	ld hl, wBattleMonMoves
	jr .got_menu_type

.ether_elixer_menu
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes

.got_menu_type
	ld de, wListMoves_MoveIndicesBuffer
	ld bc, NUM_MOVES
	call CopyBytes
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 17 - (NUM_MOVES * 2) - 1
	ld b, 8
	ld c, 8
	ld a, [wMoveSelectionMenuType]
	cp 2
	jr nz, .got_dims
	hlcoord 10, 17 - (NUM_MOVES * 2) - 1
	ld b, 8
	ld c, 8

.got_dims
	call DrawTextBox
	hlcoord 2, 17 - (NUM_MOVES * 2) + 1
	ld a, [wMoveSelectionMenuType]
	cp 2
	jr nz, .got_start_coord
	hlcoord 12, 17 - (NUM_MOVES * 2) + 1

.got_start_coord
	ld a, SCREEN_WIDTH * 2
	ld [wHPBarMaxHP], a
	predef ListMoves

	ld b, 1
	ld a, [wMoveSelectionMenuType]
	cp 2
	jr nz, .got_default_coord
	ld b, 11

.got_default_coord
	ld a, 17 - (NUM_MOVES * 2) + 1
	ld [w2DMenuCursorInitY], a
	ld a, b
	ld [w2DMenuCursorInitX], a
	ld a, [wMoveSelectionMenuType]
	cp 1
	jr z, .skip_inc
	ld a, [wCurMoveNum]
	inc a

.skip_inc
	ld [wMenuCursorY], a
	ld a, 1
	ld [wMenuCursorX], a
	ld a, [wNumMoves]
	inc a
	ld [w2DMenuNumRows], a
	ld a, 1
	ld [w2DMenuNumCols], a

	ld c, STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP
	ld a, [wMoveSelectionMenuType]
	dec a
	ld b, D_DOWN | D_UP | A_BUTTON
	jr z, .okay

	dec a
	ld b,  D_DOWN | D_UP | A_BUTTON | B_BUTTON
	jr z, .okay

	ld a, [wLinkMode]
	cp 3 ; LINK_COLOSSEUM
	jr z, .okay

	ld a, [wDebugFlags]
	bit DEBUG_BATTLE_F, a
	ld b, D_DOWN | D_UP | A_BUTTON | B_BUTTON | SELECT
	jr z, .okay

	ld b, D_DOWN | D_UP | D_LEFT | D_RIGHT | A_BUTTON | B_BUTTON | START | SELECT
	ld c, STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_SELECT | STATICMENU_DISABLE_B | STATICMENU_ENABLE_START | STATICMENU_WRAP

.okay
	ld a, b
	ld [wMenuJoypadFilter], a
	ld a, c
	ld [w2DMenuFlags1], a
	xor a
	ld [w2DMenuFlags2], a
	ld a, $20
	ld [w2DMenuCursorOffsets], a

.menu_loop
	ld a, [wMoveSelectionMenuType]
	and a
	jr z, .battle_player_moves

	dec a
	jr nz, .interpret_joypad
	hlcoord 11, 14
	ld de, .Unused_BattleText_MimicWhichMove
	call PlaceString
	jr .interpret_joypad

.battle_player_moves
	ld a, [wDebugFlags]
	bit 0, a
	jr nz, .interpret_joypad
	
	call MoveInfoBox
	ld a, [wSelectedSwapPosition]
	and a
	jr z, .interpret_joypad
	hlcoord 1, 18 - (NUM_MOVES * 2)
	dec a
	ld bc, SCREEN_WIDTH * 2
	call AddNTimes
	ld [hl], "▷"

.interpret_joypad
	call WaitBGMap
	ld a, 1
	ldh [hBGMapMode], a
	call ScrollingMenuJoypad
	bit D_UP_F, a
	jp nz, .pressed_up
	bit D_DOWN_F, a
	jp nz, .pressed_down
	bit SELECT_F, a
	jp nz, .pressed_select
	bit START_F, a
	jp nz, .pressed_start
	bit D_RIGHT_F, a
	jp nz, .pressed_right
	bit D_LEFT_F, a
	jp nz, .pressed_left
	bit B_BUTTON_F, a
	; A button
	push af

	xor a
	ld [wSelectedSwapPosition], a
	ld a, [wMenuCursorY]
	dec a
	ld [wMenuCursorY], a
	ld b, a
	ld a, [wMoveSelectionMenuType]
	dec a
	jr nz, .not_enemy_moves_process_b
	pop af
	ret

.not_enemy_moves_process_b
	dec a
	ld a, b
	ld [wCurMoveNum], a
	jr nz, .use_move

	pop af
	ret

.use_move
	pop af
	ret nz

	ld hl, wBattleMonPP
	ld a, [wMenuCursorY]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	and PP_MASK
	jr z, .no_pp_left

	ld a, [wPlayerDisableCount]
	swap a
	and $f
	dec a
	cp c
	jr z, .move_disabled

	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TRANSFORMED, a
	jr nz, .transformed
	; something was commented out here
.transformed
	ld a, [wMenuCursorY]
	ld hl, wBattleMonMoves
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wCurPlayerSelectedMove], a
	xor a
	ret

.move_disabled
	ld hl, .BattleText_TheMoveIsDisabled
	jr .place_textbox_start_over

.no_pp_left
	ld hl, .BattleText_TheresNoPPLeftForThisMove

.place_textbox_start_over
	call PrintText
	call ReloadTilesFromBuffer
	jp MoveSelectionScreen



.BattleText_TheresNoPPLeftForThisMove:
	text "わざの　のこりポイントが　ない！"
	prompt

.BattleText_TheMoveIsDisabled:
	text "わざを　ふうじられている！"
	prompt

.Unused_BattleText_MimicWhichMove:
	db   "どのわざを"
	next "ものまねする？@"

.pressed_up
	ld a, [wMenuCursorY]
	and a
	jp nz, .menu_loop
	ld a, [wNumMoves]
	inc a
	ld [wMenuCursorY], a
	jp .menu_loop

.pressed_down
	ld a, [wMenuCursorY]
	ld b, a
	ld a, [wNumMoves]
	inc a
	inc a
	cp b
	jp nz, .menu_loop
	ld a, 1
	ld [wMenuCursorY], a
	jp .menu_loop

.DebugMovePreview:
.pressed_start
	bit START_F, a
	ld a, 0
	jr nz, .player_side
	ld a, 1

.player_side
	ldh [hBattleTurn], a
	call ReloadTilesFromBuffer
	call .DrawDebugMoveSelection
	ld a, [wPlayerDebugSelectedMove]
	and a
	jp z, MoveSelectionScreen
	ld [wFXAnimID], a
	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	predef PlayBattleAnim
	jp MoveSelectionScreen

.pressed_left
	ld a, [wPlayerDebugSelectedMove]
	dec a
	jr .pressed_left_right_continue

.pressed_right
	ld a, [wPlayerDebugSelectedMove]
	inc a

.pressed_left_right_continue
	ld [wPlayerDebugSelectedMove], a
	call .DrawDebugMoveSelection
	jp MoveSelectionScreen

.DrawDebugMoveSelection:
	hlcoord 10, 16
	lb bc, 2, 10
	call ClearBox

	hlcoord 10, 17
	ld de, wPlayerDebugSelectedMove
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNumber

	ld a, [wPlayerDebugSelectedMove]
	and a
	ret z
	cp NUM_ATTACKS + 1
	ret nc

	ld [wNamedObjectIndexBuffer], a
	call GetMoveName
	hlcoord 13, 17
	jp PlaceString

.CheckPlayerHasUsableMoves:
	ld a, MOVE_STRUGGLE
	ld [wCurPlayerSelectedMove], a
	ld a, [wPlayerDisableCount]
	and a
	ld hl, wBattleMonPP
	jr nz, .disabled

	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	inc hl
	or [hl]
; BUG: There should be "and PP_MASK" here
	ret nz
	jr .force_struggle

.disabled
	swap a
	and $f
	ld b, a
	ld d, NUM_MOVES + 1
	xor a
.loop
	dec d
	jr z, .done
	ld c, [hl]
	inc hl
	dec b
	jr z, .loop
	or c
	jr .loop

.done
	; BUG: This will result in a move with PP Up confusing the game.
	and a ; should be "and PP_MASK"
	ret nz

.force_struggle
	ld hl, .BattleText_MonHasNoMovesLeft
	call PrintText
	ld c, 60
	call DelayFrames
	xor a
	ret

.BattleText_MonHasNoMovesLeft:
	text_from_ram wBattleMonNickname
	text "は　だすことの　できる"
	line "わざが　ない！"
	done

.pressed_select
	ld a, [wDebugFlags]
	bit DEBUG_BATTLE_F, a
	jp nz, .DebugMovePreview

	ld a, [wSelectedSwapPosition]
	and a
	jr z, .start_swap
	ld hl, wBattleMonMoves
	call .swap_bytes
	ld hl, wBattleMonPP
	call .swap_bytes
	ld hl, wPlayerDisableCount
	ld a, [hl]
	swap a
	and $f
	ld b, a
	ld a, [wMenuCursorY]
	cp b
	jr nz, .not_swapping_disabled_move
	ld a, [hl]
	and $f
	ld b, a
	ld a, [wSelectedSwapPosition]
	swap a
	add b
	ld [hl], a
	jr .swap_moves_in_party_struct

.not_swapping_disabled_move
	ld a, [wSelectedSwapPosition]
	cp b
	jr nz, .swap_moves_in_party_struct
	ld a, [hl]
	and $f
	ld b, a
	ld a, [wMenuCursorY]
	swap a
	add b
	ld [hl], a

.swap_moves_in_party_struct
; BUG: COOLTRAINER glitch from Generation I still exists here.
	ld hl, wPartyMon1Moves
	ld a, [wCurBattleMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	push hl
	call .swap_bytes
	pop hl
	ld bc, MON_PP - MON_MOVES
	add hl, bc
	call .swap_bytes
	xor a
	ld [wSelectedSwapPosition], a
	jp MoveSelectionScreen

.swap_bytes
	push hl
	ld a, [wSelectedSwapPosition]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wMenuCursorY]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [de]
	ld b, [hl]
	ld [hl], a
	ld a, b
	ld [de], a
	ret

.start_swap
	ld a, [wMenuCursorY]
	ld [wSelectedSwapPosition], a
	jp MoveSelectionScreen

MoveInfoBox:
	xor a
	ldh [hBGMapMode], a

	hlcoord 9, 12
	ld b, 4
	ld c, 9
	call DrawTextBox

	ld a, [wPlayerDisableCount]
	and a
	jr z, .not_disabled

	swap a
	and $f
	ld b, a
	ld a, [wMenuCursorY]
	cp b
	jr nz, .not_disabled

	hlcoord 10, 15
	ld de, .Disabled
	call PlaceString
	jr .done

.not_disabled
	ld hl, wMenuCursorY
	dec [hl]
	xor a
	ldh [hBattleTurn], a
	ld hl, wBattleMonMoves
	ld a, [wMenuCursorY]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wCurPlayerSelectedMove], a

	ld a, [wCurBattleMon]
	ld [wCurPartyMon], a
	ld a, WILDMON
	ld [wMonType], a
	callfar GetMaxPPOfMove

	ld hl, wMenuCursorY
	ld c, [hl]
	inc [hl]
	ld b, 0
	ld hl, wBattleMonPP
	add hl, bc
	ld a, [hl]
	and PP_MASK
	ld [wStringBuffer1], a
	hlcoord 10, 15
	ld de, .Type
	call PlaceString

	hlcoord 16, 13
	ld [hl], "／"
	hlcoord 14, 16
	ld [hl], "／"
	hlcoord 14, 13
	ld de, wStringBuffer1
	lb bc, 1, 2
	call PrintNumber

	hlcoord 17, 13
	ld de, wTempPP
	lb bc, 1, 2
	call PrintNumber

	callfar UpdateMoveData
	ld a, [wPlayerMoveStruct]
	ld b, a
	hlcoord 15, 16
	predef PrintMoveType

.done
	jp WaitBGMap

.Disabled:
	db "ふうじられている！@"
.Type:
	db "わざタイプ@"

sub_3de6e:
	ld a, [wLinkMode]
	and a
	jr z, asm_3dea0
	call BackUpTilesToBuffer
	ld a, [wFieldMoveSucceeded]
	and a
	call z, LinkBattleSendRecieveAction
	call ReloadTilesFromBuffer
	ld a, [wOtherPlayerLinkAction]
	cp $e
	jp z, asm_3df82
	cp $d
	jr z, asm_3df04
	cp 4
	jp nc, asm_3df86
	ld [wCurEnemyMoveNum], a
	ld c, a
	ld hl, wEnemyMonMoves
	ld b, 0
	add hl, bc
	ld a, [hl]
	jp asm_3df68

asm_3dea0:
	ld hl, wEnemySubStatus5
	bit 4, [hl]
	jr z, asm_3dedc
	ld a, [wEnemyEncoreCount]
	dec a
	ld [wEnemyEncoreCount], a
	jr nz, asm_3dec1

asm_3deb0:
	ld hl, wEnemySubStatus5
	res 4, [hl]
	ld a, 1
	ldh [hBattleTurn], a
	ld hl, BattleText_TargetsEncoreEnded
	call PrintText
	jr asm_3dedc

asm_3dec1:
	ld a, [wCurEnemyMove]
	and a
	jr z, asm_3deb0
	ld hl, wEnemyMonPP
	ld a, [wCurEnemyMoveNum]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	and $3f
	jr z, asm_3deb0
	ld a, [wCurEnemyMove]
	jp asm_3df68

asm_3dedc:
	ld a, [wEnemySubStatus4]
	and $60
	jp nz, asm_3df86
	ld hl, wEnemySubStatus3
	ld a, [hl]
	and $12
	jp nz, asm_3df86
	ld hl, wEnemySubStatus1
	bit 6, [hl]
	jp nz, asm_3df86
	ld a, [wEnemySubStatus3]
	and $21
	jp nz, asm_3df86
	ld a, [wPlayerSubStatus3]
	bit 5, a
	jr asm_3df08

asm_3df04:
	ld a, $ff
	jr asm_3df68

asm_3df08:
	ld hl, wEnemyMonPP
	ld bc, 0

asm_3df0e:
	inc b
	ld a, b
	cp 5
	jr z, asm_3df26
	ld a, [hli]
	and $3f
	jr z, asm_3df0e
	ld a, [wEnemyDisableCount]
	swap a
	and $f
	cp b
	jr z, asm_3df0e
	inc c
	jr asm_3df0e

asm_3df26:
	ld a, c
	and a
	jr z, asm_3df82
	ld a, [wBattleMode]
	dec a
	jr z, asm_3df3f
	ld a, 1
	ld [wca22], a
	callfar Function384d4
	jr asm_3df6b

asm_3df3f:
	ld hl, wEnemyMonMoves
	call BattleRandom
	and 3
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wEnemyDisableCount]
	swap a
	and $f
	dec a
	cp c
	jr z, asm_3df3f
	ld a, [hl]
	and a
	jr z, asm_3df3f
	ld hl, wEnemyMonPP
	add hl, bc
	ld b, a
	ld a, [hl]
	and a
	jr z, asm_3df3f
	ld a, c
	ld [wCurEnemyMoveNum], a
	ld a, b

asm_3df68:
	ld [wCurEnemySelectedMove], a

asm_3df6b:
	ld a, 1
	ldh [hBattleTurn], a
	callfar UpdateMoveData
	ld a, [wEnemyMoveStructEffect]
	cp $77
	ret z
	xor a
	ld [wEnemyFuryCutterCount], a
	ret

asm_3df82:
	ld a, $a5
	jr asm_3df68

asm_3df86:
	xor a
	ld [wEnemyFuryCutterCount], a
	ret

LinkBattleSendRecieveAction:
	ld a, $ff
	ld [wOtherPlayerLinkAction], a
	ld a, [wBattlePlayerAction]
	and a ; BATTLEPLAYERACTION_USEMOVE?
	jr nz, .switch

	ld a, [wCurPlayerSelectedMove]
	cp MOVE_STRUGGLE
	ld b, BATTLEACTION_STRUGGLE
	jr z, .struggle

	dec b
	inc a
	jr z, .struggle
	ld a, [wCurMoveNum]
	jr .use_move

.switch
	ld a, [wCurPartyMon]
	add BATTLEACTION_SWITCH1
	ld b, a

.struggle
	ld a, b

.use_move
	ld [wPlayerLinkAction], a
	callfar PlaceWaitingText

.waiting
	call LinkTransfer
	call DelayFrame
	ld a, [wOtherPlayerLinkAction]
	inc a
	jr z, .waiting
	ld b, 10

.recieve
	call DelayFrame
	call LinkTransfer
	dec b
	jr nz, .recieve
	ld b, 10

.acknowledge
	call DelayFrame
	call LinkDataReceived
	dec b
	jr nz, .acknowledge
	ret

BattleText_TargetsEncoreEnded:
	text "<TARGET>の<LINE>アンコールじょうたいが　とけた！<PROMPT>"

asm_3dff2:
	ldh a, [hBattleTurn]
	and a
	ld hl, wCurEnemySelectedMove
	ld de, wEnemyMoveStructPower
	ld a, [wCurPlayerSelectedMove]
	jr z, asm_3e009
	ld hl, wCurPlayerSelectedMove
	ld de, wPlayerMoveStructPower
	ld a, [wCurEnemySelectedMove]

asm_3e009:
	cp MOVE_COUNTER
	ret nz
	ld a, 1
	ld [wAttackMissed], a
	ld a, [hl]
	cp MOVE_COUNTER
	ret z
	ld a, [de]
	and a
	ret z
	inc de
	ld a, [de]
	and a
	jr z, asm_3e023
	cp 1
	jr z, asm_3e023
	xor a
	ret

asm_3e023:
	ld hl, wCurDamage
	ld a, [hli]
	or [hl]
	ret z
	ld a, [hl]
	add a
	ld [hld], a
	ld a, [hl]
	adc a
	ld [hl], a
	jr nc, asm_3e035
	ld a, $ff
	ld [hli], a
	ld [hl], a

asm_3e035:
	xor a
	ld [wAttackMissed], a
	callfar BattleCommand_CheckHit
	xor a
	ret

; Initialize enemy monster parameters
; To do this we pull the species from wTempEnemyMonSpecies
LoadEnemyMon:
; Notes:
;   BattleRandom is used to ensure sync between Game Boys

; We don't need to be here if we're in a link battle
	ld a, [wLinkMode]
	and a
	jp nz, LoadEnemyMonFromParty

; Make sure everything knows what species we're working with
	ld a, [wTempEnemyMonSpecies]
	ld [wEnemyMonSpecies], a
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a

; Grab the BaseData for this species
	call GetBaseData

; Let's get the item:

; Is the item predetermined?	
	ld a, [wBattleMode]
	cp TRAINER_BATTLE
	jr nz, .WildItem

; If we're in a trainer battle, the item is in the party struct
	ld a, [wCurPartyMon]
	ld hl, wOTPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [hl]
	jr .UpdateItem

.WildItem
; ~20% chance of getting an item.
	call BattleRandom
	cp 79 percent - 1
	ld a, 0
	jr c, .UpdateItem
	ld a, [wMonHItems]

.UpdateItem
	ld [wEnemyMonItem], a
	ld a, [wEnemySubStatus5]
	bit SUBSTATUS_TRANSFORMED, a
	ld hl, wEnemyBackupDVs
	ld a, [hli]
	ld b, [hl]
	jr nz, .UpdateDVs

; Load preset middle-class DVs for trainer battles.
	ld a, [wBattleMode]
	cp TRAINER_BATTLE
	ln a, 9, 8
	ln b, 8, 8
	jr z, .UpdateDVs

; Otherwise randomly generate DVs for wild encounters
	call BattleRandom
	ld b, a
	call BattleRandom

.UpdateDVs
	ld hl, wEnemyMonDVs
	ld [hli], a
	ld [hl], b

	ld a, [wCurPartyLevel]
	ld [wEnemyMonLevel], a
	ld de, wEnemyMonMaxHP
	ld b, 0
	; This address doesn't seem to be referenced anywhere
	ld hl, wEnemyMonDVs - (MON_DVS - MON_STAT_EXP + 1)
	predef CalcMonStats

	ld a, [wBattleMode]
	cp TRAINER_BATTLE
	jr z, .OpponentParty

	ld a, [wEnemySubStatus5]
	bit SUBSTATUS_TRANSFORMED, a
	jr nz, .Moves

; Zero out status when generating Pokémon
	ld hl, wEnemyMonStatus
	xor a
	ld [hli], a
	ld [hli], a

; Set HP equal to max HP.
	ld a, [wEnemyMonMaxHP]
	ld [hli], a
	ld a, [wEnemyMonMaxHP + 1]
	ld [hli], a
	jr .Moves

.OpponentParty
; Get HP from the party struct
	ld hl, wOTPartyMon1HP + 1
	ld a, [wCurPartyMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [hld]
	ld [wEnemyMonHP + 1], a
	ld a, [hld]
	ld [wEnemyMonHP], a

; Make sure everything knows which monster the opponent is using
	ld a, [wCurPartyMon]
	ld [wCurOTMon], a

; Get status from the party struct
	dec hl
	ld a, [hl]
	ld [wEnemyMonStatus], a

.Moves
	ld hl, wMonHType1
	ld de, wEnemyMonType1
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a

	ld de, wEnemyMonMoves
	ld a, [wBattleMode]
	cp TRAINER_BATTLE
	jr nz, .WildMoves

	ld hl, wOTPartyMon1Moves
	ld a, [wCurPartyMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld bc, NUM_MOVES
	call CopyBytes
	jr .PP

.WildMoves
	xor a
	ld h, d
	ld l, e
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wSkipMovesBeforeLevelUp], a
	predef FillMoves

.PP
	ld hl, wEnemyMonMoves
	ld de, wEnemyMonPP
	predef FillPP

.Finish
	ld hl, wMonHBaseStats
	ld de, wEnemyMonBaseStats
	ld b, NUM_BATTLE_STATS

.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop

	ld a, [wMonHCatchRate]
	ld [de], a

	inc de
	ld a, [wMonHBaseEXP]
	ld [de], a

	ld a, [wTempEnemyMonSpecies]
	ld [wNamedObjectIndexBuffer], a

	call GetPokemonName

; Update enemy nickname
	ld hl, wStringBuffer1
	ld de, wEnemyMonNickname
	ld bc, MON_NAME_LENGTH
	call CopyBytes

; Saw this mon
	ld a, [wTempEnemyMonSpecies]
	dec a
	ld c, a
	ld b, 1
	ld hl, wEndPokedexCaught
	predef SmallFarFlagAction
	ld hl, wEnemyMonStats
	ld de, wEnemyStats
	ld bc, NUM_BATTLE_STATS * 2
	call CopyBytes

	ld a, 7
	ld b, 8
	ld hl, wEnemyStatLevels

.InitStatLevel
	ld [hli], a
	dec b
	jr nz, .InitStatLevel

	ld a, 1
	ldh [hBattleTurn], a
	callfar GetMonSGBPaletteFlags
	ret

asm_3e193:
	push bc
	ld a, [wBattleMonLevel]
	ld b, a
	ld a, [wEnemyMonLevel]
	ld [wBattleMonLevel], a
	ld a, b
	ld [wEnemyMonLevel], a
	pop bc
	ret

; A leftover from Generation I, where it had no effect due to no stats actually being selected.
; BUG: Remarkably, this is STILL run from HealStatus despite the stat double/halve bitfields
; being overwritten with variables that are actually used as substatuses.
DoubleOrHalveSelectedStats_Old::
	call DoubleSelectedStats
	jp HalveSelectedStats

DoubleSelectedStats:
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerSubStatus1] ; wPlayerStatsToDouble
	ld hl, wBattleMonAttack + 1
	jr z, .notEnemyTurn
	ld a, [wEnemySubStatus1] ; wEnemyStatsToDouble
	ld hl, wEnemyMonAttack + 1

.notEnemyTurn
	ld c, 4
	ld b, a

.loop
	srl b
	call c, .doubleStat
	inc hl
	inc hl
	dec c
	ret z
	jr .loop

.doubleStat
	ld a, [hl]
	add a
	ld [hld], a
	ld a, [hl]
	rl a
	ld [hli], a
	ret

HalveSelectedStats:
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerSubStatus2] ; wPlayerStatsToHalve
	ld hl, wBattleMonAttack
	jr z, .notEnemyTurn
	ld a, [wEnemySubStatus2] ; wEnemyStatsToHalve
	ld hl, wEnemyMonAttack
.notEnemyTurn
	ld c, 4
	ld b, a
.loop
	srl b
	call c, .halveStat
	inc hl
	inc hl
	dec c
	ret z
	jr .loop

.halveStat
	ld a, [hl]
	srl a
	ld [hli], a
	ld d, a
	ld a, [hl]
	rr a
	ld [hl], a
	or d
	jr nz, .nonzeroStat
	ld a, 1
	ld [hl], a
.nonzeroStat
	dec hl
	ret

sub_3e201:
	xor a
	ld [wTempEnemyMonSpecies], a
	ld b, 1
	call GetSGBLayout
; Should be a call instead
	callfar sub_3f003
	ld hl, $c2b3
	ld c, 0

asm_3e217:
	inc c
	ld a, c
	cp 7
	ret z
	ld d, 0
	push bc
	push hl

asm_3e220:
	call sub_3e235
	inc hl
	ld a, 7
	add d
	ld d, a
	dec c
	jr nz, asm_3e220
	ld c, 4
	call DelayFrames
	pop hl
	pop bc
	dec hl
	jr asm_3e217

sub_3e235:
	push hl
	push de
	push bc
	ld e, 7

asm_3e23a:
	ld [hl], d
	ld bc, $14
	add hl, bc
	inc d
	dec e
	jr nz, asm_3e23a
	pop bc
	pop de
	pop hl
	ret

ApplyStatusEffectOnPlayerStats:
	ld a, 1
	jr ApplyStatusEffectOnStats

ApplyStatusEffectOnEnemyStats:
	xor a

ApplyStatusEffectOnStats:
	ldh [hBattleTurn], a
	call ApplyPrzEffectOnSpeed
	jp ApplyBrnEffectOnAttack

ApplyPrzEffectOnSpeed:
	ldh a, [hBattleTurn]
	and a
	jr z, .enemy
	ld a, [wBattleMonStatus]
	and 1 << PAR
	ret z
	ld hl, wBattleMonSpeed + 1
	ld a, [hld]
	ld b, a
	ld a, [hl]
	srl a
	rr b
	srl a
	rr b
	ld [hli], a
	or b
	jr nz, .player_ok
	ld b, 1

.player_ok:
	ld [hl], b
	ret

.enemy:
	ld a, [wEnemyMonStatus]
	and 1 << PAR
	ret z
	ld hl, wEnemyMonSpeed + 1
	ld a, [hld]
	ld b, a
	ld a, [hl]
	srl a
	rr b
	srl a
	rr b
	ld [hli], a
	or b
	jr nz, .enemy_ok
	ld b, 1

.enemy_ok:
	ld [hl], b
	ret

ApplyBrnEffectOnAttack:
	ldh a, [hBattleTurn]
	and a
	jr z, .enemy
	ld a, [wBattleMonStatus]
	and 1 << BRN
	ret z
	ld hl, wBattleMonAttack + 1
	ld a, [hld]
	ld b, a
	ld a, [hl]
	srl a
	rr b
	ld [hli], a
	or b
	jr nz, .player_ok
	ld b, 1 ; min attack

.player_ok
	ld [hl], b
	ret

.enemy
	ld a, [wEnemyMonStatus]
	and 1 << BRN
	ret z
	ld hl, wEnemyMonAttack + 1
	ld a, [hld]
	ld b, a
	ld a, [hl]
	srl a
	rr b
	ld [hli], a
	or b
	jr nz, .enemy_ok
	ld b, 1 ; min attack

.enemy_ok
	ld [hl], b
	ret

ApplyStatLevelMultiplierOnAllStats:
	ld c, 0

.stat_loop
	call ApplyStatLevelMultiplier
	inc c
	ld a, c
	cp NUM_BATTLE_STATS
	jr nz, .stat_loop
	ret

ApplyStatLevelMultiplier:
	push bc
	push bc
	ld a, [wApplyStatLevelMultipliersToEnemy]
	and a
	ld a, c

	ld hl, wBattleMonStats
	ld de, wPlayerStats
	ld bc, wPlayerStatLevels
	jr z, .got_pointers

	ld hl, wEnemyMonStats
	ld de, wEnemyStats
	ld bc, wEnemyStatLevels

.got_pointers
; Adds a (battle stat index) to StatLevels, increase b if c overflows.
	add c
	ld c, a
	jr nc, .okay
	inc b

.okay
	ld a, [bc]
	pop bc
; b = Stat Level
	ld b, a
	push bc
; c = Stat index * 2. Add to MonStats pointer.
	sla c
	ld b, 0
	add hl, bc
	ld a, c
; Add stat index * 2 to wEnemyStats.
	add e
	ld e, a
	jr nc, .okay2
	inc d

.okay2
	pop bc
	push hl
	ld hl, StatLevelMultipliers_Applied
; Get index of stat level from StatLevelMultipliers_Applied.
	dec b
	sla b
	ld c, b
	ld b, 0
	add hl, bc
; Load enemy's original stat into Multiplicand.
	xor a
	ldh [hMultiplicand], a
	ld a, [de]
	ldh [hMultiplicand + 1], a
	inc de
	ld a, [de]
	ldh [hMultiplicand + 2], a

; Load multiplication value from StatLevelMultipliers_Applied.
	ld a, [hli]
	ldh [hMultiplier], a
	call Multiply

; Load division value from same table.
	ld a, [hl]
	ldh [hDivisor], a
	ld b, 4
	call Divide

; Cap at 999.
	pop hl
	ldh a, [hQuotient + 3]
	sub LOW(MAX_STAT_VALUE)
	ldh a, [hQuotient + 2]
	sbc HIGH(MAX_STAT_VALUE)
	jp c, .okay3

	ld a, HIGH(MAX_STAT_VALUE)
	ldh [hQuotient + 2], a
	ld a, LOW(MAX_STAT_VALUE)
	ldh [hQuotient + 3], a

.okay3
; Load output into MonStat.
	ldh a, [hQuotient + 2]
	ld [hli], a
	ld b, a
	ldh a, [hQuotient + 3]
	ld [hl], a
	or b
; Keep at minimum of 1
	jr nz, .okay4
	inc [hl]

.okay4
	pop bc
	ret

StatLevelMultipliers_Applied:
	INCLUDE "data/battle/stat_multipliers.inc"

; Checks every odd-numbered badge, and triggers their corresponding boosts.
; Stat boosts are identical to Gen 1, with Special Attack replacing Special.
BadgeStatBoosts:
	ld a, [wLinkMode]
	cp 3 ; LINK_COLOSSEUM
	ret z

	ld a, [wBadges]
	ld b, a
	ld hl, wBattleMonAttack
	ld c, 4

.CheckBadge
	srl b
	call c, BoostStat
	inc hl
	inc hl
; Check every other badge.
	srl b
	dec c
	jr nz, .CheckBadge
	ret

; Raise stat at hl by 1/8.
BoostStat:
	ld a, [hli]
	ld d, a
	ld e, [hl]
	srl d
	rr e
	srl d
	rr e
	srl d
	rr e
	ld a, [hl]
	add e
	ld [hld], a
	ld a, [hl]
	adc d
	ld [hli], a

; Cap at 999.
	ld a, [hld]
	sub LOW(MAX_STAT_VALUE)
	ld a, [hl]
	sbc HIGH(MAX_STAT_VALUE)
	ret c
	ld a, HIGH(MAX_STAT_VALUE)
	ld [hli], a
	ld a, LOW(MAX_STAT_VALUE)
	ld [hld], a
	ret

Call_LoadBattleFontsHPBar:
	jpfar LoadBattleFontsHPBar

_LoadHPBar:
	jpfar LoadHPBar

	ld de, HpExpBarParts0GFX
	ld hl, vChars2 tile $6c
	lb bc, BANK(HpExpBarParts0GFX), 04
	call Get1bpp

	ld de, HpExpBarParts1GFX
	ld hl, vChars2 tile $73
	lb bc, BANK(HpExpBarParts1GFX), 06
	call Get1bpp

	ld de, ExpBarGFX
	ld hl, vChars2 tile $55
	lb bc, BANK(ExpBarGFX), 08
	jp Get2bpp

PrintEmptyString:
	ld hl, .EmptyString
	jp PrintText

.EmptyString:
	db "@"

SECTION "engine/dumps/bank0f.asm@PlayMoveAnimation", ROMX
PlayMoveAnimation:
	ld a, e
	ld [wFXAnimID], a
	ld a, d
	ld [wFXAnimID + 1], a

asm_3e419:
	call WaitBGMap

asm_3e41c:
	predef_jump PlayBattleAnim

sub_3e421:
	ld a, [wLinkMode]
	and a
	ret nz

asm_3e426:
	call sub_3e64b
	xor a
	ld [wCurPartyMon], a
	ld bc, wPartyMon1Species

asm_3e430:
	ld hl, $22
	add hl, bc
	ld a, [hli]
	or [hl]
	jp z, asm_3e613
	push bc
	ld hl, wBattleParticipantsNotFainted
	ld a, [wCurPartyMon]
	ld c, a

asm_3e441:
	ld b, 2
	ld d, 0
	predef SmallFarFlagAction
	ld a, c
	and a
	pop bc
	jp z, asm_3e613
	ld hl, $c
	add hl, bc
	ld d, h
	ld e, l
	ld hl, wEnemyMonBaseStats
	push bc
	ld c, 5

asm_3e45c:
	ld a, [hli]
	ld b, a
	ld a, [de]
	add b
	ld [de], a
	jr nc, asm_3e471
	dec de
	ld a, [de]
	inc a
	jr z, asm_3e46c
	ld [de], a
	inc de
	jr asm_3e471

asm_3e46c:
	ld a, $ff
	ld [de], a
	inc de
	ld [de], a

asm_3e471:
	dec c
	jr z, asm_3e478
	inc de
	inc de
	jr asm_3e45c

asm_3e478:
	xor a
	ldh [hMultiplicand], a
	ldh [hMultiplicand + 1], a
	ld a, [wcdff]
	ldh [hMultiplicand + 2], a
	ld a, [wEnemyMonLevel]
	ldh [hMultiplier], a
	call Multiply
	ld a, 7
	ldh [hDivisor], a
	ld b, 4
	call Divide
	pop bc
	ld hl, 6
	add hl, bc
	ld a, [wPlayerID]
	cp [hl]
	jr nz, asm_3e4a7
	inc hl
	ld a, [wPlayerID + 1]
	cp [hl]
	ld a, 0
	jr z, asm_3e4ac

asm_3e4a7:
	call sub_3e67e
	ld a, 1

asm_3e4ac:
	ld [wcd33], a
	ld a, [wBattleMode]
	dec a
	call nz, sub_3e67e
	ld hl, $a
	add hl, bc
	ld d, [hl]
	ldh a, [hQuotient + 3]
	ld [wcd32], a
	add d
	ld [hld], a
	ld d, [hl]
	ldh a, [hQuotient + 2]
	ld [wStringBuffer2], a
	adc d
	ld [hl], a
	jr nc, asm_3e4ce
	dec hl
	inc [hl]

asm_3e4ce:
	ld a, [wCurPartyMon]
	ld e, a
	ld d, 0
	ld hl, wPartySpecies
	add hl, de
	ld a, [hl]
	ld [wCurSpecies], a
	call GetBaseData
	push bc
	ld d, MAX_LEVEL
	callfar CalcExpAtLevel
	pop bc
	ld hl, $a
	add hl, bc
	push bc
	ldh a, [hMultiplicand]
	ld b, a
	ldh a, [hMultiplicand + 1]
	ld c, a
	ldh a, [hMultiplicand + 2]
	ld d, a
	ld a, [hld]
	sub d
	ld a, [hld]
	sbc c
	ld a, [hl]
	sbc b
	jr c, asm_3e507
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, d
	ld [hld], a

asm_3e507:
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	ld hl, BoostedExpPointsText
	call PrintText
	xor a
	ld [wMonType], a
	predef CopyMonToTempMon
	farcall CalcLevel
	pop bc
	ld hl, $1f
	add hl, bc
	ld a, [hl]
	cp d
	jp z, asm_3e613
	ld a, [wCurPartyLevel]
	push af
	ld a, d
	ld [wCurPartyLevel], a
	ld [hl], a
	ld hl, 0
	add hl, bc
	ld a, [hl]
	ld [wCurSpecies], a
	ld [wNumSetBits], a
	call GetBaseData
	ld hl, $25
	add hl, bc
	ld a, [hld]
	ld e, a
	ld d, [hl]
	push de
	ld hl, $24
	add hl, bc
	ld d, h
	ld e, l
	ld hl, $a
	add hl, bc
	push bc
	ld b, 1
	predef CalcMonStats
	pop bc
	pop de
	ld hl, $25
	add hl, bc
	ld a, [hld]
	sub e
	ld e, a
	ld a, [hl]
	sbc d
	ld d, a
	dec hl
	ld a, [hl]
	add e
	ld [hld], a
	ld a, [hl]
	adc d
	ld [hl], a
	ld a, [wCurBattleMon]
	ld d, a
	ld a, [wCurPartyMon]
	cp d
	jr nz, asm_3e5d3
	ld de, wBattleMonHP
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld de, wBattleMonMaxHP
	push bc
	ld bc, $c
	call CopyBytes
	pop bc
	ld hl, $1f
	add hl, bc
	ld a, [hl]
	ld [wBattleMonLevel], a
	ld a, [wPlayerSubStatus5]
	bit 3, a
	jr nz, asm_3e5ae
	ld hl, $26
	add hl, bc
	ld de, wPlayerStats
	ld bc, $a
	call CopyBytes

asm_3e5ae:
	xor a
	ld [wApplyStatLevelMultipliersToEnemy], a
	call ApplyStatLevelMultiplierOnAllStats
; these three calls should be regular calls
	callfar ApplyStatusEffectOnPlayerStats
	callfar BadgeStatBoosts
	callfar UpdatePlayerHUD
	call PrintEmptyString
	call BackUpTilesToBuffer

asm_3e5d3:
	ld hl, GrewToLevelText
	call PrintText
	xor a
	ld [wMonType], a
	predef CopyMonToTempMon
	ld d, 1
	callfar PrintTempMonStats
	call TextboxWaitPressAorB_BlinkCursor
	call ReloadTilesFromBuffer
	xor a
	ld [wMonType], a
	ld a, [wCurSpecies]
	ld [wNumSetBits], a
	predef LearnLevelMoves
	ld hl, wEvolvableFlags
	ld a, [wCurPartyMon]
	ld c, a
	ld b, 1
	predef SmallFarFlagAction
	pop af
	ld [wCurPartyLevel], a

asm_3e613:
	ld a, [wPartyCount]
	ld b, a
	ld a, [wCurPartyMon]
	inc a
	cp b
	jr z, asm_3e62f
	ld [wCurPartyMon], a
	ld bc, $30
	ld hl, wPartyMon1Species
	call AddNTimes
	ld b, h
	ld c, l
	jp asm_3e430

asm_3e62f:
	ld hl, wBattleParticipantsNotFainted
	xor a
	ld [hl], a
	ld a, [wCurBattleMon]
	ld c, a
	ld b, 1
	push bc
	predef SmallFarFlagAction
	ld hl, wBattleParticipantsIncludingFainted
	xor a
	ld [hl], a
	pop bc
	predef_jump SmallFarFlagAction

sub_3e64b:
	ld a, [wBattleParticipantsNotFainted]
	ld b, a
	xor a
	ld c, 8
	ld d, 0

asm_3e654:
	xor a
	srl b
	adc d
	ld d, a
	dec c
	jr nz, asm_3e654
	cp 2
	ret c
	ld [wNumSetBits], a
	ld hl, wEnemyMonBaseStats
	ld c, 7

asm_3e667:
	xor a
	ldh [hDividend], a
	ld a, [hl]
	ldh [hDividend + 1], a
	ld a, [wNumSetBits]
	ldh [hDivisor], a
	ld b, 2
	call Divide
	ldh a, [hQuotient + 3]
	ld [hli], a
	dec c
	jr nz, asm_3e667
	ret

sub_3e67e:
	push bc
	ldh a, [hQuotient + 2]
	ld b, a
	ldh a, [hQuotient + 3]
	ld c, a
	srl b
	rr c
	add c
	ldh [hQuotient + 3], a
	ldh a, [hQuotient + 2]
	adc b
	ldh [hQuotient + 2], a
	pop bc
	ret

BoostedExpPointsText:
	text_from_ram wStringBuffer1
	text "は@"
	start_asm
	ld a, [wHPBarMaxHP]
	ld hl, .BoostedExpPoints1Text
	and a
	ret nz
	ld hl, .BoostedExpPoints3Text
	ld a, [wcd33]
	and a
	ret z
	ld hl, .BoostedExpPoints2Text
	ret

.BoostedExpPoints1Text:
	text "　がくしゅうそうちで@"
	start_asm
	ld hl, .BoostedExpPoints3Text
	ret

.BoostedExpPoints2Text:
	text "　おおめに@"

.BoostedExpPoints3Text:
	text "<LINE>@"
	deciram wStringBuffer2, 2, 4
	text "　けいけんちを　もらった！<PROMPT>"

GrewToLevelText:
	text_from_ram wStringBuffer1
	text "は<LINE>レべル@"
	deciram wCurPartyLevel, 1, 3
	text "　に　あがった！@"
	db "ジ@"

PrintSendOutMonMessage:
	ld a, [wLinkMode]
	and a
	jr z, .not_link
	ld hl, GoText
	ld a, [wBattleHasJustStarted]
	and a
	jr nz, .print_text

.not_link
	ld hl, wEnemyMonHP
	ld a, [hli]
	or [hl]
	ld hl, GoText
	jr z, .print_text
	xor a
	ldh [hMultiplicand], a
; enemy mon current HP * 25
	ld hl, wEnemyMonHP
	ld a, [hli]
	ld [wEnemyHPAtTimeOfPlayerSwitch], a
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ld [wEnemyHPAtTimeOfPlayerSwitch + 1], a
	ldh [hMultiplicand + 2], a
	ld a, 25
	ldh [hPrintNumDivisor], a
	call Multiply
	ld hl, wEnemyMonMaxHP
	ld a, [hli]
	ld b, [hl]
	srl a
	rr b
	srl a
	rr b
	ld a, b
; enemy mon max HP divided by 4
	ld b, 4
	ldh [hDivisor], a
	call Divide

; (enemy's current HP * 25) / (enemy's max HP / 4)
; approximates current % of max HP
	ldh a, [hQuotient + 3]
; >= 70%
	ld hl, GoText
	cp 70
	jr nc, .print_text
; 40% <= HP <= 69%
	ld hl, DoItText
	cp 40
	jr nc, .print_text
; 10% <= HP <= 39%
	ld hl, GetmText
	cp 10
	jr nc, .print_text
; < 10%
	ld hl, EnemysWeakText
.print_text
	jp PrintText

GoText:
	text "ゆけっ！　@"
	start_asm
	jr PrintPlayerMon1Text

DoItText:
	text "いってこい！　@"
	start_asm
	jr PrintPlayerMon1Text

GetmText:
	text "がんばれ！　@"
	start_asm
	jr PrintPlayerMon1Text

EnemysWeakText:
	text "あいてが　よわっている！"
	line "チャンスだ！　@"
	start_asm

PrintPlayerMon1Text:
	ld hl, .Text
	ret
.Text:
	text_from_ram wBattleMonNickname
	text "！<DONE>"

RetreatMon:
	ld hl, PlayerMon2Text
	jp PrintText

PlayerMon2Text:
	text_from_ram wBattleMonNickname
	text "　@"
	start_asm
	push de
	push bc
	ld hl, wEnemyMonHP + 1
	ld de, wEnemyHPAtTimeOfPlayerSwitch + 1
	ld b, [hl]
	dec hl
	ld a, [de]
	sub b
	ldh [hMultiplicand + 2], a
	dec de
	ld b, [hl]
	ld a, [de]
	sbc b
	ldh [hMultiplicand + 1], a
	ld a, 25
	ldh [hMultiplier], a
	call Multiply
	ld hl, wEnemyMonMaxHP
	ld a, [hli]
	ld b, [hl]
	srl a
	rr b
	srl a
	rr b
	ld a, b
	ld b, 4
	ldh [hDivisor], a
	call Divide
	pop bc
	pop de
	ldh a, [hQuotient + 3]
; HP stays the same
	ld hl, EnoughText
	and a
	ret z
; HP went down 1% - 29%
	ld hl, ComeBackText
	cp 30
	ret c
; HP went down 30% - 69%
	ld hl, OKExclamationText
	cp 70
	ret c
; HP went down 70% or more
	ld hl, GoodText
	ret

EnoughText:
	text "もういい！@"
	start_asm
	jr PrintComeBackText

OKExclamationText:
	text "いいぞ！@"
	start_asm
	jr PrintComeBackText

GoodText:
	text "よくやった！@"
	start_asm
	jr PrintComeBackText

PrintComeBackText:
	ld hl, ComeBackText
	ret

ComeBackText:
	text ""
	line "もどれ！"
	done

sub_3e81b:
	ld hl, wcace
	ld a, [hl]
	and a
	jr z, asm_3e828
	dec [hl]
	ld hl, Data3e84b
	jr asm_3e843

asm_3e828:
	dec hl
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ld hl, Data3e861
	jr nz, asm_3e843
	push hl
	ld a, [wEnemyMonSpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld a, [wMonHCatchRate]
	ld [wEnemyMonCatchRate], a
	pop hl

asm_3e843:
	push hl
	call ReloadTilesFromBuffer
	pop hl
	jp PrintText

Data3e84b:
	text "やせいの@"
	text_from_ram wEnemyMonNickname
	text "は"
	line "エサを　たべてる！"
	prompt

Data3e861:
	text "やせいの@"
	text_from_ram wEnemyMonNickname
	text "は"
	line "おこってる！"
	prompt

; Calculate the percent exp between this level and the next
; Level in b, then place the exp bar. Split in the final game.
CalcAndPlaceExpBar:
	push hl
	push de
	ld d, b
	push de
	callfar CalcExpAtLevel
	pop de
; exp at current level gets pushed to the stack
	ld hl, hMultiplicand
	ld a, [hli]
	push af
	ld a, [hli]
	push af
	ld a, [hl]
	push af
; next level
	inc d
	callfar CalcExpAtLevel
; back up the next level exp, and subtract the two levels
	ld hl, hMultiplicand + 2
	ld a, [hl]
	ldh [hMathBuffer + 2], a
	pop bc
	sub b
	ld [hld], a
	ld a, [hl]
	ldh [hMathBuffer + 1], a
	pop bc
	sbc b
	ld [hld], a
	ld a, [hl]
	ldh [hMathBuffer], a
	pop bc
	sbc b
	ld [hl], a
	pop de

	ld hl, hMultiplicand + 1
	ld a, [hli]
	push af
	ld a, [hl]
	push af
; get the amount of exp remaining to the next level
	ld a, [de]
	dec de
	ld c, a
	ldh a, [hMathBuffer + 2]
	sub c
	ld [hld], a
	ld a, [de]
	dec de
	ld b, a
	ldh a, [hMathBuffer + 1]
	sbc b
	ld [hld], a
	ld a, [de]
	ld c, a
	ldh a, [hMathBuffer]
	sbc c
	ld [hld], a
	xor a
	ld [hl], a
	ld a, 64
	ldh [hMultiplier], a
	call Multiply
	pop af
	ld c, a
	pop af
	ld b, a
.loop
	ld a, b
	and a
	jr z, .done
	srl b
	rr c
	ld hl, hProduct
	srl [hl]
	inc hl
	rr [hl]
	inc hl
	rr [hl]
	inc hl
	rr [hl]
	jr .loop
.done
	ld a, c
	ldh [hDivisor], a
	ld b, 4
	call Divide
	pop hl
	ld bc, 7
	add hl, bc
	ldh a, [hQuotient + 3]
	ld b, a
	ld a, $40
	sub b
	ld b, a

; Separated into PlaceExpBar in the final game
	ld c, 8
.loop2
	ld a, b
	sub 8
	jr c, .next
	ld b, a
	ld a, $6a ; full bar
	ld [hld], a
	dec c
	jr z, .finish
	jr .loop2

.next
	add 8
	jr z, .loop3
	add $54 ; tile to the left of small exp bar tile
	jr .skip

.loop3
	ld a, $62 ; empty bar

.skip
	ld [hld], a
	ld a, $62 ; empty bar
	dec c
	jr nz, .loop3
.finish
	ret

GetBattleMonBackpic:
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	ld hl, BattleAnimCmd_RaiseSub
	jr nz, GetBattleMonBackpic_DoAnim

DropPlayerSub:
	ld a, [wPlayerMinimized]
	and a
	ld hl, BattleAnimCmd_MinimizeOpp
	jr nz, GetBattleMonBackpic_DoAnim
	ld a, [wCurPartySpecies]
	push af
	ld a, [wBattleMonSpecies]
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	call GetBaseData
	ld hl, wMonHBackSprite - wMonHeader
	call UncompressMonSprite
	ld hl, vBackPic
	predef GetMonBackpic
	pop af
	ld [wCurPartySpecies], a
	ret

GetBattleMonBackpic_DoAnim:
	ldh a, [hBattleTurn]
	push af
	xor a
	ldh [hBattleTurn], a
	ld a, BANK(BattleAnimCmd_RaiseSub)
	call FarCall_hl
	pop af
	ldh [hBattleTurn], a
	ret

GetEnemyMonFrontpic:
	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	ld hl, BattleAnimCmd_RaiseSub
	jr nz, GetEnemyMonFrontpic_DoAnim

DropEnemySub:
	ld a, [wEnemyMinimized]
	and a
	ld hl, BattleAnimCmd_MinimizeOpp
	jr nz, GetEnemyMonFrontpic_DoAnim
	ld a, [wCurPartySpecies]
	push af
	ld a, [wEnemyMonSpecies]
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	call GetBaseData
	ld hl, wEnemyMonDVs
	predef GetUnownLetter
	ld de, vFrontPic
	call LoadMonFrontSprite
	pop af
	ld [wCurPartySpecies], a
	ret

GetEnemyMonFrontpic_DoAnim:
	ldh a, [hBattleTurn]
	push af
	ld a, 1
	ldh [hBattleTurn], a
	ld a, BANK(BattleAnimCmd_RaiseSub)
	call FarCall_hl
	pop af
	ldh [hBattleTurn], a
	ret

_LoadWildMons:
	xor a
	ld hl, wWildMons
	ld bc, GRASS_WILDDATA_LENGTH
	call ByteFill
	ld a, [wMapGroup]
	ld d, a
	ld a, [wMapId]
	ld e, a
	ld bc, GRASS_WILDDATA_LENGTH
	ld hl, GrassWildMons
.find
	ld a, [hl]
	cp -1
	ret z
	cp d
	jr nz, .got_map_group
	inc hl
	ld a, [hl]
	dec hl
	cp e
	jr z, .got_map
.got_map_group
	add hl, bc
	jr .find
.got_map
	inc hl
	inc hl
	ld de, wWildMons
	ld bc, GRASS_WILDDATA_LENGTH - 2
	jp CopyBytes

; Load nest landmarks into wTilemap[0,0]
FindNest:
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	call ByteFill
	ld hl, GrassWildMons
	decoord 0, 0

.FindGrass:
	ld a, [hl]
	cp -1
	jr z, .done

	push hl
	ld b, a
	inc hl
	ld c, [hl]
	call .SearchMapForMon
	jr nc, .next_grass

	push de
	call GetWorldMapLocation
	call .AppendNest
	pop de
	jr c, .next_grass
	ld [de], a
	inc de

.next_grass
	pop hl
	ld bc, GRASS_WILDDATA_LENGTH
	add hl, bc
	jr .FindGrass

.done:
	ret

.SearchMapForMon:
rept 5
	inc hl
endr
	ld a, NUM_GRASSMON * 3

.ScanMapLoop:
	push af
	ld a, [wNamedObjectIndexBuffer]
	cp [hl]
	jr z, .found
	inc hl
	inc hl
	pop af
	dec a
	jr nz, .ScanMapLoop
	and a
	ret

.found
	pop af
	scf
	ret

.AppendNest:
	ld c, a
	ld hl, wTileMap
	ld de, SCREEN_WIDTH * SCREEN_HEIGHT
.AppendNestLoop:
	ld a, [hli]
	cp c
	jr z, .found_nest

	dec de
	ld a, e
	or d
	jr nz, .AppendNestLoop

	ld a, c
	and a
	ret

.found_nest
	scf
	ret

SECTION "engine/dumps/bank0f.asm@Function3ee3e", ROMX
Function3ee3e:
	ld a, [wRepelEffect]
	and a
	jr z, asm_3ee4b
	dec a
	jp z, asm_3eeba
	ld [wRepelEffect], a

asm_3ee4b:
	call sub_3eec8
	jr nc, asm_3eebd
	call sub_3ef0e
	ld c, a
	ld b, 0
	ld hl, wWildMons
	add hl, bc
	ld a, [hl]
	ld b, a
	call Random
	ldh a, [hRandomAdd]
	cp b
	jr nc, asm_3eebd
	call Random
	ld b, a
	ld hl, Data3eedf
	call sub_3ef0e
	cp 1
	ld bc, 0
	jr c, asm_3ee7d
	ld bc, 6
	jr z, asm_3ee7d
	ld bc, $e

asm_3ee7d:
	add hl, bc

asm_3ee7e:
	call Random
	cp $64
	jr nc, asm_3ee7e
	ld b, a
	ld c, 0

asm_3ee88:
	ld a, [hli]
	add c
	ld c, a
	cp b
	jr nc, asm_3ee91
	inc hl
	jr asm_3ee88

asm_3ee91:
	ld c, [hl]
	ld b, 0
	ld hl, wOTPartyMon1Moves + 1
	add hl, bc
	ld a, [hli]
	ld [wCurPartyLevel], a
	ld a, [hl]
	call sub_3ef03
	jr c, asm_3eebd
	ld [wCurPartySpecies], a
	ld [wTempEnemyMonSpecies], a
	ld a, [wRepelEffect]
	and a
	jr z, asm_3eec1
	ld a, [wPartyMon1Level]
	ld b, a
	ld a, [wCurPartyLevel]
	cp b
	jr c, asm_3eebd
	jr asm_3eec1

asm_3eeba:
	ld [wRepelEffect], a

asm_3eebd:
	ld a, 1
	and a
	ret

asm_3eec1:
	ld a, 1
	ld [wBattleMode], a
	xor a
	ret

sub_3eec8:
	ld a, [wPlayerTile]
	ld hl, Data3eed5
	ld de, 1
	call FindItemInTable
	ret

Data3eed5:
	db $8
	db $18
	db $28
	db $29
	db $48
	db $49
	db $4a
	db $4b
	db $4c
	db -1

Data3eedf:
	db $1
	db $0
	db $4
	db $2
	db $5
	db $4
	db $1
	db $6
	db $4
	db $8
	db $f
	db $a
	db $14
	db $c
	db $5
	db $e
	db $a
	db $10
	db $14
	db $12
	db $f
	db $14
	db $5
	db $16
	db $5
	db $18
	db $14
	db $1a
	db $a
	db $1c
	db $5
	db $1e
	db $4
	db $20
	db $1
	db $22

sub_3ef03:
	and a
	jr z, .return
	cp $fc
	jr nc, .return
	and a
	ret

.return
	scf
	ret

sub_3ef0e:
	ld a, [wTimeOfDay]
	inc a
	and 3
	cp 3
	ret nz
	dec a
	ret

Function3ef19:
	ld a, [wOtherTrainerClass]
	and a
	jr nz, InitBattleCommon
	ld a, [wTempWildMonSpecies]
	and a
	jr z, InitBattleCommon
	ld [wCurPartySpecies], a
	ld [wTempEnemyMonSpecies], a

InitBattleCommon:
	ld a, [wTimeOfDayPal]
	push af
	ld hl, wTextboxFlags
	ld a, [hl]
	push af
	res TEXT_DELAY_F, [hl]
	ldh a, [hMapAnims]
	ld [wce26], a
	call PlayBattleMusic
	call ShowLinkBattleParticipants
	call InitBattleVariables
	ld a, [wOtherTrainerClass]
	and a
	jr nz, .asm_3ef4f
	call sub_3efdb
	jr _InitBattleCommon
.asm_3ef4f
	call sub_3ef9a

_InitBattleCommon:
	ld b, 0
	call GetSGBLayout
	ld hl, wStateFlags
	res SPRITE_UPDATES_DISABLED_F, [hl]
	call InitBattleDisplay
	call BattleStartMessage
	xor a
	ldh [hBGMapMode], a
	call PrintEmptyString
	ld hl, $c335
	ld bc, $050a
	call ClearBox
	ld hl, $c2a1
	ld bc, $040a
	call ClearBox
	call ClearSprites
	ld a, [wBattleMode]
	cp 1
	call z, UpdateEnemyHUD
	call StartBattle
	call sub_3f13e
	pop af
	ld [wTextboxFlags], a
	pop af
	ld [wTimeOfDayPal], a
	ld a, [wce26]
	ldh [hMapAnims], a
	scf
	ret

sub_3ef9a:
	ld [wca22], a
	callfar LoadTrainerClass
	callfar Function38f45
	ld a, [wca22]
	cp 9
	jr nz, asm_3efb8
	xor a
	ld [wOTPartyMon1Item], a

asm_3efb8:
	call sub_3f003
	xor a
	ld [wTempEnemyMonSpecies], a
	ldh [hGraphicStartTile], a
	dec a
	ld [wEnemyItemState], a
	ld hl, $c2ac
	ld bc, $0707
	predef PlaceGraphic
	ld a, $ff
	ld [wCurOTMon], a
	ld a, 2
	ld [wBattleMode], a
	ret

sub_3efdb:
	ld a, 1
	ld [wBattleMode], a
	call LoadEnemyMon
	ld hl, wEnemyMonDVs
	predef GetUnownLetter
	ld de, vFrontPic
	call LoadMonFrontSprite
	xor a
	ld [wca22], a
	ldh [hGraphicStartTile], a
	ld hl, $c2ac
	ld bc, $0707
	predef PlaceGraphic
	ret

sub_3f003:
	ld a, [wca23]
	ld e, a
	ld a, [wca24]
	ld d, a
	ld a, $12
	call UncompressSpriteFromDE
	ld de, vFrontPic
	ld a, $77
	ld c, a
	jp LoadUncompressedSpriteData

PlaceGraphic:
	ld de, $14
	ld a, [wSpriteFlipped]
	and a
	jr nz, asm_3f033
	ldh a, [hGraphicStartTile]

asm_3f024:
	push bc
	push hl

asm_3f026:
	ld [hl], a
	add hl, de
	inc a
	dec c
	jr nz, asm_3f026
	pop hl
	inc hl
	pop bc
	dec b
	jr nz, asm_3f024
	ret

asm_3f033:
	push bc
	ld b, 0
	dec c
	add hl, bc
	pop bc
	ldh a, [hGraphicStartTile]

asm_3f03b:
	push bc
	push hl

asm_3f03d:
	ld [hl], a
	add hl, de
	inc a
	dec c
	jr nz, asm_3f03d
	pop hl
	dec hl
	pop bc
	dec b
	jr nz, asm_3f03b
	ret

LoadMonBackPic:
	ld a, [wTempBattleMonSpecies]
	ld [wCurPartySpecies], a
	hlcoord 1, 5
	ld b, 7
	ld c, 8
	call ClearBox
	ld hl, wMonHBackSprite - wMonHeader
	call UncompressMonSprite
	ld hl, vBackPic
	predef_jump GetMonBackpic

Function3f068:
	ld de, $a203
	ld hl, $a187
	call sub_3f0a5
	call sub_3f07d
	ld de, $a38b
	ld hl, $a30f
	call sub_3f0a5

sub_3f07d:
	ld b, 3
asm_3f07f:
	ld c, $1c
asm_3f081:
	push bc
	ld a, [de]
	ld bc, $ffc9
	call sub_3f0bf
	ld a, [de]
	dec de
	swap a
	ld bc, $37
	call sub_3f0bf
	pop bc
	dec c
	jr nz, asm_3f081
	dec de
	dec de
	dec de
	dec de
	ld a, b
	ld bc, $ffc8
	add hl, bc
	ld b, a
	dec b
	jr nz, asm_3f07f
	ret

sub_3f0a5:
	ld a, $1c
	ldh [hTextBoxCursorBlinkInterval], a
	ld bc, $ffff

asm_3f0ac:
	ld a, [de]
	dec de
	swap a
	call sub_3f0bf
	ldh a, [hTextBoxCursorBlinkInterval]
	dec a
	ldh [hTextBoxCursorBlinkInterval], a
	jr nz, asm_3f0ac
	dec de
	dec de
	dec de
	dec de
	ret

sub_3f0bf:
	push hl
	and $f
	ld hl, Data3f0d0
	add l
	ld l, a
	jr nc, asm_3f0ca
	inc h

asm_3f0ca:
	ld a, [hl]
	pop hl
	ld [hld], a
	ld [hl], a
	add hl, bc
	ret

Data3f0d0:
	db $0
	db $3
	db $c
	db $f
	db $30
	db $33
	db $3c
	db $3f
	db $c0
	db $c3
	db $cc
	db $cf
	db $f0
	db $f3
	db $fc
	db $ff

InitBattleVariables:
	xor a
	ld [wFieldMoveSucceeded], a
	ld [wcd5d], a
	ld hl, wcd3c
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wMenuScrollPosition], a
	ld [wCriticalHit], a
	ld [wBattleMonSpecies], a
	ld [wBattleParticipantsNotFainted], a
	ld [wCurBattleMon], a
	ld [wBattleResult], a
	ld [wTimeOfDayPal], a
	ld [wcaba], a
	ld hl, wPlayerHPPal
	ld [hli], a
	ld [hl], a
	ld hl, wBattleMonDVs
	ld [hli], a
	ld [hl], a
	ld hl, wEnemyMonDVs
	ld [hli], a
	ld [hl], a
	ld hl, wEnemyMoveStruct
	ld bc, $012c
	xor a
	call ByteFill
	call ClearWindowData
	ld hl, hBGMapAddress
	xor a
	ld [hli], a
	ld [hl], HIGH(vBGMap0)
	ld a, $a3
	ldh [rLCDC], a
	ld a, [wMapId]
	cp $d9 ; SAFARI_ZONE_EAST
	jr c, .return
	cp $dd ; SAFARI_ZONE_CENTER_REST_HOUSE
	jr nc, .return
	ld a, 2
	ld [wBattleType], a
.return
	ret

sub_3f13e:
	call IsLinkBattle
	jr nz, asm_3f148
	call sub_3f1f3
	jr asm_3f151

asm_3f148:
	ld a, [wcd5d]
	and a
	jr nz, asm_3f15a
	call sub_3f19e

asm_3f151:
	xor a
	ld [wForceEvolution], a
	predef EvolveAfterBattle

asm_3f15a:
	xor a
	ld [wLowHealthAlarmBuffer], a
	ld [wBattleMode], a
	ld [wBattleType], a
	ld [wAttackMissed], a
	ld [wTempWildMonSpecies], a
	ld [wOtherTrainerClass], a
	ld [wce38], a
	ld [wce39], a
	ld [wBattleResult], a
	ld hl, wcd3c
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wMenuScrollPosition], a
	ld hl, wPlayerSubStatus1
	ld b, $18
.clear
	ld [hli], a
	dec b
	jr nz, .clear
	ld hl, wd4a7
	set 0, [hl]
	call WaitSFX
	ld a, $e3
	ldh [rLCDC], a
	ld hl, wd14f
	res 7, [hl]
	call ClearPalettes
	ret

sub_3f19e:
	ld hl, wPayDayMoney
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	ret z
	ld a, [wBattleMonItem]
	ld b, a
	callfar GetItemHeldEffect
	ld a, b
	cp $4c
	jr nz, AddBattleMoneyToAccount
	ld hl, wPayDayMoney + 2
	sla [hl]
	dec hl
	rl [hl]
	dec hl
	rl [hl]
	jr nc, AddBattleMoneyToAccount
	ld a, $ff
	ld [hli], a
	ld [hli], a
	ld [hl], a

AddBattleMoneyToAccount:
	ld hl, wPayDayMoney + 2
	ld de, wMoney + 2
	ld c, 3
	and a
.loop
	ld a, [de]
	adc [hl]
	ld [de], a
	dec de
	dec hl
	dec c
	jr nz, .loop
	ld hl, BattleText_PlayerPickedUpPayDayMoney
	call PrintText
	ret

BattleText_PlayerPickedUpPayDayMoney:
	text "<PLAYER>は　@"
	deciram wPayDayMoney, 3, 6
	text "円"
	line "ひろった！"
	prompt

sub_3f1f3:
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Status
	ld bc, $30
	call AddNTimes
	ld a, [wEnemyMonStatus]
	ld [hl], a
	call ClearTileMap
	call sub_3f60c
	ld a, [wcd5d]
	cp 1
	ld de, WonAgainstText
	jr c, .print_text
	ld de, LostAgainstText
	jr z, .print_text
	ld de, TiedAgainstText

.print_text
	ld hl, $c346
	call PlaceString
	ld c, $c8
	call DelayFrames
	ret

WonAgainstText:
	db "あなたの　かち@"

LostAgainstText:
	db "あなたの　まけ@"

TiedAgainstText:
	db "　　ひきわけ@"

PlayBattleMusic:
	push hl
	push de
	push bc
	xor a
	ld [wMusicFade], a
	ld de, 0
	call PlayMusic
	call DelayFrame
	call MaxVolume
; plays vs. gym leader music regardless of the battle type
	ld de, MUSIC_LEADER_BATTLE
	call PlayMusic
	pop bc
	pop de
	pop hl
	ret

InitBattleDisplay:
	call InitBackPic
	ld hl, $c390
	ld b, 4
	ld c, $12
	call DrawTextBox
	ld hl, $c305
	ld bc, $0307
	call ClearBox
	call DisableLCD
	call LoadFont
	call Call_LoadBattleFontsHPBar
	ld hl, vBGMap0
	ld bc, $0400
	ld a, $7f
	call ByteFill
	call LoadMapTimeOfDay.PushAttrMap
	call EnableLCD
	xor a
	ldh [hMapAnims], a
	ldh [hSCY], a
	ld a, $90
	ldh [hWY], a
	ldh [rWY], a
	call WaitBGMap
	xor a
	ldh [hBGMapMode], a
	call BattleIntroSlidingPics
	ld a, 1
	ldh [hBGMapMode], a
	ld a, $31
	ldh [hGraphicStartTile], a
	ld hl, $c31a
	ld bc, $0606
	predef PlaceGraphic
	xor a
	ldh [hWY], a
	ldh [rWY], a
	call WaitBGMap
	ld b, 1
	call GetSGBLayout
	call HideSprites
	ld a, $90
	ldh [hWY], a
	xor a
	ldh [hSCX], a
	ret


BattleIntroSlidingPics:
	ld b, $70
	ld c, $90
	ld a, c
	ldh [hSCX], a
	call DelayFrame
	ld a, $e4
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a
.loop1
	push bc
	ld h, b
	ld l, $40
	call .Subfunction2
	ld h, 0
	ld l, $60
	call .Subfunction2
	call .Subfunction1
	pop bc
	ld a, c
	ldh [hSCX], a
	inc b
	inc b
	dec c
	dec c
	jr nz, .loop1
	ret

.Subfunction1:
	push bc
	ld hl, wShadowOAMSprite00XCoord
	ld c, $12
	ld de, 4
.loop2
	dec [hl]
	dec [hl]
	add hl, de
	dec c
	jr nz, .loop2
	pop bc
	ret

.Subfunction2:
.loop3
	ldh a, [rLY]
	cp l
	jr nz, .loop3
	ld a, h
	ldh [rSCX], a
.loop4
	ldh a, [rLY]
	cp h
	jr z, .loop4
	ret

InitBackPic:
	ld de, PlayerBacksprite
	ld a, BANK(PlayerBacksprite)
	call UncompressSpriteFromDE
	ld hl, vTitleLogo2
	predef GetMonBackpic
	ld a, 0
	call OpenSRAM
	ld hl, vSprites
	ld de, sSpriteBuffer1
	ldh a, [hROMBank]
	ld b, a
	ld c, 7 * 7
	call Request2bpp
	call CloseSRAM
	call LoadTrainerBackpicAsOAM
	ld a, $31
	ldh [hGraphicStartTile], a
	ld hl, $c31a
	ld bc, $0606
	predef PlaceGraphic
	ret

LoadTrainerBackpicAsOAM:
	ld hl, wShadowOAMSprite00
	xor a
	ldh [hTextBoxCursorBlinkInterval], a
	ld b, 6
	ld e, $a8

.outer_loop
	ld c, 3
	ld d, $40

.inner_loop
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ldh a, [hTextBoxCursorBlinkInterval]
	ld [hli], a
	inc a
	ldh [hTextBoxCursorBlinkInterval], a
	inc hl
	ld a, d
	add 8
	ld d, a
	dec c
	jr nz, .inner_loop
	ldh a, [hTextBoxCursorBlinkInterval]
	add 3
	ldh [hTextBoxCursorBlinkInterval], a
	ld a, e
	add 8
	ld e, a
	dec b
	jr nz, .outer_loop
	ret

PlayerBacksprite:
INCBIN "gfx/trainer/protagonist_back.pic"

Unused_OldManBacksprite:
INCBIN "gfx/trainer/oldman_back.pic"

BattleStartMessage:
	ld a, [wBattleMode]
	dec a
	jr z, .wild
	ld de, SFX_SHINE
	call PlaySFX
	call WaitSFX
	ld c, 20
	call DelayFrames
	callfar Battle_GetTrainerName
	ld hl, WantsToBattleText
	jr .PlaceBattleStartText

.wild
	ld a, $f
	ld [wCryTracks], a
	ld a, [wTempEnemyMonSpecies]
	call PlayStereoCry
	ld hl, WildPokemonAppearedText
	ld a, [wAttackMissed]
	and a
	jr z, .PlaceBattleStartText
	ld hl, HookedPokemonAttackedText

.PlaceBattleStartText:
	push hl
	callfar Function38340
	pop hl
	call PrintText
	ret

WildPokemonAppearedText:
	text "あ！　やせいの"
	line "@"
	text_from_ram wEnemyMonNickname
	text "が　とびだしてきた！"
	prompt

HookedPokemonAttackedText:
	text "つりあげた　@"
	text_from_ram wEnemyMonNickname
	text "が"
	line "とびかかってきた！"
	prompt

WantsToBattleText:
	text_from_ram wca2b
	text "の　@"
	text_from_ram wStringBuffer1
	text "が"
	line "しょうぶを　しかけてきた！"
	prompt

ShowLinkBattleParticipants:
	call IsLinkBattle
	jr nz, .ok
	call sub_3f60c
	call ClearTileMap
.ok
	call DelayFrame
	predef DoBattleTransition
	call Call_LoadBattleFontsHPBar
	ld a, 1
	ldh [hBGMapMode], a
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ldh [hWY], a
	ldh [rWY], a
	ldh [hMapAnims], a
	ret

sub_3f60c:
	call LoadFontExtra
	ld hl, $c2f3
	ld b, 7
	ld c, $c
	call DrawTextBox
	ld hl, $c31c
	ld de, wPlayerName
	call PlaceString
	ld hl, $c36c
	ld de, wd8fe
	call PlaceString
	ld hl, $c349
	ld a, $69
	ld [hli], a
	ld [hl], $6a
	callfar LinkBattle_TrainerHuds
	ld c, 150
	jp DelayFrames

IsLinkBattle:
	push bc
	push af
	ld a, [wLinkMode]
	cp 3
	pop bc
	ld a, b
	pop bc
	ret

