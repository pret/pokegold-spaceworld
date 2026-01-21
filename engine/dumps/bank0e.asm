INCLUDE "constants.asm"

SECTION "engine/dumps/bank0e.asm", ROMX

; START OF: engine/battle/ai/items.asm

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

TrainerAIPointers:
	; one entry per trainer class
	; first byte, number of times (per Pokémon) it can occur
	; next two bytes, pointer to AI subroutine for trainer class
	; subroutines are defined in engine/battle/trainer_ai.asm
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, JugglerAI ; unused_juggler
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, GenericAI
	dbw 3, JugglerAI ; juggler
	dbw 3, GenericAI ; This build's youngster
	dbw 3, GenericAI
	dbw 2, BlackbeltAI ; blackbelt
	dbw 3, GenericAI ; rival1 / Lass
	dbw 3, GenericAI
	dbw 1, GenericAI ; chief
	dbw 3, GenericAI
	dbw 1, GiovanniAI ; giovanni / Beauty
	dbw 3, GenericAI
	dbw 2, CooltrainerMAI ; cooltrainerm
	dbw 1, CooltrainerFAI ; cooltrainerf
	dbw 2, BrunoAI ; bruno
	dbw 5, BrockAI ; brock
	dbw 1, MistyAI ; misty
	dbw 1, LtSurgeAI ; surge / this build's Bug Catchers
	dbw 1, ErikaAI ; erika / Fisherman
	dbw 2, KogaAI ; koga
	dbw 2, BlaineAI ; blaine
	dbw 1, SabrinaAI ; sabrina
	dbw 3, GenericAI
	dbw 1, Rival2AI ; rival2
	dbw 1, Rival3AI ; rival3
	dbw 2, LoreleiAI ; lorelei
	dbw 3, GenericAI
	dbw 2, AgathaAI ; agatha
	dbw 1, LanceAI ; lance

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

; START OF: "engine/battle/trainer_huds.asm"

BattleStart_TrainerHuds:
	call LoadBallIconGFX
	call ShowPlayerMonsRemaining
	ld a, [wBattleMode]
	dec a
	ret z
	jp ShowOTTrainerMonsRemaining

EnemySwitch_TrainerHud:
	call LoadBallIconGFX
	jp ShowOTTrainerMonsRemaining

ShowPlayerMonsRemaining:
	call DrawPlayerPartyIconHUDBorder
	ld hl, wPartyMon1HP
	ld de, wPartyCount
	call StageBallTilesData
	; ldpixel wPlaceBallsX, 12, 12
	ld a, 12 * TILE_WIDTH
	ld hl, wPlaceBallsX
	ld [hli], a
	ld [hl], a
	ld a, TILE_WIDTH
	ld [wPlaceBallsDirection], a
	ld hl, wShadowOAMSprite00
	jp LoadTrainerHudOAM

ShowOTTrainerMonsRemaining:
	call DrawEnemyHUDBorder
	ld hl, wOTPartyMon1HP
	ld de, wOTPartyCount
	call StageBallTilesData
	; ldpixel wPlaceBallsX, 9, 4
	ld hl, wPlaceBallsX
	ld a, 9 * TILE_WIDTH
	ld [hli], a
	ld [hl], 4 * TILE_WIDTH
	ld a, -TILE_WIDTH
	ld [wPlaceBallsDirection], a
	ld hl, wShadowOAMSprite00 + PARTY_LENGTH * SPRITEOAMSTRUCT_LENGTH
	jp LoadTrainerHudOAM

StageBallTilesData:
	ld a, [de]
	push af
	ld de, wBattleHUDTiles
	ld c, PARTY_LENGTH
	ld a, $34 ; empty slot
.loop1
	ld [de], a
	inc de
	dec c
	jr nz, .loop1
	pop af

	ld de, wBattleHUDTiles
.loop2
	push af
	call .GetHUDTile
	inc de
	pop af
	dec a
	jr nz, .loop2
	ret

.GetHUDTile:
	ld a, [hli]
	and a
	jr nz, .got_hp
	ld a, [hl]
	and a
	ld b, $33 ; fainted
	jr z, .fainted
.got_hp
	dec hl
	dec hl
	dec hl
	ld a, [hl]
	and a
	ld b, $32 ; statused
	jr nz, .load
	dec b
	jr .load

.fainted
	dec hl
	dec hl
	dec hl
.load
	ld a, b
	ld [de], a
	ld bc, PARTYMON_STRUCT_LENGTH + MON_HP - MON_STATUS
	add hl, bc
	ret

DrawPlayerHUDBorder::
	ld hl, .tiles
	ld de, wTrainerHUDTiles
	ld bc, .tiles_end - .tiles
	call CopyBytes
	hlcoord 18, 10
	ld de, -1
	jr PlaceHUDBorderTiles

.tiles
	db $73 ; right side
	db $77 ; bottom right
	db $6f ; bottom left
	db $76 ; bottom side
.tiles_end

DrawPlayerPartyIconHUDBorder:
	ld hl, .tiles
	ld de, wTrainerHUDTiles
	ld bc, .tiles_end - .tiles
	call CopyBytes
	hlcoord 18, 10
	ld de, -1 ; start on right
	jr PlaceHUDBorderTiles

.tiles
	db $73 ; right side
	db $5c ; bottom right
	db $6f ; bottom left
	db $76 ; bottom side
.tiles_end

DrawEnemyHUDBorder:
	ld hl, .tiles
	ld de, wTrainerHUDTiles
	ld bc, .tiles_end - .tiles
	call CopyBytes
	hlcoord 1, 2
	ld de, 1 ; start on left
	jr PlaceHUDBorderTiles

.tiles
	db $6d ; left side
	db $74 ; bottom left
	db $78 ; bottom right
	db $76 ; bottom side
.tiles_end

PlaceHUDBorderTiles::
	ld a, [wTrainerHUDTiles]
	ld [hl], a
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld a, [wTrainerHUDTiles + 1]
	ld [hl], a
	ld b, 8
.loop
	add hl, de
	ld a, [wTrainerHUDTiles + 3]
	ld [hl], a
	dec b
	jr nz, .loop
	add hl, de
	ld a, [wTrainerHUDTiles + 2]
	ld [hl], a
	ret

LinkBattle_TrainerHuds::
	call LoadBallIconGFX
	ld hl, wPartyMon1HP
	ld de, wPartyCount
	call StageBallTilesData
	ld hl, wPlaceBallsX
	ld a, 10 * TILE_WIDTH
	ld [hli], a
	ld [hl], 8 * TILE_WIDTH
	ld a, TILE_WIDTH
	ld [wPlaceBallsDirection], a
	ld hl, wShadowOAMSprite00
	call LoadTrainerHudOAM

	ld hl, wOTPartyMon1HP
	ld de, wOTPartyCount
	call StageBallTilesData

	ld hl, wPlaceBallsX
	ld a, 10 * TILE_WIDTH
	ld [hli], a
	ld [hl], 12 * TILE_WIDTH
	ld hl, wShadowOAMSprite00 + PARTY_LENGTH * SPRITEOAMSTRUCT_LENGTH
	jp LoadTrainerHudOAM

LoadTrainerHudOAM:
	ld de, wBattleHUDTiles
	ld c, PARTY_LENGTH
.loop
	ld a, [wPlaceBallsY]
	ld [hli], a ; y
	ld a, [wPlaceBallsX]
	ld [hli], a ; x
	ld a, [de]
	ld [hli], a ; tile id
	xor a
	ld [hli], a ; tile attributes
	ld a, [wPlaceBallsX]
	ld b, a
	ld a, [wPlaceBallsDirection]
	add b
	ld [wPlaceBallsX], a
	inc de
	dec c
	jr nz, .loop
	ret

LoadBallIconGFX:
	ld de, PokeBallsGFX
	ld hl, vChars0 tile $31
	lb bc, 14, 4
	jp Request2bpp

PokeBallsGFX:: INCBIN "gfx/misc/poke_balls.2bpp"

; START: engine/battle/ai/move.asm

; Score each move of wEnemyMonMoves in wEnemyAIMoveScores. Lower is better.
; Pick the move with the lowest score.
AIChooseMove::
	; The default score is 20. Unusable moves are given a score of 80.
	ld a, 20
	ld hl, wEnemyAIMoveScores
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a

; Don't pick disabled moves.
	ld a, [wEnemyDisableCount]
	swap a
	and $f
	jr z, .CheckPP

	ld hl, wEnemyAIMoveScores
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld [hl], 80

; Don't pick moves with 0 PP.
.CheckPP:
	ld hl, wEnemyAIMoveScores - 1
	ld de, wEnemyMonPP
	ld b, 0
.CheckMovePP:
	inc b
	ld a, b
	cp NUM_MOVES + 1
	jr z, .ApplyLayers
	inc hl
	ld a, [de]
	inc de
	and PP_MASK
	jr nz, .CheckMovePP
	ld [hl], 80
	jr .CheckMovePP

.ApplyLayers:
	ld hl, TrainerClassAttributes + TRNATTR_AI_MOVE_WEIGHTS
	ld a, [wTrainerClass]
	dec a
	ld bc, NUM_TRAINER_ATTRIBUTES
	call AddNTimes
	lb bc, CHECK_FLAG, 0
	push bc
	push hl

.CheckLayer:
	pop hl
	pop bc

	ld a, c
	cp MAX_TRAINER_AI ; up to 24 scoring layers
	jr z, .DecrementScores

	push bc
	ld d, BANK(TrainerClassAttributes)
	predef SmallFarFlagAction
	ld d, c
	pop bc

	inc c
	push bc
	push hl

	ld a, d
	and a
	jr z, .CheckLayer

	ld hl, AIScoringPointers
	dec c
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .CheckLayer
	push de
	jp hl
	
; Decrement the scores of all moves one by one until one reaches 0.
.DecrementScores:
	ld hl, wEnemyAIMoveScores
	ld de, wEnemyMonMoves
	ld c, NUM_MOVES

.DecrementNextScore:
	; If the enemy has no moves, this will infinite.
	ld a, [de]
	inc de
	and a
	jr z, .DecrementScores

	; We are done whenever a score reaches 0
	dec [hl]
	jr z, .PickLowestScoreMoves

	; If we just decremented the fourth move's score, go back to the first move
	inc hl
	dec c
	jr z, .DecrementScores

	jr .DecrementNextScore

; In order to avoid bias towards the moves located first in memory, increment the scores
; that were decremented one more time than the rest (in case there was a tie).
; This means that the minimum score will be 1.
.PickLowestScoreMoves:
	ld a, c

.move_loop
	inc [hl]
	dec hl
	inc a
	cp NUM_MOVES + 1
	jr nz, .move_loop

	ld hl, wEnemyAIMoveScores
	ld de, wEnemyMonMoves
	ld c, NUM_MOVES

; Give a score of 0 to a blank move
.loop2
	ld a, [de]
	and a
	jr nz, .skip_load
	ld [hl], a

; Disregard the move if its score is not 1
.skip_load
	ld a, [hl]
	dec a
	jr z, .keep
	xor a
	ld [hli], a
	jr .after_toss

.keep
	ld a, [de]
	ld [hli], a
.after_toss
	inc de
	dec c
	jr nz, .loop2

; Randomly choose one of the moves with a score of 1
.ChooseMove:
	ld hl, wEnemyAIMoveScores
	call Random
	maskbits NUM_MOVES
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	jr z, .ChooseMove

	ld [wCurEnemyMove], a
	ld a, c
	ld [wCurEnemyMoveNum], a
	ret

AIScoringPointers:
; entries correspond to AI_* constants
	dw AI_Basic
	dw AI_Setup
	dw AI_Types
	dw AI_Offensive_Placeholder
	dw AI_Smart
	dw AI_Opportunist
	dw AI_Aggressive
	dw AI_Cautious
rept MAX_TRAINER_AI - VALID_TRAINER_AI
	dw AI_None
endr

; START: engine/battle/ai/scoring.asm
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

; START: "engine/battle/read_trainer_attributes.asm"

GetOTName::
	ld hl, wOTPlayerName
	ld a, [wLinkMode]
	and a
	jr nz, .ok

	ld hl, wRivalName
	ld a, [wTrainerClass]
	cp TRAINER_RIVAL
	jr z, .ok

	ld hl, wPlayerName
	cp TRAINER_PROTAGONIST
	jr z, .ok

	ld [wCurSpecies], a
	ld a, TRAINER_NAME
	ld [wNamedObjectTypeBuffer], a
	call GetName
	ld hl, wStringBuffer1

.ok
	ld de, wOTClassName
	ld bc, TRAINER_CLASS_NAME_LENGTH
	jp CopyBytes

GetTrainerAttributes::
	call GetOTName
	ld a, [wTrainerClass]
	dec a
	ld hl, TrainerClassAttributes + TRNATTR_SPRITEPOINTER1
	ld bc, NUM_TRAINER_ATTRIBUTES
	call AddNTimes
	ld de, wEnemyTrainerGraphicsPointer
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld a, [hl]
	ld [wEnemyTrainerBaseReward], a
	ret

; Forces the opponent to use the protagonist front sprite.
Unreferenced_Function38bc6:
	ld hl, wEnemyTrainerGraphicsPointer
	ld de, ProtagonistPic
	ld [hl], e
	inc hl
	ld [hl], d
	ret

; START: data/trainers/attributes.inc

; Combination of pokered's TrainerPicAndMoneyPointers and the final game's TrainerClassAttributes.
; The money values are leftover from Generation I, where they used BCD, whereas this build reads it like a normal byte.
TrainerClassAttributes:
; TRAINER_HAYATO (originally Youngster)
	dw HayatoPic
	db 21 ; originally: 15
	littledt $ffff00 | AI_BASIC | AI_SETUP | AI_TYPES | AI_OFFENSIVE | AI_SMART | AI_OPPORTUNIST | AI_AGGRESSIVE | AI_CAUTIOUS
	db 0

; TRAINER_AKANE (originally Bug Catcher)
	dw AkanePic
	db 16 ; originally 10
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_TSUKUSHI (originally Lass)
	dw TsukushiPic
	db 21 ; originally 15
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_ENOKI (originally Sailor)
	dw EnokiPic
	db 48 ; originally 30
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_OKERA (originally Jr. Trainer Male)
	dw OkeraPic
	db 32 ; originally 20
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_MIKAN (originally Jr. Trainer Female)
	dw MikanPic
	db 32 ; originally 20
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_BLUE (originally Pokémaniac)
	dw BluePic
	db 80 ; originally 50
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_GAMA (originally SuperNerd)
	dw GamaPic
	db 37 ; originally 25
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_RIVAL (originally Hiker)
	dw RivalPic
	db 53 ; originally 35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_OKIDO (originally Biker)
	dw OakPic
	db $20
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_SAKAKI (originally Burglar)
	dw ProtagonistPic
	db $90
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_PROTAGONIST (originally Engineer)
	dw ProtagonistPic
	db 80 ; originally 50
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_SIBA (originally unused Juggler duplicate)
	dw KurtPic
	db 53 ; originally 35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_KASUMI (originally Fisher)
	dw KurtPic
	db 53 ; originally 35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_KANNA (originally Swimmer)
	dw KurtPic
	db 5
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_WATARU (originally Cue Ball)
	dw KurtPic
	db 37 ; originally 25
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_GERUGE_MEMBER_M (originally Gambler)
	dw KurtPic
	db 112 ; originally 70
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_TRIO_1 (originally Beauty)
	dw KurtPic
	db 112 ; originally 70
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_TRIO_2 (originally Psychic)
	dw KurtPic
	db 16 ; originally 10
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_TRIO_3 (originally Rocker)
	dw KurtPic
	db 37 ; originally 25
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_ROCKET_F (originally Juggler)
	dw YoungsterPic
	db 53 ; originally 35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_YOUNGSTER (originally Tamer)
	dw YoungsterPic
	db 64 ; originally 40
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_SCHOOLBOY (originally Bird Keeper)
	dw SchoolboyPic
	db 37 ; originally 25
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_FLEDGLING (originally Black Belt)
	dw FledglingPic
	db 37 ; originally 25
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_LASS (originally Rival 1)
	dw LassPic
	db 53 ; originally 35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_GENIUS (originally Prof. Oak)
	dw ProfessionalMPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_PROFESSIONAL_M (originally Chief)
	dw ProfessionalMPic
	db 48 ; originally 30
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_PROFESSIONAL_F (originally Scientist)
	dw ProfessionalFPic
	db 80 ; originally 50
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_BEAUTY (originally Giovanni)
	dw BeautyPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_POKEMANIAC (originally Rocket)
	dw PokemaniacPic
	db 48 ; originally 30
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_ROCKET_M (originally Cooltrainer Male)
	dw RocketMPic
	db 53 ; originally 35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_GENTLEMAN (originally Cooltrainer Female)
	dw TeacherMPic
	db 53 ; originally 35
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_TEACHER_M (originally Bruno)
	dw TeacherMPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_TEACHER_F (originally Brock)
	dw TeacherFPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_MANCHILD (originally Misty)
	dw BugCatcherBoyPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_BUG_CATCHER_BOY (originally Lt. Surge)
	dw BugCatcherBoyPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_FISHER (originally Erika)
	dw FisherPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_SWIMMER_M (originally Koga)
	dw SwimmerMPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_SWIMMER_F (originally Blaine)
	dw SwimmerFPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_SAILOR (originally Sabrina)
	dw SuperNerdPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_SUPER_NERD (originally Gentleman)
	dw SuperNerdPic
	db 112 ; originally 70
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_ENGINEER (originally Rival 2)
	dw EngineerPic
	db 101 ; originally 65
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_ROCKER (originally Rival 3)
	dw GreenPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_HIKER (originally Loreli)
	dw BikerPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_BIKER (originally Channeler)
	dw BikerPic
	db 48 ; originally 30
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_ROCK_CLIMBER (originally Agatha)
	dw BurglarPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_BURGLAR (originally Lance)
	dw BurglarPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; Everything beyond this point has no Generation I equivalent slot, so the money values are "unique".

; TRAINER_FIREBREATHER
	dw FirebreatherPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_JUGGLER
	dw JugglerPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_BLACKBELT
	dw BlackbeltPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_SPORTSMAN
	dw SportsmanPic
	db 112 ; originally 70
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_PSYCHIC
	dw MediumPic
	db 101 ; originally 65
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_KUNG_FU_MASTER
	dw MediumPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_FORTUNE_TELLER
	dw MediumPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_HOOLIGAN
	dw MediumPic
	db 48 ; originally 30
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_SAGE
	dw MediumPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_MEDIUM
	dw MediumPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_SOLDIER
	dw SoldierPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_GERUGE_MEMBER_F
	dw KimonoGirlPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_KIMONO_GIRL
	dw KimonoGirlPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

; TRAINER_TWINS
	dw TwinsPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_GERUGE_MEMBER_M_2
	dw TwinsPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_ELITE_FOUR_M
	dw TwinsPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0
	
; TRAINER_ELITE_FOUR_F
	dw TwinsPic
	db 153 ; originally 99
	littledt AI_BASIC | AI_SETUP | AI_TYPES
	db 0

SECTION "engine/dumps/bank0e.asm@ReadTrainerParty", ROMX

; START OF: "engine/battle/read_trainer_party.asm"

ReadTrainerParty::
	ld a, [wLinkMode]
	and a
	ret nz

	ld hl, wOTPartyCount
	xor a
	ld [hli], a
	dec a
	ld [hl], a

	ld hl, wOTPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH * PARTY_LENGTH
	xor a
	call ByteFill

	ld a, [wOtherTrainerClass]
	dec a
	ld c, a
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wOtherTrainerID]
	ld b, a
.skip_trainer
	dec b
	jr z, .got_trainer
.loop
	ld a, [hli]
	cp -1
	jr nz, .loop
	jr .skip_trainer
.got_trainer

.skip_name
	ld a, [hli]
	cp '@'
	jr nz, .skip_name

	ld a, [hli]
	ld c, a
	ld b, 0
	ld d, h
	ld e, l
	ld hl, TrainerTypes
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, .done
	push bc
	jp hl

.done
	jp ComputeTrainerReward

TrainerTypes:
	; entries correspond to TRAINERTYPE_* constants
	dw TrainerType1 ; level, species
	dw TrainerType2 ; level, species, moves
	dw TrainerType3 ; level, species, item
	dw TrainerType4 ; level, species, item, moves

TrainerType1:
; normal (level, species)
	ld h, d
	ld l, e
.loop
	ld a, [hli]
	cp $ff
	ret z

	ld [wCurPartyLevel], a
	ld a, [hli]
	ld [wCurPartySpecies], a
	ld a, OTPARTYMON
	ld [wMonType], a
	push hl
	predef TryAddMonToParty
	pop hl
	jr .loop

TrainerType2:
; moves
	ld h, d
	ld l, e
.loop
	ld a, [hli]
	cp $ff
	ret z

	ld [wCurPartyLevel], a
	ld a, [hli]
	ld [wCurPartySpecies], a
	ld a, OTPARTYMON
	ld [wMonType], a

	push hl
	predef TryAddMonToParty
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

	ld b, NUM_MOVES
.copy_moves
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copy_moves

	push hl

	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, MON_PP
	add hl, de
	push hl
	ld hl, MON_MOVES
	add hl, de
	pop de

	ld b, NUM_MOVES
.copy_pp
	ld a, [hli]
	and a
	jr z, .copied_pp

	push hl
	push bc
	dec a
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop bc
	pop hl

	ld [de], a
	inc de
	dec b
	jr nz, .copy_pp
.copied_pp

	pop hl
	jr .loop

TrainerType3:
; item
	ld h, d
	ld l, e
.loop
	ld a, [hli]
	cp $ff
	ret z

	ld [wCurPartyLevel], a
	ld a, [hli]
	ld [wCurPartySpecies], a
	ld a, OTPARTYMON
	ld [wMonType], a
	push hl
	predef TryAddMonToParty
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	ld a, [hli]
	ld [de], a
	jr .loop

TrainerType4:
; item + moves
	ld h, d
	ld l, e
.loop
	ld a, [hli]
	cp $ff
	ret z

	ld [wCurPartyLevel], a
	ld a, [hli]
	ld [wCurPartySpecies], a

	ld a, OTPARTYMON
	ld [wMonType], a

	push hl
	predef TryAddMonToParty
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

	ld a, [hli]
	ld [de], a

	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

	ld b, NUM_MOVES
.copy_moves
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copy_moves

	push hl

	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, MON_PP
	add hl, de

	push hl
	ld hl, MON_MOVES
	add hl, de
	pop de

	ld b, NUM_MOVES
.copy_pp
	ld a, [hli]
	and a
	jr z, .copied_pp

	push hl
	push bc
	dec a
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop bc
	pop hl

	ld [de], a
	inc de
	dec b
	jr nz, .copy_pp
.copied_pp

	pop hl
	jr .loop

ComputeTrainerReward:
	ld hl, hProduct
	xor a
	ld [hli], a
	ld [hli], a ; hMultiplicand + 0
	ld [hli], a ; hMultiplicand + 1
	ld a, [wEnemyTrainerBaseReward]
	ld [hli], a ; hMultiplicand + 2
	ld a, [wCurPartyLevel]
	ld [hl], a ; hMultiplier
	call Multiply
	ld hl, wBattleReward
	xor a
	ld [hli], a
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a
	ret

Battle_GetTrainerName:
	ld a, [wOtherTrainerClass]
	dec a
	ld c, a
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wOtherTrainerID]
	ld b, a

.loop
	dec b
	jr z, .CopyTrainerName

.skip
	ld a, [hli]
	cp $ff
	jr nz, .skip
	jr .loop

.CopyTrainerName:
	ld de, wStringBuffer1
	ld bc, STRING_BUFFER_LENGTH
	call CopyBytes
	ret
