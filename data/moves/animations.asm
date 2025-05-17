INCLUDE "constants.asm"

SECTION "data/moves/animations.asm", ROMX

BattleAnim_Dummy:
BattleAnim_MirrorMove:
	anim_ret

BattleAnim_ThrowPokeBall:
	anim_if_param_equal ITEM_MASTER_BALL, .MasterBall
	anim_if_param_equal ITEM_ULTRA_BALL, .UltraBall
	anim_if_param_equal ITEM_GREAT_BALL, .GreatBall
	anim_if_param_equal ITEM_POKE_BALL, .PokeBall
.TheTrainerBlockedTheBall:
	anim_2gfx BATTLE_ANIM_GFX_POKE_BALL, BATTLE_ANIM_GFX_HIT
	anim_sound 6, 2, SFX_THROW_BALL
	anim_obj BATTLE_ANIM_OBJ_POKE_BALL_BLOCKED, 64, 92, $20
	anim_wait 20
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 112, 40, $0
	anim_wait 32
	anim_ret

.UltraBall:
	anim_2gfx BATTLE_ANIM_GFX_POKE_BALL, BATTLE_ANIM_GFX_SMOKE
	anim_sound 6, 2, SFX_THROW_BALL
	anim_obj BATTLE_ANIM_OBJ_POKE_BALL, 68, 92, $40
	anim_wait 36
	anim_obj BATTLE_ANIM_OBJ_POKE_BALL, 136, 65, $0
	anim_setobj $2, $6
	anim_wait 16
	anim_sound 0, 1, SFX_BALL_POOF
	anim_obj BATTLE_ANIM_OBJ_BALL_POOF, 136, 64, $10
	anim_wait 16
	anim_bgeffect BATTLE_BG_EFFECT_RETURN_MON, $0, BG_EFFECT_TARGET, $0
	anim_wait 8
	anim_incobj 2
	anim_wait 16
	anim_incobj 1
	anim_wait 128
	anim_jump .FinishShake

.GreatBall:
	anim_2gfx BATTLE_ANIM_GFX_POKE_BALL, BATTLE_ANIM_GFX_SMOKE
	anim_sound 6, 2, SFX_THROW_BALL
	anim_obj BATTLE_ANIM_OBJ_POKE_BALL, 68, 92, $40
	anim_wait 36
	anim_obj BATTLE_ANIM_OBJ_POKE_BALL, 136, 65, $0
	anim_setobj $2, $6
	anim_wait 16
	anim_sound 0, 1, SFX_BALL_POOF
	anim_obj BATTLE_ANIM_OBJ_BALL_POOF, 136, 64, $10
	anim_wait 16
	anim_bgeffect BATTLE_BG_EFFECT_RETURN_MON, $0, BG_EFFECT_TARGET, $0
	anim_wait 8
	anim_incobj 2
	anim_wait 16
	anim_incobj 1
	anim_wait 128
	anim_jump .FinishShake

.PokeBall:
	anim_2gfx BATTLE_ANIM_GFX_POKE_BALL, BATTLE_ANIM_GFX_SMOKE
	anim_sound 6, 2, SFX_THROW_BALL
	anim_obj BATTLE_ANIM_OBJ_POKE_BALL, 68, 92, $40
	anim_wait 36
	anim_obj BATTLE_ANIM_OBJ_POKE_BALL, 136, 65, $0
	anim_setobj $2, $6
	anim_wait 16
	anim_sound 0, 1, SFX_BALL_POOF
	anim_obj BATTLE_ANIM_OBJ_BALL_POOF, 136, 64, $10
	anim_wait 16
	anim_bgeffect BATTLE_BG_EFFECT_RETURN_MON, $0, BG_EFFECT_TARGET, $0
	anim_wait 8
	anim_incobj 2
	anim_wait 16
	anim_incobj 1
	anim_wait 128
	anim_jump .FinishShake

.MasterBall:
	anim_3gfx BATTLE_ANIM_GFX_POKE_BALL, BATTLE_ANIM_GFX_SMOKE, BATTLE_ANIM_GFX_SPEED
	anim_sound 6, 2, SFX_THROW_BALL
	anim_obj BATTLE_ANIM_OBJ_POKE_BALL, 64, 92, $20
	anim_wait 36
	anim_obj BATTLE_ANIM_OBJ_POKE_BALL, 136, 65, $0
	anim_setobj $2, $6
	anim_wait 16
	anim_sound 0, 1, SFX_BALL_POOF
	anim_obj BATTLE_ANIM_OBJ_BALL_POOF, 136, 64, $10
	anim_wait 24
	anim_obj BATTLE_ANIM_OBJ_MASTER_BALL_SPARKLE, 136, 56, $30
	anim_obj BATTLE_ANIM_OBJ_MASTER_BALL_SPARKLE, 136, 56, $31
	anim_obj BATTLE_ANIM_OBJ_MASTER_BALL_SPARKLE, 136, 56, $32
	anim_obj BATTLE_ANIM_OBJ_MASTER_BALL_SPARKLE, 136, 56, $33
	anim_obj BATTLE_ANIM_OBJ_MASTER_BALL_SPARKLE, 136, 56, $34
	anim_obj BATTLE_ANIM_OBJ_MASTER_BALL_SPARKLE, 136, 56, $35
	anim_obj BATTLE_ANIM_OBJ_MASTER_BALL_SPARKLE, 136, 56, $36
	anim_obj BATTLE_ANIM_OBJ_MASTER_BALL_SPARKLE, 136, 56, $37
	anim_wait 64
	anim_bgeffect BATTLE_BG_EFFECT_RETURN_MON, $0, BG_EFFECT_TARGET, $0
	anim_wait 8
	anim_incobj 2
	anim_wait 16
	anim_incobj 1
	anim_wait 128
.FinishShake:
	anim_setvar $0
.Loop:
	anim_sound 0, 1, SFX_BALL_WOBBLE
	anim_wait 48
	anim_checkpokeball
	anim_if_var_equal $1, .Click
	anim_if_var_equal $2, .BreakFree
	anim_incobj 1
	anim_jump .Loop

.Click:
	anim_keepsprites
	anim_ret

.BreakFree:
	anim_setobj $1, $a
	anim_sound 0, 1, SFX_BALL_POOF
	anim_obj BATTLE_ANIM_OBJ_BALL_POOF, 136, 64, $10
	anim_wait 2
	anim_bgeffect BATTLE_BG_EFFECT_ENTER_MON, $0, BG_EFFECT_TARGET, $0
	anim_wait 32
	anim_ret

BattleAnim_SendOutMon:
	anim_if_param_equal $0, .Normal
	anim_if_param_equal $1, .Shiny
	anim_if_param_equal $2, .Unknown
	anim_1gfx BATTLE_ANIM_GFX_SMOKE
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_BETA_SEND_OUT_MON2, $0, BG_EFFECT_USER, $0
	anim_sound 0, 0, SFX_BALL_POOF
	anim_obj BATTLE_ANIM_OBJ_BETA_BALL_POOF, 48, 96, $0
	anim_bgeffect BATTLE_BG_EFFECT_ENTER_MON, $0, BG_EFFECT_USER, $0
	anim_wait 128
	anim_wait 4
	anim_call BattleAnim_ShowMon_0
	anim_ret

.Unknown:
	anim_1gfx BATTLE_ANIM_GFX_SMOKE
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_BETA_SEND_OUT_MON1, $0, BG_EFFECT_USER, $0
	anim_wait 1
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_USER, $0
	anim_wait 4
	anim_sound 0, 0, SFX_BALL_POOF
	anim_obj BATTLE_ANIM_OBJ_BETA_BALL_POOF, 48, 96, $0
	anim_incbgeffect BATTLE_BG_EFFECT_BETA_SEND_OUT_MON1
	anim_wait 96
	anim_incbgeffect BATTLE_BG_EFFECT_BETA_SEND_OUT_MON1
	anim_call BattleAnim_ShowMon_0
	anim_ret

.Shiny:
	anim_1gfx BATTLE_ANIM_GFX_SMOKE
	anim_sound 0, 0, SFX_BALL_POOF
	anim_obj BATTLE_ANIM_OBJ_BETA_BALL_POOF, 48, 96, $0
	anim_wait 16
	anim_1gfx BATTLE_ANIM_GFX_SPEED
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $2, $6
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS, $0, $2, $0
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SHINY, 48, 96, $0
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SHINY, 48, 96, $8
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SHINY, 48, 96, $10
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SHINY, 48, 96, $18
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SHINY, 48, 96, $20
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SHINY, 48, 96, $28
	anim_bgeffect BATTLE_BG_EFFECT_ENTER_MON, $0, BG_EFFECT_USER, $0
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SHINY, 48, 96, $30
	anim_wait 4
	anim_sound 0, 0, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_SHINY, 48, 96, $38
	anim_wait 32
	anim_ret

.Normal:
	anim_1gfx BATTLE_ANIM_GFX_SMOKE
	anim_sound 0, 0, SFX_BALL_POOF
	anim_obj BATTLE_ANIM_OBJ_BALL_POOF, 44, 96, $0
	anim_wait 4
	anim_bgeffect BATTLE_BG_EFFECT_ENTER_MON, $0, BG_EFFECT_USER, $0
	anim_wait 32
	anim_ret

BattleAnim_ReturnMon:
	anim_sound 0, 0, SFX_BALL_POOF
BattleAnimSub_Return:
	anim_bgeffect BATTLE_BG_EFFECT_RETURN_MON, $0, BG_EFFECT_USER, $0
	anim_wait 32
	anim_ret

BattleAnim_Confused:
	anim_1gfx BATTLE_ANIM_GFX_STATUS
	anim_sound 0, 1, SFX_KINESIS
	anim_obj BATTLE_ANIM_OBJ_CHICK, 44, 56, $15
	anim_obj BATTLE_ANIM_OBJ_CHICK, 44, 56, $aa
	anim_obj BATTLE_ANIM_OBJ_CHICK, 44, 56, $bf
	anim_wait 96
	anim_ret

BattleAnim_Slp:
	anim_1gfx BATTLE_ANIM_GFX_STATUS
	anim_sound 0, 0, SFX_TAIL_WHIP
.loop
	anim_obj BATTLE_ANIM_OBJ_ASLEEP, 64, 80, $0
	anim_wait 40
	anim_loop 3, .loop
	anim_wait 32
	anim_ret

BattleAnim_Brn:
	anim_1gfx BATTLE_ANIM_GFX_FIRE
.loop
	anim_sound 0, 0, SFX_EMBER ; SFX_BURN in the final game
	anim_obj BATTLE_ANIM_OBJ_BURNED, 56, 88, $10
	anim_wait 4
	anim_loop 3, .loop
	anim_wait 6
	anim_ret

BattleAnim_Psn:
	anim_1gfx BATTLE_ANIM_GFX_POISON
	anim_sound 0, 0, SFX_POISON
	anim_obj BATTLE_ANIM_OBJ_SKULL, 64, 56, $0
	anim_wait 8
	anim_sound 0, 0, SFX_POISON
	anim_obj BATTLE_ANIM_OBJ_SKULL, 48, 56, $0
	anim_wait 8
	anim_ret

BattleAnim_Sap:
	anim_1gfx BATTLE_ANIM_GFX_CHARGE
	anim_sound 6, 3, SFX_WATER_GUN
	anim_obj BATTLE_ANIM_OBJ_ABSORB, 128, 48, $2
	anim_wait 6
	anim_sound 6, 3, SFX_WATER_GUN
	anim_obj BATTLE_ANIM_OBJ_ABSORB, 136, 64, $3
	anim_wait 6
	anim_sound 6, 3, SFX_WATER_GUN
	anim_obj BATTLE_ANIM_OBJ_ABSORB, 136, 32, $4
	anim_wait 16
	anim_ret

BattleAnim_Frz:
	anim_1gfx BATTLE_ANIM_GFX_ICE
	anim_obj BATTLE_ANIM_OBJ_FROZEN, 44, 110, $0
	anim_sound 0, 0, SFX_SHINE
	anim_wait 16
	anim_sound 0, 0, SFX_SHINE
	anim_wait 16
	anim_ret

BattleAnim_Par:
	anim_1gfx BATTLE_ANIM_GFX_STATUS
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS, $0, $2, $0
	anim_sound 0, 0, SFX_THUNDERSHOCK
	anim_obj BATTLE_ANIM_OBJ_PARALYZED, 20, 88, $42
	anim_obj BATTLE_ANIM_OBJ_PARALYZED, 76, 88, $c2
	anim_wait 128
	anim_ret

BattleAnim_InLove:
; BUG: Uses BATTLE_ANIM_GFX_MISC when it was supposed to use BATTLE_ANIM_GFX_OBJECTS.
; This makes it show up as a pair of Kinesis spoons in-game instead of the intended heart.
	anim_1gfx BATTLE_ANIM_GFX_MISC
	anim_sound 0, 1, SFX_LICK
	anim_obj BATTLE_ANIM_OBJ_HEART, 64, 76, $0
	anim_wait 32
	anim_sound 0, 1, SFX_LICK
	anim_obj BATTLE_ANIM_OBJ_HEART, 36, 72, $0
	anim_wait 32
	anim_ret

BattleAnim_InSandstorm:
	anim_1gfx BATTLE_ANIM_GFX_POWDER
.loop1
	anim_sound 6, 3, SFX_MENU
	anim_obj BATTLE_ANIM_OBJ_SANDSTORM, 116, 56, $4
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_SANDSTORM, 116, 48, $3
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_SANDSTORM, 116, 56, $3
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_SANDSTORM, 116, 48, $4
	anim_wait 2
	anim_loop 2, .loop1
.loop2
	anim_sound 0, 1, SFX_MENU
	anim_wait 8
	anim_loop 10, .loop2
	anim_wait 16
	anim_ret

BattleAnim_InNightmare:
	anim_1gfx BATTLE_ANIM_GFX_ANGELS
	anim_sound 0, 0, SFX_BUBBLEBEAM
	anim_obj BATTLE_ANIM_OBJ_IN_NIGHTMARE, 68, 80, $0
	anim_wait 40
	anim_ret

BattleAnim_Miss:
	anim_ret

BattleAnim_PlayerDamage:
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_Y, $20, $2, $20
	anim_wait 40
	anim_ret

; Leftover from Generation 1. In those games, this animation would be used instead of the standard damage animation
; if the move had an additional effect.
BattleAnim_ShakeHorizontalUnused: 
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $20, $2, $20
	anim_wait 40
	anim_ret

BattleAnim_PlayerStatDown:
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $20, $2, $40
	anim_wait 40
	anim_ret

; Unused. Originally used in Generation 1, but not here for some reason.
BattleAnim_BlinkEnemyMon:
.loop
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, BG_EFFECT_USER, $0
	anim_wait 8
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_USER, $0
	anim_wait 8
	anim_loop 6, .loop
	anim_ret

; Another leftover from Generation 1.
BattleAnim_ShakeHorizontalUnused2:
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $20, $1, $20
	anim_wait 40
	anim_ret

BattleAnim_EnemyStatDown:
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $20, $1, $40
	anim_wait 40
	anim_ret

BattleAnim_Pound:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_sound 0, 1, SFX_POUND
	anim_obj BATTLE_ANIM_OBJ_PALM, 136, 56, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 16
	anim_ret

BattleAnim_KarateChop:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_PALM, 136, 40, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 40, $0
	anim_wait 6
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_PALM, 136, 44, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 44, $0
	anim_wait 6
	anim_sound 0, 1, SFX_KARATE_CHOP
	anim_obj BATTLE_ANIM_OBJ_PALM, 136, 48, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 48, $0
	anim_wait 16
	anim_ret

BattleAnim_Doubleslap:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_if_param_equal $1, .alternate
	anim_sound 0, 1, SFX_DOUBLESLAP
	anim_obj BATTLE_ANIM_OBJ_PALM, 144, 48, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 144, 48, $0
	anim_wait 8
	anim_ret

.alternate:
	anim_sound 0, 1, SFX_DOUBLESLAP
	anim_obj BATTLE_ANIM_OBJ_PALM, 120, 48, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 120, 48, $0
	anim_wait 8
	anim_ret

BattleAnim_CometPunch:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_if_param_equal $1, .alternate
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj BATTLE_ANIM_OBJ_PUNCH, 144, 48, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 144, 48, $0
	anim_wait 8
	anim_ret

.alternate:
	anim_sound 0, 1, SFX_COMET_PUNCH
	anim_obj BATTLE_ANIM_OBJ_PUNCH, 120, 64, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 120, 64, $0
	anim_wait 8
	anim_ret

BattleAnim_MegaPunch:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $40, $2, $0
	anim_wait 64
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $7
.loop
	anim_sound 0, 1, SFX_MEGA_PUNCH
	anim_obj BATTLE_ANIM_OBJ_PUNCH, 136, 56, $0
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 56, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_PUNCH, 136, 56, $0
	anim_wait 6
	anim_loop 3, .loop
	anim_ret

BattleAnim_Stomp:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_sound 0, 1, SFX_STOMP
	anim_obj BATTLE_ANIM_OBJ_KICK, 136, 40, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 40, $0
	anim_wait 6
	anim_sound 0, 1, SFX_STOMP
	anim_obj BATTLE_ANIM_OBJ_KICK, 136, 44, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 44, $0
	anim_wait 6
	anim_sound 0, 1, SFX_STOMP
	anim_obj BATTLE_ANIM_OBJ_KICK, 136, 48, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 48, $0
	anim_wait 16
	anim_ret

BattleAnim_DoubleKick:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_if_param_equal $1, .alternate
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj BATTLE_ANIM_OBJ_KICK, 144, 48, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 144, 48, $0
	anim_wait 8
	anim_ret

.alternate:
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj BATTLE_ANIM_OBJ_KICK, 120, 64, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 120, 64, $0
	anim_wait 8
	anim_ret

BattleAnim_JumpKick:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_sound 0, 1, SFX_JUMP_KICK
	anim_obj BATTLE_ANIM_OBJ_KICK, 112, 72, $0
	anim_obj BATTLE_ANIM_OBJ_KICK, 100, 60, $0
	anim_setobj $1, $2
	anim_setobj $2, $2
	anim_wait 24
	anim_if_param_equal $1, .alternate ; Plays out the kick animation before the player hits themselves, unlike final game.
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj BATTLE_ANIM_OBJ_HIT, 136, 48, $0
	anim_wait 16
	anim_ret

.alternate
	anim_wait 40
	anim_sound 0, 0, SFX_DOUBLE_KICK
	anim_obj BATTLE_ANIM_OBJ_HIT, 44, 88, $0
	anim_wait 16
	anim_ret

BattleAnim_HiJumpKick:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $40, $2, $0
	anim_wait 32
	anim_sound 0, 1, SFX_JUMP_KICK
	anim_obj BATTLE_ANIM_OBJ_KICK, 112, 72, $0
	anim_setobj $1, $2
	anim_wait 16
	anim_if_param_equal $1, .alternate ; Plays out the kick animation before the player hits themselves, unlike final game.
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj BATTLE_ANIM_OBJ_HIT, 136, 48, $0
	anim_wait 16
	anim_ret

.alternate:
	anim_wait 48
	anim_sound 0, 0, SFX_DOUBLE_KICK
	anim_obj BATTLE_ANIM_OBJ_HIT, 44, 88, $0
	anim_wait 16
	anim_ret

BattleAnim_RollingKick:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_sound 0, 1, SFX_DOUBLE_KICK
	anim_obj BATTLE_ANIM_OBJ_KICK, 112, 56, $0
	anim_setobj $1, $3
	anim_wait 12
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 48, $0
	anim_wait 16
	anim_ret

BattleAnim_MegaKick:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $40, $2, $0
	anim_wait 64
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $7
.loop
	anim_sound 0, 1, SFX_MEGA_KICK
	anim_obj BATTLE_ANIM_OBJ_KICK, 136, 56, $0
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 56, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_KICK, 136, 56, $0
	anim_wait 6
	anim_loop 3, .loop
	anim_ret

BattleAnim_HyperFang:
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_sound 0, 1, SFX_BITE
	anim_obj BATTLE_ANIM_OBJ_FANG, 136, 56, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 16
	anim_ret

anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $40, $2, $0
	anim_wait 64
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $7
.loop
	anim_sound 0, 1, SFX_BITE
	anim_obj BATTLE_ANIM_OBJ_FANG, 136, 56, $0
	anim_obj BATTLE_ANIM_OBJ_HIT_BIG_YFIX, 136, 56, $0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_FANG, 136, 56, $0
	anim_wait 6
	anim_loop 3, .loop
	anim_ret

BattleAnim_Ember:
	anim_1gfx BATTLE_ANIM_GFX_FIRE
	anim_sound 6, 2, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_EMBER, 64, 96, $12
	anim_wait 4
	anim_sound 6, 2, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_EMBER, 64, 100, $14
	anim_wait 4
	anim_sound 6, 2, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_EMBER, 64, 84, $13
	anim_wait 16
	anim_incobj 1
	anim_incobj 2
	anim_incobj 3
	anim_sound 0, 1, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_EMBER, 120, 68, $30
	anim_obj BATTLE_ANIM_OBJ_EMBER, 132, 68, $30
	anim_obj BATTLE_ANIM_OBJ_EMBER, 144, 68, $30
	anim_wait 32
	anim_ret

BattleAnim_FirePunch:
	anim_2gfx BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_FIRE
	anim_obj BATTLE_ANIM_OBJ_PUNCH_SHAKE, 136, 56, $43
	anim_call BattleAnimSub_Fire
	anim_wait 16
	anim_ret

BattleAnim_FireSpin:
	anim_1gfx BATTLE_ANIM_GFX_FIRE
.loop
	anim_sound 6, 2, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_FIRE_SPIN, 64, 88, $4
	anim_wait 2
	anim_sound 6, 2, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_FIRE_SPIN, 64, 96, $3
	anim_wait 2
	anim_sound 6, 2, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_FIRE_SPIN, 64, 88, $3
	anim_wait 2
	anim_sound 6, 2, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_FIRE_SPIN, 64, 96, $4
	anim_wait 2
	anim_loop 2, .loop
	anim_wait 96
	anim_ret

BattleAnim_DragonRage:
	anim_1gfx BATTLE_ANIM_GFX_FIRE
.loop
	anim_sound 6, 2, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_DRAGON_RAGE, 64, 92, $0
	anim_wait 3
	anim_loop 32, .loop ; Has double the loops it does in the final game.
	anim_wait 64
	anim_ret

BattleAnim_Flamethrower:
	anim_1gfx BATTLE_ANIM_GFX_FIRE
	anim_sound 6, 2, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_FLAMETHROWER, 64, 92, $3
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_FLAMETHROWER, 75, 86, $5
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_FLAMETHROWER, 85, 81, $7
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_FLAMETHROWER, 96, 76, $9
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_FLAMETHROWER, 106, 71, $b
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_FLAMETHROWER, 116, 66, $c
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_FLAMETHROWER, 126, 61, $a
	anim_wait 2
	anim_obj BATTLE_ANIM_OBJ_FLAMETHROWER, 136, 56, $8
	anim_wait 16
.loop
	anim_sound 0, 1, SFX_EMBER
	anim_wait 16
	anim_loop 8, .loop ; 6 loops in final game
	anim_wait 16
	anim_ret

BattleAnim_FireBlast:
	anim_1gfx BATTLE_ANIM_GFX_FIRE
.loop1
	anim_sound 6, 2, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_FIRE_BLAST, 64, 92, $7
	anim_wait 6
	anim_loop 10, .loop1
.loop2
	anim_sound 0, 1, SFX_EMBER
	anim_wait 8
	anim_loop 16, .loop2 ; Final game: 10 loops
	anim_incobj 1
	anim_incobj 2
	anim_incobj 3
	anim_incobj 4
	anim_incobj 5
	anim_incobj 6
	anim_incobj 7
	anim_incobj 8
	anim_incobj 9
	anim_incobj 10
	anim_wait 2
.loop3
	anim_sound 0, 1, SFX_EMBER
	anim_obj BATTLE_ANIM_OBJ_FIRE_BLAST, 136, 56, $1
	anim_obj BATTLE_ANIM_OBJ_FIRE_BLAST, 136, 56, $2
	anim_obj BATTLE_ANIM_OBJ_FIRE_BLAST, 136, 56, $3
	anim_obj BATTLE_ANIM_OBJ_FIRE_BLAST, 136, 56, $4
	anim_obj BATTLE_ANIM_OBJ_FIRE_BLAST, 136, 56, $5
	anim_wait 16
	anim_loop 2, .loop3
	anim_wait 64 ; double the dead space at the end compared to final
	anim_ret

BattleAnim_IcePunch:
	anim_2gfx BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_ICE
	anim_obj BATTLE_ANIM_OBJ_PUNCH_SHAKE, 136, 56, $43
	anim_call BattleAnimSub_Ice
	anim_wait 32
	anim_ret

BattleAnim_IceBeam:
	anim_1gfx BATTLE_ANIM_GFX_ICE
.loop
	anim_sound 6, 2, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_ICE_BEAM, 64, 92, $4
	anim_wait 4
	anim_loop 5, .loop
	anim_obj BATTLE_ANIM_OBJ_ICE_BUILDUP, 136, 74, $10
.loop2
	anim_sound 6, 2, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_ICE_BEAM, 64, 92, $4
	anim_wait 4
	anim_loop 15, .loop2
	anim_wait 48
	anim_sound 0, 1, SFX_SHINE
	anim_wait 8
	anim_sound 0, 1, SFX_SHINE
	anim_wait 8
	anim_ret

BattleAnim_Blizzard:
	anim_1gfx BATTLE_ANIM_GFX_ICE
.loop
	anim_sound 6, 2, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_BLIZZARD, 64, 88, $63
	anim_wait 2
	anim_sound 6, 2, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_BLIZZARD, 64, 80, $64
	anim_wait 2
	anim_sound 6, 2, SFX_SHINE
	anim_obj BATTLE_ANIM_OBJ_BLIZZARD, 64, 96, $63
	anim_wait 2
	anim_loop 3, .loop
	anim_bgeffect BATTLE_BG_EFFECT_WHITE_HUES, $0, $8, $0
	anim_wait 32
	anim_obj BATTLE_ANIM_OBJ_ICE_BUILDUP, 136, 74, $10
	anim_wait 128
	anim_sound 0, 1, SFX_SHINE
	anim_wait 8
	anim_sound 0, 1, SFX_SHINE
	anim_wait 24
	anim_ret

BattleAnim_Bubble:
	anim_1gfx BATTLE_ANIM_GFX_BUBBLE
	anim_sound 32, 2, SFX_WATER_GUN
	anim_obj BATTLE_ANIM_OBJ_BUBBLE, 64, 92, $c1
	anim_wait 6
	anim_sound 32, 2, SFX_WATER_GUN
	anim_obj BATTLE_ANIM_OBJ_BUBBLE, 64, 92, $e1
	anim_wait 6
	anim_sound 32, 2, SFX_WATER_GUN
	anim_obj BATTLE_ANIM_OBJ_BUBBLE, 64, 92, $d1
	anim_wait 128
	anim_wait 32
	anim_ret

BattleAnim_Bubblebeam:
	anim_1gfx BATTLE_ANIM_GFX_BUBBLE
.loop
	anim_sound 16, 2, SFX_BUBBLEBEAM
	anim_obj BATTLE_ANIM_OBJ_BUBBLE, 64, 92, $92
	anim_wait 6
	anim_sound 16, 2, SFX_BUBBLEBEAM
	anim_obj BATTLE_ANIM_OBJ_BUBBLE, 64, 92, $b3
	anim_wait 6
	anim_sound 16, 2, SFX_BUBBLEBEAM
	anim_obj BATTLE_ANIM_OBJ_BUBBLE, 64, 92, $f4
	anim_wait 8
	anim_loop 3, .loop
	anim_wait 64
; No rippling effect added yet.
	anim_ret

BattleAnim_WaterGun:
	anim_1gfx BATTLE_ANIM_GFX_WATER
	anim_sound 16, 2, SFX_WATER_GUN
	anim_obj BATTLE_ANIM_OBJ_WATER_GUN, 64, 88, $0
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_WATER_GUN, 64, 76, $0
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_WATER_GUN, 64, 82, $0
	anim_wait 128
; No ripple effect here either.
	anim_ret

BattleAnim_HydroPump:
	anim_1gfx BATTLE_ANIM_GFX_WATER
	anim_sound 0, 1, SFX_HYDRO_PUMP
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 108, 72, $0
	anim_wait 16
	anim_sound 0, 1, SFX_HYDRO_PUMP
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 116, 72, $0
	anim_wait 16
	anim_sound 0, 1, SFX_HYDRO_PUMP
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 124, 72, $0
	anim_wait 16
	anim_sound 0, 1, SFX_HYDRO_PUMP
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 132, 72, $0
	anim_wait 16
	anim_sound 0, 1, SFX_HYDRO_PUMP
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 140, 72, $0
	anim_wait 16
	anim_sound 0, 1, SFX_HYDRO_PUMP
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 148, 72, $0
	anim_wait 16
	anim_sound 0, 1, SFX_HYDRO_PUMP
	anim_obj BATTLE_ANIM_OBJ_HYDRO_PUMP, 156, 72, $0
	anim_wait 96
	anim_ret

BattleAnim_Surf:
	anim_1gfx BATTLE_ANIM_GFX_BUBBLE
	anim_bgeffect BATTLE_BG_EFFECT_SURF, $0, $0, $0
	anim_obj BATTLE_ANIM_OBJ_SURF, 88, 104, $8
.loop
	anim_sound 0, 1, SFX_SURF
	anim_wait 32
	anim_loop 4, .loop
	anim_incobj 1
	anim_wait 56
	anim_ret

BattleAnim_VineWhip:
	anim_1gfx BATTLE_ANIM_GFX_WHIP
	anim_sound 0, 1, SFX_VINE_WHIP
	anim_obj BATTLE_ANIM_OBJ_VINE_WHIP2, 116, 52, $80
	anim_wait 4
	anim_sound 0, 1, SFX_VINE_WHIP
	anim_obj BATTLE_ANIM_OBJ_VINE_WHIP1, 128, 60, $0
	anim_wait 4
	anim_incobj 1
	anim_wait 4
	anim_ret

BattleAnim_LeechSeed:
	anim_1gfx BATTLE_ANIM_GFX_PLANT
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_obj BATTLE_ANIM_OBJ_LEECH_SEED, 48, 80, $20
	anim_wait 8
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_obj BATTLE_ANIM_OBJ_LEECH_SEED, 48, 80, $30
	anim_wait 8
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_obj BATTLE_ANIM_OBJ_LEECH_SEED, 48, 80, $28
	anim_wait 32
	anim_sound 0, 1, SFX_CHARGE
	anim_wait 128
	anim_ret

BattleAnim_RazorLeaf:
	anim_1gfx BATTLE_ANIM_GFX_PLANT
	anim_sound 0, 0, SFX_VINE_WHIP
	anim_obj BATTLE_ANIM_OBJ_RAZOR_LEAF, 48, 80, $28
	anim_obj BATTLE_ANIM_OBJ_RAZOR_LEAF, 48, 80, $5c
	anim_obj BATTLE_ANIM_OBJ_RAZOR_LEAF, 48, 80, $10
	anim_obj BATTLE_ANIM_OBJ_RAZOR_LEAF, 48, 80, $e8
	anim_obj BATTLE_ANIM_OBJ_RAZOR_LEAF, 48, 80, $9c
	anim_obj BATTLE_ANIM_OBJ_RAZOR_LEAF, 48, 80, $d0
	anim_wait 6
	anim_obj BATTLE_ANIM_OBJ_RAZOR_LEAF, 48, 80, $1c
	anim_obj BATTLE_ANIM_OBJ_RAZOR_LEAF, 48, 80, $50
	anim_obj BATTLE_ANIM_OBJ_RAZOR_LEAF, 48, 80, $dc
	anim_obj BATTLE_ANIM_OBJ_RAZOR_LEAF, 48, 80, $90
	anim_wait 80
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_incobj 3
	anim_wait 2
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_incobj 5
	anim_wait 2
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_incobj 7
	anim_wait 2
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_incobj 9
	anim_wait 2
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_incobj 1
	anim_wait 2
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_incobj 2
	anim_wait 2
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_incobj 4
	anim_wait 2
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_incobj 6
	anim_wait 2
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_incobj 8
	anim_wait 2
	anim_sound 16, 2, SFX_VINE_WHIP
	anim_incobj 10
	anim_wait 64
	anim_ret

BattleAnim_Solarbeam:
	anim_if_param_equal $0, .FireSolarBeam
	; charge turn
	anim_1gfx BATTLE_ANIM_GFX_CHARGE
	anim_sound 0, 0, SFX_CHARGE
	anim_obj BATTLE_ANIM_OBJ_ABSORB_CENTER, 48, 84, $0
	anim_obj BATTLE_ANIM_OBJ_SOLAR_BEAM_CHARGE, 48, 84, $0
	anim_obj BATTLE_ANIM_OBJ_SOLAR_BEAM_CHARGE, 48, 84, $8
	anim_obj BATTLE_ANIM_OBJ_SOLAR_BEAM_CHARGE, 48, 84, $10
	anim_obj BATTLE_ANIM_OBJ_SOLAR_BEAM_CHARGE, 48, 84, $18
	anim_obj BATTLE_ANIM_OBJ_SOLAR_BEAM_CHARGE, 48, 84, $20
	anim_obj BATTLE_ANIM_OBJ_SOLAR_BEAM_CHARGE, 48, 84, $28
	anim_obj BATTLE_ANIM_OBJ_SOLAR_BEAM_CHARGE, 48, 84, $30
	anim_obj BATTLE_ANIM_OBJ_SOLAR_BEAM_CHARGE, 48, 84, $38
	anim_wait 104
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_WHITE, $0, $2, $4
	anim_wait 64
	anim_ret

.FireSolarBeam
	anim_1gfx BATTLE_ANIM_GFX_BEAM
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS, $0, $2, $0
	anim_call BattleAnimSub_Beam
	anim_wait 48
	anim_ret

BattleAnim_Thunderpunch:
	anim_2gfx BATTLE_ANIM_GFX_HIT, BATTLE_ANIM_GFX_LIGHTNING
	anim_obj BATTLE_ANIM_OBJ_PUNCH_SHAKE, 136, 56, $43
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $4
	anim_sound 0, 1, SFX_THUNDER
	anim_obj BATTLE_ANIM_OBJ_THUNDER_RIGHT, 152, 68, $0
	anim_wait 64
	anim_ret

BattleAnim_Thundershock:
	anim_2gfx BATTLE_ANIM_GFX_LIGHTNING, BATTLE_ANIM_GFX_EXPLOSION
	anim_obj BATTLE_ANIM_OBJ_THUNDERSHOCK_BALL, 136, 56, $2
	anim_wait 16
	anim_sound 0, 1, SFX_THUNDERSHOCK
	anim_obj BATTLE_ANIM_OBJ_SPARKS_CIRCLE, 136, 56, $0
	anim_wait 128 ; 96 in final game
	anim_ret

BattleAnim_Thunderbolt:
	anim_2gfx BATTLE_ANIM_GFX_LIGHTNING, BATTLE_ANIM_GFX_EXPLOSION
	anim_obj BATTLE_ANIM_OBJ_THUNDERBOLT_BALL, 136, 56, $2
	anim_wait 16
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $2, $2
	anim_sound 0, 1, SFX_THUNDERSHOCK
	anim_obj BATTLE_ANIM_OBJ_SPARKS_CIRCLE_BIG, 136, 56, $0
	anim_wait 64
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $2, $2
	anim_wait 64
	anim_ret

BattleAnim_ThunderWave:
	anim_1gfx BATTLE_ANIM_GFX_LIGHTNING
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $2, $7
	anim_sound 0, 1, SFX_THUNDERSHOCK
	anim_obj BATTLE_ANIM_OBJ_THUNDER_WAVE, 136, 56, $0
	anim_wait 20
	anim_bgp $1b
	anim_incobj 1
	anim_wait 128 ; 96 in final game
	anim_ret

BattleAnim_Thunder:
	anim_1gfx BATTLE_ANIM_GFX_LIGHTNING
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $2, $40
	anim_sound 0, 1, SFX_THUNDER
	anim_obj BATTLE_ANIM_OBJ_THUNDER_LEFT, 120, 68, $0
	anim_wait 16
	anim_sound 0, 1, SFX_THUNDER
	anim_obj BATTLE_ANIM_OBJ_THUNDER_RIGHT, 152, 68, $0
	anim_wait 16
	anim_sound 0, 1, SFX_THUNDER
	anim_obj BATTLE_ANIM_OBJ_THUNDER_CENTER, 136, 68, $0
	anim_wait 48
	anim_ret

BattleAnim_RazorWind:
	anim_if_param_equal $1, BattleAnim_FocusEnergy
	anim_1gfx BATTLE_ANIM_GFX_WHIP
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS, $0, $1, $0
.loop
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $2, $2
	anim_sound 0, 1, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_RAZOR_WIND2, 152, 40, $3
	anim_wait 4
	anim_sound 0, 1, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_RAZOR_WIND2, 136, 56, $3
	anim_wait 4
	anim_sound 0, 1, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_RAZOR_WIND2, 152, 64, $3
	anim_wait 4
	anim_sound 0, 1, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_RAZOR_WIND1, 120, 40, $83
	anim_wait 4
	anim_sound 0, 1, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_RAZOR_WIND1, 120, 64, $83
	anim_wait 4
	anim_loop 3, .loop
	anim_wait 32
	anim_ret

BattleAnim_Sonicboom:
	anim_2gfx BATTLE_ANIM_GFX_WHIP, BATTLE_ANIM_GFX_HIT
.loop
	anim_sound 3, 0, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_SONICBOOM, 64, 80, $3
	anim_wait 8
	anim_sound 3, 0, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_SONICBOOM, 64, 88, $2
	anim_wait 8
	anim_sound 3, 0, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_SONICBOOM, 64, 96, $4
	anim_wait 8
	anim_loop 2, .loop
	anim_wait 32
	anim_incobj 1
	anim_incobj 2
	anim_incobj 3
	anim_incobj 4
	anim_incobj 5
	anim_incobj 6
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 16
	anim_ret

BattleAnim_Gust:
	anim_2gfx BATTLE_ANIM_GFX_WIND, BATTLE_ANIM_GFX_HIT
.loop
	anim_sound 0, 1, SFX_RAZOR_WIND
	anim_obj BATTLE_ANIM_OBJ_GUST, 136, 72, $0
	anim_wait 6
	anim_loop 9, .loop
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 144, 64, $18
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 128, 32, $18
	anim_wait 16
	anim_ret

BattleAnim_Selfdestruct:
	anim_1gfx BATTLE_ANIM_GFX_EXPLOSION
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $48
	anim_if_param_equal $1, .loop
	anim_call BattleAnimSub_Explosion2
	anim_wait 16
	anim_ret

.loop
	anim_call BattleAnimSub_Explosion1
	anim_wait 5
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, BG_EFFECT_USER, $0
	anim_loop 2, .loop
	anim_wait 16
	anim_ret

BattleAnim_Explosion:
	anim_1gfx BATTLE_ANIM_GFX_EXPLOSION
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $60, $4, $10
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $48
	anim_if_param_equal $1, .loop
	anim_call BattleAnimSub_Explosion2
	anim_wait 16
	anim_ret

.loop
	anim_call BattleAnimSub_Explosion1
	anim_wait 5
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, BG_EFFECT_USER, $0
	anim_loop 2, .loop
	anim_wait 16
	anim_ret

BattleAnim_Acid:
	anim_1gfx BATTLE_ANIM_GFX_POISON
	anim_call BattleAnimSub_Acid
	anim_wait 64
	anim_ret

BattleAnim_RockThrow:
	anim_1gfx BATTLE_ANIM_GFX_ROCKS
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_SMALL_ROCK, 128, 68, $30
	anim_wait 2
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_BIG_ROCK, 136, 64, $40
	anim_wait 2
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_SMALL_ROCK, 144, 68, $30
	anim_wait 96
	anim_ret

BattleAnim_RockSlide:
	anim_1gfx BATTLE_ANIM_GFX_ROCKS
.loop
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_SMALL_ROCK, 128, 64, $40
	anim_wait 2
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_BIG_ROCK, 120, 68, $30
	anim_wait 2
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_SMALL_ROCK, 152, 68, $30
	anim_wait 2
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_BIG_ROCK, 144, 64, $40
	anim_wait 2
	anim_sound 0, 1, SFX_STRENGTH
	anim_obj BATTLE_ANIM_OBJ_SMALL_ROCK, 136, 68, $30
	anim_wait 16
	anim_loop 2, .loop
	anim_wait 96
	anim_ret

BattleAnim_Sing:
	anim_1gfx BATTLE_ANIM_GFX_NOISE
	anim_sound 16, 2, SFX_SING
.loop
	anim_obj BATTLE_ANIM_OBJ_SING, 64, 92, $0
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_SING, 64, 92, $1
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_SING, 64, 92, $2
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_SING, 64, 92, $0
	anim_wait 8
	anim_obj BATTLE_ANIM_OBJ_SING, 64, 92, $2
	anim_wait 8
	anim_loop 4, .loop
	anim_wait 64
	anim_ret

BattleAnim_Poisonpowder:
BattleAnim_SleepPowder:
BattleAnim_Spore:
BattleAnim_StunSpore:
	anim_1gfx BATTLE_ANIM_GFX_POWDER
.loop
	anim_sound 0, 1, SFX_POWDER
	anim_obj BATTLE_ANIM_OBJ_POWDER, 104, 16, $0
	anim_wait 4
	anim_sound 0, 1, SFX_POWDER
	anim_obj BATTLE_ANIM_OBJ_POWDER, 136, 16, $0
	anim_wait 4
	anim_sound 0, 1, SFX_POWDER
	anim_obj BATTLE_ANIM_OBJ_POWDER, 112, 16, $0
	anim_wait 4
	anim_sound 0, 1, SFX_POWDER
	anim_obj BATTLE_ANIM_OBJ_POWDER, 128, 16, $0
	anim_wait 4
	anim_sound 0, 1, SFX_POWDER
	anim_obj BATTLE_ANIM_OBJ_POWDER, 120, 16, $0
	anim_wait 4
	anim_loop 2, .loop
	anim_wait 128
	anim_ret

BattleAnim_HyperBeam:
	anim_1gfx BATTLE_ANIM_GFX_BEAM
	anim_bgeffect BATTLE_BG_EFFECT_SHAKE_SCREEN_X, $30, $4, $10
	anim_bgeffect BATTLE_BG_EFFECT_FLASH_INVERTED, $0, $4, $80
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS, $0, $2, $0
	anim_call BattleAnimSub_Beam
	anim_wait 48
	anim_ret

BattleAnim_AuroraBeam:
	anim_1gfx BATTLE_ANIM_GFX_BEAM
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS, $0, $2, $0
	anim_bgeffect BATTLE_BG_EFFECT_ALTERNATE_HUES, $0, $2, $0
	anim_wait 64
	anim_call BattleAnimSub_Beam
	anim_wait 48
	anim_incobj 5
	anim_wait 64
	anim_ret

BattleAnim_Vicegrip:
	anim_1gfx BATTLE_ANIM_GFX_CUT
	anim_sound 0, 1, SFX_VICEGRIP
	anim_obj BATTLE_ANIM_OBJ_CUT_DOWN_LEFT, 152, 40, $0
	anim_obj BATTLE_ANIM_OBJ_CUT_UP_RIGHT, 120, 72, $0
	anim_wait 32
	anim_ret

BattleAnim_Scratch:
	anim_1gfx BATTLE_ANIM_GFX_CUT
	anim_sound 0, 1, SFX_SCRATCH
	anim_obj BATTLE_ANIM_OBJ_CUT_DOWN_LEFT, 144, 48, $0
	anim_obj BATTLE_ANIM_OBJ_CUT_DOWN_LEFT, 140, 44, $0
	anim_obj BATTLE_ANIM_OBJ_CUT_DOWN_LEFT, 136, 40, $0
	anim_wait 32
	anim_ret

BattleAnim_FurySwipes:
	anim_1gfx BATTLE_ANIM_GFX_CUT
	anim_if_param_equal $1, .alternate
	anim_sound 0, 1, SFX_SCRATCH
	anim_obj BATTLE_ANIM_OBJ_CUT_DOWN_LEFT, 144, 48, $0
	anim_obj BATTLE_ANIM_OBJ_CUT_DOWN_LEFT, 140, 44, $0
	anim_obj BATTLE_ANIM_OBJ_CUT_DOWN_LEFT, 136, 40, $0
	anim_sound 0, 1, SFX_SCRATCH
	anim_wait 32
	anim_ret

.alternate:
	anim_sound 0, 1, SFX_SCRATCH
	anim_obj BATTLE_ANIM_OBJ_CUT_DOWN_RIGHT, 120, 48, $0
	anim_obj BATTLE_ANIM_OBJ_CUT_DOWN_RIGHT, 124, 44, $0
	anim_obj BATTLE_ANIM_OBJ_CUT_DOWN_RIGHT, 128, 40, $0
	anim_sound 0, 1, SFX_SCRATCH
	anim_wait 32
	anim_ret

BattleAnim_Cut:
	anim_1gfx BATTLE_ANIM_GFX_CUT
	anim_sound 0, 1, SFX_CUT
	anim_obj BATTLE_ANIM_OBJ_CUT_LONG_DOWN_LEFT, 152, 40, $0
	anim_wait 32
	anim_ret

BattleAnim_Slash:
	anim_1gfx BATTLE_ANIM_GFX_CUT
	anim_sound 0, 1, SFX_CUT
	anim_obj BATTLE_ANIM_OBJ_CUT_LONG_DOWN_LEFT, 152, 40, $0
	anim_obj BATTLE_ANIM_OBJ_CUT_LONG_DOWN_LEFT, 148, 36, $0
	anim_wait 32
	anim_ret

BattleAnim_Clamp:
	anim_2gfx BATTLE_ANIM_GFX_CUT, BATTLE_ANIM_GFX_HIT
	anim_obj BATTLE_ANIM_OBJ_CLAMP, 136, 56, $a0
	anim_obj BATTLE_ANIM_OBJ_CLAMP, 136, 56, $20
	anim_wait 16
	anim_sound 0, 1, SFX_BITE
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 144, 48, $18
	anim_wait 32
	anim_sound 0, 1, SFX_BITE
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 128, 64, $18
	anim_wait 16
	anim_ret

BattleAnim_Bite:
	anim_2gfx BATTLE_ANIM_GFX_CUT, BATTLE_ANIM_GFX_HIT
	anim_obj BATTLE_ANIM_OBJ_BITE, 136, 56, $98
	anim_obj BATTLE_ANIM_OBJ_BITE, 136, 56, $18
	anim_wait 8
	anim_sound 0, 1, SFX_BITE
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 144, 48, $18
	anim_wait 16
	anim_sound 0, 1, SFX_BITE
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 128, 64, $18
	anim_wait 8
	anim_ret

BattleAnim_Teleport:
	anim_1gfx BATTLE_ANIM_GFX_SPEED
	anim_call BattleAnim_TargetObj_1Row
	anim_bgeffect BATTLE_BG_EFFECT_TELEPORT, $0, BG_EFFECT_USER, $0
	anim_wait 32
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, BG_EFFECT_USER, $0
	anim_wait 3
	anim_incbgeffect BATTLE_BG_EFFECT_TELEPORT
	anim_call BattleAnim_ShowMon_0
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS, $0, $1, $0
	anim_call BattleAnimSub_WarpAway
	anim_wait 64
	anim_ret

BattleAnim_Fly:
	anim_if_param_equal $1, .turn1
	anim_if_param_equal $2, .miss
	anim_1gfx BATTLE_ANIM_GFX_HIT
	anim_sound 0, 1, SFX_WING_ATTACK
	anim_obj BATTLE_ANIM_OBJ_HIT_YFIX, 136, 56, $0
	anim_wait 32
.miss:
	anim_bgeffect BATTLE_BG_EFFECT_SHOW_MON, $0, BG_EFFECT_USER, $0
	anim_wait 32
	anim_ret

.turn1:
	anim_1gfx BATTLE_ANIM_GFX_SPEED
	anim_bgeffect BATTLE_BG_EFFECT_CYCLE_OBPALS, $0, $1, $0
	anim_bgeffect BATTLE_BG_EFFECT_HIDE_MON, $0, BG_EFFECT_USER, $0
	anim_call BattleAnimSub_WarpAway
	anim_wait 64
	anim_ret

BattleAnim_DoubleTeam:
	anim_call BattleAnim_TargetObj_1Row
	anim_sound 0, 0, SFX_PSYBEAM
	anim_bgeffect BATTLE_BG_EFFECT_DOUBLE_TEAM, $0, BG_EFFECT_USER, $0
	anim_wait 128
	anim_incbgeffect BATTLE_BG_EFFECT_DOUBLE_TEAM
	anim_wait 24
	anim_incbgeffect BATTLE_BG_EFFECT_DOUBLE_TEAM
	anim_call BattleAnim_ShowMon_0
	anim_ret

BattleAnim_Recover:
	anim_1gfx BATTLE_ANIM_GFX_BUBBLE
	anim_call BattleAnim_TargetObj_1Row
	anim_sound 0, 0, SFX_FULL_HEAL
	anim_bgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT_REPEATING, $0, BG_EFFECT_USER, $40
	anim_obj BATTLE_ANIM_OBJ_RECOVER, 44, 88, $30
	anim_obj BATTLE_ANIM_OBJ_RECOVER, 44, 88, $31
	anim_obj BATTLE_ANIM_OBJ_RECOVER, 44, 88, $32
	anim_obj BATTLE_ANIM_OBJ_RECOVER, 44, 88, $33
	anim_obj BATTLE_ANIM_OBJ_RECOVER, 44, 88, $34
	anim_obj BATTLE_ANIM_OBJ_RECOVER, 44, 88, $35
	anim_obj BATTLE_ANIM_OBJ_RECOVER, 44, 88, $36
	anim_obj BATTLE_ANIM_OBJ_RECOVER, 44, 88, $37
	anim_wait 64
	anim_incbgeffect BATTLE_BG_EFFECT_FADE_MON_TO_LIGHT_REPEATING
	anim_call BattleAnim_ShowMon_0
	anim_ret
