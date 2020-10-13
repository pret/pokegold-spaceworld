	db DEX_MUK ; 089

	db 105, 105,  75,  50,  80,  65
	;   hp  atk  def  spd  sat  sdf

	db TYPE_POISON, TYPE_POISON ; type
	db 75 ; catch rate
	db 157 ; base exp
	db ITEM_APPLE, ITEM_GROSS_GARBAGE ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw MukPicFront, MukPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 15, 20, 21, 24, 25, 31, 32, 34, 36, 38, 44, 47, 50
	; end

