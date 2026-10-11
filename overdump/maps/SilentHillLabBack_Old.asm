if DEF(_SILVER)
Unreferenced_Corrupt_SilentHillLabBack_OldTextString6:
	db "おお！　くさのポケモン"
	line "@"
	text_from_ram wStringBuffer1
	text "が　いいんじゃな？@"

	start_asm
	call Unreferenced_Corrupt_Old_ConfirmPokemonSelection
	call TextAsmEnd + Bank34NonDebugOffset - Bank34CorruptOffset
	ret

Unreferenced_Corrupt_Old_ConfirmPokemonSelection:
	call YesNoBox
	jr c, .bigJump
	SetEvent SILENT_HILL_LAB_BACK_CHOSE_STARTER
	ld a, SCENE_PLAYER_HOUSE_1F_MOM_BACK
	ld [wPlayerHouse1FSceneID], a
	ld a, SCENE_PLAYER_HOUSE_2F_KEN_LEFT
	ld [wPlayerHouse2FSceneID], a
	ld a, SCENE_RIVAL_HOUSE_KEN_HERE
	ld [wRivalHouseSceneID], a
	ld hl, Unreferenced_Corrupt_SilentHillLabBack_OldTextString8
	call PrintText
	ld hl, wJoypadDisable
	set JOYPAD_DISABLE_CLOSE_TEXTBOX_F, [hl]
	ld a, [wPlayerStarter]
	ld [wCurPartySpecies], a
	ld a, 5
	ld [wCurPartyLevel], a
	ld hl, GivePoke + Bank34StarterDexOffset
	ld a, BANK(GivePoke)
	call FarCall_hl + Bank34NonDebugOffset - Bank34CorruptOffset
	xor a
	ld [wPartyMon1Item], a
	ld a, SCENE_SILENT_HILL_LAB_BACK_RIVAL_CHOOSING_STARTER
	ld [wMapScriptNumber], a
	ret
.bigJump
	ld hl, Unreferenced_Corrupt_SilentHillLabBack_OldTextString7
	call PrintText
	ret

Unreferenced_Corrupt_SilentHillLabBack_OldTextString7:
	text "では"
	line "どれに　するのじゃ？"
	done

Unreferenced_Corrupt_SilentHillLabBack_OldTextString8:
	text "オーキド『この　ポケモンは"
	line "ほんとに　げんきが　いいぞ！"

	para "<PLAYER>は　オーキドはかせから"
	line "@"
	text_from_ram wStringBuffer1
	text "を　もらった！"
	prompt

Unreferenced_Corrupt_SilentHillLabBack_OldTextString9:
	text "オーキド『そうじゃ！"
	line "やせいの　ポケモンが　でて　きても"
	cont "そいつを　たたかわせて　いけば"
	cont "となりまちへ　いける！"
	done

Unreferenced_Corrupt_SilentHillLabBack_OldFunc3:
	CheckEvent SILENT_HILL_LAB_BACK_CHOSE_STARTER
	ld hl, Unreferenced_Corrupt_SilentHillLabBack_OldTextString11
	jr z, .skip
	ld hl, Unreferenced_Corrupt_SilentHillLabBack_OldTextString14
.skip
	call OpenTextbox + Bank34NonDebugOffset - Bank34CorruptOffset
	ret

Unreferenced_Corrupt_SilentHillLabBack_OldTextString10:
	text "<RIVAL>『あッ！　おれにも！"
	line "じいさん　おれにもくれ"
endc
	db "よう！"
	done

Unreferenced_Corrupt_SilentHillLabBack_OldTextString11:
	text "<RIVAL>『いいぜ　<PLAYER>！"
	line "さきに　えらんで！"
	cont "おれは　こころが　ひろいからな"
	done

Unreferenced_Corrupt_SilentHillLabBack_OldTextString12:
	text "<RIVAL>『じゃ　おれは　これ！"
	done

Unreferenced_Corrupt_SilentHillLabBack_OldTextString13:
	text "<RIVAL>は　オーキドから"
	line "@"
	text_from_ram wStringBuffer1
	text "を　もらった！"
	done

Unreferenced_Corrupt_SilentHillLabBack_OldTextString14:
	text "<RIVAL>『<PLAYER>の#"
	line "いいなあ！"
	cont "でも　おれのポケモンも"
	cont "ちょっと　いいだろ？"
	done

Unreferenced_Corrupt_SilentHillLabBack_OldChoseStarter:
	CheckEvent SILENT_HILL_LAB_BACK_CHOSE_STARTER
	jr nz, .bigjump
	ldh a, [hLastTalked]
	sub 2
	ld [wChosenStarter], a
	ld d, 0
	ld e, a
	ld hl, Unreferenced_Corrupt_SilentHillLabBack_OldStarterData
	add hl, de
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld [wPlayerStarter], a
	push hl
	ld [wNamedObjectIndexBuffer], a
	ld a, BANK(StarterDex)
	ld hl, StarterDex + Bank34StarterDexOffset
	call FarCall_hl + Bank34NonDebugOffset - Bank34CorruptOffset
	ld a, [wPlayerStarter]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName + Bank34NonDebugOffset - Bank34CorruptOffset
	pop hl
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call OpenTextbox + Bank34NonDebugOffset - Bank34CorruptOffset
	pop hl
	inc hl
	inc hl
	ld a, [hl]
	ld [wRivalStarter], a
	ret
.bigjump
	ld hl, Unreferenced_Corrupt_SilentHillLabBack_OldTextString15
	call OpenTextbox + Bank34NonDebugOffset - Bank34CorruptOffset
	ret
Unreferenced_Corrupt_SilentHillLabBack_OldStarterData:
	db DEX_HONOGUMA
	dw @ - $229
	db DEX_CRUISE

	db DEX_CRUISE
	dw @ - $203
	db DEX_HAPPA

	db DEX_HAPPA
	dw @ - $1de
	db DEX_HONOGUMA

Unreferenced_Corrupt_SilentHillLabBack_OldTextString15:
	text "オーキド『これ！"
	line "よくばっちゃ　いかん！"
	done

Unreferenced_Corrupt_SilentHillLabBack_OldTextPointers2:
	dw PokemonBooksScript + Bank34NonDebugOffset - Bank34CorruptOffset - Bank34OldOffset
	dw PokemonBooksScript + Bank34NonDebugOffset - Bank34CorruptOffset - Bank34OldOffset
	dw PokemonBooksScript + Bank34NonDebugOffset - Bank34CorruptOffset - Bank34OldOffset
	dw PokemonBooksScript + Bank34NonDebugOffset - Bank34CorruptOffset - Bank34OldOffset
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset
