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
	callfar AnimationSubstitute

.played_anim
	ld hl, MadeSubstituteText
	call PrintText
	ld hl, UpdateBattleHuds
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
