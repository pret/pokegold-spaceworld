; FieldDebug_Jumptable constants
	const_def
	const FIELDDEBUG_RESET                   ; 0
	const FIELDDEBUG_CLOSE_MENU              ; 1
	const FIELDDEBUG_FRAME_TYPE              ; 2
	const FIELDDEBUG_MINIGAMES               ; 3
	const FIELDDEBUG_CHANGE_TRANSPORTATION   ; 4
	const FIELDDEBUG_CHANGE_TILESET          ; 5
	const FIELDDEBUG_TOWN_MAP                ; 6
	const FIELDDEBUG_SPRITE_VIEWER           ; 7
	const FIELDDEBUG_NAME_PLAYER             ; 8
	const FIELDDEBUG_TOOLGEAR                ; 9
	const FIELDDEBUG_CLEAR_EVENT_FLAGS       ; $a
	const FIELDDEBUG_HEAL_POKEMON            ; $b
	const FIELDDEBUG_CABLE_CLUB              ; $c
	const FIELDDEBUG_GO_TO_NEXT_PAGE         ; $d
	const FIELDDEBUG_NPC_MOVEMENT_TEST       ; $e
	const FIELDDEBUG_POKEMON_FOLLOWING       ; $f
	const FIELDDEBUG_FOLLOW_NPC_TEST         ; $10
	const FIELDDEBUG_WARP                    ; $11
	const FIELDDEBUG_FIELD_CUT               ; $12
	const FIELDDEBUG_CHECK_TILE              ; $13
	const FIELDDEBUG_MOVE_TO_ROUTE1_ENTRANCE ; $14
	const FIELDDEBUG_TOGGLE_NPC_MOVEMENT     ; $15
	const FIELDDEBUG_MAP_VIEWER              ; $16
	const FIELDDEBUG_ITEM_TEST               ; $17
	const FIELDDEBUG_PC_MENU                 ; $18
	const FIELDDEBUG_POKEMART_MENU           ; $19
	const FIELDDEBUG_TELEPORT                ; $1a
	const FIELDDEBUG_VRAM_VIEWER             ; $1b
	const FIELDDEBUG_TRAINER_GEAR            ; $1c

FieldDebug_MenuStrings:
	db "りセット@"
	db "とじる@"
	db "わくせん@"
	db "ゲーム@"
	db "のりもの@"
	db "セル@"
	db "ちず@"
	db "キャラ@"
	db "なまえ@"
	db "ツールギア@"
	db "イべント@"
	db "かいふく@"
	db "つうしん@"
	db "つぎ▶@"
	db "アニメ@"
	db "つれてく@"
	db "つれてけ@"
	db "ワープ@"
	db "くさかり@"
	db "あしもと@"
	db "じどう@"
	db "うごき@"
	db "マッパー@"
	db "アイテム@"
	db "パソコン@"
	db "ショップ@"
	db "テレポ！@"
	db "テスト@"
	db "じっけん@"

FieldDebug_Jumptable:
	dw FieldDebug_Reset
	dw FieldDebug_CloseMenu
	dw FieldDebug_FrameType
	dw FieldDebug_Minigames
	dw FieldDebug_ChangeTransportation
	dw FieldDebug_ChangeTileset
	dw FieldDebug_TownMap
	dw FieldDebug_SpriteViewer
	dw FieldDebug_NamePlayer
	dw FieldDebug_Toolgear
	dw FieldDebug_ClearEventFlags
	dw FieldDebug_HealPokemon
	dw FieldDebug_CableClub
	dw FieldDebug_GoToNextPage
	dw FieldDebug_NPCMovementTest
	dw FieldDebug_PokemonFollowing
	dw FieldDebug_FollowNPCTest
	dw FieldDebug_Warp
	dw FieldDebug_FieldCut
	dw FieldDebug_CheckTile
	dw FieldDebug_MoveToRoute1Entrance
	dw FieldDebug_ToggleNPCMovement
	dw FieldDebug_OpenMapViewer
	dw FieldDebug_ItemTest
	dw FieldDebug_PCMenu
	dw FieldDebug_PokemartMenu
	dw FieldDebug_Teleport
	dw FieldDebug_VRAMViewer
	dw FieldDebug_TrainerGear

FIELDDEBUG_NUM_PAGES EQU 3

FieldDebug_Pages:
; page 1
	db 7    ; number of items
	db FIELDDEBUG_GO_TO_NEXT_PAGE
	db FIELDDEBUG_WARP
	db FIELDDEBUG_SPRITE_VIEWER
	db FIELDDEBUG_CHANGE_TRANSPORTATION
	db FIELDDEBUG_TOOLGEAR
	db FIELDDEBUG_PC_MENU
	db FIELDDEBUG_CLOSE_MENU
	db -1

; page 2
	db 7    ; number of items
	db FIELDDEBUG_GO_TO_NEXT_PAGE
	db FIELDDEBUG_POKEMART_MENU
	db FIELDDEBUG_HEAL_POKEMON
	db FIELDDEBUG_TRAINER_GEAR
	db FIELDDEBUG_MINIGAMES
	db FIELDDEBUG_MAP_VIEWER
	db FIELDDEBUG_CLOSE_MENU
	db -1

; page 3
	db 7    ; number of items
	db FIELDDEBUG_GO_TO_NEXT_PAGE
	db FIELDDEBUG_CLEAR_EVENT_FLAGS
	db FIELDDEBUG_VRAM_VIEWER
	db FIELDDEBUG_TELEPORT
	db FIELDDEBUG_FOLLOW_NPC_TEST
	db FIELDDEBUG_TOWN_MAP
	db FIELDDEBUG_CLOSE_MENU
	db -1
