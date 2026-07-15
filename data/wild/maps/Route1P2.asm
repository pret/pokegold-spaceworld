	map_id ROUTE_1_P2
	db 8 percent, 8 percent, 8 percent ; encounter rates: morn/day/nite
	; morn only
if DEF(_GOLD)
	db 6, DEX_SUNNY
	db 6, DEX_SUNNY
	db 6, DEX_SUNNY
endc
if DEF(_SILVER)
	db 8, DEX_PIDGEY
	db 8, DEX_PIDGEY
	db 6, DEX_PIDGEY
endc
	; morn/day
	db 5, DEX_PIKACHU
	db 4, DEX_EKANS
	db 5, DEX_RATTATA
	db 5, DEX_PIDGEY
	; morn/day/nite
	db 7, DEX_YOROIDORI
	db 5, DEX_RATTATA
if DEF(_GOLD)
	db 8, DEX_HANEKO
endc
if DEF(_SILVER)
	db 8, DEX_MARIL
endc
	db 4, DEX_PIDGEY
	; day/nite
	db 7, DEX_RATTATA
	db 7, DEX_RATTATA
	; nite only
	db 6, DEX_EKANS
if DEF(_GOLD)
	db 6, DEX_RATTATA
endc
if DEF(_SILVER)
	db 6, DEX_HOHO
endc
	db 7, DEX_EKANS
	db 8, DEX_RATTATA
	db 5, DEX_PIKACHU
