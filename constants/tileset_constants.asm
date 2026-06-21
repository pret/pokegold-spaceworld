; Tilesets indexes (see data/tilesets.asm)
	const_def
	const TILESET_SILENT_HILL          ; 00
	const TILESET_OLD_CITY             ; 01
	const TILESET_WEST                 ; 02
	const TILESET_HIGH_TECH            ; 03
	const TILESET_BIRDON               ; 04
	const TILESET_FONT                 ; 05
	const TILESET_NORTH                ; 06
	const TILESET_KANTO                ; 07
	const TILESET_SOUTH                ; 08
	const TILESET_HOUSE                ; 09
	const TILESET_LAB                  ; 0a
	const TILESET_TRADITIONAL_HOUSE    ; 0b
	const TILESET_POKECENTER           ; 0c
	const TILESET_MART                 ; 0d
	const TILESET_AQUARIUM             ; 0e
	const TILESET_TOWER                ; 0f
	const TILESET_DEPT_STORE           ; 10
	const TILESET_GATE                 ; 11
	const TILESET_RADIO_TOWER          ; 12
	const TILESET_ROCKET_HOUSE         ; 13
	const TILESET_GYM                  ; 14
	const TILESET_OFFICE               ; 15
	const TILESET_RUINS_OF_ALPH        ; 16
	const TILESET_CAVE                 ; 17
	const TILESET_POWER_PLANT          ; 18
	const TILESET_SHIP                 ; 19
	const TILESET_SHIP_PORT            ; 1a
	const TILESET_FOREST               ; 1b
DEF NUM_TILESETS EQU const_value - 1

; wTileset struct size
DEF TILESET_LENGTH EQU 11
