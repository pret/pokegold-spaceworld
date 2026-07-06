; TODO: These aren't bespoke morning/day/night chunks. Find a way to indicate this.

GrassWildMons::

	map_id ROUTE_1_P1
	db 8 percent, 8 percent, 8 percent ; encounter rates: morn/day/nite
	; morn only
if DEF(_GOLD)
	db 7, DEX_SUNNY
	db 3, DEX_SUNNY
	db 5, DEX_SUNNY
endc
if DEF(_SILVER)
	db 8, DEX_PIDGEY
	db 8, DEX_PIDGEY
	db 7, DEX_PIDGEY
endc
	; morn/day
	db 5, DEX_PIKACHU
	db 5, DEX_PIDGEY
	db 5, DEX_PIDGEY
	db 4, DEX_RATTATA
	; morn/day/nite
	db 6, DEX_KIRINRIKI
	db 4, DEX_KIRINRIKI
if DEF(_GOLD)
	db 4, DEX_HANEKO
endc
if DEF(_SILVER)
	db 4, DEX_MARIL
endc
	db 4, DEX_PIDGEY
	; day/nite
	db 8, DEX_RATTATA
	db 7, DEX_RATTATA
	; nite only
	db 5, DEX_RATTATA
	db 5, DEX_RATTATA
if DEF(_GOLD)
	db 7, DEX_RATTATA
	db 8, DEX_RATTATA
endc
if DEF(_SILVER)
	db 5, DEX_HOHO
	db 3, DEX_HOHO
endc
	db 5, DEX_PIKACHU

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

	map_id ROUTE_2
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 9, DEX_CATERPIE
	db 9, DEX_METAPOD
	db 8, DEX_CATERPIE
	; morn/day
	db 7, DEX_METAPOD
	db 10, DEX_PIDGEY
	db 7, DEX_CATERPIE
	db 8, DEX_CATERPIE
	; morn/day/nite
	db 9, DEX_PIDGEY
	db 11, DEX_RATTATA
	db 9, DEX_RATTATA
	db 10, DEX_RATTATA
	; day/nite
	db 8, DEX_CATERPIE
	db 9, DEX_RATTATA
	; nite only
	db 10, DEX_HOHO
	db 11, DEX_ODDISH
	db 12, DEX_HOHO
	db 11, DEX_ODDISH
	db 13, DEX_ODDISH

	map_id BIRDON_ROUTE_1
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 19, DEX_DITTO
	db 20, DEX_FEAROW
	db 18, DEX_DITTO
	; morn/day
	db 17, DEX_METAPOD
	db 21, DEX_FEAROW
	db 17, DEX_DITTO
	db 17, DEX_SPEAROW
	; morn/day/nite
	db 18, DEX_SPEAROW
	db 21, DEX_DODUO
	db 19, DEX_DODUO
	db 20, DEX_DODUO
	; day/nite
	db 18, DEX_DITTO
	db 19, DEX_DROWZEE
	; nite only
	db 20, DEX_DROWZEE
	db 21, DEX_DROWZEE
	db 22, DEX_DROWZEE
	db 23, DEX_DROWZEE
	db 23, DEX_DROWZEE

	map_id HIGHTECH_WEST_ROUTE
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 12, DEX_EXEGGCUTE
	db 12, DEX_VENONAT
	db 11, DEX_EXEGGCUTE
	; morn/day
	db 10, DEX_VENONAT
	db 13, DEX_SPEAROW
	db 10, DEX_EXEGGCUTE
	db 11, DEX_SPEAROW
	; morn/day/nite
	db 12, DEX_SPEAROW
	db 14, DEX_GEODUDE
	db 12, DEX_GEODUDE
	db 13, DEX_GEODUDE
	; day/nite
	db 11, DEX_EXEGGCUTE
	db 12, DEX_EKANS
	; nite only
	db 13, DEX_EKANS
	db 14, DEX_EKANS
	db 15, DEX_EKANS
	db 16, DEX_EKANS
	db 16, DEX_EKANS

	map_id HIGHTECH_WEST_ROUTE_OCEAN
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 25, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	; morn/day
	db 15, DEX_TENTACOOL
	db 35, DEX_HANEEI
	db 15, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	; morn/day/nite
	db 35, DEX_TENTACRUEL
	db 35, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	; day/nite
	db 30, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	; nite only
	db 30, DEX_TENTACOOL
	db 35, DEX_TENTACOOL
	db 40, DEX_TENTACOOL
	db 35, DEX_HANEEI
	db 45, DEX_TENTACOOL

	map_id FONT_ROUTE_1
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 25, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	; morn/day
	db 15, DEX_TENTACOOL
	db 35, DEX_HANEEI
	db 15, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	; morn/day/nite
	db 35, DEX_TENTACRUEL
	db 35, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	; day/nite
	db 30, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	; nite only
	db 30, DEX_TENTACOOL
	db 35, DEX_TENTACOOL
	db 40, DEX_TENTACOOL
	db 35, DEX_HANEEI
	db 45, DEX_TENTACOOL

	map_id FONT_ROUTE_2
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 25, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	; morn/day
	db 15, DEX_TENTACOOL
	db 35, DEX_HANEEI
	db 15, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	; morn/day/nite
	db 35, DEX_TENTACRUEL
	db 35, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	; day/nite
	db 30, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	; nite only
	db 30, DEX_TENTACOOL
	db 35, DEX_TENTACOOL
	db 40, DEX_TENTACOOL
	db 35, DEX_HANEEI
	db 45, DEX_TENTACOOL

	map_id FONT_ROUTE_3
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 16, DEX_MACHOP
	db 16, DEX_MACHOP
	db 15, DEX_MACHOP
	; morn/day
	db 14, DEX_MACHOP
	db 17, DEX_SPEAROW
	db 14, DEX_MACHOP
	db 15, DEX_SPEAROW
	; morn/day/nite
	db 16, DEX_SPEAROW
	db 18, DEX_RATTATA
	db 16, DEX_RATTATA
	db 17, DEX_RATTATA
	; day/nite
	db 15, DEX_SPEAROW
	db 16, DEX_DROWZEE
	; nite only
	db 17, DEX_DROWZEE
	db 18, DEX_DROWZEE
	db 19, DEX_DROWZEE
	db 20, DEX_DROWZEE
	db 20, DEX_DROWZEE

	map_id FONT_ROUTE_4
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 17, DEX_SPEAROW
	db 17, DEX_SPEAROW
	db 16, DEX_SPEAROW
	; morn/day
	db 15, DEX_SPEAROW
	db 18, DEX_DODUO
	db 15, DEX_SPEAROW
	db 16, DEX_DODUO
	; morn/day/nite
	db 17, DEX_DONPHAN
	db 19, DEX_SANDSHREW
	db 17, DEX_SANDSHREW
	db 18, DEX_SANDSHREW
	; day/nite
	db 16, DEX_DODUO
	db 17, DEX_DODUO
	; nite only
	db 18, DEX_DODUO
	db 19, DEX_DODUO
	db 20, DEX_DODUO
	db 21, DEX_BULU
	db 21, DEX_BULU

	map_id BIRDON_ROUTE_2
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 21, DEX_SPEAROW
	db 21, DEX_SPEAROW
	db 20, DEX_FEAROW
	; morn/day
	db 19, DEX_FEAROW
	db 22, DEX_FEAROW
	db 19, DEX_SPEAROW
	db 20, DEX_DODUO
	; morn/day/nite
	db 22, DEX_SANDSLASH
	db 21, DEX_DONPHAN
	db 21, DEX_SANDSHREW
	db 23, DEX_SANDSHREW
	; day/nite
	db 20, DEX_DODUO
	db 21, DEX_DODUO
	; nite only
	db 22, DEX_DODUO
	db 23, DEX_DODUO
	db 24, DEX_DODUO
	db 25, DEX_BULU
	db 25, DEX_BULU

	map_id BIRDON_ROUTE_3
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 23, DEX_HANEKO
	db 23, DEX_POPONEKO
	db 22, DEX_HANEKO
	; morn/day
	db 25, DEX_POPONEKO
	db 24, DEX_SANDSHREW
	db 21, DEX_HANEKO
	db 22, DEX_SANDSHREW
	; morn/day/nite
	db 23, DEX_SANDSLASH
	db 25, DEX_VULPIX
	db 23, DEX_VULPIX
	db 21, DEX_MIKON
	; day/nite
	db 22, DEX_HANEKO
	db 23, DEX_HOHO
	; nite only
	db 24, DEX_HOHO
	db 25, DEX_HOHO
	db 26, DEX_HOHO
	db 27, DEX_BULU
	db 27, DEX_BULU

	map_id ROUTE_15
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 24, DEX_HANEKO
	db 24, DEX_POPONEKO
	db 23, DEX_HANEKO
	; morn/day
	db 22, DEX_POPONEKO
	db 25, DEX_POPONEKO
	db 22, DEX_HANEKO
	db 23, DEX_PIDGEY
	; morn/day/nite
	db 24, DEX_PIDGEOTTO
	db 26, DEX_VULPIX
	db 24, DEX_VULPIX
	db 25, DEX_VULPIX
	; day/nite
	db 23, DEX_HANEKO
	db 24, DEX_HOHO
	; nite only
	db 25, DEX_HOHO
	db 26, DEX_DROWZEE
	db 27, DEX_DROWZEE
	db 28, DEX_HYPNO
	db 28, DEX_HYPNO

	map_id SUGAR_ROUTE
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 25, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	; morn/day
	db 15, DEX_TENTACOOL
	db 35, DEX_IKARI
	db 15, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	; morn/day/nite
	db 35, DEX_TENTACRUEL
	db 35, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	; day/nite
	db 30, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	; nite only
	db 30, DEX_TENTACOOL
	db 35, DEX_TENTACOOL
	db 40, DEX_TENTACOOL
	db 35, DEX_IKARI
	db 45, DEX_TENTACOOL

	map_id NEWTYPE_ROUTE
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 28, DEX_HANEKO
	db 28, DEX_POPONEKO
	db 27, DEX_HANEKO
	; morn/day
	db 27, DEX_POPONEKO
	db 30, DEX_POPONEKO
	db 27, DEX_HANEKO
	db 28, DEX_PIDGEY
	; morn/day/nite
	db 29, DEX_PIDGEOTTO
	db 31, DEX_VULPIX
	db 29, DEX_VULPIX
	db 30, DEX_VULPIX
	; day/nite
	db 28, DEX_HANEKO
	db 29, DEX_HOHO
	; nite only
	db 31, DEX_HOHO
	db 32, DEX_DROWZEE
	db 33, DEX_DROWZEE
	db 34, DEX_HYPNO
	db 34, DEX_HYPNO

	map_id ROUTE_18
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 28, DEX_REDIBA
	db 28, DEX_MANKEY
	db 27, DEX_REDIBA
	; morn/day
	db 28, DEX_MANKEY
	db 31, DEX_MANKEY
	db 28, DEX_PIDGEY
	db 29, DEX_MANKEY
	; morn/day/nite
	db 30, DEX_PIDGEOTTO
	db 32, DEX_VULPIX
	db 30, DEX_WOLFMAN
	db 31, DEX_WOLFMAN
	; day/nite
	db 29, DEX_REDIBA
	db 30, DEX_WOLFMAN
	; nite only
	db 33, DEX_WOLFMAN
	db 34, DEX_DROWZEE
	db 35, DEX_WOLFMAN
	db 36, DEX_HYPNO
	db 36, DEX_WOLFMAN

	map_id BLUE_FOREST_ROUTE_1
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 29, DEX_REDIBA
	db 29, DEX_MILTANK
	db 28, DEX_REDIBA
	; morn/day
	db 29, DEX_MILTANK
	db 32, DEX_MANKEY
	db 29, DEX_REDIBA
	db 30, DEX_MANKEY
	; morn/day/nite
	db 31, DEX_PRIMEAPE
	db 33, DEX_POLIWAG
	db 31, DEX_POLIWHIRL
	db 32, DEX_POLIWAG
	; day/nite
	db 30, DEX_REDIBA
	db 31, DEX_WOLFMAN
	; nite only
	db 34, DEX_WOLFMAN
	db 35, DEX_WOLFMAN
	db 36, DEX_WOLFMAN
	db 37, DEX_WOLFMAN
	db 37, DEX_WOLFMAN

	map_id BLUE_FOREST_ROUTE_2
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 32, DEX_MILTANK
	db 32, DEX_MILTANK
	db 31, DEX_MILTANK
	; morn/day
	db 32, DEX_MILTANK
	db 35, DEX_PRIMEAPE
	db 32, DEX_REDIBA
	db 33, DEX_MANKEY
	; morn/day/nite
	db 34, DEX_PRIMEAPE
	db 36, DEX_POLIWAG
	db 34, DEX_POLIWHIRL
	db 35, DEX_POLIWHIRL
	; day/nite
	db 33, DEX_REDIBA
	db 34, DEX_WOLFMAN
	; nite only
	db 37, DEX_WOLFMAN
	db 38, DEX_WOLFMAN
	db 39, DEX_WOLFMAN
	db 40, DEX_WARWOLF
	db 40, DEX_WARWOLF

	map_id STAND_ROUTE
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 29, DEX_CUBONE
	db 29, DEX_MAROWAK
	db 28, DEX_CUBONE
	; morn/day
	db 29, DEX_MAROWAK
	db 32, DEX_RHYHORN
	db 29, DEX_CUBONE
	db 30, DEX_RHYHORN
	; morn/day/nite
	db 31, DEX_RHYHORN
	db 33, DEX_YOROIDORI
	db 31, DEX_YOROIDORI
	db 32, DEX_YOROIDORI
	; day/nite
	db 30, DEX_CUBONE
	db 31, DEX_EKANS
	; nite only
	db 34, DEX_EKANS
	db 35, DEX_ARBOK
	db 36, DEX_ARBOK
	db 37, DEX_EKANS
	db 37, DEX_ARBOK

	map_id KANTO_EAST_ROUTE
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 28, DEX_PICHU
	db 28, DEX_PICHU
	db 27, DEX_PIKACHU
	; morn/day
	db 28, DEX_ODDISH
	db 31, DEX_GLOOM
	db 28, DEX_PIKACHU
	db 29, DEX_ODDISH
	; morn/day/nite
	db 30, DEX_PAINTER
	db 32, DEX_MEOWTH
	db 32, DEX_RATICATE
	db 31, DEX_MEOWTH
	; day/nite
	db 29, DEX_ODDISH
	db 31, DEX_RATICATE
	; nite only
	db 33, DEX_EKANS
	db 34, DEX_ARBOK
	db 35, DEX_ARBOK
	db 36, DEX_EKANS
	db 36, DEX_ARBOK

	map_id ROUTE_SILENT_EAST
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 29, DEX_PICHU
	db 29, DEX_PICHU
	db 28, DEX_PIKACHU
	; morn/day
	db 29, DEX_ODDISH
	db 32, DEX_GLOOM
	db 27, DEX_PIKACHU
	db 28, DEX_ODDISH
	; morn/day/nite
	db 29, DEX_PAINTER
	db 32, DEX_MEOWTH
	db 32, DEX_RATICATE
	db 30, DEX_MEOWTH
	; day/nite
	db 28, DEX_ODDISH
	db 30, DEX_RATICATE
	; nite only
	db 32, DEX_HOHO
	db 33, DEX_EKANS
	db 34, DEX_HOHO
	db 35, DEX_ARBOK
	db 35, DEX_HOHO

	map_id FONT_ROUTE_5
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 25, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	; morn/day
	db 15, DEX_TENTACOOL
	db 35, DEX_HANEEI
	db 15, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	; morn/day/nite
	db 35, DEX_TENTACRUEL
	db 35, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	; day/nite
	db 30, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	; nite only
	db 30, DEX_TENTACOOL
	db 35, DEX_TENTACOOL
	db 40, DEX_TENTACOOL
	db 35, DEX_HANEEI
	db 45, DEX_TENTACOOL

	map_id FONT_ROUTE_6
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 25, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	; morn/day
	db 15, DEX_TENTACOOL
	db 35, DEX_HANEEI
	db 15, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	; morn/day/nite
	db 35, DEX_TENTACRUEL
	db 35, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	; day/nite
	db 30, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	; nite only
	db 30, DEX_TENTACOOL
	db 35, DEX_TENTACOOL
	db 40, DEX_TENTACOOL
	db 35, DEX_HANEEI
	db 45, DEX_TENTACOOL

	map_id BLUE_FOREST_ROUTE_3
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn only
	db 25, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	; morn/day
	db 15, DEX_TENTACOOL
	db 35, DEX_TENTACRUEL
	db 15, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	; morn/day/nite
	db 35, DEX_TENTACRUEL
	db 35, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	; day/nite
	db 30, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	; nite only
	db 30, DEX_TENTACOOL
	db 35, DEX_TENTACOOL
	db 40, DEX_TENTACOOL
	db 35, DEX_TENTACRUEL
	db 45, DEX_TENTACOOL

	map_id SILENT_HILLS
	db 8 percent, 8 percent, 8 percent ; encounter rates: morn/day/nite
	; morn only
	db 7, DEX_REDIBA
	db 7, DEX_REDIBA
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
	db 6, DEX_MARIL
endc
	db 5, DEX_CATERPIE
	; day/nite
	db 8, DEX_REDIBA
	db 4, DEX_METAPOD
	; nite only
	db 6, DEX_RATTATA
if DEF(_GOLD)
	db 6, DEX_CATERPIE
endc
if DEF(_SILVER)
	db 5, DEX_HOHO
endc
	db 6, DEX_REDIBA
	db 5, DEX_METAPOD
	db 5, DEX_PIKACHU

	db -1 ; end
