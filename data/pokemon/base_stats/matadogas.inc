	db DEX_WEEZING ; 110

	db  65,  90, 120,  60,  85,  55
	;   hp  atk  def  spd  sat  sdf

	db TYPE_POISON, TYPE_POISON ; type
	db 60 ; catch rate
	db 173 ; base exp
	db ITEM_APPLE, ITEM_GROSS_GARBAGE ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw WeezingPicFront, WeezingPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 15, 20, 24, 25, 31, 32, 34, 36, 38, 44, 47, 50
	; end

