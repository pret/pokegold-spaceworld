Route2_ScriptLoader::
	ld hl, Route2ScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

Route2ScriptPointers::
	def_script_pointers
	script_pointer Route2Script, Route2NPCIDs, SCENE_ROUTE_2_DEFAULT

Route2NPCIDs:
	npc_id ROUTE_2_RIVAL
	npc_id ROUTE_2_KIMONO_GIRL
	db -1

Route2SignPointers:
	dw Route2TextSign1

Route2_TextPointers::
	dw Route2Text1
	dw Route2Text2

Route2Script::
	ld a, [wYCoord]
	cp 6
	jr nz, .skipCheck
	ld a, [wXCoord]
	cp 9
	jr nz, .skipCheck
	ld a, PLAYER_OBJECT
	ld d, LEFT
	call SetObjectFacing
	ld a, ROUTE_2_RIVAL
	ld d, RIGHT
	call SetObjectFacing
	jr .endDemo
.skipCheck
	ld hl, Route2NPCIDs ;data
	ld de, Route2SignPointers ;start of textld pointers?
	call CallMapTextSubroutine
	ret

.endDemo
Route2Text1:
	ld hl, Route2TextString4
	call OpenTextbox
	call GBFadeOutToBlack
	jp Init

Route2Text2:
	ld hl, wRoute2Flags
	bit 1, [hl]
	jr nz, .Text2Jump ; already fought
	ld hl, Route2TextString1
	call OpenTextbox
	ld hl, wRoute2Flags
	set 1, [hl]
	ld a, TRAINER_KIMONO_GIRL
	ld [wOtherTrainerClass], a
if DEF(_GOLD)
	ld a, KIMONO_GIRL_KOUME
endc
if DEF(_SILVER)
	ld a, KIMONO_GIRL_TAMAO
endc
	ld [wOtherTrainerID], a
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, MAPSTATUS_START_TRAINER_BATTLE
	ld [wMapStatus], a
	ret

.Text2Jump
Route2Text3:
	ld hl, Route2TextString3
	call OpenTextbox
	ret

Route2TextSign1:
	ld hl, Route2TextString5
	call OpenTextbox
	ret

if DEF(_GOLD)
Route2TextString1:
	text "まあ　かわいらしい　トレーナーやこと"
	line "うちと　ポケモン　しはります？"
	done

Route2TextString2: ; (unused?)
	text "いやあ　かんにんやわあ"
	done

Route2TextString3:
	text "かわいい　かおして　つよおすなあ"
	line "その　ちょうしで　おきばりやす"
	done
endc
if DEF(_SILVER)
Route2TextString1:
	text "うちの　ポケモン"
	line "そら　もう　かわいいんどすえ"
	done

Route2TextString2: ; (unused?)
	text "うそでしょー！"
	line "じゃなくて　なに　しはるんよ"
	done

Route2TextString3:
	text "プりンちゃんが　かわいそ　どす"
	done
endc

Route2TextString4:
if DEF(_GOLD)
	text "シゲル『おっ　サトシじゃないか！"

	para "なんとか　ここまで　これた"
	line "って　かんじだな"
endc
if DEF(_SILVER)
	text "サトシ『おっ　シゲルじゃないか"
	line "なんとか　ここまで　これた"
	cont "って　かんじだな"
endc
	para "じつりょくが　ないのに"
	line "むり　するなよな"

	para "もっと　ポケモン　あつめるとか"
	line "いろんな　ポケモン　そだてるとか"
	cont "やること　あるだろ？"

	para "ここで　ひきかえしたほうが　いいぜ！"
	line "じゃあな"
	done

Route2TextString5:
	text "ここは　１ばん　どうろ"
	line "サイレントヒル　⋯⋯　オールドシティ"
	done
