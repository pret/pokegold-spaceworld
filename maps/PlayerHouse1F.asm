	map_attributes PlayerHouse1F, PLAYER_HOUSE_1F

PlayerHouse1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  6,  7, SILENT_HILL, 1, 48
	warp_event  7,  7, SILENT_HILL, 1, 48
	warp_event  9,  0, PLAYER_HOUSE_2F, 1, 16

	def_bg_events
	bg_event  0,  1, 1
	bg_event  1,  1, 2
	bg_event  2,  1, 3
	bg_event  4,  1, 4
	bg_event  5,  1, 5

	def_object_events
	object_event  7,  3, SPRITE_MOM, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

PlayerHouse1F_Blocks::
INCBIN "maps/PlayerHouse1F.blk"

PlayerHouse1F_ScriptLoader::
	map_generic_scriptloader

PlayerHouse1FScriptPointers::
	dw PlayerHouse1FScript1
	dw PlayerHouse1FNPCIDs1
	dw PlayerHouse1FScript2
	dw PlayerHouse1FNPCIDs2

PlayerHouse1FNPCIDs1:
	db $FF

PlayerHouse1FNPCIDs2:
	db 0
	db $FF

PlayerHouse1FScript1:
	ld hl, PlayerHouse1FNPCIDs1
	ld de, PlayerHouse1FSignPointers
	call CallMapTextSubroutine
	ret

PlayerHouse1FScript2:
	ld hl, PlayerHouse1FNPCIDs2
	ld de, PlayerHouse1FSignPointers
	call CallMapTextSubroutine
	ret

PlayerHouse1FSignPointers:
	dw SilentHillHouseStoveScript
	dw SilentHillHouseSinkScript
	dw PlayerHouse1FFridgeScript
	dw SilentHillHouseTVScript
	dw PokemonBooksScript
PlayerHouse1F_TextPointers::
	dw PlayerHouse1FNPCText1

PlayerHouse1FNPCText1:
	ld hl, PlayerHouse1FTextString1
	call OpenTextbox
	ret

PlayerHouse1FTextString1:
	text "おかあさん『えっ　あなた"
	line "オーキドはかせに"
	cont "ポケモンずかんを　つくってくれって"
	cont "たのまれたの？"

	para "すごいじゃない！"
	line "わたしも　ポケモン　きらいって"
	cont "わけじゃないし　がんばるのよ！"
	done
