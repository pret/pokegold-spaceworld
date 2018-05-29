	db DEX_NASSY ; 103

	db  95,  95,  85,  55, 125,  75
	;   hp  atk  def  spd  sat  sdf

	db TYPE_GRASS, TYPE_PSYCHIC ; type
	db 45 ; catch rate
	db 212 ; base exp
	db ITEM_APPLE, ITEM_CALM_BERRY ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw NassyPicFront, NassyPicBack ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 6, 9, 10, 15, 20, 21, 22, 29, 30, 31, 32, 33, 34, 36, 37, 44, 46, 47, 50, 54
	; end

