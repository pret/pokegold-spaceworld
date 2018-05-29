	db DEX_GARURA ; 115

	db 105,  95,  80,  90,  40,  80
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_NORMAL ; type
	db 45 ; catch rate
	db 175 ; base exp
	db ITEM_BERRY, ITEM_MOMS_LOVE ; items
	db GENDER_FEMALE ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw GaruraPicFront, GaruraPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 17, 18, 19, 20, 24, 25, 26, 27, 31, 32, 34, 38, 40, 44, 48, 50, 53, 54
	; end

