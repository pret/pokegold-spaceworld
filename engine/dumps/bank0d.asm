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
	call sub_34677

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
	call sub_34677

	ld a, [wTurnEnded]
	and a
	ret nz

	ld hl, wcaba
	inc [hl]

	call UpdateMoveData
	ld a, [wEnemyMoveStructEffect]
	; fallthrough

DoMove:
	ld b, 0
	ld c, a
	ld hl, MoveEffectsPointers
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld de, wca5d

.GetMoveEffect:
	ld a, [hli]
	ld [de], a
	inc de
	cp $ff
	jr nz, .GetMoveEffect

	ld hl, wca5d
	ld a, l
	ld [wca7b], a
	ld a, h
	ld [wca7c], a

.ReadMoveEffectCommand:
	push bc
	ld a, [wca7b]
	ld l, a
	ld a, [wca7c]
	ld h, a

	ld a, [hli]

	ld c, a
	cp $ff
	ld a, l
	ld [wca7b], a
	ld a, h
	ld [wca7c], a
	jr z, .end

	dec c
	ld b, 0
	ld hl, Data34599
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

MoveEffectsPointers:
	dw NormalHit
	dw Data341c9
	dw Data341d1
	dw Data341e5
	dw Data341f8
	dw Data3420c
	dw Data34220
	dw Data34234
	dw Data34249
	dw Data3425b
	dw Data34261
	dw Data34261
	dw Data34261
	dw Data34261
	dw Data34261
	dw Data34261
	dw Data34261
	dw NormalHit
	dw Data34266
	dw Data34266
	dw Data34266
	dw Data34266
	dw Data34266
	dw Data34266
	dw Data34266
	dw Data34299
	dw Data3429e
	dw Data342ab
	dw Data342c1
	dw Data342c6
	dw Data34294
	dw Data342dc
	dw Data34339
	dw Data34348
	dw Data3427f
	dw Data34343
	dw NormalHit
	dw Data342dc
	dw Data342f0
	dw Data3438e
	dw Data343b9
	dw Data343b9
	dw Data343a4
	dw Data3438e
	dw Data342c6
	dw NormalHit
	dw Data34314
	dw Data34319
	dw Data342ff
	dw Data3431e
	dw Data34261
	dw Data34261
	dw Data34261
	dw Data34261
	dw Data34261
	dw Data34261
	dw Data34261
	dw Data3433e
	dw Data34266
	dw Data34266
	dw Data34266
	dw Data34266
	dw Data34266
	dw Data34266
	dw Data34266
	dw Data34343
	dw Data34348
	dw Data34350
	dw Data3426b
	dw Data3426b
	dw Data3426b
	dw Data3426b
	dw Data3426b
	dw Data3426b
	dw Data3426b
	dw NormalHit
	dw Data34325
	dw Data342c6
	dw NormalHit
	dw Data34358
	dw Data3435d
	dw NormalHit
	dw Data34371
	dw Data34377
	dw Data3437d
	dw Data34383
	dw Data34388
	dw Data343b9
	dw Data343b9
	dw Data343c7
	dw Data343d4
	dw Data343da
	dw Data343e0
	dw Data343f6
	dw Data343fc
	dw Data34402
	dw Data34407
	dw Data3440c
	dw Data34412
	dw Data343b9
	dw Data34417
	dw Data3441d
	dw Data34432
	dw NormalHit
	dw Data34437
	dw Data3444f
	dw Data34464
	dw Data34469
	dw Data3446e
	dw Data34483
	dw NormalHit
	dw Data34488
	dw Data3448d
	dw Data34493
	dw Data34499
	dw Data3449f
	dw Data344a5
	dw Data344aa
	dw Data344c0
	dw Data344c7
	dw Data344dc
	dw Data344e2
	dw Data344f7
	dw Data34509
	dw Data3451e
	dw Data34524
	dw Data34539
	dw Data3454e
	dw Data34553
	dw Data34554
	dw NormalHit
	dw NormalHit
	dw Data34569
	dw Data3456e
	dw Data34573
	dw Data34578
	dw Data3458d
	dw Data34593
	dw NormalHit
	dw NormalHit

NormalHit:
	checkobedience
	usedmovetext
	doturn
	critical
	damagestats
	damagecalc
	db $7
	db $8
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $4d
	db $ff

Data341c9:
	db $2
	db $3
	db $4
	db $7
	db $9
	db $65
	db $14
	db $ff

Data341d1:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $62
	db $7
	db $8
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $13
	db $ff

Data341e5:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $62
	db $7
	db $8
	db $9
	db $b
	db $d
	db $e
	db $f
	db $10
	db $15
	db $11
	db $12
	db $4d
	db $ff

Data341f8:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $62
	db $7
	db $8
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $17
	db $ff

Data3420c:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $62
	db $7
	db $8
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $18
	db $ff

Data34220:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $62
	db $7
	db $8
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $19
	db $ff

Data34234:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $62
	db $7
	db $8
	db $9
	db $a
	db $1a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $4d
	db $ff

Data34249:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $62
	db $7
	db $8
	db $9
	db $b
	db $d
	db $e
	db $f
	db $10
	db $16
	db $11
	db $12
	db $ff

Data3425b:
	db $2
	db $3
	db $7
	db $9
	db $1b
	db $ff

Data34261:
	db $2
	db $3
	db $4
	db $1c
	db $ff

Data34266:
	db $2
	db $3
	db $4
	db $1d
	db $ff

Data3426b:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $62
	db $7
	db $8
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $1d
	db $ff

Data3427f:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $62
	db $7
	db $8
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $1e
	db $11
	db $12
	db $4d
	db $ff

Data34294:
	db $2
	db $3
	db $4
	db $1f
	db $ff

Data34299:
	db $2
	db $3
	db $4
	db $20
	db $ff

Data3429e:
	db $21
	db $2
	db $4
	db $3
	db $22
	db $a
	db $b
	db $c
	db $e
	db $11
	db $12
	db $4d
	db $ff

Data342ab:
	db $3e
	db $2
	db $4
	db $9
	db $3d
	db $3
	db $5
	db $6
	db $62
	db $7
	db $8
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $4d
	db $ff

Data342c1:
	db $2
	db $3
	db $4
	db $23
	db $ff

Data342c6:
	db $2
	db $3
	db $4
	db $9
	db $5
	db $6
	db $62
	db $7
	db $8
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $38
	db $10
	db $11
	db $12
	db $24
	db $4d
	db $ff

Data342dc:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $62
	db $7
	db $8
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $25
	db $ff

Data342f0:
	db $2
	db $3
	db $4
	db $7
	db $26
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $ff

Data342ff:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $62
	db $7
	db $8
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $27
	db $11
	db $12
	db $4d
	db $ff

Data34314:
	db $2
	db $3
	db $4
	db $28
	db $ff

Data34319:
	db $2
	db $3
	db $4
	db $29
	db $ff

Data3431e:
	db $2
	db $3
	db $4
	db $9
	db $7
	db $2a
	db $ff

Data34325:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $62
	db $7
	db $8
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $2b
	db $ff

Data34339:
	db $2
	db $3
	db $4
	db $2c
	db $ff

Data3433e:
	db $2
	db $3
	db $4
	db $2d
	db $ff

Data34343:
	db $2
	db $3
	db $4
	db $2e
	db $ff

Data34348:
	db $2
	db $3
	db $4
	db $9
	db $7
	db $65
	db $2f
	db $ff

Data34350:
	db $2
	db $3
	db $4
	db $7
	db $9
	db $65
	db $30
	db $ff

Data34358:
	db $2
	db $3
	db $4
	db $31
	db $ff

Data3435d:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $62
	db $7
	db $8
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $32
	db $ff

Data34371:
	db $2
	db $3
	db $4
	db $9
	db $33
	db $ff

Data34377:
	db $2
	db $3
	db $4
	db $9
	db $34
	db $ff

Data3437d:
	db $2
	db $3
	db $4
	db $9
	db $35
	db $ff

Data34383:
	db $2
	db $3
	db $4
	db $36
	db $ff

Data34388:
	db $2
	db $3
	db $4
	db $9
	db $37
	db $ff

Data3438e:
	db $3a
	db $2
	db $4
	db $39
	db $3
	db $5
	db $6
	db $62
	db $7
	db $8
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $4d
	db $ff

Data343a4:
	db $3c
	db $2
	db $4
	db $3
	db $9
	db $3b
	db $5
	db $6
	db $62
	db $7
	db $8
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $ff

Data343b9:
	db $2
	db $3
	db $4
	db $3f
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $11
	db $12
	db $4d
	db $ff

Data343c7:
	db $2
	db $3
	db $4
	db $40
	db $a
	db $b
	db $c
	db $d
	db $e
	db $11
	db $12
	db $4d
	db $ff

Data343d4:
	db $2
	db $3
	db $4
	db $9
	db $41
	db $ff

Data343da:
	db $2
	db $3
	db $4
	db $9
	db $42
	db $ff

Data343e0:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $62
	db $7
	db $8
	db $9
	db $43
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $2b
	db $4d
	db $ff

Data343f6:
	db $2
	db $3
	db $4
	db $9
	db $44
	db $ff

Data343fc:
	db $2
	db $3
	db $4
	db $9
	db $45
	db $ff

Data34402:
	db $2
	db $3
	db $4
	db $46
	db $ff

Data34407:
	db $2
	db $3
	db $4
	db $47
	db $ff

Data3440c:
	db $2
	db $3
	db $4
	db $9
	db $48
	db $ff

Data34412:
	db $2
	db $3
	db $4
	db $49
	db $ff

Data34417:
	db $2
	db $3
	db $4
	db $9
	db $4a
	db $ff

Data3441d:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $62
	db $7
	db $8
	db $4b
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $4d
	db $ff

Data34432:
	db $2
	db $3
	db $4
	db $4c
	db $ff

Data34437:
	db $2
	db $3
	db $4
	db $9
	db $5
	db $6
	db $62
	db $4e
	db $7
	db $8
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $38
	db $10
	db $11
	db $12
	db $4f
	db $24
	db $4d
	db $ff

Data3444f:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $62
	db $7
	db $8
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $50
	db $11
	db $12
	db $4d
	db $ff

Data34464:
	db $2
	db $3
	db $4
	db $51
	db $ff

Data34469:
	db $2
	db $3
	db $4
	db $52
	db $ff

Data3446e:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $62
	db $7
	db $8
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $53
	db $11
	db $12
	db $4d
	db $ff

Data34483:
	db $2
	db $3
	db $4
	db $54
	db $ff

Data34488:
	db $2
	db $3
	db $4
	db $55
	db $ff

Data3448d:
	db $2
	db $3
	db $4
	db $9
	db $56
	db $ff

Data34493:
	db $2
	db $3
	db $4
	db $9
	db $57
	db $ff

Data34499:
	db $2
	db $3
	db $4
	db $9
	db $58
	db $ff

Data3449f:
	db $2
	db $3
	db $4
	db $9
	db $59
	db $ff

Data344a5:
	db $2
	db $3
	db $4
	db $5a
	db $ff

Data344aa:
	db $5b
	db $2
	db $4
	db $3
	db $5
	db $6
	db $62
	db $7
	db $9
	db $5c
	db $8
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $4d
	db $ff

Data344c0:
	db $2
	db $3
	db $4
	db $9
	db $5d
	db $2b
	db $ff

Data344c7:
	db $2
	db $4
	db $3
	db $5
	db $6
	db $62
	db $7
	db $9
	db $5e
	db $8
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $4d
	db $ff

Data344dc:
	db $2
	db $3
	db $4
	db $9
	db $5f
	db $ff

Data344e2:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $60
	db $62
	db $7
	db $8
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $4d
	db $ff

Data344f7:
	db $2
	db $3
	db $4
	db $9
	db $5
	db $6
	db $61
	db $62
	db $7
	db $8
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $4d
	db $ff

Data34509:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $63
	db $62
	db $7
	db $8
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $4d
	db $ff

Data3451e:
	db $2
	db $3
	db $4
	db $9
	db $64
	db $ff

Data34524:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $62
	db $7
	db $8
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $53
	db $11
	db $12
	db $25
	db $ff

Data34539:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $66
	db $62
	db $7
	db $8
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $4d
	db $ff

Data3454e:
	db $2
	db $3
	db $4
	db $67
	db $ff

Data34553:
	db $ff

Data34554:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $62
	db $7
	db $8
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $69
	db $11
	db $12
	db $4d
	db $ff

Data34569:
	db $2
	db $3
	db $4
	db $6a
	db $ff

Data3456e:
	db $2
	db $3
	db $4
	db $6b
	db $ff

Data34573:
	db $2
	db $3
	db $4
	db $6c
	db $ff

Data34578:
	db $2
	db $3
	db $4
	db $5
	db $6
	db $6d
	db $62
	db $7
	db $8
	db $9
	db $a
	db $b
	db $c
	db $d
	db $e
	db $f
	db $10
	db $11
	db $12
	db $4d
	db $ff

Data3458d:
	db $2
	db $3
	db $4
	db $9
	db $6e
	db $ff

Data34593:
	db $2
	db $3
	db $4
	db $9
	db $6f
	db $ff

Data34599:
	dw sub_34677
	dw BattleCommand_CheckObedience
	dw BattleCommand_UsedMoveText
	dw BattleCommand_DoTurn
	dw BattleCommand_Critical
	dw BattleCommand_DamageStats
	dw asm_34ec9
	dw asm_3519b
	dw Function351d0
	dw sub_35375
	dw asm_35393
	dw sub_353ef
	dw asm_3540e
	dw asm_3543f
	dw asm_3565c
	dw asm_35698
	dw asm_356c9
	dw asm_3574f
	dw asm_3622a
	dw BattleCommand_SleepTarget
	dw asm_36371
	dw asm_3638d
	dw asm_36426
	dw asm_364dc
	dw asm_36555
	dw asm_3751b
	dw asm_37549
	dw Function365bf
	dw asm_366e3
	dw BattleCommand_PayDay
	dw asm_37180
	dw asm_371ba
	dw asm_36894
	dw asm_36908
	dw asm_36985
	dw asm_36a92
	dw asm_36b55
	dw asm_36ba0
	dw asm_36d9b
	dw asm_36d3d
	dw asm_36d6d
	dw asm_36e2b
	dw asm_36e1e
	dw asm_3724b
	dw asm_37305
	dw asm_37407
	dw asm_36299
	dw asm_36ead
	dw asm_36f35
	dw asm_36fef
	dw asm_3701b
	dw asm_375b8
	dw asm_37069
	dw asm_370c2
	dw asm_370c8
	dw BattleCommand_ClearText
	dw asm_36c02
	dw asm_36beb
	dw asm_36cfe
	dw asm_36cd9
	dw asm_36969
	dw asm_3693e
	dw asm_35a9c
	dw asm_35b84
	dw asm_35bbd
	dw asm_35c0b
	dw asm_35cc5
	dw asm_35cd9
	dw asm_35d31
	dw asm_35d66
	dw asm_35dae
	dw asm_35dd4
	dw asm_35e30
	dw asm_35e5e
	dw sub_35ee1
	dw asm_35f13
	dw asm_36b74
	dw asm_34e99
	dw asm_34ec1
	dw asm_375ea
	dw asm_37672
	dw asm_376a6
	dw asm_376e6
	dw asm_3772b
	dw asm_37780
	dw asm_377ab
	dw asm_377e8
	dw asm_37828
	dw asm_37876
	dw asm_378af
	dw asm_378da
	dw asm_378f7
	dw asm_37936
	dw asm_3796e
	dw asm_379a8
	dw BattleCommand_HappinessPower
	dw asm_37a3a
	dw sub_3599d
	dw BattleCommand_FrustrationPower
	dw asm_37aa6
	dw asm_37af7
	dw asm_37b29
	dw asm_37b72
	dw asm_37c76
	dw asm_37c77
	dw asm_37ca5
	dw asm_37caa
	dw asm_37caf
	dw asm_37d21
	dw asm_37d83
	dw asm_37dae

sub_34677:
	ldh a, [hBattleTurn]
	and a
	ld a, [wCurPlayerSelectedMove]
	jr z, asm_34682
	ld a, [wCurEnemySelectedMove]

asm_34682:
	inc a
	jp z, asm_34991
	xor a
	ld [wca3a], a
	ld [wBattleAnimParam], a
	ld [wAlreadyDisobeyed], a
	ld [wcad9], a
	ld a, $a
	ld [wTypeModifier], a
	ldh a, [hBattleTurn]
	and a
	jp nz, asm_34809
	ld hl, wBattleMonStatus
	ld a, [hl]
	and 7
	jr z, asm_346e5
	dec a
	ld [wBattleMonStatus], a
	and 7
	jr z, asm_346ba
	xor a
	ld [wNumHits], a
	ld de, $0104
	call sub_35f53
	jr asm_346cd

asm_346ba:
	ld hl, WokeUpText
	call PrintText
	ld hl, Function3d5ce
	call CallFromBank0F
	ld hl, wPlayerSubStatus1
	res 0, [hl]
	jr asm_346e5

asm_346cd:
	ld hl, FastAsleepText
	call PrintText
	ld a, [wCurPlayerSelectedMove]
	cp MOVE_SNORE
	jr z, asm_346e5
	cp MOVE_SLEEP_TALK
	jr z, asm_346e5
	xor a
	ld [wCurPlayerMove], a
	jp asm_34991

asm_346e5:
	ld hl, wBattleMonStatus
	bit 5, [hl]
	jr z, asm_34704
	ld a, [wCurPlayerSelectedMove]
	cp MOVE_FLAME_WHEEL
	jr z, asm_34704
	cp MOVE_SACRED_FIRE
	jr z, asm_34704
	ld hl, FrozenSolidText
	call PrintText
	xor a
	ld [wCurPlayerMove], a
	jp asm_34991

asm_34704:
	ld a, [wEnemySubStatus3]
	bit 5, a
	jp z, asm_3471d
	ld a, [wCurPlayerSelectedMove]
	cp MOVE_RAPID_SPIN
	jp z, asm_3471d
	ld hl, CantMoveText
	call PrintText
	jp asm_34991

asm_3471d:
	ld hl, wPlayerSubStatus3
	bit 3, [hl]
	jp z, asm_34730
	res 3, [hl]
	ld hl, FlinchedText
	call PrintText
	jp asm_34991

asm_34730:
	ld hl, wPlayerSubStatus4
	bit 5, [hl]
	jr z, asm_34742
	res 5, [hl]
	ld hl, MustRechargeText
	call PrintText
	jp asm_34991

asm_34742:
	ld hl, wca48
	ld a, [hl]
	and a
	jr z, asm_34759
	dec a
	ld [hl], a
	and $f
	jr nz, asm_34759
	ld [hl], a
	ld [wcad3], a
	ld hl, DisabledNoMoreText
	call PrintText

asm_34759:
	ld a, [wPlayerSubStatus3]
	add a
	jr nc, asm_34796
	ld hl, wca46
	dec [hl]
	jr nz, asm_34772
	ld hl, wPlayerSubStatus3
	res 7, [hl]
	ld hl, ConfusedNoMoreText
	call PrintText
	jr asm_34796

asm_34772:
	ld hl, IsConfusedText
	call PrintText
	xor a
	ld [wNumHits], a
	ld de, $0103
	call sub_35f53
	call BattleRandom
	cp $80
	jp c, asm_34796
	ld hl, wPlayerSubStatus3
	ld a, [hl]
	and $80
	ld [hl], a
	call sub_34b03
	jr asm_347e2

asm_34796:
	ld a, [wPlayerSubStatus1]
	add a
	jr nc, asm_347bc
	ld hl, InLoveWithText
	call PrintText
	xor a
	ld [wNumHits], a
	ld de, $010a
	call sub_35f53
	call BattleRandom
	cp $80
	jp c, asm_347bc
	ld hl, InfatuationText
	call PrintText
	jr asm_347e2

asm_347bc:
	ld a, [wcad3]
	and a
	jr z, asm_347ce
	ld hl, wCurPlayerSelectedMove
	cp [hl]
	jr nz, asm_347ce
	call sub_34acc
	jp asm_34991

asm_347ce:
	ld hl, wBattleMonStatus
	bit 6, [hl]
	jr z, asm_34808
	call BattleRandom
	cp $3f
	jr nc, asm_34808
	ld hl, FullyParalyzedText
	call PrintText

asm_347e2:
	ld hl, wPlayerSubStatus3
	ld a, [hl]
	and $cc
	ld [hl], a
	ld hl, wPlayerSubStatus1
	res 6, [hl]
	ld a, [wPlayerMoveStruct]
	cp $13
	jr z, asm_347fb
	cp $5b
	jr z, asm_347fb
	jr asm_34805

asm_347fb:
	res 6, [hl]
	ld a, 2
	ld [wBattleAnimParam], a
	call LoadMoveAnim

asm_34805:
	jp asm_34991

asm_34808:
	ret

asm_34809:
	ld hl, wEnemyMonStatus
	ld a, [hl]
	and 7
	jr z, asm_3484f
	dec a
	ld [wEnemyMonStatus], a
	and a
	jr z, asm_3482a
	ld hl, FastAsleepText
	call PrintText
	xor a
	ld [wNumHits], a
	ld de, $0104
	call sub_35f53
	jr asm_3483d

asm_3482a:
	ld hl, WokeUpText
	call PrintText
	ld hl, Function3d67c
	call CallFromBank0F
	ld hl, wEnemySubStatus1
	res 0, [hl]
	jr asm_3484f

asm_3483d:
	ld a, [wCurPlayerSelectedMove]
	cp MOVE_SNORE
	jr z, asm_3484f
	cp MOVE_SLEEP_TALK
	jr z, asm_3484f
	xor a
	ld [wCurEnemyMove], a
	jp asm_34991

asm_3484f:
	ld hl, wEnemyMonStatus
	bit 5, [hl]
	jr z, asm_3486e
	ld a, [wCurEnemySelectedMove]
	cp MOVE_FLAME_WHEEL
	jr z, asm_3486e
	cp MOVE_SACRED_FIRE
	jr z, asm_3486e
	ld hl, FrozenSolidText
	call PrintText
	xor a
	ld [wCurEnemyMove], a
	jp asm_34991

asm_3486e:
	ld a, [wPlayerSubStatus3]
	bit 5, a
	jp z, asm_34887
	ld a, [wCurEnemySelectedMove]
	cp MOVE_RAPID_SPIN
	jp z, asm_34887
	ld hl, CantMoveText
	call PrintText
	jp asm_34991

asm_34887:
	ld hl, wEnemySubStatus3
	bit 3, [hl]
	jp z, asm_3489a
	res 3, [hl]
	ld hl, FlinchedText
	call PrintText
	jp asm_34991

asm_3489a:
	ld hl, wEnemySubStatus4
	bit 5, [hl]
	jr z, asm_348ac
	res 5, [hl]
	ld hl, MustRechargeText
	call PrintText
	jp asm_34991

asm_348ac:
	ld hl, wca50
	ld a, [hl]
	and a
	jr z, asm_348c3
	dec a
	ld [hl], a
	and $f
	jr nz, asm_348c3
	ld [hl], a
	ld [wcad4], a
	ld hl, DisabledNoMoreText
	call PrintText

asm_348c3:
	ld a, [wEnemySubStatus3]
	add a
	jp nc, asm_3491d
	ld hl, wca4e
	dec [hl]
	jr nz, asm_348de
	ld hl, wEnemySubStatus3
	res 7, [hl]
	ld hl, ConfusedNoMoreText
	call PrintText
	jp asm_3491d

asm_348de:
	ld hl, IsConfusedText
	call PrintText
	xor a
	ld [wNumHits], a
	ld de, $0103
	call sub_35f53
	call BattleRandom
	cp $80
	jr c, asm_3491d
	ld hl, wEnemySubStatus3
	ld a, [hl]
	and $80
	ld [hl], a
	ld hl, HurtItselfText
	call PrintText
	call sub_35904
	call sub_3599d
	xor a
	ld [wNumHits], a
	ldh [hBattleTurn], a
	ld de, 1
	call sub_35f53
	ld a, 1
	ldh [hBattleTurn], a
	call sub_35f68
	jr asm_34969

asm_3491d:
	ld a, [wEnemySubStatus1]
	add a
	jr nc, asm_34943
	ld hl, InLoveWithText
	call PrintText
	xor a
	ld [wNumHits], a
	ld de, $010a
	call sub_35f53
	call BattleRandom
	cp $80
	jp c, asm_34943
	ld hl, InfatuationText
	call PrintText
	jr asm_34969

asm_34943:
	ld a, [wcad4]
	and a
	jr z, asm_34955
	ld hl, wCurEnemySelectedMove
	cp [hl]
	jr nz, asm_34955
	call sub_34acc
	jp asm_34991

asm_34955:
	ld hl, wEnemyMonStatus
	bit 6, [hl]
	jr z, asm_3498f
	call BattleRandom
	cp $3f
	jr nc, asm_3498f
	ld hl, FullyParalyzedText
	call PrintText

asm_34969:
	ld hl, wEnemySubStatus3
	ld a, [hl]
	and $cc
	ld [hl], a
	ld hl, wEnemySubStatus1
	res 6, [hl]
	ld a, [wEnemyMoveStruct]
	cp MOVE_FLY
	jr z, asm_34982
	cp MOVE_DIG
	jr z, asm_34982
	jr asm_3498c

asm_34982:
	res 6, [hl]
	ld a, 2
	ld [wBattleAnimParam], a
	call LoadMoveAnim

asm_3498c:
	jp asm_34991

asm_3498f:
	ret
	ret

asm_34991:
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

sub_34acc:
	ld hl, wCurPlayerSelectedMove
	ld de, wPlayerSubStatus3
	ldh a, [hBattleTurn]
	and a
	jr z, asm_34adb
	inc hl ; wCurEnemySelectedMove
	ld de, wEnemySubStatus3

asm_34adb:
	ld a, [de]
	res 4, a
	ld [de], a
	ld a, [hl]
	ld [wNumSetBits], a
	call Unreferenced_GetMoveName
	ld hl, ScaredText
	jp PrintText

ScaredText:
	text "<USER>は　かなしばりで"
	line "@"
	text_from_ram wStringBuffer1
	text "がだせない！"
	prompt

sub_34b03:
	ld hl, HurtItselfText
	call PrintText
	xor a
	ld [wCriticalHit], a
	call sub_35904
	call sub_3599d
	xor a
	ld [wNumHits], a
	inc a
	ldh [hBattleTurn], a
	ld de, 1
	call sub_35f53
	ld hl, Function3d5ce
	call CallFromBank0F
	xor a
	ldh [hBattleTurn], a
	jp sub_35fc9

BattleCommand_CheckObedience:
	ldh a, [hBattleTurn]
	and a
	ret nz
	xor a
	ld [wAlreadyDisobeyed], a
	ld a, [wLinkMode]
	and a
	ret nz
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
	ld b, a
	ld c, a
	ld a, [wBattleMonLevel]
	ld d, a
	add b
	ld b, a
	jr nc, asm_34b7a
	ld b, $ff

asm_34b7a:
	ld a, c
	cp d
	ret nc

asm_34b7d:
	call BattleRandom
	swap a
	cp b
	jr nc, asm_34b7d
	cp c
	ret c

asm_34b87:
	call BattleRandom
	cp b
	jr nc, asm_34b87
	cp c
	jr c, asm_34bdb
	ld a, d
	sub c
	ld b, a
	call BattleRandom
	swap a
	sub b
	jr c, asm_34baa
	cp b
	jr nc, asm_34bbc
	ld hl, WontObeyText
	call PrintText
	call sub_34b03
	jp asm_34c34

asm_34baa:
	call BattleRandom
	add a
	swap a
	and 7
	jr z, asm_34baa
	ld [wBattleMonStatus], a
	ld hl, BeganToNapText
	jr asm_34bd6

asm_34bbc:
	call BattleRandom
	and 3
	ld hl, LoafingAroundText
	and a
	jr z, asm_34bd6
	ld hl, WontObeyText
	dec a
	jr z, asm_34bd6
	ld hl, TurnedAwayText
	dec a
	jr z, asm_34bd6
	ld hl, IgnoredOrdersText

asm_34bd6:
	call PrintText
	jr asm_34c34

asm_34bdb:
	ld a, [wBattleMonMoves + 1]
	and a
	jr z, asm_34bbc
	ld hl, wBattleMonPP
	push hl
	ld a, [hli]
	ld b, [hl]
	inc hl
	add b
	ld b, [hl]
	inc hl
	add b
	ld b, [hl]
	add b
	pop hl
	push af
	ld a, [wcd40]
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	pop af
	cp b
	jr z, asm_34bbc
	ld a, 1
	ld [wAlreadyDisobeyed], a
	ld a, [w2DMenuNumRows]
	dec a
	ld b, a
	ld a, [wcd40]
	ld c, a

asm_34c0a:
	call BattleRandom
	and 3
	cp b
	jr nc, asm_34c0a
	cp c
	jr z, asm_34c0a
	ld [wcd40], a
	ld hl, wBattleMonPP
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hl]
	and a
	jr z, asm_34c0a
	ld a, [wcd40]
	ld c, a
	ld b, 0
	ld hl, wBattleMonMoves
	add hl, bc
	ld a, [hl]
	ld [wCurPlayerSelectedMove], a
	call UpdateMoveData

asm_34c34:
	jp asm_357a9

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
	jr z, asm_34d96
	ld a, [wCurEnemySelectedMove]
	ld hl, wEnemyMonPP
	ld de, wEnemySubStatus3

asm_34d96:
	; If move is struggle, return
	cp MOVE_STRUGGLE
	ret z

	; If afflicted with one of these substatuses, return
	ld a, [de]
	and 7
	ret nz

	inc de
	ld a, [de]
	bit 6, a
	ret nz
	call sub_34dcb
	ld a, b
	and a
	jp nz, asm_357a9
	inc de
	ld a, [de]
	bit 3, a
	ret nz
	ldh a, [hBattleTurn]
	and a
	ld hl, wPartyMon1PP
	ld a, [wCurBattleMon]
	jr z, asm_34dc5
	ld a, [wBattleMode]
	dec a
	ret z
	ld hl, wOTPartyMon1PP
	ld a, [wCurOTMon]

asm_34dc5:
	ld bc, (wPartyMon2 - wPartyMon1)
	call AddNTimes

sub_34dcb:
	ldh a, [hBattleTurn]
	and a
	ld a, [wcd40]
	jr z, asm_34dd6
	ld a, [wcac7]

asm_34dd6:
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	jr z, asm_34de2
	dec [hl]
	ld b, 0
	ret

asm_34de2:
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
	ld hl, CriticalHitMoves

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

CriticalHitMoves:
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

asm_34e99:
	ld a, [wBattleAnimParam]
	ld b, a
	inc b
	ld a, [wCurDamage + 1]
	ld e, a
	ld a, [wCurDamage]
	ld d, a

asm_34ea6:
	dec b
	ret z
	ld a, [wCurDamage + 1]
	add e
	ld [wCurDamage + 1], a
	ld a, [wCurDamage]
	adc d
	ld [wCurDamage], a
	jr nc, asm_34ea6
	ld a, $ff
	ld [wCurDamage], a
	ld [wCurDamage + 1], a
	ret

asm_34ec1:
	ld a, [wBattleAnimParam]
	inc a
	ld [wBattleAnimParam], a
	ret

asm_34ec9:
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
	jr z, asm_34ef2
	ld hl, wEnemyMonType
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wBattleMonType
	ld a, [hli]
	ld d, a
	ld e, [hl]
	ld a, [wEnemyMoveStructType]
	ld [wNumSetBits], a

asm_34ef2:
	call sub_34f97
	ld a, [wNumSetBits]
	cp b
	jr z, asm_34f00
	cp c
	jr z, asm_34f00
	jr asm_34f1a

asm_34f00:
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
	set 7, [hl]

asm_34f1a:
	ld a, [wNumSetBits]
	ld b, a
	ld hl, TypeMatchups

asm_34f21:
	ld a, [hli]
	cp $ff
	jr z, asm_34f86
	cp $fe
	jr nz, asm_34f3d
	push hl
	ld hl, wEnemySubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, asm_34f36
	ld hl, wPlayerSubStatus1

asm_34f36:
	bit 3, [hl]
	pop hl
	jr nz, asm_34f86
	jr asm_34f21

asm_34f3d:
	cp b
	jr nz, asm_34f81
	ld a, [hl]
	cp d
	jr z, asm_34f49
	cp e
	jr z, asm_34f49
	jr asm_34f81

asm_34f49:
	push hl
	push bc
	inc hl
	ld a, [wTypeModifier]
	and $80
	ld b, a
	ld a, [hl]
	and a
	jr nz, asm_34f5b
	inc a
	ld [wca3a], a
	xor a

asm_34f5b:
	ldh [hDivisor], a
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
	ld a, $a
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 2]
	ld [hli], a
	ldh a, [hQuotient + 3]
	ld [hl], a
	pop bc
	pop hl

asm_34f81:
	inc hl
	inc hl
	jp asm_34f21

asm_34f86:
	call Function34fff
	ld a, [wNumSetBits]
	ld b, a
	ld a, [wTypeModifier]
	and $80
	or b
	ld [wTypeModifier], a
	ret

sub_34f97:
	push hl
	push de
	push bc
	ld hl, Data34ff2
	ld a, [wcae2]
	ld b, a
	ld a, [wNumSetBits]
	ld c, a

asm_34fa5:
	ld a, [hli]
	cp $ff
	jr z, asm_34fee
	cp b
	jr nz, asm_34fb1
	ld a, [hl]
	cp c
	jr z, asm_34fb5

asm_34fb1:
	inc hl
	inc hl
	jr asm_34fa5

asm_34fb5:
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
	ld a, $a
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 1]
	and a
	ld bc, $ffff
	jr nz, asm_34fe6
	ldh a, [hQuotient + 2]
	ld b, a
	ldh a, [hQuotient + 3]
	ld c, a
	or b
	jr nz, asm_34fe6
	ld bc, 1

asm_34fe6:
	ld a, b
	ld [wCurDamage], a
	ld a, c
	ld [wCurDamage + 1], a

asm_34fee:
	pop bc
	pop de
	pop hl
	ret

Data34ff2:
	db $1
	db $15
	db $14
	db $1
	db $14
	db $5
	db $2
	db $14
	db $14
	db $2
	db $15
	db $5
	db $ff

Function34fff:
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyMonType
	ld a, [wPlayerMoveStructType]
	jr z, asm_35010
	ld hl, wBattleMonType
	ld a, [wEnemyMoveStructType]

asm_35010:
	ld d, a
	ld b, [hl]
	inc hl
	ld c, [hl]
	ld a, $a
	ld [wNumSetBits], a
	ld hl, TypeMatchups

asm_3501c:
	ld a, [hli]
	cp $ff
	jr z, asm_3506c
	cp $fe
	jr nz, asm_35038
	push hl
	ld hl, wEnemySubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, asm_35031
	ld hl, wPlayerSubStatus1

asm_35031:
	bit 3, [hl]
	pop hl
	jr nz, asm_3506c
	jr asm_3501c

asm_35038:
	cp d
	jr nz, asm_35044
	ld a, [hli]
	cp b
	jr z, asm_35048
	cp c
	jr z, asm_35048
	jr asm_35045

asm_35044:
	inc hl

asm_35045:
	inc hl
	jr asm_3501c

asm_35048:
	xor a
	ldh [hProduct], a
	ldh [hMultiplicand], a
	ldh [hMultiplicand + 1], a
	ld a, [hli]
	ldh [hMultiplicand + 2], a
	ld a, [wNumSetBits]
	ldh [hMultiplier], a
	call Multiply
	ld a, $a
	ldh [hDivisor], a
	push bc
	ld b, 4
	call Divide
	pop bc
	ldh a, [hQuotient + 3]
	ld [wNumSetBits], a
	jr asm_3501c

asm_3506c:
	ret

INCLUDE "data/types/type_matchups.inc"

asm_3519b:
	ld hl, wCurDamage
	ld a, [hli]
	and a
	jr nz, asm_351a6
	ld a, [hl]
	cp 2
	ret c

asm_351a6:
	xor a
	ldh [hMultiplicand], a
	dec hl
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ldh [hMultiplicand + 2], a

asm_351b0:
	call BattleRandom
	rrca
	cp $d9
	jr c, asm_351b0
	ldh [hMultiplier], a
	call Multiply
	ld a, $ff
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 2]
	ld hl, wCurDamage
	ld [hli], a
	ldh a, [hQuotient + 3]
	ld [hl], a
	ret

Function351d0:
	ld hl, wEnemySubStatus1
	ld de, wPlayerMoveStructEffect
	ld bc, wEnemyMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, asm_351e7
	ld hl, wPlayerSubStatus1
	ld de, wEnemyMoveStructEffect
	ld bc, wBattleMonStatus

asm_351e7:
	ld a, [de]
	cp 8
	jr nz, asm_351f2
	ld a, [bc]
	and 7
	jp z, asm_352c4

asm_351f2:
	bit 2, [hl]
	jp nz, asm_352c4
	ld a, [de]
	cp $11
	ret z
	inc hl
	inc hl
	inc hl
	inc hl
	bit 5, [hl]
	res 5, [hl]
	ret nz
	call CheckSubstituteOpp
	jr z, asm_35213
	cp 3
	jp z, asm_352c4
	cp 8
	jp z, asm_352c4

asm_35213:
	dec hl
	dec hl
	bit 6, [hl]
	jp z, asm_3524d
	ld hl, wCurEnemyMove
	ld de, wPlayerMoveStruct
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3522b
	ld hl, wCurPlayerMove
	ld de, wEnemyMoveStruct

asm_3522b:
	ld a, [hl]
	cp MOVE_FLY
	jr nz, asm_3523c
	ld a, [de]
	cp MOVE_WHIRLWIND
	jr z, asm_3524d
	cp MOVE_THUNDER
	jr z, asm_3524d
	jp asm_352c4

asm_3523c:
	cp MOVE_DIG
	jp nz, asm_352c4
	ld a, [de]
	cp MOVE_EARTHQUAKE
	jr z, asm_3524d
	cp MOVE_FISSURE
	jr z, asm_3524d
	jp asm_352c4

asm_3524d:
	ldh a, [hBattleTurn]
	and a
	jr nz, asm_35277
	ld a, [wPlayerMoveStructEffect]
	cp $12
	jr c, asm_3526f
	cp $1a
	jr c, asm_35267
	cp $3a
	jr c, asm_3526f
	cp $42
	jr c, asm_35267
	jr asm_3526f

asm_35267:
	ld a, [wEnemySubStatus4]
	bit 1, a
	jp nz, asm_352c4

asm_3526f:
	ld a, [wPlayerSubStatus4]
	bit 0, a
	ret nz
	jr asm_3529a

asm_35277:
	ld a, [wEnemyMoveStructEffect]
	cp $12
	jr c, asm_35294
	cp $1a
	jr c, asm_3528c
	cp $3a
	jr c, asm_35294
	cp $42
	jr c, asm_3528c
	jr asm_35294

asm_3528c:
	ld a, [wPlayerSubStatus4]
	bit 1, a
	jp nz, asm_352c4

asm_35294:
	ld a, [wEnemySubStatus4]
	bit 0, a
	ret nz

asm_3529a:
	call sub_352df
	ld a, [wPlayerMoveStructAccuracy]
	ld b, a
	ldh a, [hBattleTurn]
	and a
	jr z, asm_352aa
	ld a, [wEnemyMoveStructAccuracy]
	ld b, a

asm_352aa:
	push bc
	call GetOpponentItem
	ld a, b
	cp $4d
	ld a, c
	pop bc
	jr nz, asm_352bd
	ld c, a
	ld a, b
	sub c
	ld b, a
	jr nc, asm_352bd
	ld b, 0

asm_352bd:
	call BattleRandom
	cp b
	jr nc, asm_352c4
	ret

asm_352c4:
	xor a
	ld hl, wCurDamage
	ld [hli], a
	ld [hl], a
	inc a
	ld [wca3a], a
	ldh a, [hBattleTurn]
	and a
	jr z, asm_352d9
	ld hl, wEnemySubStatus3
	res 5, [hl]
	ret

asm_352d9:
	ld hl, wPlayerSubStatus3
	res 5, [hl]
	ret

sub_352df:
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerMoveStructAccuracy
	ld a, [wcaae]
	ld b, a
	ld a, [wcab7]
	ld c, a
	jr z, asm_352fa
	ld hl, wEnemyMoveStructAccuracy
	ld a, [wcab6]
	ld b, a
	ld a, [wcaaf]
	ld c, a

asm_352fa:
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

asm_35309:
	push bc
	ld hl, Data35342
	dec b
	sla b
	ld c, b
	ld b, 0
	add hl, bc
	pop bc
	ld a, [hli]
	ldh [hMultiplier], a
	call Multiply
	ld a, [hl]
	ldh [hPrintNumDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 3]
	ld b, a
	ldh a, [hQuotient + 2]
	or b
	jp nz, asm_35332
	ldh [hQuotient + 2], a
	ld a, 1
	ldh [hQuotient + 3], a

asm_35332:
	ld b, c
	dec d
	jr nz, asm_35309
	ldh a, [hQuotient + 2]
	and a
	ldh a, [hQuotient + 3]
	jr z, asm_3533f
	ld a, $ff

asm_3533f:
	pop hl
	ld [hl], a
	ret

Data35342:
	dw $6419
	dw $641c
	dw $6421
	dw $6428
	dw $6432
	dw $6442
	dw $101
	dw $a0f
	dw $102
	dw $a19
	dw $103
	dw $a23
	dw $104

BattleCommand_EffectChance:
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

sub_35375:
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerSubStatus4]
	jr z, asm_35380
	ld a, [wEnemySubStatus4]

asm_35380:
	bit 4, a
	ret z
	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	inc a
	ld [wBattleAnimParam], a
	ld a, $a4
	jp LoadBattleAnim

asm_35393:
	ld a, [wca3a]
	and a
	jp nz, BattleCommand_MoveDelay
	inc a
	ld [wNumHits], a
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStruct]
	ld c, a
	ld de, wca45
	ld a, [wPlayerMoveStructEffect]
	jr z, asm_353b7
	ld a, [wEnemyMoveStruct]
	ld c, a
	ld de, wca4d
	ld a, [wEnemyMoveStructEffect]

asm_353b7:
	cp $1d
	jr z, asm_353d5
	cp $1e
	jr z, asm_353d5
	cp $2c
	jr z, asm_353d5
	cp $4d
	jr z, asm_353d5
	cp $68
	jr z, asm_353cf
	xor a
	ld [wBattleAnimParam], a

asm_353cf:
	ld e, c
	ld d, 0
	jp sub_35f53

asm_353d5:
	ld a, [wBattleAnimParam]
	and 1
	xor 1
	ld [wBattleAnimParam], a
	ld a, [de]
	cp 1
	ld e, c
	ld d, 0
	jp z, sub_35f53
	xor a
	ld [wNumHits], a
	jp sub_35f53

sub_353ef:
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerSubStatus4]
	jr z, asm_353fa
	ld a, [wEnemySubStatus4]

asm_353fa:
	bit 4, a
	ret z
	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	ld a, 2
	ld [wBattleAnimParam], a
	ld a, $a4
	jp LoadBattleAnim

asm_3540e:
	ld a, [wca3a]
	and a
	ret z
	call sub_355a6
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStruct]
	ld hl, wPlayerSubStatus3
	jr z, asm_35427
	ld a, [wEnemyMoveStruct]
	ld hl, wEnemySubStatus3

asm_35427:
	cp $13
	jr z, asm_35432
	cp $5b
	jr z, asm_35432
	jp asm_357a9

asm_35432:
	res 6, [hl]
	ld a, 2
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	jp asm_357a9

asm_3543f:
	ld hl, wEnemySubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3544a
	ld hl, wPlayerSubStatus1

asm_3544a:
	bit 5, [hl]
	jr z, asm_35459
	call sub_35ee1
	ld b, 0
	jr nc, asm_35472
	ld b, 1
	jr asm_35472

asm_35459:
	call GetOpponentItem
	ld a, b
	cp $4f
	ld b, 0
	jr nz, asm_35472
	call BattleRandom
	cp c
	jr nc, asm_35472
	call sub_35ee1
	ld b, 0
	jr nc, asm_35472
	ld b, 2

asm_35472:
	push bc
	call sub_354a0
	ldh a, [hBattleTurn]
	and a
	jr nz, asm_35480
	call sub_35f68
	jr asm_35483

asm_35480:
	call sub_35fc9

asm_35483:
	pop bc
	ld a, b
	and a
	ret z
	dec a
	jr nz, asm_35490
	ld hl, EnduredText
	jp PrintText

asm_35490:
	call GetOpponentItem
	ld a, [hl]
	ld [wNumSetBits], a
	call GetItemName
	ld hl, HungOnText
	jp PrintText

sub_354a0:
	ld de, wca56
	ldh a, [hBattleTurn]
	and a
	jr nz, asm_354ab
	ld de, wca58

asm_354ab:
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
	call GetOpponentItem
	ldh a, [hBattleTurn]
	and a
	ld de, wBattleMonHP
	ld hl, wBattleMonMaxHP
	ld a, [wPlayerMoveStruct]
	jr z, asm_354db
	ld de, wEnemyMonHP
	ld hl, wEnemyMonMaxHP
	ld a, [wEnemyMoveStruct]

asm_354db:
	ld b, a
	ld a, [de]
	cp [hl]
	inc de
	inc hl
	ld a, [de]
	sbc [hl]
	jp z, asm_3556a
	ld a, b
	cp $9c
	jr nz, asm_3550d
	push hl
	push de
	push af
	call BattleCommand_MoveDelay
	ld hl, wBattleMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, asm_354fb
	ld hl, wEnemyMonStatus

asm_354fb:
	ld a, [hl]
	and a
	ld [hl], 2
	ld hl, WentToSleepText
	jr z, asm_35507
	ld hl, RestedText

asm_35507:
	call PrintText
	pop af
	pop de
	pop hl

asm_3550d:
	ld a, [hld]
	ld [wHPBarMaxHP], a
	ld c, a
	ld a, [hl]
	ld [wPlayerEffectivenessVsEnemyMons], a
	ld b, a
	jr z, asm_3551d
	srl b
	rr c

asm_3551d:
	ld a, [de]
	ld [wHPBarOldHP], a
	add c
	ld [de], a
	ld [wHPBarNewHP], a
	dec de
	ld a, [de]
	ld [wcdc6], a
	adc b
	ld [de], a
	ld [wcdc8], a
	inc hl
	inc de
	ld a, [de]
	dec de
	sub [hl]
	dec hl
	ld a, [de]
	sbc [hl]
	jr c, asm_35545
	ld a, [hli]
	ld [de], a
	ld [wcdc8], a
	inc de
	ld a, [hl]
	ld [de], a
	ld [wHPBarNewHP], a

asm_35545:
	call LoadMoveAnim
	ldh a, [hBattleTurn]
	and a
	ld hl, wTileMap + 190
	ld a, 1
	jr z, asm_35556
	ld hl, wTileMap + 42
	xor a

asm_35556:
	ld [wWhichHPBar], a
	predef UpdateHPBar
	ld hl, DrawHUDsAndHPBars
	call CallFromBank0F
	ld hl, RegainedHealthText
	jp PrintText

asm_3556a:
	call BattleCommand_MoveDelay
	jp Function37499

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

sub_355a6:
	ld de, wPlayerMoveStructEffect
	ldh a, [hBattleTurn]
	and a
	jr z, asm_355b1
	ld de, wEnemyMoveStructEffect

asm_355b1:
	ld hl, DoesntAffectTarget
	ld a, [wTypeModifier]
	and $7f
	jr z, asm_355c8
	ld hl, AttackMissedText
	ld a, [wCriticalHit]
	cp $ff
	jr nz, asm_355c8
	ld hl, UnaffectedText

asm_355c8:
	push de
	call PrintText
	xor a
	ld [wCriticalHit], a
	pop de
	ld a, [de]
	cp $2d
	ret nz
	ld hl, wCurDamage
	ld a, [hli]
	ld b, [hl]
	srl a
	rr b
	srl a
	rr b
	srl a
	rr b
	ld [hl], b
	dec hl
	ld [hli], a
	or b
	jr nz, asm_355ee
	inc a
	ld [hl], a

asm_355ee:
	ld hl, CrashedText
	call PrintText
	ld a, 1
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ldh a, [hBattleTurn]
	and a
	jp nz, sub_35f68
	jp sub_35fc9

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

asm_35643:
	ld hl, DoesntAffectTarget
	jp PrintText

DoesntAffectTarget:
	text "<TARGET>には"
	line "こうかが　ない　みたいだ<⋯⋯>"
	prompt

asm_3565c:
	ld a, [wCriticalHit]
	and a
	jr z, asm_35675
	dec a
	add a
	ld hl, Data3567a
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	xor a
	ld [wCriticalHit], a

asm_35675:
	ld c, 20
	jp DelayFrames

Data3567a:
	dw CriticalHitText
	dw OneHitKOText

CriticalHitText:
	text "きゅうしょに　あたった！"
	prompt

OneHitKOText:
	text "いちげき　ひっさつ！"
	prompt

asm_35698:
	ld a, [wTypeModifier]
	and $7f
	cp EFFECTIVE
	ret z
	ld hl, SuperEffectiveText
	jr nc, asm_356a8
	ld hl, NotVeryEffectiveText

asm_356a8:
	jp PrintText

SuperEffectiveText:
	text "こうかは　ばつぐんだ！"
	prompt

NotVeryEffectiveText:
	text "こうかは　いまひとつの　ようだ"
	prompt

asm_356c9:
	ld hl, wEnemyMonHP
	ld de, wEnemySubStatus5
	ldh a, [hBattleTurn]
	and a
	jr z, asm_356da
	ld hl, wBattleMonHP
	ld de, wPlayerSubStatus5

asm_356da:
	ld a, [hli]
	or [hl]
	ret nz
	ld a, [de]
	bit 6, a
	jr z, asm_3573b
	ld hl, TookDownWithItText
	call PrintText
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyMonMaxHP + 1
	ld bc, wTileMap + 42
	ld a, 0
	jr nz, asm_356fd
	ld hl, wBattleMonMaxHP + 1
	ld bc, wTileMap + 190
	ld a, 1

asm_356fd:
	ld [wWhichHPBar], a
	ld a, [hld]
	ld [wHPBarMaxHP], a
	ld a, [hld]
	ld [wPlayerEffectivenessVsEnemyMons], a
	ld a, [hl]
	ld [wHPBarOldHP], a
	xor a
	ld [hld], a
	ld a, [hl]
	ld [wcdc6], a
	xor a
	ld [hl], a
	ld [wHPBarNewHP], a
	ld [wcdc8], a
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
	ld a, $c2
	call LoadBattleAnim
	pop af
	ldh [hBattleTurn], a

asm_3573b:
	jp asm_357a9

TookDownWithItText:
	text "<TARGET>は　<USER>を"
	line "みちずれに　した！"
	prompt

asm_3574f:
	jp asm_35752

asm_35752:
	ld hl, wEnemySubStatus4
	ld de, wcab1
	ld bc, wEnemyMoveStruct
	ldh a, [hBattleTurn]
	and a
	jr z, asm_35769
	ld hl, wPlayerSubStatus4
	ld de, wcaa9
	ld bc, wPlayerMoveStruct

asm_35769:
	bit 6, [hl]
	ret z
	ld a, [de]
	cp $d
	ret z
	ldh a, [hBattleTurn]
	xor 1
	ldh [hBattleTurn], a
	ld h, b
	ld l, c
	ld [hl], 0
	inc hl
	ld [hl], $a
	push hl
	ld hl, RageBuildingText
	call PrintText
	pop hl
	xor a
	ld [hld], a
	ld a, $63
	ld [hl], a
	ldh a, [hBattleTurn]
	xor 1
	ldh [hBattleTurn], a
	ret

RageBuildingText:
	text "<USER>の　いかりの"
	line "ボルテージが　あがっていく！"
	prompt

asm_357a9:
	ld a, [wca7b]
	ld l, a
	ld a, [wca7c]
	ld h, a
	ld a, $ff
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
	jr z, .done

	ld c, STAT_DEF
	call sub_35952

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
	jr .done

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
	jr z, .done

	ld c, 6
	call sub_35952

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

.done:
	ld a, [hli]
	ld l, [hl]
	ld h, a
	or b
	jr z, asm_3584c
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
	jr nz, asm_3584c
	inc l

asm_3584c:
	ld b, l
	ld a, [wBattleMonLevel]
	ld e, a
	ld a, [wCriticalHit]
	and a
	jr z, asm_35859
	sla e

asm_35859:
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
	jr nc, asm_358a4
	ld hl, wBattleMonDefense
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld a, [wPlayerSubStatus5]
	bit 2, a
	jr z, asm_35880
	sla c
	rl b

asm_35880:
	ld hl, wEnemyMonAttack
	ld a, [wCriticalHit]
	and a
	jr z, asm_358d7
	ld hl, wPartyMon1Defense
	ld a, [wCurBattleMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [hli]
	ld b, a
	ld c, [hl]
	push bc
	ld c, 2
	call sub_35952
	ld hl, hQuotient + 2
	pop bc
	jr asm_358d7

asm_358a4:
	ld hl, wBattleMonSpclDef
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld a, [wPlayerSubStatus5]
	bit 1, a
	jr z, asm_358b5
	sla c
	rl b

asm_358b5:
	ld hl, wEnemyMonSpclAtk
	ld a, [wCriticalHit]
	and a
	jr z, asm_358d7
	ld hl, wPartyMon1SpclDef
	ld a, [wCurBattleMon]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [hli]
	ld b, a
	ld c, [hl]
	push bc
	ld c, 5
	call sub_35952
	ld hl, hQuotient + 2
	pop bc

asm_358d7:
	ld a, [hli]
	ld l, [hl]
	ld h, a
	or b
	jr z, asm_358f2
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
	jr nz, asm_358f2
	inc l

asm_358f2:
	ld b, l
	ld a, [wEnemyMonLevel]
	ld e, a
	ld a, [wCriticalHit]
	and a
	jr z, asm_358ff
	sla e

asm_358ff:
	ld a, 1
	and a
	and a
	ret

sub_35904:
	xor a
	ld hl, wCurDamage
	ld [hli], a
	ld [hl], a
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonDefense
	ld de, wPlayerSubStatus5
	ld a, [wBattleMonLevel]
	jr z, asm_35921
	ld hl, wEnemyMonDefense
	ld de, wEnemySubStatus5
	ld a, [wEnemyMonLevel]

asm_35921:
	push af
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld a, [de]
	bit 2, a
	jr z, asm_3592e
	sla c
	rl b

asm_3592e:
	dec hl
	dec hl
	dec hl
	ld a, [hli]
	ld l, [hl]
	ld h, a
	or b
	jr z, asm_3594c
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
	jr nz, asm_3594c
	inc l

asm_3594c:
	ld b, l
	ld d, $28
	pop af
	ld e, a
	ret

sub_35952:
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
	ld hl, wTempMonExp + 2
	predef CalcMonStatC
	pop de
	ret

sub_3599d:
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStructEffect]
	jr z, asm_359a8
	ld a, [wEnemyMoveStructEffect]

asm_359a8:
	cp 7
	jr nz, asm_359b1
	srl c
	jr nz, asm_359b1
	inc c

asm_359b1:
	cp $1d
	jr z, asm_359bc
	cp $1e
	jr z, asm_359bc
	ld a, d
	and a
	ret z

asm_359bc:
	xor a
	ld hl, hProduct
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld a, e
	add a
	jr nc, asm_359cc
	push af
	ld a, 1
	ld [hl], a
	pop af

asm_359cc:
	inc hl
	ld [hli], a
	ld a, 5
	ld [hld], a
	push bc
	ld b, 4
	call Divide
	pop bc
	inc [hl]
	inc [hl]
	inc hl
	ld [hl], d
	call Multiply
	ld [hl], b
	call Multiply
	ld [hl], c
	ld b, 4
	call Divide
	ld [hl], $32
	ld b, 4
	call Divide
	call GetUserItem
	ld hl, Data35a7d

asm_359f6:
	ld a, [hli]
	cp $ff
	jr z, asm_35a1f
	cp b
	ld a, [hli]
	jr nz, asm_359f6
	ld b, a
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStructType]
	jr z, asm_35a0b
	ld a, [wEnemyMoveStructType]

asm_35a0b:
	cp b
	jr nz, asm_35a1f
	ld a, c
	add $64
	ldh [hMultiplier], a
	call Multiply
	ld a, $64
	ldh [hMultiplier], a
	ld b, 4
	call Divide

asm_35a1f:
	ld hl, wCurDamage
	ld b, [hl]
	ldh a, [hQuotient + 3]
	add b
	ldh [hQuotient + 3], a
	jr nc, asm_35a32
	ldh a, [hQuotient + 2]
	inc a
	ldh [hQuotient + 2], a
	and a
	jr z, asm_35a66

asm_35a32:
	ldh a, [hQuotient]
	ld b, a
	ldh a, [hQuotient + 1]
	or a
	jr nz, asm_35a66
	ldh a, [hQuotient + 2]
	cp 3
	jr c, asm_35a4a
	cp 4
	jr nc, asm_35a66
	ldh a, [hQuotient + 3]
	cp $e6
	jr nc, asm_35a66

asm_35a4a:
	inc hl
	ldh a, [hQuotient + 3]
	ld b, [hl]
	add b
	ld [hld], a
	ldh a, [hQuotient + 2]
	ld b, [hl]
	adc b
	ld [hl], a
	jr c, asm_35a66
	ld a, [hl]
	cp 3
	jr c, asm_35a6c
	cp 4
	jr nc, asm_35a66
	inc hl
	ld a, [hld]
	cp $e6
	jr c, asm_35a6c

asm_35a66:
	ld a, 3
	ld [hli], a
	ld a, $e5
	ld [hld], a

asm_35a6c:
	inc hl
	ld a, [hl]
	add 2
	ld [hld], a
	jr nc, asm_35a74
	inc [hl]

asm_35a74:
	ld a, 1
	and a
	ret

unknown_35a78:
	db MOVE_KARATE_CHOP
	db MOVE_RAZOR_LEAF
	db MOVE_CRABHAMMER
	db MOVE_SLASH
	db -1

Data35a7d:
	dw $32
	dw $133
	dw $234
	dw $335
	dw $436
	dw $537
	dw $738
	dw $839
	dw $143a
	dw $153b
	dw $163c
	dw $173d
	dw $183e
	dw $193f
	dw $1a40
	db $ff

asm_35a9c:
	ld hl, wBattleMonLevel
	ld de, wPlayerMoveStructEffect
	ldh a, [hBattleTurn]
	and a
	jr z, asm_35aad
	ld hl, wEnemyMonLevel
	ld de, wEnemyMoveStructEffect

asm_35aad:
	ld a, [de]
	cp $57
	ld b, [hl]
	ld a, 0
	jr z, asm_35afd
	ld a, [de]
	cp $58
	jr z, asm_35ac9
	cp $28
	jr z, asm_35adc
	cp $63
	jr z, asm_35b03
	inc de
	ld a, [de]
	ld b, a
	ld a, 0
	jr asm_35afd

asm_35ac9:
	ld a, b
	srl a
	add b
	ld b, a

asm_35ace:
	call BattleRandom
	and a
	jr z, asm_35ace
	cp b
	jr nc, asm_35ace
	ld b, a
	ld a, 0
	jr asm_35afd

asm_35adc:
	ld hl, wEnemyMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, asm_35ae7
	ld hl, wBattleMonHP

asm_35ae7:
	ld a, [hli]
	srl a
	ld b, a
	ld a, [hl]
	rr a
	push af
	ld a, b
	pop bc
	and a
	jr nz, asm_35afd
	or b
	ld a, 0
	jr nz, asm_35afd
	ld b, 1
	jr asm_35afd

asm_35afd:
	ld hl, wCurDamage
	ld [hli], a
	ld [hl], b
	ret

asm_35b03:
	ld hl, wBattleMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, asm_35b0e
	ld hl, wEnemyMonHP

asm_35b0e:
	xor a
	ldh [hProduct], a
	ldh [hMultiplicand], a
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hli]
	ldh [hMultiplicand + 2], a
	ld a, $30
	ldh [hMultiplier], a
	call Multiply
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ldh [hDivisor], a
	ld a, b
	and a
	jr z, asm_35b47
	ldh a, [hDivisor]
	srl b
	rr a
	srl b
	rr a
	ldh [hDivisor], a
	ldh a, [hDividend + 2]
	ld b, a
	srl b
	ldh a, [hDividend + 3]
	rr a
	srl b
	rr a
	ldh [hDividend + 3], a
	ld a, b
	ldh [hDividend + 2], a

asm_35b47:
	ld b, 4
	call Divide
	ldh a, [hQuotient + 3]
	ld b, a
	ld hl, Data35b78

asm_35b52:
	ld a, [hli]
	cp b
	jr nc, asm_35b59
	inc hl
	jr asm_35b52

asm_35b59:
	ldh a, [hBattleTurn]
	and a
	ld a, [hl]
	jr nz, asm_35b69
	ld hl, wPlayerMoveStructPower
	ld [hl], a
	push hl
	call PlayerAttackDamage
	jr asm_35b71

asm_35b69:
	ld hl, wEnemyMoveStructPower
	ld [hl], a
	push hl
	call EnemyAttackDamage

asm_35b71:
	call sub_3599d
	pop hl
	ld [hl], 1
	ret

Data35b78:
	db $1
	db $c8
	db $4
	db $96
	db $9
	db $64
	db $10
	db $50
	db $20
	db $28
	db $30
	db $14

asm_35b84:
	ldh a, [hBattleTurn]
	and a
	ld hl, wCurEnemySelectedMove
	ld de, wEnemyMoveStructPower
	jr z, asm_35b95
	ld hl, wCurPlayerSelectedMove
	ld de, wPlayerMoveStructPower

asm_35b95:
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
	cp $14
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
	jr nc, asm_35bb8
	ld a, $ff
	ld [hli], a
	ld [hl], a

asm_35bb8:
	xor a
	ld [wca3a], a
	ret

asm_35bbd:
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemySubStatus5
	ld de, wca51
	ld a, [wCurEnemyMove]
	jr z, asm_35bd4
	ld hl, wPlayerSubStatus5
	ld de, wca49
	ld a, [wCurPlayerMove]

asm_35bd4:
	and a
	jr z, asm_35bf5
	bit 4, [hl]
	jr nz, asm_35bf5
	ld a, [wca3a]
	and a
	jr nz, asm_35bf5
	set 4, [hl]
	call BattleRandom
	and 3
	inc a
	inc a
	inc a
	ld [de], a
	call LoadMoveAnim
	ld hl, GotAnEncoreText
	jp PrintText

asm_35bf5:
	call BattleCommand_MoveDelay
	jp asm_374b1

GotAnEncoreText:
	text "<TARGET>は"
	line "アンコールを　うけた！"
	prompt

asm_35c0b:
	ld a, [wca3a]
	and a
	jp nz, asm_35ca9
	call CheckSubstituteOpp
	jp nz, asm_35ca9
	call LoadMoveAnim
	ld hl, wBattleMonMaxHP + 1
	ld de, wEnemyMonMaxHP + 1
	call sub_35c59
	ld a, 1
	ld [wWhichHPBar], a
	ld hl, wTileMap + 190
	predef UpdateHPBar
	ld hl, wEnemyMonHP
	ld a, [hli]
	ld [wcdc6], a
	ld a, [hli]
	ld [wHPBarOldHP], a
	ld a, [hli]
	ld [wPlayerEffectivenessVsEnemyMons], a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	call sub_35c88
	xor a
	ld [wWhichHPBar], a
	ld hl, wTileMap + 42
	predef UpdateHPBar
	ld hl, SharedPainText
	jp PrintText

sub_35c59:
	ld a, [hld]
	ld [wHPBarMaxHP], a
	ld a, [hld]
	ld [wPlayerEffectivenessVsEnemyMons], a
	ld a, [hld]
	ld b, a
	ld [wHPBarOldHP], a
	ld a, [hl]
	ld [wcdc6], a
	dec de
	dec de
	ld a, [de]
	dec de
	add b
	ld [wCurDamage + 1], a
	ld b, [hl]
	ld a, [de]
	adc b
	srl a
	ld [wCurDamage], a
	ld a, [wCurDamage + 1]
	rr a
	ld [wCurDamage + 1], a
	inc hl
	inc hl
	inc hl
	inc de
	inc de
	inc de

sub_35c88:
	ld c, [hl]
	dec hl
	ld a, [wCurDamage + 1]
	sub c
	ld b, [hl]
	dec hl
	ld a, [wCurDamage]
	sbc b
	jr nc, asm_35c9e
	ld a, [wCurDamage]
	ld b, a
	ld a, [wCurDamage + 1]
	ld c, a

asm_35c9e:
	ld a, c
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, b
	ld [hli], a
	ld [wcdc8], a
	ret

asm_35ca9:
	call BattleCommand_MoveDelay
	jp asm_374b1

SharedPainText:
	text "おたがいの　たいりょくを"
	line "わかちあった！"
	prompt

asm_35cc5:
	ld hl, wBattleMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, asm_35cd0
	ld hl, wBattleMonStatus

asm_35cd0:
	ld a, [hl]
	and 7
	ret nz
	inc a
	ld [wca3a], a
	ret

asm_35cd9:
	ld hl, wEnemyMonType
	ldh a, [hBattleTurn]
	and a
	jr z, asm_35ce4
	ld hl, wBattleMonType

asm_35ce4:
	ld a, [wca3a]
	and a
	jr nz, asm_35d2e
	call LoadMoveAnim
	ld a, [hli]
	ld b, a
	ld c, [hl]

asm_35cf0:
	call BattleRandom
	and $1f
	cp b
	jr z, asm_35cf0
	cp c
	jr z, asm_35cf0
	cp 9
	jr c, asm_35d09
	cp $14
	jr c, asm_35cf0
	cp $1b
	jr c, asm_35d09
	jr asm_35cf0

asm_35d09:
	ld [hld], a
	ld [hl], a
	ld [wNumSetBits], a
	predef GetTypeName
	ld hl, TransformedTypeText
	jp PrintText

TransformedTypeText:
	text "<TARGET>の　タイプを"
	line "@"
	text_from_ram wStringBuffer1
	text "に　かえた！"
	prompt

asm_35d2e:
	jp asm_374b1

asm_35d31:
	ld hl, wEnemySubStatus5
	ldh a, [hBattleTurn]
	and a
	jr z, asm_35d3c
	ld hl, wPlayerSubStatus5

asm_35d3c:
	ld a, [wca3a]
	and a
	jr nz, asm_35d53
	call CheckSubstituteOpp
	jp nz, asm_35d53
	set 5, [hl]
	call LoadMoveAnim
	ld hl, TookAimText
	jp PrintText

asm_35d53:
	call BattleCommand_MoveDelay
	jp asm_374b1

TookAimText:
	text "<TARGET>を"
	line "ロックオンした！"
	prompt

asm_35d66:
	ld a, [wLinkMode]
	cp 3
	jr z, asm_35d95
	call CheckSubstituteOpp
	jp nz, asm_35d95
	ld hl, wBattleMonMoves
	ld a, [wcd40]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wCurEnemyMove]
	ld [hl], a
	ld hl, wPartyMon1Moves
	add hl, bc
	ld [hl], a
	ld [wNumSetBits], a
	call Unreferenced_GetMoveName
	call LoadMoveAnim
	ld hl, SketchedText
	jp PrintText

asm_35d95:
	call BattleCommand_MoveDelay
	jp asm_374b1

SketchedText:
	text "<USER>は"
	line "@"
	text_from_ram wStringBuffer1
	text "を　ダビングした！"
	prompt

asm_35dae:
	call LoadMoveAnim
	ld hl, wPlayerMoveStructEffect
	ld de, wEnemyMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, asm_35dc2
	ld hl, wEnemyMoveStructEffect
	ld de, wBattleMonStatus

asm_35dc2:
	push hl
	call sub_364a2
	pop hl
	ld a, [hl]
	push hl
	push af
	ld a, $a
	ld [hl], a
	call Function365bf
	pop af
	pop hl
	ld [hl], a
	ret

asm_35dd4:
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonMoves + 1
	ld de, wCurPlayerSelectedMove
	ld bc, wPlayerMoveStruct
	ld a, [wBattleMonStatus]
	jr z, asm_35df1
	ld hl, wEnemyMonMoves + 1
	ld de, wCurEnemySelectedMove
	ld bc, wEnemyMoveStruct
	ld a, [wEnemyMonStatus]

asm_35df1:
	and 7
	jr z, asm_35e2a
	ld a, [wca3a]
	and a
	jr nz, asm_35e2a
	ld a, [hl]
	and a
	jr z, asm_35e2a
	dec hl

asm_35e00:
	push hl
	call BattleRandom
	and 3
	push bc
	ld c, a
	ld b, 0
	add hl, bc
	pop bc
	ld a, [hl]
	pop hl
	and a
	jr z, asm_35e00
	push de
	ld d, a
	ld a, [bc]
	cp d
	ld a, d
	pop de
	jr z, asm_35e00
	ld [de], a
	call LoadMoveAnim
	push bc
	call UpdateMoveData
	pop bc
	inc bc
	ld a, [bc]
	call DoMove
	jp asm_357a9

asm_35e2a:
	call BattleCommand_MoveDelay
	jp asm_374b1

asm_35e30:
	ld hl, wPlayerSubStatus5
	ldh a, [hBattleTurn]
	and a
	jr z, asm_35e3b
	ld hl, wEnemySubStatus5

asm_35e3b:
	set 6, [hl]
	call LoadMoveAnim
	ld hl, DestinyBondEffectText
	jp PrintText

DestinyBondEffectText:
	text "<USER>は　あいてを"
	line "みちずれに　しようとしている"
	prompt

asm_35e5e:
	ld a, [wca3a]
	and a
	jr nz, asm_35ec4
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyMonMoves
	ld de, wOTPartyMon1PP
	ld a, [wCurEnemyMove]
	jr z, asm_35e7b
	ld hl, wBattleMonMoves
	ld de, wPartyMon1PP
	ld a, [wCurPlayerMove]

asm_35e7b:
	and a
	jr z, asm_35ec4
	cp $a5
	jr z, asm_35ec4
	ld b, a
	ld c, $ff

asm_35e85:
	inc c
	ld a, [hli]
	cp b
	jr nz, asm_35e85
	ld [wNumSetBits], a
	dec hl
	ld b, 0
	push bc
	ld c, 6
	add hl, bc
	pop bc
	ld a, [hl]
	and $3f
	jr z, asm_35ec4
	push bc
	push de
	call Unreferenced_GetMoveName
	pop de
	call BattleRandom
	and 3
	inc a
	inc a
	ld b, a
	ld a, [hl]
	and $3f
	cp b
	jr nc, asm_35eaf
	ld b, a

asm_35eaf:
	ld a, b
	ld [wNumSetBits], a
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

asm_35ec4:
	call BattleCommand_MoveDelay
	jp asm_374b1

SpiteEffectText:
	text "<TARGET>の"
	line "@"
	text_from_ram wStringBuffer1
	text "を　@"
	deciram wTempByteValue, 1, 1
	text "けずった！"
	prompt

sub_35ee1:
	ld de, wEnemyMonHP + 1
	ldh a, [hBattleTurn]
	and a
	jr z, asm_35eec
	ld de, wBattleMonHP + 1

asm_35eec:
	ld hl, wCurDamage + 1
	ld a, [de]
	dec de
	sub [hl]
	dec hl
	ld a, [de]
	sbc [hl]
	jr z, asm_35efb
	jr c, asm_35f03
	jr asm_35f11

asm_35efb:
	inc hl
	inc de
	ld a, [de]
	cp [hl]
	jr nz, asm_35f11
	dec hl
	dec de

asm_35f03:
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hl], a
	dec [hl]
	ld a, [hl]
	inc a
	jr nz, asm_35f0f
	dec hl
	dec [hl]

asm_35f0f:
	scf
	ret

asm_35f11:
	and a
	ret

asm_35f13:
	ld hl, wBattleMonStatus
	ld de, wPlayerSubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, asm_35f24
	ld hl, wEnemyMonStatus
	ld de, wEnemySubStatus1

asm_35f24:
	ld a, [hli]
	or [hl]
	jr z, asm_35f38
	xor a
	ld [hld], a
	ld [hl], a
	ld a, [de]
	res 0, a
	ld [de], a
	call LoadMoveAnim
	ld hl, text_35f3e
	jp PrintText

asm_35f38:
	call BattleCommand_MoveDelay
	jp asm_3746a

text_35f3e:
	db $0
	db $5a
	db $c9
	db $4f
	db $8c
	db $92
	db $e3
	db $8f
	db $8c
	db $b2
	db $2c
	db $e2
	db $b3
	db $26
	db $7f
	db $c5
	db $b5
	db $df
	db $c0
	db $e7
	db $58

sub_35f53:
	ld a, e
	ld [wFXAnimID], a
	ld a, d
	ld [wFXAnimID + 1], a
	ld c, 3
	call DelayFrames
	jpfar PlayBattleAnim

sub_35f68:
	ld hl, wCurDamage
	ld a, [hli]
	ld b, a
	ld a, [hl]
	or b
	jr z, asm_35fc3
	ld a, [wEnemySubStatus4]
	bit 4, a
	jp nz, asm_3602a
	ld a, [hld]
	ld b, a
	ld a, [wEnemyMonHP + 1]
	ld [wHPBarOldHP], a
	sub b
	ld [wEnemyMonHP + 1], a
	ld a, [hl]
	ld b, a
	ld a, [wEnemyMonHP]
	ld [wcdc6], a
	sbc b
	ld [wEnemyMonHP], a
	jr nc, asm_35fa1
	ld a, [wcdc6]
	ld [hli], a
	ld a, [wHPBarOldHP]
	ld [hl], a
	xor a
	ld hl, wEnemyMonHP
	ld [hli], a
	ld [hl], a

asm_35fa1:
	ld hl, wEnemyMonMaxHP
	ld a, [hli]
	ld [wPlayerEffectivenessVsEnemyMons], a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld hl, wEnemyMonHP
	ld a, [hli]
	ld [wcdc8], a
	ld a, [hl]
	ld [wHPBarNewHP], a
	ld hl, wTileMap + 42
	xor a
	ld [wWhichHPBar], a
	predef UpdateHPBar

asm_35fc3:
	ld hl, DrawHUDsAndHPBars
	jp CallFromBank0F

sub_35fc9:
	ld hl, wCurDamage
	ld a, [hli]
	ld b, a
	ld a, [hl]
	or b
	jr z, asm_36024
	ld a, [wPlayerSubStatus4]
	bit 4, a
	jp nz, asm_3602a
	ld a, [hld]
	ld b, a
	ld a, [wBattleMonHP + 1]
	ld [wHPBarOldHP], a
	sub b
	ld [wBattleMonHP + 1], a
	ld [wHPBarNewHP], a
	ld b, [hl]
	ld a, [wBattleMonHP]
	ld [wcdc6], a
	sbc b
	ld [wBattleMonHP], a
	ld [wcdc8], a
	jr nc, asm_3600c
	ld a, [wcdc6]
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

asm_3600c:
	ld hl, wBattleMonMaxHP
	ld a, [hli]
	ld [wPlayerEffectivenessVsEnemyMons], a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld hl, wTileMap + 190
	ld a, 1
	ld [wWhichHPBar], a
	predef UpdateHPBar

asm_36024:
	ld hl, DrawHUDsAndHPBars
	jp CallFromBank0F

asm_3602a:
	ld hl, text_36084
	call PrintText
	ld de, wcabd
	ld bc, wEnemySubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36041
	ld de, wcabc
	ld bc, wPlayerSubStatus4

asm_36041:
	ld hl, wCurDamage
	ld a, [hli]
	and a
	jr nz, asm_3604c
	ld a, [de]
	sub [hl]
	ld [de], a
	ret nc

asm_3604c:
	ld h, b
	ld l, c
	res 4, [hl]
	ld hl, text_3609e
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
	ld a, $a4
	call LoadBattleAnim
	pop af
	ldh [hBattleTurn], a
	ldh a, [hBattleTurn]
	ld hl, wPlayerMoveStructEffect
	and a
	jr z, asm_3607c
	ld hl, wEnemyMoveStructEffect

asm_3607c:
	xor a
	ld [hl], a
	ld hl, DrawHUDsAndHPBars
	jp CallFromBank0F

text_36084:
	db $0
	db $59
	db $c6
	db $7f
	db $b6
	db $dc
	db $df
	db $c3
	db $4f
	db $3c
	db $de
	db $bc
	db $de
	db $26
	db $7f
	db $ba
	db $b3
	db $29
	db $b7
	db $dd
	db $7f
	db $b3
	db $b9
	db $c0
	db $e7
	db $58

text_3609e:
	db $0
	db $59
	db $c9
	db $7f
	db $3c
	db $de
	db $bc
	db $de
	db $ca
	db $4f
	db $b7
	db $b4
	db $c3
	db $bc
	db $cf
	db $df
	db $c0
	db $56
	db $58

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
	cp HELD_2
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
	and $7f
	cp EFFECTIVE
	ld hl, DoesntAffectTarget
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
	
	ld a, [wca3a]
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
	cp HELD_2
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

asm_3622a:
	ld de, wEnemyMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36235
	ld de, wBattleMonStatus

asm_36235:
	call CheckSubstituteOpp
	ret nz
	ld a, [de]
	and a
	ret nz
	ld a, [wTypeModifier]
	and $7f
	cp $a
	ret c
	call GetOpponentItem
	ld a, b
	cp $14
	ret z
	call BattleCommand_EffectChance
	ret nc
	call SafeCheckSafeguard
	ret nz
	ld a, [de]
	set 3, a
	ld [de], a
	push de
	ld de, $0106
	call PlayOpponentBattleAnim
	ld hl, DrawHUDsAndHPBars
	call CallFromBank0F
	ld hl, text_3628d
	call PrintText
	pop de
	call GetOpponentItem
	ld a, b
	cp $a
	jr z, asm_3627c
	cp $f
	jr z, asm_3627c
	cp 2
	jr z, asm_3627c
	ret

asm_3627c:
	ld a, [de]
	res 3, a
	ld [de], a
	ld a, [hl]
	call PrintRecoveredUsingItem
	call ConsumeHeldItem
	ld hl, DrawHUDsAndHPBars
	jp CallFromBank0F

text_3628d:
	db $0
	db $59
	db $ca
	db $7f
	db $34
	db $b8
	db $dd
	db $b1
	db $3b
	db $c0
	db $e7
	db $58

asm_36299:
	ld de, wEnemyMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, asm_362a4
	ld de, wBattleMonStatus

asm_362a4:
	ld hl, DoesntAffectTarget
	ld a, [wTypeModifier]
	and $7f
	cp $a
	jp c, asm_3634b
	ld hl, text_36351
	ld a, [de]
	bit 3, a
	jp nz, asm_3634b
	call GetOpponentItem
	ld a, b
	cp $14
	jr nz, asm_362ce
	ld a, [hl]
	ld [wNumSetBits], a
	call GetItemName
	ld hl, ProtectedByText
	jr asm_3634b

asm_362ce:
	ld hl, DidntAffectText
	and a
	jr nz, asm_3634b
	call CheckSubstituteOpp
	jr nz, asm_3634b
	ld a, [wca3a]
	and a
	jr nz, asm_3634b
	ld a, [de]
	set 3, a
	ld [de], a
	push de
	call sub_36331
	jr z, asm_362f4
	call PlayDamageAnim
	ld hl, text_3628d
	call PrintText
	jr asm_36307

asm_362f4:
	set 0, [hl]
	xor a
	ld [de], a
	call PlayDamageAnim
	ld hl, DrawHUDsAndHPBars
	call CallFromBank0F
	ld hl, text_36363
	call PrintText

asm_36307:
	pop de
	call GetOpponentItem
	ld a, b
	cp $a
	jr z, asm_36319
	cp $f
	jr z, asm_36319
	cp 2
	jr z, asm_36319
	ret

asm_36319:
	ld a, [de]
	res 3, a
	ld [de], a
	ld a, [hl]
	call PrintRecoveredUsingItem
	call ConsumeHeldItem
	ld hl, DrawHUDsAndHPBars
	call CallFromBank0F
	call sub_36331
	ret nz
	res 0, [hl]
	ret

sub_36331:
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStructEffect]
	ld hl, wEnemySubStatus5
	ld de, wca4f
	jr z, asm_36348
	ld a, [wEnemyMoveStructEffect]
	ld hl, wPlayerSubStatus5
	ld de, wca47

asm_36348:
	cp $21
	ret

asm_3634b:
	call BattleCommand_MoveDelay
	jp PrintText

text_36351:
	db $0
	db $59
	db $ca
	db $7f
	db $bd
	db $33
	db $c6
	db $4f
	db $34
	db $b8
	db $dd
	db $7f
	db $b1
	db $3b
	db $c3
	db $b2
	db $d9
	db $58

text_36363:
	db $0
	db $59
	db $ca
	db $4f
	db $d3
	db $b3
	db $34
	db $b8
	db $dd
	db $b1
	db $3b
	db $c0
	db $e7
	db $58

asm_36371:
	call sub_363a3
	ld hl, text_3637a
	jp PrintText

text_3637a:
	db $0
	db $59
	db $b6
	db $d7
	db $4f
	db $c0
	db $b2
	db $d8
	db $e2
	db $b8
	db $dd
	db $7f
	db $bd
	db $b2
	db $c4
	db $df
	db $c0
	db $e7
	db $58

asm_3638d:
	call sub_363a3
	ld hl, text_36396
	jp PrintText

text_36396:
	db $0
	db $59
	db $c9
	db $4f
	db $d5
	db $d2
	db $dd
	db $7f
	db $b8
	db $df
	db $c0
	db $e7
	db $58

sub_363a3:
	ld hl, wCurDamage
	ld a, [hl]
	srl a
	ld [hli], a
	ld a, [hl]
	rr a
	ld [hld], a
	or [hl]
	jr nz, asm_363b3
	inc hl
	inc [hl]

asm_363b3:
	ld hl, wBattleMonHP
	ld de, wBattleMonMaxHP
	ldh a, [hBattleTurn]
	and a
	jp z, asm_363c5
	ld hl, wEnemyMonHP
	ld de, wEnemyMonMaxHP

asm_363c5:
	ld bc, wcdc6
	ld a, [hli]
	ld [bc], a
	ld a, [hl]
	dec bc
	ld [bc], a
	ld a, [de]
	dec bc
	ld [bc], a
	inc de
	ld a, [de]
	dec bc
	ld [bc], a
	ld a, [wCurDamage + 1]
	ld b, [hl]
	add b
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [wCurDamage]
	ld b, [hl]
	adc b
	ld [hli], a
	ld [wcdc8], a
	jr c, asm_363f4
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
	jr nc, asm_36400

asm_363f4:
	ld a, [de]
	ld [hld], a
	ld [wHPBarNewHP], a
	dec de
	ld a, [de]
	ld [hli], a
	ld [wcdc8], a
	inc de

asm_36400:
	ldh a, [hBattleTurn]
	and a
	ld hl, wTileMap + 190
	ld a, 1
	jr z, asm_3640e
	ld hl, wTileMap + 42
	xor a

asm_3640e:
	ld [wWhichHPBar], a
	predef UpdateHPBar
	predef Function3d5ce
	predef Function3d67c
	ld hl, sub_3d3f4
	jp CallFromBank0F

asm_36426:
	xor a
	ld [wNumHits], a
	call CheckSubstituteOpp
	ret nz
	ld de, wEnemyMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36439
	ld de, wBattleMonStatus

asm_36439:
	ld a, [de]
	and a
	jp nz, sub_364a2
	ld a, [wTypeModifier]
	and $7f
	cp $a
	ret c
	call GetOpponentItem
	ld a, b
	cp $15
	ret z
	call BattleCommand_EffectChance
	ret nc
	call SafeCheckSafeguard
	ret nz
	ld a, [de]
	set 4, a
	ld [de], a
	push de
	ld hl, asm_3e291
	call CallFromBank0F
	ld de, $0105
	call PlayOpponentBattleAnim
	ld hl, DrawHUDsAndHPBars
	call CallFromBank0F
	ld hl, text_36495
	call PrintText
	call GetOpponentItem
	ld a, b
	pop de
	cp $b
	jr z, asm_36484
	cp $f
	jr z, asm_36484
	cp 2
	jr z, asm_36484
	ret

asm_36484:
	ld a, [de]
	res 4, a
	ld [de], a
	ld a, [hl]
	call PrintRecoveredUsingItem
	call ConsumeHeldItem
	ld hl, DrawHUDsAndHPBars
	jp CallFromBank0F

text_36495:
	db $0
	db $59
	db $ca
	db $4f
	db $d4
	db $b9
	db $34
	db $dd
	db $b5
	db $df
	db $c0
	db $e7
	db $58

sub_364a2:
	ld a, [de]
	and $20
	ret z
	xor a
	ld [de], a
	ldh a, [hBattleTurn]
	and a
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Status
	jr z, asm_364b9
	ld hl, wPartyMon1Status
	ld a, [wCurBattleMon]

asm_364b9:
	ld bc, $30
	call AddNTimes
	xor a
	ld [hl], a
	ld hl, text_364c7
	jp PrintText

text_364c7:
	db $0
	db $ce
	db $c9
	db $b5
	db $dd
	db $b1
	db $3b
	db $c3
	db $59
	db $c9
	db $4f
	db $ba
	db $b5
	db $d8
	db $26
	db $7f
	db $c4
	db $b9
	db $c0
	db $e7
	db $58

asm_364dc:
	xor a
	ld [wNumHits], a
	call CheckSubstituteOpp
	ret nz
	ld de, wEnemyMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, asm_364ef
	ld de, wBattleMonStatus

asm_364ef:
	ld a, [de]
	and a
	ret nz
	ld a, [wTypeModifier]
	and $7f
	cp $a
	ret c
	call GetOpponentItem
	ld a, b
	cp $16
	ret z
	call BattleCommand_EffectChance
	ret nc
	call SafeCheckSafeguard
	ret nz
	ld a, [de]
	set 5, a
	ld [de], a
	push de
	call sub_36ffd
	ld de, $0108
	call PlayOpponentBattleAnim
	ld hl, DrawHUDsAndHPBars
	call CallFromBank0F
	ld hl, text_36546
	call PrintText
	call GetOpponentItem
	ld a, b
	pop de
	cp $c
	jr z, asm_36535
	cp $f
	jr z, asm_36535
	cp 2
	jr z, asm_36535
	ret

asm_36535:
	ld a, [de]
	res 5, a
	ld [de], a
	ld a, [hl]
	call PrintRecoveredUsingItem
	call ConsumeHeldItem
	ld hl, DrawHUDsAndHPBars
	jp CallFromBank0F

text_36546:
	db $0
	db $59
	db $ca
	db $4f
	db $ba
	db $b5
	db $d8
	db $32
	db $b9
	db $c6
	db $c5
	db $df
	db $c0
	db $e7
	db $58

asm_36555:
	xor a
	ld [wNumHits], a
	call CheckSubstituteOpp
	ret nz
	ld de, wEnemyMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36568
	ld de, wBattleMonStatus

asm_36568:
	ld a, [de]
	and a
	ret nz
	ld a, [wTypeModifier]
	and $7f
	cp $a
	ret c
	call GetOpponentItem
	ld a, b
	cp $18
	ret z
	call BattleCommand_EffectChance
	ret nc
	call SafeCheckSafeguard
	ret nz
	ld a, [de]
	set 6, a
	ld [de], a
	push de
	ld hl, sub_3e254
	call CallFromBank0F
	ld de, $0109
	call PlayOpponentBattleAnim
	ld hl, DrawHUDsAndHPBars
	call CallFromBank0F
	call sub_374db
	call GetOpponentItem
	ld a, b
	pop de
	cp $e
	jr z, asm_365ae
	cp $f
	jr z, asm_365ae
	cp 2
	jr z, asm_365ae
	ret

asm_365ae:
	ld a, [de]
	res 6, a
	ld [de], a
	ld a, [hl]
	call PrintRecoveredUsingItem
	call ConsumeHeldItem
	ld hl, DrawHUDsAndHPBars
	jp CallFromBank0F

Function365bf:
	ld hl, wcaa9
	ld de, wPlayerMoveStructEffect
	ldh a, [hBattleTurn]
	and a
	jr z, asm_365d0
	ld hl, wcab1
	ld de, wEnemyMoveStructEffect

asm_365d0:
	ld a, [de]
	sub $a
	cp 8
	jr c, asm_365d9
	sub $28

asm_365d9:
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	inc b
	ld a, $d
	cp b
	jp c, asm_366ac
	ld a, [de]
	cp $12
	jr c, asm_365f1
	inc b
	ld a, $d
	cp b
	jr nc, asm_365f1
	ld b, a

asm_365f1:
	ld [hl], b
	ld a, c
	cp 4
	jr nc, asm_36661
	push hl
	ld hl, wBattleMonAttack + 1
	ld de, wca93
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36609
	ld hl, wEnemyMonAttack + 1
	ld de, wca9e

asm_36609:
	push bc
	sla c
	ld b, 0
	add hl, bc
	ld a, c
	add e
	ld e, a
	jr nc, asm_36615
	inc d

asm_36615:
	pop bc
	ld a, [hld]
	sub $e7
	jr nz, asm_36621
	ld a, [hl]
	sbc 3
	jp z, asm_366aa

asm_36621:
	push hl
	push bc
	ld hl, Data3687a
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
	sub $e7
	ldh a, [hQuotient + 2]
	sbc 3
	jp c, asm_3665a
	ld a, 3
	ldh [hQuotient + 2], a
	ld a, $e7
	ldh [hQuotient + 3], a

asm_3665a:
	ldh a, [hQuotient + 2]
	ld [hli], a
	ldh a, [hQuotient + 3]
	ld [hl], a
	pop hl

asm_36661:
	ld b, c
	inc b
	call sub_3682e

asm_36666:
	ld hl, wPlayerSubStatus4
	ld de, wPlayerMoveStruct
	ld bc, wcadc
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3667d
	ld hl, wEnemySubStatus4
	ld de, wEnemyMoveStruct
	ld bc, wcad8

asm_3667d:
	call sub_35375
	call LoadMoveAnim
	call sub_353ef
	ld a, [de]
	cp $6b
	jr nz, asm_3668f
	pop bc
	ld a, 1
	ld [bc], a

asm_3668f:
	ldh a, [hBattleTurn]
	and a
	ld hl, sub_3e360
	call z, CallFromBank0F
	ld hl, text_366b2
	call PrintText
	ld hl, sub_3e254
	call CallFromBank0F
	ld hl, asm_3e291
	jp CallFromBank0F

asm_366aa:
	pop hl
	dec [hl]

asm_366ac:
	call BattleCommand_MoveDelay
	jp asm_3746a

text_366b2:
	db $0
	db $5a
	db $c9
	db $4f
	db $50
	db $1
	dw wStringBuffer2
	db $0
	db $26
	db $50
	db $8
	ld hl, text_366d3
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStructEffect]
	jr z, asm_366cc
	ld a, [wEnemyMoveStructEffect]

asm_366cc:
	cp $12
	ret nc
	ld hl, text_366db
	ret

text_366d3:
	db $a
	db $0
	db $4c
	db $28
	db $e3
	db $de
	db $c4
	db $50

text_366db:
	db $0
	db $7f
	db $b1
	db $26
	db $df
	db $c0
	db $e7
	db $58

asm_366e3:
	ld hl, wcab1
	ld de, wPlayerMoveStructEffect
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36703
	ld hl, wcaa9
	ld de, wEnemyMoveStructEffect
	ld a, [wLinkMode]
	cp 3
	jr z, asm_36703
	call BattleRandom
	cp $40
	jp c, asm_367f0

asm_36703:
	call CheckSubstituteOpp
	jp nz, asm_367f0
	ld a, [de]
	cp $44
	jr c, asm_36719
	call BattleCommand_EffectChance
	jp nc, asm_367e6
	ld a, [de]
	sub $44
	jr asm_36736

asm_36719:
	push hl
	push de
	call Function351d0
	pop de
	pop hl
	ld a, [wca3a]
	and a
	jp nz, asm_367f0
	call sub_37e0d
	jp nz, asm_367f0
	ld a, [de]
	sub $12
	cp 8
	jr c, asm_36736
	sub $28

asm_36736:
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	dec b
	jp z, asm_367e6
	ld a, [de]
	cp $24
	jr c, asm_3674c
	cp $44
	jr nc, asm_3674c
	dec b
	jr nz, asm_3674c
	inc b

asm_3674c:
	ld [hl], b
	ld a, c
	cp 4
	jr nc, asm_367b9
	push hl
	push de
	ld hl, wEnemyMonAttack + 1
	ld de, wca9e
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36765
	ld hl, wBattleMonAttack + 1
	ld de, wca93

asm_36765:
	push bc
	sla c
	ld b, 0
	add hl, bc
	ld a, c
	add e
	ld e, a
	jr nc, asm_36771
	inc d

asm_36771:
	pop bc
	ld a, [hld]
	sub 1
	jr nz, asm_3677c
	ld a, [hl]
	and a
	jp z, asm_367e3

asm_3677c:
	push hl
	push bc
	ld hl, Data3687a
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
	jp nz, asm_367b1
	ldh [hQuotient + 2], a
	ld a, 1
	ldh [hQuotient + 3], a

asm_367b1:
	ldh a, [hQuotient + 2]
	ld [hli], a
	ldh a, [hQuotient + 3]
	ld [hl], a
	pop de
	pop hl

asm_367b9:
	ld b, c
	inc b
	push de
	call sub_3682e

asm_367bf:
	pop de
	ld a, [de]
	cp $44
	jr nc, asm_367c8
	call PlayDamageAnim

asm_367c8:
	ldh a, [hBattleTurn]
	and a
	ld hl, sub_3e360
	call nz, CallFromBank0F
	ld hl, text_367fa
	call PrintText
	ld hl, sub_3e254
	call nz, CallFromBank0F
	ld hl, asm_3e291
	jp CallFromBank0F

asm_367e3:
	pop de
	pop hl
	inc [hl]

asm_367e6:
	ld a, [de]
	cp $44
	ret nc
	call BattleCommand_MoveDelay
	jp asm_3746a

asm_367f0:
	ld a, [de]
	cp $44
	ret nc
	call BattleCommand_MoveDelay
	jp asm_37494

text_367fa:
	db $0
	db $59
	db $c9
	db $4f
	db $50
	db $1
	dw wStringBuffer2
	db $0
	db $26
	db $50
	db $8
	ld hl, text_36826
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStructEffect]
	jr z, asm_36814
	ld a, [wEnemyMoveStructEffect]

asm_36814:
	cp $1a
	ret c
	cp $44
	ret nc
	ld hl, text_3681e
	ret

text_3681e:
	db $a
	db $0
	db $4c
	db $26
	db $b8
	db $df
	db $c4
	db $50

text_36826:
	db $0
	db $7f
	db $bb
	db $26
	db $df
	db $c0
	db $e7
	db $58

sub_3682e:
	ld hl, text_36845
	ld c, $50

asm_36833:
	dec b
	jr z, asm_3683c

asm_36836:
	ld a, [hli]
	cp c
	jr z, asm_36833
	jr asm_36836

asm_3683c:
	ld de, wStringBuffer2
	ld bc, $a
	jp CopyBytes

text_36845:
	db $ba
	db $b3
	db $29
	db $b7
	db $d8
	db $e2
	db $b8
	db $50
	db $3e
	db $b3
	db $27
	db $e2
	db $d8
	db $e2
	db $b8
	db $50
	db $bd
	db $3a
	db $d4
	db $bb
	db $50
	db $c4
	db $b8
	db $bc
	db $e1
	db $ba
	db $b3
	db $29
	db $b7
	db $50
	db $c4
	db $b8
	db $bc
	db $e1
	db $3e
	db $b3
	db $27
	db $e2
	db $50
	db $d2
	db $b2
	db $c1
	db $e1
	db $b3
	db $d8
	db $c2
	db $50
	db $b6
	db $b2
	db $cb
	db $d8
	db $c2
	db $50

Data3687a:
	dw $6419
	dw $641c
	dw $6421
	dw $6428
	dw $6432
	dw $6442
	dw $101
	dw $a0f
	dw $102
	dw $a19
	dw $103
	dw $a23
	dw $104

asm_36894:
	ld bc, wPlayerSubStatus3
	ld de, wPlayerMoveStruct
	ld hl, wca56
	ldh a, [hBattleTurn]
	and a
	jr z, asm_368ab
	ld bc, wEnemySubStatus3
	ld de, wEnemyMoveStruct
	ld hl, wca58

asm_368ab:
	ld a, [bc]
	bit 0, a
	ret z
	push hl
	ld hl, wCurDamage
	ld a, [hli]
	ld b, a
	ld c, [hl]
	pop hl
	ld a, [hl]
	add c
	ld [hld], a
	ld a, [hl]
	adc b
	ld [hl], a
	ld hl, wca45
	ldh a, [hBattleTurn]
	and a
	jr z, asm_368c8
	ld hl, wca4d

asm_368c8:
	dec [hl]
	jr nz, asm_368ff
	ld hl, wPlayerSubStatus3
	res 0, [hl]
	ld hl, UnleashedEnergyText
	call PrintText
	ld a, 1
	ld [wPlayerMoveStructPower], a
	ld hl, wca56
	ld a, [hld]
	add a
	ld b, a
	ld [wCurDamage + 1], a
	ld a, [hl]
	rl a
	ld [wCurDamage], a
	or b
	jr nz, asm_368f2
	ld a, 1
	ld [wca3a], a

asm_368f2:
	xor a
	ld [hli], a
	ld [hl], a
	ld a, MOVE_BIDE
	ld [wPlayerMoveStruct], a
	ld b, $22
	jp SkipToBattleCommand

asm_368ff:
	ld hl, StoringEnergyText
	call PrintText
	jp asm_357a9

asm_36908:
	ld hl, wPlayerSubStatus3
	ld de, wca55
	ld bc, wca45
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3691f
	ld hl, wEnemySubStatus3
	ld de, wTrainerClass
	ld bc, wca4d

asm_3691f:
	set 0, [hl]
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
	jp asm_357a9

asm_3693e:
	ld hl, wPlayerSubStatus3
	ld de, wca45
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3694f
	ld hl, wEnemySubStatus3
	ld de, wca4d

asm_3694f:
	bit 1, [hl]
	ret z
	ld a, [de]
	dec a
	ld [de], a
	jr nz, asm_36964
	res 1, [hl]
	set 7, [hl]
	call BattleRandom
	and 1
	inc a
	inc a
	inc de
	ld [de], a

asm_36964:
	ld b, $3d
	jp SkipToBattleCommand

asm_36969:
	ld hl, wPlayerSubStatus3
	ld de, wca45
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3697a
	ld hl, wEnemySubStatus3
	ld de, wca4d

asm_3697a:
	set 1, [hl]
	call BattleRandom
	and 1
	inc a
	inc a
	ld [de], a
	ret

asm_36985:
	ldh a, [hBattleTurn]
	and a
	jr nz, asm_369e4
	ld a, [wBattleMode]
	dec a
	jr nz, asm_369cf
	ld a, [wCurPartyLevel]
	ld b, a
	ld a, [wBattleMonLevel]
	cp b
	jr nc, asm_369bc
	add b
	ld c, a
	inc c

asm_3699d:
	call BattleRandom
	cp c
	jr nc, asm_3699d
	srl b
	srl b
	cp b
	jr nc, asm_369bc
	xor a
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld a, [wPlayerMoveStruct]
	cp $64
	jp nz, asm_374b1
	jp Function37499

asm_369bc:
	ld hl, sub_3d3f4
	call CallFromBank0F
	xor a
	ld [wNumHits], a
	inc a
	ld [wce06], a
	ld a, [wPlayerMoveStruct]
	jr asm_36a3e

asm_369cf:
	xor a
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld hl, text_374c8
	ld a, [wPlayerMoveStruct]
	cp $64
	jp nz, PrintText
	jp Function37499

asm_369e4:
	ld a, [wBattleMode]
	dec a
	jr nz, asm_36a29
	ld a, [wBattleMonLevel]
	ld b, a
	ld a, [wCurPartyLevel]
	cp b
	jr nc, asm_36a16
	add b
	ld c, a
	inc c

asm_369f7:
	call BattleRandom
	cp c
	jr nc, asm_369f7
	srl b
	srl b
	cp b
	jr nc, asm_36a16
	xor a
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld a, [wEnemyMoveStruct]
	cp $64
	jp nz, asm_374b1
	jp Function37499

asm_36a16:
	ld hl, sub_3d3f4
	call CallFromBank0F
	xor a
	ld [wNumHits], a
	inc a
	ld [wce06], a
	ld a, [wEnemyMoveStruct]
	jr asm_36a3e

asm_36a29:
	xor a
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld hl, text_374c8
	ld a, [wEnemyMoveStruct]
	cp $64
	jp nz, PrintText
	jp asm_37494

asm_36a3e:
	push af
	ld a, 1
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld c, 20
	call DelayFrames
	pop af
	ld hl, text_36a61
	cp $64
	jr z, text_36a5e
	ld hl, text_36a73
	cp $2e
	jr z, text_36a5e
	ld hl, text_36a85

text_36a5e:
	jp PrintText

text_36a61:
	db $0
	db $5a
	db $ca
	db $7f
	db $be
	db $de
	db $c4
	db $b3
	db $b6
	db $d7
	db $4f
	db $d8
	db $30
	db $c2
	db $bc
	db $c0
	db $e7
	db $58

text_36a73:
	db $0
	db $59
	db $ca
	db $7f
	db $b5
	db $2c
	db $b9
	db $32
	db $b2
	db $c3
	db $4f
	db $c6
	db $29
	db $30
	db $bc
	db $c0
	db $e7
	db $58

text_36a85:
	db $0
	db $59
	db $ca
	db $4f
	db $cc
	db $b7
	db $c4
	db $3a
	db $bb
	db $da
	db $c0
	db $e7
	db $58

asm_36a92:
	ld hl, wPlayerSubStatus3
	ld de, wca45
	ld bc, wca55
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36aa9
	ld hl, wEnemySubStatus3
	ld de, wca4d
	ld bc, wTrainerClass

asm_36aa9:
	bit 2, [hl]
	jp nz, asm_36af2
	set 2, [hl]
	ld hl, wPlayerMoveStructEffect
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36abb
	ld hl, wEnemyMoveStructEffect

asm_36abb:
	ld a, [hl]
	cp $4d
	jr z, asm_36aec
	cp $2c
	ld a, 1
	jr z, asm_36ae7
	ld a, [hl]
	cp $68
	jr nz, asm_36ada

asm_36acb:
	call BattleRandom
	and 3
	jr z, asm_36acb
	dec a
	jr nz, asm_36ae7
	ld a, 1
	ld [bc], a
	jr asm_36af7

asm_36ada:
	call BattleRandom
	cp 2
	jr c, asm_36ae6
	call BattleRandom
	and 3

asm_36ae6:
	inc a

asm_36ae7:
	ld [de], a
	inc a
	ld [bc], a
	jr asm_36b14

asm_36aec:
	ld a, 2
	ld [hl], a
	dec a
	jr asm_36ae7

asm_36af2:
	ld a, [de]
	dec a
	ld [de], a
	jr nz, asm_36b14

asm_36af7:
	ld hl, text_36b2b
	ld de, wPlayerSubStatus3
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36b08
	ld hl, text_36b40
	ld de, wEnemySubStatus3

asm_36b08:
	ld a, [de]
	res 2, a
	ld [de], a
	push bc
	call PrintText
	pop bc
	xor a
	ld [bc], a
	ret

asm_36b14:
	ld a, [wca7c]
	ld h, a
	ld a, [wca7b]
	ld l, a

asm_36b1c:
	ld a, [hld]
	cp 5
	jr nz, asm_36b1c
	inc hl
	ld a, h
	ld [wca7c], a
	ld a, l
	ld [wca7b], a
	ret

text_36b2b:
	db $0
	db $b1
	db $b2
	db $c3
	db $c6
	db $7f
	db $50
	db $9
	dw wca55
	db $11
	db $0
	db $b6
	db $b2
	db $7f
	db $b1
	db $c0
	db $df
	db $c0
	db $e7
	db $58

text_36b40:
	db $0
	db $b1
	db $b2
	db $c3
	db $c6
	db $7f
	db $50
	db $9
	dw wTrainerClass
	db $11
	db $0
	db $b6
	db $b2
	db $7f
	db $b1
	db $c0
	db $df
	db $c0
	db $e7
	db $58

asm_36b55:
	call CheckSubstituteOpp
	ret nz
	ld hl, wEnemySubStatus3
	ld de, wPlayerMoveStructEffect
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36b6a
	ld hl, wPlayerSubStatus3
	ld de, wEnemyMoveStructEffect

asm_36b6a:
	call sub_36ffd
	call BattleCommand_EffectChance
	ret nc
	set 3, [hl]
	ret

asm_36b74:
	call GetUserItem
	ld a, b
	cp $4b
	ret nz
	call CheckSubstituteOpp
	ret nz
	ld hl, wEnemySubStatus3
	ld de, wPlayerMoveStructEffect
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36b90
	ld hl, wPlayerSubStatus3
	ld de, wEnemyMoveStructEffect

asm_36b90:
	push hl
	call sub_36ffd
	call GetUserItem
	pop hl
	call BattleRandom
	cp c
	ret nc
	set 3, [hl]
	ret

asm_36ba0:
	ld hl, wCurDamage
	xor a
	ld [hli], a
	ld [hl], a
	ld a, [wTypeModifier]
	and $7f
	cp $a
	jr c, asm_36be0
	ld hl, wBattleMonSpeed + 1
	ld de, wEnemyMonSpeed + 1
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36bc0
	ld hl, wEnemyMonSpeed + 1
	ld de, wBattleMonSpeed + 1

asm_36bc0:
	ld a, [de]
	dec de
	ld b, a
	ld a, [hld]
	sub b
	ld a, [de]
	ld b, a
	ld a, [hl]
	sbc b
	jr c, asm_36be0
	call Function351d0
	ld a, [wca3a]
	and a
	ret nz
	ld hl, wCurDamage
	ld a, $ff
	ld [hli], a
	ld [hl], a
	ld a, 2
	ld [wCriticalHit], a
	ret

asm_36be0:
	ld a, $ff
	ld [wCriticalHit], a
	ld a, 1
	ld [wca3a], a
	ret

asm_36beb:
	ld hl, wPlayerSubStatus3
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36bf6
	ld hl, wEnemySubStatus3

asm_36bf6:
	bit 4, [hl]
	ret z
	res 4, [hl]
	res 6, [hl]
	ld b, $39
	jp SkipToBattleCommand

asm_36c02:
	xor a
	ld [wNumHits], a
	inc a
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld hl, wPlayerSubStatus3
	ld de, wPlayerMoveStruct
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36c1e
	ld hl, wEnemySubStatus3
	ld de, wEnemyMoveStruct

asm_36c1e:
	set 4, [hl]
	ld a, [de]
	cp $13
	jr nz, asm_36c27
	set 6, [hl]

asm_36c27:
	ld a, [de]
	cp $5b
	jr nz, asm_36c2e
	set 6, [hl]

asm_36c2e:
	ld a, [de]
	ld [wMovementBufferCount], a
	ld hl, text_36c3b
	call PrintText
	jp asm_357a9

text_36c3b:
	db $0
	db $5a
	db $50
	db $8
	ld a, [wMovementBufferCount]
	cp $d
	ld hl, text_36c6b
	jr z, asm_36c6a
	cp $4c
	ld hl, text_36c80
	jr z, asm_36c6a
	cp $82
	ld hl, text_36c92
	jr z, asm_36c6a
	cp $8f
	ld hl, text_36ca0
	jr z, asm_36c6a
	cp $13
	ld hl, text_36cb2
	jr z, asm_36c6a
	cp $5b
	ld hl, text_36cc3

asm_36c6a:
	ret

text_36c6b:
	db $0
	db $c9
	db $7f
	db $cf
	db $dc
	db $d8
	db $33
	db $4f
	db $b8
	db $b3
	db $b7
	db $26
	db $7f
	db $b3
	db $2d
	db $dd
	db $7f
	db $cf
	db $b8
	db $e7
	db $58

text_36c80:
	db $0
	db $ca
	db $4f
	db $cb
	db $b6
	db $d8
	db $dd
	db $7f
	db $b7
	db $e1
	db $b3
	db $bc
	db $e1
	db $b3
	db $bc
	db $c0
	db $e7
	db $58

text_36c92:
	db $0
	db $ca
	db $4f
	db $b8
	db $3b
	db $dd
	db $7f
	db $cb
	db $df
	db $ba
	db $d2
	db $c0
	db $e7
	db $58

text_36ca0:
	db $0
	db $dd
	db $4f
	db $ca
	db $29
	db $bc
	db $b2
	db $7f
	db $cb
	db $b6
	db $d8
	db $26
	db $7f
	db $c2
	db $c2
	db $d1
	db $e7
	db $58

text_36cb2:
	db $0
	db $ca
	db $4f
	db $bf
	db $d7
	db $c0
	db $b6
	db $b8
	db $7f
	db $c4
	db $3b
	db $b1
	db $26
	db $df
	db $c0
	db $e7
	db $58

text_36cc3:
	db $0
	db $ca
	db $4f
	db $b1
	db $c5
	db $dd
	db $ce
	db $df
	db $c3
	db $7f
	db $c1
	db $c1
	db $e1
	db $b3
	db $c6
	db $7f
	db $d3
	db $28
	db $df
	db $c0
	db $e7
	db $58

asm_36cd9:
	ld hl, wPlayerSubStatus3
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36ce4
	ld hl, wEnemySubStatus3

asm_36ce4:
	bit 5, [hl]
	ret z
	ld a, [wca7c]
	ld h, a
	ld a, [wca7b]
	ld l, a

asm_36cef:
	ld a, [hli]
	cp $3b
	jr nz, asm_36cef
	dec hl
	ld a, h
	ld [wca7c], a
	ld a, l
	ld [wca7b], a
	ret

asm_36cfe:
	ld hl, wPlayerSubStatus3
	ld de, wca45
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36d0f
	ld hl, wEnemySubStatus3
	ld de, wca4d

asm_36d0f:
	ld a, [wca3a]
	and a
	ret nz
	bit 5, [hl]
	jr nz, asm_36d2e
	call sub_36ffd
	set 5, [hl]
	call BattleRandom
	and 3
	cp 2
	jr c, asm_36d2b
	call BattleRandom
	and 3

asm_36d2b:
	inc a
	ld [de], a
	ret

asm_36d2e:
	push hl
	push de
	ld hl, AttackContinuesText
	call PrintText
	pop hl
	dec [hl]
	pop hl
	ret nz
	res 5, [hl]
	ret

asm_36d3d:
	ld hl, wPlayerSubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36d48
	ld hl, wEnemySubStatus4

asm_36d48:
	bit 1, [hl]
	jr nz, asm_36d57
	set 1, [hl]
	call LoadMoveAnim
	ld hl, text_36d5a
	jp PrintText

asm_36d57:
	jp Function37499

text_36d5a:
	db $0
	db $5a
	db $ca
	db $4f
	db $bc
	db $db
	db $b2
	db $7f
	db $b7
	db $d8
	db $c6
	db $7f
	db $c2
	db $c2
	db $cf
	db $da
	db $c0
	db $e7
	db $58

asm_36d6d:
	ld hl, wPlayerSubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36d78
	ld hl, wEnemySubStatus4

asm_36d78:
	bit 2, [hl]
	jr nz, asm_36d87
	set 2, [hl]
	call LoadMoveAnim
	ld hl, text_36d8d
	jp PrintText

asm_36d87:
	call BattleCommand_MoveDelay
	jp Function37499

text_36d8d:
	db $a
	db $0
	db $5a
	db $ca
	db $4f
	db $ca
	db $d8
	db $b7
	db $df
	db $c3
	db $b2
	db $d9
	db $e7
	db $58

asm_36d9b:
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStruct]
	ld hl, wBattleMonMaxHP
	jr z, asm_36dac
	ld a, [wEnemyMoveStruct]
	ld hl, wEnemyMonMaxHP

asm_36dac:
	ld d, a
	ld a, [wCurDamage]
	ld b, a
	ld a, [wCurDamage + 1]
	ld c, a
	srl b
	rr c
	ld a, d
	cp $a5
	jr z, asm_36dc2
	srl b
	rr c

asm_36dc2:
	ld a, b
	or c
	jr nz, asm_36dc7
	inc c

asm_36dc7:
	ld a, [hli]
	ld [wPlayerEffectivenessVsEnemyMons], a
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
	ld [wcdc6], a
	sbc b
	ld [hl], a
	ld [wcdc8], a
	jr nc, asm_36ded
	xor a
	ld [hli], a
	ld [hl], a
	ld hl, wHPBarNewHP
	ld [hli], a
	ld [hl], a

asm_36ded:
	ld hl, wTileMap + 190
	ldh a, [hBattleTurn]
	and a
	ld a, 1
	jr z, asm_36dfb
	ld hl, wTileMap + 42
	xor a

asm_36dfb:
	ld [wWhichHPBar], a
	predef UpdateHPBar
	ld hl, text_36e09
	jp PrintText

text_36e09:
	db $0
	db $5a
	db $ca
	db $7f
	db $ba
	db $b3
	db $29
	db $b7
	db $c9
	db $4f
	db $ca
	db $de
	db $34
	db $b3
	db $dd
	db $7f
	db $b3
	db $b9
	db $c0
	db $e7
	db $58

asm_36e1e:
	call GetOpponentItem
	ld a, b
	cp $19
	ret z
	call BattleCommand_EffectChance
	ret nc
	jr asm_36e4e

asm_36e2b:
	call GetOpponentItem
	ld a, b
	cp $19
	jr nz, asm_36e43
	ld a, [hl]
	ld [wNumSetBits], a
	call GetItemName
	call BattleCommand_MoveDelay
	ld hl, ProtectedByText
	jp PrintText

asm_36e43:
	call CheckSubstituteOpp
	jr nz, asm_36e9e
	ld a, [wca3a]
	and a
	jr nz, asm_36e9e

asm_36e4e:
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemySubStatus3
	ld bc, wca4e
	ld a, [wPlayerMoveStructEffect]
	jr z, asm_36e65
	ld hl, wPlayerSubStatus3
	ld bc, wca46
	ld a, [wEnemyMoveStructEffect]

asm_36e65:
	bit 7, [hl]
	jr nz, asm_36e9e
	set 7, [hl]
	push af
	call BattleRandom
	and 3
	inc a
	inc a
	ld [bc], a
	pop af
	cp $4c
	jr z, asm_36e86
	cp $5c
	jr z, asm_36e86
	cp $76
	jr z, asm_36e86
	call LoadMoveAnim
	jr asm_36e8c

asm_36e86:
	ld de, $0103
	call PlayOpponentBattleAnim

asm_36e8c:
	ld hl, Data36e92
	jp PrintText

Data36e92:
	db $0
	db $59
	db $ca
	db $4f
	db $ba
	db $de
	db $d7
	db $de
	db $bc
	db $c0
	db $e7
	db $58

asm_36e9e:
	cp $4c
	ret z
	cp $5c
	ret z
	cp $76
	ret z
	call BattleCommand_MoveDelay
	jp asm_37494

asm_36ead:
	ld hl, wEnemyMonStatus
	ld de, wPlayerMoveStructType
	ldh a, [hBattleTurn]
	and a
	jp z, asm_36ebf
	ld hl, wBattleMonStatus
	ld de, wEnemyMoveStructType

asm_36ebf:
	ld a, [wTypeModifier]
	and $7f
	cp $a
	jr c, asm_36f2f
	ld a, [hl]
	and a
	jr nz, asm_36f29
	push hl
	call GetOpponentItem
	ld a, b
	cp $18
	ld a, [hl]
	pop hl
	jr nz, asm_36ee6
	ld [wNumSetBits], a
	call GetItemName
	call BattleCommand_MoveDelay
	ld hl, ProtectedByText
	jp PrintText

asm_36ee6:
	ld a, [wca3a]
	and a
	jr nz, asm_36f29
	set 6, [hl]
	push hl
	ld hl, sub_3e254
	call CallFromBank0F
	ld c, 30
	call DelayFrames
	call LoadMoveAnim
	ld hl, DrawHUDsAndHPBars
	call CallFromBank0F
	call sub_374db
	call GetOpponentItem
	ld a, b
	pop de
	cp $e
	jr z, asm_36f18
	cp $f
	jr z, asm_36f18
	cp 2
	jr z, asm_36f18
	ret

asm_36f18:
	ld a, [de]
	res 6, a
	ld [de], a
	ld a, [hl]
	call PrintRecoveredUsingItem
	call ConsumeHeldItem
	ld hl, DrawHUDsAndHPBars
	jp CallFromBank0F

asm_36f29:
	call BattleCommand_MoveDelay
	jp asm_374b1

asm_36f2f:
	call BattleCommand_MoveDelay
	jp asm_35643

asm_36f35:
	call BattleCommand_MoveDelay
	ld hl, wBattleMonMaxHP
	ld de, wcabc
	ld bc, wPlayerSubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36f4f
	ld hl, wEnemyMonMaxHP
	ld de, wcabd
	ld bc, wEnemySubStatus4

asm_36f4f:
	ld a, [bc]
	bit 4, a
	jr nz, asm_36f9d
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
	jr c, asm_36fa2
	ld [hli], a
	ld [hl], d
	ld h, b
	ld l, c
	set 4, [hl]
	ld a, [wce5f]
	add a
	jr c, asm_36f89
	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	ld [wBattleAnimParam], a
	ld a, $a4
	call LoadBattleAnim
	jr asm_36f91

asm_36f89:
	callfar Functioncc000_2

asm_36f91:
	ld hl, text_36fa8
	call PrintText
	ld hl, DrawHUDsAndHPBars
	jp CallFromBank0F

asm_36f9d:
	ld hl, text_36fd8
	jr asm_36fa5

asm_36fa2:
	ld hl, text_36fd0

asm_36fa5:
	jp PrintText

text_36fa8:
	db $0
	db $5a
	db $c9
	db $4f
	db $3c
	db $de
	db $bc
	db $de
	db $26
	db $7f
	db $b1
	db $d7
	db $dc
	db $da
	db $c0
	db $58

text_36fd8:
	db $0
	db $bc
	db $b6
	db $bc
	db $7f
	db $5a
	db $c9
	db $4f
	db $d0
	db $26
	db $dc
	db $d8
	db $ca
	db $7f
	db $bd
	db $33
	db $c6
	db $7f
	db $33
	db $c3
	db $b2
	db $c0
	db $e7
	db $58

text_36fd0:
	db $0
	db $bc
	db $b6
	db $bc
	db $7f
	db $3c
	db $de
	db $bc
	db $de
	db $dd
	db $7f
	db $30
	db $bd
	db $c6
	db $ca
	db $4f
	db $c0
	db $b2
	db $d8
	db $e2
	db $b8
	db $26
	db $7f
	db $c0
	db $d8
	db $c5
	db $b6
	db $df
	db $c0
	db $e7
	db $58

asm_36fef:
	ld hl, wPlayerSubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, asm_36ffa
	ld hl, wEnemySubStatus4

asm_36ffa:
	set 5, [hl]
	ret

sub_36ffd:
	push hl
	ld hl, wEnemySubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, asm_37009
	ld hl, wPlayerSubStatus4

asm_37009:
	res 5, [hl]
	pop hl
	ret
	ld hl, wPlayerSubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, asm_37018
	ld hl, wEnemySubStatus4

asm_37018:
	set 6, [hl]
	ret

asm_3701b:
	call BattleCommand_MoveDelay
	ld a, [wca3a]
	and a
	jr nz, asm_37055
	ld hl, wBattleMonMoves
	ld de, wCurEnemyMove
	ldh a, [hBattleTurn]
	and a
	jr z, asm_37035
	ld hl, wEnemyMonMoves
	ld de, wCurPlayerMove

asm_37035:
	call sub_37e0d
	jr nz, asm_37055
	ld a, [de]
	and a
	jr z, asm_37055

asm_3703e:
	ld a, [hli]
	cp $66
	jr nz, asm_3703e
	dec hl
	ld a, [de]
	ld [hl], a
	ld [wNumSetBits], a
	call Unreferenced_GetMoveName
	call LoadMoveAnim
	ld hl, text_37058
	jp PrintText

asm_37055:
	jp Function37499

text_37058:
	db $0
	db $5a
	db $ca
	db $4f
	db $50
	db $1
	dw wStringBuffer1
	db $0
	db $dd
	db $7f
	db $b5
	db $3e
	db $b4
	db $c0
	db $e7
	db $58

asm_37069:
	ld a, [wca3a]
	and a
	jr nz, asm_3709a
	ld hl, wEnemySubStatus4
	ld de, wEnemyMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, asm_37080
	ld hl, wPlayerSubStatus4
	ld de, wBattleMonHP

asm_37080:
	ld a, [de]
	cp $16
	jr z, asm_3709a
	inc de
	ld a, [de]
	cp $16
	jr z, asm_3709a
	bit 7, [hl]
	jr nz, asm_3709a
	set 7, [hl]
	call LoadMoveAnim
	ld hl, text_370a3
	jp PrintText

asm_3709a:
	call BattleCommand_MoveDelay
	ld hl, text_370b2
	jp PrintText

text_370a3:
	db $0
	db $59
	db $c6
	db $4f
	db $c0
	db $c8
	db $dd
	db $7f
	db $b3
	db $b4
	db $c2
	db $b9
	db $c0
	db $e7
	db $58

text_370b2:
	db $0
	db $59
	db $ca
	db $4f
	db $ba
	db $b3
	db $29
	db $b7
	db $dd
	db $7f
	db $b6
	db $dc
	db $bc
	db $c0
	db $e7
	db $58

asm_370c2:
	call LoadMoveAnim
	jp asm_37480

asm_370c8:
	ld a, [wca3a]
	and a
	jr nz, asm_37132
	ld de, wca50
	ld hl, wEnemyMonMoves
	ld bc, wCurEnemyMove
	ldh a, [hBattleTurn]
	and a
	jr z, asm_370e5
	ld de, wca48
	ld hl, wBattleMonMoves
	ld bc, wCurPlayerMove

asm_370e5:
	ld a, [de]
	and a
	jr nz, asm_37132
	ld a, [bc]
	and a
	jr z, asm_37132
	cp $a5
	jr z, asm_37132
	ld [wNumSetBits], a
	ld b, a
	ld c, $ff

asm_370f7:
	inc c
	ld a, [hli]
	cp b
	jr nz, asm_370f7
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyMonPP
	jr z, asm_37107
	ld hl, wBattleMonPP

asm_37107:
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	jr z, asm_37132
	call BattleRandom
	and 7
	inc a
	inc c
	swap c
	add c
	ld [de], a
	call PlayDamageAnim
	ld hl, wcad3
	ldh a, [hBattleTurn]
	and a
	jr nz, asm_37125
	inc hl

asm_37125:
	ld a, [wNumSetBits]
	ld [hl], a
	call Unreferenced_GetMoveName
	ld hl, MoveDisabledText
	jp PrintText

asm_37132:
	call BattleCommand_MoveDelay
	jp Function37499

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

.ok:
	add a
	ld hl, wPayDayMoney + 2
	add [hl]
	ld [hld], a
	jr nc, PrintCoinsScatteredText
	inc [hl]
	dec hl
	jr nz, PrintCoinsScatteredText
	inc [hl]

PrintCoinsScatteredText:
	ld hl, CoinsScatteredText
	jp PrintText

CoinsScatteredText:
	text "こばんが　あたりに　ちらばった！"
	prompt


asm_37180:
	ld hl, wEnemyMonType
	ld de, wBattleMonType
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3718f
	push hl
	ld h, d
	ld l, e
	pop de

asm_3718f:
	call sub_37e0d
	jr nz, asm_371b7
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	call LoadMoveAnim
	ld hl, text_371a2
	jp PrintText

text_371a2:
	db $0
	db $59
	db $c9
	db $7f
	db $8f
	db $81
	db $42
	db $dd
	db $4f
	db $2c
	db $3c
	db $de
	db $c6
	db $7f
	db $ca
	db $d8
	db $c2
	db $b9
	db $c0
	db $e7
	db $58

asm_371b7:
	jp Function37499

asm_371ba:
	ld a, 7
	ld hl, wcaa9
	call sub_37224
	ld hl, wcab1
	call sub_37224
	ld hl, wca93
	ld de, wBattleMonAttack
	call sub_3722b
	ld hl, wca9e
	ld de, wEnemyMonAttack
	call sub_3722b
	ld hl, wEnemyMonStatus
	ld de, wCurEnemySelectedMove
	ldh a, [hBattleTurn]
	and a
	jr z, asm_371e9
	ld hl, wBattleMonStatus
	dec de

asm_371e9:
	ld a, [hl]
	ld [hl], 0
	and $27
	jr z, asm_371f3
	ld a, $ff
	ld [de], a

asm_371f3:
	xor a
	ld [wca48], a
	ld [wca50], a
	ld hl, wcad3
	ld [hli], a
	ld [hl], a
	ld hl, wPlayerSubStatus3
	res 7, [hl]
	inc hl
	ld a, [hl]
	and $78
	ld [hli], a
	ld a, [hl]
	and $f8
	ld [hl], a
	ld hl, wEnemySubStatus3
	res 7, [hl]
	inc hl
	ld a, [hl]
	and $78
	ld [hli], a
	ld a, [hl]
	and $f8
	ld [hl], a
	call LoadMoveAnim
	ld hl, text_37234
	jp PrintText

sub_37224:
	ld b, 8

asm_37226:
	ld [hli], a
	dec b
	jr nz, asm_37226
	ret

sub_3722b:
	ld b, 8

asm_3722d:
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, asm_3722d
	ret

text_37234:
	db $0
	db $bd
	db $3d
	db $c3
	db $c9
	db $7f
	db $8c
	db $92
	db $e3
	db $8f
	db $8c
	db $26
	db $4f
	db $d3
	db $c4
	db $c6
	db $7f
	db $d3
	db $34
	db $df
	db $c0
	db $e7
	db $58

asm_3724b:
	ldh a, [hBattleTurn]
	and a
	ld de, wBattleMonHP
	ld hl, wBattleMonMaxHP
	ld a, [wPlayerMoveStruct]
	jr z, asm_37262
	ld de, wEnemyMonHP
	ld hl, wEnemyMonMaxHP
	ld a, [wEnemyMoveStruct]

asm_37262:
	ld b, a
	ld a, [de]
	cp [hl]
	inc de
	inc hl
	ld a, [de]
	sbc [hl]
	jp z, asm_372c9
	ld a, b
	cp $9c
	jr nz, asm_37294
	push hl
	push de
	push af
	call BattleCommand_MoveDelay
	ld hl, wBattleMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, asm_37282
	ld hl, wEnemyMonStatus

asm_37282:
	ld a, [hl]
	and a
	ld [hl], 2
	ld hl, text_372cf
	jr z, asm_3728e
	ld hl, text_372dc

asm_3728e:
	call PrintText
	pop af
	pop de
	pop hl

asm_37294:
	jr z, asm_372a0
	callfar Function3c7d3
	jr asm_372a8

asm_372a0:
	callfar Function3c7f2

asm_372a8:
	call LoadMoveAnim
	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	callfar sub_3c808
	pop af
	ldh [hBattleTurn], a
	ld hl, DrawHUDsAndHPBars
	call CallFromBank0F
	ld hl, text_372f2
	jp PrintText

asm_372c9:
	call BattleCommand_MoveDelay
	jp Function37499

text_372cf:
	db $0
	db $5a
	db $ca
	db $4f
	db $c8
	db $d1
	db $d8
	db $ca
	db $2c
	db $d2
	db $c0
	db $e7
	db $57

text_372dc:
	db $0
	db $5a
	db $ca
	db $7f
	db $b9
	db $de
	db $ba
	db $b3
	db $c6
	db $c5
	db $df
	db $c3
	db $4f
	db $c8
	db $d1
	db $d8
	db $ca
	db $2c
	db $d2
	db $c0
	db $e7
	db $57

text_372f2:
	db $0
	db $5a
	db $ca
	db $7f
	db $c0
	db $b2
	db $d8
	db $e2
	db $b8
	db $dd
	db $4f
	db $b6
	db $b2
	db $cc
	db $b8
	db $bc
	db $c0
	db $e7
	db $58

asm_37305:
	ld hl, wBattleMon
	ld de, wEnemyMon
	ld bc, wEnemySubStatus5
	ldh a, [hBattleTurn]
	and a
	jr nz, asm_37320
	ld hl, wEnemyMon
	ld de, wBattleMon
	ld bc, wPlayerSubStatus5
	xor a
	ld [wcd40], a

asm_37320:
	call sub_37e0d
	jp nz, asm_373f1
	push hl
	push de
	push bc
	ld hl, $ca3e
	ldh a, [hBattleTurn]
	and a
	jr z, asm_37334
	ld hl, $ca43

asm_37334:
	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	ld a, 1
	ld [wBattleAnimParam], a
	bit 4, [hl]
	push af
	ld a, $a4
	call nz, LoadBattleAnim
	ld a, [wce5f]
	add a
	jr c, asm_37353
	call LoadMoveAnim
	jr asm_3735b

asm_37353:
	callfar Functioncc000_2

asm_3735b:
	xor a
	ld [wNumHits], a
	ld [wFXAnimID + 1], a
	ld a, 2
	ld [wBattleAnimParam], a
	pop af
	ld a, $a4
	call nz, LoadBattleAnim
	pop bc
	ld a, [bc]
	set 3, a
	ld [bc], a
	pop de
	pop hl
	push hl
	ld a, [hli]
	ld [de], a
	inc hl
	inc de
	inc de
	ld bc, 4
	call CopyBytes
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3738f
	ld a, [de]
	ld [wcad0], a
	inc de
	ld a, [de]
	ld [wcad1], a
	dec de

asm_3738f:
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld bc, $c
	add hl, bc
	push hl
	ld h, d
	ld l, e
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld bc, $c
	call CopyBytes
	ld bc, hFFE2
	add hl, bc
	push de
	ld d, h
	ld e, l
	pop hl
	ld bc, hMapAnims
	add hl, bc
	ld b, 4

asm_373b4:
	ld a, [de]
	inc de
	and a
	jr z, asm_373bf
	ld a, 5
	ld [hli], a
	dec b
	jr nz, asm_373b4

asm_373bf:
	pop hl
	ld a, [hl]
	ld [wNumSetBits], a
	call GetPokemonName
	ld hl, wca9e
	ld de, wca93
	ld bc, $a
	call sub_373e5
	ld hl, wcab1
	ld de, wcaa9
	ld bc, 8
	call sub_373e5
	ld hl, text_373f4
	jp PrintText

sub_373e5:
	ldh a, [hBattleTurn]
	and a
	jr z, asm_373ee
	push hl
	ld h, d
	ld l, e
	pop de

asm_373ee:
	jp CopyBytes

asm_373f1:
	jp Function37499

text_373f4:
	db $0
	db $5a
	db $ca
	db $4f
	db $50
	db $1
	dw wStringBuffer1
	db $0
	db $c6
	db $7f
	db $cd
	db $de
	db $bc
	db $de
	db $bc
	db $c0
	db $e7
	db $58

asm_37407:
	ld hl, wPlayerSubStatus5
	ld de, wPlayerMoveStructEffect
	ldh a, [hBattleTurn]
	and a
	jr z, asm_37418
	ld hl, wEnemySubStatus5
	ld de, wEnemyMoveStructEffect

asm_37418:
	ld a, [de]
	cp $40
	jr nz, asm_37428
	bit 1, [hl]
	jr nz, asm_37439
	set 1, [hl]
	ld hl, text_3743f
	jr asm_37431

asm_37428:
	bit 2, [hl]
	jr nz, asm_37439
	set 2, [hl]
	ld hl, text_37455

asm_37431:
	push hl
	call LoadMoveAnim
	pop hl
	jp PrintText

asm_37439:
	call BattleCommand_MoveDelay
	jp Function37499

text_3743f:
	db $0
	db $5a
	db $ca
	db $4f
	db $c4
	db $b8
	db $bc
	db $e1
	db $ba
	db $b3
	db $29
	db $b7
	db $c6
	db $7f
	db $c2
	db $d6
	db $b8
	db $c5
	db $df
	db $c0
	db $e7
	db $58

text_37455:
	db $0
	db $5a
	db $ca
	db $4f
	db $30
	db $29
	db $b7
	db $ba
	db $b3
	db $29
	db $b7
	db $c6
	db $7f
	db $c2
	db $d6
	db $b8
	db $c5
	db $df
	db $c0
	db $e7
	db $58

asm_3746a:
	ld hl, text_37470
	jp PrintText

text_37470:
	db $0
	db $bc
	db $b6
	db $bc
	db $7f
	db $ba
	db $b3
	db $b6
	db $26
	db $7f
	db $c5
	db $b6
	db $df
	db $c0
	db $e7
	db $58

asm_37480:
	ld hl, text_37486
	jp PrintText

text_37486:
	db $0
	db $bc
	db $b6
	db $bc
	db $7f
	db $c5
	db $c6
	db $d3
	db $b5
	db $ba
	db $d7
	db $c5
	db $b2
	db $58

asm_37494:
	ld a, [wcad9]
	and a
	ret nz

Function37499:
	ld hl, text_3749f
	jp PrintText

text_3749f:
	db $0
	db $bc
	db $b6
	db $bc
	db $7f
	db $b3
	db $cf
	db $b8
	db $7f
	db $b7
	db $cf
	db $d7
	db $c5
	db $b6
	db $df
	db $c0
	db $e7
	db $58

asm_374b1:
	ld hl, DidntAffectText
	jp PrintText

DidntAffectText:
	text "しかし　<TARGET>には"
	line "きかなかった！"
	prompt

text_374c8:
	db $0
	db $59
	db $ca
	db $4f
	db $cd
	db $b2
	db $b7
	db $c5
	db $7f
	db $b6
	db $b5
	db $dd
	db $7f
	db $bc
	db $c3
	db $b2
	db $d9
	db $e7
	db $58

sub_374db:
	ld hl, text_374e1
	jp PrintText

text_374e1:
	db $0
	db $59
	db $ca
	db $7f
	db $cf
	db $cb
	db $bc
	db $c3
	db $4f
	db $dc
	db $2b
	db $26
	db $7f
	db $33
	db $c6
	db $b8
	db $b8
	db $c5
	db $df
	db $c0
	db $e7
	db $58

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

asm_3751b:
	ld a, 5
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
	jr z, asm_3753e
	ld hl, wEnemyMonStatus
	ld de, wEnemySubStatus4

asm_3753e:
	xor a
	ld [hli], a
	ld [hli], a
	inc hl
	ld [hli], a
	ld [hl], a
	ld a, [de]
	res 7, a
	ld [de], a
	ret

asm_37549:
	ldh a, [hBattleTurn]
	and a
	ld a, [wCurEnemyMove]
	ld hl, wCurPlayerSelectedMove
	ld de, wPlayerMoveStruct
	jr z, asm_37560
	ld a, [wCurPlayerMove]
	ld de, wEnemyMoveStruct
	ld hl, wCurEnemySelectedMove

asm_37560:
	cp $77
	jr z, asm_37567
	and a
	jr nz, asm_37570

asm_37567:
	ld hl, text_375a0
	call PrintText
	jp asm_357a9

asm_37570:
	ld [hl], a
	ld [wNumSetBits], a
	dec a
	ld hl, Moves
	ld bc, 7
	call AddNTimes
	ld a, $10
	call FarCopyBytes
	call sub_37ddb
	call Unreferenced_GetMoveName
	call CopyStringToStringBuffer2
	call BattleCommand_MoveDelay
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStructEffect]
	jr z, asm_3759a
	ld a, [wEnemyMoveStructEffect]

asm_3759a:
	call DoMove
	jp asm_357a9

text_375a0:
	db $0
	db $bc
	db $b6
	db $bc
	db $7f
	db $84
	db $82
	db $9f
	db $26
	db $b4
	db $bc
	db $ca
	db $4e
	db $bc
	db $df
	db $44
	db $b2
	db $c6
	db $b5
	db $dc
	db $df
	db $c0
	db $e7
	db $58

asm_375b8:
	call LoadMoveAnim
	ld de, wPlayerMoveStructEffect
	ld hl, wCurPlayerSelectedMove
	ldh a, [hBattleTurn]
	and a
	jr z, asm_375cc
	ld de, wEnemyMoveStructEffect
	ld hl, wCurEnemySelectedMove

asm_375cc:
	call BattleRandom
	and a
	jr z, asm_375cc
	cp $fc
	jr nc, asm_375cc
	cp $76
	jr z, asm_375cc
	ld [hl], a
	push de
	call sub_37ddb
	call UpdateMoveData
	pop de
	ld a, [de]
	call DoMove
	jp asm_357a9

asm_375ea:
	ldh a, [hBattleTurn]
	and a
	jr nz, asm_3760f
	call sub_37637
	ld a, [hl]
	and a
	ret nz
	call sub_37649
	ld a, [hl]
	and a
	ret z
	ld [wNumSetBits], a
	call BattleCommand_EffectChance
	ret nc
	xor a
	ld [hl], a
	ld [de], a
	call sub_37637
	ld a, [wNumSetBits]
	ld [hl], a
	ld [de], a
	jr asm_3762d

asm_3760f:
	call sub_37649
	ld a, [hl]
	and a
	ret nz
	call sub_37637
	ld a, [hl]
	and a
	ret z
	ld [wNumSetBits], a
	call BattleCommand_EffectChance
	ret nc
	xor a
	ld [hl], a
	ld [de], a
	call sub_37649
	ld a, [wNumSetBits]
	ld [hl], a
	ld [de], a

asm_3762d:
	call GetItemName
	ld hl, text_3765b
	call PrintText
	ret

sub_37637:
	ld hl, wPartyMon1Item
	ld a, [wCurBattleMon]
	ld bc, $30
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wBattleMonItem
	ret

sub_37649:
	ld hl, wOTPartyMon1Item
	ld a, [wCurOTMon]
	ld bc, $30
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wEnemyMonItem
	ret

text_3765b:
	db $0
	db $5a
	db $ca
	db $7f
	db $59
	db $b6
	db $d7
	db $4f
	db $50
	db $1
	dw wStringBuffer1
	db $0
	db $dd
	db $7f
	db $b3
	db $3a
	db $b2
	db $c4
	db $df
	db $c0
	db $e7
	db $58

asm_37672:
	ld hl, wEnemySubStatus5
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3767d
	ld hl, wPlayerSubStatus5

asm_3767d:
	call sub_37e0d
	jr nz, asm_376a0
	bit 7, [hl]
	jr nz, asm_376a0
	set 7, [hl]
	call LoadMoveAnim
	ld hl, text_37691
	jp PrintText

text_37691:
	db $0
	db $59
	db $ca
	db $4f
	db $d3
	db $b3
	db $7f
	db $c6
	db $29
	db $d7
	db $da
	db $c5
	db $b2
	db $e7
	db $58

asm_376a0:
	call BattleCommand_MoveDelay
	jp Function37499

asm_376a6:
	ld hl, wEnemySubStatus1
	ld de, wEnemyMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, asm_376b7
	ld hl, wPlayerSubStatus1
	ld de, wBattleMonStatus

asm_376b7:
	call sub_37e0d
	jr nz, asm_376e0
	ld a, [de]
	and 7
	jr z, asm_376e0
	bit 0, [hl]
	jr nz, asm_376e0
	set 0, [hl]
	call LoadMoveAnim
	ld hl, text_376d0
	jp PrintText

text_376d0:
	db $0
	db $59
	db $ca
	db $4f
	db $b1
	db $b8
	db $d1
	db $dd
	db $7f
	db $d0
	db $ca
	db $2c
	db $d2
	db $c0
	db $e7
	db $58

asm_376e0:
	call BattleCommand_MoveDelay
	jp Function37499

asm_376e6:
	ld hl, wPartyMon1Status
	ld a, [wCurBattleMon]
	ld bc, $30
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wBattleMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3770d
	ld hl, wOTPartyMon1Status
	ld a, [wCurOTMon]
	ld bc, $30
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wEnemyMonStatus

asm_3770d:
	bit 5, [hl]
	ret z
	res 5, [hl]
	ld a, [de]
	res 5, a
	ld [de], a
	ld hl, text_3771d
	call PrintText
	ret

text_3771d:
	db $0
	db $5a
	db $c9
	db $4f
	db $ba
	db $b5
	db $d8
	db $26
	db $7f
	db $c4
	db $b9
	db $c0
	db $e7
	db $58

asm_3772b:
	ld hl, wEnemySubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, asm_37736
	ld hl, wPlayerSubStatus1

asm_37736:
	call sub_37e0d
	jr nz, asm_3777a
	bit 1, [hl]
	jr nz, asm_3777a
	set 1, [hl]
	call LoadMoveAnim
	callfar sub_3c7b0
	callfar sub_3c75e
	ld hl, text_3775a
	jp PrintText

text_3775a:
	db $0
	db $5a
	db $ca
	db $4f
	db $2c
	db $3c
	db $de
	db $c6
	db $7f
	db $b8
	db $27
	db $dd
	db $7f
	db $b3
	db $df
	db $c0
	db $51
	db $59
	db $ca
	db $4f
	db $c9
	db $db
	db $b2
	db $dd
	db $7f
	db $b6
	db $b9
	db $d7
	db $da
	db $c0
	db $e7
	db $58

asm_3777a:
	call BattleCommand_MoveDelay
	jp Function37499

asm_37780:
	ld hl, wPlayerSubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3778b
	ld hl, wEnemySubStatus1

asm_3778b:
	set 2, [hl]
	call LoadMoveAnim
	ld hl, text_37796
	jp PrintText

text_37796:
	db $0
	db $5a
	db $ca
	db $4f
	db $cf
	db $d3
	db $d8
	db $c9
	db $7f
	db $c0
	db $b2
	db $be
	db $b2
	db $c6
	db $7f
	db $ca
	db $b2
	db $df
	db $c0
	db $e7
	db $58

asm_377ab:
	ld hl, wcade
	ldh a, [hBattleTurn]
	and a
	jr z, asm_377b6
	ld hl, wcadd

asm_377b6:
	ld a, [wca3a]
	and a
	jr nz, asm_377e2
	bit 0, [hl]
	jr nz, asm_377e2
	set 0, [hl]
	call LoadMoveAnim
	ld hl, text_377cb
	jp PrintText

text_377cb:
	db $0
	db $59
	db $c9
	db $7f
	db $b1
	db $bc
	db $d3
	db $c4
	db $c6
	db $4f
	db $cf
	db $b7
	db $3b
	db $bc
	db $26
	db $7f
	db $c1
	db $d7
	db $3a
	db $df
	db $c0
	db $e7
	db $58

asm_377e2:
	call BattleCommand_MoveDelay
	jp Function37499

asm_377e8:
	ld hl, wEnemySubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, asm_377f3
	ld hl, wPlayerSubStatus1

asm_377f3:
	ld a, [wca3a]
	and a
	jr nz, asm_37822
	call sub_37e0d
	jr nz, asm_37822
	bit 3, [hl]
	jr nz, asm_37822
	set 3, [hl]
	call LoadMoveAnim
	ld hl, text_3780d
	jp PrintText

text_3780d:
	db $0
	db $5a
	db $ca
	db $7f
	db $59
	db $c9
	db $4f
	db $bc
	db $e2
	db $b3
	db $c0
	db $b2
	db $dd
	db $7f
	db $d0
	db $d4
	db $3c
	db $df
	db $c0
	db $e7
	db $58

asm_37822:
	call BattleCommand_MoveDelay
	jp Function37499

asm_37828:
	ld hl, wPlayerSubStatus1
	ld de, wEnemySubStatus1
	bit 4, [hl]
	jr z, asm_37837
	ld a, [de]
	bit 4, a
	jr nz, asm_37857

asm_37837:
	bit 4, [hl]
	jr nz, asm_37842
	set 4, [hl]
	ld a, 4
	ld [wca4a], a

asm_37842:
	ld a, [de]
	jr nz, asm_3784d
	set 4, a
	ld [de], a
	ld a, 4
	ld [wca52], a

asm_3784d:
	call LoadMoveAnim
	ld hl, text_3785d
	call PrintText
	ret

asm_37857:
	call BattleCommand_MoveDelay
	jp Function37499

text_3785d:
	db $0
	db $b5
	db $c0
	db $26
	db $b2
	db $c9
	db $54
	db $ca
	db $4f
	db $f9
	db $8f
	db $e3
	db $ab
	db $2a
	db $c6
	db $7f
	db $ce
	db $db
	db $3b
	db $c3
	db $bc
	db $cf
	db $b3
	db $e7
	db $58

asm_37876:
	ld hl, wcade
	ldh a, [hBattleTurn]
	and a
	jr z, asm_37881
	ld hl, wcadd

asm_37881:
	ld a, [wca3a]
	and a
	jr nz, asm_378a9
	bit 1, [hl]
	jr nz, asm_378a9
	set 1, [hl]
	call LoadMoveAnim
	ld hl, text_37896
	jp PrintText

text_37896:
	db $0
	db $59
	db $ca
	db $4f
	db $bd
	db $c5
	db $b1
	db $d7
	db $bc
	db $c6
	db $7f
	db $cf
	db $b7
	db $ba
	db $cf
	db $da
	db $c0
	db $e7
	db $58

asm_378a9:
	call BattleCommand_MoveDelay
	jp Function37499

asm_378af:
	ld hl, wPlayerSubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, asm_378ba
	ld hl, wEnemySubStatus1

asm_378ba:
	set 5, [hl]
	call LoadMoveAnim
	ld hl, text_378c5
	jp PrintText

text_378c5:
	db $0
	db $5a
	db $ca
	db $7f
	db $ba
	db $d7
	db $b4
	db $d9
	db $4f
	db $c0
	db $b2
	db $be
	db $b2
	db $c6
	db $7f
	db $ca
	db $b2
	db $df
	db $c0
	db $e7
	db $58

asm_378da:
	ld hl, wPlayerSubStatus1
	ld de, wca45
	ldh a, [hBattleTurn]
	and a
	jr z, asm_378eb
	ld hl, wEnemySubStatus1
	ld de, wca4d

asm_378eb:
	bit 6, [hl]
	jr z, asm_378f4
	ld b, 4
	jp SkipToBattleCommand

asm_378f4:
	xor a
	ld [de], a
	ret

asm_378f7:
	ld hl, wca45
	ld de, wPlayerSubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, asm_37908
	ld hl, wca4d
	ld de, wEnemySubStatus1

asm_37908:
	ld a, [wca3a]
	and a
	jr z, asm_37913
	ld a, [de]
	res 6, a
	ld [de], a
	ret

asm_37913:
	inc [hl]
	ld a, [hl]
	ld b, a
	cp 5
	jr nz, asm_37920
	ld a, [de]
	res 6, a
	ld [de], a
	jr asm_37924

asm_37920:
	ld a, [de]
	set 6, a
	ld [de], a

asm_37924:
	dec b
	jr z, asm_37935
	ld hl, wCurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	jr nc, asm_37924
	ld a, $ff
	ld [hli], a
	ld [hl], a

asm_37935:
	ret

asm_37936:
	ld a, [wca3a]
	and a
	jr nz, asm_37965
	call LoadMoveAnim
	ld hl, wEnemyMoveStruct
	ldh a, [hBattleTurn]
	and a
	jr z, asm_3794a
	ld hl, wPlayerMoveStruct

asm_3794a:
	push af
	xor 1
	ldh [hBattleTurn], a
	ld a, [hli]
	push af
	ld a, [hl]
	push af
	push hl
	ld a, $32
	ld [hld], a
	xor a
	ld [hl], a
	call Function365bf
	pop hl
	pop af
	ld [hld], a
	pop af
	ld [hl], a
	pop af
	ldh [hBattleTurn], a
	ret

asm_37965:
	call BattleCommand_MoveDelay
	call Function37499
	jp asm_357a9

asm_3796e:
	ld hl, wca4b
	ldh a, [hBattleTurn]
	and a
	jr z, asm_37979
	ld hl, wca53

asm_37979:
	ld a, [wca3a]
	and a
	jr z, asm_37983
	call sub_37998
	ret

asm_37983:
	inc [hl]
	ld a, [hl]
	ld b, a

asm_37986:
	dec b
	jr z, asm_37997
	ld hl, wCurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	jr nc, asm_37986
	ld a, $ff
	ld [hli], a
	ld [hl], a

asm_37997:
	ret

sub_37998:
	push hl
	ld hl, wca4b
	ldh a, [hBattleTurn]
	and a
	jr z, asm_379a4
	ld hl, wca53

asm_379a4:
	xor a
	ld [hl], a
	pop hl
	ret

asm_379a8:
	ld a, [wBattleMonSpecies]
	ld [wCurSpecies], a
	call GetBaseData
	xor a
	ld [wMonType], a
	callfar GetGender
	push af
	ld a, [wEnemyMonSpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld a, TEMPMON
	ld [wMonType], a
	callfar GetGender
	push af
	pop bc
	ld a, c
	pop bc
	xor c
	bit 4, a
	jr z, asm_37a0b
	ld hl, wEnemySubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, asm_379e8
	ld hl, wPlayerSubStatus1

asm_379e8:
	call sub_37e0d
	jr nz, asm_37a0b
	bit 7, [hl]
	jr nz, asm_37a0b
	set 7, [hl]
	call LoadMoveAnim
	ld hl, FellInLoveText
	jp PrintText

FellInLoveText:
	text "<TARGET>は"
	line "メロメロに　なった！"
	prompt

asm_37a0b:
	call BattleCommand_MoveDelay
	jp Function37499

BattleCommand_HappinessPower::
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

asm_37a3a:
	ld a, [wca3a]
	and a
	ret nz
	push bc
	call BattleRandom
	ld b, a
	ld hl, Data37a85
	ld c, 0

asm_37a49:
	ld a, [hli]
	cp $ff
	jr z, asm_37a5f
	cp b
	jr nc, asm_37a55
	inc c
	inc hl
	jr asm_37a49

asm_37a55:
	xor a
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld d, [hl]
	pop bc
	ret

asm_37a5f:
	pop bc
	ld a, 1
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	callfar sub_3c7b0
	pop af
	ldh [hBattleTurn], a
	callfar sub_3c808
	jp asm_357a9

Data37a85:
	db $66
	db $28
	db $b3
	db $50
	db $cc
	db $78
	db $ff

BattleCommand_FrustrationPower::
	push bc
	ld hl, wBattleMonHappiness
	ldh a, [hBattleTurn]
	and a
	jr z, .got_happiness
	ld hl, wEnemyMonHappiness

.got_happiness:
	ld a, [hl]
	cp 70
	ld d, 30
	jr nc, .happiness_higher_than_70
	ld b, a
	ld a, 100
	sub b
	ld d, a

.happiness_higher_than_70:
	pop bc
	ret

asm_37aa6:
	ld hl, wcadd
	ld de, wcadf
	ldh a, [hBattleTurn]
	and a
	jr z, asm_37ab7
	ld hl, wcade
	ld de, wcae0

asm_37ab7:
	ld a, [wca3a]
	and a
	jr nz, asm_37ae3
	bit 2, [hl]
	jr nz, asm_37ae3
	set 2, [hl]
	ld a, 5
	ld [de], a
	call LoadMoveAnim
	ld hl, text_37acf
	jp PrintText

text_37acf:
	db $0
	db $5a
	db $ca
	db $4f
	db $bc
	db $de
	db $45
	db $c9
	db $3d
	db $e3
	db $a6
	db $c6
	db $7f
	db $c2
	db $c2
	db $cf
	db $da
	db $c0
	db $e7
	db $58

asm_37ae3:
	call BattleCommand_MoveDelay
	jp Function37499

SafeCheckSafeguard:
	ld hl, wEnemyScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_turn
	ld hl, wPlayerScreens

.got_turn:
	bit SCREENS_SAFEGUARD, [hl]
	ret

asm_37af7:
	ld hl, wcade
	ldh a, [hBattleTurn]
	and a
	jr z, asm_37b02
	ld hl, wcadd

asm_37b02:
	bit 2, [hl]
	ret z
	ld a, 1
	ld [wca3a], a
	call BattleCommand_MoveDelay
	ld hl, text_37b13
	jp PrintText

text_37b13:
	db $0
	db $59
	db $ca
	db $4f
	db $bc
	db $de
	db $45
	db $c9
	db $3d
	db $e3
	db $a6
	db $c6
	db $7f
	db $cf
	db $d3
	db $d7
	db $da
	db $c3
	db $b2
	db $d9
	db $e7
	db $58

asm_37b29:
	push bc
	call BattleRandom
	ld b, a
	ld hl, Data37b5d

asm_37b31:
	ld a, [hli]
	cp b
	jr nc, asm_37b39
	inc hl
	inc hl
	jr asm_37b31

asm_37b39:
	ld d, [hl]
	push de
	inc hl
	ld a, [hl]
	ld [wNumSetBits], a
	call BattleCommand_MoveDelay
	ld hl, MagnitudeText
	call PrintText
	pop de
	pop bc
	ret

MagnitudeText:
	text "マグニチュード@"
	deciram wNamedObjectIndexBuffer, 1, 1
	text "！！"
	prompt

Data37b5d:
	db $d
	db $a
	db $4
	db $26
	db $1e
	db $5
	db $59
	db $32
	db $6
	db $a6
	db $46
	db $7
	db $d9
	db $5a
	db $8
	db $f2
	db $6e
	db $9
	db $ff
	db $96
	db $a

asm_37b72:
	ldh a, [hBattleTurn]
	and a
	jp nz, asm_37c02
	ld de, wPartySpecies
	ld hl, wPartyMon1HP
	ld bc, 0

asm_37b81:
	ld a, [de]
	inc de
	cp $ff
	jr z, asm_37b9c
	ld a, [wCurBattleMon]
	cp c
	jr z, asm_37b93
	ld a, [hli]
	or b
	ld b, a
	ld a, [hld]
	or b
	ld b, a

asm_37b93:
	push bc
	ld bc, (wPartyMon2 - wPartyMon1)
	add hl, bc
	pop bc
	inc c
	jr asm_37b81

asm_37b9c:
	ld a, b
	and a
	jp z, asm_37c63
	call LoadMoveAnim
	call LoadStandardMenuHeader
	ld a, 2
	ld [wcdb9], a
	predef PartyMenuInBattle_Setup

asm_37bb1:
	jr c, asm_37bc2
	ld hl, wCurBattleMon
	ld a, [wCurPartyMon]
	cp [hl]
	jr nz, asm_37bc9
	ld hl, BattleText_MonIsAlreadyOut
	call PrintText

asm_37bc2:
	predef PartyMenuInBattle
	jr asm_37bb1

asm_37bc9:
	callfar HasMonFainted
	jr z, asm_37bc2
	call ClearPalettes
	callfar Function3e3a7
	call CloseWindow
	call ClearSprites
	ld hl, wTileMap + 1
	ld bc, $040a
	call ClearBox
	ld b, 1
	call GetSGBLayout
	call SetPalettes
	call sub_37c4c
	callfar asm_3da1c
	jr asm_37c4b

asm_37c02:
	ld a, [wBattleMode]
	dec a
	jr z, asm_37c63
	ld de, wOTPartySpecies
	ld hl, wOTPartyMon1HP
	ld bc, 0

asm_37c11:
	ld a, [de]
	inc de
	cp $ff
	jr z, asm_37c2c
	ld a, [wCurOTMon]
	cp c
	jr z, asm_37c23
	ld a, [hli]
	or b
	ld b, a
	ld a, [hld]
	or b
	ld b, a

asm_37c23:
	push bc
	ld bc, $30
	add hl, bc
	pop bc
	inc c
	jr asm_37c11

asm_37c2c:
	ld a, b
	and a
	jr z, asm_37c63
	call LoadMoveAnim
	call sub_37c4c
	callfar sub_3cd6e
	ld a, 1
	ld [wNumSetBits], a
	callfar sub_3e2c6

asm_37c4b:
	ret

sub_37c4c:
	ld a, [wLinkMode]
	and a
	ret z
	ld a, 1
	ld [wFieldMoveSucceeded], a
	callfar sub_3df8b
	xor a
	ld [wFieldMoveSucceeded], a
	ret

asm_37c63:
	call BattleCommand_MoveDelay
	jp Function37499

BattleText_MonIsAlreadyOut:
	text_from_ram wBattleMonNickname
	text "はもうでています"
	prompt


asm_37c76:
	ret

asm_37c77:
	ld hl, wEnemySubStatus3
	ldh a, [hBattleTurn]
	and a
	jr z, asm_37c82
	ld hl, wPlayerSubStatus3

asm_37c82:
	bit 5, [hl]
	ret z
	res 5, [hl]
	ld hl, ReleasedByText
	call PrintText
	ret

ReleasedByText:
	text "<USER>は　<TARGET>の"
	line "こうげきから　かいほうされた！"
	prompt


asm_37ca5:
	ld de, $0303
	jr asm_37cb2

asm_37caa:
	ld de, 0
	jr asm_37cb2

asm_37caf:
	ld de, $0102

asm_37cb2:
	push de
	callfar Function3c7f2
	pop de
	ld a, [wTimeOfDay]
	cp d
	jr z, asm_37cd0
	ld a, [wTimeOfDay]
	cp e
	jr z, asm_37cd0
	callfar Function3c7d3

asm_37cd0:
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
	callfar sub_3c808
	pop af
	ldh [hBattleTurn], a
	ld hl, text_37d0e
	call PrintText
	ret

text_37d0e:
	db $0
	db $5a
	db $ca
	db $7f
	db $c0
	db $b2
	db $d8
	db $e2
	db $b8
	db $dd
	db $4f
	db $b6
	db $b2
	db $cc
	db $b8
	db $bc
	db $c0
	db $e7
	db $58

asm_37d21:
	ld a, [wca3a]
	and a
	ret nz
	push bc
	ld hl, wBattleMonDVs
	ld bc, wPlayerMoveStructType
	ldh a, [hBattleTurn]
	and a
	jr z, asm_37d38
	ld hl, wEnemyMonDVs
	ld bc, wEnemyMoveStructType

asm_37d38:
	push bc
	ld a, [hl]
	swap a
	and 8
	ld b, a
	ld a, [hli]
	and 8
	srl a
	or b
	ld b, a
	ld a, [hl]
	swap a
	and 8
	srl a
	srl a
	or b
	ld b, a
	ld a, [hl]
	and 8
	srl a
	srl a
	srl a
	or b
	ld b, a
	add a
	add a
	add b
	ld b, a
	ld a, [hld]
	and 3
	add b
	ld d, a
	ld a, [hl]
	and 3
	ld b, a
	ld a, [hl]
	and $30
	swap a
	sla a
	sla a
	or b
	inc a
	cp 6
	jr c, asm_37d7f
	inc a
	cp $a
	jr c, asm_37d7f
	add $a

asm_37d7f:
	pop bc
	ld [bc], a
	pop bc
	ret

asm_37d83:
	ld a, [wca3a]
	and a
	jr nz, asm_37da8
	ld a, 1
	ld [wcae2], a
	ld a, 5
	ld [wcae3], a
	call LoadMoveAnim
	ld hl, text_37d9c
	jp PrintText

text_37d9c:
	db $0
	db $b5
	db $b5
	db $b1
	db $d2
	db $c6
	db $7f
	db $c5
	db $df
	db $c0
	db $e7
	db $58

asm_37da8:
	call BattleCommand_MoveDelay
	jp Function37499

asm_37dae:
	ld a, [wca3a]
	and a
	jr nz, asm_37dd5
	ld a, 2
	ld [wcae2], a
	ld a, 5
	ld [wcae3], a
	call LoadMoveAnim
	ld hl, text_37dc7
	jp PrintText

text_37dc7:
	db $0
	db $cb
	db $2b
	db $bc
	db $26
	db $7f
	db $c2
	db $d6
	db $b8
	db $c5
	db $df
	db $c0
	db $e7
	db $58

asm_37dd5:
	call BattleCommand_MoveDelay
	jp Function37499

sub_37ddb:
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonPP
	ld de, wPartyMon1PP
	ld a, [wcd40]
	jr z, asm_37df2
	ld hl, wEnemyMonPP
	ld de, wOTPartyMon1PP
	ld a, [wcac7]

asm_37df2:
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
	jr z, asm_37e05
	ld a, [wEnemyMonStatus]

asm_37e05:
	ld bc, $30
	call AddNTimes
	inc [hl]
	ret

sub_37e0d:
	push hl
	ld hl, wEnemySubStatus3
	ldh a, [hBattleTurn]
	and a
	jr z, asm_37e19
	ld hl, wPlayerSubStatus3

asm_37e19:
	bit 6, [hl]
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
	; jump is redundant in current arrangement, falls through

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

ConsumableEffects:
	db HELD_BERRY
	db HELD_2
	db HELD_5

	db HELD_HEAL_POISON
	db HELD_HEAL_FREEZE
	db HELD_HEAL_BURN
	db HELD_HEAL_SLEEP
	db HELD_HEAL_PARALYZE
	db HELD_HEAL_STATUS

	db HELD_30
	db HELD_ATTACK_UP
	db HELD_DEFENSE_UP
	db HELD_SPEED_UP
	db HELD_SP_ATTACK_UP
	db HELD_SP_DEFENSE_UP
	db HELD_ACCURACY_UP
	db HELD_EVASION_UP
	db HELD_38

	db HELD_71
	db HELD_ESCAPE
	db HELD_CRITICAL_UP
	db -1

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
	ld a, [wca7c]
	ld h, a
	ld a, [wca7b]
	ld l, a
.loop
	ld a, [hli]
	cp b
	jr nz, .loop
	ld a, h
	ld [wca7c], a
	ld a, l
	ld [wca7b], a
	ret

