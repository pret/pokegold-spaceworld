INCLUDE "constants.asm"

MACRO landmark
; X, Y. The game actually stores and reads the bytes swapped, with Y first and X second.
; Made a macro for convenience and to avoid confusion.
; Not used right now, but use in the future?
	db \2 + 16, \1 + 8

ENDM

SECTION "data/maps/landmarks.asm@LandmarkPositions", ROMX

LandmarkPositions:
	db 0, 0				; LANDMARK_NONE
	db 28, 156			; LANDMARK_NORTH
	db 40, 156			; LANDMARK_BULL_FOREST_ROUTE_3
	db 52, 156			; LANDMARK_BULL_FOREST
	db 64, 156			; LANDMARK_BULL_FOREST_ROUTE_2
	db 76, 156			; LANDMARK_STAND
	db 92, 156			; LANDMARK_STAND_ROUTE
	db 108, 148			; LANDMARK_KANTO_EAST_ROUTE
	db 108, 132			; LANDMARK_KANTO
	db 108, 120			; LANDMARK_ROUTE_SILENT_EAST
	db 108, 108			; LANDMARK_SILENT_HILL
	db 100, 108			; LANDMARK_PRINCE
	db 92, 108			; LANDMARK_MT_FUJI
	db 108, 100			; LANDMARK_ROUTE_1_P1
	db 108, 92			; LANDMARK_ROUTE_1_P2
	db 92, 92			; LANDMARK_OLD_CITY
	db 92, 80			; LANDMARK_ROUTE_2
	db 92, 68			; LANDMARK_WEST
	db 80, 68			; LANDMARK_BAADON_ROUTE_1
	db 68, 68			; LANDMARK_BAADON
	db 68, 92			; LANDMARK_BAADON_ROUTE_2
	db 68, 108			; LANDMARK_BAADON_ROUTE_3
	db 76, 116			; LANDMARK_ROUTE_15
	db 76, 124			; LANDMARK_NEWTYPE
	db 64, 124			; LANDMARK_SUGAR_ROUTE
	db 52, 124			; LANDMARK_SUGAR
	db 76, 132			; LANDMARK_NEWTYPE_ROUTE
	db 60, 140			; LANDMARK_ROUTE_18
	db 52, 148			; LANDMARK_BULL_FOREST_ROUTE_1
	db 92, 128			; LANDMARK_1C
	db 84, 104			; LANDMARK_1D
	db 60, 56			; LANDMARK_FONTO_ROUTE_3
	db 60, 44			; LANDMARK_FONTO
	db 52, 44			; LANDMARK_FONTO_ROUTE_2
	db 44, 32			; LANDMARK_FONTO_ROUTE_6
	db 52, 20			; LANDMARK_FONTO_ROUTE_5
	db 60, 20			; LANDMARK_SOUTH
	db 60, 32			; LANDMARK_FONTO_ROUTE_1
	db 72, 20			; LANDMARK_HAITEKU_WEST_ROUTE_OCEAN
	db 84, 28			; LANDMARK_HAITEKU_WEST_ROUTE
	db 84, 44			; LANDMARK_HAITEKU
	db 84, 56			; LANDMARK_WASTE_BRIDGE
	db 60, 68			; LANDMARK_FONTO_ROUTE_4
	db 72, 44			; LANDMARK_FONTO_BRIDGE

SECTION "data/maps/landmarks.asm@LandmarkNames", ROMX

LandmarkNames::
	db "サイレント@" ; SILENT
	db "オールド@" ; OLD
	db "ウエスト@" ; WEST
	db "ハイテク@" ; HIGH_TECH
	db "フォント@" ; FOUNT
	db "バードン@" ; BIRDON
	db "ニュータイプ@" ; NEW_TYPE
	db "シュガー@" ; SUGAR
	db "ブルーフォレスト@" ; BLUE_FOREST
	db "スタンド@" ; STAND
	db "カントー@" ; KANTO
	db "プりンス@" ; PRINCE
	db "フジヤマ@" ; MT_FUJI
	db "サウス@" ; SOUTH
	db "ノース@" ; NORTH
	db "１５ばんどうろ@" ; ROUTE_15
	db "１８ばんどうろ@" ; ROUTE_18
	db "はつでんしょ１@" ; POWER_PLANT_1
	db "はつでんしょ２@" ; POWER_PLANT_2
	db "はつでんしょ３@" ; POWER_PLANT_3
	db "はつでんしょ４@" ; POWER_PLANT_4
	db "いせき　１@" ; RUINS_1
	db "いせき　２@" ; RUINS_2
	db "はいこう１@" ; MINES_1
	db "はいこう２@" ; MINES_2
	db "はいこう３@" ; MINES_3
	db "はいこう４@" ; MINES_4
	db "はいこう５@" ; MINES_5
	db "はいこう６@" ; MINES_6
	db "はいこう７@" ; MINES_7
	db "アジト　１@" ; HIDEOUT_1
	db "アジト　２@" ; HIDEOUT_2
	db "アジト　３@" ; HIDEOUT_3
	db "ヤドンの　いど１@" ; SLOWPOKE_WELL_1
	db "ヤドンの　いど２@" ; SLOWPOKE_WELL_2
	db "#りーぐ１@" ; POKEMON_LEAGUE_1
	db "#りーぐ１@" ; POKEMON_LEAGUE_1_2
	db "#りーぐ２@" ; POKEMON_LEAGUE_2
	db "#りーぐ３@" ; POKEMON_LEAGUE_3
	db "#りーぐ４@" ; POKEMON_LEAGUE_4
	db "#りーぐ５@" ; POKEMON_LEAGUE_5
	db "#りーぐ６@" ; POKEMON_LEAGUE_6
	db "#りーぐ７@" ; POKEMON_LEAGUE_7
	db "#りーぐ７@" ; POKEMON_LEAGUE_7_2
	db "しずかなおか@" ; SILENT_HILL
