; Old super rod encounter table.
SuperRodData:
	dbw $00, .Group1  ; PALLET_TOWN
	dbw $01, .Group1  ; VIRIDIAN_CITY
	dbw $03, .Group3  ; CERULEAN_CITY
	dbw $05, .Group4  ; VERMILION_CITY
	dbw $06, .Group5  ; CELADON_CITY
	dbw $07, .Group10 ; FUCHSIA_CITY
	dbw $08, .Group8  ; CINNABAR_ISLAND
	dbw $0f, .Group3  ; ROUTE_4
	dbw $11, .Group4  ; ROUTE_6
	dbw $15, .Group5  ; ROUTE_10
	dbw $16, .Group4  ; ROUTE_11
	dbw $17, .Group7  ; ROUTE_12
	dbw $18, .Group7  ; ROUTE_13
	dbw $1c, .Group7  ; ROUTE_17
	dbw $1d, .Group7  ; ROUTE_18
	dbw $1e, .Group8  ; ROUTE_19
	dbw $1f, .Group8  ; ROUTE_20
	dbw $20, .Group8  ; ROUTE_21
	dbw $21, .Group2  ; ROUTE_22
	dbw $22, .Group9  ; ROUTE_23
	dbw $23, .Group3  ; ROUTE_24
	dbw $24, .Group3  ; ROUTE_25
	dbw $41, .Group3  ; CERULEAN_GYM
	dbw $5e, .Group4  ; VERMILION_DOCK
	dbw $a1, .Group8  ; SEAFOAM_ISLANDS_B3F
	dbw $a2, .Group8  ; SEAFOAM_ISLANDS_B4F
	dbw $d9, .Group6  ; SAFARI_ZONE_EAST
	dbw $da, .Group6  ; SAFART_ZONE_NORTH
	dbw $db, .Group6  ; SAFARI_ZONE_WEST
	dbw $dc, .Group6  ; SAFARI_ZONE_CENTER
	dbw $e2, .Group9  ; CERULEAN_CAVE_2F
	dbw $e3, .Group9  ; CERULEAN_CAVE_B1F
	dbw $e4, .Group9  ; CERLIEAN_CAVE_1F
	db -1 ; end

.Group1:
	db 2
	db 15, MON_TENTACOOL
	db 15, MON_POLIWAG

.Group2:
	db 2
	db 15, MON_GOLDEEN
	db 15, MON_POLIWAG

.Group3:
	db 3
	db 15, MON_PSYDUCK
	db 15, MON_GOLDEEN
	db 15, MON_KRABBY

.Group4:
	db 2
	db 15, MON_KRABBY
	db 15, MON_SHELLDER

.Group5:
	db 2
	db 23, MON_POLIWHIRL
	db 15, MON_SLOWPOKE

.Group6:
	db 4
	db 15, MON_DRATINI
	db 15, MON_KRABBY
	db 15, MON_PSYDUCK
	db 15, MON_SLOWPOKE

.Group7:
	db 4
	db  5, MON_TENTACOOL
	db 15, MON_KRABBY
	db 15, MON_GOLDEEN
	db 15, MON_MAGIKARP

.Group8:
	db 4
	db 15, MON_STARYU
	db 15, MON_HORSEA
	db 15, MON_SHELLDER
	db 15, MON_GOLDEEN

.Group9:
	db 4
	db 23, MON_SLOWBRO
	db 23, MON_SEAKING
	db 23, MON_KINGLER
	db 23, MON_SEADRA

.Group10:
	db 4
	db 23, MON_SEAKING
	db 15, MON_KRABBY
	db 15, MON_GOLDEEN
	db 15, MON_MAGIKARP
