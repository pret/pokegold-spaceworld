Route1_ScriptLoader::
	ld hl, Route1ScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

Route1ScriptPointers::
	dw Route1Script
	dw Route1NPCIDs

Route1NPCIDs:
	db 0
	db 1
	db $FF

Route1SignPointers:
	dw Route1TextSign1
	dw Route1TextSign2

Route1_TextPointers::
	dw Route1TextNPC1
	dw Route1TextNPC2

Route1Script::
	ld hl, Route1NPCIDs
	ld de, Route1SignPointers
	call CallMapTextSubroutine
	ret

Route1TextNPC1:
	ld hl, Route1TextString1
	call OpenTextbox
	ret

Route1TextNPC2:
	ld hl, Route1TextString2
	call OpenTextbox
	ret

Route1TextSign1:
	ld hl, Route1TextString3
	call OpenTextbox
	ret

Route1TextSign2:
	ld hl, Route1TextString4
	call OpenTextbox
	ret

Route1TextString1:
	text "しょうねん！"

	para "モンスターボールは"
	line "やせいの　ポケモンを　よわらせてから"
	cont "つかうのが　きほんだ！"
	done

Route1TextString2:
	text "ぼく　ゆうがた　じゅくの　かえりに"
	line "かわった　ポケモンを　みたよ"
	done

Route1TextString3:
	text "このさき　しずかな　おか"
	line "やせいの　ポケモンに　ちゅうい"
	done

Route1TextString4:
	text "ここは　１ばん　どうろ"
	line "サイレントヒル　⋯⋯　オールドシティ"
	done
