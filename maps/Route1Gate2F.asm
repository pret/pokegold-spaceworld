include "constants.asm"

SECTION "maps/Route1Gate2F.asm", ROMX

Route1Gate2FScriptLoader::
	ld hl, Route1Gate2FScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

Route1Gate2FScriptPointers:
	dw Route1Gate2FScript
	dw Route1Gate2FNPCIDs

Route1Gate2FNPCIDs:
	db 0
	db 1
	db $FF

Route1Gate2FSignPointers:
	dw Route1Gate2FTextSign1
	dw Route1Gate2FTextSign2
Route1Gate2FTextPointers::
	dw Route1Gate2FTextNPC1
	dw Route1Gate2FTextNPC2

Route1Gate2FScript::
	ld hl, Route1Gate2FNPCIDs
	ld de, Route1Gate2FSignPointers
	call CallMapTextSubroutine
	ret

Route1Gate2FTextNPC1:
	ld hl, Route1Gate2FTextString1
	call OpenTextbox
	ret

Route1Gate2FTextNPC2:
	ld hl, Route1Gate2FTextString2
	call OpenTextbox
	ret

Route1Gate2FTextSign1:
	ld hl, Route1Gate2FTextString3
	call OpenTextbox
	ret

Route1Gate2FTextSign2:
	ld hl, Route1Gate2FTextString4
	call OpenTextbox
	ret

Route1Gate2FTextString1:
	text "ガンテツさんって　しってる？"

	para "ガンテツさんに"
	line "きに　いられるように　なれば"
	cont "トレーナーとして　たいしたもの　よ"
	done

Route1Gate2FTextString2:
	text "あなた　かんこうで　きたの？"
	line "なら　ざんねんね"

	para "オールドシティの"
	line "ごじゅうのとう　は"
	cont "だれでも　はいれる　って"
	cont "ものじゃないわ"
	done

Route1Gate2FTextString3:
	text "<PLAYER>は"
	line "ぼうえんきょうを　のぞいた！"

	para "むむむ！"
	line "たかーい　とう　が　みえる！"
	done

Route1Gate2FTextString4:
	text "<PLAYER>は"
	line "ぼうえんきょうを　のぞいた！"

	para "むむ？"
	line "ながーい　かわ　が　みえる"
	done
