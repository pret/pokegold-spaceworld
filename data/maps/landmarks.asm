MACRO landmark
; X, Y.
; Unlike the final game, the prototype actually stores and reads the bytes swapped, with Y first and X second.
	db \2 + 16, \1 + 8

ENDM

LandmarkPositions:
	landmark  -8, -16 ; LANDMARK_NONE
	landmark 148,  12 ; LANDMARK_NORTH
	landmark 148,  24 ; LANDMARK_ROUTE_26
	landmark 148,  36 ; LANDMARK_BLUE_FOREST
	landmark 148,  48 ; LANDMARK_ROUTE_20
	landmark 148,  60 ; LANDMARK_STAND
	landmark 148,  76 ; LANDMARK_ROUTE_21
	landmark 140,  92 ; LANDMARK_ROUTE_22
	landmark 124,  92 ; LANDMARK_KANTO
	landmark 112,  92 ; LANDMARK_ROUTE_23
	landmark 100,  92 ; LANDMARK_SILENT_HILL
	landmark 100,  84 ; LANDMARK_PRINCE
	landmark 100,  76 ; LANDMARK_MT_FUJI
	landmark  92,  92 ; LANDMARK_ROUTE_1
	landmark  84,  92 ; LANDMARK_ROUTE_2
	landmark  84,  76 ; LANDMARK_OLD_CITY
	landmark  72,  76 ; LANDMARK_ROUTE_3
	landmark  60,  76 ; LANDMARK_WEST
	landmark  60,  64 ; LANDMARK_ROUTE_4
	landmark  60,  52 ; LANDMARK_BIRDON
	landmark  84,  52 ; LANDMARK_ROUTE_13
	landmark 100,  52 ; LANDMARK_ROUTE_14
	landmark 108,  60 ; LANDMARK_ROUTE_15
	landmark 116,  60 ; LANDMARK_NEWTYPE
	landmark 116,  48 ; LANDMARK_ROUTE_16
	landmark 116,  36 ; LANDMARK_SUGAR
	landmark 124,  60 ; LANDMARK_ROUTE_17
	landmark 132,  44 ; LANDMARK_ROUTE_18
	landmark 140,  36 ; LANDMARK_ROUTE_19
	landmark 120,  76 ; LANDMARK_1C
	landmark  96,  68 ; LANDMARK_1D
	landmark  48,  44 ; LANDMARK_ROUTE_11
	landmark  36,  44 ; LANDMARK_FONT
	landmark  36,  36 ; LANDMARK_ROUTE_10
	landmark  24,  28 ; LANDMARK_ROUTE_25
	landmark  12,  36 ; LANDMARK_ROUTE_24
	landmark  12,  44 ; LANDMARK_SOUTH
	landmark  24,  44 ; LANDMARK_ROUTE_9
	landmark  12,  56 ; LANDMARK_HIGH_TECH_WEST_ROUTE_OCEAN
	landmark  20,  68 ; LANDMARK_HIGH_TECH_WEST_ROUTE
	landmark  36,  68 ; LANDMARK_HIGH_TECH
	landmark  48,  68 ; LANDMARK_WASTE_BRIDGE
	landmark  60,  44 ; LANDMARK_ROUTE_12
	landmark  36,  56 ; LANDMARK_FONT_BRIDGE
