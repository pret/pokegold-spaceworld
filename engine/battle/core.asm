INCLUDE "constants.asm"

SECTION "engine/battle/core.asm@DoBattle", ROMX

DoBattle:
	xor a
	ld [wBattleParticipantsNotFainted], a
	ld [wBattleParticipantsIncludingFainted], a
	ld [wBattlePlayerAction], a

	inc a
	ld [wBattleHasJustStarted], a

	ld hl, wOTPartyMon1HP
	ld bc, PARTYMON_STRUCT_LENGTH - 1
	ld d, BATTLEACTION_SWITCH1 - 1
.loop
	inc d
	ld a, [hli]
	or [hl]
	jr nz, .alive
	add hl, bc
	jr .loop

.alive
	ld a, d
	ld [wBattleAction], a
	ld a, [wLinkMode]
	and a
	jr z, .not_linked

	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr z, .player_2

.not_linked
	ld a, [wBattleMode]
	dec a
	jr z, .wild
	call EnemySwitch
	call NewEnemyMonStatus

.wild
	ld c, 40
	call DelayFrames

.player_2
	call BackUpTilesToBuffer
.check_any_alive
	call CheckPlayerPartyForFitMon
	ld a, d
	and a
	jp z, LostBattle
	call ReloadTilesFromBuffer
	ld a, [wBattleType]
	and a
	jp nz, .SafariZoneBattleTurn
	xor a
	ld [wCurPartyMon], a
.loop2
	call CheckIfCurPartyMonIsFitToFight
	jr nz, .alive2
	ld hl, wCurPartyMon
	inc [hl]
	jr .loop2

.alive2
	ld a, [wCurPartyMon]
	ld [wCurBattleMon], a
	inc a
	ld hl, wPartySpecies - 1
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wCurPartySpecies], a
	ld [wTempBattleMonSpecies], a
	hlcoord 1, 5
	ld a, 9
	call SlideBattlePicOut
	call BackUpTilesToBuffer
	ld a, [wCurPartyMon]
	ld c, a
	ld b, SET_FLAG
	push bc
	ld hl, wBattleParticipantsNotFainted
	predef SmallFarFlagAction
	ld hl, wBattleParticipantsIncludingFainted
	pop bc
	predef SmallFarFlagAction
	call LoadBattleMonFromParty
	call ApplyStatMods
	call SendOutMonText
	call NewBattleMonStatus
	call SendOutPlayerMon
	call EmptyBattleTextbox
	call BackUpTilesToBuffer
	xor a
	ldh [hBattleTurn], a
	call SpikesDamage
	ld a, [wLinkMode]
	and a
	jr z, .to_battle
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr nz, .to_battle

	call EnemySwitch
	call NewEnemyMonStatus
	ld a, 1
	ldh [hBattleTurn], a
	call SpikesDamage
.to_battle
	jp BattleTurn

; Old Safari Zone code from Red & Green.
.SafariZoneBattleTurn
	call BattleMenu
	ret c
	ld a, [wBattlePlayerAction]
	and a ; if non-zero, this would have meant that the item was used successfully
	jr z, .SafariZoneBattleTurn
	; There used to be code checking for Safari Balls here, but it was taken out.
	call ReloadTilesFromBuffer
	ld hl, Unused_OutOfSafariBallsText
	jp PrintText

; Unreferenced.
.not_out_of_safari_balls
	call PrintSafariZoneBattleText
	ld a, [wEnemyMonSpeed + 1]
	add a
	ld b, a
	jp c, WildFled_EnemyFled_LinkBattleCanceled
	ld a, [wUnused_SafariBaitFactor]
	and a
	jr z, .check_escape_factor
	srl b
	srl b
.check_escape_factor
	ld a, [wUnused_SafariEscapeFactor]
	and a
	jr z, .compare_with_random_value
	sla b
	jr nc, .compare_with_random_value
	ld b, $ff
.compare_with_random_value
	call BattleRandom
	cp b
	jp nc, .check_any_alive
	jr WildFled_EnemyFled_LinkBattleCanceled

Unused_OutOfSafariBallsText:
	text "アナウンス『ピンポーン！"

	para "サファリ　ボールを"
	line "ぜんぶ　なげました！"
	prompt

WildFled_EnemyFled_LinkBattleCanceled:
	call ReloadTilesFromBuffer
	ld a, DRAW
	ld [wBattleResult], a

	ld a, [wLinkMode]
	and a
	ld hl, WildPokemonFledText
	jr z, .print_text

	xor a ; WIN
	ld [wBattleResult], a
	ld hl, EnemyPokemonFledText

.print_text
	call PrintText
	ld de, SFX_RUN
	call PlaySFX
	xor a
	ldh [hBattleTurn], a
; Was originally AnimationSlideEnemyMonOff in pokered.
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

BattleTurn:
	call UpdateBattleMonInParty
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .CheckEnemyFirst

	call CheckFaint_Player
	jp z, HandlePlayerMonFaint
	call CheckFaint_Enemy
	jp z, HandleEnemyMonFaint
	call HandlePerishSong

	call CheckFaint_Player
	jp z, HandlePlayerMonFaint
	call CheckFaint_Enemy
	jp z, HandleEnemyMonFaint
	jr .PerishSongDone

.CheckEnemyFirst:
	call CheckFaint_Enemy
	jp z, HandleEnemyMonFaint
	call CheckFaint_Player
	jp z, HandlePlayerMonFaint
	call HandlePerishSong
	
	call CheckFaint_Enemy
	jp z, HandleEnemyMonFaint
	call CheckFaint_Player
	jp z, HandlePlayerMonFaint

.PerishSongDone:
	call HandleSafeguard
	call HandleWeather
	call HandleStatBoostingHeldItems
	call HandleHealingItems
	call UpdateBattleMonInParty
	call BackUpTilesToBuffer

	call TryEnemyFlee
	jp c, WildFled_EnemyFled_LinkBattleCanceled

	xor a
	ld [wBattleHasJustStarted], a
	ld a, [wPlayerSubStatus4]
	and ((1 << SUBSTATUS_RECHARGE) | (1 << SUBSTATUS_RAGE))
	jp nz, .locked_in

	ld hl, wEnemySubStatus3
	res SUBSTATUS_FLINCHED, [hl]
	ld hl, wPlayerSubStatus3
	res SUBSTATUS_FLINCHED, [hl]

	ld a, [hl]
	and ((1 << SUBSTATUS_RAMPAGE) | (1 << SUBSTATUS_CHARGED))
	jp nz, .locked_in

	ld hl, wPlayerSubStatus1
	bit SUBSTATUS_ROLLOUT, [hl]
	jp nz, .locked_in

.loop1
	call BattleMenu
	ret c
	ld a, [wBattleEnded]
	and a
	ret nz
	ld hl, wPlayerSubStatus5
	bit SUBSTATUS_ENCORED, [hl]
	jr z, .not_encored
	ld a, [wPlayerEncoreCount]
	dec a
	ld [wPlayerEncoreCount], a
	jr nz, .encored

.clear_encore
	ld hl, wPlayerSubStatus5
	res SUBSTATUS_ENCORED, [hl]
	xor a
	ldh [hBattleTurn], a
	ld hl, BattleText_TargetsEncoreEnded
	call PrintText
	jr .not_encored

.encored
; If the player hasn't used a move (possible via sleep and freeze), Encore gets cleared.
	ld a, [wLastPlayerCounterMove]
	and a
	jr z, .clear_encore
	ld a, [wCurMoveNum]
	ld c, a
	ld b, 0
	ld hl, wBattleMonPP
	add hl, bc
	ld a, [hl]
	and PP_MASK
	jr z, .clear_encore
	ld a, [wLastPlayerCounterMove]
	ld [wCurPlayerMove], a
	jr .encored2

.not_encored
	ld a, [wPlayerSubStatus3]
	and ((1 << SUBSTATUS_BIDE) | (1 << SUBSTATUS_USING_TRAPPING_MOVE))
	jr nz, .locked_in
	ld a, [wBattlePlayerAction]
	and a ; BATTLEPLAYERACTION_USEMOVE
	jr nz, .locked_in
	xor a
	ld [wMoveSelectionMenuType], a
	inc a ; MOVE_POUND
	ld [wFXAnimID], a
	call MoveSelectionScreen
	push af
	call ReloadTilesFromBuffer
	call UpdateBattleHuds
	pop af
	jp nz, .loop1

.encored2
	xor a
	ldh [hBattleTurn], a
	callfar UpdateMoveData
	ld a, [wPlayerMoveStructEffect]
	cp EFFECT_FURY_CUTTER
	jr z, .continue_fury_cutter
	xor a
	ld [wPlayerFuryCutterCount], a
	jr .next

.locked_in
	xor a
	ld [wPlayerFuryCutterCount], a
.continue_fury_cutter
.next
	call ParseEnemyAction
	ld a, [wLinkMode]
	and a
	jr z, .use_move

	ld a, [wOtherPlayerLinkAction]
	cp BATTLEACTION_FORFEIT
	jp z, WildFled_EnemyFled_LinkBattleCanceled
	cp BATTLEACTION_STRUGGLE
	jr z, .use_move
	cp BATTLEACTION_SKIPTURN
	jr z, .use_move
	sub BATTLEACTION_SKIPTURN - BATTLEACTION_SWITCH6
	jr c, .use_move

	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_USING_TRAPPING_MOVE, a
	jr z, .dont_change_last_move
	ld a, [wCurMoveNum]
	ld hl, wBattleMonMoves
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	cp MOVE_METRONOME
	jr nz, .dont_change_last_move
	ld [wCurPlayerMove], a

.dont_change_last_move
	callfar AI_Switch
	ld a, 1
	ldh [hBattleTurn], a
	call SpikesDamage
	jp Battle_EnemyFirst

.use_move
	ld a, [wCurPlayerMove]
	call GetMoveEffect
	cp EFFECT_PRIORITY_HIT
	jr nz, .no_priority_player
	ld a, [wCurEnemyMove]
	call GetMoveEffect
	cp EFFECT_PRIORITY_HIT
	jr z, .equal_priority
	jp Battle_PlayerFirst

.no_priority_player
	ld a, [wCurEnemyMove]
	call GetMoveEffect
	cp EFFECT_PRIORITY_HIT
	jp z, Battle_EnemyFirst
	ld a, [wCurPlayerMove]
	call GetMoveEffect
	cp EFFECT_COUNTER
	jr nz, .no_counter_player
	ld a, [wCurEnemyMove]
	call GetMoveEffect
	cp EFFECT_COUNTER
	jr z, .equal_priority
	jp Battle_EnemyFirst

.no_counter_player
	ld a, [wCurEnemyMove]
	call GetMoveEffect
	cp EFFECT_COUNTER
	jp z, Battle_PlayerFirst

.equal_priority
	xor a
	ldh [hBattleTurn], a
	callfar GetUserItem
	push bc
	callfar GetOpponentItem
	pop de
	ld a, d
	cp HELD_QUICK_CLAW
	jr nz, .player_no_quick_claw
	ld a, b
	cp HELD_QUICK_CLAW
	jr z, .both_have_quick_claw
	call BattleRandom
	cp e
	jr nc, .speed_check
	jp Battle_PlayerFirst

.player_no_quick_claw
	ld a, b
	cp HELD_QUICK_CLAW
	jr nz, .speed_check
	call BattleRandom
	cp c
	jr nc, .speed_check
	jp Battle_EnemyFirst

.both_have_quick_claw
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr z, .player_2b
	call BattleRandom
	cp c
	jp c, Battle_EnemyFirst
	call BattleRandom
	cp e
	jp c, Battle_PlayerFirst
	jr .speed_check

.player_2b
	call BattleRandom
	cp e
	jp c, Battle_PlayerFirst
	call BattleRandom
	cp c
	jp c, Battle_EnemyFirst
	jr .speed_check

.speed_check
	ld de, wBattleMonSpeed
	ld hl, wEnemyMonSpeed
	ld c, 2
	call CompareBytes
	jr z, .speed_tie
	jp nc, Battle_PlayerFirst
	jr Battle_EnemyFirst

.speed_tie
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr z, .player_2c

	call BattleRandom
	cp 50 percent + 1
	jp c, Battle_PlayerFirst
	jr Battle_EnemyFirst

.player_2c
	call BattleRandom
	cp 50 percent + 1
	jr c, Battle_EnemyFirst
	jp Battle_PlayerFirst

TryEnemyFlee:
	ld a, [wBattleMode]
	dec a
	jr nz, .stay

	ld a, [wDebugFlags]
	bit DEBUG_BATTLE_F, a
	jr nz, .stay

	ld a, [wEnemySubStatus5]
	bit SUBSTATUS_CANT_RUN, a
	jr nz, .stay

	call BattleRandom
	cp 4 percent ; 10/256 chance for any Pokémon to run away
	jr nc, .stay
	scf
	ret

.stay
	and a
	ret

GetMoveEffect:
	dec a
	ld hl, Moves + MOVE_EFFECT
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	jp GetFarByte

Battle_EnemyFirst:
	ld a, 1
	ldh [hBattleTurn], a
	callfar AI_SwitchOrTryItem
	jr c, .switch_item
	callfar DoEnemyTurn
	call EndOpponentProtectEndureDestinyBond
	ld a, [wBattleEnded]
	and a
	ret nz
	call CheckFaint_Player
	jp z, HandlePlayerMonFaint

.switch_item
	call ResidualDamage
	jp z, HandleEnemyMonFaint
	call UpdateBattleHuds
	callfar DoPlayerTurn
	call EndOpponentProtectEndureDestinyBond
	ld a, [wBattleEnded]
	and a
	ret nz

	call CheckFaint_Enemy
	jp z, HandleEnemyMonFaint
	call ResidualDamage
	jp z, HandlePlayerMonFaint
	call UpdateBattleHuds
	call CheckForEndOfTrappingMoves
	xor a ; BATTLEPLAYERACTION_USEMOVE
	ld [wBattlePlayerAction], a
	jp BattleTurn

Battle_PlayerFirst:
	callfar DoPlayerTurn
	call EndOpponentProtectEndureDestinyBond
	ld a, [wBattleEnded]
	and a
	ret nz
	call CheckFaint_Enemy
	jp z, HandleEnemyMonFaint
	call ResidualDamage
	jp z, HandlePlayerMonFaint
	call UpdateBattleHuds
	ld a, 1
	ldh [hBattleTurn], a
	callfar AI_SwitchOrTryItem
	jr c, .switch_item
	callfar DoEnemyTurn
	call EndOpponentProtectEndureDestinyBond
	ld a, [wBattleEnded]
	and a
	ret nz
	call CheckFaint_Player
	jp z, HandlePlayerMonFaint

.switch_item
	call ResidualDamage
	jp z, HandleEnemyMonFaint
	call UpdateBattleHuds
	call CheckForEndOfTrappingMoves
	xor a
	ld [wFieldMoveSucceeded], a
	jp BattleTurn

EndOpponentProtectEndureDestinyBond:
	ld hl, wEnemySubStatus5
	ld de, wEnemySubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wPlayerSubStatus5
	ld de, wPlayerSubStatus1

.ok
	res SUBSTATUS_DESTINY_BOND, [hl]
	ld a, [de]
	res SUBSTATUS_PROTECT, a
	res SUBSTATUS_ENDURE, a
	ld [de], a
	ret

CheckFaint_Enemy:
	ld hl, wEnemyMonHP
	jr CheckIfHPIsZero

CheckFaint_Player:
	ld hl, wBattleMonHP
CheckIfHPIsZero:
	ld a, [hli]
	or [hl]
	ret

; Return z if the user fainted before
; or as a result of residual damage.
ResidualDamage:
	ld hl, wBattleMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, .ok

	ld hl, wEnemyMonStatus

.ok
	ld a, [hl]
	and 1 << PSN | 1 << BRN
	jr z, .did_psn_brn

	ld hl, HurtByPoisonText
	ld de, ANIM_PSN
	and 1 << BRN
	jr z, .got_anim
	ld hl, HurtByBurnText
	ld de, ANIM_BRN

.got_anim
	push de
	call PrintText
	pop de

	xor a
	ld [wNumHits], a
	call Call_PlayBattleAnim
	call GetEighthMaxHP
	ld hl, wPlayerSubStatus5
	ld de, wPlayerToxicCount
	ldh a, [hBattleTurn]
	and a
	jr z, .check_toxic
	ld hl, wEnemySubStatus5
	ld de, wEnemyToxicCount

.check_toxic
	bit SUBSTATUS_TOXIC, [hl]
	jr z, .did_toxic
; Multiplies the initial 1/8th health reduction by the toxic count
	ld a, [de]
	inc a
	ld [de], a
	ld hl, 0

.add
	add hl, bc
	dec a
	jr nz, .add
	ld b, h
	ld c, l

.did_toxic
	call SubtractHPFromUser

.did_psn_brn
	ld hl, wPlayerSubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, .check_seed
	ld hl, wEnemySubStatus4

.check_seed
	bit SUBSTATUS_LEECH_SEED, [hl]
	jr z, .not_seeded

	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	xor a
	ld [wNumHits], a
	ld de, ANIM_SAP
	call Call_PlayBattleAnim
	pop af
	ldh [hBattleTurn], a
	call GetEighthMaxHP
	call SubtractHPFromUser
	call RestoreHP
	ld hl, LeechSeedSapsText
	call PrintText

.not_seeded
	ld hl, wPlayerSubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, .check_nightmare
	ld hl, wEnemySubStatus1

.check_nightmare
	bit SUBSTATUS_NIGHTMARE, [hl]
	jr z, .not_nightmare
	xor a
	ld [wNumHits], a
	ld de, ANIM_IN_NIGHTMARE
	call Call_PlayBattleAnim
	call GetQuarterMaxHP
	call SubtractHPFromUser
	ld hl, HasANightmareText
	call PrintText

.not_nightmare
	ld hl, wPlayerSubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, .check_curse
	ld hl, wEnemySubStatus1

.check_curse
	bit SUBSTATUS_CURSE, [hl]
	jr z, .not_cursed
	xor a
	ld [wNumHits], a
	ld de, ANIM_IN_NIGHTMARE
	call Call_PlayBattleAnim
	call GetQuarterMaxHP
	call SubtractHPFromUser
	ld hl, HurtByCurseText
	call PrintText

.not_cursed
	ld hl, wPlayerScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .check_sandstorm
	ld hl, wEnemyScreens

.check_sandstorm
	bit SCREENS_SANDSTORM, [hl]
	jr z, .no_sandstorm
	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	xor a
	ld [wNumHits], a
	ld de, ANIM_IN_SANDSTORM
	call Call_PlayBattleAnim
	pop af
	ldh [hBattleTurn], a
	call GetEighthMaxHP
	call SubtractHPFromUser
	ld hl, SandstormHitsText
	call PrintText

.no_sandstorm
	ld hl, wBattleMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wEnemyMonHP

.got_hp
	ld a, [hli]
	or [hl]
	ret nz
	call UpdateBattleHuds
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

HandlePerishSong:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .player1

	xor a
	ldh [hBattleTurn], a
	call .do_it
	ld a, 1
	ldh [hBattleTurn], a
	call .do_it
	ret

.player1
	ld a, 1
	ldh [hBattleTurn], a
	call .do_it
	xor a
	ldh [hBattleTurn], a
	call .do_it
	ret

.do_it
	ld hl, wPlayerSubStatus1
	ld de, wPlayerPerishCount
	ldh a, [hBattleTurn]
	and a
	jr z, .got_count
	ld hl, wEnemySubStatus1
	ld de, wEnemyPerishCount

.got_count
	bit SUBSTATUS_PERISH, [hl]
	ret z
	ld a, [de]
	dec a
	ld [de], a
	ld [wTextDecimalByte], a
	push af
	push hl
	ld hl, PerishCountText
	call PrintText
	pop hl
	pop af
	ret nz
	res SUBSTATUS_PERISH, [hl]
	ldh a, [hBattleTurn]
	and a
	jr nz, .kill_enemy
	ld hl, wBattleMonHP
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, wPartyMon1HP
	ld a, [wCurBattleMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	xor a
	ld [hli], a
	ld [hl], a
	ret

.kill_enemy
	ld hl, wEnemyMonHP
	xor a
	ld [hli], a
	ld [hl], a
	ld a, [wBattleMode]
	dec a
	ret z
	ld hl, wOTPartyMon1HP
	ld a, [wCurOTMon]
	ld bc, PARTYMON_STRUCT_LENGTH
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

HandleSafeguard:
	ld a, [wPlayerScreens]
	bit SCREENS_SAFEGUARD, a
	jr z, .check_enemy
	ld hl, wPlayerSafeguardCount
	dec [hl]
	jr nz, .check_enemy
	res SCREENS_SAFEGUARD, a
	ld [wPlayerScreens], a
	xor a
	call .PrintSafeguardFadedText

.check_enemy
	ld a, [wEnemyScreens]
	bit SCREENS_SAFEGUARD, a
	ret z
	ld hl, wEnemySafeguardCount
	dec [hl]
	ret nz
	res SCREENS_SAFEGUARD, a
	ld [wEnemyScreens], a
	ld a, 1

.PrintSafeguardFadedText:
	ldh [hBattleTurn], a
	ld hl, BattleText_SafeguardFaded
	jp PrintText

BattleText_SafeguardFaded:
	text "<USER>を　つつんでいた"
	line "しんぴの　ベールが　なくなった！"
	prompt

HandleWeather:
	ld a, [wBattleWeather]
	and a ; WEATHER_NONE
	ret z

	dec a
	ld c, a
	ld hl, wWeatherCount
	dec [hl]
	ld hl, .WeatherMessages
	jr nz, .PrintWeatherMessage

	xor a
	ld [wBattleWeather], a
	ld hl, .WeatherEndedMessages

.PrintWeatherMessage:
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	ret

.WeatherMessages:
	dw BattleText_RainContinuesToFall
	dw BattleText_TheSunlightIsStrong

.WeatherEndedMessages:
	dw BattleText_TheRainStopped
	dw BattleText_TheSunlightFaded

BattleText_RainContinuesToFall:
	text "あめが　ふりつずいている"
	prompt

BattleText_TheSunlightIsStrong:
	text "ひざしが　つよい"
	prompt

BattleText_TheRainStopped:
	text "あめが　やんだ！"
	prompt

BattleText_TheSunlightFaded:
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

; Clears SUBSTATUS_USING_TRAPPING_MOVE if a Pokémon's Rollout count is zero.
CheckForEndOfTrappingMoves:
	ld a, [wPlayerRolloutCount]
	and a
	jr nz, .check_enemy
	ld hl, wPlayerSubStatus3
	res SUBSTATUS_USING_TRAPPING_MOVE, [hl]

.check_enemy
	ld a, [wEnemyRolloutCount]
	and a
	ret nz
	ld hl, wEnemySubStatus3
	res SUBSTATUS_USING_TRAPPING_MOVE, [hl]
	ret

HandleEnemyMonFaint:
	xor a
	ld [wWhichMonFaintedFirst], a
	call UpdateBattleStateAndExperienceAfterEnemyFaint
	call CheckPlayerPartyForFitMon
	ld a, d
	and a
	jp z, LostBattle

	ld hl, wBattleMonHP
	ld a, [hli]
	or [hl]
	call nz, UpdatePlayerHUD

	ld c, 60
	call DelayFrames

	ld a, [wBattleMode]
	dec a
	ret z

	call CheckEnemyTrainerDefeated
	jp z, WinTrainerBattle

	ld hl, wBattleMonHP
	ld a, [hli]
	or [hl]
	jr nz, .notfainted

	call AskUseNextPokemon
	ret c
	call ForcePlayerMonChoice

.notfainted
	ld a, 1
	ld [wBattlePlayerAction], a
	call HandleEnemySwitch
	jp z, WildFled_EnemyFled_LinkBattleCanceled

	xor a
	ld [wFieldMoveSucceeded], a
	jp BattleTurn

UpdateBattleStateAndExperienceAfterEnemyFaint:
	call UpdateBattleMonInParty
	ld a, [wBattleMode]
	dec a
	jr z, .wild

	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1HP
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	xor a
	ld [hli], a
	ld [hl], a

.wild
	ld hl, wPlayerSubStatus3
	res SUBSTATUS_IN_LOOP, [hl]
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
	ld hl, wLastPlayerCounterMove
	ld [hli], a
	ld [hl], a

	hlcoord 12, 5
	decoord 12, 6
	call MonFaintedAnimation
	hlcoord 1, 0
	lb bc, 4, 10
	call ClearBox
	
	ld a, [wBattleMode]
	dec a
	jr z, .wild2

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
	jr .trainer

.wild2
	call StopDangerSound
	ld a, 0
	call PlayVictoryMusic

.trainer
	ld hl, wBattleMonHP
	ld a, [hli]
	or [hl]
	jr nz, .player_mon_did_not_faint
	ld a, [wWhichMonFaintedFirst]
	and a
	jr nz, .player_mon_did_not_faint
	call UpdateFaintedPlayerMon

.player_mon_did_not_faint
	call CheckPlayerPartyForFitMon
	ld a, d
	and a
	ret z
	ld hl, EnemyMonFainted
	call PrintText
	call EmptyBattleTextbox
	call BackUpTilesToBuffer
	xor a
	ld [wBattleResult], a
	ld b, ITEM_EXP_ALL_RED
	call Call_GetItemAmount
	push af
	jr z, .skip_exp
	ld hl, wEnemyMonBaseStats
	ld b, wEnemyMonEnd - wEnemyMonBaseStats

.loop
	srl [hl]
	inc hl
	dec b
	jr nz, .loop

.skip_exp
	xor a ; FALSE
	ld [wBoostExpByExpAll], a
	call GiveExperiencePoints
	pop af
	ret z

	ld a, TRUE
	ld [wBoostExpByExpAll], a
	ld a, [wPartyCount]
	ld b, 0

.gain_exp_loop
	scf
	rl b
	dec a
	jr nz, .gain_exp_loop

	ld a, b
	ld [wBattleParticipantsNotFainted], a
	jp GiveExperiencePoints

EnemyMonFainted:
	text "てきの　@"
	text_from_ram wEnemyMonNickname
	text "は　たおれた！"
	prompt

; TODO: Does it really stop the Danger Sound? wBattleLowHealthAlarm doesn't appear to be read anywhere else...
StopDangerSound:
	inc a
	ld [wBattleLowHealthAlarm], a
	ret

CheckEnemyTrainerDefeated:
	ld a, [wOTPartyCount]
	ld b, a
	xor a
	ld hl, wOTPartyMon1HP
	ld de, PARTYMON_STRUCT_LENGTH

.loop:
	or [hl]
	inc hl
	or [hl]
	dec hl
	add hl, de
	dec b
	jr nz, .loop

	and a
	ret

HandleEnemySwitch:
	ld hl, wEnemyHPPal
	ld e, HP_BAR_LENGTH_PX
	call UpdateHPPal
	callfar EnemySwitch_TrainerHud
	ld a, [wLinkMode]
	and a
	jr z, .not_linked

	call LinkBattleSendRecieveAction
	ld a, [wOtherPlayerLinkAction]
	cp BATTLEACTION_FORFEIT
	ret z

	call ReloadTilesFromBuffer

.not_linked
	call EnemySwitch
	call NewEnemyMonStatus
	ld a, 1
	ldh [hBattleTurn], a
	call SpikesDamage
	xor a
	ld [wEnemyMoveStruct], a
	ld [wFieldMoveSucceeded], a
	ld [wEnemyTurnsTaken], a
	inc a
	ret

WinTrainerBattle:
	call StopDangerSound
	ld b, MUSIC_NONE
	ld a, [wUnused_GymLeaderNo]
	and a
	jr nz, .gym_leader
	ld b, MUSIC_VICTORY_TRAINER

.gym_leader
	ld a, [wTrainerClass]
	cp TRAINER_OPP_RIVAL3_RED
	jr nz, .notrival_red
	ld b, MUSIC_NONE
	ld hl, wDebugFlags ; wStatusFlags7
	set DEBUG_FIELD_F, [hl] ; BIT_NO_MAP_MUSIC

.notrival_red
	ld a, [wLinkMode]
	and a
	ld a, b
	call z, PlayVictoryMusic
	callfar Battle_GetTrainerName
	ld hl, BattleText_EnemyWasDefeated
	call PrintText

	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	ret z

	call BattleWinSlideInEnemyTrainerFrontpic
	ld c, 40
	call DelayFrames

	ld a, [wOtherTrainerClass]
	cp TRAINER_RIVAL
	jr nz, .notrival
	ld hl, RivalLossText
	call PrintText
	callfar HealParty

.notrival
; No win/loss text implemented in this build, except for the rival's.
	ld a, [wBattleMonItem]
	ld b, a
	callfar GetItemHeldEffect
	ld a, b
	cp HELD_AMULET_COIN
	jr nz, .dont_double_reward

	ld hl, wBattleReward + 2
	sla [hl]
	dec hl
	rl [hl]
	dec hl
	rl [hl]
	jr nc, .not_overflow

	ld a, $ff
	ld [hli], a
	ld [hli], a
	ld [hl], a

.dont_double_reward
.not_overflow
	ld de, wMoney + 2
	ld hl, wBattleReward + 2
	ld c, 3
	and a
; Add battle money to account
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
	text "<PLAYER>は　しょうきんとして"
	line "@"
	deciram wBattleReward, 3, 6
	text "円　てにいれた！"
	prompt

BattleText_EnemyWasDefeated:
	text_from_ram wOTClassName
	text "の　@"
	text_from_ram wStringBuffer1
	text_start
	line "との　しょうぶに　かった！"
	prompt

RivalLossText:
	text "<RIVAL>『あれー？"
	line "おまえの　#に"
	cont "すりゃあ　よかったのかなあ？"
	prompt

PlayVictoryMusic:
	push de
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld de, MUSIC_VICTORY_TRAINER
	call PlayMusic
	pop de
	ret

HandlePlayerMonFaint:
	ld a, 1
	ld [wWhichMonFaintedFirst], a
	call UpdateFaintedPlayerMon
	call CheckPlayerPartyForFitMon
	ld a, d
	and a
	jp z, LostBattle
	ld hl, wEnemyMonHP
	ld a, [hli]
	or [hl]
	jr nz, .notfainted
	call UpdateBattleStateAndExperienceAfterEnemyFaint
	ld a, [wBattleMode]
	dec a
	ret z
	call CheckEnemyTrainerDefeated
	jp z, WinTrainerBattle

.notfainted
	call AskUseNextPokemon
	ret c

	call ForcePlayerMonChoice
	jp nz, BattleTurn
	ld a, BATTLEPLAYERACTION_USEITEM
	ld [wBattlePlayerAction], a

	call HandleEnemySwitch
	jp z, WildFled_EnemyFled_LinkBattleCanceled

	xor a
	ld [wFieldMoveSucceeded], a
	jp BattleTurn

UpdateFaintedPlayerMon:
	ld a, [wCurBattleMon]
	ld c, a
	ld hl, wBattleParticipantsNotFainted
	ld b, RESET_FLAG
	predef SmallFarFlagAction
	ld hl, wEnemySubStatus3
	res SUBSTATUS_IN_LOOP, [hl]
	ld a, [wLowHealthAlarmBuffer]
	bit DANGER_ON_F, a
	jr z, .no_low_health_alarm

	ld a, $ff
	ld [wLowHealthAlarmBuffer], a
	call WaitSFX

.no_low_health_alarm
	ld hl, wEnemyDamageTaken
	ld [hli], a
	ld [hl], a
	ld [wBattleMonStatus], a
	ld [wBattleMonStatus + 1], a
	call UpdateBattleMonInParty
	hlcoord 9, 7
	lb bc, 5, 11
	call ClearBox
	hlcoord 1, 10
	decoord 1, 11
	call MonFaintedAnimation
	ld a, LOSE
	ld [wBattleResult], a
	ld a, [wWhichMonFaintedFirst]
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

AskUseNextPokemon:
	call EmptyBattleTextbox
	call BackUpTilesToBuffer
; We don't need to be here if we're in a Trainer battle,
; as that decision is made for us.
	ld a, [wBattleMode]
	and a
	dec a
	ret nz
	ld hl, BattleText_UseNextMon
	call PrintText

.loop
	lb bc, 1, 7
	call PlaceYesNoBox
	ld a, [wMenuCursorY]
	jr c, .pressed_b
	and a
	ret

.pressed_b
	ld a, [wMenuCursorY]
	cp 1 ; YES
	jr z, .loop
	ld hl, wPartyMon1Speed
	ld de, wEnemyMonSpeed
	jp TryToRunAwayFromBattle

BattleText_UseNextMon:
	text "つぎの　#をつかいますか？"
	done

ForcePlayerMonChoice:
	call LoadStandardMenuHeader
	ld a, PARTYMENUACTION_SWITCH
	ld [wPartyMenuActionText], a
	predef OpenPartyMenu_ClearGraphics

.pick
	jr nc, .picked
.not_fit_to_fight
	predef OpenPartyMenu
	jr .pick

.picked
	call CheckIfCurPartyMonIsFitToFight
	jr z, .not_fit_to_fight
	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	jr nz, .skip_link
; BUG TODO: Doesn't this result in invalid wBattlePlayerAction arguments?
	inc a ; BATTLEPLAYERACTION_USEITEM
	ld [wBattlePlayerAction], a
	call LinkBattleSendRecieveAction

.skip_link
	xor a ; BATTLEPLAYERACTION_USEMOVE
	ld [wBattlePlayerAction], a
	call ClearSprites
	ld a, [wCurPartyMon]
	ld [wCurBattleMon], a
	ld c, a
	ld hl, wBattleParticipantsNotFainted
	ld b, SET_FLAG
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

	call SendOutMonText
	call NewBattleMonStatus
	call SendOutPlayerMon
	call EmptyBattleTextbox
	call BackUpTilesToBuffer

	xor a
	ldh [hBattleTurn], a
	call SpikesDamage
	ld hl, wEnemyMonHP
	ld a, [hli]
	or [hl]
	ret

LostBattle:
	ld a, [wLinkMode]
	and a
	jr nz, .link

	ld a, [wOtherTrainerClass]
	cp TRAINER_RIVAL
	jr nz, .not_rival

	ld hl, wTileMap
	lb bc, 8, 21
	call ClearBox
	call BattleWinSlideInEnemyTrainerFrontpic

	ld c, 40
	call DelayFrames

	ld hl, RivalWinText
	call PrintText
	callfar HealParty
	ret

.link
.not_rival
; Grayscale
	ld b, SGB_BATTLE_GRAYSCALE
	call GetSGBLayout
	ld hl, OutOfUsableMonsText

	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	jr nz, .not_link
	ld hl, LostAgainstText

.not_link
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

LostAgainstText:
	text_from_ram wOTClassName
	text "との"
	line "しょうぶに　まけた！"
	prompt

MonFaintedAnimation:
	ld a, [wJoypadFlags]
	push af
	set 6, a ; JOYPAD_DISABLE_MON_FAINT_F
	ld [wJoypadFlags], a

	ld b, 7

.OuterLoop:
	push bc
	push de
	push hl
	ld b, 6

.InnerLoop:
	push bc
	push hl
	push de
	ld bc, 7
	call CopyBytes
	pop de
	pop hl
	ld bc, -SCREEN_WIDTH
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
	jr nz, .InnerLoop

	ld bc, SCREEN_WIDTH
	add hl, bc
	ld de, .Spaces
	call PlaceString
	ld c, 2
	call DelayFrames
	pop hl
	pop de
	pop bc
	dec b
	jr nz, .OuterLoop
	pop af
	ld [wJoypadFlags], a
	ret

.Spaces:
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
	ldh a, [hSpriteWidth]
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
	ld hl, wLastPlayerCounterMove
	ld [hli], a
	ld [hl], a
	dec a
	ld [wEnemyItemState], a
	ld hl, wPlayerSubStatus3
	res SUBSTATUS_USING_TRAPPING_MOVE, [hl]

	hlcoord 18, 0
	ld a, 8
	call SlideBattlePicOut
	call EmptyBattleTextbox
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

	ld hl, BattleText_MonIsAlreadyOut_0f
	call PrintText

.fainted
	predef OpenPartyMenu
	jr .pick

.notout
	call CheckIfCurPartyMonIsFitToFight
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
	call Call_PlayBattleAnim

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
	jp PlayerSwitch

; BUG: They forgot to terminate the line immediately after StringBuffer1.
; This makes the game halt the script early and throw up an error handler,
; due to reading the start of the following 'text' line as a <NULL> character.
TrainerAboutToUseText:
	text_from_ram wOTClassName
	text "の　@"
	text_from_ram wStringBuffer1
	text "は"
	line
	text_from_ram wEnemyMonNickname
	text "を　くりだそうと　している"

	para "<PLAYER>も　#を"
	line "とりかえますか？"
	done

TrainerSentOutText:
	text_from_ram wOTClassName
	text "の　@"
	text_from_ram wStringBuffer1
	text "は"
	line "@"
	text_from_ram wEnemyMonNickname
	text "を　くりだした！"
	done

NewEnemyMonStatus:
	xor a
	ld hl, wLastEnemyCounterMove
	ld [hli], a
	ld [hl], a
	ld hl, wEnemySubStatus1
rept 4
	ld [hli], a
endr
	ld [hl], a
	ld [wEnemyDisableCount], a
	ld [wEnemyFuryCutterCount], a
	ld [wEnemyDisabledMove], a
	ld [wEnemyMinimized], a
	ret

CheckPlayerPartyForFitMon:
; Has the player any mon in his Party that can fight?
	ld a, [wPartyCount]
	ld e, a
	xor a
	ld hl, wPartyMon1HP
	ld bc, PARTYMON_STRUCT_LENGTH - 1
.loop
	or [hl]
	inc hl
	or [hl]
	add hl, bc
	dec e
	jr nz, .loop
	ld d, a
	ret

CheckIfCurPartyMonIsFitToFight:
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1HP
	ld bc, PARTYMON_STRUCT_LENGTH
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

TryToRunAwayFromBattle:
	ld a, [wBattleType]
	cp BATTLETYPE_DEBUG
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
	ld hl, BattleText_UserFledUsingAStringBuffer1
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
	call CompareBytes
	jr nc, .can_escape
	
	xor a
	ldh [hMultiplicand], a
	ld a, 32
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
	ld a, [wNumFleeAttempts]
	ld c, a
.loop
	dec c
	jr z, .cant_escape_2
	ld b, 30
	ldh a, [hMultiplicand + 2]
	add b
	ldh [hMultiplicand + 2], a
	jr c, .can_escape
	jr .loop

.cant_escape_2
	call BattleRandom
	ld b, a
	ldh a, [hMultiplicand + 2]
	cp b
	jr nc, .can_escape
	ld a, BATTLEPLAYERACTION_USEITEM
	ld [wBattlePlayerAction], a
.cannot_escape
	ld hl, BattleText_CantEscape
	jr .print_text

.trainer_battle
	ld hl, BattleText_TheresNoEscapeFromTrainerBattle
.print_text
	call PrintText
	ld a, TRUE
	ld [wFailedToFlee], a
	call BackUpTilesToBuffer
	and a
	ret

.can_escape
	ld a, [wLinkMode]
	and a
	ld a, DRAW
	jr z, .fled
	call BackUpTilesToBuffer
	xor a ; BATTLEPLAYERACTION_USEMOVE
	ld [wBattlePlayerAction], a
	ld a, BATTLEACTION_FORFEIT
	ld [wCurMoveNum], a
	call LinkBattleSendRecieveAction
	call ReloadTilesFromBuffer

	ld a, [wOtherPlayerLinkAction]
	cp BATTLEACTION_FORFEIT
	ld a, DRAW
	jr z, .fled
	dec a
.fled
	ld [wBattleResult], a
	push de
	ld de, SFX_RUN
	call WaitPlaySFX
	pop de
	call WaitSFX
	ld hl, BattleText_GotAwaySafely
	call PrintText
	call WaitSFX
	call BackUpTilesToBuffer
	scf
	ret

BattleText_CantEscape:
	text "にげられない！"
	prompt

BattleText_TheresNoEscapeFromTrainerBattle:
	text "ダメだ！"
	line "しょうぶの　さいちゅうに"
	cont "あいてに　せなかは　みせられない！"
	prompt

BattleText_GotAwaySafely:
	text "うまく　にげきれた！"
	prompt

BattleText_UserFledUsingAStringBuffer1:
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
	call Call_PlayBattleAnim

; mon on the left side
	ld a, $f0
	ld [wCryTracks], a
	ld a, [wCurPartySpecies]
	call PlayStereoCry
	call UpdatePlayerHUD
	ret

NewBattleMonStatus:
	xor a
	ld hl, wLastPlayerCounterMove
	ld [hli], a
	ld [hl], a
	ld hl, wPlayerSubStatus1
rept 4
	ld [hli], a
endr
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
	call Call_PlayBattleAnim
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

; Only handles HP-healing items at this point.
; Status-healing items aren't handled except at the moment when the target is afflicted.
HandleHealingItems:
	ldh a, [hSerialConnectionStatus]
	cp 1
	jr z, .player1
	call .DoPlayer
	call .DoEnemy
	ret

.player1:
	call .DoEnemy
	call .DoPlayer
	ret

.DoPlayer:
	xor a
	ldh [hBattleTurn], a
	call HandleHPHealingItem
	ld a, 1
	ldh [hBattleTurn], a
	call HandleHPHealingItem
	ret

.DoEnemy:
	ld a, 1
	ldh [hBattleTurn], a
	call HandleHPHealingItem
	xor a
	ldh [hBattleTurn], a
	call HandleHPHealingItem
	ret

HandleHPHealingItem:
	callfar GetOpponentItem
	ld a, b
	cp HELD_BERRY
	ret nz
	ld de, wEnemyMonHP + 1
	ld hl, wEnemyMonMaxHP + 1
	ldh a, [hBattleTurn]
	and a
	jr z, .go
	ld de, wBattleMonHP + 1
	ld hl, wBattleMonMaxHP + 1

.go
; If, and only if, Pokemon's HP is less than half max, use the item.
; Store current HP in Buffer 3/4
	push bc
	ld a, [de]
	ld [wHPBuffer2], a
	add a
	ld c, a
	dec de
	ld a, [de]
	inc de
	ld [wHPBuffer2 + 1], a
	adc a
	ld b, a
	ld a, c
	cp [hl]
	dec hl
	ld a, b
	sbc [hl]
	pop bc
	ret nc

	; store max HP in wHPBuffer1
	ld a, [hli]
	ld [wHPBuffer1 + 1], a
	ld a, [hl]
	ld [wHPBuffer1], a
	ld a, [de]
	add c
	ld [wHPBuffer3], a
	ld c, a
	dec de
	ld a, [de]
	adc 0
	ld [wHPBuffer3 + 1], a
	ld b, a
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	jr nc, .okay
	ld a, [hli]
	ld [wHPBuffer3 + 1], a
	ld a, [hl]
	ld [wHPBuffer3], a

.okay
	ld a, [wHPBuffer3 + 1]
	ld [de], a
	inc de
	ld a, [wHPBuffer3]
	ld [de], a
	call ItemRecoveryAnim
	ldh a, [hBattleTurn]
	ld [wWhichHPBar], a
	and a
	hlcoord 2, 2
	jr z, .got_hp_bar_coords
	hlcoord 10, 9

.got_hp_bar_coords
	ld [wWhichHPBar], a
	predef UpdateHPBar

	call UpdateBattleHuds
	callfar GetOpponentItem
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	callfar ConsumeHeldItem
	ld hl, RecoveredUsingText
	jp PrintText

ItemRecoveryAnim:
	ld a, MOVE_RECOVER
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

RecoveredUsingText:
	text "<TARGET>は　そうびしていた"
	line "@"
	text_from_ram wStringBuffer1
	text "で　かいふくした！"
	prompt

HandleStatBoostingHeldItems:
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .player1
	call .DoPlayer
	call .DoEnemy
	ret

.player1
	call .DoEnemy
	call .DoPlayer
	ret

.DoPlayer:
	ld hl, wPartyMon1Item
	ld a, [wCurBattleMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld bc, wBattleMonItem
	ld de, wPlayerMoveStruct
	ld a, 0
	call .HandleItem
	ret

.DoEnemy:
	ld hl, wOTPartyMon1Item
	ld a, [wCurOTMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld bc, wEnemyMonItem
	ld de, wEnemyMoveStruct
	ld a, 1
	call .HandleItem
	ret

.HandleItem:
	ldh [hBattleTurn], a
	push hl
	push bc
	ld a, [bc]
	ld b, a
	callfar GetItemHeldEffect
	ld hl, HeldStatUpItems
.loop:
	ld a, [hli]
	cp -1
	jr z, .finish
	inc hl
	cp b
	jr nz, .loop
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
; Play the Growth animation when using the item.
	ld a, [de]
	push af
	ld a, MOVE_GROWTH
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

.finish
	pop bc
	pop hl
	ret

INCLUDE "data/battle/held_stat_up.inc"

UseItemFailedText:
	text "<USER>が　そうびしていた"
	line "@"
	text_from_ram wStringBuffer1
	text "が　さどうした！"
	prompt

UpdateBattleHuds::
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
	cp '@'
	jr z, .done
	inc de
	ld a, [de]
	cp '@'
	jr z, .done
	dec hl
	dec b
	jr nz, .loop
.done:
	pop de
	ret

BattleMenu:
	call ReloadTilesFromBuffer
	ld a, [wBattleType]
	and a
	jr nz, .ok
	call UpdateBattleHuds
	call EmptyBattleTextbox
	call BackUpTilesToBuffer
.ok

.loop
	callfar LoadBattleMenu
	jr c, .loop
	ld a, [wStartmenuCursor]
	cp 1
	jp z, BattleMenu_Fight
	cp 2
	jp z, BattleMenu_Pack
	cp 3
	jp z, BattleMenu_PKMN
	cp 4
	jp z, BattleMenu_Run
	jr .loop

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
	call StopUsingTrappingMove
	ld a, [wWildMon]
	and a
	jr nz, .run
	call CloseWindow
	call BackUpTilesToBuffer
	call UpdateBattleHuds
	call WaitBGMap
	call ClearWindowData
	call SetPalettes
	and a
	ret

.run
	xor a
	ld [wWildMon], a
	ld a, DRAW
	ld [wBattleResult], a
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
	jp BattleMenu

.ItemsCantBeUsed
	ld hl, BattleText_ItemsCantBeUsedHere
	call PrintText
	jp BattleMenu

BattleText_ItemsCantBeUsedHere:
	text "ここでは　どうぐを"
	line "つかうことは　できません"
	prompt

StopUsingTrappingMove:
	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_USING_TRAPPING_MOVE, a
	jr z, .done
	ld hl, wPlayerRolloutCount
	dec [hl]
	jr nz, .done
	ld hl, wPlayerSubStatus3
	res SUBSTATUS_USING_TRAPPING_MOVE, [hl]
.done
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

.BattleMenuPKMN_ReturnFromStats:
	call ExitMenu
	call LoadStandardMenuHeader
	xor a
	ld [wPartyMenuActionText], a
	predef OpenPartyMenu_ClearGraphics
	jp c, .Cancel
	jp .loop
.BattleMenuPKMN_Loop:
	hlcoord 11, 11
	ld bc, $81
	ld a, '　'
	call ByteFill
	xor a
	ld [wPartyMenuActionText], a
	predef OpenPartyMenu
	jr c, .Cancel

.loop
	callfar FreezeMonIcons
	callfar BattleMonMenu
	jr c, .BattleMenuPKMN_Loop
	call PlaceHollowCursor
	ld a, [wMenuCursorY]
	cp 1 ; SWITCH
	jp z, .TryPlayerSwitch
	cp 2 ; STATS
	jr z, .Stats
	cp 3 ; CANCEL
	jr z, .Cancel
	jr .loop

.Stats:
	call .Battle_StatsScreen
	jp .BattleMenuPKMN_ReturnFromStats

.Cancel:
	call ClearSprites
	call ClearPalettes
	call _LoadHPBar
	call CloseWindow
	call BackUpTilesToBuffer
	call GetMemSGBLayout
	call SetPalettes
	jp BattleMenu

; TODO: Do the tile identifiers look right (are they not vFrontPic, vBackPic)?...
.Battle_StatsScreen:
	call DisableLCD

	ld hl, vChars2 tile $31
	ld de, vChars0
	ld bc, $11 tiles
	call CopyBytes

	ld hl, vChars2
	ld de, vChars0 tile $11
	ld bc, $31 tiles
	call CopyBytes

	call EnableLCD
	call ClearSprites
	call LowVolume
	xor a ; PARTYMON
	ld [wMonType], a
	ld hl, wPartyMon1Species
	predef StatsScreenMain
	call MaxVolume

	call DisableLCD

	ld hl, vChars0
	ld de, vChars2 tile $31
	ld bc, $11 tiles
	call CopyBytes

	ld hl, vChars0 tile $11
	ld de, vChars2
	ld bc, $31 tiles
	call CopyBytes

	call EnableLCD
	ret

.TryPlayerSwitch:
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_CANT_RUN, a
	jr z, .not_trapped

	ld hl, BattleText_MonCantBeRecalled
	call PrintText
	jp .BattleMenuPKMN_Loop

.not_trapped
	ld a, [wCurBattleMon]
	ld d, a
	ld a, [wCurPartyMon]
	cp d
	jr nz, .try_switch
	ld hl, BattleText_MonIsAlreadyOut_0f
	call PrintText
	jp .BattleMenuPKMN_Loop

.try_switch
	call CheckIfCurPartyMonIsFitToFight
	jp z, .BattleMenuPKMN_Loop
	ld a, 1
	ld [wFieldMoveSucceeded], a
	call ClearPalettes
	call ClearSprites
	call _LoadHPBar
	call CloseWindow
	call GetMemSGBLayout
	call SetPalettes

PlayerSwitch:
	ld a, [wLinkMode]
	and a
	jr z, .not_linked
	call LinkBattleSendRecieveAction

.not_linked
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
	ld b, SET_FLAG
	push bc
	ld hl, wBattleParticipantsNotFainted
	predef SmallFarFlagAction

	pop bc
	ld hl, wBattleParticipantsIncludingFainted
	predef SmallFarFlagAction

	call LoadBattleMonFromParty
	call ApplyStatMods
	call SendOutMonText
	call NewBattleMonStatus
	call SendOutPlayerMon
	call EmptyBattleTextbox
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
	call EmptyBattleTextbox
	call BackUpTilesToBuffer
	xor a
	ldh [hBattleTurn], a
	call SpikesDamage
	ret

BattleText_MonIsAlreadyOut_0f:
	text_from_ram wBattleMonNickname
	text "はもうでています"
	prompt

BattleText_MonCantBeRecalled:
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
	call TryToRunAwayFromBattle
	ld a, FALSE
	ld [wFailedToFlee], a
	ret c
	ld a, [wFieldMoveSucceeded]
	and a
	ret nz
	jp BattleMenu

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
	cp LINK_COLOSSEUM
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
	bit DEBUG_BATTLE_F, a
	jr nz, .interpret_joypad
	
	call MoveInfoBox
	ld a, [wSelectedSwapPosition]
	and a
	jr z, .interpret_joypad
	hlcoord 1, 18 - (NUM_MOVES * 2)
	dec a
	ld bc, SCREEN_WIDTH * 2
	call AddNTimes
	ld [hl], '▷'

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
	ld [wCurPlayerMove], a
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
	ld [wCurPlayerMove], a
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
	ld [wCurPlayerMove], a

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
	ld [hl], '／'
	hlcoord 14, 16
	ld [hl], '／'
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

ParseEnemyAction:
	ld a, [wLinkMode]
	and a
	jr z, .not_linked
	call BackUpTilesToBuffer
	ld a, [wBattlePlayerAction]
	and a
	call z, LinkBattleSendRecieveAction
	call ReloadTilesFromBuffer

	ld a, [wOtherPlayerLinkAction]
	cp BATTLEACTION_STRUGGLE
	jp z, .struggle
	cp BATTLEACTION_SKIPTURN
	jr z, .skip_turn
	cp BATTLEACTION_SWITCH1
	jp nc, .locked_in
	
	ld [wCurEnemyMoveNum], a
	ld c, a
	ld hl, wEnemyMonMoves
	ld b, 0
	add hl, bc
	ld a, [hl]
	jp .finish

.not_linked
	ld hl, wEnemySubStatus5
	bit SUBSTATUS_ENCORED, [hl]
	jr z, .not_encored
	ld a, [wEnemyEncoreCount]
	dec a
	ld [wEnemyEncoreCount], a
	jr nz, .encored2

.clear_encore
	ld hl, wEnemySubStatus5
	res SUBSTATUS_ENCORED, [hl]
	ld a, 1
	ldh [hBattleTurn], a
	ld hl, BattleText_TargetsEncoreEnded
	call PrintText
	jr .not_encored

.encored2
	ld a, [wLastEnemyCounterMove]
	and a
	jr z, .clear_encore

	ld hl, wEnemyMonPP
	ld a, [wCurEnemyMoveNum]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	and PP_MASK
	jr z, .clear_encore

	ld a, [wLastEnemyCounterMove]
	jp .finish

.not_encored
	ld a, [wEnemySubStatus4]
	and ((1 << SUBSTATUS_RECHARGE) | (1 << SUBSTATUS_RAGE))
	jp nz, .locked_in

	ld hl, wEnemySubStatus3
	ld a, [hl]
	and ((1 << SUBSTATUS_RAMPAGE) | (1 << SUBSTATUS_CHARGED))
	jp nz, .locked_in

	ld hl, wEnemySubStatus1
	bit SUBSTATUS_ROLLOUT, [hl]
	jp nz, .locked_in

	ld a, [wEnemySubStatus3]
	and ((1 << SUBSTATUS_USING_TRAPPING_MOVE) | (1 << SUBSTATUS_BIDE))
	jp nz, .locked_in
	
	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_USING_TRAPPING_MOVE, a
	jr .continue

.skip_turn
	ld a, $ff
	jr .finish

.continue
	ld hl, wEnemyMonPP
	ld bc, 0
.loop
	inc b
	ld a, b
	cp NUM_MOVES + 1
	jr z, .finish_pp_check
	ld a, [hli]
	and PP_MASK
	jr z, .loop
	ld a, [wEnemyDisableCount]
	swap a
	and $f
	cp b
	jr z, .loop
	inc c
	jr .loop

.finish_pp_check
	ld a, c
	and a
	jr z, .struggle

	ld a, [wBattleMode]
	dec a ; WILD_BATTLE
	jr z, .wild_loop

; Overwrites wTrainerClass in order to give trainers all the AI layers.
	ld a, 1
	ld [wTrainerClass], a
	callfar AIChooseMove
	jr .skip_load

.wild_loop
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
	jr z, .wild_loop

	ld a, [hl]
	and a
	jr z, .wild_loop

	ld hl, wEnemyMonPP
	add hl, bc
	ld b, a
	ld a, [hl]
	and a
	jr z, .wild_loop

	ld a, c
	ld [wCurEnemyMoveNum], a
	ld a, b

.finish
	ld [wCurEnemyMove], a
.skip_load
	ld a, 1
	ldh [hBattleTurn], a
	callfar UpdateMoveData
	ld a, [wEnemyMoveStructEffect]
	cp EFFECT_FURY_CUTTER
	ret z
	xor a
	ld [wEnemyFuryCutterCount], a
	ret

.struggle
	ld a, MOVE_STRUGGLE
	jr .finish

.locked_in
	xor a
	ld [wEnemyFuryCutterCount], a
	ret

LinkBattleSendRecieveAction:
	ld a, $ff
	ld [wOtherPlayerLinkAction], a
	ld a, [wBattlePlayerAction]
	and a ; BATTLEPLAYERACTION_USEMOVE?
	jr nz, .switch

	ld a, [wCurPlayerMove]
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
	text "<TARGET>の"
	line "アンコールじょうたいが　とけた！"
	prompt

; The Counter code from Generation I, completely unchanged.
Old_HandleCounterMove:
	ldh a, [hBattleTurn]
	and a
	ld hl, wCurEnemyMove
	ld de, wEnemyMoveStructPower
	ld a, [wCurPlayerMove]
	jr z, .next
	ld hl, wCurPlayerMove
	ld de, wPlayerMoveStructPower
	ld a, [wCurEnemyMove]

.next
	cp MOVE_COUNTER
	ret nz ; return if not using Counter
	ld a, 1
	ld [wAttackMissed], a ; initialize the move missed variable to true (it is set to false below if the move hits)
	ld a, [hl]
	cp MOVE_COUNTER
	ret z ; miss if the opponent's last selected move is Counter.
	ld a, [de]
	and a
	ret z ; miss if the opponent's last selected move's Base Power is 0.
	inc de
	ld a, [de]
	and a
	jr z, .counterableType
	cp TYPE_FIGHTING
	jr z, .counterableType
	xor a
	ret

.counterableType
	ld hl, wCurDamage
	ld a, [hli]
	or [hl]
	ret z ; If we made it here, Counter still misses if the last move used in battle did no damage to its target.
	      ; wDamage is shared by both players, so Counter may strike back damage dealt by the Counter user itself
	      ; if the conditions meet, even though 99% of the times damage will come from the target.
; if it did damage, double it
	ld a, [hl]
	add a
	ld [hld], a
	ld a, [hl]
	adc a
	ld [hl], a
	jr nc, .noCarry
	ld a, $ff
	ld [hli], a
	ld [hl], a

.noCarry:
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

; Leftover from Generation I.
Old_SwapPlayerAndEnemyLevels:
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

BattleWinSlideInEnemyTrainerFrontpic:
	xor a
	ld [wTempEnemyMonSpecies], a
	ld b, SGB_BATTLE_COLORS
	call GetSGBLayout
; Should be a call instead
	callfar GetTrainerPic
	hlcoord 19, 0
	ld c, 0

.outer_loop
	inc c
	ld a, c
	cp 7
	ret z
	ld d, 0
	push bc
	push hl

.inner_loop
	call .CopyColumn
	inc hl
	ld a, 7
	add d
	ld d, a
	dec c
	jr nz, .inner_loop
	ld c, 4
	call DelayFrames
	pop hl
	pop bc
	dec hl
	jr .outer_loop

.CopyColumn:
	push hl
	push de
	push bc
	ld e, 7

.loop
	ld [hl], d
	ld bc, SCREEN_WIDTH
	add hl, bc
	inc d
	dec e
	jr nz, .loop
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
BadgeStatBoosts::
	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
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

EmptyBattleTextbox:
	ld hl, .empty
	jp PrintText

.empty:
	text_end

_BattleRandom:
; If the normal RNG is used in a link battle it'll desync.
; To circumvent this a shared PRNG is used instead.

; But if we're in a non-link battle we're safe to use it
	ld a, [wLinkMode]
	and a
	jp z, Random

; The PRNG operates in streams of 10 values.

; Which value are we trying to pull?
	push hl
	push bc
	ld a, [wLinkBattleRNCount]
	ld c, a
	ld b, $0
	ld hl, wLinkBattleRNs
	add hl, bc
	inc a
	ld [wLinkBattleRNCount], a

; If we haven't hit the end yet, we're good
	cp 9 ; number of seeds, including the last one. see comment in pokecrystal
	ld a, [hl]
	pop bc
	pop hl
	ret c

; If we have, we have to generate new pseudorandom data
; Instead of having multiple PRNGs, ten seeds are used
	push hl
	push bc
	push af

; Reset count to 0
	xor a
	ld [wLinkBattleRNCount], a
	ld hl, wLinkBattleRNs
	ld b, 9 ; number of seeds; in release, this was increased to 10

; Generate next number in the sequence for each seed
; a[n+1] = (a[n] * 5 + 1) % 256
.loop
	; get last #
	ld a, [hl]

	; a * 5 + 1
	ld c, a
	add a
	add a
	add c
	inc a

	; update #
	ld [hli], a
	dec b
	jr nz, .loop

; This has the side effect of pulling the last value first,
; then wrapping around. As a result, when we check to see if
; we've reached the end, we check the one before it.

	pop af
	pop bc
	pop hl
	ret

Call_PlayBattleAnim:
	ld a, e
	ld [wFXAnimID], a
	ld a, d
	ld [wFXAnimID + 1], a
	call WaitBGMap
	predef_jump PlayBattleAnim

; Give experience.
; Don't give experience if linked.
GiveExperiencePoints:
	ld a, [wLinkMode]
	and a
	ret nz

	call .EvenlyDivideExpAmongParticipants
	xor a
	ld [wCurPartyMon], a
	ld bc, wPartyMon1Species

.loop:
	ld hl, MON_HP
	add hl, bc
	ld a, [hli]
	or [hl]
	jp z, .next_mon ; fainted

	push bc
	ld hl, wBattleParticipantsNotFainted
	ld a, [wCurPartyMon]
	ld c, a

	ld b, CHECK_FLAG
	ld d, 0
	predef SmallFarFlagAction
	ld a, c
	and a
	pop bc
	jp z, .next_mon

; give stat exp
	ld hl, MON_STAT_EXP + 1
	add hl, bc
	ld d, h
	ld e, l
	ld hl, wEnemyMonBaseStats
	push bc
	ld c, NUM_EXP_STATS
.stat_exp_loop
	ld a, [hli]
	ld b, a
	ld a, [de]
	add b
	ld [de], a
	jr nc, .no_carry_stat_exp
	dec de
	ld a, [de]
	inc a
	jr z, .stat_exp_maxed_out
	ld [de], a
	inc de
	jr .no_carry_stat_exp

.stat_exp_maxed_out
	ld a, $ff
	ld [de], a
	inc de
	ld [de], a

.no_carry_stat_exp
	dec c
	jr z, .stat_exp_awarded
	inc de
	inc de
	jr .stat_exp_loop

.stat_exp_awarded
	xor a
	ldh [hMultiplicand], a
	ldh [hMultiplicand + 1], a
	ld a, [wEnemyMonBaseExp]
	ldh [hMultiplicand + 2], a
	ld a, [wEnemyMonLevel]
	ldh [hMultiplier], a
	call Multiply
	ld a, 7
	ldh [hDivisor], a
	ld b, 4
	call Divide
; Boost Experience for traded Pokemon
	pop bc
	ld hl, MON_ID
	add hl, bc
	ld a, [wPlayerID]
	cp [hl]
	jr nz, .boosted
	inc hl
	ld a, [wPlayerID + 1]
	cp [hl]
	ld a, 0
	jr z, .no_boost

.boosted
	call BoostExp
	ld a, 1

.no_boost
; Boost experience for a Trainer Battle
	ld [wStringBuffer2 + 2], a
	ld a, [wBattleMode]
	dec a
	call nz, BoostExp

	ld hl, MON_EXP + 2
	add hl, bc
	ld d, [hl]


	ldh a, [hQuotient + 3]
	ld [wStringBuffer2 + 1], a
	add d
	ld [hld], a
	ld d, [hl]
	ldh a, [hQuotient + 2]
	ld [wStringBuffer2], a
	adc d
	ld [hl], a
	jr nc, .no_exp_overflow
	dec hl
	inc [hl]

.no_exp_overflow
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
	ld hl, MON_EXP + 2
	add hl, bc
	push bc
	ldh a, [hQuotient + 1]
	ld b, a
	ldh a, [hQuotient + 2]
	ld c, a
	ldh a, [hQuotient + 3]
	ld d, a
	ld a, [hld]
	sub d
	ld a, [hld]
	sbc c
	ld a, [hl]
	sbc b
	jr c, .not_max_exp
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, d
	ld [hld], a

.not_max_exp
; <NICKNAME> grew to level ##!
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	ld hl, BoostedExpPointsText
	call PrintText
; Check if the mon leveled up
	xor a
	ld [wMonType], a
	predef CopyMonToTempMon
	farcall CalcLevel
	pop bc
	ld hl, MON_LEVEL
	add hl, bc
	ld a, [hl]
	cp d
	jp z, .next_mon

	ld a, [wCurPartyLevel]
	push af
	ld a, d
	ld [wCurPartyLevel], a
	ld [hl], a
	ld hl, 0
	add hl, bc
	ld a, [hl]
	ld [wCurSpecies], a
	ld [wTempSpecies], a ; unused?
	call GetBaseData
	ld hl, MON_MAXHP + 1
	add hl, bc
	ld a, [hld]
	ld e, a
	ld d, [hl]
	push de
	ld hl, MON_MAXHP
	add hl, bc
	ld d, h
	ld e, l
	ld hl, MON_STAT_EXP - 1
	add hl, bc
	push bc
	ld b, TRUE
	predef CalcMonStats
	pop bc
	pop de
	ld hl, MON_MAXHP + 1
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
	jr nz, .skip_active_mon_update
	ld de, wBattleMonHP
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld de, wBattleMonMaxHP
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH - MON_MAXHP
	call CopyBytes
	pop bc
	ld hl, MON_LEVEL
	add hl, bc
	ld a, [hl]
	ld [wBattleMonLevel], a
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TRANSFORMED, a
	jr nz, .transformed
	ld hl, MON_ATK
	add hl, bc
	ld de, wPlayerStats
	ld bc, PARTYMON_STRUCT_LENGTH - MON_ATK
	call CopyBytes

.transformed
	xor a ; FALSE
	ld [wApplyStatLevelMultipliersToEnemy], a
	call ApplyStatLevelMultiplierOnAllStats
; these three calls should be regular calls
	callfar ApplyStatusEffectOnPlayerStats
	callfar BadgeStatBoosts
	callfar UpdatePlayerHUD
	call EmptyBattleTextbox
	call BackUpTilesToBuffer

.skip_active_mon_update
	ld hl, GrewToLevelText
	call PrintText
	xor a
	ld [wMonType], a
	predef CopyMonToTempMon
	ld d, 1
	callfar PrintTempMonStats
	call TextboxWaitPressAorB_BlinkCursor
	call ReloadTilesFromBuffer
	xor a ; PARTYMON
	ld [wMonType], a
	ld a, [wCurSpecies]
	ld [wTempSpecies], a ; unused?
	predef LearnLevelMoves
	ld hl, wEvolvableFlags
	ld a, [wCurPartyMon]
	ld c, a
	ld b, SET_FLAG
	predef SmallFarFlagAction
	pop af
	ld [wCurPartyLevel], a

.next_mon
	ld a, [wPartyCount]
	ld b, a
	ld a, [wCurPartyMon]
	inc a
	cp b
	jr z, .done
	ld [wCurPartyMon], a
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1Species
	call AddNTimes
	ld b, h
	ld c, l
	jp .loop

.done
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
	predef_jump SmallFarFlagAction

; Divide enemy base stats, catch rate, and base exp by the number of mons gaining exp.
.EvenlyDivideExpAmongParticipants:
; count number of battle participants
	ld a, [wBattleParticipantsNotFainted]
	ld b, a
	xor a
	ld c, 8
	ld d, 0

.count_loop
	xor a
	srl b
	adc d
	ld d, a
	dec c
	jr nz, .count_loop
	cp 2
	ret c

	ld [wTempByteValue], a
	ld hl, wEnemyMonBaseStats
	ld c, wEnemyMonEnd - wEnemyMonBaseStats

.base_stat_division_loop
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
	jr nz, .base_stat_division_loop
	ret

; Multiply experience by 1.5x
BoostExp:
	push bc
; load experience value
	ldh a, [hProduct + 2]
	ld b, a
	ldh a, [hProduct + 3]
	ld c, a
; halve it
	srl b
	rr c
; add it back to the whole exp value
	add c
	ldh [hProduct + 3], a
	ldh a, [hProduct + 2]
	adc b
	ldh [hProduct + 2], a
	pop bc
	ret

BoostedExpPointsText:
	text_from_ram wStringBuffer1
	text "は@"
	start_asm
	ld a, [wBoostExpByExpAll]
	ld hl, .WithExpAllText
	and a
	ret nz
	ld hl, .ExpPointsText
	ld a, [wGainBoostedExp]
	and a
	ret z
	ld hl, .BoostedExpPointsText
	ret

.WithExpAllText:
	text "　がくしゅうそうちで@"
	start_asm
	ld hl, .ExpPointsText
	ret

.BoostedExpPointsText:
	text "　おおめに@"
.ExpPointsText:
	text_start
	line "@"
	deciram wStringBuffer2, 2, 4
	text "　けいけんちを　もらった！"
	prompt

GrewToLevelText:
	text_from_ram wStringBuffer1
	text "は"
	line "レベル@"
	deciram wCurPartyLevel, 1, 3
	text "　に　あがった！@"
	sound_dex_fanfare_50_79
	text_end

SendOutMonText:
	ld a, [wLinkMode]
	and a
	jr z, .not_linked

; If we're in a LinkBattle print just "Go <PlayerMon>"
; unless DoBattle already set [wBattleHasJustStarted]
	ld hl, GoMonText
	ld a, [wBattleHasJustStarted]
	and a
	jr nz, .skip_to_textbox

; Depending on the HP of the enemy mon, the game prints a different text
.not_linked
	ld hl, wEnemyMonHP
	ld a, [hli]
	or [hl]
	ld hl, GoMonText
	jr z, .skip_to_textbox

	; compute enemy health remaining as a percentage
	xor a
	ldh [hMultiplicand], a
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
	ld b, 4
	ldh [hDivisor], a
	call Divide

; (enemy's current HP * 25) / (enemy's max HP / 4)
; approximates current % of max HP
	ldh a, [hQuotient + 3]
; >= 70%
	ld hl, GoMonText
	cp 70
	jr nc, .skip_to_textbox
; 40% <= HP <= 69%
	ld hl, DoItMonText
	cp 40
	jr nc, .skip_to_textbox
; 10% <= HP <= 39%
	ld hl, GoForItMonText
	cp 10
	jr nc, .skip_to_textbox
; < 10%
	ld hl, YourFoesWeakGetmMonText
.skip_to_textbox
	jp PrintText

GoMonText:
	text "ゆけっ！　@"
	start_asm
	jr PrintPlayerMon1Text

DoItMonText:
	text "いってこい！　@"
	start_asm
	jr PrintPlayerMon1Text

GoForItMonText:
	text "がんばれ！　@"
	start_asm
	jr PrintPlayerMon1Text

YourFoesWeakGetmMonText:
	text "あいてが　よわっている！"
	line "チャンスだ！　@"
	start_asm

PrintPlayerMon1Text:
	ld hl, .Text
	ret
.Text:
	text_from_ram wBattleMonNickname
	text "！"
	done

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
	text_start
	line "もどれ！"
	done

PrintSafariZoneBattleText:
	ld hl, wUnused_SafariBaitFactor
	ld a, [hl]
	and a
	jr z, .no_bait
	dec [hl]
	ld hl, Unused_SafariZoneEatingText
	jr .done

.no_bait
	dec hl
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ld hl, Unused_SafariZoneAngryText
	jr nz, .done
	push hl
	ld a, [wEnemyMonSpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld a, [wMonHCatchRate]
	ld [wEnemyMonCatchRate], a
	pop hl

.done
	push hl
	call ReloadTilesFromBuffer
	pop hl
	jp PrintText

Unused_SafariZoneEatingText:
	text "やせいの@"
	text_from_ram wEnemyMonNickname
	text "は"
	line "エサを　たべてる！"
	prompt

Unused_SafariZoneAngryText:
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

SECTION "engine/battle/core.asm@StartBattle", ROMX

StartBattle::
	ld a, [wOtherTrainerClass]
	and a
	jr nz, .battle_intro

	ld a, [wTempWildMonSpecies]
	and a
	jr z, .battle_intro

	ld [wCurPartySpecies], a
	ld [wTempEnemyMonSpecies], a

.battle_intro
	ld a, [wTimeOfDayPal]
	push af
	ld hl, wTextboxFlags
	ld a, [hl]
	push af
	res TEXT_DELAY_F, [hl]
	ldh a, [hMapAnims]
	ld [wMapAnimsBackup], a
	call PlayBattleMusic
	call ShowLinkBattleParticipants
	call ClearBattleRAM
	ld a, [wOtherTrainerClass]
	and a
	jr nz, .trainer

	call InitEnemyWildmon
	jr .back_up_bgmap2
.trainer
	call InitEnemyTrainer

.back_up_bgmap2
	ld b, 0
	call GetSGBLayout
	ld hl, wStateFlags
	res SPRITE_UPDATES_DISABLED_F, [hl]
	call InitBattleDisplay
	call BattleStartMessage
	xor a
	ldh [hBGMapMode], a
	call EmptyBattleTextbox
	hlcoord 9, 7
	lb bc, 5, 10
	call ClearBox
	hlcoord 1, 0
	lb bc, 4, 10
	call ClearBox
	call ClearSprites
	ld a, [wBattleMode]
	cp WILD_BATTLE
	call z, UpdateEnemyHUD
	call DoBattle
	call ExitBattle
	pop af
	ld [wTextboxFlags], a
	pop af
	ld [wTimeOfDayPal], a
	ld a, [wMapAnimsBackup]
	ldh [hMapAnims], a
	scf
	ret

InitEnemyTrainer:
	ld [wTrainerClass], a
	callfar GetTrainerAttributes
	callfar ReadTrainerParty

	; RIVAL's first mon has no held item
	ld a, [wTrainerClass]
	cp TRAINER_RIVAL
	jr nz, .ok
	xor a
	ld [wOTPartyMon1Item], a

.ok
	call GetTrainerPic
	xor a
	ld [wTempEnemyMonSpecies], a
	ldh [hGraphicStartTile], a
	dec a
	ld [wEnemyItemState], a
	hlcoord 12, 0
	lb bc, 7, 7
	predef PlaceGraphic
	ld a, -1
	ld [wCurOTMon], a
	ld a, TRAINER_BATTLE
	ld [wBattleMode], a
	ret

InitEnemyWildmon:
	ld a, 1
	ld [wBattleMode], a
	call LoadEnemyMon
	ld hl, wEnemyMonDVs
	predef GetUnownLetter
	ld de, vFrontPic
	call LoadMonFrontSprite
	xor a
	ld [wTrainerClass], a
	ldh [hGraphicStartTile], a
	hlcoord 12, 0
	lb bc, 7, 7
	predef PlaceGraphic
	ret

GetTrainerPic:
	ld a, [wEnemyTrainerGraphicsPointer]
	ld e, a
	ld a, [wEnemyTrainerGraphicsPointer + 1]
	ld d, a
	ld a, BANK("gfx.asm@Trainer Battle Sprites")
	call UncompressSpriteFromDE
	ld de, vFrontPic
	ln a, 7, 7
	ld c, a
	jp LoadUncompressedSpriteData

; Fill wBoxAlignment-aligned box width b height c
; with iterating tile starting from hGraphicStartTile at hl.
PlaceGraphic:
	ld de, SCREEN_WIDTH

	ld a, [wSpriteFlipped]
	and a
	jr nz, .right

	ldh a, [hGraphicStartTile]

.x1
	push bc
	push hl

.y1
	ld [hl], a
	add hl, de
	inc a
	dec c
	jr nz, .y1

	pop hl
	inc hl
	pop bc
	dec b
	jr nz, .x1
	ret

.right
	push bc
	ld b, 0
	dec c
	add hl, bc
	pop bc

	ldh a, [hGraphicStartTile]
.x2
	push bc
	push hl

.y2
	ld [hl], a
	add hl, de
	inc a
	dec c
	jr nz, .y2

	pop hl
	dec hl
	pop bc
	dec b
	jr nz, .x2
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

; Old back sprite scaling code from Red & Green.
Old_ScaleSpriteByTwo:
	ld de, sSpriteBuffer1 + (4*4*8) - 5          ; last byte of input data, last 4 rows already skipped
	ld hl, sSpriteBuffer0 + SPRITEBUFFERSIZE - 1 ; end of destination buffer
	call ScaleLastSpriteColumnByTwo              ; last tile column is special case
	call ScaleFirstThreeSpriteColumnsByTwo       ; scale first 3 tile columns
	ld de, sSpriteBuffer2 + (4*4*8) - 5          ; last byte of input data, last 4 rows already skipped
	ld hl, sSpriteBuffer1 + SPRITEBUFFERSIZE - 1 ; end of destination buffer
	call ScaleLastSpriteColumnByTwo              ; last tile column is special case

ScaleFirstThreeSpriteColumnsByTwo:
	ld b, $3 ; 3 tile columns
.columnLoop
	ld c, 4*8 - 4 ; $1c, 4 tiles minus 4 unused rows
.columnInnerLoop
	push bc
	ld a, [de]
	ld bc, -(7*8)+1       ; -$37, scale lower nybble and seek to previous output column
	call ScalePixelsByTwo
	ld a, [de]
	dec de
	swap a
	ld bc, 7*8+1-2        ; $37, scale upper nybble and seek back to current output column and to the next 2 rows
	call ScalePixelsByTwo
	pop bc
	dec c
	jr nz, .columnInnerLoop
	dec de
	dec de
	dec de
	dec de
	ld a, b
	ld bc, -7*8 ; -$38, skip one output column (which has already been written along with the current one)
	add hl, bc
	ld b, a
	dec b
	jr nz, .columnLoop
	ret

ScaleLastSpriteColumnByTwo:
	ld a, 4*8 - 4 ; $1c, 4 tiles minus 4 unused rows
	ldh [hSpriteInterlaceCounter], a
	ld bc, -1
.columnInnerLoop
	ld a, [de]
	dec de
	swap a                    ; only high nybble contains information
	call ScalePixelsByTwo
	ldh a, [hSpriteInterlaceCounter]
	dec a
	ldh [hSpriteInterlaceCounter], a
	jr nz, .columnInnerLoop
	dec de                    ; skip last 4 rows of new column
	dec de
	dec de
	dec de
	ret

; scales the given 4 bits in a (4x1 pixels) to 2 output bytes (8x2 pixels)
; hl: destination pointer
; bc: destination pointer offset (added after the two bytes have been written)
ScalePixelsByTwo:
	push hl
	and $f
	ld hl, DuplicateBitsTable
	add l
	ld l, a
	jr nc, .noCarry
	inc h
.noCarry
	ld a, [hl]
	pop hl
	ld [hld], a ; write output byte twice to make it 2 pixels high
	ld [hl], a
	add hl, bc   ; add offset
	ret

DuplicateBitsTable:
FOR n, 16
	db (n & 1) * 3 + (n & 2) * 6 + (n & 4) * 12 + (n & 8) * 24
ENDR

ClearBattleRAM:
	xor a
	ld [wBattlePlayerAction], a
	ld [wBattleResult], a

	ld hl, wPartyMenuCursor
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a

	ld [wMenuScrollPosition], a
	ld [wCriticalHit], a
	ld [wBattleMonSpecies], a
	ld [wBattleParticipantsNotFainted], a
	ld [wCurBattleMon], a
	ld [wBattleEnded], a
	ld [wTimeOfDayPal], a
	ld [wEnemyTurnsTaken], a

	ld hl, wPlayerHPPal
	ld [hli], a
	ld [hl], a

	ld hl, wBattleMonDVs
	ld [hli], a
	ld [hl], a

	ld hl, wEnemyMonDVs
	ld [hli], a
	ld [hl], a

; Clear the entire BattleMons area
	ld hl, wEnemyMoveStruct
	ld bc, wBattleEnd - wBattle
	xor a
	call ByteFill

	call ClearWindowData

	ld hl, hBGMapAddress
	xor a
	ld [hli], a
	ld [hl], HIGH(vBGMap0)
	ld a, (LCDC_DEFAULT & ~(1 << rLCDC_WINDOW_TILEMAP))
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

ExitBattle:
	call IsLinkBattle
	jr nz, .HandleEndOfBattle
	call ShowLinkBattleParticipantsAfterEnd
	jr .CheckEvolution

.HandleEndOfBattle
	ld a, [wBattleResult]
	and a
	jr nz, .CleanUpBattleRAM
	; WIN
	call CheckPayDay

.CheckEvolution
	xor a
	ld [wForceEvolution], a
	predef EvolveAfterBattle

.CleanUpBattleRAM:
	xor a
	ld [wLowHealthAlarmBuffer], a
	ld [wBattleMode], a
	ld [wBattleType], a
	ld [wAttackMissed], a
	ld [wTempWildMonSpecies], a
	ld [wOtherTrainerClass], a
	ld [wFailedToFlee], a
	ld [wNumFleeAttempts], a
	ld [wBattleEnded], a
	ld hl, wPartyMenuCursor
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wMenuScrollPosition], a
	ld hl, wPlayerSubStatus1
	ld b, wEnemyFuryCutterCount - wPlayerSubStatus1
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ld hl, wd4a7
	set 0, [hl]
	call WaitSFX

	ld a, $e3
	ldh [rLCDC], a
	ld hl, wd14f
	res 7, [hl]
	call ClearPalettes
	ret

CheckPayDay:
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
	cp HELD_AMULET_COIN
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

ShowLinkBattleParticipantsAfterEnd:
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Status
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [wEnemyMonStatus]
	ld [hl], a
	call ClearTileMap
	call _ShowLinkBattleParticipants
	ld a, [wBattleResult]
	cp LOSE
	ld de, .YouWin
	jr c, .store_result
	ld de, .YouLose
	jr z, .store_result
	ld de, .Draw

.store_result
	hlcoord 6, 8
	call PlaceString
	ld c, 200
	call DelayFrames
	ret

.YouWin:
	db "あなたの　かち@"

.YouLose:
	db "あなたの　まけ@"

.Draw:
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
	call GetTrainerBackpic
	hlcoord 0, 12
	ld b, 4
	ld c, 18
	call DrawTextBox
	hlcoord 1, 5
	lb bc, 3, 7
	call ClearBox
	call DisableLCD
	call LoadFont
	call Call_LoadBattleFontsHPBar
	ld hl, vBGMap0
	lb bc, 4, 0
	ld a, '　'
	call ByteFill
	call LoadMapTimeOfDay.PushAttrMap
	call EnableLCD
	xor a
	ldh [hMapAnims], a
	ldh [hSCY], a
	ld a, SCREEN_HEIGHT_PX
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
	hlcoord 2, 6
	lb bc, 6, 6
	predef PlaceGraphic
	xor a
	ldh [hWY], a
	ldh [rWY], a
	call WaitBGMap
	ld b, SGB_BATTLE_COLORS
	call GetSGBLayout
	call HideSprites
	ld a, SCREEN_HEIGHT_PX
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
	ld a, %11100100
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a
.loop1
	push bc
	ld h, b
	ld l, $40
	call .subfunction2
	ld h, 0
	ld l, $60
	call .subfunction2
	call .subfunction1
	pop bc
	ld a, c
	ldh [hSCX], a
	inc b
	inc b
	dec c
	dec c
	jr nz, .loop1
	ret

.subfunction1:
	push bc
	ld hl, wShadowOAMSprite00XCoord
	ld c, $12
	ld de, SPRITEOAMSTRUCT_LENGTH
.loop2
	dec [hl]
	dec [hl]
	add hl, de
	dec c
	jr nz, .loop2
	pop bc
	ret

.subfunction2:
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

GetTrainerBackpic:
	ld de, PlayerBacksprite
	ld a, BANK(PlayerBacksprite)
	call UncompressSpriteFromDE
	ld hl, vChars2 tile $31
	predef GetMonBackpic
	ld a, BANK(sSpriteBuffer1)
	call OpenSRAM
	ld hl, vSprites
	ld de, sSpriteBuffer1
	ldh a, [hROMBank]
	ld b, a
	ld c, 7 * 7
	call Request2bpp
	call CloseSRAM
	call .LoadTrainerBackpicAsOAM

	ld a, $31
	ldh [hGraphicStartTile], a
	hlcoord 2, 6
	lb bc, 6, 6
	predef PlaceGraphic
	ret

.LoadTrainerBackpicAsOAM:
	ld hl, wShadowOAMSprite00
	xor a
	ldh [hMapObjectIndex], a
	ld b, 6
	ld e, (SCREEN_WIDTH + 1) * TILE_WIDTH

.outer_loop
	ld c, 3
	ld d, 8 * TILE_WIDTH

.inner_loop
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ldh a, [hMapObjectIndex]
	ld [hli], a
	inc a
	ldh [hMapObjectIndex], a
	inc hl
	ld a, d
	add 1 * TILE_WIDTH
	ld d, a
	dec c
	jr nz, .inner_loop
	ldh a, [hMapObjectIndex]
	add 3
	ldh [hMapObjectIndex], a
	ld a, e
	add 1 * TILE_WIDTH
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
	jr .PrintBattleStartText

.wild
	ld a, $f
	ld [wCryTracks], a
	ld a, [wTempEnemyMonSpecies]
	call PlayStereoCry
	ld hl, WildPokemonAppearedText
	ld a, [wAttackMissed]
	and a
	jr z, .PrintBattleStartText
	ld hl, HookedPokemonAttackedText

.PrintBattleStartText:
	push hl
	callfar BattleStart_TrainerHuds
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
	text_from_ram wOTClassName
	text "の　@"
	text_from_ram wStringBuffer1
	text "が"
	line "しょうぶを　しかけてきた！"
	prompt

ShowLinkBattleParticipants:
	call IsLinkBattle
	jr nz, .ok
	call _ShowLinkBattleParticipants
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

_ShowLinkBattleParticipants:
	call LoadFontExtra
	hlcoord 3, 4
	ld b, 7
	ld c, 12
	call DrawTextBox
	hlcoord 4, 6
	ld de, wPlayerName
	call PlaceString
	hlcoord 4, 10
	ld de, wOTPlayerName
	call PlaceString
	hlcoord 9, 8
	ld a, 'Ｖ'
	ld [hli], a
	ld [hl], 'Ｓ'
	callfar LinkBattle_TrainerHuds
	ld c, 150
	jp DelayFrames

IsLinkBattle:
	push bc
	push af
	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	pop bc
	ld a, b
	pop bc
	ret
