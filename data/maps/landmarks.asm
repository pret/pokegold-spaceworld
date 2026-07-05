MACRO landmark
; X, Y.
; Unlike the final game, the prototype actually stores and reads the bytes swapped, with Y first and X second.
	db \2 + 16, \1 + 8

ENDM

LandmarkPositions:
	landmark  -8, -16 ; LANDMARK_NONE
	landmark 148,  12 ; LANDMARK_NORTH
	landmark 148,  24 ; LANDMARK_BLUE_FOREST_ROUTE_3
	landmark 148,  36 ; LANDMARK_BLUE_FOREST
	landmark 148,  48 ; LANDMARK_BLUE_FOREST_ROUTE_2
	landmark 148,  60 ; LANDMARK_STAND
	landmark 148,  76 ; LANDMARK_STAND_ROUTE
	landmark 140,  92 ; LANDMARK_KANTO_EAST_ROUTE
	landmark 124,  92 ; LANDMARK_KANTO
	landmark 112,  92 ; LANDMARK_ROUTE_SILENT_EAST
	landmark 100,  92 ; LANDMARK_SILENT_HILL
	landmark 100,  84 ; LANDMARK_PRINCE
	landmark 100,  76 ; LANDMARK_MT_FUJI
	landmark  92,  92 ; LANDMARK_ROUTE_1_P1
	landmark  84,  92 ; LANDMARK_ROUTE_1_P2
	landmark  84,  76 ; LANDMARK_OLD_CITY
	landmark  72,  76 ; LANDMARK_ROUTE_2
	landmark  60,  76 ; LANDMARK_WEST
	landmark  60,  64 ; LANDMARK_BIRDON_ROUTE_1
	landmark  60,  52 ; LANDMARK_BIRDON
	landmark  84,  52 ; LANDMARK_BIRDON_ROUTE_2
	landmark 100,  52 ; LANDMARK_BIRDON_ROUTE_3
	landmark 108,  60 ; LANDMARK_ROUTE_15
	landmark 116,  60 ; LANDMARK_NEWTYPE
	landmark 116,  48 ; LANDMARK_SUGAR_ROUTE
	landmark 116,  36 ; LANDMARK_SUGAR
	landmark 124,  60 ; LANDMARK_NEWTYPE_ROUTE
	landmark 132,  44 ; LANDMARK_ROUTE_18
	landmark 140,  36 ; LANDMARK_BLUE_FOREST_ROUTE_1
	landmark 120,  76 ; LANDMARK_1C
	landmark  96,  68 ; LANDMARK_1D
	landmark  48,  44 ; LANDMARK_FONT_ROUTE_3
	landmark  36,  44 ; LANDMARK_FONT
	landmark  36,  36 ; LANDMARK_FONT_ROUTE_2
	landmark  24,  28 ; LANDMARK_FONT_ROUTE_6
	landmark  12,  36 ; LANDMARK_FONT_ROUTE_5
	landmark  12,  44 ; LANDMARK_SOUTH
	landmark  24,  44 ; LANDMARK_FONT_ROUTE_1
	landmark  12,  56 ; LANDMARK_HIGH_TECH_WEST_ROUTE_OCEAN
	landmark  20,  68 ; LANDMARK_HIGH_TECH_WEST_ROUTE
	landmark  36,  68 ; LANDMARK_HIGH_TECH
	landmark  48,  68 ; LANDMARK_WASTE_BRIDGE
	landmark  60,  44 ; LANDMARK_FONT_ROUTE_4
	landmark  36,  56 ; LANDMARK_FONT_BRIDGE
