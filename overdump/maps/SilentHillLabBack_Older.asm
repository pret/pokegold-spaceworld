Unreferenced_Corrupt_SilentHillLabBack_OlderChoseStarter:
	dw wPlayerStarter
	push hl
	ld [wNamedObjectIndexBuffer], a
	ld a, BANK(StarterDex)
	ld hl, StarterDex + Bank34StarterDexOffset + $38
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
	ld hl, Unreferenced_Corrupt_SilentHillLabBack_OlderTextString15
	call OpenTextbox + Bank34NonDebugOffset - Bank34CorruptOffset
	ret
Unreferenced_Corrupt_SilentHillLabBack_OlderStarterData:
	db DEX_HONOGUMA
	dw @ - $229
	db DEX_CRUISE

	db DEX_CRUISE
	dw @ - $203
	db DEX_HAPPA

	db DEX_HAPPA
	dw @ - $1de
	db DEX_HONOGUMA

Unreferenced_Corrupt_SilentHillLabBack_OlderTextString15:
	text "オーキド『これ！"
	line "よくばっちゃ　いかん！"
	done

Unreferenced_Corrupt_SilentHillLabBack_OlderTextPointers2:
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset
