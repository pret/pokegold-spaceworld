	map_id QUIET_HILLS
	db 8 percent, 8 percent, 8 percent ; encounter rates: morn/day/nite
	; morn only
	db 7, DEX_LEDYBA
	db 7, DEX_LEDYBA
	db 5, DEX_METAPOD
	; morn/day
	db 5, DEX_PIKACHU
	db 7, DEX_PIDGEY
	db 5, DEX_PIDGEY
	db 6, DEX_PIDGEY
	; morn/day/nite
	db 4, DEX_CATERPIE
	db 6, DEX_CATERPIE
if DEF(_GOLD)
	db 6, DEX_HANEKO
endc
if DEF(_SILVER)
	db 6, DEX_MARILL
endc
	db 5, DEX_CATERPIE
	; day/nite
	db 8, DEX_LEDYBA
	db 4, DEX_METAPOD
	; nite only
	db 6, DEX_RATTATA
if DEF(_GOLD)
	db 6, DEX_CATERPIE
endc
if DEF(_SILVER)
	db 5, DEX_HOOTHOOT
endc
	db 6, DEX_LEDYBA
	db 5, DEX_METAPOD
	db 5, DEX_PIKACHU
