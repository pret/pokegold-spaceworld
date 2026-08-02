ClearGraphicsForPartyMenu::
	ldh a, [rLCDC]
	bit rLCDC_ENABLE, a
	jr z, .InitPartyMenuGFX
	call ClearBGPalettes

.InitPartyMenuGFX
	ld hl, wStateFlags
	res SPRITE_UPDATES_DISABLED_F, [hl]
	call ClearSprites
	xor a
	ldh [hBGMapMode], a
	call ClearTileMap
	call UpdateSprites
	ret

OpenPartyMenu_ClearGraphics::
	call ClearGraphicsForPartyMenu
	; Fallthrough
OpenPartyMenu::
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	ld hl, wOptions
	set NO_TEXT_SCROLL_F, [hl]

	call InitPartyMenu
	call InitPartyMenuLayout
	call PartyMenuSelect

	ld hl, wOptions
	res NO_TEXT_SCROLL_F, [hl]
	pop bc
	ld a, b
	ldh [hMapAnims], a
	ret

InitPartyMenu:
	call LoadFontsBattleExtra
	xor a
	ld [wMonType], a
	ld de, PartyMenu2DMenuData
	call SetMenuAttributes

	ld a, [wPartyCount]
	ld [w2DMenuNumRows], a

	ld b, a
	ld a, [wFailedToFlee]
	and a
	ld a, $03
	jr z, .cancel
	xor a ; FALSE
	ld [wFailedToFlee], a
	ld a, $01
.cancel
	ld [wMenuJoypadFilter], a
	ld a, [wPartyMenuCursor]
	and a
	jr z, .skip
	inc b
	cp b
	jr c, .done
.skip
	ld a, $01
.done
	ld [wMenuCursorY], a
	ret

PartyMenu2DMenuData:
	db 1, 0 ; cursor start y, x
	db 0, 1 ; rows, columns
	db _2DMENU_WRAP_UP_DOWN | _2DMENU_ENABLE_SPRITE_ANIMS ; flags 1
	db 0 ; flags 2
	dn 2, 0 ; cursor offset
	db 0 ; accepted buttons

PartyMenuSelect::
	call StaticMenuJoypad
	call PlaceHollowCursor
	ld a, [wMenuCursorY]
	ld [wPartyMenuCursor], a
	ldh a, [hJoySum]
	ld b, a
	ld a, [wSelectedSwapPosition]
	and a
	jp nz, .swap_mons
	ld a, [wPartyCount]
	and a
	jr z, .exitmenu
	bit 1, b
	jr nz, .exitmenu

	ld a, [wMenuCursorY]
	dec a
	ld [wCurPartyMon], a

	ld c, a
	ld b, $00
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl]
	ld [wCurPartySpecies], a
	ld [wTempBattleMonSpecies], a
	and a
	ret

.exitmenu
	scf
	ret
.swap_mons
	bit B_BUTTON_F, b
	jr nz, .done
	call _SwitchPartyMons
.done
	call PartyMenu_ClearCursor
	xor a
	ld [wSelectedSwapPosition], a
	ld [wPartyMenuActionText], a
	call InitPartyMenuLayout
	jp PartyMenuSelect

InitPartyMenuLayout::
	ld a, [wPartyMenuActionText]
	cp PARTYMENUACTION_MOVE
	jp z, PrintPartyMenuText

	callfar LoadOverworldMonIcon
	call PartyMenu_ClearCursor
	callfar InitPartyMenuPalettes
	hlcoord 3, 1
	ld de, wPartySpecies
	ld a, [wCurPartyMon]
	push af
	xor a
	ld [wCurPartyMon], a
	ld [wSGBPals], a
.loop
	ld a, [de]
	cp -1
	jp z, .done
	push de
	call PlacePartyMember
	pop de
	ld a, [wCurPartyMon]
	ldh [hObjectStructIndex], a
	push hl
	push de

	ld hl, LoadMenuMonIcon
	ld a, BANK(LoadMenuMonIcon)
	ld e, MONICON_PARTYMENU
	call FarCall_hl

	pop de
	inc de
	pop hl
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	ld a, [wCurPartyMon]
	inc a
	ld [wCurPartyMon], a
	jr .loop

.done
	pop af
	ld [wCurPartyMon], a
	jp PrintPartyText_GetSGBLayout

WritePartyMenuTilemapAndText::
	ld a, [wPartyMenuActionText]
	cp PARTYMENUACTION_MOVE
	jp z, PrintPartyMenuText

	callfar InitPartyMenuPalettes
	hlcoord 3, 1
	ld de, wPartySpecies
	ld a, [wCurPartyMon]
	push af
	xor a
	ld [wCurPartyMon], a
	ld [wSGBPals], a
.loop
	ld a, [de]
	cp -1
	jp z, .done
	push de
	call PlacePartyMember
	pop de
	ld a, [wCurPartyMon]
	ldh [hEventID], a
	inc de
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	ld a, [wCurPartyMon] ; redundant
	inc a
	ld [wCurPartyMon], a
	jr .loop

.done
	pop af
	ld [wCurPartyMon], a
	jp PrintPartyText_GetSGBLayout

; Places the tilemap of the party member at wCurPartyMon.
PlacePartyMember::
	push bc
	push hl
	push hl
	ld hl, wPartyMonNicknames
	ld a, [wCurPartyMon]
	call GetNick
	pop hl
	call PlaceString
	call CopyMonToTempMon
	pop hl

	push hl
	ld a, [wSelectedSwapPosition]
	and a
	jr z, .not_switching

	dec a
	ld b, a
	ld a, [wCurPartyMon]
	cp b
	jr nz, .not_switching

	dec hl
	dec hl
	dec hl
	ld a, '▷'
	ld [hli], a
	inc hl
	inc hl

.not_switching
	ld a, [wPartyMenuActionText]
	cp PARTYMENUACTION_TEACH_TMHM
	jr z, .PlacePartyMonTMHMCompatibility
	cp PARTYMENUACTION_EVO_STONE
	jr z, .PlacePartyMonEvoStoneCompatibility
	cp PARTYMENUACTION_GIVE_MON
	jp z, .PlacePartyMonGender
	cp PARTYMENUACTION_GIVE_MON_FEMALE
	jp z, .PlacePartyMonGender
	push hl
	ld bc, -15
	add hl, bc
	ld de, wTempMonStatus
	call PlaceStatusString
	pop hl
	push hl
	ld bc, -12
	add hl, bc
	ld b, 0
	call DrawEnemyHP
	push de
	call SetPartyHPBarPalette
	pop de
	pop hl
	jr .PrintLevel

.PlacePartyMonTMHMCompatibility
	push hl
	predef CanLearnTMHMMove
	pop hl
	ld de, .string_able
	ld a, c
	and a
	jr nz, .able
	ld de, .string_not_able
.able
	push hl
	ld bc, 9
	add hl, bc
	call PlaceString
	pop hl
.PrintLevel
	ld bc, 5
	add hl, bc
	push de
	call PrintLevel
	pop de
	pop hl
	pop bc
	ret

.string_able:
	db "おぼえられる@" ; "ABLE"

.string_not_able:
	db "おぼえられない@" ; "NOT ABLE"

.PlacePartyMonEvoStoneCompatibility:
	push hl
	ld hl, EvosAttacksPointers
	ld a, [wTempMonSpecies]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
; BUG: Only the first three evolution entries can have Stone compatibility reported correctly.
; While this never comes up in the final game, this prototype has Espeon and Umbreon evolving from
; Heart Stones and Poison Stones respectively, making it five evolution stone entries for Eevee.
	ld de, wStringBuffer1
	ld a, BANK(EvosAttacksPointers)
	ld bc, 2
	call FarCopyBytes
	ld hl, wStringBuffer1
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wStringBuffer1
	ld a, BANK(EvosAttacks)
	ld bc, 10
	call FarCopyBytes
	ld hl, wStringBuffer1
	ld de, .string_cant_use

.loop
	ld a, [hli]
	and a
	jr z, .nope
	inc hl
	inc hl
	cp EVOLVE_STONE
	jr nz, .loop
	dec hl
	dec hl
	ld b, [hl]
	ld a, [wCurItem]
	inc hl
	inc hl
	cp b
	jr nz, .loop
	ld de, .string_can_use

.nope
	pop hl
	push hl
	ld bc, 9
	add hl, bc
	call PlaceString
	pop hl
	jr .PrintLevel

.string_can_use
	db "つかえる@" ; "ABLE"
.string_cant_use
	db "つかえない@" ; "NOT ABLE"

.PlacePartyMonGender
	xor a
	ld [wMonType], a
	push hl
	call GetGender
	pop hl
	ld de, .male
	jr c, .got_gender
	ld de, .female
.got_gender
	push hl
	ld bc, 9
	add hl, bc
	call PlaceString
	pop hl
	jp .PrintLevel

.male
	db "オス@"

.female
	db "メス@"

PrintPartyText_GetSGBLayout::
	ld b, SGB_PARTY_MENU
	call GetSGBLayout
PrintPartyMenuText::
	ld hl, wOptions
	ld a, [hl]
	push af
	push hl
	set NO_TEXT_SCROLL_F, [hl]

	ld a, [wPartyMenuActionText]
	cp PARTYMENUTEXT_HEAL_PSN
	jr nc, .heal

	add a
	ld c, a
	ld b, 0
	ld hl, .PartyMenuStrings
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	jr .done

.heal
	and $f
	add a
	ld c, a
	ld b, 0
	ld hl, .MenuActionStrings
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	pop hl
	call PrintText
.done
	pop hl
	pop af
	ld [hl], a
	call WaitBGMap
	call SetDefaultBGPAndOBP
	ret

.MenuActionStrings
	dw CuredOfPoisonText
	dw BurnWasHealedText
	dw _WasDefrostedText
	dw _WokeUpText
	dw RidOfParalysisText
	dw RecoveredSomeHPText
	dw HealthReturnedText
	dw RevitalizedText
	dw _GrewToLevelText

.PartyMenuStrings
	dw ChooseAMonString
	dw UseOnWhichPKMNString
	dw WhichPKMNString
	dw TeachWhichPKMNString
	dw MoveToWhereString
	dw UseOnWhichPKMNString
	dw ChooseFirstMonString
	dw ChooseSecondMonString

ChooseAMonString:
	text "#を　えらんで　ください"
	done

UseOnWhichPKMNString:
	text "どの#に　つかいますか？"
	done

WhichPKMNString:
	text "どの#を　だしますか？"
	done

TeachWhichPKMNString:
	text "どの#に　おしえますか？"
	done

MoveToWhereString:
	text "どこに　いどうしますか？"
	done

ChooseFirstMonString:
	text "１ぴきめの　#を"
	line "えらんで　ください"
	done

ChooseSecondMonString:
	text "２ひきめの　#を"
	line "えらんで　ください"
	done

RecoveredSomeHPText:
	text_from_ram wStringBuffer1
	text "の　たいりょくが"
	line "@"
	deciram wHPBarHPDifference, 2, 3
	text "　かいふくした"
	done

CuredOfPoisonText:
	text_from_ram wStringBuffer1
	text "の　どくは"
	line "きれい　さっぱり　なくなった！"
	done

RidOfParalysisText:
	text_from_ram wStringBuffer1
	text "の　からだの"
	line "しびれが　とれた"
	done

BurnWasHealedText:
	text_from_ram wStringBuffer1
	text "の"
	line "やけどが　なおった"
	done

_WasDefrostedText:
	text_from_ram wStringBuffer1
	text "の　からだの"
	line "こおりが　とけた"
	done

_WokeUpText:
	text_from_ram wStringBuffer1
	text "は"
	line "めを　さました"
	done

HealthReturnedText:
	text_from_ram wStringBuffer1
	text "は"
	line "けんこうになった！"
	done

RevitalizedText:
	text_from_ram wStringBuffer1
	text "は"
	line "げんきを　とりもどした！"
	done

_GrewToLevelText:
	text_from_ram wStringBuffer1
	text "の　レベルが@"
	deciram wCurPartyLevel, 1, 3
	text "になった@"
	sound_dex_fanfare_50_79
	text_waitbutton
	text_end

SetPartyHPBarPalette::
	ld hl, wHPPals
	ld a, [wSGBPals]
	ld c, a
	ld b, 0
	add hl, bc
	call SetHPPal
	ld b, SGB_PARTY_MENU_HP_PALS
	call GetSGBLayout
	ld hl, wSGBPals
	inc [hl]
	ret

PlaceStatusString::
	push de
	inc de
	inc de
	ld a, [de]
	ld b, a
	inc de
	ld a, [de]
	or b
	pop de
	jr nz, PlaceNonFaintStatus
	; "FNT" equivalent string
	ld a, 'ひ'
	ld [hli], a
	ld a, 'ん'
	ld [hli], a
	ld [hl], 'し'
	and a
	ret

PlaceNonFaintStatus::
	ld a, [de]
	bit PSN, a
	jr nz, .PsnString
	bit BRN, a
	jr nz, .BrnString
	bit FRZ, a
	jr nz, .FrzString
	bit PAR, a
	jr nz, .ParString
	and SLP
	ret z
	; "SLP" equivalent string
	ld a, 'ね'
	ld [hli], a
	ld a, 'む'
	ld [hli], a
	ld [hl], 'り'
	ret

.PsnString
	ld a, '<DO>'
	ld [hli], a
	ld [hl], 'く'
	ret

.BrnString
	ld a, 'や'
	ld [hli], a
	ld a, 'け'
	ld [hli], a
	ld [hl], '<DO>'
	ret

.FrzString
	ld a, 'こ'
	ld [hli], a
	ld a, 'お'
	ld [hli], a
	ld [hl], 'り'
	ret

.ParString
	ld a, 'ま'
	ld [hli], a
	ld [hl], 'ひ'
	ret
