; The actual code for std_collision.asm isn't present yet, so scripts are currently loaded
; from an object placed over the corresponding collision tile.

; Early duplicate of PlayerHouse2FRadioText, which is present in the map's bank in the final game.
; Uses the long "ポケモン" and "⋯⋯⋯⋯" instead of their shortcuts, and lacks the final sentence.
_Unreferenced_PokemonNewsScript::
	ld hl, .DuplicatePokemonNewsText
	call OpenTextbox
	ret

.DuplicatePokemonNewsText
	text "<PLAYER>は"
	line "ラジオのスイッチを　おした！"

	para "ジェイ　オー　ピー　エム"
	line "こちらは"
	cont "ポケモン　ほうそうきょく　です"

	para "ポケモンニュースを　おおくりします"

	para "⋯⋯　ポケモンの　せかいてきな"
	line "けんきゅうしゃ　オーキドはかせが"
	cont "カントーから　すがたを　けしました"
	cont "あらたな　けんきゅうの　ばしょを"
	cont "もとめて　いどうした　との"
	cont "みかたも　ありますが"
	cont "なんらかの　じけんに　まきこまれた"
	cont "かのうせいも　あり"
	cont "かんけいしゃは　とても"
	cont "しんぱい　しています"

	para "⋯⋯⋯⋯いじょう"
	line "ポケモンニュースでした"

	para "⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯"
	done

_PokemonBooksScript::
	ld hl, .PokemonBooksText
	call OpenTextbox
	ret

; "Crammed full of POKéMON books!" flavor text
.PokemonBooksText:
	text "ポケモンえほんが　そろってる！"
	done

_PlayerHouse1FFridgeScript::
	ld hl, .PlayerHouse1FFridgeText
	call OpenTextbox
	ret

; Player's empty fridge flavor text
.PlayerHouse1FFridgeText:
	text "なかは<⋯⋯>"
	line "ほとんど　からっぽだ<⋯⋯>"
	done

_RivalHouseStoveScript::
	ld hl, .RivalHouseStoveText
	call OpenTextbox
	ret

; Player's stove
.RivalHouseStoveText:
	text "ガスコンロの　ひは　きえている"
	line "あんぜん　だいいち！"
	done

_RivalHouseSinkScript::
	ld hl, .RivalHouseSinkText
	call OpenTextbox
	ret

.RivalHouseSinkText:
	text "ピカピカの　ながしだい！"
	line "こんやの　メニューは　なんだろう？"
	done

_PokecenterSignScript::
	ld hl, .PokecenterSignText
	call OpenTextbox
	ret

.PokecenterSignText:
	text "ポケモンの　たいりょく　かいふく！"
	line "ポケモンセンター"
	done

_RivalHouseWindowScript::
	ld hl, .RivalHouseWindowText
	call OpenTextbox
	ret

.RivalHouseWindowText:
	text "まどが　よごれているぞ？"
	done

; Various scenes from the Pokemon anime that play on the player and rival's TVs
_RivalHouseTVScript::
	ld a, [wTimeOfDay]
	and a
	jr nz, .not_day
	ld hl, .RivalHouseTVDayText
	jr .done

.not_day
	dec a
	jr nz, .not_night
	ld hl, .RivalHouseTVNightText
	jr .done

.not_night
	ld hl, .RivalHouseTVMorningText
.done
	call OpenTextbox
	ret

; Scene from "Pokémon: I Choose You!"
.RivalHouseTVDayText:
	text "ピカチュウが　オニスズメと"
	line "たたかっている<⋯⋯>"
	cont "サトシが　なみだ　ぐんでいる<⋯⋯>"
	cont "#アニメだ！"
	done

; Scene from "Primeape Goes Bananas"
.RivalHouseTVNightText:
	text "オコリザルが　あばれている<⋯⋯>"
	cont "サトシが　にげまわってる！<⋯⋯>"
	cont "#アニメだ！"
	done

; Scene from "Bulbasaur's Mysterious Garden"
.RivalHouseTVMorningText:
	text "フシギダネが　すねている<⋯⋯>"
	cont "サトシが　こまっている<⋯⋯>"
	cont "#アニメだ！"
	done
