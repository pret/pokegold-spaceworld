INCLUDE "constants.asm"

SECTION "engine/dumps/bank0d.asm@DoPlayerTurn", ROMX
DoPlayerTurn:
	xor a
	ldh [hBattleTurn], a

	ld a, [wBattlePlayerAction]
	and a
	ret nz

	xor a
	ld [wTurnEnded], a
	call CheckTurn

	ld a, [wTurnEnded]
	and a
	ret nz

	call UpdateMoveData
	ld a, [wPlayerMoveStructEffect]
	jr DoMove

DoEnemyTurn:
	ld a, 1
	ldh [hBattleTurn], a
	ld a, [wLinkMode]
	and a
	jr z, .do_it

	ld a, [wOtherPlayerLinkAction]
	cp BATTLEACTION_STRUGGLE
	jr z, .do_it
	cp BATTLEACTION_SWITCH1
	ret nc

.do_it:
	xor a
	ld [wTurnEnded], a
	call CheckTurn

	ld a, [wTurnEnded]
	and a
	ret nz

	ld hl, wcaba
	inc [hl]

	call UpdateMoveData
	ld a, [wEnemyMoveStructEffect]
	; fallthrough

DoMove:
; Get the user's move effect.
	ld b, 0
	ld c, a
	ld hl, MoveEffectsPointers
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld de, wBattleScriptBuffer

.GetMoveEffect:
	ld a, [hli]
	ld [de], a
	inc de
	cp endmove_command
	jr nz, .GetMoveEffect

; Start at the first command.
	ld hl, wBattleScriptBuffer
	ld a, l
	ld [wBattleScriptBufferAddress], a
	ld a, h
	ld [wBattleScriptBufferAddress + 1], a

.ReadMoveEffectCommand:
	push bc
	ld a, [wBattleScriptBufferAddress]
	ld l, a
	ld a, [wBattleScriptBufferAddress + 1]
	ld h, a

	ld a, [hli]

	ld c, a
	cp endmove_command
	ld a, l
	ld [wBattleScriptBufferAddress], a
	ld a, h
	ld [wBattleScriptBufferAddress + 1], a
	jr z, .end

; The rest of the commands (01-af) are read from BattleCommandPointers.
	dec c
	ld b, 0
	ld hl, BattleCommandPointers
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld [wPredefBC + 1], a
	ld a, [hl]
	ld [wPredefBC], a
	pop bc
	
	ld hl, .ReadMoveEffectCommand
	push hl
	ld a, [wPredefBC + 1]
	ld l, a
	ld a, [wPredefBC]
	ld h, a
	jp hl

.end:
	pop bc
	ret

INCLUDE "data/moves/effects.inc"

BattleCommandPointers:
	dw BattleCommand_CheckTurn
	dw BattleCommand_CheckObedience
	dw BattleCommand_UsedMoveText
	dw BattleCommand_DoTurn
	dw BattleCommand_Critical
	dw BattleCommand_DamageStats
	dw BattleCommand_Stab
	dw BattleCommand_DamageVariation
	dw BattleCommand_CheckHit
	dw BattleCommand_LowerSub
	dw BattleCommand_MoveAnim
	dw BattleCommand_RaiseSub
	dw BattleCommand_FailureText
	dw BattleCommand_ApplyDamage
	dw BattleCommand_CriticalText
	dw BattleCommand_SuperEffectiveText
	dw BattleCommand_CheckFaint
	dw BattleCommand_BuildOpponentRage
	dw BattleCommand_PoisonTarget
	dw BattleCommand_SleepTarget
	dw BattleCommand_DrainTarget
	dw BattleCommand_EatDream
	dw BattleCommand_BurnTarget
	dw BattleCommand_FreezeTarget
	dw BattleCommand_ParalyzeTarget
	dw BattleCommand_Selfdestruct
	dw BattleCommand_MirrorMove
	dw BattleCommand_StatUp
	dw BattleCommand_StatDown
	dw BattleCommand_PayDay
	dw BattleCommand_Conversion
	dw BattleCommand_ResetStats
	dw BattleCommand_StoreEnergy
	dw BattleCommand_UnleashEnergy
	dw BattleCommand_TryEscape
	dw BattleCommand_EndLoop
	dw BattleCommand_FlinchTarget
	dw BattleCommand_OHKO
	dw BattleCommand_Recoil
	dw BattleCommand_Mist
	dw BattleCommand_FocusEnergy
	dw BattleCommand_Confuse
	dw BattleCommand_ConfuseTarget
	dw BattleCommand_Heal
	dw BattleCommand_Transform
	dw BattleCommand_Screen
	dw BattleCommand_Poison
	dw BattleCommand_Paralyze
	dw BattleCommand_Substitute
	dw BattleCommand_RechargeNextTurn
	dw BattleCommand_Mimic
	dw BattleCommand_Metronome
	dw BattleCommand_LeechSeed
	dw BattleCommand_Splash
	dw BattleCommand_Disable
	dw BattleCommand_ClearText
	dw BattleCommand_Charge
	dw BattleCommand_CheckCharge
	dw BattleCommand_TrapTarget
	dw BattleCommand_SkipToTrapTarget
	dw BattleCommand_Rampage
	dw BattleCommand_CheckRampage
	dw BattleCommand_ConstantDamage
	dw BattleCommand_Counter
	dw BattleCommand_Encore
	dw BattleCommand_PainSplit
	dw BattleCommand_Snore
	dw BattleCommand_Conversion2
	dw BattleCommand_LockOn
	dw BattleCommand_Sketch
	dw BattleCommand_DefrostOpponent
	dw BattleCommand_SleepTalk
	dw BattleCommand_DestinyBond
	dw BattleCommand_Spite
	dw BattleCommand_FalseSwipe
	dw BattleCommand_BellChime
	dw BattleCommand_HeldFlinch
	dw BattleCommand_TripleKick
	dw BattleCommand_KickCounter
	dw BattleCommand_Thief
	dw BattleCommand_ArenaTrap
	dw BattleCommand_Nightmare
	dw BattleCommand_Defrost
	dw BattleCommand_NailDown
	dw BattleCommand_Protect
	dw BattleCommand_Spikes
	dw BattleCommand_Foresight
	dw BattleCommand_PerishSong
	dw BattleCommand_StartSandstorm
	dw BattleCommand_Endure
	dw BattleCommand_Rollout
	dw BattleCommand_RolloutPower
	dw BattleCommand_OpponentAttackUp2
	dw BattleCommand_FuryCutter
	dw BattleCommand_Attract
	dw BattleCommand_HappinessPower
	dw BattleCommand_Present
	dw BattleCommand_DamageCalc
	dw BattleCommand_FrustrationPower
	dw BattleCommand_Safeguard
	dw BattleCommand_CheckSafeguard
	dw BattleCommand_GetMagnitude
	dw BattleCommand_BatonPass
	dw BattleCommand_PursuitPlaceholder
	dw BattleCommand_EscapeTrappingMove
	dw BattleCommand_HealMorn
	dw BattleCommand_HealDay
	dw BattleCommand_HealNite
	dw BattleCommand_HiddenPower
	dw BattleCommand_StartRain
	dw BattleCommand_StartSun

CheckTurn:
BattleCommand_CheckTurn:
; Repurposed as hardcoded turn handling. Useless as a command.
	ldh a, [hBattleTurn]
	and a
	ld a, [wCurPlayerSelectedMove]
	jr z, .go
	ld a, [wCurEnemySelectedMove]

.go
	inc a
	jp z, EndTurn

	xor a
	ld [wAttackMissed], a
	ld [wBattleAnimParam], a
	ld [wAlreadyDisobeyed], a
	ld [wAlreadyFailed], a

	ld a, EFFECTIVE
	ld [wTypeModifier], a

	ldh a, [hBattleTurn]
	and a
	jp nz, CheckEnemyTurn

	ld hl, wBattleMonStatus
	ld a, [hl]
	and SLP
	jr z, .not_asleep

	dec a
	ld [wBattleMonStatus], a
	and SLP
	jr z, .woke_up

	xor a
	ld [wNumHits], a
	ld de, ANIM_SLP
	call PlayFXAnimID
	jr .fast_asleep

.woke_up
	ld hl, WokeUpText
	call PrintText
	ld hl, UpdatePlayerHUD
	call CallFromBank0F
	ld hl, wPlayerSubStatus1
	res SUBSTATUS_NIGHTMARE, [hl]
	jr .not_asleep

.fast_asleep
	ld hl, FastAsleepText
	call PrintText

	; Snore and Sleep Talk bypass sleep.
	ld a, [wCurPlayerSelectedMove]
	cp MOVE_SNORE
	jr z, .not_asleep
	cp MOVE_SLEEP_TALK
	jr z, .not_asleep

	xor a
	ld [wCurPlayerMove], a
	jp EndTurn

.not_asleep
	ld hl, wBattleMonStatus
	bit FRZ, [hl]
	jr z, .not_frozen

	; Flame Wheel and Sacred Fire thaw the user.
	ld a, [wCurPlayerSelectedMove]
	cp MOVE_FLAME_WHEEL
	jr z, .not_frozen
	cp MOVE_SACRED_FIRE
	jr z, .not_frozen

	ld hl, FrozenSolidText
	call PrintText
	xor a
	ld [wCurPlayerMove], a
	jp EndTurn

.not_frozen
	ld a, [wEnemySubStatus3]
	bit SUBSTATUS_USING_TRAPPING_MOVE, a
	jp z, .not_trapped

	; Rapid Spin breaks the player free of trapping moves
	ld a, [wCurPlayerSelectedMove]
	cp MOVE_RAPID_SPIN
	jp z, .not_trapped
	ld hl, CantMoveText
	call PrintText
	jp EndTurn

.not_trapped
	ld hl, wPlayerSubStatus3
	bit SUBSTATUS_FLINCHED, [hl]
	jp z, .not_flinched

	res SUBSTATUS_FLINCHED, [hl]
	ld hl, FlinchedText
	call PrintText
	jp EndTurn

.not_flinched
	ld hl, wPlayerSubStatus4
	bit SUBSTATUS_RECHARGE, [hl]
	jr z, .no_recharge

	res SUBSTATUS_RECHARGE, [hl]
	ld hl, MustRechargeText
	call PrintText
	jp EndTurn

.no_recharge
	ld hl, wPlayerDisableCount
	ld a, [hl]
	and a
	jr z, .not_disabled

	dec a
	ld [hl], a
	and $f
	jr nz, .not_disabled

	ld [hl], a
	ld [wDisabledMove], a
	ld hl, DisabledNoMoreText
	call PrintText

.not_disabled
	ld a, [wPlayerSubStatus3]
	add a ; bit SUBSTATUS_CONFUSED
	jr nc, .not_confused

	ld hl, wPlayerConfuseCount
	dec [hl]
	jr nz, .confused

	ld hl, wPlayerSubStatus3
	res SUBSTATUS_CONFUSED, [hl]
	ld hl, ConfusedNoMoreText
	call PrintText
	jr .not_confused

.confused
	ld hl, IsConfusedText
	call PrintText
	xor a
	ld [wNumHits], a
	ld de, ANIM_CONFUSED
	call PlayFXAnimID

	; 50% chance of hitting itself
	call BattleRandom
	cp 50 percent + 1
	jp c, .not_confused

	; clear confusion-dependent substatus
	ld hl, wPlayerSubStatus3
	ld a, [hl]
	and 1 << SUBSTATUS_CONFUSED
	ld [hl], a

	call HitConfusion
	jr .cant_move

.not_confused
	ld a, [wPlayerSubStatus1]
	add a ; bit SUBSTATUS_ATTRACT
	jr nc, .not_infatuated

	ld hl, InLoveWithText
	call PrintText
	xor a
	ld [wNumHits], a
	ld de, ANIM_IN_LOVE
	call PlayFXAnimID

	; 50% chance of infatuation
	call BattleRandom
	cp 50 percent + 1
	jp c, .not_infatuated
	ld hl, InfatuationText
	call PrintText
	jr .cant_move

.not_infatuated
	ld a, [wDisabledMove]
	and a
	jr z, .no_disabled_move

	ld hl, wCurPlayerSelectedMove
	cp [hl]
	jr nz, .no_disabled_move

	call MoveDisabled
	jp EndTurn

.no_disabled_move
	ld hl, wBattleMonStatus
	bit PAR, [hl]
	jr z, .not_paralyzed

	call BattleRandom
	cp 25 percent
	jr nc, .not_paralyzed
	ld hl, FullyParalyzedText
	call PrintText

.cant_move
	ld hl, wPlayerSubStatus3
	ld a, [hl]
	and ((1 << SUBSTATUS_CONFUSED) | (1 << SUBSTATUS_INVULNERABLE) | (1 << SUBSTATUS_FLINCHED) | (1 << SUBSTATUS_IN_LOOP))
	ld [hl], a

	ld hl, wPlayerSubStatus1
	res SUBSTATUS_ROLLOUT, [hl]

	ld a, [wPlayerMoveStruct]
	cp MOVE_FLY
	jr z, .fly_dig
	cp MOVE_DIG
	jr z, .fly_dig
	jr .end_turn

.fly_dig
	res SUBSTATUS_INVULNERABLE, [hl]
	ld a, 2
	ld [wBattleAnimParam], a
	call LoadMoveAnim

.end_turn
	jp EndTurn

.not_paralyzed
	ret

CheckEnemyTurn:
	ld hl, wEnemyMonStatus
	ld a, [hl]
	and SLP
	jr z, .not_asleep

	dec a
	ld [wEnemyMonStatus], a
	and a
	jr z, .woke_up
	
	ld hl, FastAsleepText
	call PrintText
	xor a
	ld [wNumHits], a
	ld de, ANIM_SLP
	call PlayFXAnimID
	jr .fast_asleep

.woke_up
	ld hl, WokeUpText
	call PrintText
	ld hl, UpdateEnemyHUD
	call CallFromBank0F
	ld hl, wEnemySubStatus1
	res SUBSTATUS_NIGHTMARE, [hl]
	jr .not_asleep

.fast_asleep
	; Snore and Sleep Talk bypass sleep.
	ld a, [wCurPlayerSelectedMove]
	cp MOVE_SNORE
	jr z, .not_asleep
	cp MOVE_SLEEP_TALK
	jr z, .not_asleep

	xor a
	ld [wCurEnemyMove], a
	jp EndTurn

.not_asleep
	ld hl, wEnemyMonStatus
	bit FRZ, [hl]
	jr z, .not_frozen

	; Flame Wheel and Sacred Fire thaw the user.
	ld a, [wCurEnemySelectedMove]
	cp MOVE_FLAME_WHEEL
	jr z, .not_frozen
	cp MOVE_SACRED_FIRE
	jr z, .not_frozen

	ld hl, FrozenSolidText
	call PrintText
	xor a
	ld [wCurEnemyMove], a
	jp EndTurn

.not_frozen
	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_USING_TRAPPING_MOVE, a
	jp z, .not_trapped

	; Rapid Spin breaks the player free of trapping moves
	ld a, [wCurEnemySelectedMove]
	cp MOVE_RAPID_SPIN
	jp z, .not_trapped
	ld hl, CantMoveText
	call PrintText
	jp EndTurn

.not_trapped
	ld hl, wEnemySubStatus3
	bit SUBSTATUS_FLINCHED, [hl]
	jp z, .not_flinched

	res SUBSTATUS_FLINCHED, [hl]
	ld hl, FlinchedText
	call PrintText
	jp EndTurn

.not_flinched
	ld hl, wEnemySubStatus4
	bit SUBSTATUS_RECHARGE, [hl]
	jr z, .no_recharge

	res SUBSTATUS_RECHARGE, [hl]
	ld hl, MustRechargeText
	call PrintText
	jp EndTurn

.no_recharge
	ld hl, wEnemyDisableCount
	ld a, [hl]
	and a
	jr z, .not_disabled

	dec a
	ld [hl], a
	and $f
	jr nz, .not_disabled

	ld [hl], a
	ld [wEnemyDisabledMove], a
	ld hl, DisabledNoMoreText
	call PrintText

.not_disabled
	ld a, [wEnemySubStatus3]
	add a ; bit SUBSTATUS_CONFUSED
	jp nc, .not_confused

	ld hl, wEnemyConfuseCount
	dec [hl]
	jr nz, .confused

	ld hl, wEnemySubStatus3
	res SUBSTATUS_CONFUSED, [hl]
	ld hl, ConfusedNoMoreText
	call PrintText
	jp .not_confused

.confused
	ld hl, IsConfusedText
	call PrintText
	xor a
	ld [wNumHits], a
	ld de, ANIM_CONFUSED
	call PlayFXAnimID

	; 50% chance of hitting itself
	call BattleRandom
	cp 50 percent + 1
	jr c, .not_confused

	; clear confusion-dependent substatus
	ld hl, wEnemySubStatus3
	ld a, [hl]
	and 1 << SUBSTATUS_CONFUSED
	ld [hl], a

; Player's turn zeroes out wCriticalHit here, but not the enemy.
; Damage doesn't appear to be affected by this in any way.
	ld hl, HurtItselfText
	call PrintText
	call HitSelfInConfusion
	call BattleCommand_DamageCalc

	xor a
	ld [wNumHits], a
	ldh [hBattleTurn], a
	ld de, MOVE_POUND
	call PlayFXAnimID
	ld a, 1
	ldh [hBattleTurn], a
	call DoEnemyDamage
	jr .cant_move

.not_confused
	ld a, [wEnemySubStatus1]
	add a
	jr nc, .not_infatuated

	ld hl, InLoveWithText
	call PrintText
	xor a
	ld [wNumHits], a
	ld de, ANIM_IN_LOVE
	call PlayFXAnimID

	; 50% chance of infatuation
	call BattleRandom
	cp 50 percent + 1
	jp c, .not_infatuated
	ld hl, InfatuationText
	call PrintText
	jr .cant_move

.not_infatuated
	ld a, [wEnemyDisabledMove]
	and a
	jr z, .no_disabled_move

	ld hl, wCurEnemySelectedMove
	cp [hl]
	jr nz, .no_disabled_move

	call MoveDisabled
	jp EndTurn

.no_disabled_move
	ld hl, wEnemyMonStatus
	bit PAR, [hl]
	jr z, .not_paralyzed

	call BattleRandom
	cp 25 percent
	jr nc, .not_paralyzed
	ld hl, FullyParalyzedText
	call PrintText

.cant_move
	ld hl, wEnemySubStatus3
	ld a, [hl]
	and ((1 << SUBSTATUS_CONFUSED) | (1 << SUBSTATUS_INVULNERABLE) | (1 << SUBSTATUS_FLINCHED) | (1 << SUBSTATUS_IN_LOOP))
	ld [hl], a

	ld hl, wEnemySubStatus1
	res SUBSTATUS_ROLLOUT, [hl]

	ld a, [wEnemyMoveStruct]
	cp MOVE_FLY
	jr z, .fly_dig
	cp MOVE_DIG
	jr z, .fly_dig
	jr .end_turn

.fly_dig
	res SUBSTATUS_INVULNERABLE, [hl]
	ld a, 2
	ld [wBattleAnimParam], a
	call LoadMoveAnim

.end_turn
	jp EndTurn

.not_paralyzed
	ret
; Redundant extra ret
	ret

EndTurn:
	ld a, 1
	ld [wTurnEnded], a
	ret

FastAsleepText:
	text "<USER>は"
	line "ぐうぐう　ねむっている"
	prompt

WokeUpText:
	text "<USER>は　めをさました！"
	prompt

FrozenSolidText:
	text "<USER>は"
	line "こおって　しまって　うごかない！"
	prompt

FullyParalyzedText:
	text "<USER>は"
	line "からだが　しびれて　うごけない"
	prompt

FlinchedText:
	text "<USER>は　ひるんだ！"
	prompt

MustRechargeText:
	text "こうげきの　はんどうで"
	line "<USER>は　うごけない！"
	prompt

DisabledNoMoreText:
	text "<USER>の"
	line "かなしばりが　とけた！"
	prompt

IsConfusedText:
	text "<USER>は"
	line "こんらんしている！"
	prompt

HurtItselfText:
	text "わけも　わからず"
	line "じぶんを　こうげきした！"
	prompt

ConfusedNoMoreText:
	text "<USER>の"
	line "こんらんが　とけた！"
	prompt

AttackContinuesText:
	text "<USER>の　こうげきは"
	line "まだ　つづいている"
	done

CantMoveText:
	text "<USER>は"
	line "みうごきが　とれない！"
	prompt

StoringEnergyText:
	text "<USER>は　がまんしている"
	prompt

UnleashedEnergyText:
	text "<USER>の<LINE>がまんが　とかれた！<PROMPT>"

HungOnText:
	text "<TARGET>は"
	line "@"
	text_from_ram wStringBuffer1
	text "で　もちこたえた！"
	prompt

EnduredText:
	text "<TARGET>は　あいての"
	line "こうげきを　こらえた！"
	prompt

InLoveWithText:
	text "<USER>は"
	line "<TARGET>に　メロメロだ！"
	prompt

InfatuationText:
	text "<USER>は　メロメロで"
	line "わざが　だせなかった！"
	prompt

MoveDisabled:
	ld hl, wCurPlayerSelectedMove
	ld de, wPlayerSubStatus3
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	inc hl ; wCurEnemySelectedMove
	ld de, wEnemySubStatus3

.ok
	ld a, [de]
	res SUBSTATUS_CHARGED, a
	ld [de], a

	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call Unreferenced_GetMoveName
	ld hl, DisabledMoveText
	jp PrintText

DisabledMoveText:
	text "<USER>は　かなしばりで"
	line "@"
	text_from_ram wStringBuffer1
	text "がだせない！"
	prompt

HitConfusion:
	ld hl, HurtItselfText
	call PrintText

	xor a
	ld [wCriticalHit], a
	call HitSelfInConfusion
	call BattleCommand_DamageCalc

	xor a
	ld [wNumHits], a
	inc a
	ldh [hBattleTurn], a

	ld de, MOVE_POUND
	call PlayFXAnimID
	ld hl, UpdatePlayerHUD
	call CallFromBank0F
	xor a
	ldh [hBattleTurn], a
	jp DoPlayerDamage

BattleCommand_CheckObedience:
	; Enemy can't disobey
	ldh a, [hBattleTurn]
	and a
	ret nz

	xor a
	ld [wAlreadyDisobeyed], a

	; No obedience in link battles
	; (since no handling exists for enemy)
	ld a, [wLinkMode]
	and a
	ret nz

	; If the monster's id doesn't match the player's,
	; some conditions need to be met.
	ld hl, wPartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurBattleMon]
	call AddNTimes
	ld a, [wPlayerID]
	cp [hl]
	jr nz, .obeylevel
	inc hl
	ld a, [wPlayerID + 1]
	cp [hl]
	ret z

.obeylevel
	; The maximum obedience level is constrained by owned badges:
	ld hl, wBadges

	; eighth badge
	bit 7, [hl]
	ld a, MAX_LEVEL + 1
	jr nz, .getlevel

	; sixth badge
	bit 5, [hl]
	ld a, 70
	jr nz, .getlevel

	; fourth badge
	bit 3, [hl]
	ld a, 50
	jr nz, .getlevel

	; second badge
	bit 1, [hl]
	ld a, 30
	jr nz, .getlevel

	; no badges
	ld a, 10

.getlevel
; c = obedience level
; d = monster level
; b = c + d
	ld b, a
	ld c, a

	ld a, [wBattleMonLevel]
	ld d, a

	add b
	ld b, a

; No overflow (this should never happen)
	jr nc, .checklevel
	ld b, $ff

.checklevel
; If the monster's level is lower than the obedience level, it will obey.
	ld a, c
	cp d
	ret nc

; Random number from 0 to obedience level + monster level
.rand1:
	call BattleRandom
	swap a
	cp b
	jr nc, .rand1

; The higher above the obedience level the monster is,
; the more likely it is to disobey.
	cp c
	ret c

; Another random number from 0 to obedience level + monster level
.rand2
	call BattleRandom
	cp b
	jr nc, .rand2

; A second chance.
	cp c
	jr c, .UseInstead

; No hope of using a move now.

; b = number of levels the monster is above the obedience level
	ld a, d
	sub c
	ld b, a

; The chance of napping is the difference out of 256.
	call BattleRandom
	swap a
	sub b
	jr c, .Nap

; The chance of not hitting itself is the same.
	cp b
	jr nc, .DoNothing

	ld hl, WontObeyText
	call PrintText
	call HitConfusion
	jp .EndDisobedience

.Nap
	call BattleRandom
	add a
	swap a
	and SLP
	jr z, .Nap
	ld [wBattleMonStatus], a
	ld hl, BeganToNapText
	jr .Print

.DoNothing
	call BattleRandom
	and %11

	ld hl, LoafingAroundText
	and a ; 0
	jr z, .Print

	ld hl, WontObeyText
	dec a ; 1
	jr z, .Print

	ld hl, TurnedAwayText
	dec a ; 2
	jr z, .Print

	ld hl, IgnoredOrdersText

.Print
	call PrintText
	jr .EndDisobedience

.UseInstead
; Can't use another move if the monster only has one!
	ld a, [wBattleMonMoves + 1]
	and a
	jr z, .DoNothing

; Notably, disobedience skips over checks for Disable entirely, unlike pokered and final pokegold.

; If total PP across all moves is equal to the selected moves PP, then that move is the only option.
; In that case, disobedience is forced by doing nothing.

; BUG: The calculation does not take max PP increases into account at any point.
; Therefore, this will never trigger if any moves other than the selected one had PP Ups used on them.
; This results in a potential move PP underflow, as seen below.
	ld hl, wBattleMonPP
	push hl
	ld a, [hli] ; first move PP
	ld b, [hl]  ; second move PP
	inc hl
	add b
	ld b, [hl]  ; third move PP
	inc hl
	add b
	ld b, [hl]  ; fourth move PP
	add b
	pop hl
	push af

; Force disobedience if move is the only option
	ld a, [wCurMoveNum]
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	pop af

	cp b
	jr z, .DoNothing

; Make sure we can actually use the move once we get there.
	ld a, 1
	ld [wAlreadyDisobeyed], a

	ld a, [w2DMenuNumRows]
	dec a
	ld b, a

; Save the move we originally picked for afterward.
	ld a, [wCurMoveNum]
	ld c, a

.RandomMove
	call BattleRandom
	maskbits NUM_MOVES
	cp b
	jr nc, .RandomMove

; Not the move we were trying to use.
	cp c
	jr z, .RandomMove

; Make sure it has PP.
	ld [wCurMoveNum], a
	ld hl, wBattleMonPP
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
; BUG: This line clearly wasn't designed to handle moves with extra max PP, so it lets those slide no matter what.
; As a result, if max PP-increased moves are used at zero PP, they will underflow. However...
	and a
	jr z, .RandomMove

; ...the code that would've used the move is missing the part that actually USES the move.
; This causes it to fall through to .EndDisobedience, skipping the player's turn with no text.
	ld a, [wCurMoveNum]
	ld c, a
	ld b, 0
	ld hl, wBattleMonMoves
	add hl, bc
	ld a, [hl]
	ld [wCurPlayerSelectedMove], a
	call UpdateMoveData

.EndDisobedience
	jp EndMoveEffect

LoafingAroundText:
	text_from_ram wBattleMonNickname
	text "は　なまけている"
	prompt

BeganToNapText:
	text_from_ram wBattleMonNickname
	text "は　ひるねをはじめた！"
	prompt

WontObeyText:
	text_from_ram wBattleMonNickname
	text "は　いうことを　きかない"
	prompt

TurnedAwayText:
	text_from_ram wBattleMonNickname
	text "は　そっぽを　むいた"
	prompt

IgnoredOrdersText:
	text_from_ram wBattleMonNickname
	text "は　しらんぷりをした"
	prompt

BattleCommand_UsedMoveText:
	ld hl, UsedMoveText
	jp PrintText

UsedMoveText:
	text "<USER>@"
	start_asm
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStruct]
	ld hl, wCurPlayerMove
	jr z, .playerTurn
	ld a, [wEnemyMoveStruct]
	ld hl, wCurEnemyMove

.playerTurn:
	ld [hl], a
	ld [wMoveGrammar], a
	call GetMoveGrammar
	ld a, [wAlreadyDisobeyed]
	and a
	ld hl, UsedMove2Text
	ret nz
	ld a, [wMoveGrammar]
	cp 3
	ld hl, UsedMove2Text
	ret c
	ld hl, UsedMove1Text
	ret

UsedMove1Text:
	text "の　@"
	start_asm
	jr UsedMoveText_CheckObedience

UsedMove2Text:
	text "は　@"
	start_asm
UsedMoveText_CheckObedience:
; check obedience
	ld a, [wAlreadyDisobeyed]
	and a
	jr z, .GetMoveNameText
; print " instead,"
	ld hl, .UsedInsteadText
	ret

.UsedInsteadText:
	text "めいれいをむしして@"
	start_asm
.GetMoveNameText:
	ld hl, MoveNameText
	ret

MoveNameText:
	text "<LINE>@"
	text_from_ram wStringBuffer2
	start_asm
; get start address
	ld hl, .endusemovetexts

; get move id
	ld a, [wNumSetBits]

; 2-byte pointer
	add a

; seek
	push bc
	ld b, 0
	ld c, a
	add hl, bc
	pop bc

; get pointer to usedmovetext ender
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

.endusemovetexts
; entries correspond to MoveGrammar sets
	dw EndUsedMove1Text
	dw EndUsedMove2Text
	dw EndUsedMove3Text
	dw EndUsedMove4Text
	dw EndUsedMove5Text

EndUsedMove1Text:
	text "を　つかった！"
	done


EndUsedMove2Text:
	text "を　した！"
	done

EndUsedMove3Text:
	text "した！"
	done

EndUsedMove4Text:
	text "　こうげき！"
	done

EndUsedMove5Text:
	text "！"
	done

GetMoveGrammar:
; store move grammar type in wMoveGrammar

	push bc
; wMoveGrammar contains move id
	ld a, [wMoveGrammar]
	ld c, a ; move id
	ld b, 0 ; grammar index

; read grammer table
	ld hl, MoveGrammar

.loop
	ld a, [hli]
; end of table?
	cp -1
	jr z, .end
; match?
	cp c
	jr z, .end
; advance grammar type at 0
	and a
	jr nz, .loop
; next grammar type
	inc b
	jr .loop

.end:
; wMoveGrammar now contains move grammar
	ld a, b
	ld [wMoveGrammar], a

; we're done
	pop bc
	ret

MoveGrammar:
; Each move is given an identifier for what usedmovetext to use (0-4).
; Made redundant in English localization, where all are just "[mon]<LINE>used [move]!"
; In this prototype, no new moves have been added to the list yet.
;
; 0: "[mon]の<LINE>[move]を　つかった!" ("[mon]<LINE>used [move]!")
	db MOVE_SWORDS_DANCE
	db MOVE_GROWTH
	db $0

; 1: "[mon]の<LINE>[move]した!" ("[mon]<LINE>did [move]!")
	db MOVE_RECOVER
	db MOVE_BIDE
	db MOVE_SELFDESTRUCT
	db MOVE_AMNESIA
	db $0

; 2: "[mon]の<LINE>[move]を　した!" ("[mon]<LINE>did [move]!")
	db MOVE_MEDITATE
	db MOVE_AGILITY
	db MOVE_TELEPORT
	db MOVE_MIMIC
	db MOVE_DOUBLE_TEAM
	db MOVE_BARRAGE
	db $0

; 3: "[mon]の<LINE>[move]　こうげき!" ("[mon]'s<LINE>[move] attack!")
	db MOVE_POUND
	db MOVE_SCRATCH
	db MOVE_VICEGRIP
	db MOVE_WING_ATTACK
	db MOVE_FLY
	db MOVE_BIND
	db MOVE_SLAM
	db MOVE_HORN_ATTACK
	db MOVE_BODY_SLAM
	db MOVE_WRAP
	db MOVE_THRASH
	db MOVE_TAIL_WHIP
	db MOVE_LEER
	db MOVE_BITE
	db MOVE_GROWL
	db MOVE_ROAR
	db MOVE_SING
	db MOVE_PECK
	db MOVE_COUNTER
	db MOVE_STRENGTH
	db MOVE_ABSORB
	db MOVE_STRING_SHOT
	db MOVE_EARTHQUAKE
	db MOVE_FISSURE
	db MOVE_DIG
	db MOVE_TOXIC
	db MOVE_SCREECH
	db MOVE_HARDEN
	db MOVE_MINIMIZE
	db MOVE_WITHDRAW
	db MOVE_DEFENSE_CURL
	db MOVE_METRONOME
	db MOVE_LICK
	db MOVE_CLAMP
	db MOVE_CONSTRICT
	db MOVE_POISON_GAS
	db MOVE_LEECH_LIFE
	db MOVE_BUBBLE
	db MOVE_FLASH
	db MOVE_SPLASH
	db MOVE_ACID_ARMOR
	db MOVE_FURY_SWIPES
	db MOVE_REST
	db MOVE_SHARPEN
	db MOVE_SLASH
	db MOVE_SUBSTITUTE
	db $0

; 4: "[mon]の<LINE>[move]!" ("[mon]'s<LINE>[move]!")
; Any move not listed above uses this grammar.
	db -1 ; end

BattleCommand_DoTurn:
	ldh a, [hBattleTurn]
	and a
	ld a, [wCurPlayerSelectedMove]
	ld hl, wBattleMonPP
	ld de, wPlayerSubStatus3
	jr z, .proceed

	ld a, [wCurEnemySelectedMove]
	ld hl, wEnemyMonPP
	ld de, wEnemySubStatus3

.proceed
; If move is struggle, return
	cp MOVE_STRUGGLE
	ret z

; If forced to use the same move repeatedly, return
	ld a, [de]
	and ((1 << SUBSTATUS_BIDE) | (1 << SUBSTATUS_RAMPAGE) | (1 << SUBSTATUS_IN_LOOP))
	ret nz

	inc de
	ld a, [de]
	bit SUBSTATUS_RAGE, a
	ret nz

	call .consume_pp
	ld a, b
	and a
	jp nz, EndMoveEffect

; Don't update party mon's PP to match when transformed.
	inc de
	ld a, [de]
	bit SUBSTATUS_TRANSFORMED, a
	ret nz

	ldh a, [hBattleTurn]
	and a
	ld hl, wPartyMon1PP
	ld a, [wCurBattleMon]
	jr z, .player

; Wild Pokémon don't use PP
	ld a, [wBattleMode]
	dec a
	ret z

	ld hl, wOTPartyMon1PP
	ld a, [wCurOTMon]

.player
	ld bc, (wPartyMon2 - wPartyMon1)
	call AddNTimes

.consume_pp
	ldh a, [hBattleTurn]
	and a
	ld a, [wCurMoveNum]
	jr z, .okay
	ld a, [wCurEnemyMoveNum]

.okay
; BUG: If the Pokémon had PP Ups applied to the move it's using, then it can use it even with 0 PP.
; While not normally an issue, as the move is prevented from even being selected if it has 0 PP,
; this becomes a problem when the opponent uses Spite to lower the move's PP before the move is used.

; The move's PP will underflow, and lose one PP Up boost in the process.
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a ; should be 'and PP_MASK'
	jr z, .out_of_pp

	dec [hl]
	ld b, 0
	ret

.out_of_pp
	call BattleCommand_MoveDelay
	ld hl, NoPPLeftText
	call PrintText
	ld b, 1
	ret

NoPPLeftText:
	text "しかし　わざの　ポイントが"
	line "なかった！"
	prompt


BattleCommand_Critical:
	xor a
	ld [wCriticalHit], a
	ldh a, [hBattleTurn]
	and a
	ld a, [wEnemyMonSpecies]
	jr nz, .go
	ld a, [wBattleMonSpecies]

.go:
	ld [wCurSpecies], a
	call GetBaseData
	ld c, 6
	ld hl, wPlayerMoveStructPower
	ld de, wPlayerSubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, .player
	ld hl, wEnemyMoveStructPower
	ld de, wEnemySubStatus4

.player:
	ld a, [hld]
	and a
	ret z

	ld a, [de]
	bit SUBSTATUS_FOCUS_ENERGY, a
	jr z, .not_focus_energy
	dec c
	dec c
	dec c

.not_focus_energy:
	dec hl
	ld b, [hl]
	ld hl, HighCriticalMoves

.CheckCritical:
	ld a, [hli]
	cp b
	jr z, .critical_hit_move
	inc a
	jr nz, .CheckCritical
	jr .CalcCritChance

.critical_hit_move:
	dec c
	dec c

; de = Base Speed * 4
.CalcCritChance:
	ld a, [wMonHBaseSpeed]
	ld e, a
	ld d, 0
	sla e
	rl d
	sla e
	rl d

.half_crit_chance:
	dec c
	jr z, .CheckForCritGuarantee
	srl d
	rr e
	jr .half_crit_chance

.CheckForCritGuarantee:
	ld b, e
	ld a, d
	and a
	jr z, .SharpScythe
	ld b, $ff

.SharpScythe:
	push bc
	call GetUserItem
	ld a, b
	cp HELD_CRITICAL_UP

	ld a, c
	pop bc
	jr nz, .Tally

	; Old crit chance + held item parameter = New crit chance
	add b
	ld b, a
	jr nc, .Tally
	ld b, $ff

; Roll random number, return if less than or equal to b.
.Tally:
; Bug: 1/256 chance to not get a crit even when b is the max possible value.
	call BattleRandom
	rlc a
	rlc a
	rlc a
	cp b
	ret nc

	ld a, 1
	ld [wCriticalHit], a
	ret

HighCriticalMoves:
	db MOVE_KARATE_CHOP
	db MOVE_RAZOR_LEAF
	db MOVE_CRABHAMMER
	db MOVE_SLASH
	db -1

BattleCommand_DamageStats:
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy

	call PlayerAttackDamage
	jr .return

.enemy:
	call EnemyAttackDamage

.return:
	ret

BattleCommand_TripleKick:
	ld a, [wBattleAnimParam]
	ld b, a
	inc b
	ld a, [wCurDamage + 1]
	ld e, a
	ld a, [wCurDamage]
	ld d, a

.next_kick
	dec b
	ret z
	ld a, [wCurDamage + 1]
	add e
	ld [wCurDamage + 1], a
	ld a, [wCurDamage]
	adc d
	ld [wCurDamage], a

; No overflow.
	jr nc, .next_kick
	ld a, $ff
	ld [wCurDamage], a
	ld [wCurDamage + 1], a
	ret

BattleCommand_KickCounter:
	ld a, [wBattleAnimParam]
	inc a
	ld [wBattleAnimParam], a
	ret

BattleCommand_Stab:
; STAB = Same Type Attack Bonus
	ld hl, wBattleMonType
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wEnemyMonType
	ld a, [hli]
	ld d, a
	ld e, [hl]
	ld a, [wPlayerMoveStructType]
	ld [wNumSetBits], a

	ldh a, [hBattleTurn]
	and a
	jr z, .go

	ld hl, wEnemyMonType
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wBattleMonType
	ld a, [hli]
	ld d, a
	ld e, [hl]
	ld a, [wEnemyMoveStructType]
	ld [wCurType], a

.go:
	call DoWeatherModifiers

	ld a, [wCurType]
	cp b
	jr z, .stab
	cp c
	jr z, .stab

	jr .SkipStab

.stab:
	ld hl, wCurDamage + 1
	ld a, [hld]
	ld h, [hl]
	ld l, a

	ld b, h
	ld c, l
	srl b
	rr c
	add hl, bc

	ld a, h
	ld [wCurDamage], a
	ld a, l
	ld [wCurDamage + 1], a
	ld hl, wTypeModifier
	set STAB_DAMAGE_F, [hl]

.SkipStab:
	ld a, [wCurType]
	ld b, a
	ld hl, TypeMatchups

.TypesLoop:
	ld a, [hli]
	cp -1
	jr z, .end

	; foresight
	cp -2
	jr nz, .SkipForesightCheck

	push hl
	ld hl, wEnemySubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, .foresight_check
	ld hl, wPlayerSubStatus1

.foresight_check:
	bit SUBSTATUS_IDENTIFIED, [hl]
	pop hl
	jr nz, .end
	jr .TypesLoop

.SkipForesightCheck:
	cp b
	jr nz, .SkipType
	ld a, [hl]
	cp d
	jr z, .GotMatchup
	cp e
	jr z, .GotMatchup
	jr .SkipType

.GotMatchup:
	push hl
	push bc
	inc hl
	ld a, [wTypeModifier]
	and STAB_DAMAGE
	ld b, a
	ld a, [hl]
	and a
	jr nz, .NotImmune
	inc a
	ld [wAttackMissed], a
	xor a

.NotImmune:
	ldh [hMultiplier], a
	add b
	ld [wTypeModifier], a

	xor a
	ldh [hMultiplicand], a

	ld hl, wCurDamage
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hld]
	ldh [hMultiplicand + 2], a

	call Multiply

	ld a, 10
	ldh [hDivisor], a
	ld b, 4

	call Divide

	ldh a, [hQuotient + 2]
	ld [hli], a
	ldh a, [hQuotient + 3]
	ld [hl], a
	pop bc
	pop hl

.SkipType:
	inc hl
	inc hl
	jp .TypesLoop

.end:
	call BattleCheckTypeMatchup
	ld a, [wNumSetBits]
	ld b, a
	ld a, [wTypeModifier]
	and STAB_DAMAGE
	or b
	ld [wTypeModifier], a
	ret

DoWeatherModifiers:
	push hl
	push de
	push bc
	ld hl, WeatherTypeModifiers
	ld a, [wBattleWeather]
	ld b, a
	ld a, [wCurType]
	ld c, a

.CheckWeatherType:
	ld a, [hli]
	cp -1
	jr z, .done

	cp b
	jr nz, .NextWeatherType
	ld a, [hl]
	cp c
	jr z, .ApplyModifier

.NextWeatherType:
	inc hl
	inc hl
	jr .CheckWeatherType

.ApplyModifier:
	xor a
	ldh [hMultiplicand], a
	ld a, [wCurDamage]
	ldh [hMultiplicand + 1], a
	ld a, [wCurDamage + 1]
	ldh [hMultiplicand + 2], a

	inc hl
	ld a, [hl]
	ldh [hMultiplier], a
	call Multiply

	ld a, 10
	ldh [hDivisor], a
	ld b, 4
	call Divide

	ldh a, [hQuotient + 1]
	and a
	ld bc, $ffff
	jr nz, .Update

	ldh a, [hQuotient + 2]
	ld b, a
	ldh a, [hQuotient + 3]
	ld c, a
	or b
	jr nz, .Update

	ld bc, 1

.Update:
	ld a, b
	ld [wCurDamage], a
	ld a, c
	ld [wCurDamage + 1], a

.done:
	pop bc
	pop de
	pop hl
	ret

WeatherTypeModifiers:
	db WEATHER_RAIN, TYPE_WATER, SUPER_EFFECTIVE
	db WEATHER_RAIN, TYPE_FIRE,  NOT_VERY_EFFECTIVE
	db WEATHER_SUN,  TYPE_FIRE,  SUPER_EFFECTIVE
	db WEATHER_SUN,  TYPE_WATER, NOT_VERY_EFFECTIVE
	db -1 ; end

BattleCheckTypeMatchup:
	ldh a, [hBattleTurn]
	and a

	ld hl, wEnemyMonType
	ld a, [wPlayerMoveStructType]
	jr z, CheckTypeMatchup

	ld hl, wBattleMonType
	ld a, [wEnemyMoveStructType]

CheckTypeMatchup:
	ld d, a
	ld b, [hl]
	inc hl
	ld c, [hl]
	ld a, EFFECTIVE
	ld [wTypeMatchup], a
	ld hl, TypeMatchups
.TypesLoop:
	ld a, [hli]
	cp -1
	jr z, .End
	cp -2
	jr nz, .Next
	push hl
	ld hl, wEnemySubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, .do_foresight_check
	ld hl, wPlayerSubStatus1

.do_foresight_check:
	bit SUBSTATUS_IDENTIFIED, [hl]
	pop hl
	jr nz, .End
	jr .TypesLoop

.Next:
	cp d
	jr nz, .Nope
	ld a, [hli]
	cp b
	jr z, .Yup
	cp c
	jr z, .Yup
	jr .Nope2

.Nope:
	inc hl
.Nope2:
	inc hl
	jr .TypesLoop

.Yup:
	xor a
	ldh [hProduct], a
	ldh [hMultiplicand], a
	ldh [hMultiplicand + 1], a
	ld a, [hli]
	ldh [hMultiplicand + 2], a
	ld a, [wTypeMatchup]
	ldh [hMultiplier], a
	call Multiply
	ld a, 10
	ldh [hDivisor], a
	push bc
	ld b, 4
	call Divide
	pop bc
	ldh a, [hQuotient + 3]
	ld [wTypeMatchup], a
	jr .TypesLoop

.End:
	ret

INCLUDE "data/types/type_matchups.inc"

BattleCommand_DamageVariation:
; Modify the damage spread between 85% and 100%.

; Because of the method of division the probability distribution
; is not consistent. This makes the highest damage multipliers
; rarer than normal.

; No point in reducing 1 or 0 damage.
	ld hl, wCurDamage
	ld a, [hli]
	and a
	jr nz, .go
	ld a, [hl]
	cp 2
	ret c

.go:
; Start with the maximum damage.
	xor a
	ldh [hMultiplicand], a
	dec hl
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ldh [hMultiplicand + 2], a

; Multiply by 85-100%...
.loop:
	call BattleRandom
	rrca
	cp $d9
	jr c, .loop
	ldh [hMultiplier], a
	call Multiply

; ...divide by 100%...
	ld a, 100 percent
	ldh [hDivisor], a
	ld b, 4
	call Divide

; ...to get .85-1.00x damage.
	ldh a, [hQuotient + 2]
	ld hl, wCurDamage
	ld [hli], a
	ldh a, [hQuotient + 3]
	ld [hl], a
	ret

BattleCommand_CheckHit:
	ld hl, wEnemySubStatus1
	ld de, wPlayerMoveStructEffect
	ld bc, wEnemyMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, .DreamEater
	ld hl, wPlayerSubStatus1
	ld de, wEnemyMoveStructEffect
	ld bc, wBattleMonStatus

.DreamEater:
; Return z if we're trying to eat the dream of
; a monster that isn't sleeping.
	ld a, [de]
	cp EFFECT_DREAM_EATER
	jr nz, .Protect
	ld a, [bc]
	and SLP
	jp z, .Miss

.Protect:
	bit SUBSTATUS_PROTECT, [hl]
	jp nz, .Miss
	ld a, [de]
	cp EFFECT_SWIFT
	ret z

	inc hl
	inc hl
	inc hl
	inc hl
	bit SUBSTATUS_LOCK_ON, [hl]
	res SUBSTATUS_LOCK_ON, [hl]
	ret nz

; Bug: Supposed to return z if using an HP drain move on a substitute.
; Register a is expected to contain the move struct effect.
; However, it is overwritten to either 0 or 1 by calling CheckSubstituteOpp.
	call CheckSubstituteOpp

	jr z, .FlyDigMoves
	cp EFFECT_LEECH_HIT
	jp z, .Miss
	cp EFFECT_DREAM_EATER
	jp z, .Miss

.FlyDigMoves:
; Check for moves that can hit underground/flying opponents.
; Return z if the current move can hit the opponent.
	dec hl
	dec hl
	bit SUBSTATUS_INVULNERABLE, [hl]
	jp z, .EnemyMonMist
	
	ld hl, wCurEnemyMove
	ld de, wPlayerMoveStruct
	ldh a, [hBattleTurn]
	and a
	jr z, .fly_moves
	ld hl, wCurPlayerMove
	ld de, wEnemyMoveStruct

.fly_moves:
	ld a, [hl]
	cp MOVE_FLY
	jr nz, .dig_moves

; Final game adds Gust to this list
	ld a, [de]
	cp MOVE_WHIRLWIND
	jr z, .EnemyMonMist
	cp MOVE_THUNDER
	jr z, .EnemyMonMist
	jp .Miss

.dig_moves:
	cp MOVE_DIG
	jp nz, .Miss

; Final game adds Magnitude to this list
	ld a, [de]
	cp MOVE_EARTHQUAKE
	jr z, .EnemyMonMist
	cp MOVE_FISSURE
	jr z, .EnemyMonMist
	jp .Miss

.EnemyMonMist:
	ldh a, [hBattleTurn]
	and a
	jr nz, .PlayerMonMist
	ld a, [wPlayerMoveStructEffect]
	cp EFFECT_ATTACK_DOWN
	jr c, .skip_enemy_mist_check
	cp EFFECT_RESET_STATS + 1
	jr c, .enemy_mist_check
	cp EFFECT_ATTACK_DOWN_2
	jr c, .skip_enemy_mist_check
	cp EFFECT_REFLECT + 1
	jr c, .enemy_mist_check
	jr .skip_enemy_mist_check

.enemy_mist_check:
	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_MIST, a
	jp nz, .Miss

.skip_enemy_mist_check:
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_X_ACCURACY, a
	ret nz
	jr .calc_hit_chance

.PlayerMonMist:
	ld a, [wEnemyMoveStructEffect]
	cp EFFECT_ATTACK_DOWN
	jr c, .skip_player_mist_check
	cp EFFECT_RESET_STATS + 1
	jr c, .player_mist_check
	cp EFFECT_ATTACK_DOWN_2
	jr c, .skip_player_mist_check
	cp EFFECT_REFLECT + 1
	jr c, .player_mist_check
	jr .skip_player_mist_check

.player_mist_check:
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_MIST, a
	jp nz, .Miss

.skip_player_mist_check:
	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_X_ACCURACY, a
	ret nz

.calc_hit_chance:
	call .StatModifiers
	ld a, [wPlayerMoveStructAccuracy]
	ld b, a
	ldh a, [hBattleTurn]
	and a
	jr z, .StrangeThread
	ld a, [wEnemyMoveStructAccuracy]
	ld b, a

.StrangeThread:
	push bc
	call GetOpponentItem
	ld a, b
	cp HELD_STRANGE_THREAD
	ld a, c
	pop bc
	jr nz, .skip_strange_thread

	ld c, a
	ld a, b
	sub c
	ld b, a
	jr nc, .skip_strange_thread
	ld b, 0

.skip_strange_thread:
	call BattleRandom
	cp b
	jr nc, .Miss
	ret

.Miss:
	xor a
	ld hl, wCurDamage
	ld [hli], a
	ld [hl], a
	inc a
	ld [wAttackMissed], a
	ldh a, [hBattleTurn]
	and a
	jr z, .player_wrapping
	ld hl, wEnemySubStatus3
	res SUBSTATUS_USING_TRAPPING_MOVE, [hl]
	ret

.player_wrapping:
	ld hl, wPlayerSubStatus3
	res SUBSTATUS_USING_TRAPPING_MOVE, [hl]
	ret

.StatModifiers:
	ldh a, [hBattleTurn]
	and a

	ld hl, wPlayerMoveStructAccuracy
	ld a, [wPlayerAccLevel]
	ld b, a
	ld a, [wEnemyEvaLevel]
	ld c, a
	jr z, .got_acc_eva


	ld hl, wEnemyMoveStructAccuracy
	ld a, [wEnemyAccLevel]
	ld b, a
	ld a, [wPlayerEvaLevel]
	ld c, a

.got_acc_eva:
; c = 14 - Evasion Level
	ld a, $e
	sub c
	ld c, a

	xor a
	ldh [hMultiplicand], a
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ldh [hMultiplicand + 2], a
	push hl
	ld d, 2

.accuracy_loop:
	; look up the multiplier from the table
	push bc
	ld hl, AccuracyLevelMultipliers
	dec b
	sla b
	ld c, b
	ld b, 0
	add hl, bc
	pop bc
	; multiply by the first byte in that row...
	ld a, [hli]
	ldh [hMultiplier], a
	call Multiply
	; ... and divide by the second byte
	ld a, [hl]
	ldh [hPrintNumDivisor], a
	ld b, 4
	call Divide
	; minimum accuracy is $0001
	ldh a, [hQuotient + 3]
	ld b, a
	ldh a, [hQuotient + 2]
	or b
	jp nz, .min_accuracy

	ldh [hQuotient + 2], a
	ld a, 1
	ldh [hQuotient + 3], a

.min_accuracy:
	; do the same thing to the target's evasion
	ld b, c
	dec d
	jr nz, .accuracy_loop

	; if the result is more than 2 bytes, max out at 100%
	ldh a, [hQuotient + 2]
	and a
	ldh a, [hQuotient + 3]
	jr z, .finish_accuracy
	ld a, $ff

.finish_accuracy:
	pop hl
	ld [hl], a
	ret

; Identical to StatLevelMultipliers.
; Given this is a separate table (unlike RBY), seems like they were already in the process of being split.
AccuracyLevelMultipliers:
	INCLUDE "data/battle/stat_multipliers.inc"

BattleCommand_EffectChance:
	; final game clears out wEffectFailed here
	call CheckSubstituteOpp
	jr nz, .failed
	push hl
	ld hl, wPlayerMoveStructEffectChance
	ldh a, [hBattleTurn]
	and a
	jr z, .got_move_chance
	ld hl, wEnemyMoveStructEffectChance

.got_move_chance
	call BattleRandom
	cp [hl]
	pop hl
	ret

.failed:
	and a
	ret

BattleCommand_LowerSub:
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerSubStatus4]
	jr z, .go
	ld a, [wEnemySubStatus4]

.go:
	bit SUBSTATUS_SUBSTITUTE, a
	ret z
	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	inc a
	ld [wBattleAnimParam], a
	ld a, MOVE_SUBSTITUTE
	jp LoadBattleAnim

BattleCommand_MoveAnim:
	ld a, [wAttackMissed]
	and a
	jp nz, BattleCommand_MoveDelay

	inc a
	ld [wNumHits], a
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStruct]
	ld c, a
	ld de, wPlayerRolloutCount
	ld a, [wPlayerMoveStructEffect]
	jr z, .got_rollout_count

	ld a, [wEnemyMoveStruct]
	ld c, a
	ld de, wEnemyRolloutCount
	ld a, [wEnemyMoveStructEffect]

.got_rollout_count:
	cp EFFECT_MULTI_HIT
	jr z, .alternate_anim
	cp EFFECT_CONVERSION
	jr z, .alternate_anim
	cp EFFECT_DOUBLE_HIT
	jr z, .alternate_anim
	cp EFFECT_POISON_MULTI_HIT
	jr z, .alternate_anim
	cp EFFECT_TRIPLE_KICK
	jr z, .triplekick
	xor a
	ld [wBattleAnimParam], a

.triplekick:
	ld e, c
	ld d, 0
	jp PlayFXAnimID

.alternate_anim:
	ld a, [wBattleAnimParam]
	and 1
	xor 1
	ld [wBattleAnimParam], a
	ld a, [de]
	cp 1
	ld e, c
	ld d, 0
	jp z, PlayFXAnimID
	xor a
	ld [wNumHits], a
	jp PlayFXAnimID

BattleCommand_RaiseSub:
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerSubStatus4]
	jr z, .got_substatus
	ld a, [wEnemySubStatus4]

.got_substatus:
	bit SUBSTATUS_SUBSTITUTE, a
	ret z

	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	ld a, 2
	ld [wBattleAnimParam], a
	ld a, MOVE_SUBSTITUTE
	jp LoadBattleAnim

BattleCommand_FailureText:
	ld a, [wAttackMissed]
	and a
	ret z
	call GetFailureResultText
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStruct]
	ld hl, wPlayerSubStatus3
	jr z, .check_fly_dig

	ld a, [wEnemyMoveStruct]
	ld hl, wEnemySubStatus3

.check_fly_dig:
	cp MOVE_FLY
	jr z, .fly_dig
	cp MOVE_DIG
	jr z, .fly_dig
	jp EndMoveEffect

.fly_dig:
	res SUBSTATUS_INVULNERABLE, [hl]
	ld a, 2
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	jp EndMoveEffect

BattleCommand_ApplyDamage:
	ld hl, wEnemySubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus_1
	ld hl, wPlayerSubStatus1

.got_substatus_1:
	bit SUBSTATUS_ENDURE, [hl]
	jr z, .focus_orb
	call BattleCommand_FalseSwipe
	ld b, 0
	jr nc, .damage
	ld b, 1
	jr .damage

.focus_orb:
	call GetOpponentItem
	ld a, b
	cp HELD_FOCUS_ORB
	ld b, 0
	jr nz, .damage

	call BattleRandom
	cp c
	jr nc, .damage
	call BattleCommand_FalseSwipe
	ld b, 0
	jr nc, .damage
	ld b, 2

.damage:
	push bc
	call .update_damage_taken
	ldh a, [hBattleTurn]
	and a
	jr nz, .damage_player
	call DoEnemyDamage
	jr .done_damage

.damage_player:
	call DoPlayerDamage

.done_damage:
	pop bc
	ld a, b
	and a
	ret z

	dec a
	jr nz, .focus_orb_text
	ld hl, EnduredText
	jp PrintText

.focus_orb_text:
	call GetOpponentItem
	ld a, [hl]
	ld [wNumSetBits], a
	call GetItemName
	ld hl, HungOnText
	jp PrintText

.update_damage_taken:
	ld de, wPlayerDamageTaken + 1
	ldh a, [hBattleTurn]
	and a
	jr nz, .got_damage_taken
	ld de, wEnemyDamageTaken + 1

.got_damage_taken:
	ld a, [wCurDamage + 1]
	ld b, a
	ld a, [de]
	add b
	ld [de], a
	dec de
	ld a, [wCurDamage]
	ld b, a
	ld a, [de]
	adc b
	ld [de], a
	ret nc
	ld a, $ff
	ld [de], a
	inc de
	ld [de], a
	ret

Unreferenced_Gen1HealEffect:
	call GetOpponentItem
	ldh a, [hBattleTurn]
	and a
	ld de, wBattleMonHP
	ld hl, wBattleMonMaxHP
	ld a, [wPlayerMoveStruct]
	jr z, .healEffect
	ld de, wEnemyMonHP
	ld hl, wEnemyMonMaxHP
	ld a, [wEnemyMoveStruct]

.healEffect:
	ld b, a
	ld a, [de]
	cp [hl]
; BUG: The previous comparison is ignored.
; This made healing moves in Gen 1 fail when user's HP is 255/511 points lower than max HP.
	inc de
	inc hl
	ld a, [de]
	sbc [hl]
	jp z, .failed
	ld a, b
	cp MOVE_REST
	jr nz, .healHP
	push hl
	push de
	push af
	call BattleCommand_MoveDelay
	ld hl, wBattleMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, .restEffect
	ld hl, wEnemyMonStatus

.restEffect:
	ld a, [hl]
	and a
	ld [hl], 2
	ld hl, Unused_WentToSleepText
	jr z, .printRestText
	ld hl, Unused_RestedText

.printRestText:
	call PrintText
	pop af
	pop de
	pop hl

.healHP:
	ld a, [hld]
	ld [wHPBarMaxHP], a
	ld c, a
	ld a, [hl]
	ld [wHPBarMaxHP + 1], a
	ld b, a
	jr z, .gotHPAmountToHeal
; Recover and Softboiled only heal for half the mon's max HP
	srl b
	rr c

.gotHPAmountToHeal:
	ld a, [de]
	ld [wHPBarOldHP], a
	add c
	ld [de], a
	ld [wHPBarNewHP], a
	dec de
	ld a, [de]
	ld [wHPBarOldHP + 1], a
	adc b
	ld [de], a
	ld [wHPBarNewHP + 1], a
	inc hl
	inc de
	ld a, [de]
	dec de
	sub [hl]
	dec hl
	ld a, [de]
	sbc [hl]
	jr c, .playAnim
; copy max HP to current HP if an overflow occurred
	ld a, [hli]
	ld [de], a
	ld [wHPBarNewHP + 1], a
	inc de
	ld a, [hl]
	ld [de], a
	ld [wHPBarNewHP], a

.playAnim:
	call LoadMoveAnim
	ldh a, [hBattleTurn]
	and a
	hlcoord 10, 9
	ld a, 1
	jr z, .updateHPBar
	hlcoord 2, 2
	xor a

.updateHPBar:
	ld [wWhichHPBar], a
	predef UpdateHPBar
	ld hl, DrawHUDsAndHPBars
	call CallFromBank0F
	ld hl, Unused_RegainedHealthText
	jp PrintText

.failed:
	call BattleCommand_MoveDelay
	jp PrintButItFailed

Unused_WentToSleepText:
	text "<USER>は"
	line "ねむりはじめた！"
	done

Unused_RestedText:
	text "<USER>は　けんこうになって"
	line "ねむりはじめた！"
	done

Unused_RegainedHealthText:
	text "<USER>は　たいりょくを"
	line "かいふくした！"
	prompt

GetFailureResultText:
	ld de, wPlayerMoveStructEffect
	ldh a, [hBattleTurn]
	and a
	jr z, .go
	ld de, wEnemyMoveStructEffect

.go:
	ld hl, DoesntAffectText
	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	jr z, .got_text
	ld hl, AttackMissedText
	ld a, [wCriticalHit]
	cp -1
	jr nz, .got_text
	ld hl, UnaffectedText

.got_text:
	push de
	call PrintText
	xor a
	ld [wCriticalHit], a

; Take 1/4 of wCurDamage if using Jump Kick/High Jump Kick
	pop de
	ld a, [de]
	cp EFFECT_JUMP_KICK
	ret nz
	ld hl, wCurDamage
	ld a, [hli]
	ld b, [hl]
rept 3
	srl a
	rr b
endr
	ld [hl], b
	dec hl
	ld [hli], a
	or b
	jr nz, .do_at_least_one_damage
	inc a
	ld [hl], a

.do_at_least_one_damage:
	ld hl, CrashedText
	call PrintText
	ld a, 1
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ldh a, [hBattleTurn]
	and a
	jp nz, DoEnemyDamage
	jp DoPlayerDamage

AttackMissedText:
	text "しかし　<USER>の"
	line "こうげきは　はずれた！"
	prompt

CrashedText:
	text "いきおい　あまって"
	line "<USER>は"
	cont "じめんに　ぶつかった！"
	prompt

UnaffectedText:
	text "<TARGET>には"
	line "ぜんぜんきいてない！"
	prompt

PrintDoesntAffect:
	ld hl, DoesntAffectText
	jp PrintText

DoesntAffectText:
	text "<TARGET>には"
	line "こうかが　ない　みたいだ<⋯⋯>"
	prompt

; Prints the message for critical hits or one-hit KOs.

; If there is no message to be printed, wait 20 frames.
BattleCommand_CriticalText:
	ld a, [wCriticalHit]
	and a
	jr z, .wait

	dec a
	add a
	ld hl, .texts
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText

	xor a
	ld [wCriticalHit], a

.wait:
	ld c, 20
	jp DelayFrames

.texts:
	dw CriticalHitText
	dw OneHitKOText

CriticalHitText:
	text "きゅうしょに　あたった！"
	prompt

OneHitKOText:
	text "いちげき　ひっさつ！"
	prompt

BattleCommand_SuperEffectiveText:
	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	cp EFFECTIVE
	ret z
	ld hl, SuperEffectiveText
	jr nc, .print
	ld hl, NotVeryEffectiveText
.print:
	jp PrintText

SuperEffectiveText:
	text "こうかは　ばつぐんだ！"
	prompt

NotVeryEffectiveText:
	text "こうかは　いまひとつの　ようだ"
	prompt

BattleCommand_CheckFaint:
	ld hl, wEnemyMonHP
	ld de, wEnemySubStatus5
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wBattleMonHP
	ld de, wPlayerSubStatus5

.got_hp:
	ld a, [hli]
	or [hl]
	ret nz

	ld a, [de]
	bit SUBSTATUS_DESTINY_BOND, a
	jr z, .no_dbond

	ld hl, TookDownWithItText
	call PrintText

	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyMonMaxHP + 1
	bccoord 2, 2
	ld a, 0
	jr nz, .got_max_hp
	ld hl, wBattleMonMaxHP + 1
	bccoord 10, 9
	ld a, 1

.got_max_hp:
	ld [wWhichHPBar], a
	ld a, [hld]
	ld [wHPBarMaxHP], a
	ld a, [hld]
	ld [wHPBarMaxHP + 1], a
; Back up current HP and set it to 0
	ld a, [hl]
	ld [wHPBarOldHP], a
	xor a
	ld [hld], a
	ld a, [hl]
	ld [wHPBarOldHP + 1], a
	xor a
	ld [hl], a

	ld [wHPBarNewHP], a
	ld [wHPBarNewHP + 1], a
	ld h, b
	ld l, c
	predef UpdateHPBar

	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a

	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	inc a
	ld [wBattleAnimParam], a
	ld a, MOVE_DESTINY_BOND
	call LoadBattleAnim
	pop af
	ldh [hBattleTurn], a

.no_dbond:
	jp EndMoveEffect

TookDownWithItText:
	text "<TARGET>は　<USER>を"
	line "みちずれに　した！"
	prompt

; Used to handle hitting the opponent when they have SUBSTATUS_RAGE.
; However, Rage itself doesn't actually initiate the effect in this build, so this interaction is unseen.
BattleCommand_BuildOpponentRage:
; This jump really wasn't necessary.
	jp .start

.start:
	ld hl, wEnemySubStatus4
	ld de, wEnemyAtkLevel
	ld bc, wEnemyMoveStruct
	ldh a, [hBattleTurn]
	and a
	jr z, .player
	ld hl, wPlayerSubStatus4
	ld de, wPlayerAtkLevel
	ld bc, wPlayerMoveStruct

.player:
	bit SUBSTATUS_RAGE, [hl]
	ret z

	ld a, [de]
	cp $d
	ret z

	ldh a, [hBattleTurn]
	xor 1
	ldh [hBattleTurn], a
; Temporarily replaces target's current move with NULL that raises attack.
	ld h, b
	ld l, c
	ld [hl], 0
	inc hl
	ld [hl], EFFECT_ATTACK_UP
	push hl
	ld hl, RageBuildingText
	call PrintText
; This is where the line that actually raises the target's attack stat WAS... in Gen I.
; In this prototype, the stat-raising call is strangely absent, meaning the prior setup was all for nothing!

; This also means the "rage building" effect is purely visual in this build and doesn't indicate anything.

	pop hl
	xor a
	ld [hld], a
	ld a, MOVE_RAGE
	ld [hl], a

	ldh a, [hBattleTurn]
	xor 1
	ldh [hBattleTurn], a
	ret

RageBuildingText:
	text "<USER>の　いかりの"
	line "ボルテージが　あがっていく！"
	prompt

EndMoveEffect:
	ld a, [wBattleScriptBufferAddress]
	ld l, a
	ld a, [wBattleScriptBufferAddress + 1]
	ld h, a
	ld a, endmove_command
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

PlayerAttackDamage:
	xor a
	ld hl, wCurDamage
	ld [hli], a
	ld [hl], a
	
	ld hl, wPlayerMoveStructPower
	ld a, [hli]
	and a
	ld d, a
	ret z

	ld a, [hl]
	cp SPECIAL_TYPES
	jr nc, .special

; physical
	ld hl, wEnemyMonDefense
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld a, [wEnemySubStatus5]
	bit 2, a
	jr z, .physicalcrit

	sla c
	rl b

.physicalcrit:
	ld hl, wBattleMonAttack
	ld a, [wCriticalHit]
	and a
	jr z, .TruncateHL_BC

	ld c, STAT_DEF
	call GetEnemyMonStat

	ldh a, [hQuotient + 2]
	ld b, a
	ldh a, [hQuotient + 3]
	ld c, a
	push bc
	ld hl, wPartyMon1Attack
	ld a, [wCurBattleMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	pop bc
	jr .TruncateHL_BC

.special:
	ld hl, wEnemyMonSpclDef
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld a, [wEnemySubStatus5]
	bit 1, a
	jr z, .specialcrit
	sla c
	rl b

.specialcrit:
	ld hl, wBattleMonSpclAtk
	ld a, [wCriticalHit]
	and a
	jr z, .TruncateHL_BC

	ld c, STAT_SDEF
	call GetEnemyMonStat

	ldh a, [hQuotient + 2]
	ld b, a
	ldh a, [hQuotient + 3]
	ld c, a
	push bc
	ld hl, wPartyMon1SpclAtk
	ld a, [wCurBattleMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	pop bc

.TruncateHL_BC:
	ld a, [hli]
	ld l, [hl]
	ld h, a
	or b
	jr z, .done

	srl b
	rr c
	srl b
	rr c
	srl h
	rr l
	srl h
	rr l

	ld a, l
	or h
	jr nz, .done

	inc l

.done:
	ld b, l
	ld a, [wBattleMonLevel]
	ld e, a
	ld a, [wCriticalHit]
	and a
	jr z, .return

	sla e

.return:
	ld a, 1
	and a
	ret

EnemyAttackDamage:
	ld hl, wCurDamage
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, wEnemyMoveStructPower
	ld a, [hli]
	ld d, a
	and a
	ret z
	ld a, [hl]
	cp SPECIAL_TYPES
	jr nc, .special

	ld hl, wBattleMonDefense
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld a, [wPlayerSubStatus5]
	bit 2, a
	jr z, .physicalcrit
	sla c
	rl b

.physicalcrit:
	ld hl, wEnemyMonAttack
	ld a, [wCriticalHit]
	and a
	jr z, .TruncateHL_BC
	ld hl, wPartyMon1Defense
	ld a, [wCurBattleMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [hli]
	ld b, a
	ld c, [hl]
	push bc
	ld c, STAT_ATK
	call GetEnemyMonStat
	ld hl, hQuotient + 2
	pop bc
	jr .TruncateHL_BC

.special:
	ld hl, wBattleMonSpclDef
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld a, [wPlayerSubStatus5]
	bit 1, a
	jr z, .specialcrit
	sla c
	rl b

.specialcrit:
	ld hl, wEnemyMonSpclAtk
	ld a, [wCriticalHit]
	and a
	jr z, .TruncateHL_BC
	ld hl, wPartyMon1SpclDef
	ld a, [wCurBattleMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [hli]
	ld b, a
	ld c, [hl]
	push bc
	ld c, STAT_SATK
	call GetEnemyMonStat
	ld hl, hQuotient + 2
	pop bc

.TruncateHL_BC:
	ld a, [hli]
	ld l, [hl]
	ld h, a
	or b
	jr z, .done

	srl b
	rr c
	srl b
	rr c
	srl h
	rr l
	srl h
	rr l

	ld a, l
	or h
	jr nz, .done
	inc l

.done:
	ld b, l
	ld a, [wEnemyMonLevel]
	ld e, a
	ld a, [wCriticalHit]
	and a
	jr z, .return

	sla e

.return:
	ld a, 1
	and a
	and a
	ret

HitSelfInConfusion:
	xor a
	ld hl, wCurDamage
	ld [hli], a
	ld [hl], a
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonDefense
	ld de, wPlayerSubStatus5
	ld a, [wBattleMonLevel]
	jr z, .got_it

	ld hl, wEnemyMonDefense
	ld de, wEnemySubStatus5
	ld a, [wEnemyMonLevel]

.got_it
	push af
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld a, [de]
	bit SUBSTATUS_REFLECT, a
	jr z, .mimic_screen
	sla c
	rl b

.mimic_screen
	dec hl
	dec hl
	dec hl
	ld a, [hli]
	ld l, [hl]
	ld h, a

	or b
	jr z, .done
	srl b
	rr c
	srl b
	rr c
	srl h
	rr l
	srl h
	rr l
	ld a, l
	or h
	jr nz, .done
	inc l

.done:
	ld b, l
	ld d, 40
	pop af
	ld e, a
	ret

GetEnemyMonStat:
	push de
	push bc
	ld a, [wLinkMode]
	cp 3 ; LINK_COLOSSEUM
	jr nz, .notLinkBattle

	ld hl, wOTPartyMon1MaxHP
	dec c
	sla c
	ld b, 0
	add hl, bc
	ld a, [wCurOTMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes

	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ldh [hMultiplicand + 2], a
	pop bc
	pop de
	ret

.notLinkBattle:
	ld a, [wEnemyMonLevel]
	ld [wCurPartyLevel], a
	ld a, [wEnemyMonSpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld hl, wEnemyMonDVs
	ld de, wTempMonDVs
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	pop bc
	ld b, 0
	ld hl, wTempMonSpcExp - $9
	predef CalcMonStatC
	pop de
	ret

; Return a damage value for move power d, player level e, enemy defense c and player attack b.
; Return 1 if successful, else 0.
BattleCommand_DamageCalc:
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStructEffect]
	jr z, .player
	ld a, [wEnemyMoveStructEffect]

.player:
; Selfdestruct and Explosion halve defense.
	cp EFFECT_SELFDESTRUCT
	jr nz, .dont_selfdestruct
	srl c
	jr nz, .dont_selfdestruct
	inc c

.dont_selfdestruct:
; Variable-hit moves and Conversion can have a power of 0.
	cp EFFECT_MULTI_HIT
	jr z, .skip_zero_damage_check
	cp $1e
	jr z, .skip_zero_damage_check

; No damage if move power is 0.
	ld a, d
	and a
	ret z

.skip_zero_damage_check:
; No checks for a defense value of 0, unlike in the final game.
	xor a
	ld hl, hDividend
	ld [hli], a
	ld [hli], a
	ld [hl], a

; Level * 2
	ld a, e
	add a
	jr nc, .level_not_overflowing
	push af
	ld a, 1
	ld [hl], a
	pop af

.level_not_overflowing:
	inc hl
	ld [hli], a

; / 5
	ld a, 5
	ld [hld], a
	push bc
	ld b, 4
	call Divide
	pop bc

; + 2
	inc [hl]
	inc [hl]

; * bp
	inc hl
	ld [hl], d
	call Multiply

; * Attack
	ld [hl], b
	call Multiply

; / Defense
	ld [hl], c
	ld b, 4
	call Divide

; / 50
	ld [hl], 50
	ld b, 4
	call Divide
	
; Item boosts
	call GetUserItem
	ld hl, TypeBoostItems

.NextItem:
	ld a, [hli]
	cp -1
	jr z, .DoneItem

; Item effect
	cp b
	ld a, [hli]
	jr nz, .NextItem

; Type
	ld b, a
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStructType]
	jr z, .player_move_type
	ld a, [wEnemyMoveStructType]
.player_move_type:
	cp b
	jr nz, .DoneItem

; * 100 + item effect amount
	ld a, c
	add 100
	ldh [hMultiplier], a
	call Multiply

; / 100
	ld a, 100
	ldh [hDivisor], a
	ld b, 4
	call Divide

.DoneItem:
; Update wCurDamage. Max 999 (capped at 997, then add 2).
DEF MAX_DAMAGE EQU 999
DEF MIN_DAMAGE EQU 2
DEF DAMAGE_CAP EQU MAX_DAMAGE - MIN_DAMAGE

	ld hl, wCurDamage
	ld b, [hl]
	ldh a, [hQuotient + 3]
	add b
	ldh [hQuotient + 3], a
	jr nc, .dont_cap_1

	ldh a, [hQuotient + 2]
	inc a
	ldh [hQuotient + 2], a
	and a
	jr z, .Cap

.dont_cap_1:
	ldh a, [hQuotient]
	ld b, a
	ldh a, [hQuotient + 1]
	or a
	jr nz, .Cap

	ldh a, [hQuotient + 2]
	cp HIGH(DAMAGE_CAP + 1)
	jr c, .dont_cap_2

	cp HIGH(DAMAGE_CAP + 1) + 1
	jr nc, .Cap

	ldh a, [hQuotient + 3]
	cp LOW(DAMAGE_CAP + 1)
	jr nc, .Cap

.dont_cap_2:
	inc hl

	ldh a, [hQuotient + 3]
	ld b, [hl]
	add b
	ld [hld], a

	ldh a, [hQuotient + 2]
	ld b, [hl]
	adc b
	ld [hl], a
	jr c, .Cap

	ld a, [hl]
	cp HIGH(DAMAGE_CAP + 1)
	jr c, .dont_cap_3

	cp HIGH(DAMAGE_CAP + 1) + 1
	jr nc, .Cap

	inc hl
	ld a, [hld]
	cp LOW(DAMAGE_CAP + 1)
	jr c, .dont_cap_3

.Cap:
	ld a, HIGH(DAMAGE_CAP)
	ld [hli], a
	ld a, LOW(DAMAGE_CAP)
	ld [hld], a

.dont_cap_3:
; Add back MIN_DAMAGE (capping at 999).
	inc hl
	ld a, [hl]
	add MIN_DAMAGE
	ld [hld], a
	jr nc, .dont_floor
	inc [hl]
.dont_floor:

; Returns nz and nc.
	ld a, 1
	and a
	ret

Unused_HighCriticalMoves:
	db MOVE_KARATE_CHOP
	db MOVE_RAZOR_LEAF
	db MOVE_CRABHAMMER
	db MOVE_SLASH
	db -1


INCLUDE "data/types/type_boost_items.inc"

BattleCommand_ConstantDamage:
	ld hl, wBattleMonLevel
	ld de, wPlayerMoveStructEffect
	ldh a, [hBattleTurn]
	and a
	jr z, .got_turn
	ld hl, wEnemyMonLevel
	ld de, wEnemyMoveStructEffect

.got_turn
	ld a, [de]
	cp EFFECT_LEVEL_DAMAGE
	ld b, [hl]
	ld a, 0
	jr z, .got_power

	ld a, [de]
	cp EFFECT_PSYWAVE
	jr z, .psywave

	cp EFFECT_SUPER_FANG
	jr z, .super_fang

	cp EFFECT_REVERSAL
	jr z, .reversal

	inc de
	ld a, [de]
	ld b, a
	ld a, 0
	jr .got_power

.psywave
	ld a, b
	srl a
	add b
	ld b, a
.psywave_loop
	call BattleRandom
	and a
	jr z, .psywave_loop
	cp b
	jr nc, .psywave_loop
	ld b, a
	ld a, 0
	jr .got_power

.super_fang
	ld hl, wEnemyMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wBattleMonHP

.got_hp
	ld a, [hli]
	srl a
	ld b, a
	ld a, [hl]
	rr a
	push af
	ld a, b
	pop bc
	and a
	jr nz, .got_power

	or b
	ld a, 0
	jr nz, .got_power
	ld b, 1
	jr .got_power

.got_power
	ld hl, wCurDamage
	ld [hli], a
	ld [hl], b
	ret

.reversal
	ld hl, wBattleMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .reversal_got_hp
	ld hl, wEnemyMonHP

.reversal_got_hp
	xor a
	ldh [hDividend], a
	ldh [hMultiplicand], a
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hli]
	ldh [hMultiplicand + 2], a
	ld a, 48
	ldh [hMultiplier], a
	call Multiply

	ld a, [hli]
	ld b, a
	ld a, [hl]
	ldh [hDivisor], a
	ld a, b
	and a
	jr z, .skip_to_divide

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

.skip_to_divide
	ld b, 4
	call Divide
	ldh a, [hQuotient + 3]
	ld b, a
	ld hl, FlailReversalPower

.reversal_loop
	ld a, [hli]
	cp b
	jr nc, .break_loop
	inc hl
	jr .reversal_loop

.break_loop
	ldh a, [hBattleTurn]
	and a
	ld a, [hl]
	jr nz, .notPlayersTurn
	ld hl, wPlayerMoveStructPower
	ld [hl], a
	push hl
	call PlayerAttackDamage
	jr .notEnemysTurn

.notPlayersTurn
	ld hl, wEnemyMoveStructPower
	ld [hl], a
	push hl
	call EnemyAttackDamage

.notEnemysTurn
	call BattleCommand_DamageCalc
	pop hl
	ld [hl], 1
	ret

INCLUDE "data/moves/flail_reversal_power.inc"

BattleCommand_Counter:
	ldh a, [hBattleTurn]
	and a
	ld hl, wCurEnemySelectedMove
	ld de, wEnemyMoveStructPower
	jr z, .got_enemy_move
	ld hl, wCurPlayerSelectedMove
	ld de, wPlayerMoveStructPower

.got_enemy_move
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
	cp SPECIAL_TYPES
	ret nc

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
	jr nc, .capped
	ld a, $ff
	ld [hli], a
	ld [hl], a

.capped
	xor a
	ld [wAttackMissed], a
	ret

BattleCommand_Encore:
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemySubStatus5
	ld de, wEnemyEncoreCount
	ld a, [wCurEnemyMove]
	jr z, .ok
	ld hl, wPlayerSubStatus5
	ld de, wPlayerEncoreCount
	ld a, [wCurPlayerMove]

.ok
; Struggle, Mirror Move, and Encore itself can be encored, unlike the final game.
	and a
	jr z, .failed

	bit SUBSTATUS_ENCORED, [hl]
	jr nz, .failed

	ld a, [wAttackMissed]
	and a
	jr nz, .failed
	
	set SUBSTATUS_ENCORED, [hl]
	call BattleRandom
	and 3
	inc a
	inc a
	inc a
	ld [de], a
	call LoadMoveAnim
	ld hl, GotAnEncoreText
	jp PrintText

.failed
	call BattleCommand_MoveDelay
	jp PrintDidntAffectText

GotAnEncoreText:
	text "<TARGET>は"
	line "アンコールを　うけた！"
	prompt

BattleCommand_PainSplit:
	ld a, [wAttackMissed]
	and a
	jp nz, .ButItFailed
	call CheckSubstituteOpp
	jp nz, .ButItFailed

	call LoadMoveAnim
	ld hl, wBattleMonMaxHP + 1
	ld de, wEnemyMonMaxHP + 1
	call .PlayerShareHP

	ld a, 1
	ld [wWhichHPBar], a
	hlcoord 10, 9
	predef UpdateHPBar

	ld hl, wEnemyMonHP
	ld a, [hli]
	ld [wHPBarOldHP + 1], a
	ld a, [hli]
	ld [wHPBarOldHP], a

	ld a, [hli]
	ld [wHPBarMaxHP + 1], a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	call .EnemyShareHP

	xor a
	ld [wWhichHPBar], a
	hlcoord 2, 2
	predef UpdateHPBar
	ld hl, SharedPainText
	jp PrintText

.PlayerShareHP
; Set HPBar's max hp and old hp to match BattleMon
	ld a, [hld]
	ld [wHPBarMaxHP], a
	ld a, [hld]
	ld [wHPBarMaxHP + 1], a
	ld a, [hld]
	ld b, a
	ld [wHPBarOldHP], a
	ld a, [hl]
	ld [wHPBarOldHP + 1], a

; Add player and enemy's HP together
	dec de
	dec de
	ld a, [de]

	dec de
	add b
	ld [wCurDamage + 1], a
	ld b, [hl]
	ld a, [de]
	adc b
; Write half the combined HP totals to wCurDamage
	srl a
	ld [wCurDamage], a
	ld a, [wCurDamage + 1]
	rr a
	ld [wCurDamage + 1], a

	inc hl
	inc hl
	inc hl
; Increasing de back is unnecessary here because it's not read anywhere else
	inc de
	inc de
	inc de

.EnemyShareHP
; Check difference between max HP and current Damage
	ld c, [hl]
	dec hl
	ld a, [wCurDamage + 1]
	sub c
	ld b, [hl]
	dec hl
	ld a, [wCurDamage]
	sbc b
; If difference is negative, set HP to wCurDamage exactly
	jr nc, .skip

	ld a, [wCurDamage]
	ld b, a
	ld a, [wCurDamage + 1]
	ld c, a

.skip
	ld a, c
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, b
	ld [hli], a
	ld [wHPBarNewHP + 1], a
	ret

.ButItFailed
	call BattleCommand_MoveDelay
	jp PrintDidntAffectText

SharedPainText:
	text "おたがいの　たいりょくを"
	line "わかちあった！"
	prompt

BattleCommand_Snore:
	ld hl, wBattleMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, .got_status
	ld hl, wBattleMonStatus

.got_status
	ld a, [hl]
	and SLP
	ret nz
	inc a
	ld [wAttackMissed], a
	ret

BattleCommand_Conversion2:
	ld hl, wEnemyMonType
	ldh a, [hBattleTurn]
	and a
	jr z, .got_type
	ld hl, wBattleMonType

.got_type
	ld a, [wAttackMissed]
	and a
	jr nz, .failed
	call LoadMoveAnim
	ld a, [hli]
	ld b, a
	ld c, [hl]

.loop
	call BattleRandom
	and %11111
; Exclude types the target already has.
	cp b
	jr z, .loop
	cp c
	jr z, .loop

; BUG: Hasn't been modified to include Metal and Dark types yet.
	cp TYPE_METAL
	jr c, .okay
	cp UNUSED_TYPES_END
	jr c, .loop
	cp TYPE_DARK
	jr c, .okay
	jr .loop

.okay
	ld [hld], a
	ld [hl], a
	ld [wNamedObjectIndexBuffer], a
	predef GetTypeName
	ld hl, .TransformedTypeText
	jp PrintText

.TransformedTypeText
	text "<TARGET>の　タイプを"
	line "@"
	text_from_ram wStringBuffer1
	text "に　かえた！"
	prompt

.failed
	jp PrintDidntAffectText

BattleCommand_LockOn:
	ld hl, wEnemySubStatus5
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wPlayerSubStatus5

.got_substatus
	ld a, [wAttackMissed]
	and a
	jr nz, .fail

	call CheckSubstituteOpp
	jp nz, .fail

	set SUBSTATUS_LOCK_ON, [hl]
	call LoadMoveAnim
	ld hl, TookAimText
	jp PrintText

.fail
	call BattleCommand_MoveDelay
	jp PrintDidntAffectText

TookAimText:
	text "<TARGET>を"
	line "ロックオンした！"
	prompt

BattleCommand_Sketch:
	ld a, [wLinkMode]
	cp 3 ; LINK_COLOSSEUM
	jr z, .failed

	call CheckSubstituteOpp
	jp nz, .failed
; BUG: Just like Bide, there is absolutely no handling for when the opponent uses it.
; If the enemy uses it, then it overwrites the player's selected move with Sketch.
; Also: no PP handling. The new move will have the PP of the old move.
	ld hl, wBattleMonMoves
	ld a, [wCurMoveNum]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wCurEnemyMove]
	ld [hl], a

	ld hl, wPartyMon1Moves
	add hl, bc
	ld [hl], a

	ld [wNamedObjectIndexBuffer], a
	call Unreferenced_GetMoveName
	call LoadMoveAnim
	ld hl, SketchedText
	jp PrintText

.failed
	call BattleCommand_MoveDelay
	jp PrintDidntAffectText

SketchedText:
	text "<USER>は"
	line "@"
	text_from_ram wStringBuffer1
	text "を　ダビングした！"
	prompt

; Thaw the opponent if frozen, and 
; raise the user's Attack one stage.
BattleCommand_DefrostOpponent:
	call LoadMoveAnim
	ld hl, wPlayerMoveStructEffect
	ld de, wEnemyMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, .go
	ld hl, wEnemyMoveStructEffect
	ld de, wBattleMonStatus

.go
	push hl
	call Defrost
	pop hl

	ld a, [hl]
	push hl
	push af

	ld a, EFFECT_ATTACK_UP
	ld [hl], a
	call BattleCommand_StatUp

	pop af
	pop hl
	ld [hl], a
	ret

BattleCommand_SleepTalk:
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonMoves + 1
	ld de, wCurPlayerSelectedMove
	ld bc, wPlayerMoveStruct
	ld a, [wBattleMonStatus]
	jr z, .go
	ld hl, wEnemyMonMoves + 1
	ld de, wCurEnemySelectedMove
	ld bc, wEnemyMoveStruct
	ld a, [wEnemyMonStatus]

.go
	and SLP
	jr z, .failed

	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	ld a, [hl]
	and a
	jr z, .failed
	dec hl

.sample_move
; BUG: Disabled moves can be chosen and used with no problem.
; The final game would add checks to prevent this.

; Additionally, final game excludes charge moves because they prevent the user from
; finishing the move until they wake up, trapping the user in a temporary loop.
	push hl
	call BattleRandom
	maskbits NUM_MOVES
	push bc
	ld c, a
	ld b, 0
	add hl, bc
	pop bc

	ld a, [hl]
	pop hl
	and a
	jr z, .sample_move
; Make sure Sleep Talk doesn't try to run itself
	push de
	ld d, a
	ld a, [bc]
	cp d
	ld a, d
	pop de
	jr z, .sample_move

	ld [de], a
	call LoadMoveAnim
	push bc
	call UpdateMoveData
	pop bc
	inc bc
	ld a, [bc]
	call DoMove
	jp EndMoveEffect

.failed
	call BattleCommand_MoveDelay
	jp PrintDidntAffectText

BattleCommand_DestinyBond:
	ld hl, wPlayerSubStatus5
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wEnemySubStatus5

.got_substatus
	set SUBSTATUS_DESTINY_BOND, [hl]
	call LoadMoveAnim
	ld hl, DestinyBondEffectText
	jp PrintText

DestinyBondEffectText:
	text "<USER>は　あいてを"
	line "みちずれに　しようとしている"
	prompt

BattleCommand_Spite:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyMonMoves
	ld de, wOTPartyMon1PP
	ld a, [wCurEnemyMove]
	jr z, .got_moves
	ld hl, wBattleMonMoves
	ld de, wPartyMon1PP
	ld a, [wCurPlayerMove]

.got_moves
	and a
	jr z, .failed
	cp MOVE_STRUGGLE
	jr z, .failed
	ld b, a
	ld c, -1

.loop
	inc c
	ld a, [hli]
	cp b
	jr nz, .loop

	ld [wNamedObjectIndexBuffer], a
	dec hl
	ld b, 0
	push bc
	ld c, wBattleMonPP - wBattleMonMoves
	add hl, bc
	pop bc
	ld a, [hl]
	and PP_MASK
	jr z, .failed
	push bc
	push de
	call Unreferenced_GetMoveName
	pop de

	call BattleRandom
	and %11
	inc a
	inc a
	ld b, a
	ld a, [hl]
	and PP_MASK
	cp b
	jr nc, .deplete_pp
	ld b, a

.deplete_pp
; BUG: If the target is transformed, then the move in the same slot in the monster's
; original moveset will have its PP overwritten to match the new value.
; This was fixed in the final game.
	ld a, b
	ld [wTextDecimalByte], a
	ld a, [hl]
	sub b
	ld [hl], a
	ld h, d
	ld l, e
	pop bc
	add hl, bc
	ld [hl], a
	call LoadMoveAnim
	ld hl, SpiteEffectText
	jp PrintText

.failed
	call BattleCommand_MoveDelay
	jp PrintDidntAffectText

SpiteEffectText:
	text "<TARGET>の"
	line "@"
	text_from_ram wStringBuffer1
	text "を　@"
	deciram wTextDecimalByte, 1, 1
	text "けずった！"
	prompt

BattleCommand_FalseSwipe:
; Makes sure wCurDamage < MonHP
	ld de, wEnemyMonHP + 1
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld de, wBattleMonHP + 1

.got_hp
	ld hl, wCurDamage + 1
	ld a, [de]
	dec de
	sub [hl]
	dec hl
	ld a, [de]
	sbc [hl]
	jr z, .hp_under_256
	jr c, .hp_underflow
	jr .done

.hp_under_256
; If HP is a multiple of 256, continue
	inc hl
	inc de
	ld a, [de]
	cp [hl]
	jr nz, .done
	dec hl
	dec de

.hp_underflow
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hl], a
	dec [hl]
	ld a, [hl]
	inc a
	jr nz, .set_carry_flag
	dec hl
	dec [hl]

.set_carry_flag
	scf
	ret

.done
	and a
	ret

BattleCommand_BellChime:
	ld hl, wBattleMonStatus
	ld de, wPlayerSubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, .got_status
	ld hl, wEnemyMonStatus
	ld de, wEnemySubStatus1

.got_status
	ld a, [hli]
	or [hl]
	jr z, .failed
	xor a
	ld [hld], a
	ld [hl], a
	ld a, [de]
	res SUBSTATUS_NIGHTMARE, a
	ld [de], a
	call LoadMoveAnim
	ld hl, BellChimedText
	jp PrintText

.failed
	call BattleCommand_MoveDelay
	jp PrintNoChangesText

BellChimedText:
	text "<USER>の"
	line "ステータスいじょうが　なおった！"
	prompt

PlayFXAnimID:
	ld a, e
	ld [wFXAnimID], a
	ld a, d
	ld [wFXAnimID + 1], a

	ld c, 3
	call DelayFrames
	jpfar PlayBattleAnim

DoEnemyDamage:
	ld hl, wCurDamage
	ld a, [hli]
	ld b, a
	ld a, [hl]
	or b
	jr z, .did_no_damage

	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	jp nz, DoSubstituteDamage

	ld a, [hld]
	ld b, a
	ld a, [wEnemyMonHP + 1]
	ld [wHPBarOldHP], a
	sub b
	ld [wEnemyMonHP + 1], a
	ld a, [hl]
	ld b, a
	ld a, [wEnemyMonHP]
	ld [wHPBarOldHP + 1], a
	sbc b
	ld [wEnemyMonHP], a
	jr nc, .no_underflow
	
	ld a, [wHPBarOldHP + 1]
	ld [hli], a
	ld a, [wHPBarOldHP]
	ld [hl], a
	xor a
	ld hl, wEnemyMonHP
	ld [hli], a
	ld [hl], a

.no_underflow:
	ld hl, wEnemyMonMaxHP
	ld a, [hli]
	ld [wHPBarMaxHP + 1], a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld hl, wEnemyMonHP
	ld a, [hli]
	ld [wHPBarNewHP + 1], a
	ld a, [hl]
	ld [wHPBarNewHP], a

	hlcoord 2, 2
	xor a
	ld [wWhichHPBar], a
	predef UpdateHPBar
.did_no_damage:
	ld hl, DrawHUDsAndHPBars
	jp CallFromBank0F

DoPlayerDamage:
	ld hl, wCurDamage
	ld a, [hli]
	ld b, a
	ld a, [hl]
	or b
	jr z, .did_no_damage

	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	jp nz, DoSubstituteDamage

	ld a, [hld]
	ld b, a
	ld a, [wBattleMonHP + 1]
	ld [wHPBarOldHP], a
	sub b
	ld [wBattleMonHP + 1], a
	ld [wHPBarNewHP], a
	ld b, [hl]
	ld a, [wBattleMonHP]
	ld [wHPBarOldHP + 1], a
	sbc b
	ld [wBattleMonHP], a
	ld [wHPBarNewHP + 1], a
	jr nc, .no_underflow

	ld a, [wHPBarOldHP + 1]
	ld [hli], a
	ld a, [wHPBarOldHP]
	ld [hl], a
	xor a
	ld hl, wBattleMonHP
	ld [hli], a
	ld [hl], a
	ld hl, wHPBarNewHP
	ld [hli], a
	ld [hl], a

.no_underflow:
	ld hl, wBattleMonMaxHP
	ld a, [hli]
	ld [wHPBarMaxHP + 1], a
	ld a, [hl]
	ld [wHPBarMaxHP], a

	hlcoord 10, 9
	ld a, 1
	ld [wWhichHPBar], a
	predef UpdateHPBar

.did_no_damage:
	ld hl, DrawHUDsAndHPBars
	jp CallFromBank0F

DoSubstituteDamage:
	ld hl, SubTookDamageText
	call PrintText
	ld de, wEnemySubstituteHP
	ld bc, wEnemySubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld de, wPlayerSubstituteHP
	ld bc, wPlayerSubStatus4

.got_hp:
	ld hl, wCurDamage
	ld a, [hli]
	and a
	jr nz, .broke
	ld a, [de]
	sub [hl]
	ld [de], a
	ret nc

.broke:
	ld h, b
	ld l, c
	res SUBSTATUS_SUBSTITUTE, [hl]
	ld hl, SubFadedText
	call PrintText

	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a

	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a

	ld a, 3
	ld [wBattleAnimParam], a
	ld a, MOVE_SUBSTITUTE
	call LoadBattleAnim
	pop af
	ldh [hBattleTurn], a
	ldh a, [hBattleTurn]
	ld hl, wPlayerMoveStructEffect
	and a
	jr z, .got_move_effect
	ld hl, wEnemyMoveStructEffect

; Cancel move effect
.got_move_effect:
	xor a
	ld [hl], a
	ld hl, DrawHUDsAndHPBars
	jp CallFromBank0F

SubTookDamageText:
	text "<TARGET>に　かわって"
	line "ぶんしんが　こうげきを　うけた！"
	prompt

SubFadedText:
	text "<TARGET>の　ぶんしんは"
	line "きえてしまった<⋯⋯>"
	prompt

UpdateMoveData:
	ldh a, [hBattleTurn]
	and a
	jp z, .player

	ld hl, wEnemySubStatus5
	ld de, wEnemyMoveStruct
	ld bc, wCurEnemyMove
	push bc
	ld a, [wCurEnemySelectedMove]
	ld b, a
	jr .get_move_data

.player:
	ld hl, wPlayerSubStatus5
	ld de, wPlayerMoveStruct
	ld bc, wCurPlayerMove
	push bc
	ld a, [wCurPlayerSelectedMove]
	ld b, a
	ld a, [wcabe]
	and a
	jr z, .get_move_data
	ld b, a

.get_move_data:
	ld a, b
	pop bc
	and a
	bit SUBSTATUS_ENCORED, [hl]
	jr nz, .encored

	ld [wCurSpecies], a
	ld [wNamedObjectIndexBuffer], a
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call FarCopyBytes
	jr .get_move_name

.encored:
	ld a, [bc]
	ld [wCurSpecies], a
	ld [wNamedObjectIndexBuffer], a

.get_move_name:
	call Unreferenced_GetMoveName
	jp CopyStringToStringBuffer2

; Unreferenced. Seems to be early sleep code leftover from Gen 1.
; It was used at SOME point, seeing as compatibility with held items was added.
Unreferenced_OldSleepTarget:
	ld de, wEnemyMonStatus
	ld bc, wEnemySubStatus4
	ldh a, [hBattleTurn]
	and a
	jp z, .player
	ld de, wBattleMonStatus
	ld bc, wPlayerSubStatus4

.player:
	ld a, [bc]
	bit SUBSTATUS_RECHARGE, a
	res SUBSTATUS_RECHARGE, a
	ld [bc], a
	jr nz, .set_sleep_counter
	; Return if it already has a status effect
	ld a, [de]
	and a
	ret nz
	; Return if the move would be not very effective
	ld a, [wTypeModifier]
	and $7f
	cp EFFECTIVE
	ret c
	; Check held item effect and return if it prevents sleep
	call GetOpponentItem
	ld a, b
	cp HELD_PREVENT_SLEEP
	ret z
	; Return if effect chance isn't met
	call BattleCommand_EffectChance
	ret nc
	; Return if Safeguard is protecting the target
	call SafeCheckSafeguard
	ret nz

.set_sleep_counter:
	; Set sleep counter to between 1 and 7
	call BattleRandom
	and 7
	jr z, .set_sleep_counter

	ld [de], a
	call PlayDamageAnim
	push de
	ld hl, DrawHUDsAndHPBars
	call CallFromBank0F

	ld hl, FellAsleepText
	call PrintText
	pop de

	; Check for held items. If it has one of the below effects, the item is used.

	call GetOpponentItem
	ld a, b
	cp HELD_HEAL_SLEEP
	jr z, .cure_sleep
	cp HELD_HEAL_STATUS
	jr z, .cure_sleep
	cp HELD_FULL_RESTORE
	jr z, .cure_sleep
	ret

.cure_sleep:
	ld a, [de]
	and ~SLP
	ld [de], a
	ld a, [hl]
	call PrintRecoveredUsingItem
	call ConsumeHeldItem
	ld hl, DrawHUDsAndHPBars
	jp CallFromBank0F

FellAsleepText:
	text "<TARGET>は"
	line "ねむってしまった！"
	prompt

BattleCommand_SleepTarget:
	ld de, wEnemyMonStatus
	ld bc, wEnemySubStatus4
	ldh a, [hBattleTurn]
	and a
	jp z, .player
	ld de, wBattleMonStatus
	ld bc, wPlayerSubStatus4

.player:
	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	cp EFFECTIVE
	ld hl, DoesntAffectText
	jr c, .fail
	
	push bc
	call GetOpponentItem
	ld a, b
	pop bc
	cp HELD_PREVENT_SLEEP
	jr nz, .not_protected_by_item

	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	ld hl, ProtectedByText
	jr .fail

.not_protected_by_item:
	ld a, [de]
	and SLP
	ld hl, AlreadyAsleepText
	jr nz, .fail

	ld hl, DidntAffectText
	ld a, [de]
	and a
	jr nz, .fail

	call CheckSubstituteOpp
	jr nz, .fail

	ld a, [bc]
	bit SUBSTATUS_RECHARGE, a
	res SUBSTATUS_RECHARGE, a
	ld [bc], a
	jr nz, .random_loop
	
	ld a, [wAttackMissed]
	and a
	jr nz, .fail

.random_loop:
	call BattleRandom
	and 7
	jr z, .random_loop

	ld [de], a
	call PlayDamageAnim
	push de
	ld hl, DrawHUDsAndHPBars
	call CallFromBank0F

	ld hl, FellAsleepText
	call PrintText

	pop de
	call GetOpponentItem
	ld a, b
	cp HELD_HEAL_SLEEP
	jr z, .use_item
	cp HELD_HEAL_STATUS
	jr z, .use_item
	cp HELD_FULL_RESTORE
	jr z, .use_item
	ret

.use_item:
	ld a, [de]
	and ~SLP
	ld [de], a
	ld a, [hl]
	call PrintRecoveredUsingItem
	call ConsumeHeldItem
	ld hl, DrawHUDsAndHPBars
	jp CallFromBank0F

.fail:
	call BattleCommand_MoveDelay
	jp PrintText

AlreadyAsleepText:
	text "<TARGET>は　すでに"
	line "ねむっている"
	prompt

BattleCommand_PoisonTarget:
	ld de, wEnemyMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, .got_status
	ld de, wBattleMonStatus

.got_status
	call CheckSubstituteOpp
	ret nz
	ld a, [de]
	and a
	ret nz

	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	cp EFFECTIVE
	ret c

	call GetOpponentItem
	ld a, b
	cp HELD_PREVENT_POISON
	ret z

	call BattleCommand_EffectChance
	ret nc
	call SafeCheckSafeguard
	ret nz

	ld a, [de]
	set PSN, a
	ld [de], a

	push de
	ld de, ANIM_PSN
	call PlayOpponentBattleAnim
	ld hl, DrawHUDsAndHPBars
	call CallFromBank0F
	ld hl, WasPoisonedText
	call PrintText

	pop de
	call GetOpponentItem
	ld a, b
	cp HELD_HEAL_POISON
	jr z, .use_item
	cp HELD_HEAL_STATUS
	jr z, .use_item
	cp HELD_FULL_RESTORE
	jr z, .use_item
	ret

.use_item
	ld a, [de]
	res PSN, a
	ld [de], a
	ld a, [hl]
	call PrintRecoveredUsingItem
	call ConsumeHeldItem
	ld hl, DrawHUDsAndHPBars
	jp CallFromBank0F

WasPoisonedText:
	text "<TARGET>は　どくをあびた！"
	prompt

BattleCommand_Poison:
	ld de, wEnemyMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, .got_status
	ld de, wBattleMonStatus

.got_status
	ld hl, DoesntAffectText
	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	cp EFFECTIVE
	jp c, .failed

; BUG: Checks for the Poison bit, but not any other statuses.
; I'm sure this won't come up later...
	ld hl, AlreadyPoisonedText
	ld a, [de]
	bit PSN, a
	jp nz, .failed

	call GetOpponentItem
	ld a, b
	cp HELD_PREVENT_POISON
	jr nz, .do_poison

	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	ld hl, ProtectedByText
	jr .failed

.do_poison
; BUG: the comparison from "cp HELD_PREVENT_POISON" is still loaded in flags.
; Therefore it will never fail here, and poison can stack on top of other status conditions.
; Fixed in the final version by loading and properly comparing mon's status here.
	ld hl, DidntAffectText
	and a
	jr nz, .failed

	call CheckSubstituteOpp
	jr nz, .failed
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	ld a, [de]
	set PSN, a
	ld [de], a

	push de
	call .check_toxic
	jr z, .toxic

	call PlayDamageAnim
	ld hl, WasPoisonedText
	call PrintText
	jr .finished

.toxic
	set SUBSTATUS_TOXIC, [hl]
	xor a
	ld [de], a
	call PlayDamageAnim
	ld hl, DrawHUDsAndHPBars
	call CallFromBank0F

	ld hl, BadlyPoisonedText
	call PrintText

.finished
	pop de
	call GetOpponentItem
	ld a, b
	cp HELD_HEAL_POISON
	jr z, .use_item
	cp HELD_HEAL_STATUS
	jr z, .use_item
	cp HELD_FULL_RESTORE
	jr z, .use_item
	ret

.use_item
	ld a, [de]
	res PSN, a
	ld [de], a
	ld a, [hl]
	call PrintRecoveredUsingItem
	call ConsumeHeldItem
	ld hl, DrawHUDsAndHPBars
	call CallFromBank0F
	call .check_toxic
	ret nz
	res SUBSTATUS_TOXIC, [hl]
	ret

.check_toxic
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStructEffect]
	ld hl, wEnemySubStatus5
	ld de, wEnemyToxicCount
	jr z, .ok
	ld a, [wEnemyMoveStructEffect]
	ld hl, wPlayerSubStatus5
	ld de, wPlayerToxicCount

.ok
	cp EFFECT_TOXIC
	ret

.failed
	call BattleCommand_MoveDelay
	jp PrintText

AlreadyPoisonedText:
	text "<TARGET>は　すでに"
	line "どくを　あびている"
	prompt

BadlyPoisonedText:
	text "<TARGET>は"
	line "もうどくをあびた！"
	prompt

BattleCommand_DrainTarget:
	call SapHealth
	ld hl, SuckedHealthText
	jp PrintText

SuckedHealthText:
	text "<TARGET>から"
	line "たいりょくを　すいとった！"
	prompt

BattleCommand_EatDream:
	call SapHealth
	ld hl, DreamEatenText
	jp PrintText

DreamEatenText:
	text "<TARGET>の"
	line "ゆめを　くった！"
	prompt

SapHealth:
	; Divide damage by two
	ld hl, wCurDamage
	ld a, [hl]
	srl a
	ld [hli], a
	ld a, [hl]
	rr a
	ld [hld], a
	or [hl]
	jr nz, .at_least_one
	inc hl
	inc [hl]

.at_least_one:
	ld hl, wBattleMonHP
	ld de, wBattleMonMaxHP
	ldh a, [hBattleTurn]
	and a
	jp z, .battlemonhp
	ld hl, wEnemyMonHP
	ld de, wEnemyMonMaxHP

.battlemonhp:
	; Store current HP in little endian wHPBarOldHP
	ld bc, wHPBarOldHP + 1
	ld a, [hli]
	ld [bc], a
	ld a, [hl]
	dec bc
	ld [bc], a

	; Store max HP in little endian wHPBarMaxHP
	ld a, [de]
	dec bc
	ld [bc], a
	inc de
	ld a, [de]
	dec bc
	ld [bc], a

	; Add wCurDamage to current HP and copy it to little endian wHPBarNewHP
	ld a, [wCurDamage + 1]
	ld b, [hl]
	add b
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [wCurDamage]
	ld b, [hl]
	adc b
	ld [hli], a
	ld [wHPBarNewHP + 1], a
	jr c, .max_hp

	; Subtract current HP from max HP (to see if we have more than max HP)
	ld a, [hld]
	ld b, a
	ld a, [de]
	dec de
	sub b
	ld a, [hli]
	ld b, a
	ld a, [de]
	inc de
	sbc b
	jr nc, .finish

.max_hp:
	ld a, [de]
	ld [hld], a
	ld [wHPBarNewHP], a
	dec de
	ld a, [de]
	ld [hli], a
	ld [wHPBarNewHP + 1], a
	inc de

.finish:
	ldh a, [hBattleTurn]
	and a
	hlcoord 10, 9
	ld a, 1
	jr z, .hp_bar
	hlcoord 2, 2
	xor a

.hp_bar:
	ld [wWhichHPBar], a
	predef UpdateHPBar
	predef UpdatePlayerHUD
	predef UpdateEnemyHUD
	ld hl, UpdateBattleMonInParty
	jp CallFromBank0F

BattleCommand_BurnTarget:
	xor a
	ld [wNumHits], a
	call CheckSubstituteOpp
	ret nz
	ld de, wEnemyMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, .got_status
	ld de, wBattleMonStatus

.got_status
	ld a, [de]
	and a
	jp nz, Defrost
	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	cp EFFECTIVE
	ret c

	call GetOpponentItem
	ld a, b
	cp HELD_PREVENT_BURN
	ret z
	call BattleCommand_EffectChance
	ret nc
	call SafeCheckSafeguard
	ret nz

	ld a, [de]
	set BRN, a
	ld [de], a
	push de

	ld hl, ApplyBrnEffectOnAttack
	call CallFromBank0F
	ld de, ANIM_BRN
	call PlayOpponentBattleAnim
	ld hl, DrawHUDsAndHPBars
	call CallFromBank0F
	ld hl, WasBurnedText
	call PrintText
	
	call GetOpponentItem
	ld a, b
	pop de
	cp HELD_HEAL_BURN
	jr z, .use_item
	cp HELD_HEAL_STATUS
	jr z, .use_item
	cp HELD_FULL_RESTORE
	jr z, .use_item
	ret

.use_item
	ld a, [de]
	res BRN, a
	ld [de], a
	ld a, [hl]
	call PrintRecoveredUsingItem
	call ConsumeHeldItem
	ld hl, DrawHUDsAndHPBars
	jp CallFromBank0F

WasBurnedText:
	text "<TARGET>は"
	line "やけどをおった！"
	prompt

Defrost:
	ld a, [de]
	and 1 << FRZ
	ret z
	xor a
	ld [de], a
	ldh a, [hBattleTurn]
	and a
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Status
	jr z, .ok
	ld hl, wPartyMon1Status
	ld a, [wCurBattleMon]

.ok
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	xor a
	ld [hl], a
	ld hl, DefrostedOpponentText
	jp PrintText

DefrostedOpponentText:
	text "ほのおをあびて<TARGET>の"
	line "こおりが　とけた！"
	prompt

BattleCommand_FreezeTarget:
	xor a
	ld [wNumHits], a
	call CheckSubstituteOpp
	ret nz
	ld de, wEnemyMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, .got_status
	ld de, wBattleMonStatus

.got_status
	ld a, [de]
	and a
	ret nz
	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	cp EFFECTIVE
	ret c

	call GetOpponentItem
	ld a, b
	cp HELD_PREVENT_FREEZE
	ret z
	call BattleCommand_EffectChance
	ret nc
	call SafeCheckSafeguard
	ret nz

	ld a, [de]
	set FRZ, a
	ld [de], a
	push de
	call EndRechargeOpp

	ld de, ANIM_FRZ
	call PlayOpponentBattleAnim
	ld hl, DrawHUDsAndHPBars
	call CallFromBank0F
	ld hl, WasFrozenText
	call PrintText

	call GetOpponentItem
	ld a, b
	pop de
	cp HELD_HEAL_FREEZE
	jr z, .use_item
	cp HELD_HEAL_STATUS
	jr z, .use_item
	cp HELD_FULL_RESTORE
	jr z, .use_item
	ret

.use_item
	ld a, [de]
	res FRZ, a
	ld [de], a
	ld a, [hl]
	call PrintRecoveredUsingItem
	call ConsumeHeldItem
	ld hl, DrawHUDsAndHPBars
	jp CallFromBank0F

WasFrozenText:
	text "<TARGET>は"
	line "こおりづけになった！"
	prompt

BattleCommand_ParalyzeTarget:
	xor a
	ld [wNumHits], a
	call CheckSubstituteOpp
	ret nz
	ld de, wEnemyMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, .got_status
	ld de, wBattleMonStatus

.got_status
	ld a, [de]
	and a
	ret nz
	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	cp EFFECTIVE
	ret c

	call GetOpponentItem
	ld a, b
	cp HELD_PREVENT_PARALYZE
	ret z
	call BattleCommand_EffectChance
	ret nc
	call SafeCheckSafeguard
	ret nz

	ld a, [de]
	set PAR, a
	ld [de], a
	push de
	ld hl, ApplyPrzEffectOnSpeed
	call CallFromBank0F
	ld de, ANIM_PAR
	call PlayOpponentBattleAnim
	ld hl, DrawHUDsAndHPBars
	call CallFromBank0F
	call PrintParalyze

	call GetOpponentItem
	ld a, b
	pop de
	cp HELD_HEAL_PARALYZE
	jr z, .use_item
	cp HELD_HEAL_STATUS
	jr z, .use_item
	cp HELD_FULL_RESTORE
	jr z, .use_item
	ret

.use_item:
	ld a, [de]
	res PAR, a
	ld [de], a
	ld a, [hl]
	call PrintRecoveredUsingItem
	call ConsumeHeldItem
	ld hl, DrawHUDsAndHPBars
	jp CallFromBank0F

BattleCommand_StatUp:
	ld hl, wPlayerStatLevels
	ld de, wPlayerMoveStructEffect
	ldh a, [hBattleTurn]
	and a
	jr z, .got_stat_levels
	ld hl, wEnemyStatLevels
	ld de, wEnemyMoveStructEffect

.got_stat_levels
	ld a, [de]
	sub EFFECT_ATTACK_UP
	cp NUM_LEVEL_STATS
	jr c, .increment_stat_level

	; Map +2 effects to corresponding +1 effects
	sub (EFFECT_ATTACK_UP_2 - EFFECT_ATTACK_UP)

.increment_stat_level
; Try to increase stat, and fail if already at maximum stat level
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	inc b
	ld a, MAX_STAT_LEVEL
	cp b
	jp c, .cant_raise_stat

; Increase stat again if move has an UP_2 effect
	ld a, [de]
	cp EFFECT_ATTACK_UP + NUM_LEVEL_STATS
	jr c, .got_num_stages

	inc b
	ld a, MAX_STAT_LEVEL
	cp b
	jr nc, .got_num_stages
	ld b, a

.got_num_stages
; Store increased stat
	ld [hl], b
	ld a, c
; BUG: This code is supposed to check for ACCURACY or greater, but this code predates
; the addition of the Special Defense stat, so it uses an old stat index.
; This means that Special Defense generally is not affected by stat boosts in this build.
; (The rare exceptions being when ApplyStatLevelMultiplierOnAllStats is called, i.e. Baton Pass)
	cp SP_DEFENSE
	jr nc, .done_calcing_stats
	push hl
	ld hl, wBattleMonStats + 1
	ld de, wPlayerStats
	ldh a, [hBattleTurn]
	and a
	jr z, .got_stats_pointer
	ld hl, wEnemyMonStats + 1
	ld de, wEnemyStats

.got_stats_pointer
	push bc
	sla c
	ld b, 0
	add hl, bc
	ld a, c
	add e
	ld e, a
	jr nc, .no_carry
	inc d

.no_carry
	pop bc
	ld a, [hld]
	sub LOW(MAX_STAT_VALUE)
	jr nz, .not_already_max
	ld a, [hl]
	sbc HIGH(MAX_STAT_VALUE)
	jp z, .stats_already_max

.not_already_max
	push hl
	push bc

	ld hl, StatLevelMultipliers
	dec b
	sla b
	ld c, b
	ld b, 0
	add hl, bc
	pop bc

	xor a
	ldh [hMultiplicand], a
	ld a, [de]
	ldh [hMultiplicand + 1], a
	inc de
	ld a, [de]
	ldh [hMultiplicand + 2], a

	ld a, [hli]
	ldh [hMultiplier], a
	call Multiply

	ld a, [hl]
	ldh [hDivisor], a
	ld b, 4
	call Divide

	pop hl
	ldh a, [hQuotient + 3]
	sub LOW(MAX_STAT_VALUE)
	ldh a, [hQuotient + 2]
	sbc HIGH(MAX_STAT_VALUE)
	jp c, .not_maxed_out

	ld a, HIGH(MAX_STAT_VALUE)
	ldh [hQuotient + 2], a
	ld a, LOW(MAX_STAT_VALUE)
	ldh [hQuotient + 3], a

.not_maxed_out
	ldh a, [hQuotient + 2]
	ld [hli], a
	ldh a, [hQuotient + 3]
	ld [hl], a
	pop hl

.done_calcing_stats
	ld b, c
	inc b
	call GetStatName

; Checks for if Minimize is used, and if so set w[user]Minimized
; Seems to be set up to check either Mist or Substitute as well, but the SubStatus4 is never actually read
	ld hl, wPlayerSubStatus4
	ld de, wPlayerMoveStruct
	ld bc, wPlayerMinimized
	ldh a, [hBattleTurn]
	and a
	jr z, .player_turn
	ld hl, wEnemySubStatus4
	ld de, wEnemyMoveStruct
	ld bc, wEnemyMinimized

.player_turn
	call BattleCommand_LowerSub
	call LoadMoveAnim
	call BattleCommand_RaiseSub
	ld a, [de]
	cp MOVE_MINIMIZE
	jr nz, .not_minimize
	pop bc
	ld a, 1
	ld [bc], a

.not_minimize
	ldh a, [hBattleTurn]
	and a
; BUG: All stats except for the currently raised stat are badge-boosted again.
	ld hl, BadgeStatBoosts
	call z, CallFromBank0F

	ld hl, Text_BattleEffectActivate
	call PrintText
	
; BUG: Incorrectly checks the opponents' Pokémon for burn and
; paralysis penalties, while leaving the player untouched.

; Additionally, the same penalty will keep stacking each time it triggers.
; Final game fixes this by recalculating the stats each time.
	ld hl, ApplyPrzEffectOnSpeed
	call CallFromBank0F
	ld hl, ApplyBrnEffectOnAttack
	jp CallFromBank0F

.stats_already_max
	pop hl
	dec [hl]

.cant_raise_stat
	call BattleCommand_MoveDelay
	jp PrintNoChangesText

Text_BattleEffectActivate:
	text "<USER>の"
	line "@"
	text_from_ram wStringBuffer2
	text "が@"
	start_asm

	ld hl, .BattleStatWentWayUpText
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStructEffect]
	jr z, .got_effect
	ld a, [wEnemyMoveStructEffect]

.got_effect
	cp EFFECT_ATTACK_UP + NUM_LEVEL_STATS
	ret nc
	ld hl, .BattleStatWentUpText
	ret

.BattleStatWentWayUpText
	text_exit
	text "<SCROLL>ぐーんと@"
	; Fallthrough. These strings are connected in Japanese, but separate in English.

.BattleStatWentUpText
	text "　あがった！"
	prompt

BattleCommand_StatDown:
	ld hl, wEnemyStatLevels
	ld de, wPlayerMoveStructEffect
	ldh a, [hBattleTurn]
	and a
	jr z, .got_stat_levels

	ld hl, wPlayerStatLevels
	ld de, wEnemyMoveStructEffect
	ld a, [wLinkMode]
	cp 3 ; LINK_COLOSSEUM
	jr z, .got_stat_levels
; 25% chance for enemy monsters' stat-lowering moves to fail
	call BattleRandom
	cp 25 percent + 1
	jp c, .missed

.got_stat_levels
	call CheckSubstituteOpp
	jp nz, .missed
	ld a, [de]
	cp EFFECT_ATTACK_DOWN_HIT
	jr c, .is_damaging_move

	call BattleCommand_EffectChance
	jp nc, .failed

	ld a, [de]
	sub EFFECT_ATTACK_DOWN_HIT
	jr .decrease_stat_level

.is_damaging_move
	push hl
	push de
	call BattleCommand_CheckHit
	pop de
	pop hl
	ld a, [wAttackMissed]
	and a
	jp nz, .missed

	call CheckHiddenOpponent
	jp nz, .missed

	ld a, [de]
	sub EFFECT_ATTACK_DOWN
	cp NUM_LEVEL_STATS
	jr c, .decrease_stat_level
	sub (EFFECT_ATTACK_DOWN_2 - EFFECT_ATTACK_DOWN)

.decrease_stat_level
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	dec b
	jp z, .failed

	ld a, [de]
	cp EFFECT_ATTACK_DOWN_2 - $16 ; $24. EFFECT_24 is seemingly not used
	jr c, .got_num_stages
	cp EFFECT_ATTACK_DOWN_HIT
	jr nc, .got_num_stages
	dec b
	jr nz, .got_num_stages
	inc b

.got_num_stages
; Store decreased stat level
	ld [hl], b
	ld a, c
; BUG: Same issue as BattleCommand_StatUp. Special Defense is not recalculated.
	cp SP_DEFENSE
	jr nc, .done_calcing_stats
	push hl
	push de
	ld hl, wEnemyMonStats + 1
	ld de, wEnemyStats
	ldh a, [hBattleTurn]
	and a
	jr z, .got_stats_pointer
	ld hl, wBattleMonStats + 1
	ld de, wPlayerStats

.got_stats_pointer
	push bc
	sla c
	ld b, 0
	add hl, bc
	ld a, c
	add e
	ld e, a
	jr nc, .no_carry
	inc d

.no_carry
	pop bc
	ld a, [hld]
	sub 1
	jr nz, .not_already_min
	ld a, [hl]
	and a
	jp z, .stats_already_min

.not_already_min
	push hl
	push bc

	ld hl, StatLevelMultipliers
	dec b
	sla b
	ld c, b
	ld b, 0
	add hl, bc
	pop bc

	xor a
	ldh [hMultiplicand], a
	ld a, [de]
	ldh [hMultiplicand + 1], a
	inc de
	ld a, [de]
	ldh [hMultiplicand + 2], a

	ld a, [hli]
	ldh [hMultiplier], a
	call Multiply

	ld a, [hl]
	ldh [hDivisor], a
	ld b, 4
	call Divide

	pop hl
	ldh a, [hQuotient + 3]
	ld b, a
	ldh a, [hQuotient + 2]
	or b
	jp nz, .not_zero

	ldh [hQuotient + 2], a
	ld a, 1
	ldh [hQuotient + 3], a

.not_zero
	ldh a, [hQuotient + 2]
	ld [hli], a
	ldh a, [hQuotient + 3]
	ld [hl], a
	pop de
	pop hl

.done_calcing_stats
	ld b, c
	inc b
	push de
	call GetStatName

	pop de
	ld a, [de]
	cp EFFECT_ATTACK_DOWN_HIT
	jr nc, .non_damaging
	call PlayDamageAnim

.non_damaging
	ldh a, [hBattleTurn]
	and a
; Badge Boosts applied again on the player.
; See BattleCommand_StatUp for what goes wrong here.
	ld hl, BadgeStatBoosts
	call nz, CallFromBank0F
	ld hl, Text_BattleFoeEffectActivate
	call PrintText

; Same problem as with BattleCommand_StatUp: the stat decreases can stack.
	ld hl, ApplyPrzEffectOnSpeed
; For some reason, this was "fixed" here so that it happens to the player,
; but not the opponent, and only for the paralysis speed drop...
; This sounds like a Link Battle desync waiting to happen.
	call nz, CallFromBank0F
	ld hl, ApplyBrnEffectOnAttack
	jp CallFromBank0F

.stats_already_min
	pop de
	pop hl
	inc [hl]

.failed
	ld a, [de]
	cp EFFECT_ATTACK_DOWN_HIT
	ret nc
	call BattleCommand_MoveDelay
	jp PrintNoChangesText

.missed
	ld a, [de]
	cp EFFECT_ATTACK_DOWN_HIT
	ret nc
	call BattleCommand_MoveDelay
	jp TryPrintButItFailed

Text_BattleFoeEffectActivate:
	text "<TARGET>の"
	line "@"
	text_from_ram wStringBuffer2
	text "が@"
	start_asm
	ld hl, .BattleStatFellText
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStructEffect]
	jr z, .got_effect
	ld a, [wEnemyMoveStructEffect]

.got_effect
	cp EFFECT_ATTACK_DOWN + NUM_LEVEL_STATS
	ret c
	cp EFFECT_ATTACK_DOWN_HIT
	ret nc
	ld hl, .BattleStatSharplyFellText
	ret

.BattleStatSharplyFellText:
	text_exit
	text "<SCROLL>がくっと@"
	; Fallthrough. These strings are connected in Japanese, but separate in English.

.BattleStatFellText:
	text "　さがった！"
	prompt

GetStatName:
	ld hl, StatNames
	ld c, "@"

.CheckName
	dec b
	jr z, .Copy

.GetName
	ld a, [hli]
	cp c
	jr z, .CheckName
	jr .GetName

.Copy
	ld de, wStringBuffer2
	ld bc, NAME_LENGTH - 1
	jp CopyBytes

	INCLUDE "data/battle/stat_names.inc"
StatLevelMultipliers:
	INCLUDE "data/battle/stat_multipliers.inc"

BattleCommand_StoreEnergy:
	ld bc, wPlayerSubStatus3
	ld de, wPlayerMoveStruct
	ld hl, wPlayerDamageTaken + 1
	ldh a, [hBattleTurn]
	and a
	jr z, .got_battle_vars
	ld bc, wEnemySubStatus3
	ld de, wEnemyMoveStruct
	ld hl, wEnemyDamageTaken + 1

.got_battle_vars
	ld a, [bc]
	bit SUBSTATUS_BIDE, a
	ret z

	push hl
	ld hl, wCurDamage
	ld a, [hli]
	ld b, a
	ld c, [hl]
; Add wCurDamage to w[user]DamageTaken
	pop hl
	ld a, [hl]
	add c
	ld [hld], a
	ld a, [hl]
	adc b
	ld [hl], a

	ld hl, wPlayerRolloutCount
	ldh a, [hBattleTurn]
	and a
	jr z, .check_still_storing_energy
	ld hl, wEnemyRolloutCount

.check_still_storing_energy
	dec [hl]
	jr nz, .still_storing

	ld hl, wPlayerSubStatus3
	res SUBSTATUS_BIDE, [hl]
	ld hl, UnleashedEnergyText
	call PrintText
	
; BUG: The move struct power and damage taken variables are hardcoded to the player's values.
; No handling exists for the enemy whatsoever, so Bide will silently fail when unleashed by them.

; The move structs are loaded at the beginning of the function, but not used. This is where they would've fit.
	ld a, 1
	ld [wPlayerMoveStructPower], a
	ld hl, wPlayerDamageTaken + 1
	ld a, [hld]
	add a
	ld b, a
	ld [wCurDamage + 1], a
	ld a, [hl]
	rl a
	ld [wCurDamage], a
	or b
	jr nz, .built_up_something
	ld a, 1
	ld [wAttackMissed], a

.built_up_something
	xor a
	ld [hli], a
	ld [hl], a
	ld a, MOVE_BIDE
	ld [wPlayerMoveStruct], a
	ld b, unleashenergy_command
	jp SkipToBattleCommand

.still_storing:
	ld hl, StoringEnergyText
	call PrintText
	jp EndMoveEffect

BattleCommand_UnleashEnergy:
	ld hl, wPlayerSubStatus3
	ld de, wPlayerDamageTaken
	ld bc, wPlayerRolloutCount
	ldh a, [hBattleTurn]
	and a
	jr z, .got_damage
	ld hl, wEnemySubStatus3
	ld de, wEnemyDamageTaken
	ld bc, wEnemyRolloutCount

.got_damage
	set SUBSTATUS_BIDE, [hl]
	xor a
	ld [de], a
	inc de
	ld [de], a
	ld [wPlayerMoveStructEffect], a
	ld [wEnemyMoveStructEffect], a
	call BattleRandom
	and 1
	inc a
	inc a
	ld [bc], a
	ld a, 1
	ld [wBattleAnimParam], a
	call PlayDamageAnim
	jp EndMoveEffect

BattleCommand_CheckRampage:
	ld hl, wPlayerSubStatus3
	ld de, wPlayerRolloutCount
	ldh a, [hBattleTurn]
	and a
	jr z, .player
	ld hl, wEnemySubStatus3
	ld de, wEnemyRolloutCount

.player
	bit SUBSTATUS_RAMPAGE, [hl]
	ret z

	ld a, [de]
	dec a
	ld [de], a
	jr nz, .continue_rampage

	res SUBSTATUS_RAMPAGE, [hl]
; The final game prevents confusion here if the player is under Safeguard.
	set SUBSTATUS_CONFUSED, [hl]
	call BattleRandom
	and %00000001
	inc a
	inc a
	inc de
	ld [de], a

.continue_rampage
	ld b, rampage_command
	jp SkipToBattleCommand

BattleCommand_Rampage:
	ld hl, wPlayerSubStatus3
	ld de, wPlayerRolloutCount
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemySubStatus3
	ld de, wEnemyRolloutCount

.ok
	set SUBSTATUS_RAMPAGE, [hl]
; Rampage for 1 or 2 more turns
	call BattleRandom
	and %00000001
	inc a
	inc a
	ld [de], a
	ret

BattleCommand_TryEscape:
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy_turn
	ld a, [wBattleMode]
	dec a
	jr nz, .player_failed
; If player level >= enemy level, Teleport will succeed
	ld a, [wCurPartyLevel]
	ld b, a
	ld a, [wBattleMonLevel]
	cp b
	jr nc, .player_run
; c = player level + enemy level + 1
	add b
	ld c, a
	inc c

.loop_player
	call BattleRandom
	cp c
	jr nc, .loop_player
	srl b
	srl b
	cp b
	jr nc, .player_run

	xor a
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld a, [wPlayerMoveStruct]
; Print different fail text when using Teleport as opposed to Roar/Whirlwind
	cp MOVE_TELEPORT
	jp nz, PrintDidntAffectText
	jp PrintButItFailed

.player_run
	ld hl, UpdateBattleMonInParty
	call CallFromBank0F
	xor a
	ld [wNumHits], a
	inc a ; LOSE
	ld [wBattleResult], a
	ld a, [wPlayerMoveStruct]
	jr .run_away

.player_failed
; BUG: This build plays the moves' animations even when they fail.
; This causes problems with Teleport's animation, which makes the user's sprite invisible.
; The invisibility sticks until another animation that reinstates the user's sprite plays.
	xor a
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld hl, IsUnaffectedText
	ld a, [wPlayerMoveStruct]
	cp MOVE_TELEPORT
	jp nz, PrintText
	jp PrintButItFailed

.enemy_turn
	ld a, [wBattleMode]
	dec a
	jr nz, .enemy_failed

	ld a, [wBattleMonLevel]
	ld b, a
	ld a, [wCurPartyLevel]
	cp b
	jr nc, .enemy_run
	add b
	ld c, a
	inc c

.loop_enemy
	call BattleRandom
	cp c
	jr nc, .loop_enemy
	srl b
	srl b
	cp b
	jr nc, .enemy_run

	xor a
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld a, [wEnemyMoveStruct]
	cp MOVE_TELEPORT
	jp nz, PrintDidntAffectText
	jp PrintButItFailed

.enemy_run
	ld hl, UpdateBattleMonInParty
	call CallFromBank0F
	xor a
	ld [wNumHits], a
	inc a
	ld [wBattleResult], a
	ld a, [wEnemyMoveStruct]
	jr .run_away

.enemy_failed
; Same flaw as in the .player_failed section
	xor a
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld hl, IsUnaffectedText
	ld a, [wEnemyMoveStruct]
	cp MOVE_TELEPORT
	jp nz, PrintText
	jp TryPrintButItFailed

.run_away
	push af
	ld a, 1
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld c, 20
	call DelayFrames
	pop af

	ld hl, FledFromBattleText
	cp MOVE_TELEPORT
	jr z, .print_flee_text

	ld hl, FledInFearText
	cp MOVE_ROAR
	jr z, .print_flee_text

	; MOVE_WHIRLWIND
	ld hl, BlownAwayText

.print_flee_text
	jp PrintText

FledFromBattleText:
	text "<USER>は　せんとうから"
	line "りだつした！"
	prompt

FledInFearText:
	text "<TARGET>は　おじけづいて"
	line "にげだした！"
	prompt

BlownAwayText:
	text "<TARGET>は"
	line "ふきとばされた！"
	prompt

; Loop back to 'critical'.
BattleCommand_EndLoop:

	ld hl, wPlayerSubStatus3
	ld de, wPlayerRolloutCount
	ld bc, wPlayerDamageTaken
	ldh a, [hBattleTurn]
	and a
	jr z, .got_addrs
	ld hl, wEnemySubStatus3
	ld de, wEnemyRolloutCount
	ld bc, wEnemyDamageTaken

.got_addrs
	bit SUBSTATUS_IN_LOOP, [hl]
	jp nz, .in_loop

	set SUBSTATUS_IN_LOOP, [hl]
	ld hl, wPlayerMoveStructEffect
	ldh a, [hBattleTurn]
	and a
	jr z, .got_effect
	ld hl, wEnemyMoveStructEffect

.got_effect
	ld a, [hl]
	cp EFFECT_POISON_MULTI_HIT
	jr z, .twineedle
	cp EFFECT_DOUBLE_HIT
	ld a, 1
	jr z, .double_hit
	ld a, [hl]
	cp EFFECT_TRIPLE_KICK
	jr nz, .not_triple_kick

.reject_triple_kick_sample
	call BattleRandom
	and 3
	jr z, .reject_triple_kick_sample
	dec a
	jr nz, .double_hit
	ld a, 1
	ld [bc], a
	jr .done_loop

.not_triple_kick
	call BattleRandom
	cp 2
	jr c, .got_number_hits
	call BattleRandom
	and 3

.got_number_hits
	inc a

.double_hit
	ld [de], a
	inc a
	ld [bc], a
	jr .loop_back_to_critical

.twineedle
	ld a, EFFECT_POISON_HIT
	ld [hl], a
	dec a
	jr .double_hit

.in_loop:
	ld a, [de]
	dec a
	ld [de], a
	jr nz, .loop_back_to_critical
.done_loop
	ld hl, PlayerHitTimesText
	ld de, wPlayerSubStatus3
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hit_n_times_text
	ld hl, EnemyHitTimesText
	ld de, wEnemySubStatus3

.got_hit_n_times_text
	ld a, [de]
	res SUBSTATUS_IN_LOOP, a
	ld [de], a
	push bc
	call PrintText
	pop bc
	xor a
	ld [bc], a
	ret

.loop_back_to_critical
	ld a, [wBattleScriptBufferAddress + 1]
	ld h, a
	ld a, [wBattleScriptBufferAddress]
	ld l, a

.not_critical
	ld a, [hld]
	cp critical_command
	jr nz, .not_critical
	inc hl
	ld a, h
	ld [wBattleScriptBufferAddress + 1], a
	ld a, l
	ld [wBattleScriptBufferAddress], a
	ret

PlayerHitTimesText:
	text "あいてに　@"
	deciram wPlayerDamageTaken, 1, 1
	text "かい　あたった！"
	prompt

EnemyHitTimesText:
	text "あいてに　@"
	deciram wEnemyDamageTaken, 1, 1
	text "かい　あたった！"
	prompt

BattleCommand_FlinchTarget:
	call CheckSubstituteOpp
	ret nz
	ld hl, wEnemySubStatus3
	ld de, wPlayerMoveStructEffect
	ldh a, [hBattleTurn]
	and a
	jr z, .go
	ld hl, wPlayerSubStatus3
	ld de, wEnemyMoveStructEffect

.go
	call EndRechargeOpp
	call BattleCommand_EffectChance
	ret nc
	set SUBSTATUS_FLINCHED, [hl]
	ret

BattleCommand_HeldFlinch:
; No handling for move missing... can flinches still happen after a miss?
	call GetUserItem
	ld a, b
	cp HELD_FLINCH
	ret nz

	call CheckSubstituteOpp
	ret nz

	ld hl, wEnemySubStatus3
	ld de, wPlayerMoveStructEffect
	ldh a, [hBattleTurn]
	and a
	jr z, .go
	ld hl, wPlayerSubStatus3
	ld de, wEnemyMoveStructEffect

.go
	push hl
	call EndRechargeOpp
	call GetUserItem
	pop hl
	call BattleRandom
	cp c
	ret nc
	set SUBSTATUS_FLINCHED, [hl]
	ret

BattleCommand_OHKO:
	ld hl, wCurDamage
	xor a
	ld [hli], a
	ld [hl], a
	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	cp EFFECTIVE
	jr c, .no_effect
	ld hl, wBattleMonSpeed + 1
	ld de, wEnemyMonSpeed + 1
	ldh a, [hBattleTurn]
	and a
	jr z, .compare_speed
	ld hl, wEnemyMonSpeed + 1
	ld de, wBattleMonSpeed + 1

.compare_speed
	ld a, [de]
	dec de
	ld b, a
	ld a, [hld]
	sub b
	ld a, [de]
	ld b, a
	ld a, [hl]
	sbc b
	jr c, .no_effect

	call BattleCommand_CheckHit
	ld a, [wAttackMissed]
	and a
	ret nz

	ld hl, wCurDamage
	ld a, $ff
	ld [hli], a
	ld [hl], a
	ld a, 2
	ld [wCriticalHit], a
	ret

.no_effect
	ld a, $ff
	ld [wCriticalHit], a
	ld a, 1
	ld [wAttackMissed], a
	ret

BattleCommand_CheckCharge:
	ld hl, wPlayerSubStatus3
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wEnemySubStatus3

.got_substatus
	bit SUBSTATUS_CHARGED, [hl]
	ret z
	res SUBSTATUS_CHARGED, [hl]
	res SUBSTATUS_INVULNERABLE, [hl]
	ld b, charge_command
	jp SkipToBattleCommand

BattleCommand_Charge:
	xor a
	ld [wNumHits], a
	inc a
	ld [wBattleAnimParam], a
	call LoadMoveAnim

	ld hl, wPlayerSubStatus3
	ld de, wPlayerMoveStruct
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemySubStatus3
	ld de, wEnemyMoveStruct

.ok
	set SUBSTATUS_CHARGED, [hl]
	ld a, [de]
	cp MOVE_FLY
	jr nz, .dont_set_flying
	set SUBSTATUS_INVULNERABLE, [hl]

.dont_set_flying
	ld a, [de]
	cp MOVE_DIG
	jr nz, .dont_set_digging
	set SUBSTATUS_INVULNERABLE, [hl]

.dont_set_digging
	ld a, [de]
	ld [wChargeMoveNum], a
	ld hl, .UsedText
	call PrintText
	jp EndMoveEffect

.UsedText
	text "<USER>@"
	start_asm
	ld a, [wChargeMoveNum]
	cp MOVE_RAZOR_WIND
	ld hl, BattleMadeWhirlwindText
	jr z, .done

	cp MOVE_SOLARBEAM
	ld hl, BattleTookSunlightText
	jr z, .done

	cp MOVE_SKULL_BASH
	ld hl, BattleLoweredHeadText
	jr z, .done

	cp MOVE_SKY_ATTACK
	ld hl, BattleGlowingText
	jr z, .done

	cp MOVE_FLY
	ld hl, BattleFlewText
	jr z, .done

	cp MOVE_DIG
	ld hl, BattleDugText

.done
	ret

BattleMadeWhirlwindText:
	text "の　まわりで"
	line "くうきが　うずを　まく！"
	prompt

BattleTookSunlightText:
	text "は"
	line "ひかりを　きゅうしゅうした！"
	prompt

BattleLoweredHeadText:
	text "は"
	line "くびを　ひっこめた！"
	prompt

BattleGlowingText:
	text "を"
	line "はげしい　ひかりが　つつむ！"
	prompt

BattleFlewText:
	text "は"
	line "そらたかく　とびあがった！"
	prompt

BattleDugText:
	text "は"
	line "あなをほって　ちちゅうに　もぐった！"
	prompt

; Skips to the traptarget command in the move's battle script buffer.
; This command was dummied out in the final game, most likely due to 
; the changes made to trapping moves.
BattleCommand_SkipToTrapTarget:
	ld hl, wPlayerSubStatus3
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemySubStatus3

.ok
	bit SUBSTATUS_USING_TRAPPING_MOVE, [hl]
	ret z

	ld a, [wBattleScriptBufferAddress + 1]
	ld h, a
	ld a, [wBattleScriptBufferAddress]
	ld l, a

.find_traptarget
	ld a, [hli]
	cp traptarget_command

	jr nz, .find_traptarget
	dec hl
	ld a, h
	ld [wBattleScriptBufferAddress + 1], a
	ld a, l
	ld [wBattleScriptBufferAddress], a
	ret

BattleCommand_TrapTarget:
	ld hl, wPlayerSubStatus3
	ld de, wPlayerRolloutCount
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wEnemySubStatus3
	ld de, wEnemyRolloutCount

.got_substatus
	ld a, [wAttackMissed]
	and a
	ret nz
	bit SUBSTATUS_USING_TRAPPING_MOVE, [hl]
	jr nz, .attack_continues

	call EndRechargeOpp
	set SUBSTATUS_USING_TRAPPING_MOVE, [hl]

; 3/8 chance for 2 and 3 attacks, and 1/8 chance for 4 and 5 attacks.
	call BattleRandom
	and %11
	cp 2
	jr c, .trap
	call BattleRandom
	and %11

.trap
	inc a
	ld [de], a
	ret

.attack_continues
	push hl
	push de
	ld hl, AttackContinuesText
	call PrintText

	pop hl
	dec [hl]

	pop hl
	ret nz
	res SUBSTATUS_USING_TRAPPING_MOVE, [hl]
	ret

BattleCommand_Mist:
	ld hl, wPlayerSubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wEnemySubStatus4

.got_substatus
	bit SUBSTATUS_MIST, [hl]
	jr nz, .already_mist
	set SUBSTATUS_MIST, [hl]
	call LoadMoveAnim
	ld hl, MistText
	jp PrintText

.already_mist
	jp PrintButItFailed

MistText:
	text "<USER>は"
	line "しろい　きりに　つつまれた！"
	prompt

BattleCommand_FocusEnergy:
	ld hl, wPlayerSubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wEnemySubStatus4

.got_substatus
	bit SUBSTATUS_FOCUS_ENERGY, [hl]
	jr nz, .already_pumped
	set SUBSTATUS_FOCUS_ENERGY, [hl]
	call LoadMoveAnim
	ld hl, GettingPumpedText
	jp PrintText

.already_pumped
	call BattleCommand_MoveDelay
	jp PrintButItFailed

GettingPumpedText:
	text_exit
	text "<USER>は"
	line "はりきっている！"
	prompt

BattleCommand_Recoil:
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStruct]
	ld hl, wBattleMonMaxHP
	jr z, .got_max_hp
	ld a, [wEnemyMoveStruct]
	ld hl, wEnemyMonMaxHP

; get 1/4 damage or 1 HP, whichever is higher
.got_max_hp
	ld d, a
	ld a, [wCurDamage]
	ld b, a
	ld a, [wCurDamage + 1]
	ld c, a
	srl b
	rr c
	ld a, d
; get 1/2 damage instead if move is Struggle
	cp MOVE_STRUGGLE
	jr z, .struggle
	srl b
	rr c

.struggle
	ld a, b
	or c
	jr nz, .min_damage
	inc c

.min_damage
	ld a, [hli]
	ld [wHPBarMaxHP + 1], a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	dec hl
	dec hl

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
	jr nc, .dont_ko
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, wHPBarNewHP
	ld [hli], a
	ld [hl], a

.dont_ko
	hlcoord 10, 9
	ldh a, [hBattleTurn]
	and a
	ld a, 1
	jr z, .animate_hp_bar
	hlcoord 2, 2
	xor a

.animate_hp_bar
	ld [wWhichHPBar], a
	predef UpdateHPBar
	ld hl, RecoilText
	jp PrintText

RecoilText:
	text "<USER>は　こうげきの"
	line "はんどうを　うけた！"
	prompt

BattleCommand_ConfuseTarget:
	call GetOpponentItem
	ld a, b
	cp HELD_PREVENT_CONFUSE
	ret z
	call BattleCommand_EffectChance
	ret nc
	jr BattleCommand_FinishConfusingTarget

BattleCommand_Confuse:
	call GetOpponentItem
	ld a, b
	cp HELD_PREVENT_CONFUSE
	jr nz, .no_item_protection
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	call BattleCommand_MoveDelay
	ld hl, ProtectedByText
	jp PrintText

.no_item_protection
	call CheckSubstituteOpp
	jr nz, BattleCommand_Confuse_CheckSnore_Swagger_ConfuseHit
	ld a, [wAttackMissed]
	and a
	jr nz, BattleCommand_Confuse_CheckSnore_Swagger_ConfuseHit

BattleCommand_FinishConfusingTarget:
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemySubStatus3
	ld bc, wEnemyConfuseCount
	ld a, [wPlayerMoveStructEffect]
	jr z, .got_confuse_count
	ld hl, wPlayerSubStatus3
	ld bc, wPlayerConfuseCount
	ld a, [wEnemyMoveStructEffect]

.got_confuse_count
	bit SUBSTATUS_CONFUSED, [hl]
	jr nz, BattleCommand_Confuse_CheckSnore_Swagger_ConfuseHit
	set SUBSTATUS_CONFUSED, [hl]
	; confused for 2-5 turns
	push af
	call BattleRandom
	and 3
	inc a
	inc a
	ld [bc], a

	pop af
	cp EFFECT_CONFUSE_HIT
	jr z, .got_effect
	cp EFFECT_SNORE
	jr z, .got_effect
	cp EFFECT_SWAGGER
	jr z, .got_effect
	call LoadMoveAnim
	jr .became_confused_text

.got_effect
	ld de, ANIM_CONFUSED
	call PlayOpponentBattleAnim

.became_confused_text
	ld hl, BecameConfusedText
	jp PrintText

BecameConfusedText:
	text "<TARGET>は"
	line "こんらんした！"
	prompt

BattleCommand_Confuse_CheckSnore_Swagger_ConfuseHit:
	cp EFFECT_CONFUSE_HIT
	ret z
	cp EFFECT_SNORE
	ret z
	cp EFFECT_SWAGGER
	ret z
	call BattleCommand_MoveDelay
	jp TryPrintButItFailed

BattleCommand_Paralyze:
	ld hl, wEnemyMonStatus
	ld de, wPlayerMoveStructType
	ldh a, [hBattleTurn]
	and a
	jp z, .got_status
	ld hl, wBattleMonStatus
	ld de, wEnemyMoveStructType

.got_status
	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	cp EFFECTIVE
	jr c, .didnt_affect

	ld a, [hl]
	and a
	jr nz, .paralyzed

	push hl
	call GetOpponentItem
	ld a, b
	cp HELD_PREVENT_PARALYZE
	ld a, [hl]
	pop hl
	jr nz, .paralyze

	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	call BattleCommand_MoveDelay
	ld hl, ProtectedByText
	jp PrintText

.paralyze
	ld a, [wAttackMissed]
	and a
	jr nz, .paralyzed
	set PAR, [hl]
	push hl
	ld hl, ApplyPrzEffectOnSpeed
	call CallFromBank0F

	ld c, 30
	call DelayFrames
	call LoadMoveAnim
	ld hl, DrawHUDsAndHPBars
	call CallFromBank0F
	call PrintParalyze

	call GetOpponentItem
	ld a, b
	pop de
	cp HELD_HEAL_PARALYZE
	jr z, .use_item
	cp HELD_HEAL_STATUS
	jr z, .use_item
	cp HELD_FULL_RESTORE
	jr z, .use_item
	ret

.use_item
	ld a, [de]
	res PAR, a
	ld [de], a
	ld a, [hl]
	call PrintRecoveredUsingItem
	call ConsumeHeldItem
	ld hl, DrawHUDsAndHPBars
	jp CallFromBank0F

.paralyzed
	call BattleCommand_MoveDelay
	jp PrintDidntAffectText

.didnt_affect
	call BattleCommand_MoveDelay
	jp PrintDoesntAffect

BattleCommand_Substitute:
	call BattleCommand_MoveDelay
	ld hl, wBattleMonMaxHP
	ld de, wPlayerSubstituteHP
	ld bc, wPlayerSubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wEnemyMonMaxHP
	ld de, wEnemySubstituteHP
	ld bc, wEnemySubStatus4

.got_hp
	ld a, [bc]
	bit SUBSTATUS_SUBSTITUTE, a
	jr nz, .already_has_sub
; Calculate 1/4 of user's HP
	push bc
	ld a, [hli]
	ld b, [hl]
	srl a
	rr b
	srl a
	rr b

	dec hl
	dec hl
	ld a, b
	ld [de], a
	ld a, [hld]
	sub b
	ld d, a
	ld a, [hl]
	sbc 0
	pop bc
	jr c, .too_weak_to_sub

	ld [hli], a
	ld [hl], d
	ld h, b
	ld l, c
	set SUBSTATUS_SUBSTITUTE, [hl]
	ld a, [wOptions]
	add a
	jr c, .skip_anim

	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	ld [wBattleAnimParam], a
	ld a, MOVE_SUBSTITUTE
	call LoadBattleAnim
	jr .played_anim

.skip_anim
	callfar Functioncc000_2

.played_anim
	ld hl, MadeSubstituteText
	call PrintText
	ld hl, DrawHUDsAndHPBars
	jp CallFromBank0F

.already_has_sub
	ld hl, HasSubstituteText
	jr .print

.too_weak_to_sub
	ld hl, TooWeakSubText

.print
	jp PrintText

MadeSubstituteText:
	text "<USER>の"
	line "ぶんしんが　あらわれた"
	prompt

HasSubstituteText:
	text "しかし　<USER>の"
	line "みがわりは　すでに　でていた！"
	prompt

TooWeakSubText:
	text "しかし　ぶんしんを　だすには"
	line "たいりょくが　たりなかった！"
	prompt

BattleCommand_RechargeNextTurn:
	ld hl, wPlayerSubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemySubStatus4

.ok:
	set SUBSTATUS_RECHARGE, [hl]
	ret

EndRechargeOpp:
	push hl
	ld hl, wEnemySubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wPlayerSubStatus4

.ok
	res SUBSTATUS_RECHARGE, [hl]
	pop hl
	ret

Unreferenced_RageEffect:
	ld hl, wPlayerSubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemySubStatus4
.ok
	set SUBSTATUS_RAGE, [hl]
	ret

BattleCommand_Mimic:
	call BattleCommand_MoveDelay
	ld a, [wAttackMissed]
	and a
	jr nz, .fail

	ld hl, wBattleMonMoves
	ld de, wCurEnemyMove
	ldh a, [hBattleTurn]
	and a
	jr z, .player_turn
	ld hl, wEnemyMonMoves
	ld de, wCurPlayerMove

.player_turn
; BUG: No checks for Struggle, so it can be mimicked.
	call CheckHiddenOpponent
	jr nz, .fail
	ld a, [de]
	and a
	jr z, .fail

.find_mimic
	ld a, [hli]
	cp MOVE_MIMIC
	jr nz, .find_mimic
	dec hl
	ld a, [de]
	ld [hl], a
	ld [wNamedObjectIndexBuffer], a
	call Unreferenced_GetMoveName
	call LoadMoveAnim
	ld hl, MimicLearnedMoveText
	jp PrintText

.fail
	jp PrintButItFailed

MimicLearnedMoveText:
	text "<USER>は"
	line "@"
	text_from_ram wStringBuffer1
	text "を　おぼえた！"
	prompt

BattleCommand_LeechSeed:
	ld a, [wAttackMissed]
	and a
	jr nz, .evaded

	ld hl, wEnemySubStatus4
	ld de, wEnemyMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wPlayerSubStatus4
	ld de, wBattleMonHP

.ok
; BUG: Code assumes de contains the target's type, when it actually contains HP.
; The move always fails if target's HP modulo 256 is exactly 22.
	ld a, [de]
	cp TYPE_GRASS
	jr z, .evaded
	inc de
	ld a, [de]
	cp TYPE_GRASS
	jr z, .evaded

	bit SUBSTATUS_LEECH_SEED, [hl]
	jr nz, .evaded
	set SUBSTATUS_LEECH_SEED, [hl]
	call LoadMoveAnim
	ld hl, WasSeededText
	jp PrintText

.evaded
	call BattleCommand_MoveDelay
	ld hl, EvadedText
	jp PrintText

WasSeededText:
	text "<TARGET>に"
	line "たねを　うえつけた！"
	prompt

EvadedText:
	text "<TARGET>は"
	line "こうげきを　かわした！"
	prompt

BattleCommand_Splash:
	call LoadMoveAnim
	jp PrintNothingHappenedText

BattleCommand_Disable:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	ld de, wEnemyDisableCount
	ld hl, wEnemyMonMoves
	ld bc, wCurEnemyMove
	ldh a, [hBattleTurn]
	and a
	jr z, .got_moves
	ld de, wPlayerDisableCount
	ld hl, wBattleMonMoves
	ld bc, wCurPlayerMove

.got_moves
	ld a, [de]
	and a
	jr nz, .failed

	ld a, [bc]
	and a
	jr z, .failed
	cp MOVE_STRUGGLE
	jr z, .failed

	ld [wNamedObjectIndexBuffer], a
	ld b, a
	ld c, $ff

.loop
	inc c
	ld a, [hli]
	cp b
	jr nz, .loop

	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyMonPP
	jr z, .got_pp
	ld hl, wBattleMonPP

.got_pp
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	jr z, .failed

	call BattleRandom
	and 7
	inc a
	inc c
	swap c
	add c
	ld [de], a
	call PlayDamageAnim
	ld hl, wDisabledMove
	ldh a, [hBattleTurn]
	and a
	jr nz, .got_disabled_move_pointer
	inc hl

.got_disabled_move_pointer
	ld a, [wNamedObjectIndexBuffer]
	ld [hl], a
	call Unreferenced_GetMoveName
	ld hl, MoveDisabledText
	jp PrintText

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed

MoveDisabledText:
	text "<TARGET>の"
	line "@"
	text_from_ram wStringBuffer1
	text "を　ふうじこめた！"
	prompt

BattleCommand_PayDay:
	xor a
	ld hl, wStringBuffer1
	ld [hli], a

	ldh a, [hBattleTurn]
	and a
	ld a, [wBattleMonLevel]
	jr z, .ok
	ld a, [wEnemyMonLevel]

.ok
	add a
	ld hl, wPayDayMoney + 2
	add [hl]
	ld [hld], a
	jr nc, .done
	inc [hl]
	dec hl
	jr nz, .done
	inc [hl]
.done
	ld hl, CoinsScatteredText
	jp PrintText

CoinsScatteredText:
	text "こばんが　あたりに　ちらばった！"
	prompt

; Works as in Gen 1: copies the opponent's types to the user.
BattleCommand_Conversion:
	ld hl, wEnemyMonType
	ld de, wBattleMonType
	ldh a, [hBattleTurn]
	and a
	jr z, .got_mon_types
	push hl
	ld h, d
	ld l, e
	pop de

.got_mon_types:
	call CheckHiddenOpponent
	jr nz, .fail
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	call LoadMoveAnim
	ld hl, .TransformedTypeText
	jp PrintText

.TransformedTypeText
	text "<TARGET>の　タイプを"
	line "じぶんに　はりつけた！"
	prompt

.fail
	jp PrintButItFailed

; Effect identical to Gen I
BattleCommand_ResetStats:
	ld a, BASE_STAT_LEVEL
	ld hl, wPlayerStatLevels
	call .Fill
	ld hl, wEnemyStatLevels
	call .Fill

	ld hl, wPlayerStats
	ld de, wBattleMonStats
	call .CopyStats
	ld hl, wEnemyStats
	ld de, wEnemyMonStats
	call .CopyStats

	ld hl, wEnemyMonStatus
	ld de, wCurEnemySelectedMove
	ldh a, [hBattleTurn]
	and a
	jr z, .cure_status
	ld hl, wBattleMonStatus
	dec de

.cure_status
	ld a, [hl]
	ld [hl], 0
	and (1 << FRZ) | SLP
	jr z, .not_immobile
; prevent the Pokemon from executing a move if it was asleep or frozen
	ld a, $ff
	ld [de], a

.not_immobile
; Cure Disable
	xor a
	ld [wPlayerDisableCount], a
	ld [wEnemyDisableCount], a
	ld hl, wDisabledMove
	ld [hli], a
	ld [hl], a
; Cure Confusion
	ld hl, wPlayerSubStatus3
	res SUBSTATUS_CONFUSED, [hl]

; Clear X Accuracy, Mist, Focus Energy, and Leech Seed
	inc hl
	ld a, [hl]
	and ~((1 << SUBSTATUS_X_ACCURACY) | (1 << SUBSTATUS_MIST) | (1 << SUBSTATUS_FOCUS_ENERGY) | (1 << SUBSTATUS_LEECH_SEED))

; Clear Toxic, Reflect, and Light Screen
	ld [hli], a
	ld a, [hl]
	and %11110000 | (1 << SUBSTATUS_TRANSFORMED)
	ld [hl], a

; Now do likewise for the enemy
	ld hl, wEnemySubStatus3
	res SUBSTATUS_CONFUSED, [hl]

	inc hl
	ld a, [hl]
	and ~((1 << SUBSTATUS_X_ACCURACY) | (1 << SUBSTATUS_MIST) | (1 << SUBSTATUS_FOCUS_ENERGY) | (1 << SUBSTATUS_LEECH_SEED))
	
	ld [hli], a
	ld a, [hl]
	and %11110000 | (1 << SUBSTATUS_TRANSFORMED)
	ld [hl], a

	call LoadMoveAnim
	ld hl, EliminatedStatsText
	jp PrintText

.Fill
	ld b, 8

.fill_loop
	ld [hli], a
	dec b
	jr nz, .fill_loop
	ret

.CopyStats:
	ld b, 8

.copy_stats_loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copy_stats_loop
	ret

EliminatedStatsText:
	text "すべての　ステータスが"
	line "もとに　もどった！"
	prompt

BattleCommand_Heal:
	ldh a, [hBattleTurn]
	and a
	ld de, wBattleMonHP
	ld hl, wBattleMonMaxHP
	ld a, [wPlayerMoveStruct]
	jr z, .got_hp
	ld de, wEnemyMonHP
	ld hl, wEnemyMonMaxHP
	ld a, [wEnemyMoveStruct]

.got_hp
	ld b, a
	ld a, [de]
	cp [hl]
	inc de
	inc hl
	ld a, [de]
	sbc [hl]
	jp z, .hp_full
	ld a, b
	cp MOVE_REST
	jr nz, .not_rest
	
	push hl
	push de
	push af
	call BattleCommand_MoveDelay
	ld hl, wBattleMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, .got_status
	ld hl, wEnemyMonStatus

.got_status
	ld a, [hl]
	and a
	ld [hl], REST_SLEEP_TURNS
	ld hl, WentToSleepText
	jr z, .no_status_to_heal
	ld hl, RestedText
.no_status_to_heal
	call PrintText
	pop af
	pop de
	pop hl

.not_rest
	jr z, .restore_full_hp
	callfar GetHalfMaxHP
	jr .finish

.restore_full_hp
	callfar GetMaxHP

.finish
	call LoadMoveAnim
	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	callfar RestoreHP
	pop af
	ldh [hBattleTurn], a
	ld hl, DrawHUDsAndHPBars
	call CallFromBank0F
	ld hl, RegainedHealthText
	jp PrintText

.hp_full
	call BattleCommand_MoveDelay
	jp PrintButItFailed

WentToSleepText:
	text "<USER>は"
	line "ねむりはじめた！"
	done

RestedText:
	text "<USER>は　けんこうになって"
	line "ねむりはじめた！"
	done

RegainedHealthText:
	text "<USER>は　たいりょくを"
	line "かいふくした！"
	prompt

BattleCommand_Transform:
	ld hl, wBattleMonSpecies
	ld de, wEnemyMonSpecies
	ld bc, wEnemySubStatus5
	ldh a, [hBattleTurn]
	and a
	jr nz, .ok
	ld hl, wEnemyMonSpecies
	ld de, wBattleMonSpecies
	ld bc, wPlayerSubStatus5
	xor a
	ld [wCurMoveNum], a

.ok
	call CheckHiddenOpponent
	jp nz, .failed
	push hl
	push de
	push bc
	ld hl, wPlayerSubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wEnemySubStatus4

.got_substatus
	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	ld a, 1
	ld [wBattleAnimParam], a
	bit SUBSTATUS_SUBSTITUTE, [hl]
	push af
	ld a, MOVE_SUBSTITUTE
	call nz, LoadBattleAnim
	ld a, [wOptions]
	add a ; check if BATTLE_SCENE is set
	jr c, .skip_anim
	call LoadMoveAnim
	jr .anim_played

.skip_anim
	callfar Functioncc000_2

.anim_played
	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	ld a, 2
	ld [wBattleAnimParam], a
	pop af
	ld a, MOVE_SUBSTITUTE
	call nz, LoadBattleAnim

	pop bc
	ld a, [bc]
	set SUBSTATUS_TRANSFORMED, a
	ld [bc], a
	pop de
	pop hl
	push hl

	ld a, [hli]
	ld [de], a
	inc hl
	inc de
	inc de
	ld bc, NUM_MOVES
	call CopyBytes

	ldh a, [hBattleTurn]
	and a
	jr z, .mimic_enemy_backup
	ld a, [de]
	ld [wEnemyBackupDVs], a
	inc de
	ld a, [de]
	ld [wEnemyBackupDVs + 1], a
	dec de

.mimic_enemy_backup
; copy DVs
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
; move pointer to stats
	ld bc, wBattleMonStats - wBattleMonPP
	add hl, bc
	push hl
	ld h, d
	ld l, e
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld bc, wBattleMonStructEnd - wBattleMonStats
	call CopyBytes

	ld bc, wBattleMonMoves - wBattleMonStructEnd
	add hl, bc
	push de
	ld d, h
	ld e, l
	pop hl
	ld bc, wBattleMonPP - wBattleMonStructEnd
	add hl, bc
	ld b, NUM_MOVES

.pp_loop
	ld a, [de]
	inc de
	and a
	jr z, .done_move
	ld a, 5
	ld [hli], a
	dec b
	jr nz, .pp_loop

.done_move
	pop hl
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
; Copy all stats except HP
	ld hl, wEnemyStats
	ld de, wPlayerStats
	ld bc, 2 * NUM_BATTLE_STATS
	call .BattleSideCopy

	ld hl, wEnemyStatLevels
	ld de, wPlayerStatLevels
	ld bc, (wPlayerEvaLevel + 1 - wPlayerAtkLevel) + 1
	call .BattleSideCopy
	ld hl, TransformedText
	jp PrintText

; Copy bc bytes from hl to de if it's the player's turn.
; Copy bc bytes from de to hl if it's the enemy's turn.
.BattleSideCopy
	ldh a, [hBattleTurn]
	and a
	jr z, .copy

; Swap hl and de
	push hl
	ld h, d
	ld l, e
	pop de

.copy
	jp CopyBytes

.failed
	jp PrintButItFailed

TransformedText:
	text "<USER>は"
	line "@"
	text_from_ram wStringBuffer1
	text "に　へんしんした！"
	prompt

BattleCommand_Screen:
	ld hl, wPlayerSubStatus5
	ld de, wPlayerMoveStructEffect
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wEnemySubStatus5
	ld de, wEnemyMoveStructEffect

.got_substatus
	ld a, [de]
; BUG: Uses the old Gen 1 index for EFFECT_LIGHT_SCREEN.
; This causes Light Screen to have the same effect as Reflect in this build.
	cp EFFECT_REFLECT - 1
	jr nz, .Reflect

	bit SUBSTATUS_LIGHT_SCREEN, [hl]
	jr nz, .failed
	set SUBSTATUS_LIGHT_SCREEN, [hl]
	ld hl, LightScreenEffectText
	jr .good

.Reflect
	bit SUBSTATUS_REFLECT, [hl]
	jr nz, .failed
	set SUBSTATUS_REFLECT, [hl]
	ld hl, ReflectEffectText

.good
	push hl
	call LoadMoveAnim
	pop hl
	jp PrintText

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed

LightScreenEffectText:
	text "<USER>は"
	line "とくしゅこうげきに　つよくなった！"
	prompt

ReflectEffectText:
	text "<USER>は"
	line "だげきこうげきに　つよくなった！"
	prompt

; Hasn't been split into "can't go any higher/lower!" yet
PrintNoChangesText:
	ld hl, NoChangesText
	jp PrintText

NoChangesText:
	text "しかし　こうかが　なかった！"
	prompt

PrintNothingHappenedText:
	ld hl, NothingHappenedText
	jp PrintText

NothingHappenedText:
	text "しかし　なにもおこらない"
	prompt

TryPrintButItFailed:
	ld a, [wAlreadyFailed]
	and a
	ret nz

PrintButItFailed:
	ld hl, ButItFailedText
	jp PrintText

ButItFailedText:
	text "しかし　うまく　きまらなかった！"
	prompt

PrintDidntAffectText:
	ld hl, DidntAffectText
	jp PrintText

DidntAffectText:
	text "しかし　<TARGET>には"
	line "きかなかった！"
	prompt

IsUnaffectedText:
	text "<TARGET>は"
	line "へいきな　かおを　している！"
	prompt

PrintParalyze:
	ld hl, ParalyzedText
	jp PrintText

ParalyzedText:
	text "<TARGET>は　まひして"
	line "わざが　でにくくなった！"
	prompt

ProtectedByText:
	text "<TARGET>は　"
	line "@"
	text_from_ram wStringBuffer1
	text "で　まもられてる！"
	prompt

CheckSubstituteOpp:
	push hl
	ld hl, wEnemySubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, .player_turn
	ld hl, wPlayerSubStatus4

.player_turn:
	bit SUBSTATUS_SUBSTITUTE, [hl]
	pop hl
	ret

BattleCommand_Selfdestruct:
; Reuses Mega Punch's hit animation
	ld a, MOVE_MEGA_PUNCH
	ld [wNumHits], a
	ld c, 3
	call DelayFrames

	ld a, 1
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld hl, wBattleMonStatus
	ld de, wPlayerSubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyMonStatus
	ld de, wEnemySubStatus4

.ok
	xor a
	ld [hli], a
	ld [hli], a
	inc hl
	ld [hli], a
	ld [hl], a
	ld a, [de]
	res SUBSTATUS_LEECH_SEED, a
	ld [de], a
; Final game additionally removes Destiny Bond here
	ret

BattleCommand_MirrorMove:
	ldh a, [hBattleTurn]
	and a
	ld a, [wCurEnemyMove]
	ld hl, wCurPlayerSelectedMove
	ld de, wPlayerMoveStruct
	jr z, .got_moves
	ld a, [wCurPlayerMove]
	ld de, wEnemyMoveStruct
	ld hl, wCurEnemySelectedMove

.got_moves
	cp MOVE_MIRROR_MOVE
	jr z, .failed
	and a
	jr nz, .used

.failed
	ld hl, MirrorMoveFailedText
	call PrintText
	jp EndMoveEffect

.used
	ld [hl], a
	ld [wNumSetBits], a
	dec a
	ld hl, Moves
	ld bc, 7 ; Size of move struct
	call AddNTimes
; Copy to user's move struct buffer
	ld a, BANK(Moves)
	call FarCopyBytes

	call IncrementMovePP
	call Unreferenced_GetMoveName
	call CopyStringToStringBuffer2
	call BattleCommand_MoveDelay
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStructEffect]
	jr z, .do_move
	ld a, [wEnemyMoveStructEffect]

.do_move
	call DoMove
	jp EndMoveEffect

MirrorMoveFailedText:
	text "しかし　オウムがえしは"
	next "しっぱいにおわった！"
	prompt

BattleCommand_Metronome:
	call LoadMoveAnim
	ld de, wPlayerMoveStructEffect
	ld hl, wCurPlayerSelectedMove
	ldh a, [hBattleTurn]
	and a
	jr z, .GetMove
	ld de, wEnemyMoveStructEffect
	ld hl, wCurEnemySelectedMove

.GetMove
	call BattleRandom
	and a
	jr z, .GetMove

; No invalid moves.
	cp NUM_ATTACKS + 1
	jr nc, .GetMove

; You can't get Metronome from using Metronome.
	cp MOVE_METRONOME
	jr z, .GetMove

	ld [hl], a
	push de
	call IncrementMovePP
	call UpdateMoveData
	pop de
	ld a, [de]
	call DoMove
	jp EndMoveEffect

BattleCommand_Thief:
; BUG: No checks to prevent stealing mail, unlike in the final game.
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy

; The player needs to be able to steal an item.

	call .playeritem
	ld a, [hl]
	and a
	ret nz

; The enemy needs to have an item to steal.

	call .enemyitem
	ld a, [hl]
	and a
	ret z

	ld [wNamedObjectIndexBuffer], a
	call BattleCommand_EffectChance
	ret nc

	xor a
	ld [hl], a
	ld [de], a
	call .playeritem

	ld a, [wNumSetBits]
	ld [hl], a
	ld [de], a
	jr .stole

.enemy

; The enemy can't already have an item.

	call .enemyitem
	ld a, [hl]
	and a
	ret nz

; The player must have an item to steal.

	call .playeritem
	ld a, [hl]
	and a
	ret z

	ld [wNamedObjectIndexBuffer], a
	call BattleCommand_EffectChance
	ret nc

; If the enemy steals your item,
; it's gone for good if you don't get it back.

	xor a
	ld [hl], a
	ld [de], a
	call .enemyitem

	ld a, [wNamedObjectIndexBuffer]
	ld [hl], a
	ld [de], a

.stole
	call GetItemName
	ld hl, StoleText
	call PrintText
	ret

.playeritem
	ld hl, wPartyMon1Item
	ld a, [wCurBattleMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wBattleMonItem
	ret

.enemyitem
	ld hl, wOTPartyMon1Item
	ld a, [wCurOTMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wEnemyMonItem
	ret

StoleText:
	text "<USER>は　<TARGET>から"
	line "@"
	text_from_ram wStringBuffer1
	text "を　うばいとった！"
	prompt

BattleCommand_ArenaTrap:
	ld hl, wEnemySubStatus5
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wPlayerSubStatus5

.got_substatus
; Doesn't work on an absent opponent.
	call CheckHiddenOpponent
	jr nz, .failed

; Don't trap if the opponent is already trapped.
	bit SUBSTATUS_CANT_RUN, [hl]
	jr nz, .failed

; Otherwise trap the opponent.
	set SUBSTATUS_CANT_RUN, [hl]
	call LoadMoveAnim
	ld hl, .CantEscapeNowText
	jp PrintText

.CantEscapeNowText:
	text "<TARGET>は"
	line "もう　にげられない！"
	prompt

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed

BattleCommand_Nightmare:
	ld hl, wEnemySubStatus1
	ld de, wEnemyMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, .got_status
	ld hl, wPlayerSubStatus1
	ld de, wBattleMonStatus

.got_status
; Can't hit an absent opponent.
	call CheckHiddenOpponent
	jr nz, .failed

; CAN hit a Substitute, unlike the final game.

; Only works on a sleeping opponent.
	ld a, [de]
	and SLP
	jr z, .failed

; Bail if the opponent is already having a nightmare.
	bit SUBSTATUS_NIGHTMARE, [hl]
	jr nz, .failed

; Otherwise give the opponent a nightmare.
	set SUBSTATUS_NIGHTMARE, [hl]
	call LoadMoveAnim
	ld hl, .StartedNightmareText
	jp PrintText

.StartedNightmareText:
	text "<TARGET>は"
	line "あくむを　みはじめた！"
	prompt

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed

; Thaw the user.
BattleCommand_Defrost:
	ld hl, wPartyMon1Status
	ld a, [wCurBattleMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wBattleMonStatus

	ldh a, [hBattleTurn]
	and a
	jr z, .got_battle_vars

	ld hl, wOTPartyMon1Status
	ld a, [wCurOTMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wEnemyMonStatus

.got_battle_vars
	bit FRZ, [hl]
	ret z

	res FRZ, [hl]
	ld a, [de]
	res FRZ, a
	ld [de], a

	ld hl, WasDefrostedText
	call PrintText
	ret

WasDefrostedText:
	text "<USER>の"
	line "こおりが　とけた！"
	prompt

; Cut HP in half and put a curse on the opponent.
BattleCommand_NailDown:
	ld hl, wEnemySubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wPlayerSubStatus1

.got_substatus
	call CheckHiddenOpponent
	jr nz, .failed
	bit SUBSTATUS_CURSE, [hl]
	jr nz, .failed
	set SUBSTATUS_CURSE, [hl]
	call LoadMoveAnim

	callfar GetQuarterMaxHP
	callfar SubtractHPFromUser

	ld hl, .PutACurseText
	jp PrintText

.PutACurseText
	text "<USER>は"
	line "じぶんに　くぎを　うった"
	para "<TARGET>は"
	line "のろいを　かけられた！"
	prompt

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed

BattleCommand_Protect:
	ld hl, wPlayerSubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wEnemySubStatus1

.got_substatus
	set SUBSTATUS_PROTECT, [hl]
	call LoadMoveAnim
	ld hl, ProtectedItselfText
	jp PrintText

ProtectedItselfText:
	text "<USER>は"
	line "まもりの　たいせいに　はいった！"
	prompt

BattleCommand_Spikes:
	ld hl, wEnemyScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens
	ld hl, wPlayerScreens

.got_screens
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

; Fails if spikes are already down!

	bit SCREENS_SPIKES, [hl]
	jr nz, .failed

; Nothing else stops it from working.

	set SCREENS_SPIKES, [hl]

	call LoadMoveAnim
	ld hl, .SpikesText
	jp PrintText

.SpikesText
	text "<TARGET>の　あしもとに"
	line "まきびしが　ちらばった！"
	prompt

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed

BattleCommand_Foresight:
	ld hl, wEnemySubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wPlayerSubStatus1

.got_substatus
	ld a, [wAttackMissed]
	and a
	jr nz, .failed
	
	call CheckHiddenOpponent
	jr nz, .failed

	bit SUBSTATUS_IDENTIFIED, [hl]
	jr nz, .failed

	set SUBSTATUS_IDENTIFIED, [hl]
	call LoadMoveAnim
	ld hl, .IdentifiedText
	jp PrintText

.IdentifiedText:
	text "<USER>は　<TARGET>の"
	line "しょうたいを　みやぶった！"
	prompt

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed

BattleCommand_PerishSong:
	ld hl, wPlayerSubStatus1
	ld de, wEnemySubStatus1
	bit SUBSTATUS_PERISH, [hl]
	jr z, .ok

	ld a, [de]
	bit SUBSTATUS_PERISH, a
	jr nz, .failed

.ok
	bit SUBSTATUS_PERISH, [hl]
	jr nz, .enemy

	set SUBSTATUS_PERISH, [hl]
	ld a, 4
	ld [wPlayerPerishCount], a

.enemy
	ld a, [de]
	jr nz, .done
	
	set SUBSTATUS_PERISH, a
	ld [de], a
	ld a, 4
	ld [wEnemyPerishCount], a

.done
	call LoadMoveAnim
	ld hl, StartPerishText
	call PrintText
	ret

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed

StartPerishText:
	text "おたがいの#は"
	line "３ターンごに　ほろびてしまう！"
	prompt

BattleCommand_StartSandstorm:
	ld hl, wEnemyScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens
	ld hl, wPlayerScreens

.got_screens
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	bit SCREENS_SANDSTORM, [hl]
	jr nz, .failed

	set SCREENS_SANDSTORM, [hl]
	call LoadMoveAnim
	ld hl, .SandstormBrewedText
	jp PrintText

.SandstormBrewedText:
	text "<TARGET>は"
	line "すなあらしに　まきこまれた！"
	prompt

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed

BattleCommand_Endure:
	ld hl, wPlayerSubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wEnemySubStatus1

.got_substatus
	set SUBSTATUS_ENDURE, [hl]
	call LoadMoveAnim
	ld hl, BracedItselfText
	jp PrintText

BracedItselfText:
	text "<USER>は　こらえる"
	line "たいせいに　はいった！"
	prompt

DEF MAX_ROLLOUT_COUNT EQU 5

BattleCommand_Rollout:
	ld hl, wPlayerSubStatus1
	ld de, wPlayerRolloutCount
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemySubStatus1
	ld de, wEnemyRolloutCount

.ok
	bit SUBSTATUS_ROLLOUT, [hl]
	jr z, .reset

	ld b, doturn_command
	jp SkipToBattleCommand

.reset:
	xor a
	ld [de], a
	ret

BattleCommand_RolloutPower:
	ld hl, wPlayerRolloutCount
	ld de, wPlayerSubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyRolloutCount
	ld de, wEnemySubStatus1

.ok
	ld a, [wAttackMissed]
	and a
	jr z, .hit

	ld a, [de]
	res SUBSTATUS_ROLLOUT, a
	ld [de], a
	ret

.hit
	inc [hl]
	ld a, [hl]
	ld b, a
	cp MAX_ROLLOUT_COUNT
	jr nz, .not_done_with_rollout

	ld a, [de]
	res SUBSTATUS_ROLLOUT, a
	ld [de], a
	jr .done_with_substatus_flag

.not_done_with_rollout
	ld a, [de]
	set SUBSTATUS_ROLLOUT, a
	ld [de], a

.done_with_substatus_flag
.loop
	dec b
	jr z, .done_damage

	ld hl, wCurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	jr nc, .loop

	ld a, $ff
	ld [hli], a
	ld [hl], a

.done_damage
	ret

; Dummied out in the final game in favor of a dedicated turn switch command.
; See BattleCommand_Unused5D in pokegold.
BattleCommand_OpponentAttackUp2:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	call LoadMoveAnim
	ld hl, wEnemyMoveStruct
	ldh a, [hBattleTurn]
	and a
	jr z, .got_move_struct
	ld hl, wPlayerMoveStruct

.got_move_struct:
; Flip turn to handle increasing stats of opposite side
	push af
	xor 1
	ldh [hBattleTurn], a

; Back up old move animation and effect
	ld a, [hli]
	push af
	ld a, [hl]
	push af
	push hl

; Set effect to EFFECT_ATTACK_UP_2
	ld a, EFFECT_ATTACK_UP_2
	ld [hld], a

; Zero out the move animation
	xor a
	ld [hl], a
	call BattleCommand_StatUp

; Return the variables to what they once were
	pop hl
	pop af
	ld [hld], a
	pop af
	ld [hl], a
	pop af
	ldh [hBattleTurn], a
	ret

.failed
	call BattleCommand_MoveDelay
	call PrintButItFailed
	jp EndMoveEffect

BattleCommand_FuryCutter:
	ld hl, wPlayerFuryCutterCount
	ldh a, [hBattleTurn]
	and a
	jr z, .go
	ld hl, wEnemyFuryCutterCount

.go
	ld a, [wAttackMissed]
	and a
	jr z, .do_fury_cutter
	call ResetFuryCutterCount
	ret

.do_fury_cutter
; BUG: No cap on Fury Cutter counter, unlike final game.
	inc [hl]
	ld a, [hl]
	ld b, a

.check_double
	dec b
	jr z, .return

; Double the damage
	ld hl, wCurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	jr nc, .check_double

; No overflow
	ld a, $ff
	ld [hli], a
	ld [hl], a

.return
	ret

ResetFuryCutterCount:
	push hl

	ld hl, wPlayerFuryCutterCount
	ldh a, [hBattleTurn]
	and a
	jr z, .reset
	ld hl, wEnemyFuryCutterCount

.reset
	xor a
	ld [hl], a

	pop hl
	ret

BattleCommand_Attract:
; Get player's species.
	ld a, [wBattleMonSpecies]
	ld [wCurSpecies], a
	call GetBaseData
; Use that to determine gender.
	xor a ; PARTYMON
	ld [wMonType], a
	callfar GetGender
; Get enemy's species
	push af
	ld a, [wEnemyMonSpecies]
	ld [wCurSpecies], a
	call GetBaseData
; Use that to determine gender.
	ld a, TEMPMON
	ld [wMonType], a
	callfar GetGender

; Retrieves both values of register f, and checks if they have the same gender.
; Inherits issues from GetGender: gender-unknown monsters are considered female.
	push af
	pop bc
	ld a, c
	pop bc
	xor c
	bit 4, a
	jr z, .failed

	ld hl, wEnemySubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wPlayerSubStatus1

.got_substatus
	call CheckHiddenOpponent
	jr nz, .failed

	bit SUBSTATUS_IN_LOVE, [hl]
	jr nz, .failed

	set SUBSTATUS_IN_LOVE, [hl]
	call LoadMoveAnim
	ld hl, .FellInLoveText
	jp PrintText

.FellInLoveText:
	text "<TARGET>は"
	line "メロメロに　なった！"
	prompt

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed

BattleCommand_HappinessPower:
; BUG: Return deals no damage when the user's happiness is too low
	push bc
	ld hl, wBattleMonHappiness
	ldh a, [hBattleTurn]
	and a
	jr z, .got_happiness
	ld hl, wEnemyMonHappiness

.got_happiness:
	xor a
	ldh [hMultiplicand], a
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ldh [hMultiplicand + 2], a
	ld a, 10
	ldh [hMultiplier], a
	call Multiply

	ld a, 25
	ldh [hDivisor], a
	ld b, 4
	call Divide

	ldh a, [hQuotient + 3]
	ld d, a
	pop bc
	ret

BattleCommand_Present:
	ld a, [wAttackMissed]
	and a
	ret nz

	push bc
	call BattleRandom
	ld b, a
	ld hl, PresentPower
	ld c, 0

.next
	ld a, [hli]
	cp -1
	jr z, .heal_effect

	cp b
	jr nc, .got_power

	inc c
	inc hl
	jr .next

.got_power
	xor a
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld d, [hl]
	pop bc
	ret

.heal_effect
	pop bc
	ld a, 1
	ld [wBattleAnimParam], a
	call LoadMoveAnim

	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	callfar GetQuarterMaxHP
	pop af
	ldh [hBattleTurn], a

	callfar RestoreHP
	jp EndMoveEffect

INCLUDE "data/moves/present_power.inc"

BattleCommand_FrustrationPower:
	push bc
	ld hl, wBattleMonHappiness
	ldh a, [hBattleTurn]
	and a
	jr z, .got_happiness
	ld hl, wEnemyMonHappiness

.got_happiness:
; If happiness is higher than 70, cap power at 30 minimum.
	ld a, [hl]
	cp 70
	ld d, 30
	jr nc, .happiness_higher_than_70

; 100 - Happiness = Move's power
	ld b, a
	ld a, 100
	sub b
	ld d, a

.happiness_higher_than_70:
	pop bc
	ret

BattleCommand_Safeguard:
	ld hl, wPlayerScreens
	ld de, wPlayerSafeguardCount
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyScreens
	ld de, wEnemySafeguardCount

.ok
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	bit SCREENS_SAFEGUARD, [hl]
	jr nz, .failed
	set SCREENS_SAFEGUARD, [hl]

	ld a, 5
	ld [de], a
	call LoadMoveAnim
	ld hl, .CoveredByVeilText
	jp PrintText

.CoveredByVeilText:
	text "<USER>は"
	line "しんぴのべールに　つつまれた！"
	prompt

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed

SafeCheckSafeguard:
	ld hl, wEnemyScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_turn
	ld hl, wPlayerScreens

.got_turn
	bit SCREENS_SAFEGUARD, [hl]
	ret

BattleCommand_CheckSafeguard:
	ld hl, wEnemyScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_turn
	ld hl, wPlayerScreens

.got_turn
	bit SCREENS_SAFEGUARD, [hl]
	ret z

	ld a, 1
	ld [wAttackMissed], a
	call BattleCommand_MoveDelay
	ld hl, SafeguardProtectText
	jp PrintText

SafeguardProtectText:
	text "<TARGET>は"
	line "しんぴのべールに　まもられている！"
	prompt

BattleCommand_GetMagnitude:
	push bc
	call BattleRandom
	ld b, a
	ld hl, MagnitudePower
.loop
	ld a, [hli]
	cp b
	jr nc, .ok
	inc hl
	inc hl
	jr .loop

.ok
	ld d, [hl]
	push de
	inc hl
	ld a, [hl]
	ld [wTextDecimalByte], a
	call BattleCommand_MoveDelay
	ld hl, MagnitudeText
	call PrintText
	pop de
	pop bc
	ret

MagnitudeText:
	text "マグニチュード@"
	deciram wTextDecimalByte, 1, 1
	text "！！"
	prompt

INCLUDE "data/moves/magnitude_power.inc"

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
	predef PartyMenuInBattle_Setup

.player_loop
	jr c, .pressed_b
	ld hl, wCurBattleMon
	ld a, [wCurPartyMon]
	cp [hl]
	jr nz, .picked_mon
	
	ld hl, BattleText_MonIsAlreadyOut
	call PrintText

.pressed_b
	predef PartyMenuInBattle
	jr .player_loop

.picked_mon
	callfar HasMonFainted
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

BattleText_MonIsAlreadyOut:
	text_from_ram wBattleMonNickname
	text "はもうでています"
	prompt

; Has not been implemented yet in any capacity.
BattleCommand_PursuitPlaceholder:
	ret

BattleCommand_EscapeTrappingMove:
	ld hl, wEnemySubStatus3
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wPlayerSubStatus3

.got_substatus
	bit SUBSTATUS_USING_TRAPPING_MOVE, [hl]
	ret z
	res SUBSTATUS_USING_TRAPPING_MOVE, [hl]
	ld hl, ReleasedByText
	call PrintText
	ret

ReleasedByText:
	text "<USER>は　<TARGET>の"
	line "こうげきから　かいほうされた！"
	prompt


BattleCommand_HealMorn:
	lb de, MORN_F, MORN_F
	jr BattleCommand_TimeBasedHealContinue

BattleCommand_HealDay:
	lb de, DAY_F, DAY_F
	jr BattleCommand_TimeBasedHealContinue

BattleCommand_HealNite:
	lb de, NITE_F, DARKNESS_F
	; fallthrough

; Restores random amount between 1/2 max HP to full max HP during certain times.
; Simply heals 1/2 HP otherwise.
BattleCommand_TimeBasedHealContinue:
	push de
	callfar GetMaxHP
	pop de

	ld a, [wTimeOfDay]
	cp d
	jr z, .start

	ld a, [wTimeOfDay]
	cp e
	jr z, .start
	callfar GetHalfMaxHP

.start
	call BattleRandom
	set 7, a
	ldh [hMultiplier], a
	xor a
	ldh [hMultiplicand], a
	ld a, b
	ldh [hMultiplicand + 1], a
	ld a, c
	ldh [hMultiplicand + 2], a
	call Multiply

	ld a, $ff
	ldh [hDivisor], a
	ld b, 4
	call Divide

	ldh a, [hQuotient + 2]
	ld b, a
	ldh a, [hQuotient + 3]
	ld c, a
	call LoadMoveAnim

	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	callfar RestoreHP
	pop af
	ldh [hBattleTurn], a

	ld hl, .RegainedHealthText
	call PrintText
	ret

.RegainedHealthText
	text "<USER>は　たいりょくを"
	line "かいふくした！"
	prompt

BattleCommand_HiddenPower:
	ld a, [wAttackMissed]
	and a
	ret nz

	push bc
	ld hl, wBattleMonDVs
	ld bc, wPlayerMoveStructType
	ldh a, [hBattleTurn]
	and a
	jr z, .got_dvs_and_type
	ld hl, wEnemyMonDVs
	ld bc, wEnemyMoveStructType

.got_dvs_and_type

; Power:

; Take the top bit from each stat

	; Attack
	push bc
	ld a, [hl]
	swap a
	and %1000

	; Defense
	ld b, a
	ld a, [hli]
	and %1000
	srl a
	or b

	; Speed
	ld b, a
	ld a, [hl]
	swap a
	and %1000
	srl a
	srl a
	or b
	
	; Special
	ld b, a
	ld a, [hl]
	and %1000
	srl a
	srl a
	srl a
	or b

; Multiply by 5
	ld b, a
	add a
	add a
	add b

; Add Special & 3
	ld b, a
	ld a, [hld]
	and %0011
	add b

	ld d, a

; Type:

	; Def & 3
	ld a, [hl]
	and %0011
	ld b, a

	; + (Atk & 3) << 2
	ld a, [hl]
	and %0011 << 4
	swap a
	sla a
	sla a
	or b

; Skip Normal
	inc a

; Skip Bird
	cp TYPE_BIRD
	jr c, .done
	inc a

; Skip unused types
	cp UNUSED_TYPES
	jr c, .done
	add UNUSED_TYPES_END - UNUSED_TYPES

.done
; Overwrite the current move type.
	pop bc
	ld [bc], a
	pop bc
	ret

BattleCommand_StartRain:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	ld a, WEATHER_RAIN
	ld [wBattleWeather], a
	ld a, 5
	ld [wWeatherCount], a
	call LoadMoveAnim
	ld hl, .DownpourText
	jp PrintText

.DownpourText
	text "おおあめに　なった！"
	prompt

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed

BattleCommand_StartSun:
	ld a, [wAttackMissed]
	and a
	jr nz, .failed

	ld a, WEATHER_SUN
	ld [wBattleWeather], a
	ld a, 5
	ld [wWeatherCount], a
	call LoadMoveAnim
	ld hl, .SunGotBrightText
	jp PrintText

.SunGotBrightText
	text "ひざしが　つよくなった！"
	prompt

.failed
	call BattleCommand_MoveDelay
	jp PrintButItFailed

; This function increments the current move's PP.
; It's used to prevent moves that run another move within the same turn
; (like Mirror Move and Metronome) from losing 2 PP.
IncrementMovePP:
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonPP
	ld de, wPartyMon1PP
	ld a, [wCurMoveNum]
	jr z, .ok
	ld hl, wEnemyMonPP
	ld de, wOTPartyMon1PP
	ld a, [wCurEnemyMoveNum]

.ok
	ld b, 0
	ld c, a
	add hl, bc
	inc [hl]
	ld h, d
	ld l, e
	add hl, bc
	ldh a, [hBattleTurn]
	and a
	ld a, [wCurBattleMon]
	jr z, .update_pp
	ld a, [wEnemyMonStatus]

.update_pp
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	inc [hl]
	ret

CheckHiddenOpponent:
	push hl
	ld hl, wEnemySubStatus3
	ldh a, [hBattleTurn]
	and a
	jr z, .player_turn
	ld hl, wPlayerSubStatus3
.player_turn
	bit SUBSTATUS_INVULNERABLE, [hl]
	pop hl
	ret

GetUserItem:
	ld hl, wBattleMonItem
	ldh a, [hBattleTurn]
	and a
	jp z, .go
	ld hl, wEnemyMonItem

.go
	ld b, [hl]
	jp GetItemHeldEffect

GetOpponentItem:
	ld hl, wEnemyMonItem
	ldh a, [hBattleTurn]
	and a
	jp z, .go
	ld hl, wBattleMonItem

.go
	ld b, [hl]
	jp GetItemHeldEffect

GetItemHeldEffect:
	ld a, b
	and a
	ret z

	push hl
	push bc
	ld hl, ItemAttributes + ITEMATTR_PARAM

	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc

	ld a, BANK(ItemAttributes)
	call GetFarByte

	pop bc
	ld c, a
	dec hl
	ld a, BANK(ItemAttributes)
	call GetFarByte

	ld b, a
	pop hl
	ret

ConsumeHeldItem:
	push hl
	push de
	push bc
	ldh a, [hBattleTurn]
	and a
	ld hl, wOTPartyMon1Item
	ld de, wEnemyMonItem
	ld a, [wCurOTMon]
	jr z, .their_turn
	ld hl, wPartyMon1Item
	ld de, wBattleMonItem
	ld a, [wCurBattleMon]

.their_turn
	push hl
	push af
	ld a, [de]
	ld b, a
	call GetItemHeldEffect
	ld hl, ConsumableEffects
.loop
	ld a, [hli]
	cp b
	jr z, .ok
	inc a
	jr nz, .loop
	pop af
	pop hl
	pop bc
	pop de
	pop hl
	ret

.ok
	xor a
	ld [de], a
	pop af
	pop hl
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ldh a, [hBattleTurn]
	and a
	jr nz, .ourturn
	ld a, [wBattleMode]
	dec a
	jr z, .done

.ourturn
	ld [hl], 0

.done
	pop bc
	pop de
	pop hl
	ret

INCLUDE "data/battle/held_consumables.inc"

PrintRecoveredUsingItem:
	push hl
	push de
	push bc
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	ld hl, RecoveredUsingText
	call PrintText
	pop bc
	pop de
	pop hl
	ret

RecoveredUsingText:
	text "そうびしていた"
	line "@"
	text_from_ram wStringBuffer1
	text "が　さどうした！"
	prompt

PlayDamageAnim:
	xor a
	ld [wFXAnimID + 1], a
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStructAnimation]
	jr z, .player
	ld a, [wEnemyMoveStructAnimation]

.player:
	and a
	ret z
	ld [wFXAnimID], a
	ldh a, [hBattleTurn]
	and a
	ld a, 6 ; BATTLEANIM_ENEMY_DAMAGE
	jr z, .player_damage
	ld a, 3 ; BATTLEANIM_PLAYER_DAMAGE

.player_damage:
	ld [wNumHits], a
	jp PlayUserBattleAnim

LoadMoveAnim:
	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStructAnimation]
	jr z, .not_enemy_turn
	ld a, [wEnemyMoveStructAnimation]
.not_enemy_turn
	and a
	ret z
	; Fallthrough
LoadBattleAnim:
	ld [wFXAnimID], a
	; Fallthrough
PlayUserBattleAnim:
	push hl
	push de
	push bc
	callfar PlayBattleAnim
	pop bc
	pop de
	pop hl
	ret

PlayOpponentBattleAnim:
	ld a, e
	ld [wFXAnimID], a
	ld a, d
	ld [wFXAnimID + 1], a
	xor a
	ld [wNumHits], a

	push hl
	push de
	push bc
	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	callfar PlayBattleAnim

	pop af
	ldh [hBattleTurn], a
	pop bc
	pop de
	pop hl
	ret

CallFromBank0F:
	ld a, $f
	jp FarCall_hl

BattleCommand_MoveDelay:
	ld c, 50
	jp DelayFrames

BattleCommand_ClearText:
	ld hl, .text
	jp PrintText

.text:
	text_end

SkipToBattleCommand:
	ld a, [wBattleScriptBufferAddress + 1]
	ld h, a
	ld a, [wBattleScriptBufferAddress]
	ld l, a
.loop
	ld a, [hli]
	cp b
	jr nz, .loop
	ld a, h
	ld [wBattleScriptBufferAddress + 1], a
	ld a, l
	ld [wBattleScriptBufferAddress], a
	ret

