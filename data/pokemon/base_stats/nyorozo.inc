	db DEX_POLIWHIRL ; 061

	db  65,  65,  65,  90,  50,  65
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_WATER ; type
	db 120 ; catch rate
	db 131 ; base exp
	db ITEM_BERRY, ITEM_STRANGE_WATER ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw PoliwhirlPicFront, PoliwhirlPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 11, 12, 13, 14, 17, 18, 19, 20, 26, 27, 29, 31, 32, 34, 35, 40, 44, 46, 50, 53, 54
	; end

