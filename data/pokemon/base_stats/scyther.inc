	db DEX_SCYTHER ; 123

	db  70, 110,  80, 105,  55,  85
	;   hp  atk  def  spd  sat  sdf

	db TYPE_BUG, TYPE_FLYING ; type
	db 45 ; catch rate
	db 187 ; base exp
	db ITEM_BERRY, ITEM_SHARP_SCYTHE ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw ScytherPicFront, ScytherPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 3, 6, 9, 10, 15, 20, 31, 32, 34, 39, 40, 44, 50, 51
	; end

