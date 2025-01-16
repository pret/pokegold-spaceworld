INCLUDE "constants.asm"

MACRO landmark
; X, Y.
; Unlike the final game, the prototype actually stores and reads the bytes swapped, with Y first and X second.
	db \2 + 16, \1 + 8

ENDM

SECTION "data/maps/landmarks.asm", ROMX

LandmarkPositions:
	landmark -8, -16		; LANDMARK_NONE
	landmark 148, 12		; LANDMARK_NORTH
	landmark 148, 24		; LANDMARK_BULL_FOREST_ROUTE_3
	landmark 148, 36		; LANDMARK_BULL_FOREST
	landmark 148, 48		; LANDMARK_BULL_FOREST_ROUTE_2
	landmark 148, 60 		; LANDMARK_STAND
	landmark 148, 76		; LANDMARK_STAND_ROUTE
	landmark 140, 92		; LANDMARK_KANTO_EAST_ROUTE
	landmark 124, 92		; LANDMARK_KANTO
	landmark 112, 92		; LANDMARK_ROUTE_SILENT_EAST
	landmark 100, 92		; LANDMARK_SILENT_HILL
	landmark 100, 84		; LANDMARK_PRINCE
	landmark 100, 76 		; LANDMARK_MT_FUJI
	landmark 92, 92 		; LANDMARK_ROUTE_1_P1
	landmark 84, 92			; LANDMARK_ROUTE_1_P2
	landmark 84, 76			; LANDMARK_OLD_CITY
	landmark 72, 76			; LANDMARK_ROUTE_2
	landmark 60, 76			; LANDMARK_WEST
	landmark 60, 64			; LANDMARK_BAADON_ROUTE_1
	landmark 60, 52			; LANDMARK_BAADON
	landmark 84, 52			; LANDMARK_BAADON_ROUTE_2
	landmark 100, 52		; LANDMARK_BAADON_ROUTE_3
	landmark 108, 60		; LANDMARK_ROUTE_15
	landmark 116, 60		; LANDMARK_NEWTYPE
	landmark 116, 48		; LANDMARK_SUGAR_ROUTE
	landmark 116, 36		; LANDMARK_SUGAR
	landmark 124, 60		; LANDMARK_NEWTYPE_ROUTE
	landmark 132, 44		; LANDMARK_ROUTE_18
	landmark 140, 36		; LANDMARK_BULL_FOREST_ROUTE_1
	landmark 120, 76		; LANDMARK_1C
	landmark 96, 68			; LANDMARK_1D
	landmark 48, 44			; LANDMARK_FONTO_ROUTE_3
	landmark 36, 44			; LANDMARK_FONTO
	landmark 36, 36			; LANDMARK_FONTO_ROUTE_2
	landmark 24, 28			; LANDMARK_FONTO_ROUTE_6
	landmark 12, 36			; LANDMARK_FONTO_ROUTE_5
	landmark 12, 44			; LANDMARK_SOUTH
	landmark 24, 44			; LANDMARK_FONTO_ROUTE_1
	landmark 12, 56			; LANDMARK_HAITEKU_WEST_ROUTE_OCEAN
	landmark 20, 68			; LANDMARK_HAITEKU_WEST_ROUTE
	landmark 36, 68			; LANDMARK_HAITEKU
	landmark 48, 68			; LANDMARK_WASTE_BRIDGE
	landmark 60, 44			; LANDMARK_FONTO_ROUTE_4
	landmark 36, 56			; LANDMARK_FONTO_BRIDGE

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
