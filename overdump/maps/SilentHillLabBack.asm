if DEF(_GOLD)
Unreferenced_Corrupt_SilentHillLabBackTextString11:
	db "ぜ　<PLAYER>！"
	line "さきに　えらんで！"
	cont "おれは　こころが　ひろいからな"
	done

Unreferenced_Corrupt_SilentHillLabBackTextString12:
	text "<RIVAL>『じゃ　おれは　これ！"
	done

Unreferenced_Corrupt_SilentHillLabBackTextString13:
	text "<RIVAL>は　オーキドから"
	line "@"
	text_from_ram wStringBuffer1
	text "を　もらった！"
	done

Unreferenced_Corrupt_SilentHillLabBackTextString14:
	text "<RIVAL>『<PLAYER>の#"
	line "いいなあ！"
	cont "でも　おれのポケモンも"
	cont "ちょっと　いいだろ？"
	done

Unreferenced_Corrupt_SilentHillLabBackChoseStarter:
	CheckEvent SILENT_HILL_LAB_BACK_CHOSE_STARTER
	jr nz, .bigjump
	ldh a, [hLastTalked]
	sub 2
	ld [wChosenStarter], a
	ld d, 0
	ld e, a
	ld hl, Unreferenced_Corrupt_SilentHillLabBackStarterData
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
	ld hl, Unreferenced_Corrupt_SilentHillLabBackTextString15
	call OpenTextbox + Bank34NonDebugOffset - Bank34CorruptOffset
	ret
Unreferenced_Corrupt_SilentHillLabBackStarterData:
	db DEX_HONOGUMA
	dw @ - $229
	db DEX_CRUISE

	db DEX_CRUISE
	dw @ - $203
	db DEX_HAPPA

	db DEX_HAPPA
	dw @ - $1de
	db DEX_HONOGUMA

Unreferenced_Corrupt_SilentHillLabBackTextString15:
	text "オーキド『これ！"
	line "よくばっちゃ　いかん！"
	done

Unreferenced_Corrupt_SilentHillLabBackTextPointers2:
	dw PokemonBooksScript + Bank34NonDebugOffset - Bank34CorruptOffset
	dw PokemonBooksScript + Bank34NonDebugOffset - Bank34CorruptOffset
	dw PokemonBooksScript + Bank34NonDebugOffset - Bank34CorruptOffset
	dw PokemonBooksScript + Bank34NonDebugOffset - Bank34CorruptOffset
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset
endc
