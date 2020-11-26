	db DEX_POLIWRATH ; 062

	db  90,  85,  95,  70,  70,  95
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_FIGHTING ; type
	db 45 ; catch rate
	db 185 ; base exp
	db ITEM_APPLE, ITEM_STRANGE_WATER ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw PoliwrathPicFront, PoliwrathPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 17, 18, 19, 20, 26, 27, 29, 31, 32, 34, 35, 40, 44, 46, 50, 53, 54
	; end

