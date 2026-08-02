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

_EmptyFridgeScript::
	ld hl, .EmptyFridgeText
	call OpenTextbox
	ret

; Player's empty fridge flavor text
.EmptyFridgeText:
	text "なかは<⋯⋯>"
	line "ほとんど　からっぽだ<⋯⋯>"
	done

_StoveScript::
	ld hl, .StoveText
	call OpenTextbox
	ret

.StoveText:
	text "ガスコンロの　ひは　きえている"
	line "あんぜん　だいいち！"
	done

_SinkScript::
	ld hl, .SinkText
	call OpenTextbox
	ret

.SinkText:
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

_WindowScript::
	ld hl, .WindowText
	call OpenTextbox
	ret

.WindowText:
	text "まどが　よごれているぞ？"
	done

; Various scenes from the Pokemon anime that play on the player and rival's TVs
_TVScript::
	ld a, [wTimeOfDay]
	and a
	jr nz, .not_day
	ld hl, .TVDayText
	jr .done

.not_day
	dec a
	jr nz, .not_night
	ld hl, .TVNightText
	jr .done

.not_night
	ld hl, .TVMorningText
.done
	call OpenTextbox
	ret

; Scene from "Pokémon: I Choose You!"
.TVDayText:
	text "ピカチュウが　オニスズメと"
	line "たたかっている<⋯⋯>"
	cont "サトシが　なみだ　ぐんでいる<⋯⋯>"
	cont "#アニメだ！"
	done

; Scene from "Primeape Goes Bananas"
.TVNightText:
	text "オコリザルが　あばれている<⋯⋯>"
	cont "サトシが　にげまわってる！<⋯⋯>"
	cont "#アニメだ！"
	done

; Scene from "Bulbasaur's Mysterious Garden"
.TVMorningText:
	text "フシギダネが　すねている<⋯⋯>"
	cont "サトシが　こまっている<⋯⋯>"
	cont "#アニメだ！"
	done
