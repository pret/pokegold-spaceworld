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
