INCLUDE "constants.asm"

SECTION "home/unknown_388f.asm", ROM0

EmptyFunction388f::
	ret

Unreferenced_PokemonNewsScript::
	farcall _Unreferenced_PokemonNewsScript
	ret

PokemonBooksScript::
	farcall _PokemonBooksScript
	ret

PlayerHouse1FFridgeScript::
	farcall _PlayerHouse1FFridgeScript
	ret

SilentHillHouseStoveScript::
	farcall _SilentHillHouseStoveScript
	ret

SilentHillHouseSinkScript::
	farcall _SilentHillHouseSinkScript
	ret

SilentHillHouseTVScript::
	farcall _SilentHillHouseTVScript
	ret

PokecenterSignScript::
	farcall _PokecenterSignScript
	ret

RivalHouseWindowScript::
	farcall _RivalHouseWindowScript
	ret

InitTrainerBattle::
	ld hl, wOverworldFlags
	set 7, [hl]
	ld a, MAPSTATUS_START_TRAINER_BATTLE
	ld [wMapStatus], a
	ret

TestWildBattleStart::
	ldh a, [hJoyState]
	and D_PAD
	ret z ; if no directions are down, don't try and trigger a wild encounter
	call CheckBPressedDebug
	jp nz, xor_a ; if b button is down, clear acc
	callfar TryWildBattle
	ld a, [wBattleMode]
	and a
	ret z ; if no battle, return
	ld a, MAPSTATUS_START_WILD_BATTLE
	call SetMapStatus
	call xor_a_dec_a
	ret

OverworldLoop_StartBattle::
	predef StartBattle
	ld a, $f3
	ldh [hMapEntryMethod], a
	ld hl, wd4a9
	set 5, [hl]
	ld hl, wJoypadFlags
	set 4, [hl]
	set 6, [hl]
	ld a, MAPSTATUS_EXIT_BATTLE
	call SetMapStatus
	ret

OverworldLoop_05::
	ret

OverworldLoop_ExitBattle::
	ld a, [wBattleResult]
	cp LOSE
	jr z, .DemoGameOver
	ld a, MAPSTATUS_RETURN_TO_MAIN
	call SetMapStatus
	ret

.DemoGameOver:
	ld hl, wJoypadFlags
	res 4, [hl]
	ld hl, .text
	call OpenTextbox
	call GBFadeOutToBlack
	jp Init

.text:
	text "つぎは　がんばるぞ！！"
	done
