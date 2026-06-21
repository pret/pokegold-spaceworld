INCLUDE "constants.asm"

SECTION "engine/battle/ai/items.asm", ROMX

; Trainers' item and switch AI is still completely unchanged from Generation I.
; In practice, though, since the wTrainerClass gets overwritten with 0 or 1 at some point,
; the opponent will always use GenericAI.
AI_SwitchOrTryItem::
	and a
	ld a, [wBattleMode]
	dec a
	ret z
	ld a, [wLinkMode]
	and a
	ret nz
	ld a, [wTrainerClass]
	dec a
	ld c, a
	ld b, 0
	ld hl, TrainerAIPointers
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [wEnemyItemState]
	and a
	ret z
	inc hl
	inc a
	jr nz, .getpointer
	dec hl
	ld a, [hli]
	ld [wEnemyItemState], a
.getpointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call Random
	jp hl
	
INCLUDE "data/trainers/ai_pointers.inc"

JugglerAI:
	cp 25 percent + 1
	ret nc
	jp AISwitchIfEnoughMons

BlackbeltAI:
	cp 13 percent - 1 ; 12.5%
	ret nc
	jp AIUseXAttack

GiovanniAI:
	cp 25 percent + 1
	ret nc
	jp AIUseGuardSpec

CooltrainerMAI:
	cp 25 percent + 1
	ret nc
	jp AIUseXAttack

CooltrainerFAI:
	; The intended 25% chance to consider switching will not apply.
	; Uncomment the line below to fix this.
	cp 25 percent + 1
	; ret nc
	ld a, 10
	call AICheckIfHPBelowFraction
	jp c, AIUseHyperPotion
	ld a, 5
	call AICheckIfHPBelowFraction
	ret nc
	jp AISwitchIfEnoughMons

BrockAI:
	ld a, [wEnemyMonStatus]
	and a
	ret z
	jp AIUseFullHeal

MistyAI:
	cp 25 percent + 1
	ret nc
	jp AIUseXDefend

LtSurgeAI:
	cp 25 percent + 1
	ret nc
	jp AIUseXSpeed

ErikaAI:
	cp 50 percent + 1
	ret nc
	ld a, 10
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseSuperPotion

KogaAI:
	cp 25 percent + 1
	ret nc
	jp AIUseXAttack

BlaineAI:
	cp 25 percent + 1
	ret nc
	jp AIUseSuperPotion

SabrinaAI:
	cp 25 percent + 1
	ret nc
	ld a, 10
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseHyperPotion

Rival2AI:
	cp $20
	ret nc
	ld a, 5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUsePotion

Rival3AI:
	cp 13 percent - 1
	ret nc
	ld a, 5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseFullRestore

LoreleiAI:
	cp 50 percent + 1
	ret nc
	ld a, 5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseSuperPotion

BrunoAI:
	cp 25 percent + 1
	ret nc
	jp AIUseXDefend

AgathaAI:
	cp 8 percent
	jp c, AISwitchIfEnoughMons
	cp 50 percent + 1
	ret nc
	ld a, 4
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseSuperPotion

LanceAI:
	cp 50 percent + 1
	ret nc
	ld a, 5
	call AICheckIfHPBelowFraction
	ret nc
	jp AIUseHyperPotion

GenericAI:
	and a ; clear carry
	ret

; end of individual trainer AI routines

DecrementEnemyItemState:
	ld hl, wEnemyItemState
	dec [hl]
	scf
	ret

AIPlayRestoringSFX:
	push de
	ld de, SFX_FULL_HEAL
	call PlaySFX
	pop de
	ret

AIUseFullRestore:
	call AICureStatus
	ld a, ITEM_FULL_RESTORE_RED
	ld [wEnemyItemUsed], a
	ld de, wHPBarOldHP
	ld hl, wEnemyMonHP + 1
	ld a, [hld]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	ld hl, wEnemyMonMaxHP + 1
	ld a, [hld]
	ld [de], a
	inc de
	ld [wHPBarMaxHP], a
	ld [wEnemyMonHP + 1], a
	ld a, [hl]
	ld [de], a
	ld [wHPBarMaxHP+1], a
	ld [wEnemyMonHP], a
	jr PrintText_UsedItemOn_AND_AIUpdateHUD

AIUsePotion:
; enemy trainer heals his monster with a potion
	ld a, ITEM_POTION_RED
	ld b, 20
	jr AIRecoverHP

AIUseSuperPotion:
; enemy trainer heals his monster with a super potion
	ld a, ITEM_SUPER_POTION_RED
	ld b, 50
	jr AIRecoverHP

AIUseHyperPotion:
; enemy trainer heals his monster with a hyper potion
	ld a, ITEM_HYPER_POTION_RED
	ld b, 200
	; fallthrough

AIRecoverHP:
; heal b HP and print "trainer used $(a) on pokemon!"
	ld [wEnemyItemUsed], a
	ld hl, wEnemyMonHP + 1
	ld a, [hl]
	ld [wHPBarOldHP], a
	add b
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [hl]
	ld [wHPBarOldHP+1], a
	ld [wHPBarNewHP+1], a
	jr nc, .next
	inc a
	ld [hl], a
	ld [wHPBarNewHP+1], a
.next
	inc hl
	ld a, [hld]
	ld b, a
	ld de, wEnemyMonMaxHP + 1
	ld a, [de]
	dec de
	ld [wHPBarMaxHP], a
	sub b
	ld a, [hli]
	ld b, a
	ld a, [de]
	ld [wHPBarMaxHP+1], a
	sbc b
	jr nc, PrintText_UsedItemOn_AND_AIUpdateHUD
	inc de
	ld a, [de]
	dec de
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [de]
	ld [hl], a
	ld [wHPBarNewHP+1], a
	; fallthrough

PrintText_UsedItemOn_AND_AIUpdateHUD:
	call PrintText_UsedItemOn
	hlcoord 2, 2
	xor a
	ld [wWhichHPBar], a
	predef UpdateHPBar
	jp DecrementEnemyItemState

AISwitchIfEnoughMons:
; enemy trainer switches if there are 2 or more unfainted mons in party
	ld a, [wOTPartyCount]
	ld c, a
	ld hl, wOTPartyMon1HP

	ld d, 0 ; keep count of unfainted monsters

	; count how many monsters haven't fainted yet
.loop
	ld a, [hli]
	ld b, a
	ld a, [hld]
	or b
	jr z, .Fainted ; has monster fainted?
	inc d
.Fainted
	push bc
	ld bc, wOTPartyMon2 - wOTPartyMon1
	add hl, bc
	pop bc
	dec c
	jr nz, .loop

	ld a, d ; how many available monsters are there?
	cp 2    ; don't bother if only 1
	jp nc, AI_Switch
	and a
	ret

AI_Switch:
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Status
	ld bc, wOTPartyMon2 - wOTPartyMon1
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wEnemyMonStatus
	ld bc, wEnemyMonMaxHP - wEnemyMonStatus
	call CopyBytes

	ld hl, .EnemyWithdrewText
	call PrintText
	ld a, 1
	ld [wBattleHasJustStarted], a
	callfar EnemySwitch
	xor a
	ld [wBattleHasJustStarted], a
	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	ret z
	scf
	ret

.EnemyWithdrewText:
	text_from_ram wOTClassName
	text "は"
	line "@"
	text_from_ram wEnemyMonNickname
	text "をひっこめた！"
	prompt

AIUseFullHeal:
	call AIPlayRestoringSFX
	call AICureStatus
	ld a, ITEM_FULL_HEAL_RED
	jp AIPrintItemUse

AICureStatus:
; cures the status of enemy's active pokemon
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Status
	ld bc, wOTPartyMon2 - wOTPartyMon1
	call AddNTimes
	xor a
	ld [hl], a ; clear status in enemy team roster
	ld [wEnemyMonStatus], a ; clear status of active enemy
	ld hl, wEnemySubStatus5
	res SUBSTATUS_TOXIC, [hl]
	ret

; Unreferenced
AIUseXAccuracy:
	call AIPlayRestoringSFX
	ld hl, wEnemySubStatus4
	set SUBSTATUS_X_ACCURACY, [hl]
	ld a, ITEM_X_ACCURACY_RED
	jp AIPrintItemUse

AIUseGuardSpec:
	call AIPlayRestoringSFX
	ld hl, wEnemySubStatus4
	set SUBSTATUS_MIST, [hl]
	ld a, ITEM_GUARD_SPEC_RED
	jp AIPrintItemUse

AIUseDireHit: ; unused
	call AIPlayRestoringSFX
	ld hl, wEnemySubStatus4
	set SUBSTATUS_FOCUS_ENERGY, [hl]
	ld a, ITEM_DIRE_HIT_RED
	jp AIPrintItemUse

AICheckIfHPBelowFraction:
; return carry if enemy trainer's current HP is below 1 / a of the maximum
	ldh [hDivisor], a
	ld hl, wEnemyMonMaxHP
	ld a, [hli]
	ldh [hDividend], a
	ld a, [hl]
	ldh [hDividend + 1], a
	ld b, 2
	call Divide
	ldh a, [hQuotient + 3]
	ld c, a
	ldh a, [hQuotient + 2]
	ld b, a
	ld hl, wEnemyMonHP + 1
	ld a, [hld]
	ld e, a
	ld a, [hl]
	ld d, a
	ld a, d
	sub b
	ret nz
	ld a, e
	sub c
	ret

AIUseXAttack:
	ld b, EFFECT_ATTACK_UP
	ld a, ITEM_X_ATTACK_RED
	jr AIIncreaseStat

AIUseXDefend:
	ld b, EFFECT_DEFENSE_UP
	ld a, ITEM_X_DEFEND_RED
	jr AIIncreaseStat

AIUseXSpeed:
	ld b, EFFECT_SPEED_UP
	ld a, ITEM_X_SPEED_RED
	jr AIIncreaseStat

AIUseXSpecial:
	ld b, EFFECT_SP_ATK_UP
	ld a, ITEM_X_SPECIAL_RED
	; fallthrough

AIIncreaseStat:
	ld [wEnemyItemUsed], a
	push bc
	call PrintText_UsedItemOn
	pop bc
	ld hl, wEnemyMoveStructEffect
	ld a, [hld]
	push af
	ld a, [hl]
	push af
	push hl
	ld a, $af ; XSTATITEM_DUPLICATE_ANIM in pokered
	ld [hli], a
	ld [hl], b
; Tries to call it from the wrong bank. It's in bank $d, not $f.
	ld hl, BattleCommand_StatUp
	ld a, $f
	call FarCall_hl

	pop hl
	pop af
	ld [hli], a
	pop af
	ld [hl], a
	jp DecrementEnemyItemState

AIPrintItemUse:
	ld [wEnemyItemUsed], a
	call PrintText_UsedItemOn
	jp DecrementEnemyItemState

PrintText_UsedItemOn:
; print "x used [wEnemyItemUsed] on z!"
	ld a, [wEnemyItemUsed]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	ld hl, .EnemyUsedOnText
	jp PrintText

.EnemyUsedOnText
	text_from_ram wOTClassName
	text "は　@"
	text_from_ram wEnemyMonNickname
	text "に"
	line "@"
	text_from_ram wStringBuffer1
	text "を　つかった"
	prompt
