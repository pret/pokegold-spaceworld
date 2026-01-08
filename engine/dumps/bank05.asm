INCLUDE "constants.asm"

SECTION "engine/dumps/bank05.asm", ROMX

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

_SilentHillHouseStoveScript::
	ld hl, .SilentHillHouseStoveText
	call OpenTextbox
	ret

; Player's stove
.SilentHillHouseStoveText:
	text "ガスコンロの　ひは　きえている"
	line "あんぜん　だいいち！"
	done

_SilentHillHouseSinkScript::
	ld hl, .SilentHillHouseSinkText
	call OpenTextbox
	ret

.SilentHillHouseSinkText:
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
_SilentHillHouseTVScript::
	ld a, [wTimeOfDay]
	and a
	jr nz, .not_day
	ld hl, .SilentHillHouseTVDayText
	jr .done

.not_day
	dec a
	jr nz, .not_night
	ld hl, .SilentHillHouseTVNightText
	jr .done

.not_night
	ld hl, .SilentHillHouseTVMorningText
.done
	call OpenTextbox
	ret

; Scene from "Pokémon: I Choose You!"
.SilentHillHouseTVDayText:
	text "ピカチュウが　オニスズメと"
	line "たたかっている<⋯⋯>"
	cont "サトシが　なみだ　ぐんでいる<⋯⋯>"
	cont "#アニメだ！"
	done

; Scene from "Primeape Goes Bananas"
.SilentHillHouseTVNightText:
	text "オコリザルが　あばれている<⋯⋯>"
	cont "サトシが　にげまわってる！<⋯⋯>"
	cont "#アニメだ！"
	done

; Scene from "Bulbasaur's Mysterious Garden"
.SilentHillHouseTVMorningText:
	text "フシギダネが　すねている<⋯⋯>"
	cont "サトシが　こまっている<⋯⋯>"
	cont "#アニメだ！"
	done

Unreferenced_CheckInlineTrainers:
	ld a, [wDebugFlags]
	set UNK_DEBUG_FLAG_6_F, a ; Should probably be "bit UNK_DEBUG_FLAG_6_F, a"?
	ret nz
	xor a
	ldh [hSeenTrainerDistance], a
	ldh [hSeenTrainerDirection], a
	ld a, FOLLOWER + 1
	ldh [hSeenTrainerObject], a
	ld hl, wCurrMapInlineTrainers + (2 * FOLLOWER_OBJECT_INDEX) ; Skip wReservedObjectStruct and the player's struct
	ld de, 2 ; Length of wCurrMapInlineTrainers entries
	ld b, NUM_OBJECTS - FOLLOWER_OBJECT_INDEX
.loop
	ld a, [hl]
	and a
	jr nz, .found
	add hl, de
	ldh a, [hSeenTrainerObject]
	inc a
	ldh [hSeenTrainerObject], a
	dec b
	jr nz, .loop
	ret

.found
	ldh [hSeenTrainerDistance], a
	inc hl
	ld a, [hl]
	ldh [hSeenTrainerDirection], a
	ld hl, wDebugFlags
	set UNK_DEBUG_FLAG_6_F, [hl]
	ret

Unreferenced_TestTrainerWalkToPlayer:
	ld hl, wJoypadFlags
	set 6, [hl]
	ldh a, [hSeenTrainerObject]
	call FreezeAllOtherObjects
	ldh a, [hSeenTrainerObject]
	ld hl, .MovementData
	ldh a, [hSeenTrainerDistance]
	dec a
	ld e, a
	ld d, 0
	add hl, de
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

.MovementData:
	big_step LEFT
	big_step LEFT
	big_step LEFT
	step_end

Bank05_FillerStart::
