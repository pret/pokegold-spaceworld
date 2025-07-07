INCLUDE "constants.asm"

SECTION "engine/pokemon/nickname_unused.asm", ROMX

; Unused. Also leftover from Generation I.
AskName_Old:
	push hl
	call LoadStandardMenuHeader
	ld a, [wBattleMode]
	dec a
	hlcoord 1, 0
	ld b, 4
	ld c, 10
	call z, ClearBox

	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
; Test for being in debug field mode that doesn't go anywhere... maybe the name screen was skipped in debug mode?
	ld a, [wDebugFlags]
	bit 1, a
	pop hl
	push hl
	ld hl, AskGiveNickname_Old
	call PrintText
	call YesNoBox
	pop hl
	jr c, .declined_nickname

	push hl
	ld e, l
	ld d, h
	ld a, BANK(NamingScreen)
	ld b, NAME_MON
	ld hl, NamingScreen
	call FarCall_hl
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call GetMemSGBLayout
	call SetPalettes
	ld a, [wBattleMode]
	and a
	jr nz, .in_battle
	call LoadFontExtra
	call ReloadSpritesAndFont
	jr .done

.in_battle
	callfar _LoadHPBar
.done
	pop hl
	ld a, [hl]
	cp "@"
	jr nz, .not_terminated ; shouldn't this be the other way around? 'jr z' instead of 'jr nz'?
.declined_nickname
	ld d, h
	ld e, l
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes
.not_terminated
	call CloseWindow
	ret

AskGiveNickname_Old:
	text_from_ram wStringBuffer1
	text "に"
	line "ニックネームを　つけますか？"
	done

Unreferenced_DisplayNameRaterScreen:
	ld de, wMiscStringBuffer
	push de
	ld hl, NamingScreen
	ld b, NAME_MON
	ld a, BANK(NamingScreen)
	call FarCall_hl
	call ClearBGPalettes
	call RestoreScreenAndReloadTiles
	call UpdateTimePals
	pop de
	ld a, [de]
	cp "@"
	jr z, .empty_name
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld e, l
	ld d, h
	ld hl, wMiscStringBuffer
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	and a
	ret

.empty_name
	scf
	ret
