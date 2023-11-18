INCLUDE "constants.asm"

SECTION "data/maps/landmarks.asm", ROMX

LandmarkNames::
	db "サイレント@"       ; SILENT (Silent Hill, town)
	db "オールド@"         ; OLD
	db "ウエスト@"         ; WEST
	db "ハイテク@"         ; HIGH_TECH
	db "フォント@"         ; FONT
	db "バードン@"         ; BIRDON
	db "ニュータイプ@"     ; NEW_TYPE
	db "シュガー@"         ; SUGAR
	db "ブルーフォレスト@"  ; BLUE_FOREST
	db "スタンド@"         ; STAND
	db "カントー@"         ; KANTO
	db "プりンス@"         ; PRINCE
	db "フジヤマ@"         ; MT_FUJI
	db "サウス@"           ; SOUTH
	db "ノース@"           ; NORTH
	db "１５ばんどうろ@"    ; ROUTE_15
	db "１８ばんどうろ@"    ; ROUTE_18
	db "はつでんしょ１@"    ; POWER_PLANT_1
	db "はつでんしょ２@"    ; POWER_PLANT_2
	db "はつでんしょ３@"    ; POWER_PLANT_3
	db "はつでんしょ４@"    ; POWER_PLANT_4
	db "いせき　１@"        ; RUINS_1
	db "いせき　２@"        ; RUINS_2
	db "はいこう１@"        ; ABANDONED_MINE_1
	db "はいこう２@"        ; ABANDONED_MINE_2
	db "はいこう３@"        ; ABANDONED_MINE_3
	db "はいこう４@"        ; ABANDONED_MINE_4
	db "はいこう５@"        ; ABANDONED_MINE_5
	db "はいこう６@"        ; ABANDONED_MINE_6
	db "はいこう７@"        ; ABANDONED_MINE_7
	db "アジト　１@"        ; HIDEOUT_1
	db "アジト　２@"        ; HIDEOUT_2
	db "アジト　３@"        ; HIDEOUT_3
	db "ヤドンの　いど１@"   ; YADON_WELL_1
	db "ヤドンの　いど２@"   ; YADON_WELL_2
; The Pokémon League landmarks below were misspelled by Game Freak
; since they should print out リーグ and not りーぐ.
	db "#りーぐ１@"         ; POKEMON_LEAGUE_1 (map group $02)
	db "#りーぐ１@"         ; POKEMON_LEAGUE_1_2 (map group $03)
	db "#りーぐ２@"         ; POKEMON_LEAGUE_2
	db "#りーぐ３@"         ; POKEMON_LEAGUE_3
	db "#りーぐ４@"         ; POKEMON_LEAGUE_4
	db "#りーぐ５@"         ; POKEMON_LEAGUE_5
	db "#りーぐ６@"         ; POKEMON_LEAGUE_6
	db "#りーぐ７@"         ; POKEMON_LEAGUE_7 (map group $0b, map $07)
	db "#りーぐ７@"         ; POKEMON_LEAGUE_7_2 (map group $0b, map $25)
	db "しずかなおか@"      ; SILENT_HILL (dungeon)
