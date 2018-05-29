	db DEX_BERORINGA ; 108

	db  90,  55,  75,  30,  60,  90
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_NORMAL ; type
	db 45 ; catch rate
	db 127 ; base exp
	db ITEM_BERRY, ITEM_LONG_TONGUE ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw BeroringaPicFront, dw BeroringaPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 3, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 17, 18, 19, 20, 24, 25, 26, 27, 31, 32, 34, 38, 40, 44, 50, 51, 53, 54
	; end

