	db DEX_MAGMAR ; 126

	db  65,  95,  57,  93,  85,  70
	;   hp  atk  def  spd  sat  sdf

	db TYPE_FIRE, TYPE_FIRE ; type
	db 45 ; catch rate
	db 167 ; base exp
	db ITEM_BERRY, ITEM_FIRE_CLAW ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw MagmarPicFront, MagmarPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 15, 17, 18, 19, 20, 29, 30, 31, 32, 34, 35, 38, 40, 44, 46, 50, 54
	; end

