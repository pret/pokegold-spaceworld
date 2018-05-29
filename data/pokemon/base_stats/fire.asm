	db DEX_FIRE ; 146

	db  90, 100,  90,  90, 125,  85
	;   hp  atk  def  spd  sat  sdf

	db TYPE_FIRE, TYPE_FLYING ; type
	db 3 ; catch rate
	db 217 ; base exp
	db ITEM_BERRY, ITEM_FIRE_WING ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw FirePicFront, FirePicBack ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 2, 4, 6, 9, 10, 15, 20, 31, 32, 33, 34, 38, 39, 43, 44, 50, 52
	; end

