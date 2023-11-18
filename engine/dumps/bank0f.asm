INCLUDE "constants.asm"

SECTION "engine/dumps/bank0f.asm@StartBattle", ROMX
StartBattle:
	xor a
	ld [wca37], a
	ld [wcada], a
	ld [wFieldMoveSucceeded], a
	inc a
	ld [wce36], a
	ld hl, wd93d
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
	call sub_3cd6e
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
	ld [wWhichPokemon], a
.find_first_alive_loop
	call HasMonFainted
	jr nz, .found_first_alive
	ld hl, wWhichPokemon
	inc [hl]
	jr .find_first_alive_loop
.found_first_alive
	ld a, [wWhichPokemon]
	ld [wcd41], a
	inc a
	ld hl, wPartyCount
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wMonDexIndex], a
	ld [wcdd8], a
	ld hl, $c305
	ld a, 9
	call sub_3cd3b
	call BackUpTilesToBuffer
	ld a, [wWhichPokemon]
	ld c, a
	ld b, 1
	push bc
	ld hl, wca37
	predef SmallFarFlagAction
	ld hl, wcada
	pop bc
	predef SmallFarFlagAction
	call LoadBattleMonFromParty
	call ApplyStatMods
	call PrintSendOutMonMessage
	call sub_3d387
	call Function3d32e
	call PrintEmptyString
	call BackUpTilesToBuffer
	xor a
	ldh [hBattleTurn], a
	call Function3d3a2
	ld a, [wLinkMode]
	and a
	jr z, .to_battle
	ldh a, [hLinkPlayerNumber]
	cp 2
	jr nz, .to_battle
	call sub_3cd6e
	call sub_3d071
	ld a, 1
	ldh [hBattleTurn], a
	call Function3d3a2
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
	ld a, [wcdf2]
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
	ld de, $26
	call PlaySFX
	xor a
	ldh [hBattleTurn], a
	jpab Functioncc000

WildPokemonFledText:
	text "やせいの@"
	text_from_ram wBattleMonNickname
	text "は　にげだした！"
	prompt

EnemyPokemonFledText:
	text "てきの@"
	text_from_ram wBattleMonNickname
	text "は　にげだした！"
	prompt

asm_3c183:
	call sub_3d3f4
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
	call sub_3d3f4
	call BackUpTilesToBuffer
	call sub_3c399
	jp c, asm_3c132
	xor a
	ld [wce36], a
	ld a, [wca3e]
	and $60
	jp nz, asm_3c281
	ld hl, wEnemySubStatus3
	res 3, [hl]
	ld hl, wPlayerSubStatus3
	res 3, [hl]
	ld a, [hl]
	and $12
	jp nz, asm_3c281
	ld hl, wca3b
	bit 6, [hl]
	jp nz, asm_3c281

asm_3c200:
	call DisplayBattleMenu
	ret c
	ld a, [wce06]
	and a
	ret nz
	ld hl, wca3f
	bit 4, [hl]
	jr z, asm_3c246
	ld a, [wca49]
	dec a
	ld [wca49], a
	jr nz, asm_3c229

asm_3c219:
	ld hl, wca3f
	res 4, [hl]
	xor a
	ldh [hBattleTurn], a
	ld hl, Data3dfdd
	call PrintText
	jr asm_3c246

asm_3c229:
	ld a, [wcad6]
	and a
	jr z, asm_3c219
	ld a, [wcd40]
	ld c, a
	ld b, 0
	ld hl, wca0a
	add hl, bc
	ld a, [hl]
	and $3f
	jr z, asm_3c219
	ld a, [wcad6]
	ld [wcac1], a
	jr asm_3c269

asm_3c246:
	ld a, [wPlayerSubStatus3]
	and $21
	jr nz, asm_3c281
	ld a, [wFieldMoveSucceeded]
	and a
	jr nz, asm_3c281
	xor a
	ld [wcac0], a
	inc a
	ld [wccc0], a
	call Function3daa7
	push af
	call ReloadTilesFromBuffer
	call DrawHUDsAndHPBars
	pop af
	jp nz, asm_3c200

asm_3c269:
	xor a
	ldh [hBattleTurn], a
	callab Function360b1
	ld a, [wc9f0]
	cp $77
	jr z, asm_3c285
	xor a
	ld [wca4b], a
	jr asm_3c285

asm_3c281:
	xor a
	ld [wca4b], a

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
	ld a, [wcd40]
	ld hl, wca04
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	cp $76
	jr nz, asm_3c2bb
	ld [wcac1], a

asm_3c2bb:
	callab Function38220
	ld a, 1
	ldh [hBattleTurn], a
	call Function3d3a2
	jp asm_3c3c7

asm_3c2cd:
	ld a, [wcac1]
	call sub_3c3b8
	cp $67
	jr nz, asm_3c2e4
	ld a, [wcac2]
	call sub_3c3b8
	cp $67
	jr z, asm_3c311
	jp asm_3c41d

asm_3c2e4:
	ld a, [wcac2]
	call sub_3c3b8
	cp $67
	jp z, asm_3c3c7
	ld a, [wcac1]
	call sub_3c3b8
	cp $59
	jr nz, asm_3c306
	ld a, [wcac2]
	call sub_3c3b8
	cp $59
	jr z, asm_3c311
	jp asm_3c3c7

asm_3c306:
	ld a, [wcac2]
	call sub_3c3b8
	cp $59
	jp z, asm_3c41d

asm_3c311:
	xor a
	ldh [hBattleTurn], a
	callab Function37e1d
	push bc
	callab Function37e2d
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
	ld de, wca1a
	ld hl, wcdf1
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
	ld a, [wca44]
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
	callab Function38000
	jr c, asm_3c3eb
	callab Function3401c
	call sub_3c473
	ld a, [wce06]
	and a
	ret nz
	call sub_3c492
	jp z, asm_3caf3

asm_3c3eb:
	call sub_3c498
	jp z, asm_3c883
	call DrawHUDsAndHPBars
	callab Function34000
	call sub_3c473
	ld a, [wce06]
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
	callab Function34000
	call sub_3c473
	ld a, [wce06]
	and a
	ret nz
	call sub_3c48d
	jp z, asm_3c883
	call sub_3c498
	jp z, asm_3caf3
	call DrawHUDsAndHPBars
	ld a, 1
	ldh [hBattleTurn], a
	callab Function38000
	jr c, asm_3c460
	callab Function3401c
	call sub_3c473
	ld a, [wce06]
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
	ld hl, wca44
	ld de, wca40
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c484
	ld hl, wca3f
	ld de, wca3b

asm_3c484:
	res 6, [hl]
	ld a, [de]
	res 2, a
	res 5, a
	ld [de], a
	ret

sub_3c48d:
	ld hl, wcde9
	jr asm_3c495

sub_3c492:
	ld hl, wca12

asm_3c495:
	ld a, [hli]
	or [hl]
	ret

sub_3c498:
	ld hl, wca10
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c4a3
	ld hl, wcde7

asm_3c4a3:
	ld a, [hl]
	and $18
	jr z, asm_3c4eb
	ld hl, HurtByPoisonText
	ld de, $0106
	and $10
	jr z, asm_3c4b8
	ld hl, HurtByBurnText
	ld de, $0105

asm_3c4b8:
	push de
	call PrintText
	pop de
	xor a
	ld [wcccd], a
	call PlayMoveAnimation
	call sub_3c78b
	ld hl, wca3f
	ld de, wca47
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c4d8
	ld hl, wca44
	ld de, wca4f

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
	call sub_3c75e

asm_3c4eb:
	ld hl, wca3e
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c4f6
	ld hl, wca43

asm_3c4f6:
	bit 7, [hl]
	jr z, asm_3c51d
	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	xor a
	ld [wcccd], a
	ld de, $0107
	call PlayMoveAnimation
	pop af
	ldh [hBattleTurn], a
	call sub_3c78b
	call sub_3c75e
	call sub_3c808
	ld hl, LeechSeedSapsText
	call PrintText

asm_3c51d:
	ld hl, wca3b
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c528
	ld hl, wca40

asm_3c528:
	bit 0, [hl]
	jr z, asm_3c542
	xor a
	ld [wcccd], a
	ld de, $010c
	call PlayMoveAnimation
	call sub_3c7b0
	call sub_3c75e
	ld hl, HasANightmareText
	call PrintText

asm_3c542:
	ld hl, wca3b
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c54d
	ld hl, wca40

asm_3c54d:
	bit 1, [hl]
	jr z, asm_3c567
	xor a
	ld [wcccd], a
	ld de, $010c
	call PlayMoveAnimation
	call sub_3c7b0
	call sub_3c75e
	ld hl, HurtByCurseText
	call PrintText

asm_3c567:
	ld hl, wcadd
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c572
	ld hl, wcade

asm_3c572:
	bit 1, [hl]
	jr z, asm_3c596
	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	xor a
	ld [wcccd], a
	ld de, $010b
	call PlayMoveAnimation
	pop af
	ldh [hBattleTurn], a
	call sub_3c78b
	call sub_3c75e
	ld hl, SandstormHitsText
	call PrintText

asm_3c596:
	ld hl, wca12
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c5a1
	ld hl, wcde9

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
	ld hl, wca3b
	ld de, wca4a
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c651
	ld hl, wca40
	ld de, wca52

asm_3c651:
	bit 4, [hl]
	ret z
	ld a, [de]
	dec a
	ld [de], a
	ld [wCountSetBitsResult], a
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
	ld hl, wca12
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, wPartyMon1HP
	ld a, [wcd41]
	ld bc, $30
	call AddNTimes
	xor a
	ld [hli], a
	ld [hl], a
	ret

asm_3c682:
	ld hl, wcde9
	xor a
	ld [hli], a
	ld [hl], a
	ld a, [wBattleMode]
	dec a
	ret z
	ld hl, wd93d
	ld a, [wca36]
	ld bc, $30
	call AddNTimes
	xor a
	ld [hli], a
	ld [hl], a
	ret

PerishCountText:
	text "<USER>の　ほろびの"
	line "カウントが　@"
	deciram wCountSetBitsResult, 1, 1
	text "になった！"
	prompt

sub_3c6b8:
	ld a, [wcadd]
	bit 2, a
	jr z, asm_3c6ce
	ld hl, wcadf
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
	ld hl, wcae0
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
	ld a, [wcae2]
	and a
	ret z
	dec a
	ld c, a
	ld hl, wcae3
	dec [hl]
	ld hl, TextPointers3c726
	jr nz, asm_3c71b
	xor a
	ld [wcae2], a
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

sub_3c75e:
	ld hl, wca12
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c769
	ld hl, wcde9

asm_3c769:
	inc hl
	ld a, [hl]
	ld [wHPBarOldHP], a
	sub c
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [hl]
	ld [wReplacementBlock], a
	sbc b
	ld [hl], a
	ld [wcdc8], a
	jr nc, asm_3c787
	xor a
	ld [hli], a
	ld [hl], a
	ld [wHPBarNewHP], a
	ld [wcdc8], a

asm_3c787:
	call sub_3c854
	ret

sub_3c78b:
	ld hl, wca14
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c796
	ld hl, wcdeb

asm_3c796:
	ld a, [hli]
	ld [wMapBlocksAddress], a
	ld b, a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld c, a
	srl b
	rr c
	srl b
	rr c
	srl c
	ld a, c
	and a
	jr nz, asm_3c7af
	inc c

asm_3c7af:
	ret

sub_3c7b0:
	ld hl, wca14
	ldh a, [hBattleTurn]
	and a
	jr z, .asm_3c7bb
	ld hl, wcdeb
.asm_3c7bb
	ld a, [hli]
	ld [wMapBlocksAddress], a
	ld b, a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld c, a
	srl b
	rr c
	srl b
	rr c
	ld a, c
	and a
	jr nz, .skip
	inc c
.skip
	ret

Function3c7d3:
	ld hl, wca14
	ldh a, [hBattleTurn]
	and a
	jr z, .asm_3c7de
	ld hl, wcdeb
.asm_3c7de
	ld a, [hli]
	ld [wMapBlocksAddress], a
	ld b, a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld c, a
	srl b
	rr c
	ld a, c
	and a
	jr nz, .skip
	inc c
.skip
	ret

Function3c7f2:
	ld hl, wca14
	ldh a, [hBattleTurn]
	and a
	jr z, .asm_3c7fd
	ld hl, wcdeb
.asm_3c7fd
	ld a, [hli]
	ld [wMapBlocksAddress], a
	ld b, a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld c, a
	ret

sub_3c808:
	ld hl, wcdeb
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3c813
	ld hl, wca14

asm_3c813:
	ld a, [hli]
	ld [wMapBlocksAddress], a
	ld a, [hld]
	ld [wHPBarMaxHP], a
	dec hl
	ld a, [hl]
	ld [wHPBarOldHP], a
	add c
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [hl]
	ld [wReplacementBlock], a
	adc b
	ld [hli], a
	ld [wcdc8], a
	ld a, [wHPBarMaxHP]
	ld c, a
	ld a, [hld]
	sub c
	ld a, [wMapBlocksAddress]
	ld b, a
	ld a, [hl]
	sbc b
	jr c, asm_3c846
	ld a, b
	ld [hli], a
	ld [wcdc8], a
	ld a, c
	ld [hl], a
	ld [wHPBarNewHP], a

asm_3c846:
	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	call sub_3c854
	pop af
	ldh [hBattleTurn], a
	ret

sub_3c854:
	ld hl, $c35e
	ldh a, [hBattleTurn]
	and a
	ld a, 1
	jr z, asm_3c862
	ld hl, $c2ca
	xor a

asm_3c862:
	push bc
	ld [wHPBarType], a
	predef UpdateHPBar
	pop bc
	ret

sub_3c86d:
	ld a, [wca45]
	and a
	jr nz, asm_3c878
	ld hl, wPlayerSubStatus3
	res 5, [hl]

asm_3c878:
	ld a, [wca4d]
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
	ld hl, wca12
	ld a, [hli]
	or [hl]
	call nz, Function3d5ce
	ld c, $3c
	call DelayFrames
	ld a, [wBattleMode]
	dec a
	ret z
	call sub_3c9ad
	jp z, asm_3c9fd
	ld hl, wca12
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
	call sub_3d3f4
	ld a, [wBattleMode]
	dec a
	jr z, asm_3c8e2
	ld a, [wca36]
	ld hl, wd93d
	ld bc, $30
	call AddNTimes
	xor a
	ld [hli], a
	ld [hl], a

asm_3c8e2:
	ld hl, wPlayerSubStatus3
	res 2, [hl]
	xor a
	ld hl, wca55
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld hl, wca40
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wca50], a
	ld [wcad4], a
	ld [wcad8], a
	ld hl, wcad6
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
	ld de, $33
	call PlaySFX
	call WaitSFX
	pop de
	push de
	ld de, $25
	call PlaySFX
	call WaitSFX
	pop de
	jr asm_3c93d

asm_3c935:
	call sub_3c9a8
	ld a, 0
	call sub_3cae1

asm_3c93d:
	ld hl, wca12
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
	ld hl, wcdf9
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
	ld [wca37], a
	jp sub_3e421

EnemyMonFainted:
	text "てきの　@"
	text_from_ram wBattleMonNickname
	text "は　たおれた！"
	prompt

sub_3c9a8:
	inc a
	ld [wcadb], a
	ret

sub_3c9ad:
	ld a, [wd913]
	ld b, a
	xor a
	ld hl, wd93d
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
	ld hl, wccd2
	ld e, $30
	call sub_3d723
	callab Function3834e
	ld a, [wLinkMode]
	and a
	jr z, asm_3c9e4
	call sub_3df8b
	ld a, [wOtherPlayerLinkAction]
	cp $f
	ret z
	call ReloadTilesFromBuffer

asm_3c9e4:
	call sub_3cd6e
	call sub_3d071
	ld a, 1
	ldh [hBattleTurn], a
	call Function3d3a2
	xor a
	ld [wc9e8], a
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
	callab Function390e9
	ld hl, TrainerDefeatedText
	call PrintText
	ld a, [wLinkMode]
	cp 3
	ret z
	call sub_3e201
	ld c, $28
	call DelayFrames
	ld a, [wce02]
	cp 9
	jr nz, asm_3ca51
	ld hl, RivalLossText
	call PrintText
	callab HealParty

asm_3ca51:
	ld a, [wca03]
	ld b, a
	callab Function37e3d
	ld a, b
	cp $4c
	jr nz, asm_3ca74
	ld hl, wca5b
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
	ld de, wd15f
	ld hl, wca5b
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
	ld hl, PlayerReceivedPrizeMoneyText
	call PrintText
	ret

PlayerReceivedPrizeMoneyText:
	text "<PLAYER>は　しょうきんとして"
	line "@"
	deciram wca59, 3, 6
	text "円　てにいれた！"
	prompt

TrainerDefeatedText:
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
	ld hl, wcde9
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
	ld a, [wcd41]
	ld c, a
	ld hl, wca37
	ld b, 0
	predef SmallFarFlagAction
	ld hl, wEnemySubStatus3
	res 2, [hl]
	ld a, [wccc4]
	bit 7, a
	jr z, asm_3cb56
	ld a, $ff
	ld [wccc4], a
	call WaitSFX

asm_3cb56:
	ld hl, wTrainerClass
	ld [hli], a
	ld [hl], a
	ld [wca10], a
	ld [wca11], a
	call sub_3d3f4
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
	ld a, [wca02]
	call PlayStereoCry
	ld hl, FaintedText
	jp PrintText

FaintedText:
	text_from_ram wEnemyMonNickname
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
	call asm_1dd5
	ld a, [wMenuCursorY]
	jr c, asm_3cbbc
	and a
	ret

asm_3cbbc:
	ld a, [wMenuCursorY]
	cp 1
	jr z, asm_3cbaf
	ld hl, wPartyMon1Speed
	ld de, wcdf1
	jp TryRunningFromBattle

UseNextMonText:
	text "つぎの　#をつかいますか？"
	done

sub_3cbdb:
	call LoadStandardMenuHeader
	ld a, 2
	ld [wcdb9], a
	predef Function50771

asm_3cbe8:
	jr nc, asm_3cbf1

asm_3cbea:
	predef Function50774
	jr asm_3cbe8

asm_3cbf1:
	call HasMonFainted
	jr z, asm_3cbea
	ld a, [wLinkMode]
	cp 3
	jr nz, asm_3cc04
	inc a
	ld [wFieldMoveSucceeded], a
	call sub_3df8b

asm_3cc04:
	xor a
	ld [wFieldMoveSucceeded], a
	call ClearSprites
	ld a, [wWhichPokemon]
	ld [wcd41], a
	ld c, a
	ld hl, wca37
	ld b, 1
	push bc
	predef SmallFarFlagAction
	pop bc
	ld hl, wcada
	predef SmallFarFlagAction
	call LoadBattleMonFromParty
	call ApplyStatMods
	call ClearPalettes
	call Function3e3a7
	call CloseWindow
	call GetMemSGBLayout
	call SetPalettes
	call PrintSendOutMonMessage
	call sub_3d387
	call Function3d32e
	call PrintEmptyString
	call BackUpTilesToBuffer
	xor a
	ldh [hBattleTurn], a
	call Function3d3a2
	ld hl, wcde9
	ld a, [hli]
	or [hl]
	ret

asm_3cc56:
	ld a, [wLinkMode]
	and a
	jr nz, asm_3cc83
	ld a, [wce02]
	cp 9
	jr nz, asm_3cc83
	ld hl, $c2a0
	ld bc, $0815
	call ClearBox
	call sub_3e201
	ld c, 40
	call DelayFrames
	ld hl, RivalWinText
	call PrintText
	callab HealParty
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

sub_3cd3b:
	ldh [hTextBoxCursorBlinkInterval], a
	ld c, a

asm_3cd3e:
	push bc
	push hl
	ld b, 7

asm_3cd42:
	push hl
	call sub_3cd59
	pop hl
	ld de, $14
	add hl, de
	dec b
	jr nz, asm_3cd42
	ld c, 2
	call DelayFrames
	pop hl
	pop bc
	dec c
	jr nz, asm_3cd3e
	ret

sub_3cd59:
	ldh a, [hTextBoxCursorBlinkInterval]
	ld c, a
	cp 8
	jr nz, asm_3cd67

asm_3cd60:
	ld a, [hli]
	ld [hld], a
	dec hl
	dec c
	jr nz, asm_3cd60
	ret

asm_3cd67:
	ld a, [hld]
	ld [hli], a
	inc hl
	dec c
	jr nz, asm_3cd67
	ret

sub_3cd6e:
	ld hl, wca37
	xor a
	ld [hl], a
	ld a, [wcd41]
	ld c, a
	ld b, 1
	push bc
	predef SmallFarFlagAction
	ld hl, wcada
	xor a
	ld [hl], a
	pop bc
	predef SmallFarFlagAction
	xor a
	ld hl, wcad6
	ld [hli], a
	ld [hl], a
	dec a
	ld [wcac4], a
	ld hl, wPlayerSubStatus3
	res 5, [hl]
	ld hl, $c2b2
	ld a, 8
	call sub_3cd3b
	call PrintEmptyString
	call LoadStandardMenuHeader
	ld a, [wLinkMode]
	and a
	jr z, FindMonInOTPartyToSwitchIntoBattle
	ld a, [wOtherPlayerLinkAction]
	sub 4
	ld b, a
	jp asm_3cefa

FindMonInOTPartyToSwitchIntoBattle:
	ld a, [wce36]
	and a
	jp nz, asm_3ced8
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
	ld a, [wd913]
	cp b
	jp z, ScoreMonTypeMatchups
	ld a, [wca36]
	cp b
	jr z, .discourage
	ld hl, wd93d
	push bc
	ld a, b
	ld bc, $30
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
	ld hl, wd91d
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
	ld de, wc9e8
	ld a, BANK(Moves)
	call FarCopyBytes
	ld a, 1
	ldh [hBattleTurn], a
	callab Function34fff
	pop bc
	pop de
	pop hl
	ld a, [wCountSetBitsResult]
	cp $b
	jr c, .loop
	ld hl, wEnemyEffectivenessVsPlayerMons
	set 0, [hl]
	ret
.done
	ret

IsThePlayerMonTypesEffectiveAgainstOTMon:
	push bc
	ld hl, wd913
	ld a, b
	inc a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	dec a
	ld hl, asm_3cf17
	ld bc, $1f
	call AddNTimes
	ld de, wcdf7
	ld bc, 2
	ld a, $14
	call FarCopyBytes
	ld a, [wca20]
	ld [wc9f2], a
	xor a
	ldh [hBattleTurn], a
	callab Function34fff
	ld a, [wCountSetBitsResult]
	cp $b
	jr nc, .super_effective
	ld a, [wca21]
	ld [wc9f2], a
	callab Function34fff
	ld a, [wCountSetBitsResult]
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
	ld a, [wd913]
	ld b, a
	ld c, [hl]
.loop2
	sla c
	jr nc, .okay
	dec b
	jr z, asm_3ced8
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
	jr asm_3cefa

.okay2
	ld b, -1
	ld a, [wPlayerEffectivenessVsEnemyMons]
	ld c, a
.loop4
	inc b
	sla c
	jr c, .loop4
	jr asm_3cefa

asm_3ced8:
	call BattleRandom
	and 7
	cp 6
	jr nc, asm_3ced8
	ld b, a
	ld a, [wca36]
	cp b
	jr z, asm_3ced8
	ld hl, wd93d
	push bc
	ld a, b
	ld bc, $30
	call AddNTimes
	pop bc
	ld a, [hli]
	ld c, a
	ld a, [hl]
	or c
	jr z, asm_3ced8

asm_3cefa:
	ld a, b
	ld [wWhichPokemon], a
	ld hl, wd93a
	ld bc, $30
	call AddNTimes
	ld a, [hl]
	ld [wCurPartyLevel], a
	ld a, [wWhichPokemon]
	inc a
	ld hl, wd913
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]

asm_3cf17:
	ld [wcdd7], a
	ld [wMonDexIndex], a
	call AddPokemonToBox
	ld hl, wcde9
	ld a, [hli]
	ld [wcac8], a
	ld a, [hl]
	ld [wcac9], a
	ld a, 1
	ld [wMenuCursorY], a
	ld a, [wce36]
	dec a
	jr z, EnemySendOutFirstMon
	ld a, [wPartyCount]
	dec a
	jr z, EnemySendOutFirstMon
	ld a, [wLinkMode]
	and a
	jr nz, EnemySendOutFirstMon
	ld a, [wce5f]
	bit 6, a
	jr nz, EnemySendOutFirstMon
	callab Function390e9
	ld hl, TrainerAboutToUseText
	call PrintText
	ld bc, $0107
	call asm_1dd5
	ld a, [wMenuCursorY]
	dec a
	jr nz, EnemySendOutFirstMon
	ld a, 2
	ld [wcdb9], a
	predef Function50771

asm_3cf6d:
	ld a, 1
	ld [wMenuCursorY], a
	jr c, asm_3cf93
	ld hl, wcd41
	ld a, [wWhichPokemon]
	cp [hl]
	jr nz, asm_3cf8a
	ld hl, IsAlreadyOutText
	call PrintText

asm_3cf83:
	predef Function50774
	jr asm_3cf6d

asm_3cf8a:
	call HasMonFainted
	jr z, asm_3cf83
	xor a
	ld [wMenuCursorY], a

asm_3cf93:
	call ClearPalettes
	call Function3e3a7

EnemySendOutFirstMon:
	call CloseWindow
	call ClearSprites
	ld hl, $c2a1
	ld bc, $040a
	call ClearBox
	ld b, 1
	call GetSGBLayout
	call SetPalettes
	callab Function390e9
	ld hl, TrainerSentOutText
	call PrintText
	ld a, [wcdd7]
	ld [wMonDexIndex], a
	ld [wCurSpecies], a
	call GetMonHeader
	ld a, 1
	ld [wMonType], a
	predef Function50000
	ld hl, wcd94
	predef Function50ed9
	ld de, vFrontPic
	call LoadMonFrontSprite
	xor a
	ld [wcccd], a
	inc a
	ldh [hBattleTurn], a

; Play shiny animation for Sunflora and Pikachu
	ld b, 1
	ld a, [wMonDexIndex]
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
	ld [wca5c], a
	ld de, $0101
	call PlayMoveAnimation
	ld a, $f
	ld [wCryTracks], a
	ld a, [wcdd7]
	call PlayStereoCry
	call Function3d67c
	ld a, [wMenuCursorY]
	and a
	ret nz
	xor a
	ld [wca37], a
	ld [wcada], a
	call BackUpTilesToBuffer
	jp SwitchPlayerMon

TrainerAboutToUseText:
	text_from_ram wca2b
	text "の　@"
	text_from_ram wStringBuffer1
	text "は<LINE>"
	text_from_ram wBattleMonNickname
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
	text_from_ram wBattleMonNickname
	text "を　くりだした！"
	done

sub_3d071:
	xor a
	ld hl, wcad7
	ld [hli], a
	ld [hl], a
	ld hl, wca40
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wca50], a
	ld [wca53], a
	ld [wcad4], a
	ld [wcad8], a
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
	ld a, [wWhichPokemon]
	ld hl, wPartyMon1HP
	ld bc, $30
	call AddNTimes
	ld a, [hli]
	or [hl]
	ret nz
	ld a, [wce36]
	and a
	jr nz, .has_hp
	ld hl, NoWillText
	call PrintText
.has_hp
	xor a
	ret

NoWillText:
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
	ld a, [wca3f]
	bit 7, a
	jp nz, .cannot_escape
	push hl
	push de
	ld a, [wca03]
	ld [wCountSetBitsResult], a
	ld b, a
	callab Function37e3d
	ld a, b
	cp $48
	pop de
	pop hl
	jr nz, .asm_3d10f
	call GetItemName
	ld hl, EscapedUsingItemText
	call PrintText
	jp .can_escape

.asm_3d10f
	ld a, [wce39]
	inc a
	ld [wce39], a
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ldh [hMultiplicand + 2], a
	ld a, [de]
	inc de
	ldh [hSpriteOffset], a
	ld a, [de]
	ldh [hFFB2], a
	call ReloadTilesFromBuffer
	ld de, hMultiplicand + 1
	ld hl, hSpriteOffset
	ld c, 2
	call memcmp
	jr nc, .can_escape
	xor a
	ldh [hQuotient], a
	ld a, $20
	ldh [hPrintNumDivisor], a
	call Multiply
	ldh a, [hMultiplicand + 1]
	ldh [hProduct], a
	ldh a, [hMultiplicand + 2]
	ldh [hQuotient], a
	ldh a, [hSpriteOffset]
	ld b, a
	ldh a, [hFFB2]
	srl b
	rr a
	srl b
	rr a
	and a
	jr z, .can_escape
	ldh [hPrintNumDivisor], a
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
	ld [wcd40], a
	call sub_3df8b
	call ReloadTilesFromBuffer
	ld a, [wOtherPlayerLinkAction]
	cp $f
	ld a, 2
	jr z, .play_sound
	dec a
.play_sound
	ld [wcd5d], a
	push de
	ld de, $26
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
	ld a, [wWhichPokemon]
	ld bc, $30
	ld hl, wPartyMon1Species
	call AddNTimes
	ld de, wca02
	ld bc, 6
	call CopyBytes
	ld bc, $f
	add hl, bc
	ld de, wca08
	ld bc, 7
	call CopyBytes
	inc hl
	inc hl
	inc hl
	ld de, wca0f
	ld bc, $11
	call CopyBytes
	ld a, [wcdd8]
	ld [wCurSpecies], a
	call GetMonHeader
	ld a, [wMonHType1]
	ld [wca20], a
	ld a, [wMonHType2]
	ld [wca21], a
	ld hl, wPartyMonNicknames
	ld a, [wcd41]
	call SkipNames
	ld de, wEnemyMonNickname
	ld bc, 6
	call CopyBytes
	ld hl, wca16
	ld de, wca93
	ld bc, $a
	call CopyBytes
	call sub_3e247
	call sub_3e360
	xor a
	ldh [hBattleTurn], a
	callab Function95cc
	ret

ApplyStatMods:
	ld a, 7
	ld b, 8
	ld hl, wcaa9
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret

LoadEnemyMonFromParty:
	ld a, [wWhichPokemon]
	ld bc, $30
	ld hl, wWildMons
	call AddNTimes
	ld de, wcdd9
	ld bc, 6
	call CopyBytes
	ld bc, $f
	add hl, bc
	ld de, wcddf
	ld bc, 7
	call CopyBytes
	inc hl
	inc hl
	inc hl
	ld de, wcde6
	ld bc, $11
	call CopyBytes
	ld a, [wcdd9]
	ld [wCurSpecies], a
	call GetMonHeader
	ld hl, wda5f
	ld a, [wWhichPokemon]
	call SkipNames
	ld de, wBattleMonNickname
	ld bc, 6
	call CopyBytes
	ld hl, wcded
	ld de, wca9e
	ld bc, $a
	call CopyBytes
	call sub_3e24b
	ld hl, wMonHType1
	ld de, wcdf7
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ld hl, wMonHBaseStats
	ld de, wcdf9
	ld b, 5
.base_stats_loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .base_stats_loop
	ld a, 7
	ld b, 8
	ld hl, wcab1
.stat_mod_loop
	ld [hli], a
	dec b
	jr nz, .stat_mod_loop
	ld a, [wWhichPokemon]
	ld [wca36], a
	ret

Function3d32e:
	ld hl, wca08
	predef Function50ed9
	ld a, $21
	call Predef
	xor a
	ldh [hGraphicStartTile], a
	ld hl, wStartmenuCursor
	ld [hli], a
	ld [hl], a
	ld [wca38], a
	ld [wc9ef], a
	ld b, 1
	call GetSGBLayout
	ld hl, wEnemySubStatus3
	res 5, [hl]
	xor a
	ldh [hBattleTurn], a
	ld [wcccd], a

; Play shiny animation for Sunflora and Pikachu
	ld b, 1
	ld a, [wMonDexIndex]
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
	ld [wca5c], a
	ld de, $0101
	call PlayMoveAnimation

; mon on the left side
	ld a, $f0
	ld [wCryTracks], a
	ld a, [wMonDexIndex]
	call PlayStereoCry
	call Function3d5ce
	ret

sub_3d387:
	xor a
	ld hl, wcad6
	ld [hli], a
	ld [hl], a
	ld hl, wca3b
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wca48], a
	ld [wca4b], a
	ld [wcad3], a
	ld [wcadc], a
	ret

Function3d3a2:
	ld hl, wcadd
	ld de, wca20
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3d3b3
	ld hl, wcade
	ld de, wcdf7

asm_3d3b3:
	bit 0, [hl]
	ret z
	ld a, [de]
	cp 2
	ret z
	inc de
	ld a, [de]
	cp 2
	ret z
	ld hl, HitWithRecoilText
	call PrintText
	call sub_3c78b
	call sub_3c75e
	ret

HitWithRecoilText:
	text "<USER>は　まきびしの"
	line "ダメージを　うけた！"
	prompt

sub_3d3e1:
	ldh a, [hBattleTurn]
	push af
	xor a
	ldh [hBattleTurn], a
	ld [wcccd], a
	ld de, $0102
	call PlayMoveAnimation
	pop af
	ldh [hBattleTurn], a
	ret

sub_3d3f4:
	ld a, [wcd41]
	ld hl, wPartyMon1Level
	ld bc, $30
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wca0f
	ld bc, 5
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
	callab Function37e2d
	ld a, b
	cp 1
	ret nz
	ld de, wcdea
	ld hl, wcdec
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3d458
	ld de, wca13
	ld hl, wIntroTilesPointer

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
	ld [wHPBarType], a
	and a
	ld hl, $c2ca
	jr z, asm_3d4ac
	ld hl, $c35e

asm_3d4ac:
	ld [wHPBarType], a
	predef UpdateHPBar
	call DrawHUDsAndHPBars
	callab Function37e2d
	ld a, [hl]
	ld [wCountSetBitsResult], a
	call GetItemName
	callab Function37e60
	ld hl, RecoveredWithItemText
	jp PrintText

sub_3d4d4:
	ld a, $69
	ld [wccc0], a
	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	xor a
	ld [wcccd], a
	ld [wccc1], a
	ld a, $51
	call Predef
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
	ld a, [wcd41]
	ld bc, $30
	call AddNTimes
	ld bc, wca03
	ld de, wc9ef
	ld a, 0
	call sub_3d54f
	ret

sub_3d537:
	ld hl, wd91c
	ld a, [wca36]
	ld bc, $30
	call AddNTimes
	ld bc, wcdda
	ld de, wc9e8
	ld a, 1
	call sub_3d54f
	ret

sub_3d54f:
	ldh [hBattleTurn], a
	push hl
	push bc
	ld a, [bc]
	ld b, a
	callab Function37e3d
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
	ld [wCountSetBitsResult], a
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
	callab Function365bf
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
	call Function3d5ce
	jp Function3d67c

Function3d5ce:
	xor a
	ldh [hBGMapMode], a
	ld hl, $c335
	ld bc, $050b
	call ClearBox
	callab Function383cd
	ld hl, $c366
	ld [hl], $73
	ld de, wEnemyMonNickname
	ld hl, $c34a
	call sub_3d72f
	call PlaceString
	push bc
	ld hl, wca02
	ld de, wcd7f
	ld bc, 6
	call CopyBytes
	ld hl, wca0f
	ld de, wLoadedMonLevel
	ld bc, $11
	call CopyBytes
	ld a, [wcd7f]
	ld [wCurSpecies], a
	call GetMonHeader
	pop hl
	push hl
	inc hl
	ld de, wcd9f
	ld a, $34
	call Predef
	pop hl
	jr nz, asm_3d626
	call PrintLevel

asm_3d626:
	ld a, [wcd7f]
	ld [wMonDexIndex], a
	ld hl, $c35e
	ld b, 1
	ld a, $3c
	call Predef
	push de
	ld a, [wcd41]
	ld hl, wPartyMon1Exp + 2
	ld bc, $30
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, $c386
	ld a, [wLoadedMonLevel]
	ld b, a
	call Function3e874
	ld a, 1
	ldh [hBGMapMode], a
	pop de
	ld hl, wccd1
	call sub_3d723
	ld hl, wca12
	ld a, [hli]
	or [hl]
	jr z, asm_3d66d
	ld a, [wcadb]
	and a
	ret nz
	ld a, [wccd1]
	cp 2
	jr z, asm_3d676

asm_3d66d:
	ld hl, wccc4
	bit 7, [hl]
	ld [hl], 0
	ret z
	ret

asm_3d676:
	ld hl, wccc4
	set 7, [hl]
	ret

Function3d67c:
	xor a
	ldh [hBGMapMode], a
	ld hl, $c2a1
	ld bc, $040b
	call ClearBox
	callab Function383fd
	ld de, wBattleMonNickname
	ld hl, $c2b6
	call sub_3d72f
	call PlaceString
	ld h, b
	ld l, c
	push hl
	inc hl
	ld de, wcde7
	ld a, $34
	call Predef
	pop hl
	jr nz, asm_3d6b4
	ld a, [wcde6]
	ld [wLoadedMonLevel], a
	call PrintLevel

asm_3d6b4:
	ld hl, wcde9
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hld]
	ldh [hMultiplicand + 2], a
	or [hl]
	jr nz, asm_3d6c7
	ld c, a
	ld e, a
	ld d, 6
	jp asm_3d710

asm_3d6c7:
	xor a
	ldh [hQuotient], a
	ld a, $30
	ldh [hPrintNumDivisor], a
	call Multiply
	ld hl, wcdeb
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ldh [hPrintNumDivisor], a
	ld a, b
	and a
	jr z, asm_3d6fb
	ldh a, [hPrintNumDivisor]
	srl b
	rr a
	srl b
	rr a
	ldh [hPrintNumDivisor], a
	ldh a, [hMultiplicand + 1]
	ld b, a
	srl b
	ldh a, [hMultiplicand + 2]
	rr a
	srl b
	rr a
	ldh [hMultiplicand + 2], a
	ld a, b
	ldh [hMultiplicand + 1], a

asm_3d6fb:
	ldh a, [hMultiplicand + 1]
	ldh [hProduct], a
	ldh a, [hMultiplicand + 2]
	ldh [hQuotient], a
	ld a, 2
	ld b, a
	call Divide
	ldh a, [hMultiplicand + 2]
	ld e, a
	ld a, 6
	ld d, a
	ld c, a

asm_3d710:
	xor a
	ld [wHPBarType], a
	ld hl, $c2ca
	ld b, 0
	call DrawBattleHPBar
	ld a, 1
	ldh [hBGMapMode], a
	ld hl, wccd2

sub_3d723:
	ld b, [hl]
	call SetHPPal
	ld a, [hl]
	cp b
	ret z
	ld b, 1
	jp GetSGBLayout

sub_3d72f:
	push de
	inc hl
	inc hl
	ld b, 2

asm_3d734:
	inc de
	ld a, [de]
	cp $50
	jr z, asm_3d744
	inc de
	ld a, [de]
	cp $50
	jr z, asm_3d744
	dec hl
	dec b
	jr nz, asm_3d734

asm_3d744:
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
	callab asm_24b06
	jr c, .menu_loop
	ld a, [wStartmenuCursor]
	cp 1
	jp z, .attack_menu
	cp 2
	jp z, .item_menu
	cp 3
	jp z, Battle_PartyMenu
	cp 4
	jp z, Battle_PickedRun
	jr .menu_loop

.attack_menu:
	xor a
	ld [wce39], a
	call ReloadTilesFromBuffer
	and a
	ret

.item_menu:
	ld a, [wLinkMode]
	and a
	jp nz, .cant_use_gear
	call LoadStandardMenuHeader
	callab GetPocket2Status
	xor a
	ld [wSelectedSwapPosition], a
	call ClearPalettes
	callab DrawBackpack

.item_menu_loop
	xor a
	ldh [hBGMapMode], a
	call ClearSprites
	ld hl, $c2ca
	ld b, 8
	ld c, $f
	call DrawTextBox
	call Call_DebugBackpackLoop
	jr c, .exit_item_menu
	call sub_3d84e
	ld a, [wFieldMoveSucceeded]
	and a
	jr z, .item_menu_loop
	call Call_LoadBattleGraphics
	call ClearSprites
	ld a, 1
	ld [wMenuCursorY], a
	call sub_3d832
	ld a, [wce35]
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
	ld [wce35], a
	ld a, 2
	ld [wcd5d], a
	call ClearWindowData
	call SetPalettes
	scf
	ret

.exit_item_menu
	call ClearPalettes
	call DelayFrame
	call Call_LoadBattleGraphics
	call CloseWindow
	call BackUpTilesToBuffer
	call SetPalettes
	jp DisplayBattleMenu

.cant_use_gear
	ld hl, CantUseGearText
	call PrintText
	jp DisplayBattleMenu

CantUseGearText:
	text "ここでは　どうぐを"
	line "つかうことは　できません"
	prompt

sub_3d832:
	ld a, [wPlayerSubStatus3]
	bit 5, a
	jr z, .ok
	ld hl, wca45
	dec [hl]
	jr nz, .ok
	ld hl, wPlayerSubStatus3
	res 5, [hl]
.ok
	ret

Call_DebugBackpackLoop:
	callab DebugBackpackLoop
	ret

sub_3d84e:
	callab ScrollingMenu_ClearLeftColumn
	call PlaceHollowCursor
	predef LoadItemData
	callab CheckItemContext
	ld a, [wItemAttributeParamBuffer]
	ld hl, Data3d870
	call CallJumptable
	ret

Data3d870:
	dw asm_3d87e
	dw asm_3d87e
	dw asm_3d88b
	dw asm_3d89a
	dw asm_3d8b9
	dw asm_3d8aa
	dw asm_3d8b9

asm_3d87e:
	callab PrintCantUseText
	xor a
	ld [wFieldMoveSucceeded], a
	ret

asm_3d88b:
	callab BallPocket
	jr nc, asm_3d8b9
	xor a
	ld [wFieldMoveSucceeded], a
	ret

asm_3d89a:
	callab FlipPocket2Status
	xor a
	ld [wSelectedSwapPosition], a
	ld [wFieldMoveSucceeded], a
	ret

asm_3d8aa:
	call UseItem
	call ClearPalettes
	callab DrawBackpack
	ret

asm_3d8b9:
	call UseItem
	ret

Battle_PartyMenu:
	call LoadStandardMenuHeader

asm_3d8c0:
	call ExitMenu
	call LoadStandardMenuHeader
	xor a
	ld [wcdb9], a
	predef Function50771
	jp c, asm_3d918
	jp asm_3d8eb

asm_3d8d5:
	ld hl, $c387
	ld bc, $81
	ld a, "　"
	call ByteFill
	xor a
	ld [wcdb9], a
	predef Function50774
	jr c, asm_3d918

asm_3d8eb:
	callab Function_8f1cb
	callab asm_24aa9
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
	call Function3e3a7
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
	predef Function502b5
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
	ld a, [wca3f]
	bit 7, a
	jr z, asm_3d992
	ld hl, CantBringBackText
	call PrintText
	jp asm_3d8d5

asm_3d992:
	ld a, [wcd41]
	ld d, a
	ld a, [wWhichPokemon]
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
	call Function3e3a7
	call CloseWindow
	call GetMemSGBLayout
	call SetPalettes

SwitchPlayerMon:
	ld a, [wLinkMode]
	and a
	jr z, asm_3d9cb
	call sub_3df8b

asm_3d9cb:
	call RetreatMon
	ld c, $32
	call DelayFrames
	call sub_3d3e1
	ld hl, $c335
	ld bc, $050b
	call ClearBox
	ld a, [wWhichPokemon]
	ld [wcd41], a
	ld c, a
	ld b, 1
	push bc
	ld hl, wca37
	predef SmallFarFlagAction
	pop bc
	ld hl, wcada
	predef SmallFarFlagAction
	call LoadBattleMonFromParty
	call ApplyStatMods
	call PrintSendOutMonMessage
	call sub_3d387
	call Function3d32e
	call PrintEmptyString
	call BackUpTilesToBuffer
	xor a
	ldh [hBattleTurn], a
	call Function3d3a2
	ld a, 2
	ld [wMenuCursorY], a
	and a
	ret

asm_3da1c: ; unreferenced?
	ld c, 50
	call DelayFrames
	ld a, [wLinkMode]
	and a
	jr z, asm_3da2a
	call sub_3df8b

asm_3da2a:
	ld hl, $c335
	ld bc, $050b
	call ClearBox
	ld a, [wWhichPokemon]
	ld [wcd41], a
	ld c, a
	ld b, 1
	push bc
	ld hl, wca37
	predef SmallFarFlagAction
	pop bc
	ld hl, wcada
	predef SmallFarFlagAction
	call LoadBattleMonFromParty
	xor a
	ld [wCountSetBitsResult], a
	call sub_3e2c6
	call Function3d32e
	call PrintEmptyString
	call BackUpTilesToBuffer
	xor a
	ldh [hBattleTurn], a
	call Function3d3a2
	ret

IsAlreadyOutText:
	text_from_ram wEnemyMonNickname
	text "はもうでています"
	prompt

CantBringBackText:
	text_from_ram wEnemyMonNickname
	text "を　もどすことが"
	line "できない！"
	prompt

Battle_PickedRun:
	call ReloadTilesFromBuffer
	ld a, 3
	ld [wMenuCursorY], a
	ld hl, wca1a
	ld de, wcdf1
	call TryRunningFromBattle
	ld a, 0
	ld [wce38], a
	ret c
	ld a, [wFieldMoveSucceeded]
	and a
	ret nz
	jp DisplayBattleMenu

Function3daa7:
	ld hl, wcddb
	ld a, [wcac0]
	dec a
	jr z, asm_3dac8
	dec a
	jr z, asm_3dabc
	call sub_3dce0
	ret z
	ld hl, wca04
	jr asm_3dac8

asm_3dabc:
	ld a, [wWhichPokemon]
	ld hl, wPartyMon1Moves
	ld bc, $30
	call AddNTimes

asm_3dac8:
	ld de, wce2e
	ld bc, 4
	call CopyBytes
	xor a
	ldh [hBGMapMode], a
	ld hl, $c340
	ld b, 8
	ld c, 8
	ld a, [wcac0]
	cp 2
	jr nz, asm_3dae9
	ld hl, $c34a
	ld b, 8
	ld c, 8

asm_3dae9:
	call DrawTextBox
	ld hl, $c36a
	ld a, [wcac0]
	cp 2
	jr nz, asm_3daf9
	ld hl, $c374

asm_3daf9:
	ld a, $28
	ld [wHPBarMaxHP], a
	ld a, $32
	call Predef
	ld b, 1
	ld a, [wcac0]
	cp 2
	jr nz, asm_3db0e
	ld b, $b

asm_3db0e:
	ld a, $a
	ld [w2DMenuCursorInitY], a
	ld a, b
	ld [w2DMenuCursorInitX], a
	ld a, [wcac0]
	cp 1
	jr z, asm_3db22
	ld a, [wcd40]
	inc a

asm_3db22:
	ld [wMenuCursorY], a
	ld a, 1
	ld [wMenuCursorX], a
	ld a, [wcd57]
	inc a
	ld [w2DMenuNumRows], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld c, $2c
	ld a, [wcac0]
	dec a
	ld b, $c1
	jr z, asm_3db59
	dec a
	ld b, $c3
	jr z, asm_3db59
	ld a, [wLinkMode]
	cp 3
	jr z, asm_3db59
	ld a, [wDebugFlags]
	bit 0, a
	ld b, $c7
	jr z, asm_3db59
	ld b, $ff
	ld c, $2f

asm_3db59:
	ld a, b
	ld [wMenuJoypadFilter], a
	ld a, c
	ld [w2DMenuFlags], a
	xor a
	ld [w2DMenuFlags + 1], a
	ld a, $20
	ld [w2DMenuCursorOffsets], a

asm_3db6a:
	ld a, [wcac0]
	and a
	jr z, asm_3db7e
	dec a
	jr nz, asm_3db9a
	ld hl, $c3c3
	ld de, Data3dc47
	call PlaceString
	jr asm_3db9a

asm_3db7e:
	ld a, [wDebugFlags]
	bit 0, a
	jr nz, asm_3db9a
	call sub_3ddba
	ld a, [wSelectedSwapPosition]
	and a
	jr z, asm_3db9a
	ld hl, $c369
	dec a
	ld bc, $28
	call AddNTimes
	ld [hl], $ec

asm_3db9a:
	call WaitBGMap
	ld a, 1
	ldh [hBGMapMode], a
	call Get2DMenuJoypad_NoPlaceCursor
	bit 6, a
	jp nz, asm_3dc55
	bit 7, a
	jp nz, asm_3dc66
	bit 2, a
	jp nz, asm_3dd31
	bit 3, a
	jp nz, asm_3dc7b
	bit 4, a
	jp nz, asm_3dcaa
	bit 5, a
	jp nz, asm_3dca4
	bit 1, a
	push af
	xor a
	ld [wSelectedSwapPosition], a
	ld a, [wMenuCursorY]
	dec a
	ld [wMenuCursorY], a
	ld b, a
	ld a, [wcac0]
	dec a
	jr nz, asm_3dbd9
	pop af
	ret

asm_3dbd9:
	dec a
	ld a, b
	ld [wcd40], a
	jr nz, asm_3dbe2
	pop af
	ret

asm_3dbe2:
	pop af
	ret nz
	ld hl, wca0a
	ld a, [wMenuCursorY]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	and $3f
	jr z, asm_3dc1a
	ld a, [wca48]
	swap a
	and $f
	dec a
	cp c
	jr z, asm_3dc15
	ld a, [wca3f]
	bit 3, a
	jr nz, asm_3dc05

asm_3dc05:
	ld a, [wMenuCursorY]
	ld hl, wca04
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wcac1], a
	xor a
	ret

asm_3dc15:
	ld hl, Data3dc38
	jr asm_3dc1d

asm_3dc1a:
	ld hl, Data3dc26

asm_3dc1d:
	call PrintText
	call ReloadTilesFromBuffer
	jp Function3daa7



Data3dc26:
	text "わざの　のこりポイントが　ない！<PROMPT>"

Data3dc38:
	text "わざを　ふうじられている！<PROMPT>"

Data3dc47:
	db "どのわざを<NEXT>ものまねする？@"

asm_3dc55:
	ld a, [wMenuCursorY]
	and a
	jp nz, asm_3db6a
	ld a, [wcd57]
	inc a
	ld [wMenuCursorY], a
	jp asm_3db6a

asm_3dc66:
	ld a, [wMenuCursorY]
	ld b, a
	ld a, [wcd57]
	inc a
	inc a
	cp b
	jp nz, asm_3db6a
	ld a, 1
	ld [wMenuCursorY], a
	jp asm_3db6a

asm_3dc7b:
	bit 3, a
	ld a, 0
	jr nz, asm_3dc83
	ld a, 1

asm_3dc83:
	ldh [hBattleTurn], a
	call ReloadTilesFromBuffer
	call sub_3dcb7
	ld a, [wcabe]
	and a
	jp z, Function3daa7
	ld [wccc0], a
	xor a
	ld [wcccd], a
	ld [wccc1], a
	ld a, $51
	call Predef
	jp Function3daa7

asm_3dca4:
	ld a, [wcabe]
	dec a
	jr asm_3dcae

asm_3dcaa:
	ld a, [wcabe]
	inc a

asm_3dcae:
	ld [wcabe], a
	call sub_3dcb7
	jp Function3daa7

sub_3dcb7:
	ld hl, $c3ea
	ld bc, $020a
	call ClearBox
	ld hl, $c3fe
	ld de, wcabe
	ld bc, $8103
	call PrintNumber
	ld a, [wcabe]
	and a
	ret z
	cp $fc
	ret nc
	ld [wCountSetBitsResult], a
	call Unreferenced_GetMoveName
	ld hl, $c401
	jp PlaceString

sub_3dce0:
	ld a, $a5
	ld [wcac1], a
	ld a, [wca48]
	and a
	ld hl, wca0a
	jr nz, asm_3dcf7
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	inc hl
	or [hl]
	ret nz
	jr asm_3dd0c

asm_3dcf7:
	swap a
	and $f
	ld b, a
	ld d, 5
	xor a

asm_3dcff:
	dec d
	jr z, asm_3dd0a
	ld c, [hl]
	inc hl
	dec b
	jr z, asm_3dcff
	or c
	jr asm_3dcff

asm_3dd0a:
	and a
	ret nz

asm_3dd0c:
	ld hl, Data3dd19
	call PrintText
	ld c, $3c
	call DelayFrames
	xor a
	ret

Data3dd19:
	text_from_ram wEnemyMonNickname
	text "は　だすことの　できる<LINE>わざが　ない！<DONE>"

asm_3dd31:
	ld a, [wDebugFlags]
	bit 0, a
	jp nz, asm_3dc7b
	ld a, [wSelectedSwapPosition]
	and a
	jr z, asm_3ddb1
	ld hl, wca04
	call sub_3dd97
	ld hl, wca0a
	call sub_3dd97
	ld hl, wca48
	ld a, [hl]
	swap a
	and $f
	ld b, a
	ld a, [wMenuCursorY]
	cp b
	jr nz, asm_3dd67
	ld a, [hl]
	and $f
	ld b, a
	ld a, [wSelectedSwapPosition]
	swap a
	add b
	ld [hl], a
	jr asm_3dd78

asm_3dd67:
	ld a, [wSelectedSwapPosition]
	cp b
	jr nz, asm_3dd78
	ld a, [hl]
	and $f
	ld b, a
	ld a, [wMenuCursorY]
	swap a
	add b
	ld [hl], a

asm_3dd78:
	ld hl, wPartyMon1Moves
	ld a, [wcd41]
	ld bc, $30
	call AddNTimes
	push hl
	call sub_3dd97
	pop hl
	ld bc, $15
	add hl, bc
	call sub_3dd97
	xor a
	ld [wSelectedSwapPosition], a
	jp Function3daa7

sub_3dd97:
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

asm_3ddb1:
	ld a, [wMenuCursorY]
	ld [wSelectedSwapPosition], a
	jp Function3daa7

sub_3ddba:
	xor a
	ldh [hBGMapMode], a
	ld hl, $c399
	ld b, 4
	ld c, 9
	call DrawTextBox
	ld a, [wca48]
	and a
	jr z, asm_3dde3
	swap a
	and $f
	ld b, a
	ld a, [wMenuCursorY]
	cp b
	jr nz, asm_3dde3
	ld hl, $c3d6
	ld de, DisabledText
	call PlaceString
	jr asm_3de5b

asm_3dde3:
	ld hl, wMenuCursorY
	dec [hl]
	xor a
	ldh [hBattleTurn], a
	ld hl, wca04
	ld a, [wMenuCursorY]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wcac1], a
	ld a, [wcd41]
	ld [wWhichPokemon], a
	ld a, 4
	ld [wMonType], a
	callab Functionf960
	ld hl, wMenuCursorY
	ld c, [hl]
	inc [hl]
	ld b, 0
	ld hl, wca0a
	add hl, bc
	ld a, [hl]
	and $3f
	ld [wStringBuffer1], a
	ld hl, $c3d6
	ld de, MoveTypeText
	call PlaceString
	ld hl, $c3b4
	ld [hl], $f3
	ld hl, $c3ee
	ld [hl], $f3
	ld hl, $c3b2
	ld de, wStringBuffer1
	ld bc, $0102
	call PrintNumber
	ld hl, $c3b5
	ld de, wCountSetBitsResult
	ld bc, $0102
	call PrintNumber
	callab Function360b1
	ld a, [wc9ef]
	ld b, a
	ld hl, $c3ef
	ld a, $3f
	call Predef

asm_3de5b:
	jp WaitBGMap

DisabledText:
	db "ふうじられている！@"

MoveTypeText:
	db "わざタイプ@"

sub_3de6e:
	ld a, [wLinkMode]
	and a
	jr z, asm_3dea0
	call BackUpTilesToBuffer
	ld a, [wFieldMoveSucceeded]
	and a
	call z, sub_3df8b
	call ReloadTilesFromBuffer
	ld a, [wOtherPlayerLinkAction]
	cp $e
	jp z, asm_3df82
	cp $d
	jr z, asm_3df04
	cp 4
	jp nc, asm_3df86
	ld [wcac7], a
	ld c, a
	ld hl, wcddb
	ld b, 0
	add hl, bc
	ld a, [hl]
	jp asm_3df68

asm_3dea0:
	ld hl, wca44
	bit 4, [hl]
	jr z, asm_3dedc
	ld a, [wca51]
	dec a
	ld [wca51], a
	jr nz, asm_3dec1

asm_3deb0:
	ld hl, wca44
	res 4, [hl]
	ld a, 1
	ldh [hBattleTurn], a
	ld hl, Data3dfdd
	call PrintText
	jr asm_3dedc

asm_3dec1:
	ld a, [wcad7]
	and a
	jr z, asm_3deb0
	ld hl, wcde1
	ld a, [wcac7]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	and $3f
	jr z, asm_3deb0
	ld a, [wcad7]
	jp asm_3df68

asm_3dedc:
	ld a, [wca43]
	and $60
	jp nz, asm_3df86
	ld hl, wEnemySubStatus3
	ld a, [hl]
	and $12
	jp nz, asm_3df86
	ld hl, wca40
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
	ld hl, wcde1
	ld bc, 0

asm_3df0e:
	inc b
	ld a, b
	cp 5
	jr z, asm_3df26
	ld a, [hli]
	and $3f
	jr z, asm_3df0e
	ld a, [wca50]
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
	callab Function384d4
	jr asm_3df6b

asm_3df3f:
	ld hl, wcddb
	call BattleRandom
	and 3
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wca50]
	swap a
	and $f
	dec a
	cp c
	jr z, asm_3df3f
	ld a, [hl]
	and a
	jr z, asm_3df3f
	ld hl, wcde1
	add hl, bc
	ld b, a
	ld a, [hl]
	and a
	jr z, asm_3df3f
	ld a, c
	ld [wcac7], a
	ld a, b

asm_3df68:
	ld [wcac2], a

asm_3df6b:
	ld a, 1
	ldh [hBattleTurn], a
	callab Function360b1
	ld a, [wc9e9]
	cp $77
	ret z
	xor a
	ld [wca53], a
	ret

asm_3df82:
	ld a, $a5
	jr asm_3df68

asm_3df86:
	xor a
	ld [wca53], a
	ret

sub_3df8b:
	ld a, $ff
	ld [wOtherPlayerLinkAction], a
	ld a, [wFieldMoveSucceeded]
	and a
	jr nz, asm_3dfa8
	ld a, [wcac1]
	cp $a5
	ld b, $e
	jr z, asm_3dfae
	dec b
	inc a
	jr z, asm_3dfae
	ld a, [wcd40]
	jr asm_3dfaf

asm_3dfa8:
	ld a, [wWhichPokemon]
	add 4
	ld b, a

asm_3dfae:
	ld a, b

asm_3dfaf:
	ld [wPlayerLinkAction], a
	callab PlaceWaitingText

asm_3dfba:
	call LinkTransfer
	call DelayFrame
	ld a, [wOtherPlayerLinkAction]
	inc a
	jr z, asm_3dfba
	ld b, $a

asm_3dfc8:
	call DelayFrame
	call LinkTransfer
	dec b
	jr nz, asm_3dfc8
	ld b, $a

asm_3dfd3:
	call DelayFrame
	call LinkDataReceived
	dec b
	jr nz, asm_3dfd3
	ret

Data3dfdd:
	text "<TARGET>の<LINE>アンコールじょうたいが　とけた！<PROMPT>"

asm_3dff2:
	ldh a, [hBattleTurn]
	and a
	ld hl, wcac2
	ld de, wc9ea
	ld a, [wcac1]
	jr z, asm_3e009
	ld hl, wcac1
	ld de, wc9f1
	ld a, [wcac2]

asm_3e009:
	cp $44
	ret nz
	ld a, 1
	ld [wca3a], a
	ld a, [hl]
	cp $44
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
	ld hl, wce29
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
	ld [wca3a], a
	callab Function351d0
	xor a
	ret

AddPokemonToBox:
	ld a, [wLinkMode]
	and a
	jp nz, LoadEnemyMonFromParty
	ld a, [wcdd7]
	ld [wcdd9], a
	ld [wCurSpecies], a
	ld [wMonDexIndex], a
	call GetMonHeader
	ld a, [wBattleMode]
	cp 2
	jr nz, asm_3e06f
	ld a, [wWhichPokemon]
	ld hl, wd91c
	ld bc, $30
	call AddNTimes
	ld a, [hl]
	jr asm_3e07b

asm_3e06f:
	call BattleRandom
	cp $c8
	ld a, 0
	jr c, asm_3e07b
	ld a, [wMonHItems]

asm_3e07b:
	ld [wcdda], a
	ld a, [wca44]
	bit 3, a
	ld hl, wcad0
	ld a, [hli]
	ld b, [hl]
	jr nz, asm_3e09c
	ld a, [wBattleMode]
	cp 2
	ld a, $98
	ld b, $88
	jr z, asm_3e09c
	call BattleRandom
	ld b, a
	call BattleRandom

asm_3e09c:
	ld hl, wcddf
	ld [hli], a
	ld [hl], b
	ld a, [wCurPartyLevel]
	ld [wcde6], a
	ld de, wcdeb
	ld b, 0
	ld hl, wcdd4
	ld a, $18
	call Predef
	ld a, [wBattleMode]
	cp 2
	jr z, asm_3e0d2
	ld a, [wca44]
	bit 3, a
	jr nz, asm_3e0f1
	ld hl, wcde7
	xor a
	ld [hli], a
	ld [hli], a
	ld a, [wcdeb]
	ld [hli], a
	ld a, [wcdec]
	ld [hli], a
	jr asm_3e0f1

asm_3e0d2:
	ld hl, wd93e
	ld a, [wWhichPokemon]
	ld bc, $30
	call AddNTimes
	ld a, [hld]
	ld [wcdea], a
	ld a, [hld]
	ld [wcde9], a
	ld a, [wWhichPokemon]
	ld [wca36], a
	dec hl
	ld a, [hl]
	ld [wcde7], a

asm_3e0f1:
	ld hl, wMonHType1
	ld de, wcdf7
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ld de, wcddb
	ld a, [wBattleMode]
	cp 2
	jr nz, asm_3e11a
	ld hl, wd91d
	ld a, [wWhichPokemon]
	ld bc, $30
	call AddNTimes
	ld bc, 4
	call CopyBytes
	jr asm_3e129

asm_3e11a:
	xor a
	ld h, d
	ld l, e
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wHPBarMaxHP], a
	ld a, $2a
	call Predef

asm_3e129:
	ld hl, wcddb
	ld de, wcde1
	ld a, $f
	call Predef
	ld hl, wMonHBaseStats
	ld de, wcdf9
	ld b, 5

asm_3e13c:
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, asm_3e13c
	ld a, [wMonHCatchRate]
	ld [de], a
	inc de
	ld a, [wMonHBaseEXP]
	ld [de], a
	ld a, [wcdd7]
	ld [wCountSetBitsResult], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wBattleMonNickname
	ld bc, 6
	call CopyBytes
	ld a, [wcdd7]
	dec a
	ld c, a
	ld b, 1
	ld hl, wPokedexOwnedEnd
	predef SmallFarFlagAction
	ld hl, wcded
	ld de, wca9e
	ld bc, $a
	call CopyBytes
	ld a, 7
	ld b, 8
	ld hl, wcab1

asm_3e182:
	ld [hli], a
	dec b
	jr nz, asm_3e182
	ld a, 1
	ldh [hBattleTurn], a
	callab Function95cc
	ret

asm_3e193:
	push bc
	ld a, [wca0f]
	ld b, a
	ld a, [wcde6]
	ld [wca0f], a
	ld a, b
	ld [wcde6], a
	pop bc
	ret

Function3e1a4:
	call Function3e1aa
	jp asm_3e1d1

Function3e1aa:
	ldh a, [hBattleTurn]
	and a
	ld a, [wca3b]
	ld hl, wca17
	jr z, asm_3e1bb
	ld a, [wca40]
	ld hl, wcdee

asm_3e1bb:
	ld c, 4
	ld b, a

asm_3e1be:
	srl b
	call c, sub_3e1c9
	inc hl
	inc hl
	dec c
	ret z
	jr asm_3e1be

sub_3e1c9:
	ld a, [hl]
	add a
	ld [hld], a
	ld a, [hl]
	rl a
	ld [hli], a
	ret

asm_3e1d1:
	ldh a, [hBattleTurn]
	and a
	ld a, [wca3c]
	ld hl, wca16
	jr z, asm_3e1e2
	ld a, [wca41]
	ld hl, wcded

asm_3e1e2:
	ld c, 4
	ld b, a

asm_3e1e5:
	srl b
	call c, sub_3e1f0
	inc hl
	inc hl
	dec c
	ret z
	jr asm_3e1e5

sub_3e1f0:
	ld a, [hl]
	srl a
	ld [hli], a
	ld d, a
	ld a, [hl]
	rr a
	ld [hl], a
	or d
	jr nz, asm_3e1ff
	ld a, 1
	ld [hl], a

asm_3e1ff:
	dec hl
	ret

sub_3e201:
	xor a
	ld [wcdd7], a
	ld b, 1
	call GetSGBLayout
; Should be a call instead
	callab sub_3f003
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

sub_3e247:
	ld a, 1
	jr asm_3e24c

sub_3e24b:
	xor a

asm_3e24c:
	ldh [hBattleTurn], a
	call sub_3e254
	jp asm_3e291

sub_3e254:
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3e275
	ld a, [wca10]
	and $40
	ret z
	ld hl, wca1b
	ld a, [hld]
	ld b, a
	ld a, [hl]
	srl a
	rr b
	srl a
	rr b
	ld [hli], a
	or b
	jr nz, asm_3e273
	ld b, 1

asm_3e273:
	ld [hl], b
	ret

asm_3e275:
	ld a, [wcde7]
	and $40
	ret z
	ld hl, wcdf2
	ld a, [hld]
	ld b, a
	ld a, [hl]
	srl a
	rr b
	srl a
	rr b
	ld [hli], a
	or b
	jr nz, asm_3e28f
	ld b, 1

asm_3e28f:
	ld [hl], b
	ret

asm_3e291:
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3e2ae
	ld a, [wca10]
	and $10
	ret z
	ld hl, wca17
	ld a, [hld]
	ld b, a
	ld a, [hl]
	srl a
	rr b
	ld [hli], a
	or b
	jr nz, asm_3e2ac
	ld b, 1

asm_3e2ac:
	ld [hl], b
	ret

asm_3e2ae:
	ld a, [wcde7]
	and $10
	ret z
	ld hl, wcdee
	ld a, [hld]
	ld b, a
	ld a, [hl]
	srl a
	rr b
	ld [hli], a
	or b
	jr nz, asm_3e2c4
	ld b, 1

asm_3e2c4:
	ld [hl], b
	ret

sub_3e2c6:
	ld c, 0

asm_3e2c8:
	call sub_3e2d2
	inc c
	ld a, c
	cp 5
	jr nz, asm_3e2c8
	ret

sub_3e2d2:
	push bc
	push bc
	ld a, [wCountSetBitsResult]
	and a
	ld a, c
	ld hl, wca16
	ld de, wca93
	ld bc, wcaa9
	jr z, asm_3e2ed
	ld hl, wcded
	ld de, wca9e
	ld bc, wcab1

asm_3e2ed:
	add c
	ld c, a
	jr nc, asm_3e2f2
	inc b

asm_3e2f2:
	ld a, [bc]
	pop bc
	ld b, a
	push bc
	sla c
	ld b, 0
	add hl, bc
	ld a, c
	add e
	ld e, a
	jr nc, asm_3e301
	inc d

asm_3e301:
	pop bc
	push hl
	ld hl, Data3e346
	dec b
	sla b
	ld c, b
	ld b, 0
	add hl, bc
	xor a
	ldh [hQuotient], a
	ld a, [de]
	ldh [hMultiplicand + 1], a
	inc de
	ld a, [de]
	ldh [hMultiplicand + 2], a
	ld a, [hli]
	ldh [hPrintNumDivisor], a
	call Multiply
	ld a, [hl]
	ldh [hPrintNumDivisor], a
	ld b, 4
	call Divide
	pop hl
	ldh a, [hMultiplicand + 2]
	sub $e7
	ldh a, [hMultiplicand + 1]
	sbc 3
	jp c, asm_3e339
	ld a, 3
	ldh [hMultiplicand + 1], a
	ld a, $e7
	ldh [hMultiplicand + 2], a

asm_3e339:
	ldh a, [hMultiplicand + 1]
	ld [hli], a
	ld b, a
	ldh a, [hMultiplicand + 2]
	ld [hl], a
	or b
	jr nz, asm_3e344
	inc [hl]

asm_3e344:
	pop bc
	ret

Data3e346:
	dw $6419
	dw $641C
	dw $6421
	dw $6428
	dw $6432
	dw $6442
	dw $0101
	dw $0A0F
	dw $0102
	dw $0A19
	dw $0103
	dw $0A23
	dw $0104

sub_3e360:
	ld a, [wLinkMode]
	cp 3
	ret z
	ld a, [wBadges]
	ld b, a
	ld hl, wca16
	ld c, 4

asm_3e36f:
	srl b
	call c, sub_3e37c
	inc hl
	inc hl
	srl b
	dec c
	jr nz, asm_3e36f
	ret

sub_3e37c:
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
	ld a, [hld]
	sub $e7
	ld a, [hl]
	sbc 3
	ret c
	ld a, 3
	ld [hli], a
	ld a, $e7
	ld [hld], a
	ret

Call_LoadBattleGraphics:
	jpab LoadBattleGraphics

Function3e3a7:
	jpab Functionf80d6

	ld de, $4c22 ; pointing to code?
	ld hl, $96c0
	ld bc, $3e04
	call Get1bpp

	ld de, $4c42 ; pointing to code?
	ld hl, $9730
	ld bc, $3e06
	call Get1bpp

	ld de, $4c72 ; pointing to code?
	ld hl, $9550
	ld bc, $3e08
	jp Get2bpp

PrintEmptyString:
	ld hl, .EmptyString
	jp PrintText

.EmptyString:
	db "@"

SECTION "engine/dumps/bank0f.asm@PlayMoveAnimation", ROMX
PlayMoveAnimation:
	ld a, e
	ld [wccc0], a
	ld a, d
	ld [wccc1], a

asm_3e419:
	call WaitBGMap

asm_3e41c:
	ld a, $51
	jp Predef

sub_3e421:
	ld a, [wLinkMode]
	and a
	ret nz

asm_3e426:
	call sub_3e64b
	xor a
	ld [wWhichPokemon], a
	ld bc, wPartyMon1Species

asm_3e430:
	ld hl, $22
	add hl, bc
	ld a, [hli]
	or [hl]
	jp z, asm_3e613
	push bc
	ld hl, wca37
	ld a, [wWhichPokemon]
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
	ld hl, wcdf9
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
	ldh [hQuotient], a
	ldh [hMultiplicand + 1], a
	ld a, [wcdff]
	ldh [hMultiplicand + 2], a
	ld a, [wcde6]
	ldh [hPrintNumDivisor], a
	call Multiply
	ld a, 7
	ldh [hPrintNumDivisor], a
	ld b, 4
	call Divide
	pop bc
	ld hl, 6
	add hl, bc
	ld a, [wce73]
	cp [hl]
	jr nz, asm_3e4a7
	inc hl
	ld a, [wce74]
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
	ldh a, [hMultiplicand + 2]
	ld [wcd32], a
	add d
	ld [hld], a
	ld d, [hl]
	ldh a, [hMultiplicand + 1]
	ld [wStringBuffer2], a
	adc d
	ld [hl], a
	jr nc, asm_3e4ce
	dec hl
	inc [hl]

asm_3e4ce:
	ld a, [wWhichPokemon]
	ld e, a
	ld d, 0
	ld hl, wPartySpecies
	add hl, de
	ld a, [hl]
	ld [wCurSpecies], a
	call GetMonHeader
	push bc
	ld d, $64
	callab Function50cd1
	pop bc
	ld hl, $a
	add hl, bc
	push bc
	ldh a, [hQuotient]
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
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicknames
	call GetNick
	ld hl, BoostedExpPointsText
	call PrintText
	xor a
	ld [wMonType], a
	predef Function50000
	callba Function50caa
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
	ld [wCountSetBitsResult], a
	call GetMonHeader
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
	ld a, $18
	call Predef
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
	ld a, [wcd41]
	ld d, a
	ld a, [wWhichPokemon]
	cp d
	jr nz, asm_3e5d3
	ld de, wca12
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld de, wca14
	push bc
	ld bc, $c
	call CopyBytes
	pop bc
	ld hl, $1f
	add hl, bc
	ld a, [hl]
	ld [wca0f], a
	ld a, [wca3f]
	bit 3, a
	jr nz, asm_3e5ae
	ld hl, $26
	add hl, bc
	ld de, wca93
	ld bc, $a
	call CopyBytes

asm_3e5ae:
	xor a
	ld [wCountSetBitsResult], a
	call sub_3e2c6
; these three calls should be regular calls
	callab sub_3e247
	callab sub_3e360
	callab Function3d5ce
	call PrintEmptyString
	call BackUpTilesToBuffer

asm_3e5d3:
	ld hl, GrewToLevelText
	call PrintText
	xor a
	ld [wMonType], a
	predef Function50000
	ld d, 1
	callab Function50628
	call TextboxWaitPressAorB_BlinkCursor
	call ReloadTilesFromBuffer
	xor a
	ld [wMonType], a
	ld a, [wCurSpecies]
	ld [wCountSetBitsResult], a
	ld a, $29
	call Predef
	ld hl, wcdc2
	ld a, [wWhichPokemon]
	ld c, a
	ld b, 1
	predef SmallFarFlagAction
	pop af
	ld [wCurPartyLevel], a

asm_3e613:
	ld a, [wPartyCount]
	ld b, a
	ld a, [wWhichPokemon]
	inc a
	cp b
	jr z, asm_3e62f
	ld [wWhichPokemon], a
	ld bc, $30
	ld hl, wPartyMon1Species
	call AddNTimes
	ld b, h
	ld c, l
	jp asm_3e430

asm_3e62f:
	ld hl, wca37
	xor a
	ld [hl], a
	ld a, [wcd41]
	ld c, a
	ld b, 1
	push bc
	predef SmallFarFlagAction
	ld hl, wcada
	xor a
	ld [hl], a
	pop bc
	ld a, $c
	jp Predef

sub_3e64b:
	ld a, [wca37]
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
	ld [wCountSetBitsResult], a
	ld hl, wcdf9
	ld c, 7

asm_3e667:
	xor a
	ldh [hProduct], a
	ld a, [hl]
	ldh [hQuotient], a
	ld a, [wCountSetBitsResult]
	ldh [hPrintNumDivisor], a
	ld b, 2
	call Divide
	ldh a, [hMultiplicand + 2]
	ld [hli], a
	dec c
	jr nz, asm_3e667
	ret

sub_3e67e:
	push bc
	ldh a, [hMultiplicand + 1]
	ld b, a
	ldh a, [hMultiplicand + 2]
	ld c, a
	srl b
	rr c
	add c
	ldh [hMultiplicand + 2], a
	ldh a, [hMultiplicand + 1]
	adc b
	ldh [hMultiplicand + 1], a
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
	ld a, [wce36]
	and a
	jr nz, .print_text

.not_link
	ld hl, wcde9
	ld a, [hli]
	or [hl]
	ld hl, GoText
	jr z, .print_text
	xor a
	ldh [hQuotient], a
; enemy mon current HP * 25
	ld hl, wcde9
	ld a, [hli]
	ld [wcac8], a
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ld [wcac9], a
	ldh [hMultiplicand + 2], a
	ld a, 25
	ldh [hPrintNumDivisor], a
	call Multiply
	ld hl, wcdeb
	ld a, [hli]
	ld b, [hl]
	srl a
	rr b
	srl a
	rr b
	ld a, b
; enemy mon max HP divided by 4
	ld b, 4
	ldh [hPrintNumDivisor], a
	call Divide

; (enemy's current HP * 25) / (enemy's max HP / 4)
; approximates current % of max HP
	ldh a, [hMultiplicand + 2]
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
	text_from_ram wEnemyMonNickname
	text "！<DONE>"

RetreatMon:
	ld hl, PlayerMon2Text
	jp PrintText

PlayerMon2Text:
	text_from_ram wEnemyMonNickname
	text "　@"
	start_asm
	push de
	push bc
	ld hl, wcdea
	ld de, wcac9
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
	ldh [hPrintNumDivisor], a
	call Multiply
	ld hl, wcdeb
	ld a, [hli]
	ld b, [hl]
	srl a
	rr b
	srl a
	rr b
	ld a, b
	ld b, 4
	ldh [hPrintNumDivisor], a
	call Divide
	pop bc
	pop de
	ldh a, [hMultiplicand + 2]
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
	ld a, [wcdd9]
	ld [wCurSpecies], a
	call GetMonHeader
	ld a, [wMonHCatchRate]
	ld [wcdfe], a
	pop hl

asm_3e843:
	push hl
	call ReloadTilesFromBuffer
	pop hl
	jp PrintText

Data3e84b:
	text "やせいの@"
	text_from_ram wBattleMonNickname
	text "は"
	line "エサを　たべてる！"
	prompt

Data3e861:
	text "やせいの@"
	text_from_ram wBattleMonNickname
	text "は"
	line "おこってる！"
	prompt

Function3e874:
	push hl
	push de
	ld d, b
	push de
	callab Function50cd1
	pop de
	ld hl, hQuotient
	ld a, [hli]
	push af
	ld a, [hli]
	push af
	ld a, [hl]
	push af
	inc d
	callab Function50cd1
	ld hl, hMultiplicand + 2
	ld a, [hl]
	ldh [hPrintNumTemp], a
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
	ld a, [de]
	dec de
	ld c, a
	ldh a, [hPrintNumTemp]
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
	ld a, $40
	ldh [hPrintNumDivisor], a
	call Multiply
	pop af
	ld c, a
	pop af
	ld b, a

asm_3e8d1:
	ld a, b
	and a
	jr z, asm_3e8e9
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
	jr asm_3e8d1

asm_3e8e9:
	ld a, c
	ldh [hPrintNumDivisor], a
	ld b, 4
	call Divide
	pop hl
	ld bc, 7
	add hl, bc
	ldh a, [hMultiplicand + 2]
	ld b, a
	ld a, $40
	sub b
	ld b, a
	ld c, 8

asm_3e8ff:
	ld a, b
	sub 8
	jr c, asm_3e90d
	ld b, a
	ld a, $6a
	ld [hld], a
	dec c
	jr z, asm_3e91d
	jr asm_3e8ff

asm_3e90d:
	add 8
	jr z, asm_3e915
	add $54
	jr asm_3e917

asm_3e915:
	ld a, $62

asm_3e917:
	ld [hld], a
	ld a, $62
	dec c
	jr nz, asm_3e915

asm_3e91d:
	ret

Function3e91e:
	ld a, [wca3e]
	bit 4, a
	ld hl, Functioncc44f
	jr nz, asm_3e954
	ld a, [wcadc]
	and a
	ld hl, Functioncc4d4
	jr nz, asm_3e954
	ld a, [wMonDexIndex]
	push af
	ld a, [wca02]
	ld [wCurSpecies], a
	ld [wMonDexIndex], a
	call GetMonHeader
	ld hl, $14
	call UncompressMonSprite
	ld hl, $9310
	ld a, $33
	call Predef
	pop af
	ld [wMonDexIndex], a
	ret

asm_3e954:
	ldh a, [hBattleTurn]
	push af
	xor a
	ldh [hBattleTurn], a
	ld a, BANK(Functioncc44f)
	call FarCall_hl
	pop af
	ldh [hBattleTurn], a
	ret

Function3e963:
	ld a, [wca43]
	bit 4, a
	ld hl, Functioncc44f
	jr nz, asm_3e999
	ld a, [wcad8]
	and a
	ld hl, Functioncc4d4
	jr nz, asm_3e999
	ld a, [wMonDexIndex]
	push af
	ld a, [wcdd9]
	ld [wCurSpecies], a
	ld [wMonDexIndex], a
	call GetMonHeader
	ld hl, wcddf
	predef Function50ed9
	ld de, vFrontPic
	call LoadMonFrontSprite
	pop af
	ld [wMonDexIndex], a
	ret

asm_3e999:
	ldh a, [hBattleTurn]
	push af
	ld a, 1
	ldh [hBattleTurn], a
	ld a, BANK(Functioncc44f)
	call FarCall_hl
	pop af
	ldh [hBattleTurn], a
	ret

_LoadWildMons:
	xor a
	ld hl, wWildMons
	ld bc, $29
	call ByteFill
	ld a, [wMapGroup]
	ld d, a
	ld a, [wMapId]
	ld e, a
	ld bc, $29
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
	ld bc, $27
	jp CopyBytes

Function3e9dc:
	ld hl, $c2a0
	ld bc, $0168
	xor a
	call ByteFill
	ld hl, GrassWildMons
	ld de, $c2a0

asm_3e9ec:
	ld a, [hl]
	cp $ff
	jr z, asm_3ea0d
	push hl
	ld b, a
	inc hl
	ld c, [hl]
	call sub_3ea0e
	jr nc, asm_3ea06
	push de
	call GetWorldMapLocation
	call sub_3ea27
	pop de
	jr c, asm_3ea06
	ld [de], a
	inc de

asm_3ea06:
	pop hl
	ld bc, $29
	add hl, bc
	jr asm_3e9ec

asm_3ea0d:
	ret

sub_3ea0e:
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl
	ld a, $12

asm_3ea15:
	push af
	ld a, [wCountSetBitsResult]
	cp [hl]
	jr z, asm_3ea24
	inc hl
	inc hl
	pop af
	dec a
	jr nz, asm_3ea15
	and a
	ret

asm_3ea24:
	pop af
	scf
	ret

sub_3ea27:
	ld c, a
	ld hl, $c2a0
	ld de, $0168

asm_3ea2e:
	ld a, [hli]
	cp c
	jr z, asm_3ea3a
	dec de
	ld a, e
	or d
	jr nz, asm_3ea2e
	ld a, c
	and a
	ret

asm_3ea3a:
	scf
	ret

SECTION "engine/dumps/bank0f.asm@Function3ee3e", ROMX
Function3ee3e:
	ld a, [wce2d]
	and a
	jr z, asm_3ee4b
	dec a
	jp z, asm_3eeba
	ld [wce2d], a

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
	ld hl, wd91e
	add hl, bc
	ld a, [hli]
	ld [wCurPartyLevel], a
	ld a, [hl]
	call sub_3ef03
	jr c, asm_3eebd
	ld [wMonDexIndex], a
	ld [wcdd7], a
	ld a, [wce2d]
	and a
	jr z, asm_3eec1
	ld a, [wPartyMon1Level]
	ld b, a
	ld a, [wCurPartyLevel]
	cp b
	jr c, asm_3eebd
	jr asm_3eec1

asm_3eeba:
	ld [wce2d], a

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
	ld a, [wce02]
	and a
	jr nz, InitBattleCommon
	ld a, [wce01]
	and a
	jr z, InitBattleCommon
	ld [wMonDexIndex], a
	ld [wcdd7], a

InitBattleCommon:
	ld a, [wTimeOfDayPal]
	push af
	ld hl, wTextBoxFlags
	ld a, [hl]
	push af
	res 1, [hl]
	ldh a, [hMapAnims]
	ld [wce26], a
	call PlayBattleMusic
	call ShowLinkBattleParticipants
	call InitBattleVariables
	ld a, [wce02]
	and a
	jr nz, .asm_3ef4f
	call sub_3efdb
	jr _InitBattleCommon
.asm_3ef4f
	call sub_3ef9a

_InitBattleCommon:
	ld b, 0
	call GetSGBLayout
	ld hl, wVramState
	res 0, [hl]
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
	call z, Function3d67c
	call StartBattle
	call sub_3f13e
	pop af
	ld [wTextBoxFlags], a
	pop af
	ld [wTimeOfDayPal], a
	ld a, [wce26]
	ldh [hMapAnims], a
	scf
	ret

sub_3ef9a:
	ld [wca22], a
	callab LoadTrainerClass
	callab Function38f45
	ld a, [wca22]
	cp 9
	jr nz, asm_3efb8
	xor a
	ld [wd91c], a

asm_3efb8:
	call sub_3f003
	xor a
	ld [wcdd7], a
	ldh [hGraphicStartTile], a
	dec a
	ld [wcac4], a
	ld hl, $c2ac
	ld bc, $0707
	predef PlaceGraphic
	ld a, $ff
	ld [wca36], a
	ld a, 2
	ld [wBattleMode], a
	ret

sub_3efdb:
	ld a, 1
	ld [wBattleMode], a
	call AddPokemonToBox
	ld hl, wcddf
	predef Function50ed9
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

Function3f04a:
	ld a, [wcdd8]
	ld [wMonDexIndex], a
	ld hl, $c305
	ld b, 7
	ld c, 8
	call ClearBox
	ld hl, $14
	call UncompressMonSprite
	ld hl, $9310
	ld a, $33
	jp Predef

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
	ld [wca39], a
	ld [wca02], a
	ld [wca37], a
	ld [wcd41], a
	ld [wce06], a
	ld [wTimeOfDayPal], a
	ld [wcaba], a
	ld hl, wccd1
	ld [hli], a
	ld [hl], a
	ld hl, wca08
	ld [hli], a
	ld [hl], a
	ld hl, wcddf
	ld [hli], a
	ld [hl], a
	ld hl, wc9e8
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
	ld [wcab9], a
	ld a, $2b
	call Predef

asm_3f15a:
	xor a
	ld [wccc4], a
	ld [wBattleMode], a
	ld [wBattleType], a
	ld [wca3a], a
	ld [wce01], a
	ld [wce02], a
	ld [wce38], a
	ld [wce39], a
	ld [wce06], a
	ld hl, wcd3c
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wMenuScrollPosition], a
	ld hl, wca3b
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
	ld hl, wcaca
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	ret z
	ld a, [wca03]
	ld b, a
	callab Function37e3d
	ld a, b
	cp $4c
	jr nz, AddBattleMoneyToAccount
	ld hl, wcacc
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
	ld hl, wcacc
	ld de, wd15f
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
	ld hl, GotMoneyForWinningText
	call PrintText
	ret

GotMoneyForWinningText:
	text "<PLAYER>は　@"
	deciram wcaca, 3, 6
	text "円"
	line "ひろった！"
	prompt

sub_3f1f3:
	ld a, [wca36]
	ld hl, wd93b
	ld bc, $30
	call AddNTimes
	ld a, [wcde7]
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
	call Call_LoadBattleGraphics
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
	ld a, $33
	call Predef
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
	ld de, $62 ; SFX_SHINE
	call PlaySFX
	call WaitSFX
	ld c, 20
	call DelayFrames
	callab Function390e9
	ld hl, WantsToBattleText
	jr .PlaceBattleStartText

.wild
	ld a, $f
	ld [wCryTracks], a
	ld a, [wcdd7]
	call PlayStereoCry
	ld hl, WildPokemonAppearedText
	ld a, [wca3a]
	and a
	jr z, .PlaceBattleStartText
	ld hl, HookedPokemonAttackedText

.PlaceBattleStartText:
	push hl
	callab Function38340
	pop hl
	call PrintText
	ret

WildPokemonAppearedText:
	text "あ！　やせいの"
	line "@"
	text_from_ram wBattleMonNickname
	text "が　とびだしてきた！"
	prompt

HookedPokemonAttackedText:
	text "つりあげた　@"
	text_from_ram wBattleMonNickname
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
	ld a, $4e
	call Predef
	call Call_LoadBattleGraphics
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
	callab Function38431
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

