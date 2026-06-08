INCLUDE "constants.asm"

SECTION "audio/move_sfx_old.asm", ROMX

; An unreferenced updated version of GetMoveSound from pokered
; goes unreferenced as sounds are now played in a move's animation.
Unreferenced_GetMoveSound:
	push de
	ld a, [wFXAnimID]
	ld e, a
	ld a, [wFXAnimID + 1]
	ld d, a

	dec de
	ld hl, .MoveSoundTable

	add hl, de
	add hl, de
	add hl, de

	ld a, [hli]
	ld e, a 
	ld d, 0
	
	call .IsCryMove
	jr nc, .NotCryMove
	
	ldh a, [hBattleTurn]
	and a
	jr nz, .next
	ld a, [wTempBattleMonSpecies]
	jr .Continue
.next:
	ld a, [wTempEnemyMonSpecies]
.Continue:
	push hl
	call LoadCryHeader
	pop hl
	
	push de
	ld e, [hl]
	ld d, 0
	push hl
	ld hl, wCryPitch
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld a, l
	ld [wCryPitch], a
	ld a, h
	ld [wCryPitch + 1], a
	pop hl
	inc hl
	
	ld e, [hl]
	ld d, 0
	ld hl, wCryLength
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld a, l
	ld [wCryLength], a
	ld a, h
	ld [wCryLength + 1], a
	pop de
	
	callfar _PlayCryHeader
	pop de
	ret
.NotCryMove:
	ld a, [hli]
	ld [wCryPitch], a
	xor a
	ld [wCryPitch + 1], a
	ld c, [hl]
	ld b, 0
	ld hl, $80
	add hl, bc
	ld a, l
	ld [wCryLength], a
	ld a, h
	ld [wCryLength + 1], a

	callfar PlayCrySFX
	pop de
	ret

.IsCryMove:
; set carry if the move animation involves playing a monster cry
	ld a, [wFXAnimID]
	cp MOVE_GROWL
	jr z, .CryMove
	cp MOVE_ROAR
	jr z, .CryMove
	and a ; clear carry
	ret
.CryMove:
	scf
	ret

.MoveSoundTable:
; Table correlates to data/moves/sfx.asm in pokered
	table_width 3
	; ID, pitch mod, tempo mod
	db SFX_POUND,			$00, $80
	db SFX_COMET_PUNCH,		$10, $80
	db SFX_DOUBLESLAP, 		$00, $80
	db SFX_THRASH,			$01, $80
	db SFX_MEGA_PUNCH,		$00, $40
	db SFX_SHINE,			$00, $FF
	db SFX_MEGA_PUNCH,		$10, $60
	db SFX_MEGA_PUNCH,		$20, $80
	db SFX_MEGA_PUNCH,		$00, $A0
	db SFX_RAZOR_WIND,		$00, $80
	db SFX_VICEGRIP,		$20, $40
	db SFX_VICEGRIP,		$00, $80
	db SFX_SCRATCH,			$00, $A0
	db SFX_CUT,				$10, $C0
	db SFX_CUT,				$00, $A0
	db SFX_WING_ATTACK,		$00, $C0
	db SFX_WING_ATTACK,		$10, $A0
	db SFX_WHIRLWIND,		$00, $E0
	db SFX_CUT,				$20, $C0
	db SFX_BIND,			$00, $80
	db SFX_KARATE_CHOP,		$00, $80
	db SFX_VINE_WHIP,		$01, $80
	db SFX_STOMP,			$00, $80
	db SFX_MEGA_KICK,		$F0, $40
	db SFX_TACKLE,			$00, $80
	db SFX_MEGA_KICK,		$00, $80
	db SFX_TAIL_WHIP,		$10, $80
	db SFX_POISON_STING,	$01, $A0
	db SFX_HEADBUTT,		$00, $80
	db SFX_BITE,			$00, $60
	db SFX_BITE,			$01, $40
	db SFX_JUMP_KICK,		$00, $A0
	db SFX_TACKLE,			$10, $A0
	db SFX_STOMP,			$00, $C0
	db SFX_BIND,			$10, $60
	db SFX_TACKLE,			$00, $A0
	db SFX_KARATE_CHOP,		$11, $C0
	db SFX_TACKLE,			$20, $C0
	db SFX_TAIL_WHIP,		$00, $80
	db SFX_POISON_STING,	$00, $80
	db SFX_POISON_STING,	$20, $C0
	db SFX_HORN_ATTACK,		$00, $80
	db SFX_SCREECH,			$FF, $40
	db SFX_BITE,			$00, $80
	db SFX_THRASH,			$00, $C0
	db SFX_THRASH,			$00, $40
	db SFX_SING,			$00, $80
	db SFX_SUPERSONIC,		$40, $60
	db SFX_SUPERSONIC,		$00, $80
	db SFX_SUPERSONIC,		$FF, $40
	db SFX_BUBBLEBEAM,		$80, $C0
	db SFX_HORN_ATTACK,		$10, $A0
	db SFX_HORN_ATTACK,		$21, $E0
	db SFX_EMBER,			$00, $80
	db SFX_WATER_GUN,		$20, $60
	db SFX_BUBBLEBEAM,		$00, $80
	db SFX_SURF,			$00, $80
	db SFX_LEER,			$40, $80
	db SFX_EMBER,			$F0, $E0
	db SFX_PSYBEAM,			$00, $80
	db SFX_BUBBLEBEAM,		$F0, $60
	db SFX_LEER,			$00, $80
	db SFX_HYPER_BEAM,		$00, $80
	db SFX_PECK,			$01, $A0
	db SFX_WHIRLWIND,		$F0, $20
	db SFX_SUBMISSION,		$01, $C0
	db SFX_SUBMISSION,		$00, $80
	db SFX_TACKLE,			$00, $E0
	db SFX_THUNDER,			$01, $60
	db SFX_THUNDER,			$20, $40
	db SFX_WATER_GUN,		$00, $80
	db SFX_WATER_GUN,		$40, $C0
	db SFX_POISON_STING,	$03, $60
	db SFX_SWORDS_DANCE,	$11, $E0
	db SFX_WING_ATTACK,		$20, $E0
	db SFX_CHARGE,			$00, $80
	db SFX_POWDER,			$00, $80
	db SFX_POWDER,			$11, $A0
	db SFX_POWDER,			$01, $C0
	db SFX_WHIRLWIND,		$14, $C0
	db SFX_POISON_STING,	$02, $A0
	db SFX_EMBER,			$F0, $80
	db SFX_EMBER,			$20, $C0
	db SFX_THUNDERSHOCK,	$00, $20
	db SFX_THUNDERSHOCK,	$20, $80
	db SFX_CHARGE,			$12, $60
	db SFX_THUNDER,			$00, $80
	db SFX_BIND,			$01, $E0
	db SFX_EMBER,			$0F, $E0
	db SFX_EMBER,			$11, $20
	db SFX_RAZOR_WIND,		$10, $40
	db SFX_VICEGRIP,		$10, $C0
	db SFX_BIND,			$00, $20
	db SFX_PSYCHIC,			$00, $80
	db SFX_SING,			$11, $18
	db SFX_LICK,			$20, $C0
	db SFX_KINESIS,			$20, $C0
	db SFX_SWORDS_DANCE,	$00, $10
	db SFX_THUNDER,			$F0, $20
	db SFX_SHARPEN,			$F0, $C0
	db SFX_CUT,				$F0, $E0
	db SFX_LICK,			$F0, $40
	db SFX_SCREECH,			$00, $80
	db SFX_SHARPEN,			$80, $40
	db SFX_SHARPEN,			$00, $80
	db SFX_BIND,			$11, $20
	db SFX_BIND,			$22, $10
	db SFX_POISON_STING,	$F1, $FF
	db SFX_WHIRLWIND,		$F1, $FF
	db SFX_BIND,			$33, $30
	db SFX_BONE_CLUB,		$40, $C0
	db SFX_SCRATCH,			$20, $20
	db SFX_SCRATCH,			$F0, $10
	db SFX_VICEGRIP,		$F8, $10
	db SFX_CUT,				$F0, $10
	db SFX_SWORDS_DANCE,	$00, $80
	db SFX_HEADBUTT,		$00, $C0
	db SFX_BONE_CLUB,		$C0, $FF
	db SFX_LICK,			$F2, $20
	db SFX_EGG_BOMB,		$00, $80
	db SFX_EGG_BOMB,		$00, $40
	db SFX_LICK,			$00, $40
	db SFX_CUT,				$10, $FF
	db SFX_BUBBLEBEAM,		$20, $20
	db SFX_BONE_CLUB,		$00, $80
	db SFX_EMBER,			$1F, $20
	db SFX_SWORDS_DANCE,	$2F, $80
	db SFX_VICEGRIP,		$1F, $FF
	db SFX_HYDRO_PUMP,		$1F, $60
	db SFX_THUNDER,			$1E, $20
	db SFX_THUNDER,			$1F, $18
	db SFX_BIND,			$0F, $80
	db SFX_LICK,			$F8, $10
	db SFX_KINESIS,			$18, $20
	db SFX_BONE_CLUB,		$08, $40
	db SFX_MEGA_KICK,		$01, $E0
	db SFX_CUT,				$09, $FF
	db SFX_SING,			$42, $01
	db SFX_POWDER,			$00, $FF
	db SFX_BONE_CLUB,		$08, $E0
	db SFX_WATER_GUN,		$00, $80
	db SFX_LICK,			$88, $10
	db SFX_SWORDS_DANCE,	$48, $FF
	db SFX_KINESIS,			$FF, $FF
	db SFX_WATER_GUN,		$FF, $10
	db SFX_KINESIS,			$FF, $04
	db SFX_POWDER,			$01, $FF
	db SFX_WHIRLWIND,		$F8, $FF
	db SFX_COMET_PUNCH,		$F0, $F0
	db SFX_VICEGRIP,		$08, $10
	db SFX_MEGA_PUNCH,		$F0, $FF
	db SFX_TACKLE,			$F0, $FF
	db SFX_EGG_BOMB,		$10, $FF
	db SFX_SCRATCH,			$F0, $20
	db SFX_HYDRO_PUMP,		$F0, $60
	db SFX_TAIL_WHIP,		$12, $10
	db SFX_HYPER_BEAM,		$F0, $20
	db SFX_BITE,			$12, $FF
	db SFX_SCREECH,			$80, $04
	db SFX_SHARPEN,			$F0, $10
	db SFX_EMBER,			$F8, $FF
	db SFX_THUNDER,			$F0, $FF
	db SFX_CUT,				$01, $FF
	db SFX_SURF,			$D8, $04
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	; Entries not present in pokered
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_THROW_BALL,		$00, $80
	db SFX_BALL_POOF,		$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	db SFX_POUND,			$00, $80
	; BUG: ANIM_BLINK_ENEMY_MON_UNUSED, ANIM_SHAKE_HORIZONTAL_UNUSED_2, ANIM_ENEMY_STAT_DOWN are missing from this table, so an overflow occurs if those entries are called.
	assert_table_length NUM_BATTLE_ANIMS - 3
