INCLUDE "constants.asm"

SECTION "engine/battle/ai/scoring.asm", ROMX

AI_Basic:
; Don't use status-only moves if the player can't be statused.
; The final game elaborates on this to include other redundancies (see final's AI_Redundant)
	ld a, [wBattleMonStatus]
	and a
	ret z
	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonMoves
	ld b, NUM_MOVES + 1
.checkmove
	dec b
	ret z

	inc hl
	ld a, [de]
	and a
	ret z

	inc de
	call AIGetEnemyMove

	ld a, [wEnemyMoveStructEffect]
	push hl
	push de
	push bc

; Dismiss status-only moves if the player can't be statused.
	ld hl, StatusOnlyEffects
	ld de, 1
	call FindItemInTable
	pop bc
	pop de
	pop hl
	jr nc, .checkmove

	ld a, [hl]
	add 5
	ld [hl], a
	jr .checkmove

StatusOnlyEffects:
	db EFFECT_SLEEP
	db EFFECT_TOXIC
	db EFFECT_POISON
	db EFFECT_PARALYZE
	db -1

; Stat-changing moves are discouraged on all turns except for the first turn.
AI_Setup:
	ld a, [wEnemyTurnsTaken]
	and a
	ret z

	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonMoves
	ld b, NUM_MOVES + 1
.checkmove
	dec b
	ret z
	inc hl
	ld a, [de]
	and a
	ret z
	inc de
	call AIGetEnemyMove
	ld a, [wEnemyMoveStructEffect]

	cp EFFECT_ATTACK_UP
	jr c, .checkmove
; Don't boost the probability of Swift when running this check.
	cp EFFECT_SWIFT
	jr z, .checkmove
	cp EFFECT_RESET_STATS + 1
	jr c, .discourage

	cp EFFECT_ATTACK_UP_2
	jr c, .checkmove
	cp EFFECT_REFLECT + 1
	jr c, .discourage

	jr .checkmove

.discourage
	inc [hl]
	inc [hl]
	jr .checkmove

; Dismiss any move that the player is immune to.
; Encourage super-effective moves.
; Discourage not very effective moves unless
; all damaging moves are of the same type.
AI_Types:
	ret ; Cuts off the rest of the function.

	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonMoves
	ld b, NUM_MOVES + 1
.checkmove
	dec b
	ret z

	inc hl
	ld a, [de]
	and a
	ret z

	inc de
	call AIGetEnemyMove

	push hl
	push bc
	push de
	ld a, 1
	ldh [hBattleTurn], a
	callfar BattleCheckTypeMatchup
	pop de
	pop bc
	pop hl

	ld a, [wTypeMatchup]
	and a
	jr z, .immune
	cp EFFECTIVE
	jr z, .checkmove
	jr c, .noteffective

; effective
	ld a, [wEnemyMoveStructPower]
	and a
	jr z, .checkmove
	dec [hl]
	jr .checkmove

.noteffective
; Discourage this move if there are any moves
; that do damage of a different type.
	push hl
	push de
	push bc
	ld a, [wEnemyMoveStructType]
	ld d, a
	ld hl, wEnemyMonMoves
	ld b, NUM_MOVES + 1
	ld c, 0
.checkmove2
	dec b
	jr z, .movesdone

	ld a, [hli]
	and a
	jr z, .movesdone

	call AIGetEnemyMove
	ld a, [wEnemyMoveStructType]
	cp d
	jr z, .checkmove2

	ld a, [wEnemyMoveStructPower]
	and a
	jr nz, .damaging
	jr .checkmove2

.damaging
	ld c, a
.movesdone
	ld a, c
	pop bc
	pop de
	pop hl
	and a
	jr z, .checkmove
	inc [hl]
	jr .checkmove

.immune
	ld a, [hl]
	add 10
	ld [hl], a
	jr .checkmove

; Not implemented in any capacity yet.
AI_Offensive_Placeholder:
	ret

; Context-specific scoring.
AI_Smart:
	ld hl, wEnemyAIMoveScores
	ld de, wEnemyMonMoves
	ld b, NUM_MOVES + 1
.checkmove
	dec b
	ret z

	ld a, [de]
	inc de
	and a
	ret z

	push de
	push bc
	push hl
	call AIGetEnemyMove

	ld a, [wEnemyMoveStructEffect]
	ld hl, AI_Smart_EffectHandlers
	ld de, 3
	call FindItemInTable

	inc hl
	jr nc, .nextmove

	ld a, [hli]
	ld e, a
	ld d, [hl]

	pop hl
	push hl

	ld bc, .nextmove
	push bc

	push de
	ret

.nextmove
	pop hl
	pop bc
	pop de
	inc hl
	jr .checkmove

AI_Smart_EffectHandlers:
	dbw EFFECT_SELFDESTRUCT,     AI_Smart_Selfdestruct
	dbw EFFECT_DREAM_EATER,      AI_Smart_DreamEater
	dbw EFFECT_MIRROR_MOVE,      AI_Smart_MirrorMove
	dbw EFFECT_RESET_STATS,      AI_Smart_ResetStats
	dbw EFFECT_HEAL,             AI_Smart_Heal
	dbw EFFECT_TOXIC,            AI_Smart_Toxic
	dbw EFFECT_OHKO,             AI_Smart_Ohko
	dbw EFFECT_RAZOR_WIND,       AI_Smart_RazorWind
	dbw EFFECT_SUPER_FANG,       AI_Smart_SuperFang
	dbw EFFECT_FLY,              AI_Smart_Fly
	dbw EFFECT_CONFUSE,          AI_Smart_Confuse
	dbw EFFECT_SUBSTITUTE,       AI_Smart_Substitute
	dbw EFFECT_MIMIC,            AI_Smart_Mimic
	dbw EFFECT_LEECH_SEED,       AI_Smart_LeechSeed
	dbw EFFECT_DISABLE,          AI_Smart_Disable
	dbw EFFECT_COUNTER,          AI_Smart_Counter
	dbw EFFECT_ENCORE,           AI_Smart_Encore
	dbw EFFECT_PAIN_SPLIT,       AI_Smart_PainSplit
	dbw EFFECT_SNORE,            AI_Smart_Snore
	dbw EFFECT_CONVERSION2,      AI_Smart_Conversion2
	dbw EFFECT_LOCK_ON,          AI_Smart_LockOn
	dbw EFFECT_DEFROST_OPPONENT, AI_Smart_DefrostOpponent
	dbw EFFECT_SLEEP_TALK,       AI_Smart_SleepTalk
	dbw EFFECT_DESTINY_BOND,     AI_Smart_DestinyBond
	dbw EFFECT_REVERSAL,         AI_Smart_Reversal
	dbw EFFECT_SPITE,            AI_Smart_Spite
	dbw EFFECT_BELL_CHIME,       AI_Smart_BellChime
	dbw EFFECT_PRIORITY_HIT,     AI_Smart_PriorityHit
	db -1

; Encourage using Lock-On if the trainer has several low-accuracy moves.
AI_Smart_LockOn:
	ld a, [wEnemySubStatus5] ; BUG: This really should be wPlayerSubStatus5
	bit SUBSTATUS_LOCK_ON, a
	jr nz, .enemy_locked_on

	push hl
	ld hl, wEnemyMonMoves
	ld c, NUM_MOVES + 1
.checkmove:
	dec c
	jr z, .discourage

	ld a, [hli]
	and a
	jr z, .discourage

	call AIGetEnemyMove
	ld a, [wEnemyMoveStructAccuracy]
	cp 71 percent - 1
	jr nc, .checkmove
.discourage
	pop hl
	ret nc
	inc [hl]
	ret

.enemy_locked_on
	push hl
	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonMoves
	ld c, NUM_MOVES + 1

.checkmove2
	inc hl
	dec c
	jr z, .dismiss
	ld a, [de]
	and a
	jr z, .dismiss

	inc de
	call AIGetEnemyMove
	ld a, [wEnemyMoveStructAccuracy]
	cp 71 percent - 1
	jr nc, .checkmove2
	dec [hl]
	jr .checkmove2

.dismiss
	pop hl
	ld a, [hl]
	add 10
	ld [hl], a
	ret

AI_Smart_Selfdestruct:
; Do nothing if enemy's HP is below 25%.
	call AICheckEnemyQuarterHP
	ret nc

; If enemy's HP is between 25% and 50%,
; over 90% chance to greatly discourage this move.
	call Random
	cp 8 percent
	ret c
; Discourage
	inc [hl]
	ret

; Repurposed as an AI_Redundant check for all trainers in the final game.
AI_Smart_DreamEater:
	ld a, [wBattleMonStatus]
	and SLP
	jr nz, .encourage

	ld a, [hl]
	add 10
	ld [hl], a
	ret

.encourage
	dec [hl]
	dec [hl]
	dec [hl]
	ret

AI_Smart_MirrorMove:
; If the player did not use any move last turn...
	ld a, [wLastPlayerCounterMove]
	and a
	jr nz, .usedmove

; ...do nothing if enemy is slower than player
	call AICompareSpeed
	ret nc

; ...or dismiss this move if enemy is faster than player.
	ld a, [hl]
	add 10
	ld [hl], a
	ret

; If the player did use a move last turn...
.usedmove
	push hl
	ld hl, UsefulMoves
	ld de, 1
	call FindItemInTable
	pop hl

; ...do nothing if they didn't use a useful move.
	ret nc

	dec [hl]
	ret

AI_Smart_ResetStats:
; 85% chance to encourage this move if any of enemy's stat levels is lower than -2.
	push hl
	ld hl, wEnemyStatLevels
	ld c, NUM_LEVEL_STATS
.enemystatsloop
	dec c
	jr z, .enemystatsdone
	ld a, [hli]
	cp BASE_STAT_LEVEL - 2
	jr c, .encourage
	jr .enemystatsloop

; 85% chance to encourage this move if any of player's stat levels is higher than +2.
.enemystatsdone
	ld hl, wPlayerStatLevels
	ld c, NUM_LEVEL_STATS
.playerstatsloop
	dec c
	jr z, .discourage
	ld a, [hli]
	cp BASE_STAT_LEVEL + 3
	jr c, .playerstatsloop

.encourage
	pop hl
	call Random
	cp 16 percent
	ret c
	dec [hl]
	ret

; Discourage this move if neither:
; Any of enemy's stat levels is lower than -2.
; Any of player's stat levels is higher than +2.
.discourage
	pop hl
	inc [hl]
	ret

AI_Smart_Heal:
	call AICheckEnemyHalfHP
	ret nc
	inc [hl]
	ret

AI_Smart_Toxic:
; Discourage this move if player's HP is below 50%.
	call AICheckPlayerHalfHP
	ret c
	inc [hl]
	ret

; BUG: Unlike the final game, does not get discouraged when the player's
; level is higher than the enemy's, causing this to be encouraged even when it would fail.
AI_Smart_Ohko:
; Discourage this move if player's HP is below 50%.
	call AICheckPlayerHalfHP
	ret c
	inc [hl]
	ret

; Final game splits Dig and Fly into their own, dumbed-down function that lacks even an HP check.
; The final game also added checks for confusion and Perish Song here.
AI_Smart_RazorWind:
AI_Smart_Fly:
	ld a, [wEnemyMoveStruct]
	cp MOVE_FLY
	jr z, .used_fly_or_dig
	cp MOVE_DIG
	jr z, .used_fly_or_dig
	push hl

; Rolled into AICheckEnemyHalfHP for the final game
	ld hl, wEnemyMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	inc hl
	inc hl
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	pop hl
	ret c

; Discourage if at 1/2 HP or less.
	inc [hl]
	ret

; Greatly encourage this move if the player is
; flying or underground, and slower than the enemy.
.used_fly_or_dig
	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_INVULNERABLE, a
	jr nz, .invulnerable
	ret

.invulnerable
	call AICompareSpeed
	ret nc

	dec [hl]
	ret

AI_Smart_Confuse:
	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_CONFUSED, a
	ret z
	ld a, [hl]
	add 10
	ld [hl], a
	ret

AI_Smart_SuperFang:
; Discourage if player has 25% HP or lower.
; Check was rolled into AICheckPlayerQuarterHP in the final game.
	push hl
	ld hl, wBattleMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	sla c
	rl b
	inc hl
	inc hl
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	pop hl
	ret c

	inc [hl]
	ret

AI_Smart_Substitute:
; Dismiss this move if enemy's HP is below 50%.
	call AICheckEnemyHalfHP
	jr nc, .discourage

	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	ret z

.discourage:
	ld a, [hl]
	add 10
	ld [hl], a
	ret

; BUG: Doesn't actually DISCOURAGE the move unless the player uses a move
; that would not be effective against itself.
; Consequently, the Smart AI might still use Mimic even if no move has actually been used yet.
AI_Smart_Mimic:
	ld a, [wLastPlayerCounterMove]
	and a
	ret z

	push hl
	call AIGetEnemyMove

	ld a, 1
	ldh [hBattleTurn], a
	callfar BattleCheckTypeMatchup

	ld a, [wTypeMatchup]
	cp EFFECTIVE
	pop hl
	jr c, .discourage
	jr z, .skip_encourage

	dec [hl]
.skip_encourage
	ld a, [wLastPlayerCounterMove]
	and a
	ret z ; Pointless repeat of an earlier check...

	push hl
	ld hl, UsefulMoves
	ld de, 1
	call FindItemInTable
	pop hl
	ret nc

	dec [hl]
	ret

.discourage
	inc [hl]
	ret

; Repurposed as an AI_Redundant check for all trainers in the final game.
AI_Smart_LeechSeed:
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	ret z

	ld a, [hl]
	add 10
	ld [hl], a
	ret

; Note that in this build, the AI will read the player's moves directly from the Pokémon's data.
; The final game adds the buffer wPlayerUsedMoves so that the opponent can "learn" the player's moves
; instead of somehow knowing them already.
AI_Smart_Counter:
	push hl
	ld hl, wBattleMonMoves
	ld c, NUM_MOVES
	ld b, 0

.playermoveloop:
	ld a, [hli]
	and a
	jr z, .skipmove

	call AIGetEnemyMove
	ld a, [wEnemyMoveStructPower]
	and a
	jr z, .skipmove

	ld a, [wEnemyMoveStructType]
	cp SPECIAL_TYPES
	jr nc, .skipmove

	inc b

.skipmove:
	dec c
	jr nz, .playermoveloop

	pop hl
	ld a, b
	and a
	jr z, .discourage

	cp 3
	jr nc, .encourage

	ld a, [wLastPlayerCounterMove]
	and a
	jr z, .done

	call AIGetEnemyMove
	ld a, [wEnemyMoveStructPower]
	and a
	jr z, .done

	ld a, [wEnemyMoveStructType]
	cp SPECIAL_TYPES
	jr nc, .done

.encourage
	call Random
	cp 39 percent + 1
	jr c, .done

	dec [hl]
.done:
	ret

.discourage
	inc [hl]
	ret

AI_Smart_Encore:
; This part is handled by AI_Redundant in the final game.
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_ENCORED, a
	jr nz, .discourage

	push hl
	ld a, [wLastPlayerCounterMove]
	ld hl, EncoreMoves
	ld de, 1
	call FindItemInTable
	pop hl
	ret nc

	call AICompareSpeed
	ret nc

	dec [hl]
	dec [hl]
	ret

.discourage
	ld a, [hl]
	add 10
	ld [hl], a
	ret

INCLUDE "data/battle/ai/encore_moves.inc"

AI_Smart_PainSplit:
; Discourage this move if [enemy's current HP * 2 > player's current HP].

	push hl
	ld hl, wEnemyMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	ld hl, wBattleMonHP + 1
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	pop hl
	ret nc
	inc [hl]
	ret

AI_Smart_Snore:
AI_Smart_SleepTalk:
; Encourage this move if enemy is fast asleep.
; Greatly discourage this move otherwise.
; The final game also discourages this move if the opponent is on their last turn of sleep.

	ld a, [wEnemyMonStatus]
	and SLP
	jr nz, .encourage

	ld a, [hl]
	add 10
	ld [hl], a
	ret

.encourage
	dec [hl]
	dec [hl]
	ret

AI_Smart_DefrostOpponent:
; Greatly encourage this move if enemy is frozen.
; No move has EFFECT_DEFROST_OPPONENT, so this layer is unused.

	ld a, [wEnemyMonStatus]
	and 1 << FRZ
	ret z
	dec [hl]
	dec [hl]
	dec [hl]
	ret

; BUG: The final game checks if the player has actually used a move first.
; If no move has been used yet/the player is frozen/asleep, then the player's Pokémon having
; less than four moves encourages the AI to use Spite against them.
AI_Smart_Spite:
	push hl
	ld a, [wLastPlayerCounterMove]
	ld b, a
	ld c, NUM_MOVES
	ld hl, wBattleMonMoves
	ld de, wBattleMonPP

.moveloop
	ld a, [hli]
	cp b
	jr z, .foundmove

	inc de
	dec c
	jr nz, .moveloop
	pop hl
	ret

.foundmove
; Discourage if move's PP is less than 6.
	ld a, [de]
	cp 6
	pop hl
	ret c

	inc [hl]
	ret

AI_Smart_DestinyBond:
AI_Smart_Reversal:
; Discourage this move if enemy's HP is above 25%.

	call AICheckEnemyQuarterHP
	ret nc
	inc [hl]
	ret

; Greatly discourage this move if the user isn't statused.
AI_Smart_BellChime:
	ld a, [wEnemyMonStatus]
	and a
	ret nz

	ld a, [hl]
	add 10
	ld [hl], a
	ret

; 90% chance to encourage the move if the player has 1/8 HP or lower.
AI_Smart_PriorityHit:
	call AICompareSpeed
	ret c

	push hl
	ld hl, wBattleMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	sla c
	rl b
	sla c
	rl b
	inc hl
	inc hl
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc a, b
	pop hl
	ret c

	call Random
	cp 10 percent
	ret c
	dec [hl]
	ret

; ~60% change to encourage the move if the player is... a Ghost-type?
AI_Smart_Conversion2:
	ld a, [wBattleMonType1]
	cp TYPE_GHOST
	jr z, .ghost_type

	ld a, [wBattleMonType2]
	cp TYPE_GHOST
	ret nz

.ghost_type
	call Random
	cp 39 percent + 1
	ret c
	dec [hl]
	ret

; Strongly discourage if the player is already disabled.
AI_Smart_Disable:
	ld a, [wPlayerDisableCount]
	and a
	ret z

	ld a, [hl]
	add 10
	ld [hl], a
	ret

; Return carry if enemy is faster than player.
AICompareSpeed:
	push bc
	ld a, [wEnemyMonSpeed + 1]
	ld b, a
	ld a, [wBattleMonSpeed + 1]
	cp b
	ld a, [wEnemyMonSpeed]
	ld b, a
	ld a, [wBattleMonSpeed]
	sbc b
	pop bc
	ret

AICheckPlayerHalfHP:
	push hl
	ld hl, wBattleMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	inc hl
	inc hl
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	pop hl
	ret

AICheckEnemyHalfHP:
	push hl
	ld hl, wEnemyMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	inc hl
	inc hl
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	pop hl
	ret

AICheckEnemyQuarterHP:
	push hl
	ld hl, wEnemyMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	sla c
	rl b
	sla c
	rl b
	inc hl
	inc hl
	ld a, [hld]
	cp c
	ld a, [hl]
	sbc b
	pop hl
	ret

; Return carry if the enemy has a move in array hl.
AIHasMoveInArray:
	push hl
	push de
	push bc

.next
	ld a, [hli]
	cp -1
	jr z, .done

	ld b, a
	ld c, NUM_MOVES + 1
	ld de, wEnemyMonMoves

.check
	dec c
	jr z, .next

	ld a, [de]
	inc de
	cp b
	jr nz, .check

	scf

.done
	pop bc
	pop de
	pop hl
	ret

INCLUDE "data/battle/ai/useful_moves.inc"

AI_Opportunist:
; Discourage stall moves when the enemy's HP is low.

; Do nothing if enemy's HP is above 50%.
	call AICheckEnemyHalfHP
	ret c

; Discourage stall moves if enemy's HP is below 25%.
	call AICheckEnemyQuarterHP
	jr nc, .lowhp

	call Random
	cp 50 percent + 1
	ret c

.lowhp
	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonMoves
	ld c, NUM_MOVES + 1
.checkmove
	inc hl
	dec c
	jr z, .done

	ld a, [de]
	inc de
	and a
	jr z, .done

	push hl
	push de
	push bc
	ld hl, StallMoves
	ld de, 1
	call FindItemInTable

	pop bc
	pop de
	pop hl
	jr nc, .checkmove

	inc [hl]
	jr .checkmove

.done
	ret

INCLUDE "data/battle/ai/stall_moves.inc"

AI_Aggressive:
; Use whatever does the most damage.

; Discourage all damaging moves but the one that does the most damage.
; If no damaging move deals damage to the player (immune),
; no move will be discouraged

; Figure out which attack does the most damage and put it in c.
	ld hl, wEnemyMonMoves
	ld bc, 0
	ld de, 0
.checkmove
	inc b
	ld a, b
	cp NUM_MOVES + 1
	jr z, .gotstrongestmove

	ld a, [hli]
	and a
	jr z, .gotstrongestmove

	push hl
	push de
	push bc
	call AIGetEnemyMove
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	and a
	jr z, .nodamage
; BUG: Doesn't take constant-damage moves into account
	ldh a, [hBattleTurn]
	push af
	ld a, 1
	ldh [hBattleTurn], a
	callfar EnemyAttackDamage
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
	pop af
	ldh [hBattleTurn], a
	pop bc
	pop de
	pop hl

; Update current move if damage is highest so far
	ld a, [wCurDamage + 1]
	cp e
	ld a, [wCurDamage]
	sbc d
	jr c, .checkmove

	ld a, [wCurDamage + 1]
	ld e, a
	ld a, [wCurDamage]
	ld d, a
	ld c, b
	jr .checkmove

.nodamage
	pop bc
	pop de
	pop hl
	jr .checkmove

.gotstrongestmove
; Nothing we can do if no attacks did damage.
	ld a, c
	and a
	jr z, .done

; Discourage moves that do less damage unless they're reckless too.
	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonMoves
	ld b, 0
.checkmove2
	inc b
	ld a, b
	cp NUM_MOVES + 1
	jr z, .done

; Ignore this move if it is the highest damaging one.
	cp c
	ld a, [de]
	inc de
	inc hl
	jr z, .checkmove2

	call AIGetEnemyMove

; Ignore this move if its power is 0 or 1.
; Moves such as Seismic Toss, Hidden Power,
; Counter and Fissure have a base power of 1.
	ld a, [wEnemyMoveStruct + MOVE_POWER]
	cp 2
	jr c, .checkmove2

; Ignore this move if it is reckless.
	push hl
	push de
	push bc
	ld a, [wEnemyMoveStruct + MOVE_EFFECT]
	ld hl, RecklessMoves
	ld de, 1
	call FindItemInTable
	pop bc
	pop de
	pop hl
	jr c, .checkmove2

; If we made it this far, discourage this move.
	inc [hl]
	jr .checkmove2

.done
	ret

INCLUDE "data/battle/ai/reckless_moves.inc"

AI_Cautious:
; Discourage moves with residual effects after the first turn.
; Additionally left up to a 90% chance in the final game.

	ld a, [wEnemyTurnsTaken]
	and a
	ret z

	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonMoves
	ld c, NUM_MOVES + 1
.loop
	inc hl
	dec c
	jr z, .return

	ld a, [de]
	inc de
	and a
	jr z, .return

	push hl
	push de
	push bc
	ld hl, ResidualMoves
	ld de, 1
	call FindItemInTable

	pop bc
	pop de
	pop hl
	jr nc, .loop

	inc [hl]
	jr .loop

.return
	ret

INCLUDE "data/battle/ai/residual_moves.inc"

AI_None:
	ret

AIGetEnemyMove:
; Load attributes of move a into ram

	push hl
	push de
	push bc
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes

	ld de, wEnemyMoveStruct
	ld a, BANK(Moves)
	call FarCopyBytes

	pop bc
	pop de
	pop hl
	ret
