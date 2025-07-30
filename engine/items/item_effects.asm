INCLUDE "constants.asm"

SECTION "engine/items/item_effects.asm", ROMX

_DoItemEffect::
	ld a, [wCurItem]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	call CopyStringToStringBuffer2
	ld a, 1
	ld [wItemEffectSucceeded], a
	ld a, [wCurItem]
	cp ITEM_TM01
	jp nc, AskTeachTMHM_Old
	ld hl, ItemEffects
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

ItemEffects:
; entries correspond to item ids (see constants/item_constants.asm)
	dw PokeBallEffect      ; ITEM_MASTER_BALL
	dw PokeBallEffect      ; ITEM_ULTRA_BALL
	dw NoEffect            ; ITEM_03
	dw PokeBallEffect      ; ITEM_GREAT_BALL
	dw PokeBallEffect      ; ITEM_POKE_BALL
	dw TownMapEffect       ; ITEM_TOWN_MAP 
	dw BicycleEffect       ; ITEM_BICYCLE
	dw EvoStoneEffect      ; ITEM_MOON_STONE
	dw StatusHealingEffect ; ITEM_ANTIDOTE
	dw StatusHealingEffect ; ITEM_BURN_HEAL
	dw StatusHealingEffect ; ITEM_ICE_HEAL
	dw StatusHealingEffect ; ITEM_AWAKENING
	dw StatusHealingEffect ; ITEM_PARLYZ_HEAL
	dw FullRestoreEffect   ; ITEM_FULL_RESTORE
	dw RestoreHPEffect     ; ITEM_MAX_POTION
	dw RestoreHPEffect     ; ITEM_HYPER_POTION
	dw RestoreHPEffect     ; ITEM_SUPER_POTION
	dw RestoreHPEffect     ; ITEM_POTION
	dw EscapeRopeEffect    ; ITEM_ESCAPE_ROPE
	dw RepelEffect         ; ITEM_REPEL
	dw RestorePPEffect     ; ITEM_MAX_ELIXER
	dw EvoStoneEffect      ; ITEM_FIRE_STONE
	dw EvoStoneEffect      ; ITEM_THUNDERSTONE
	dw EvoStoneEffect      ; ITEM_WATER_STONE
	dw NoEffect            ; ITEM_19
	dw VitaminEffect       ; ITEM_HP_UP
	dw VitaminEffect       ; ITEM_PROTEIN
	dw VitaminEffect       ; ITEM_IRON
	dw VitaminEffect       ; ITEM_CARBOS
	dw NoEffect            ; ITEM_1E
	dw VitaminEffect       ; ITEM_CALCIUM
	dw RareCandyEffect     ; ITEM_RARE_CANDY
	dw XAccuracyEffect     ; ITEM_X_ACCURACY
	dw EvoStoneEffect      ; ITEM_LEAF_STONE
	dw NoEffect            ; ITEM_23
	dw Stub_NuggetEffect   ; ITEM_NUGGET
	dw PokeDollEffect      ; ITEM_POKE_DOLL
	dw StatusHealingEffect ; ITEM_FULL_HEAL
	dw ReviveEffect        ; ITEM_REVIVE
	dw ReviveEffect        ; ITEM_MAX_REVIVE
	dw GuardSpecEffect     ; ITEM_GUARD_SPEC
	dw SuperRepelEffect    ; ITEM_SUPER_REPEL
	dw MaxRepelEffect      ; ITEM_MAX_REPEL
	dw DireHitEffect       ; ITEM_DIRE_HIT
	dw NoEffect            ; ITEM_2D
	dw RestoreHPEffect     ; ITEM_FRESH_WATER
	dw RestoreHPEffect     ; ITEM_SODA_POP
	dw RestoreHPEffect     ; ITEM_LEMONADE
	dw XItemEffect         ; ITEM_X_ATTACK
	dw NoEffect            ; ITEM_32
	dw XItemEffect         ; ITEM_X_DEFENSE
	dw XItemEffect         ; ITEM_X_SPEED
	dw XItemEffect         ; ITEM_X_SPECIAL
	dw CoinCaseEffect      ; ITEM_COIN_CASE
	dw PPUpEffect          ; ITEM_ITEMFINDER
	dw PokeFluteEffect     ; ITEM_POKE_FLUTE
	dw NoEffect            ; ITEM_EXP_SHARE
	dw OldRodEffect_Old    ; ITEM_OLD_ROD
	dw GoodRodEffect_Old   ; ITEM_GOOD_ROD
	dw NoEffect            ; ITEM_3C
	dw SuperRodEffect_Old  ; ITEM_SUPER_ROD
	dw PPUpEffect          ; ITEM_PP_UP
	dw RestorePPEffect     ; ITEM_ETHER
	dw RestorePPEffect     ; ITEM_MAX_ETHER
	dw RestorePPEffect     ; ITEM_ELIXER
	dw Dummy_NewItemEffect ; ITEM_MYSTIC_PETAL
	dw Dummy_NewItemEffect ; ITEM_WHITE_FEATHER
	dw Dummy_NewItemEffect ; ITEM_CONFUSE_CLAW
	dw Dummy_NewItemEffect ; ITEM_WISDOM_ORB
	dw Dummy_NewItemEffect ; ITEM_STEEL_SHELL
	dw Dummy_NewItemEffect ; ITEM_UP_GRADE
	dw Dummy_NewItemEffect ; ITEM_STRANGE_THREAD
	dw Dummy_NewItemEffect ; ITEM_BIG_LEAF
	dw Dummy_NewItemEffect ; ITEM_QUICK_NEEDLE
	dw Dummy_NewItemEffect ; ITEM_4B
	dw Dummy_NewItemEffect ; ITEM_SHARP_STONE
	dw Dummy_NewItemEffect ; ITEM_BLACK_FEATHER
	dw Dummy_NewItemEffect ; ITEM_SHARP_FANG
	dw Dummy_NewItemEffect ; ITEM_SNAKESKIN
	dw Dummy_NewItemEffect ; ITEM_ELECTRIC_POUCH
	dw Dummy_NewItemEffect ; ITEM_TOXIC_NEEDLE
	dw Dummy_NewItemEffect ; ITEM_KINGS_ROCK
	dw Dummy_NewItemEffect ; ITEM_STRANGE_POWER
	dw Dummy_NewItemEffect ; ITEM_LIFE_TAG
	dw Dummy_NewItemEffect ; ITEM_POISON_FANG
	dw Dummy_NewItemEffect ; ITEM_CORDYCEPS
	dw Dummy_NewItemEffect ; ITEM_DRAGON_FANG
	dw Dummy_NewItemEffect ; ITEM_SILVERPOWDER
	dw Dummy_NewItemEffect ; ITEM_DIGGING_CLAW
	dw Dummy_NewItemEffect ; ITEM_5A
	dw Dummy_NewItemEffect ; ITEM_AMULET_COIN
	dw Dummy_NewItemEffect ; ITEM_MIGRAINE_SEED
	dw Dummy_NewItemEffect ; ITEM_COUNTER_CUFF
	dw Dummy_NewItemEffect ; ITEM_TALISMAN_TAG
	dw Dummy_NewItemEffect ; ITEM_STRANGE_WATER
	dw Dummy_NewItemEffect ; ITEM_TWISTEDSPOON
	dw Dummy_NewItemEffect ; ITEM_ATTACK_NEEDLE
	dw Dummy_NewItemEffect ; ITEM_POWER_BRACER
	dw Dummy_NewItemEffect ; ITEM_HARD_STONE
	dw Dummy_NewItemEffect ; ITEM_64
	dw Dummy_NewItemEffect ; ITEM_JIGGLING_BALLOON
	dw Dummy_NewItemEffect ; ITEM_FIRE_MANE
	dw Dummy_NewItemEffect ; ITEM_SLOWPOKETAIL
	dw Dummy_NewItemEffect ; ITEM_EARTH
	dw Dummy_NewItemEffect ; ITEM_STICK
	dw Dummy_NewItemEffect ; ITEM_FLEE_FEATHER
	dw Dummy_NewItemEffect ; ITEM_ICE_FANG
	dw Dummy_NewItemEffect ; ITEM_FOSSIL_SHARD
	dw Dummy_NewItemEffect ; ITEM_GROSS_GARBAGE
	dw Dummy_NewItemEffect ; ITEM_BIG_PEARL
	dw Dummy_NewItemEffect ; ITEM_CHAMPION_BELT
	dw Dummy_NewItemEffect ; ITEM_TAG
	dw Dummy_NewItemEffect ; ITEM_SPELL_TAG
	dw Dummy_NewItemEffect ; ITEM_5_YEN_COIN
	dw Dummy_NewItemEffect ; ITEM_GUARD_THREAD
	dw Dummy_NewItemEffect ; ITEM_STIMULUS_ORB
	dw Dummy_NewItemEffect ; ITEM_CALM_BERRY
	dw Dummy_NewItemEffect ; ITEM_THICK_CLUB
	dw Dummy_NewItemEffect ; ITEM_FOCUS_ORB
	dw Dummy_NewItemEffect ; ITEM_78
	dw Dummy_NewItemEffect ; ITEM_DETECT_ORB
	dw Dummy_NewItemEffect ; ITEM_LONG_TONGUE
	dw Dummy_NewItemEffect ; ITEM_LOTTO_TICKET
	dw Dummy_NewItemEffect ; ITEM_EVERSTONE
	dw Dummy_NewItemEffect ; ITEM_SHARP_HORN
	dw Dummy_NewItemEffect ; ITEM_LUCKY_EGG
	dw Dummy_NewItemEffect ; ITEM_LONG_VINE
	dw Dummy_NewItemEffect ; ITEM_MOMS_LOVE
	dw Dummy_NewItemEffect ; ITEM_SMOKESCREEN
	dw Dummy_NewItemEffect ; ITEM_WET_HORN
	dw Dummy_NewItemEffect ; ITEM_SKATEBOARD
	dw Dummy_NewItemEffect ; ITEM_CRIMSON_JEWEL
	dw Dummy_NewItemEffect ; ITEM_INVISIBLE_WALL
	dw Dummy_NewItemEffect ; ITEM_SHARP_SCYTHE
	dw Dummy_NewItemEffect ; ITEM_87
	dw Dummy_NewItemEffect ; ITEM_ICE_BIKINI
	dw Dummy_NewItemEffect ; ITEM_THUNDER_FANG
	dw Dummy_NewItemEffect ; ITEM_FIRE_CLAW
	dw Dummy_NewItemEffect ; ITEM_TWIN_HORNS
	dw Dummy_NewItemEffect ; ITEM_SPIKE
	dw Dummy_NewItemEffect ; ITEM_BERRY
	dw Dummy_NewItemEffect ; ITEM_APPLE
	dw Dummy_NewItemEffect ; ITEM_METAL_COAT
	dw Dummy_NewItemEffect ; ITEM_PRETTY_TAIL
	dw Dummy_NewItemEffect ; ITEM_WATER_TAIL
	dw Dummy_NewItemEffect ; ITEM_LEFTOVERS
	dw Dummy_NewItemEffect ; ITEM_ICE_WING
	dw Dummy_NewItemEffect ; ITEM_THUNDER_WING
	dw Dummy_NewItemEffect ; ITEM_FIRE_WING
	dw Dummy_NewItemEffect ; ITEM_96
	dw Dummy_NewItemEffect ; ITEM_DRAGON_SCALE
	dw Dummy_NewItemEffect ; ITEM_BERSERK_GENE
	dw Dummy_NewItemEffect ; ITEM_HEART_STONE
	dw Dummy_NewItemEffect ; ITEM_FIRE_TAIL
	dw Dummy_NewItemEffect ; ITEM_THUNDER_TAIL
	dw Dummy_NewItemEffect ; ITEM_SACRED_ASH
	dw TMHolderEffect      ; ITEM_TM_HOLDER
	dw Stub_MailEffect     ; ITEM_MAIL
	dw Dummy_NewItemEffect ; ITEM_BALL_HOLDER
	dw Dummy_NewItemEffect ; ITEM_BAG
	dw Dummy_NewItemEffect ; ITEM_IMPORTANT_BAG
	dw Dummy_NewItemEffect ; ITEM_POISON_STONE
	dw Dummy_NewItemEffect ; ITEM_A3
	dw Dummy_NewItemEffect ; ITEM_A4
	dw Dummy_NewItemEffect ; ITEM_A5
	dw Dummy_NewItemEffect ; ITEM_A6
	dw Dummy_NewItemEffect ; ITEM_A7
	dw Dummy_NewItemEffect ; ITEM_A8
	dw Dummy_NewItemEffect ; ITEM_A9
	dw Dummy_NewItemEffect ; ITEM_AA
; ITEM_AB through ITEM_C3 have no entries.

PokeBallEffect:
	ld a, [wBattleMode]
	and a
	jp z, IsntTheTimeMessage
	dec a
	jp nz, UseBallInTrainerBattle

	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr nz, .room_in_party

	ld a, [wBoxCount]
	cp MONS_PER_BOX
	jp z, Ball_BoxIsFullMessage

.room_in_party
	xor a
	ld [wWildMon], a
	call ReturnToBattle_UseBall

	ld hl, ItemUsedText
	call PrintText

	ld a, [wEnemyMonCatchRate]
	ld b, a
	ld a, [wCurItem]
	cp ITEM_MASTER_BALL
	jp z, .catch_without_fail

	cp ITEM_ULTRA_BALL
	jr z, .ultra_ball_modifier

	cp ITEM_GREAT_BALL
	jr z, .great_ball_modifier

	; POKE_BALL
	jr .regular_ball

; 1.5x modifier
.great_ball_modifier
	ld a, b
	srl a
	add b
	ld b, a
	jr nc, .regular_ball
	ld b, $ff
	jr .regular_ball

; 2.0x modifier
.ultra_ball_modifier
	sla b
	jr nc, .regular_ball
	ld b, $ff

.regular_ball
	ld a, b
	ldh [hMultiplicand + 2], a

	ld hl, wEnemyMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld e, [hl]
	sla c
	rl b
	
	ld h, d
	ld l, e
	add hl, de
	add hl, de
	ld d, h
	ld e, l
	ld a, d
	and a
	jr z, .okay_1

	srl d
	rr e
	srl d
	rr e
	srl b
	rr c
	srl b
	rr c

	ld a, c
	and a
	jr nz, .okay_1
	ld c, 1
.okay_1
	ld b, e

	push bc
	ld a, b
	sub c
	ldh [hMultiplier], a
	xor a
	ldh [hDividend + 0], a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	call Multiply
	pop bc

	ld a, b
	ldh [hDivisor], a
	ld b, 4
	call Divide

	ldh a, [hQuotient + 3]
	and a
	jr nz, .statuscheck
	ld a, 1
.statuscheck
; This routine is buggy, even in the final game.
; It was intended that SLP and FRZ provide a higher catch rate than BRN/PSN/PAR,
; which in turn provide a higher catch rate than no status effect at all.
; But instead, it makes BRN/PSN/PAR provide no benefit.
; Uncomment the line below to fix this.
	ld b, a
	ld a, [wEnemyMonStatus]
	and 1 << FRZ | SLP
	ld c, 10
	jr nz, .addstatus
	; ld a, [wEnemyMonStatus]
	and a
	ld c, 5
	jr nz, .addstatus
	ld c, 0
.addstatus
	ld a, b
	add c
	jr nc, .max_1
	ld a, $ff
.max_1
	; BUG: farcall overwrites a, and GetItemHeldEffect takes b anyway.
	; This might be the reason the HELD_CATCH_CHANCE effect goes unused in the final game.
	; Uncomment the line below to fix.
	ld d, a
	push de
	ld a, [wBattleMonItem]
	; ld b, a
	callfar GetItemHeldEffect
	ld a, b
	cp HELD_CATCH_CHANCE
	pop de
	ld a, d
	jr nz, .max_2
	add c
	jr nc, .max_2
	ld a, $ff
.max_2
	ld b, a
	ld [wFieldMoveScriptID], a
	call Random

	cp b
	ld a, 0
	jr z, .catch_without_fail
	jr nc, .fail_to_catch

.catch_without_fail
	ld a, [wEnemyMonSpecies]

.fail_to_catch
	ld [wWildMon], a
	ld c, 20
	call DelayFrames

	ld a, [wCurItem]
	ld [wBattleAnimParam], a

	ld de, ANIM_THROW_POKE_BALL
	ld a, e
	ld [wFXAnimID], a
	ld a, d
	ld [wFXAnimID + 1], a
	xor a
	ldh [hBattleTurn], a
	ld [wThrownBallWobbleCount], a
	ld [wNumHits], a
	predef PlayBattleAnim

	ld a, [wWildMon]
	and a
	jr nz, .caught
	ld a, [wThrownBallWobbleCount]
	cp 1
	ld hl, BallBrokeFreeText
	jp z, .shake_and_break_free
	cp 2
	ld hl, BallAppearedCaughtText
	jp z, .shake_and_break_free
	cp 3
	ld hl, BallAlmostHadItText
	jp z, .shake_and_break_free
	cp 4
	ld hl, BallSoCloseText
	jp z, .shake_and_break_free

.caught
	ld hl, wEnemyMonHP
	ld a, [hli]
	push af
	ld a, [hli]
	push af
	inc hl
	ld a, [hl]

	push af
	push hl
	ld hl, wEnemyMonItem
	ld a, [hl]
	push af
	push hl

; BUG: If a Pokémon is caught while transformed, it is assumed to be a Ditto,
; even if it used Transform via Mirror Move/Mimic or is Mew.
	ld hl, wEnemySubStatus5
	bit SUBSTATUS_TRANSFORMED, [hl]
	jr z, .not_ditto

	ld a, DEX_DITTO
	ld [wTempEnemyMonSpecies], a
; This doesn't seem right... aren't transformed Pokémon the only ones that use backup DVs anyway?
	jr .load_data

.not_ditto
	set SUBSTATUS_TRANSFORMED, [hl]
	ld hl, wEnemyBackupDVs
	ld a, [wEnemyMonDVs]
	ld [hli], a
	ld a, [wEnemyMonDVs + 1]
	ld [hl], a

.load_data
	ld a, [wTempEnemyMonSpecies]
	ld [wCurPartySpecies], a
	ld a, [wEnemyMonLevel]
	ld [wCurPartyLevel], a
	callfar LoadEnemyMon

	pop hl
	pop af
	ld [hl], a
	pop hl
	pop af
	ld [hld], a
	dec hl
	pop af
	ld [hld], a
	pop af
	ld [hl], a

	ld a, [wEnemyMonSpecies]
	ld [wWildMon], a
	ld [wCurPartySpecies], a
	ld [wTempSpecies], a
	ld a, [wBattleType]
	dec a ; BATTLETYPE_TUTORIAL?
	jp z, .FinishTutorial

	ld hl, Text_GotchaMonWasCaught
	call PrintText

	call ClearSprites

	ld a, [wTempSpecies]
	dec a
	ld c, a
	ld d, 0
	ld hl, wPokedexCaught
	ld b, CHECK_FLAG
	predef SmallFarFlagAction

	ld a, c
	push af
	ld a, [wTempSpecies]
	dec a
	ld c, a
	ld b, SET_FLAG
	predef SmallFarFlagAction

; Notably doesn't skip the Pokédex if you actually don't have the Pokédex yet, unlike in GivePoke.
; Not a big deal, since you shouldn't have Poké Balls yet anyway.
	pop af
	and a
	jr nz, .skip_pokedex

	ld hl, NewDexDataText_CaughtMon
	call PrintText

	call ClearSprites

	ld a, [wEnemyMonSpecies]
	ld [wTempSpecies], a
	predef NewPokedexEntry

.skip_pokedex
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr z, .SendToPC

	xor a ; PARTYMON
	ld [wMonType], a
	call ClearSprites

	predef TryAddMonToParty

	ld hl, AskGiveNicknameText_CaughtMon
	call PrintText
	call YesNoBox
	jr c, .return_from_capture

	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call AddNTimes

	ld d, h
	ld e, l
	ld b, NAME_MON
	ld a, BANK(NamingScreen)
	ld hl, NamingScreen
	push de
	call FarCall_hl

	call GBFadeOutToWhite

	pop de
	ld a, [de]
	cp "@" ; Did we just leave the name empty?
	jr nz, .return_from_capture
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	jr .return_from_capture

.SendToPC
	call ClearSprites

	predef SendMonIntoBox

	ld hl, AskGiveNicknameText_CaughtMon
	call PrintText
	call YesNoBox
	jr c, .done_with_nickname_pc

	ld de, wBoxMonNicknames
	ld b, NAME_MON
	farcall NamingScreen

	call GBFadeOutToWhite
	ld de, wBoxMonNicknames
	ld a, [de]
	cp "@"
	jr nz, .done_with_nickname_pc

	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes

.done_with_nickname_pc
; BUG: Clearly there was supposed to be some kind of event flag check, but no flag address is actually loaded.
; 'a' is still the last byte copied in CopyBytes, which is most likely $50 (string terminator), which does not have bit 0 set.
	ld hl, BallSentToBillsPCText
	bit 0, a
	jr nz, .met_bill
	ld hl, BallSentToSomeonesPCText
.met_bill
	call PrintText
	jr .return_from_capture

.FinishTutorial:
	ld hl, Text_GotchaMonWasCaught

.shake_and_break_free
	call PrintText
	call ClearSprites

.return_from_capture
	ld a, [wBattleType]
	and a
	ret nz
	ld hl, wItems
	inc a
	ld [wItemQuantity], a
	jp TossItem

Unreferenced_BallDodgedText:
	text "よけられた！" ; "It dodged the thrown BALL!"
	line "こいつは　つかまりそうにないぞ！" ; "This MON can't be caught!"
	prompt

Unreferenced_BallMissedText:
	text "#に" ; "You missed the"
	line "うまく　あたらなかった！" ; "(MON)!"
	prompt

BallBrokeFreeText:
	text "だめだ！　#が" ; "Oh no! The (MON)"
	line "ボールから　でてしまった！" ; "broke free!"
	prompt

BallAppearedCaughtText:
	text "ああ！" ; "Aww! It appeared"
	line "つかまえたと　おもったのに！" ; "to be caught!"
	prompt

BallAlmostHadItText:
	text "ざんねん！" ; "Aargh!"
	line "もうすこしで　つかまえられたのに！" ; "Almost had it!"
	prompt

BallSoCloseText:
	text "おしい！" ; "Shoot! It was so"
	line "あと　ちょっとの　ところだったのに！" ; "close too!"
	prompt

Text_GotchaMonWasCaught:
	text "やったー！" ; "Gotcha!"
	line "@"
	text_from_ram wEnemyMonNickname
	text "を　つかまえたぞ！@" ; "(MON) was caught!"
	sound_caught_mon
	text_waitbutton
	text_end

BallSentToBillsPCText:
	text_from_ram wBoxMonNicknames
	text "は　マサキの　ところへ" ; "was transferred to"
	line "てんそうされた！" ; "BILL's PC!"
	prompt

BallSentToSomeonesPCText:
	text_from_ram wBoxMonNicknames
	text "は　だれかの　<PC>に" ; "was transferred to"
	line "てんそうされた！" ; "Someone's PC!"
	prompt

NewDexDataText_CaughtMon:
	text_from_ram wEnemyMonNickname
	text "の　データが　あたらしく" ; "New Dex data will"
	line "#ずかんに　セーブされます！@" ; "be added for (MON)!"
	sound_slot_machine_start
	text_waitbutton
	text_end

AskGiveNicknameText_CaughtMon:
	text "つかまえた　@"
	text_from_ram wStringBuffer1
	text "に"
	line "なまえを　つけますか"
	done

ReturnToBattle_UseBall:
	call ClearPalettes
	callfar Call_LoadBattleFontsHPBar
	call GetMemSGBLayout
	call CloseWindow
	call LoadStandardMenuHeader
	call WaitBGMap
	call SetPalettes
	ret

TownMapEffect:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage
	farjp TownMap

BicycleEffect:
	xor a
	ld [wItemEffectSucceeded], a
	call .CheckEnvironment
	ret c
	ldh a, [hROMBank]
	ld hl, .UseBike
	call QueueScript
	ld a, 1
	ld [wItemEffectSucceeded], a
	ret

.CheckEnvironment:
	call GetMapEnvironment
	cp TOWN
	jr z, .ok
	cp ROUTE
	jr z, .ok
	cp CAVE
	jr z, .ok
	jr .nope

.ok
; POSSIBLE BUG: Can't get onto the Bike while on the Skateboard.
	ld a, [wPlayerState]
	and a
	ret z
	cp PLAYER_BIKE
	ret z

.nope
	scf
	ret

.UseBike:
	call RefreshScreen
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	jr z, .get_off_bike
	ld a, PLAYER_BIKE
	ld [wPlayerState], a
	ld hl, ItemGotOnText
	jr .done

.get_off_bike
	xor a
	ld [wPlayerState], a
	ld hl, ItemGotOffText
.done
	call MenuTextBox
	call CloseWindow
	call RedrawPlayerSprite
	call PlayMapMusic
	call ScreenCleanup
	ret

EvoStoneEffect:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage

	ld a, PARTYMENUACTION_EVO_STONE
	call UseItem_SelectMon

	jr c, .DecidedNotToUse

	ld a, TRUE
	ld [wForceEvolution], a
	push de
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	call WaitSFX
	pop de
	callfar EvolvePokemon

	ld a, [wMonTriedToEvolve]
	and a
	jr z, .NoEffect
	jp UseDisposableItem

.NoEffect:
	call WontHaveAnyEffectMessage

.DecidedNotToUse
	xor a
	ld [wItemEffectSucceeded], a
	ret

VitaminEffect:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage

	ld a, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, RareCandy_StatBooster_ExitMenu

	ld a, MON_SPECIES
	call GetPartyParamLocation
	push hl
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld [wTempSpecies], a

	ld bc, MON_LEVEL
	add hl, bc
	ld a, [hl]
	ld [wCurPartyLevel], a

	call GetBaseData
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick

	call GetStatExpRelativePointer

	pop hl
	push hl
	add hl, bc
	ld bc, MON_STAT_EXP
	add hl, bc
	ld a, [hl]
	cp 100
	jr nc, NoEffectMessage

	add 10
	ld [hl], a
	pop hl
	call UpdateStatsAfterItem

	call GetStatExpRelativePointer

	ld hl, StatStrings
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wStringBuffer2
	ld bc, STRING_BUFFER_LENGTH
	call CopyBytes

	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	ld hl, ItemStatRoseText
	call PrintText
	jp UseDisposableItem

NoEffectMessage:
	pop hl
	ld hl, ItemWontHaveEffectText
	call PrintText
	jp ClearPalettes

UpdateStatsAfterItem:
	push hl
	ld bc, MON_MAXHP
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld bc, MON_STAT_EXP - 1
	add hl, bc
	ld b, TRUE
	predef_jump CalcMonStats

RareCandy_StatBooster_ExitMenu:
	xor a
	ld [wItemEffectSucceeded], a
	call ClearPalettes
	call z, GetMemSGBLayout
	jp ReloadFontAndTileset

ItemStatRoseText:
	text_from_ram wStringBuffer1 ; "(MON)'s"
	text "の　@"
	text_from_ram wStringBuffer2 ; "(STAT) rose."
	text "の"
	line "きそ　ポイントが　あがった！"
	prompt

ItemWontHaveEffectText:
	text "つかっても　こうかが　ないよ" ; "It won't have any effect."
	prompt

StatStrings:
	dw .health
	dw .attack
	dw .defense
	dw .speed
	dw .special

.health: db "たいりょく@" ; "HEALTH"
.attack: db "こうげきりょく@" ; "ATTACK"
.defense: db "ぼうぎょりょく@" ; "DEFENSE"
.speed: db "すばやさ@" ; "SPEED"
.special: db "とくしゅのうりょく@" ; "SPECIAL"

GetStatExpRelativePointer:
	ld a, [wCurItem]
	ld hl, StatExpItemPointerOffsets
.next
	cp [hl]
	inc hl
	jr z, .got_it
	inc hl
	jr .next

.got_it
	ld a, [hl]
	ld c, a
	ld b, 0
	ret

StatExpItemPointerOffsets:
	db ITEM_HP_UP,    MON_HP_EXP - MON_STAT_EXP
	db ITEM_PROTEIN, MON_ATK_EXP - MON_STAT_EXP
	db ITEM_IRON,    MON_DEF_EXP - MON_STAT_EXP
	db ITEM_CARBOS,  MON_SPD_EXP - MON_STAT_EXP
	db ITEM_CALCIUM, MON_SPC_EXP - MON_STAT_EXP

RareCandyEffect:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage

	ld a, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, RareCandy_StatBooster_ExitMenu

	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld [wTempSpecies], a
	push hl

	ld bc, MON_LEVEL
	add hl, bc
	ld a, [hl]
	ld [wCurPartyLevel], a
	call GetBaseData
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	pop hl

	push hl
	ld bc, MON_LEVEL
	add hl, bc
	ld a, [hl]
	cp MAX_LEVEL
	jp nc, NoEffectMessage

	inc a
	ld [hl], a
	ld [wCurPartyLevel], a
	push de
	ld d, a
	callfar CalcExpAtLevel
	pop de
	pop hl

	push hl
	ld bc, MON_EXP
	add hl, bc
	ldh a, [hProduct + 1]
	ld [hli], a
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a
	pop hl

	push hl
	ld bc, MON_MAXHP
	add hl, bc
	ld a, [hli]
	ld b, a
	ld c, [hl]
	pop hl
	push bc
	push hl
	call UpdateStatsAfterItem

	pop hl
	ld bc, MON_MAXHP + 1
	add hl, bc
	pop bc
	ld a, [hld]
	sub c
	ld c, a
	ld a, [hl]
	sbc b
	ld b, a
	dec hl
	ld a, [hl]
	add c
	ld [hld], a
	ld a, [hl]
	adc b
	ld [hl], a

	ld a, PARTYMENUTEXT_LEVEL_UP
	ld [wPartyMenuActionText], a
	callfar WritePartyMenuTilemapAndText

	xor a
	ld [wMonType], a
	predef CopyMonToTempMon

	ld d, 1
	callfar PrintTempMonStats
	call TextboxWaitPressAorB_BlinkCursor

	xor a
	ld [wMonType], a
	ld a, [wCurPartySpecies]
	ld [wTempSpecies], a
	predef LearnLevelMoves

	xor a
	ld [wForceEvolution], a
	callfar EvolvePokemon
	jp UseDisposableItem

StatusHealingEffect:
	ld a, [wPartyCount]
	and a
	jp z, IsntTheTimeMessage

	ld a, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, StatusHealer_ExitMenu
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a

HealStatus:
	call GetItemHealingAction
	ld a, MON_STATUS
	call GetPartyParamLocation
	ld a, [hl]
	and c
	jp z, StatusHealer_NoEffect
	xor a
	ld [hl], a
	ld a, b
	ld [wPartyMenuActionText], a

	call IsItemUsedOnBattleMon
	jr nc, .not_in_battle
	xor a
	ld [wBattleMonStatus], a
	ld hl, wPlayerSubStatus5
	res SUBSTATUS_TOXIC, [hl]
	ld hl, wPlayerSubStatus1
	res SUBSTATUS_NIGHTMARE, [hl]

; This whole section is leftover from an unused mechanic in Generation I, which is broken now
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld de, wBattleMonMaxHP
	ld bc, (NUM_STATS - 1) * 2 ; Doesn't include special defense
	call CopyBytes
	predef DoubleOrHalveSelectedStats_Old

.not_in_battle
	call UseDisposableItem
	push de
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	pop de
	call ItemActionTextWaitButton
	jp StatusHealer_ClearPalettes

GetItemHealingAction:
	push hl
	ld a, [wCurItem]
	ld hl, StatusHealingActions
	ld bc, 3
.next
	cp [hl]
	jr z, .found_it
	add hl, bc
	jr .next

.found_it
	inc hl
	ld b, [hl]
	inc hl
	ld c, [hl]
	pop hl
	ret

StatusHealingActions:
	;  item,         party menu action text, status
	db ITEM_ANTIDOTE,     PARTYMENUTEXT_HEAL_PSN, 1 << PSN
	db ITEM_BURN_HEAL,    PARTYMENUTEXT_HEAL_BRN, 1 << BRN
	db ITEM_ICE_HEAL,     PARTYMENUTEXT_HEAL_FRZ, 1 << FRZ
	db ITEM_AWAKENING,    PARTYMENUTEXT_HEAL_SLP,      SLP
	db ITEM_PARLYZ_HEAL,  PARTYMENUTEXT_HEAL_PAR, 1 << PAR
	db ITEM_FULL_HEAL,    PARTYMENUTEXT_HEAL_ALL, %11111111
	db -1, 0, 0 ; end

ReviveEffect:
	ld a, [wPartyCount]
	and a
	jp z, IsntTheTimeMessage

	ld a, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, StatusHealer_ExitMenu

	call IsMonFainted
	jp nz, StatusHealer_NoEffect

	ld a, [wBattleMode]
	and a
	jr z, .skip_to_revive

	ld a, [wCurPartyMon]
	ld c, a
	ld d, 0
	ld hl, wBattleParticipantsIncludingFainted
	ld b, CHECK_FLAG
	predef SmallFarFlagAction
	ld a, c
	and a
	jr z, .skip_to_revive

	ld a, [wCurPartyMon]
	ld c, a
	ld hl, wBattleParticipantsNotFainted
	ld b, SET_FLAG
	predef SmallFarFlagAction

.skip_to_revive
	xor a
	ld [wLowHealthAlarmBuffer], a
	ld a, [wCurItem]
	cp ITEM_REVIVE
	jr z, .revive_half_hp

	call ReviveFullHP
	jr .finish_revive

.revive_half_hp
	call ReviveHalfHP
.finish_revive
	call HealHP_SFX_GFX
	ld a, PARTYMENUTEXT_REVIVE
	ld [wPartyMenuActionText], a
	call ItemActionTextWaitButton
	call UseDisposableItem
	jp StatusHealer_ClearPalettes

Unreferenced_EmptyFunctionefed:
	ret

FullRestoreEffect:
	ld a, [wPartyCount]
	and a
	jp z, IsntTheTimeMessage

	ld a, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, StatusHealer_ExitMenu

	call IsMonFainted
	jp z, StatusHealer_NoEffect

	call IsMonAtFullHealth
	jr c, .NotAtFullHealth

	ld a, MON_STATUS
	call GetPartyParamLocation
	ld a, [hl]
	and a
	jp z, StatusHealer_NoEffect

	ld a, ITEM_FULL_HEAL
	ld [wCurItem], a
	jp HealStatus

.NotAtFullHealth
	xor a
	ld [wLowHealthAlarmBuffer], a
	call ReviveFullHP
	ld a, MON_STATUS
	call GetPartyParamLocation
	xor a
	ld [hli], a
	ld [hl], a

	call IsItemUsedOnBattleMon
	jr nc, .not_in_battle

	ld hl, wPlayerSubStatus5
	res SUBSTATUS_TOXIC, [hl]
	ld hl, wPlayerSubStatus1
	res SUBSTATUS_NIGHTMARE, [hl]
	xor a
	ld [wBattleMonStatus], a

	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [hli]
	ld [wBattleMonHP], a
	ld a, [hld]
	ld [wBattleMonHP + 1], a

.not_in_battle
	call HealHP_SFX_GFX
	ld a, PARTYMENUTEXT_HEAL_HP
	ld [wPartyMenuActionText], a
	call ItemActionTextWaitButton
	call UseDisposableItem
	jp StatusHealer_ClearPalettes

Unreferenced_EmptyFunctionf05a:
	ret

RestoreHPEffect:
	ld a, [wPartyCount]
	and a
	jp z, IsntTheTimeMessage

	ld a, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, StatusHealer_ExitMenu

	call IsMonFainted
	jp z, StatusHealer_NoEffect
	call IsMonAtFullHealth
	jp nc, StatusHealer_NoEffect

	xor a
	ld [wLowHealthAlarmBuffer], a
	ld a, [wCurItem]
	cp ITEM_MAX_POTION
	jr nz, .get_heal_amount
	call ReviveFullHP
	jr .continue_heal

.get_heal_amount
	call GetHealingItemAmount
	call RestoreHealth
.continue_heal
	call IsItemUsedOnBattleMon
	jr nc, .not_in_battle

	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [hli]
	ld [wBattleMonHP], a
	ld a, [hld]
	ld [wBattleMonHP + 1], a
.not_in_battle
	call HealHP_SFX_GFX
	ld a, PARTYMENUTEXT_HEAL_HP
	ld [wPartyMenuActionText], a
	call ItemActionTextWaitButton
	call UseDisposableItem
	jp StatusHealer_ClearPalettes

Unreferenced_EmptyFunctionf0af:
	ret

HealHP_SFX_GFX:
	push de
	ld de, SFX_POTION
	call WaitPlaySFX
	pop de
	ld a, [wCurPartyMon]
	hlcoord 11, 0
	ld bc, SCREEN_WIDTH * 2
	call AddNTimes
	ld a, $2
	ld [wWhichHPBar], a
	predef UpdateHPBar
	ret

UseItem_SelectMon:
	ld [wPartyMenuActionText], a
	predef OpenPartyMenu_ClearGraphics
	ret

ItemActionTextWaitButton:
	xor a
	ldh [hBGMapMode], a
	ld hl, wTileMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, "　"
	call ByteFill
	callfar WritePartyMenuTilemapAndText
	ld a, 1
	ldh [hBGMapMode], a
	ld c, 50
	call DelayFrames
	call TextboxWaitPressAorB_BlinkCursor
	ret

StatusHealer_NoEffect:
	call WontHaveAnyEffectMessage
	jr StatusHealer_ClearPalettes

StatusHealer_ExitMenu:
	xor a
	ld [wFieldMoveSucceeded], a

StatusHealer_ClearPalettes:
	call ClearPalettes
	call z, GetMemSGBLayout
	ld a, [wBattleMode]
	and a
	ret nz
	call ReloadFontAndTileset
	ret

IsItemUsedOnBattleMon:
	ld a, [wBattleMode]
	and a
	ret z
	ld a, [wCurPartyMon]
	push hl
	ld hl, wCurBattleMon
	cp [hl]
	pop hl
	jr nz, .nope
	scf
	ret

.nope
	xor a
	ret

ReviveHalfHP:
	call LoadHPFromBuffer1
	srl d
	rr e
	jr ContinueRevive

ReviveFullHP:
	call LoadHPFromBuffer1
ContinueRevive:
	ld a, MON_HP
	call GetPartyParamLocation
	ld [hl], d
	inc hl
	ld [hl], e
	call LoadCurHPIntoBuffer3
	ret

RestoreHealth:
	ld a, MON_HP + 1
	call GetPartyParamLocation
	ld a, [hl]
	add e
	ld [hld], a
	ld a, [hl]
	adc d
	ld [hl], a
	call LoadCurHPIntoBuffer3
	ld a, MON_HP + 1
	call GetPartyParamLocation
	ld d, h
	ld e, l
	ld a, MON_MAXHP + 1
	call GetPartyParamLocation
	ld a, [de]
	sub [hl]
	dec de
	dec hl
	ld a, [de]
	sbc [hl]
	jr c, .finish
	call ReviveFullHP
.finish
	ret

IsMonFainted:
	call LoadMaxHPIntoBuffer1
	call LoadCurHPIntoBuffer2
	call LoadHPFromBuffer2
	ld a, d
	or e
	ret

IsMonAtFullHealth:
	call LoadHPFromBuffer2
	ld h, d
	ld l, e
	call LoadHPFromBuffer1
	ld a, l
	sub e
	ld a, h
	sbc d
	ret

LoadCurHPIntoBuffer3:
	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [hli]
	ld [wHPBuffer3 + 1], a
	ld a, [hl]
	ld [wHPBuffer3], a
	ret

; Unreferenced
LoadHPIntoBuffer3:
	ld a, d
	ld [wHPBuffer3 + 1], a
	ld a, e
	ld [wHPBuffer3], a
	ret

; Unreferenced
LoadHPFromBuffer3:
	ld a, [wHPBuffer3 + 1]
	ld d, a
	ld a, [wHPBuffer3]
	ld e, a
	ret

LoadCurHPIntoBuffer2:
	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [hli]
	ld [wHPBuffer2 + 1], a
	ld a, [hl]
	ld [wHPBuffer2], a
	ret

LoadHPFromBuffer2:
	ld a, [wHPBuffer2 + 1]
	ld d, a
	ld a, [wHPBuffer2]
	ld e, a
	ret

LoadMaxHPIntoBuffer1:
	push hl
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld a, [hli]
	ld [wHPBuffer1 + 1], a
	ld a, [hl]
	ld [wHPBuffer1], a
	pop hl
	ret

LoadHPFromBuffer1:
	ld a, [wHPBuffer1 + 1]
	ld d, a
	ld a, [wHPBuffer1]
	ld e, a
	ret

GetOneFifthMaxHP:
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld a, [hli]
	ldh [hDividend], a
	ld a, [hl]
	ldh [hDividend + 1], a
	ld a, 5
	ldh [hDivisor], a
	ld b, 2
	call Divide
	ldh a, [hQuotient + 2]
	ld d, a
	ldh a, [hQuotient + 3]
	ld e, a
	ret

GetHealingItemAmount:
	push hl
	ld a, [wCurItem]
	ld hl, HealingHPAmounts
	ld d, a
.next
	ld a, [hli]
	cp -1
	jr z, .NotFound
	cp d
	jr z, .done
	inc hl
	inc hl
	jr .next

.NotFound:
	scf
.done
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	ret

; INCLUDE IN: "data/items/heal_hp.inc"

HealingHPAmounts:
	dbw ITEM_FRESH_WATER,   50
	dbw ITEM_SODA_POP,      60
	dbw ITEM_LEMONADE,      80
	dbw ITEM_HYPER_POTION, 200
	dbw ITEM_SUPER_POTION,  50
	dbw ITEM_POTION,        20
	dbw -1, 0 ; end

SoftboiledFunction:
	ld a, [wPartyMenuCursor]
	dec a
	ld b, a
.loop
	push bc
	ld a, PARTYMENUACTION_HEALING_ITEM
	ld [wPartyMenuActionText], a
	predef OpenPartyMenu
	pop bc
	jr c, .skip

	ld a, [wPartyMenuCursor]
	dec a
	ld c, a
	ld a, b
	cp c
	jr z, .loop

	push bc
	ld a, c
	ld [wCurPartyMon], a
	call IsMonFainted
	jr z, .fainted
	call IsMonAtFullHealth
	jp nc, .full_health

	pop bc
	push bc
	ld a, b
	ld [wCurPartyMon], a
	call IsMonFainted
	call GetOneFifthMaxHP
	push de
	ld a, MON_HP + 1
	call GetPartyParamLocation
	ld a, [hl]
	sub e
	ld [hld], a
	ld e, a
	ld a, [hl]
	sbc d
	ld [hl], a
	ld d, a
	call LoadHPIntoBuffer3
	call HealHP_SFX_GFX
	pop de
	pop bc

	push bc
	push de
	ld a, c
	ld [wCurPartyMon], a
	call IsMonFainted
	pop de
	call RestoreHealth
	call HealHP_SFX_GFX

	xor a
	ldh [hBGMapMode], a
	call ClearTileMap
	ld a, PARTYMENUTEXT_HEAL_HP
	ld [wPartyMenuActionText], a
	predef InitPartyMenuLayout
	ld c, 200
	call PartyMenu_WaitForAorB
	pop bc
.skip
	ld a, b
	inc a
	ld [wPartyMenuCursor], a
	ret

.fainted
	ld hl, .ItemCantUseOnMonText
	call PartyMenu_TextboxBackup
	pop bc
	jp .loop

; Looks like they might have been intended to have different messages at one point?
.full_health
	ld hl, .ItemCantUseOnMonText
	call PartyMenu_TextboxBackup
	pop bc
	jp .loop

.ItemCantUseOnMonText:
	text "その#には　"
	line "つかえません"
	done

EscapeRopeEffect:
	xor a
	ld [wItemEffectSucceeded], a
	callfar DigFunction
	ret

SuperRepelEffect:
	ld b, 200
	jp UseRepel

MaxRepelEffect:
	ld b, 250
	jp UseRepel

RepelEffect:
	ld b, 100

UseRepel:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage

	ld a, b
	ld [wRepelEffect], a
	jp UseItemText

XAccuracyEffect:
	ld a, [wBattleMode]
	and a
	jp z, IsntTheTimeMessage

	ld hl, wPlayerSubStatus4
	set SUBSTATUS_X_ACCURACY, [hl]
	jp UseItemText

PokeDollEffect:
	ld a, [wBattleMode]
	dec a ; WILD_BATTLE?
	jp nz, IsntTheTimeMessage

	ld a, LOSE
	ld [wBattleResult], a
	jp UseItemText

GuardSpecEffect:
	ld a, [wBattleMode]
	and a
	jp z, IsntTheTimeMessage

	ld hl, wPlayerSubStatus4
	set SUBSTATUS_MIST, [hl]
	jp UseItemText

DireHitEffect:
	ld a, [wBattleMode]
	and a
	jp z, IsntTheTimeMessage

	ld hl, wPlayerSubStatus4
	set SUBSTATUS_FOCUS_ENERGY, [hl]
	jp UseItemText

XItemEffect:
	ld a, [wBattleMode]
	and a
	jr nz, .in_battle

	call IsntTheTimeMessage
	ld a, 2
	ld [wItemEffectSucceeded], a
	ret

.in_battle
	ld hl, wPlayerMoveStructAnimation
	ld a, [hli]
	push af
	ld a, [hl]
	push af
	push hl
; Uses old index from pokered...
	ld a, [wCurItem]
	sub ITEM_X_ATTACK_RED - EFFECT_ATTACK_UP
	ld [hl], a
	call UseItemText
	ld a, $ae ; XSTATITEM_ANIM in pokered
	ld [wPlayerMoveStructAnimation], a
	call ReloadTilesFromBuffer
	call WaitBGMap
	xor a
	ldh [hBattleTurn], a
; BUG: Wrong bank. Replace $f with BANK(BattleCommand_StatUp) to fix it.
	ld a, $f
	ld hl, BattleCommand_StatUp
	call FarCall_hl

	pop hl
	pop af
	ld [hld], a
	pop af
	ld [hl], a
	ret

; Stubbed with a ret. The rest of the leftover code is intact below here though.
PokeFluteEffect:
	ret

	xor a
	ld [wPokeFluteCuredSleep], a
	ld b, ~SLP
	ld hl, wPartyMon1Status
	call .CureSleep

	ld a, [wBattleMode]
	cp WILD_BATTLE
	jr z, .skip_otrainer
	ld hl, wOTPartyMon1Status
	call .CureSleep
.skip_otrainer

	ld hl, wBattleMonStatus
	ld a, [hl]
	and b
	ld [hl], a
	ld hl, wEnemyMonStatus
	ld a, [hl]
	and b
	ld [hl], a

	ld a, [wPokeFluteCuredSleep]
	and a
	ld hl, .PlayedFluteText
	jp z, PrintText
	ld hl, .PlayedTheFlute
	call PrintText

	ld a, [wLowHealthAlarmBuffer]
	and 1 << DANGER_ON_F
	jr nz, .dummy
	; more code was dummied out here
.dummy
	ld hl, .FluteWakeUpText
	jp PrintText

.CureSleep:
	ld de, PARTYMON_STRUCT_LENGTH
	ld c, PARTY_LENGTH
.loop
	ld a, [hl]
	push af
	and SLP
	jr z, .not_asleep
	ld a, TRUE
	ld [wPokeFluteCuredSleep], a
.not_asleep
	pop af
	and b
	ld [hl], a
	add hl, de
	dec c
	jr nz, .loop
	ret

MACRO dbmapcoord
	db \2, \1
ENDM

.Unreferenced_Route12SnorlaxFluteCoords:
	dbmapcoord  9, 62 ; one space West of Snorlax
	dbmapcoord 10, 61 ; one space North of Snorlax
	dbmapcoord 10, 63 ; one space South of Snorlax
	dbmapcoord 11, 62 ; one space East of Snorlax
	db -1 ; end

.Unreferenced_Route16SnorlaxFluteCoords:
	dbmapcoord 27, 10 ; one space East of Snorlax
	dbmapcoord 25, 10 ; one space West of Snorlax
	db -1 ; end

.PlayedFluteText:
	text "#のふえを　ふいた！"
	para "うーん！"
	line "すばらしい　ねいろだ！"
	prompt

.FluteWakeUpText:
	text "すべての　#が"
	line "めを　さました！"
	prompt

.PlayedTheFlute:
	text "<PLAYER>は"
	line "#のふえを　ふいてみた！@"
; BUG: No text_asm.
	ld b, 8
	ld a, [wBattleMode]
	and a
	jr nz, .battle

	push de
	ld de, SFX_POKEFLUTE
	call WaitPlaySFX
	call WaitSFX
	pop de

.battle
	jp GetTerminatingString

CoinCaseEffect:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage

	ld hl, CoinCaseCountText
	call MenuTextBox
	call CloseWindow
	ret

CoinCaseCountText:
	text "あなたの　コイン"
	line "@"
	deciram wCoins, 2, 4
	text "まい"
	prompt

; These rod effects haven't been touched since Generation I... like, at all.
; The only change was in FishingInit_Old to force the water check to always fail.
OldRodEffect_Old:
	call FishingInit_Old
	jp c, IsntTheTimeMessage
	lb bc, 5, MON_MAGIKARP
	ld a, $1
	jr RodResponse_Old

GoodRodEffect_Old:
	call FishingInit_Old
	jp c, IsntTheTimeMessage
.random_loop
	call Random
	srl a
	jr c, .set_bite
	and %11
	cp $2
	jr nc, .random_loop
	ld hl, .GoodRodMons
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld b, [hl]
	inc hl
	ld c, [hl]
	and a
.set_bite
	ld a, 0
	rla
	xor 1
	jr RodResponse_Old

; random choice of 2 good rod encounters
.GoodRodMons:
	; level, species
	db 10, MON_GOLDEEN
	db 10, MON_POLIWAG

SuperRodEffect_Old:
	call FishingInit_Old
	jp c, IsntTheTimeMessage
	call ReadSuperRodData_Old
	ld a, e

RodResponse_Old:
	ld [wRodResponse_Old], a

	dec a
	jr nz, .next

	ld a, 1
	ld [wAttackMissed], a
	ld a, b
	ld [wCurPartyLevel], a
	ld a, c
	ld [wTempWildMonSpecies], a

.next
	ld hl, wPlayerState
	ld a, [hl]
	push af
	ld [hl], 0
	push hl
	farcall FishingAnim_Old
	pop hl
	pop af
	ld [hl], a
	ret

FishingInit_Old:
	ld a, [wBattleMode]
	and a
	jr z, .not_in_battle
	scf
	ret

.not_in_battle
	call Stub_IsNextTileShoreOrWater_Old
	ret c
	ld a, [wPlayerState]
	cp $2 ; PLAYER_SURF at one point
	jr z, .surfing
	call ItemUseReloadOverworldData_Old
	ld hl, ItemUsedText
	call PrintText
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	ld c, 80
	call DelayFrames
	and a
	ret

.surfing
	scf
	ret

PPUpEffect:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage

RestorePPEffect:
	ld a, [wCurItem]
	ld [wTempRestorePPItem], a

.loop
	; Party Screen opens to choose on which mon to use the Item
	ld a, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jr nc, .loop2
	jp PPRestoreItem_Cancel

.loop2
	ld a, [wTempRestorePPItem]
	cp ITEM_ELIXER_RED
	jp nc, Elixer_RestorePPofAllMoves
	ld a, 2
	ld [wMoveSelectionMenuType], a
	ld hl, RaiseThePPOfWhichMoveText
	ld a, [wTempRestorePPItem]
	cp ITEM_ETHER_RED
	jr c, .ppup
	ld hl, RestoreThePPOfWhichMoveText

.ppup
	call PrintText
	callfar MoveSelectionScreen
	jr nz, .loop

	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call GetMthMoveOfNthPartymon
	push hl
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetMoveName
	call CopyStringToStringBuffer2
	pop hl

	ld a, [wTempRestorePPItem]
	cp ITEM_ETHER_RED
	jr nc, Not_PP_Up

	ld bc, MON_PP - MON_MOVES
	add hl, bc
	ld a, [hl]
	cp PP_UP_MASK
	jr c, .do_ppup

	ld hl, PPIsMaxedOutText
	call PrintText
	jr .loop2

.do_ppup
	ld a, [hl]
	add PP_UP_ONE
	ld [hl], a
	ld a, TRUE
	ld [wUsePPUp], a
	call ApplyPPUp
	ld hl, PPsIncreasedText
	call PrintText

FinishPPRestore:
	call ClearPalettes
	call GetMemSGBLayout
	jp UseDisposableItem

BattleRestorePP:
	ld a, [wBattleMode]
	and a
	jr z, .not_in_battle

	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wCurBattleMon]
	cp b
	jr nz, .not_in_battle

	ld hl, wPartyMon1PP
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld de, wBattleMonPP
	ld bc, NUM_MOVES
	call CopyBytes
.not_in_battle
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	ld hl, PPRestoredText
	call PrintText
	jr FinishPPRestore

Not_PP_Up:
	call RestorePP
	jr nz, BattleRestorePP
	jp PPRestoreItem_NoEffect

RestorePP:
	xor a ; PARTYMON
	ld [wMonType], a
	call GetMaxPPOfMove
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call GetMthMoveOfNthPartymon

	ld bc, MON_PP - MON_MOVES
	add hl, bc
	ld a, [wTempPP]
	ld b, a

	ld a, [wTempRestorePPItem]
	cp ITEM_MAX_ETHER_RED
	jr z, .restore_all

	ld a, [hl]
	and PP_MASK
	cp b
	ret z

	add 10
	cp b
	jr nc, .restore_some
	ld b, a
	
.restore_some
	ld a, [hl]
	and PP_UP_MASK
	add b
	ld [hl], a
	ret
.restore_all
	ld a, [hl]
	cp b
	ret z
	jr .restore_some

Elixer_RestorePPofAllMoves:
	ld hl, wTempRestorePPItem
	dec [hl]
	dec [hl]

	xor a
	ld hl, wMenuCursorY
	ld [hli], a
	ld [hl], a
	ld b, NUM_MOVES
.move_loop
	push bc
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call GetMthMoveOfNthPartymon
	ld a, [hl]
	and a
	jr z, .next

	call RestorePP
	jr z, .next
	ld hl, wMenuCursorX
	inc [hl]

.next
	ld hl, wMenuCursorY
	inc [hl]
	pop bc
	dec b
	jr nz, .move_loop
	ld a, [wMenuCursorX]
	and a
	jp nz, BattleRestorePP

PPRestoreItem_NoEffect:
	call WontHaveAnyEffectMessage

PPRestoreItem_Cancel:
	call ClearPalettes
	call GetMemSGBLayout
	pop af
	xor a
	ld [wItemEffectSucceeded], a
	ret

RaiseThePPOfWhichMoveText:
	text "どのわざの"
	line "ポイントをふやす？"
	done

RestoreThePPOfWhichMoveText:
	text "どのわざを"
	line "かいふくする？"
	done

PPIsMaxedOutText:
	text_from_ram wStringBuffer2
	text "は　これいじょう"
	line "ふやすことが　できません"
	prompt

PPsIncreasedText:
	text_from_ram wStringBuffer2
	text "の"
	line "わざポイントが　ふえた！"
	prompt

PPRestoredText:
	text "わざポイントが"
	line "かいふくした！"
	prompt

TMHolderEffect:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage
	jpfar _TMHolder

Stub_NuggetEffect:
	jp IsntTheTimeMessage

NoEffect:
	jp IsntTheTimeMessage

Dummy_NewItemEffect:
	jp IsntTheTimeMessage

Unreferenced_EnterBreeder:
	jp _Breeder

AskTeachTMHM_Old:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage
	
	ld a, [wCurItem]
	sub ITEM_TM01_RED
	push af
	jr nc, .is_tm_or_hm
	add NUM_TM_HM - 2 ; Generation I only had 5 HMs
.is_tm_or_hm
	inc a
	ld [wTempTMHM], a
	predef GetTMHMMove
	ld a, [wTempTMHM]
	ld [wPutativeTMHMMove], a
	call GetMoveName
	call CopyStringToStringBuffer2
	pop af
	ld hl, .BootedTMText
	jr nc, .TM
	ld hl, .BootedHMText
.TM
	call PrintText
	ld hl, .ContainedMoveText
	call PrintText
	call YesNoBox
	jr nc, .ChooseMonToLearnTMHM

	ld a, 2
	ld [wItemEffectSucceeded], a
	ret

.ChooseMonToLearnTMHM:
.loopback
	ld hl, wStringBuffer2
	ld de, wMonOrItemNameBuffer
	ld bc, MOVE_NAME_LENGTH
	call CopyBytes

	ld a, PARTYMENUACTION_TEACH_TMHM
	call UseItem_SelectMon
	push af
	ld hl, wMonOrItemNameBuffer
	ld de, wStringBuffer2
	ld bc, MOVE_NAME_LENGTH
	call CopyBytes
	pop af
	jr nc, .TeachTMHM

	pop af
	pop af
	call ClearBGPalettes
	call ClearSprites
	call GetMemSGBLayout
	jp ReloadTilesFromBuffer

.TeachTMHM:
	predef CanLearnTMHMMove
	push bc
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	pop bc

	ld a, c
	and a
	jr nz, .compatible
	ld de, SFX_WRONG
	call WaitPlaySFX

	ld hl, .TMHMNotCompatibleText
	call PrintText
	jr .loopback

.compatible
	call KnowsMove
	jr c, .loopback

	predef LearnMove
	ld a, b
	and a
	ret z

	ld a, [wCurItem]
	call IsHM
	ret c

	jp UseDisposableItem

.BootedTMText:
	text "<TM>を　きどうした！"
	prompt

.BootedHMText:
	text "ひでんマシンを　きどうした！"

.ContainedMoveText:
	text "なかには　@"
	text_from_ram wStringBuffer2
	text "が"
	line "きろくされていた！"
	para "@"
	text_from_ram wStringBuffer2
	text "を"
	line "#に　おぼえさせますか？"
	done

.TMHMNotCompatibleText:
	text_from_ram wStringBuffer1
	text "と　@"
	text_from_ram wStringBuffer2
	text "は"
	line "あいしょうが　わるかった！"
	para "@"
	text_from_ram wStringBuffer2
	text "は　おぼえられない！"
	prompt

UseItemText:
	ld hl, ItemUsedText
	call PrintText
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	call TextboxWaitPressAorB_BlinkCursor

UseDisposableItem:
	ld hl, wItems
	ld a, 1
	ld [wItemQuantity], a
	call TossItem
	ret

UseBallInTrainerBattle:
	call ReturnToBattle_UseBall
	ld de, ANIM_THROW_POKE_BALL
	ld a, e
	ld [wFXAnimID], a
	ld a, d
	ld [wFXAnimID + 1], a
	xor a
	ld [wBattleAnimParam], a
	ldh [hBattleTurn], a
	ld [wNumHits], a
	predef PlayBattleAnim
	ld hl, BallBlockedText
	call PrintText
	ld hl, BallDontBeAThiefText
	call PrintText
	jr UseDisposableItem

Ball_BoxIsFullMessage:
	ld hl, BallBoxFullText
	jr CantUseItemMessage

IsntTheTimeMessage:
	ld hl, ItemOakWarningText
	jr CantUseItemMessage

WontHaveAnyEffectMessage:
	ld hl, ItemWontHaveAnyEffectText
	jr CantUseItemMessage

; Unreferenced
BelongsToSomeoneElseMessage:
	ld hl, ItemBelongsToSomeoneElseText
	jr CantUseItemMessage

; Unreferenced
CyclingIsntAllowedMessage:
	ld hl, NoCyclingText
	jr CantUseItemMessage

; Unreferenced
CantGetOnYourBikeMessage:
	ld hl, ItemCantGetOnText

CantUseItemMessage:
	xor a
	ld [wItemEffectSucceeded], a
	jp PrintText

ItemOakWarningText:
	text "オーキドの　ことば<⋯⋯>"
	line "<PLAYER>よ！　こういうものには"
	cont "つかいどきが　あるのじゃ！"
	prompt

ItemBelongsToSomeoneElseText:
	text "たいせつな　あずかりものです！"
	next "つかうことは　できません！"
	prompt

ItemWontHaveAnyEffectText:
	text "つかっても　こうかがないよ"
	prompt

BallBlockedText:
	text "<TRAINER>に　ボールを　はじかれた！"
	prompt

BallDontBeAThiefText:
	text "ひとの　ものを　とったら　どろぼう！"
	prompt

NoCyclingText:
	text "ここでは　じてんしゃに"
	next "のることは　できません"
	prompt

ItemCantGetOnText:
	text "ここでは@"
	text_from_ram wStringBuffer1
	text "に"
	line "のることは　できません"
	prompt

BallBoxFullText:
	text "ボックスに　あずけている　#が"
	line "いっぱいなので　つかえません！"
	prompt

ItemUsedText:
	text "<PLAYER>は@"
	text_low
	text_from_ram wStringBuffer2
	text "を　つかった！"
	done

ItemGotOnText:
	text "<PLAYER>は@"
	text_low
	text_from_ram wStringBuffer2
	text "に　のった"
	prompt

ItemGotOffText:
	text "<PLAYER>は@"
	text_low
	text_from_ram wStringBuffer2
	text "から　おりた"
	prompt

ApplyPPUp:
	ld a, MON_MOVES
	call GetPartyParamLocation
	push hl
	ld de, wStringBuffer1
	predef FillPP
	pop hl
	ld c, MON_PP - MON_MOVES
	ld b, 0
	add hl, bc
	ld de, wStringBuffer1 + 1
	ld b, 0
.loop
	inc b
	ld a, b
	cp NUM_MOVES + 1
	ret z
	ld a, [wce37]
	dec a
	jr nz, .use
	ld a, [wMenuCursorY]
	inc a
	cp b
	jr nz, .skip
.use
	ld a, [hl]
	and PP_UP_MASK
	call nz, ComputeMaxPP
.skip
	inc hl
	inc de
	jr .loop

ComputeMaxPP:
	push bc
	; Divide the base PP by 5.
	ld a, [de]
	ldh [hDividend + 3], a
	xor a
	ldh [hDividend], a
	ldh [hDividend + 1], a
	ldh [hDividend + 2], a
	ld a, 5
	ldh [hDivisor], a
	ld b, 4
	call Divide
	; Get the number of PP, which are bits 6 and 7 of the PP value stored in RAM.
	ld a, [hl]
	ld b, a
	swap a
	and $f
	srl a
	srl a
	ld c, a
.loop
	; Normally, a move with 40 PP would have 64 PP with three PP Ups.
	; Since this would overflow into bit 6, we prevent that from happening
	; by decreasing the extra amount of PP each PP Up provides, resulting
	; in a maximum of 61.
	ldh a, [hQuotient + 3]
	cp $8
	jr c, .okay
	ld a, $7
.okay
	add b
	ld b, a
	ld a, [wce37]
	dec a
	jr z, .no_pp_up
	dec c
	jr nz, .loop
.no_pp_up
	ld [hl], b
	pop bc
	ret

GetMaxPPOfMove::
	ld a, [wMonType]
	and a

	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	jr z, .got_partymon ; PARTYMON

	ld hl, wOTPartyMon1Moves
	dec a
	jr z, .got_partymon ; OTPARTYMON

	ld hl, wBoxMon1Moves
	ld bc, BOXMON_STRUCT_LENGTH
	dec a
	jr z, .got_partymon ; BOXMON

	ld hl, wBufferMonMoves
	dec a
	jr z, .got_nonpartymon ; TEMPMON

	ld hl, wBattleMonMoves ; WILDMON

.got_nonpartymon ; TEMPMON, WILDMON
	call GetMthMoveOfCurrentMon
	jr .gotdatmove

.got_partymon ; PARTYMON, OTPARTYMON, BOXMON
	call GetMthMoveOfNthPartymon

.gotdatmove
	ld a, [hl]
	dec a

	push hl
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld b, a
	ld de, wStringBuffer1
	ld [de], a
	pop hl

	push bc
	ld bc, MON_PP - MON_MOVES
	ld a, [wMonType]
	cp WILDMON
	jr nz, .notwild
	ld bc, wEnemyMonPP - wEnemyMonMoves
.notwild
	add hl, bc
	ld a, [hl]
	and PP_UP_MASK
	pop bc

	or b
	ld hl, wStringBuffer1 + 1
	ld [hl], a
	xor a
	ld [wTempPP], a
	call ComputeMaxPP
	ld a, [hl]
	and PP_MASK
	ld [wTempPP], a
	ret

GetMthMoveOfNthPartymon:
	ld a, [wCurPartyMon]
	call AddNTimes

GetMthMoveOfCurrentMon:
	ld a, [wMenuCursorY]
	ld c, a
	ld b, $00
	add hl, bc
	ret

; Dummied out to always return the carry flag.
Stub_IsNextTileShoreOrWater_Old:
	scf
	ret

ReadSuperRodData_Old:
	ld a, [wMapId]
	ld de, 3
	ld hl, SuperRodData
	call FindItemInTable
	jr c, .ReadFishingGroup
	ld e, 2
	ret

.ReadFishingGroup
	inc hl

	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld b, [hl]
	inc hl
	ld e, $00

.random_loop
	call Random
	srl a
	ret c
	and %11
	cp b
	jr nc, .random_loop

	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	inc hl
	ld c, [hl]
	ld e, 1
	ret

INCLUDE "data/items/super_rod.inc"

ItemUseReloadOverworldData_Old::
	call LoadMapPart
	jp UpdateSprites
