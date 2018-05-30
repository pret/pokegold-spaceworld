	db DEX_CRAB ; 098

	db  30, 105,  90,  50,  35,  25
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_WATER ; type
	db 225 ; catch rate
	db 115 ; base exp
	db ITEM_BERRY, ITEM_STEEL_SHELL ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw CrabPicFront, CrabPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 3, 6, 8, 9, 10, 11, 12, 13, 14, 20, 31, 32, 34, 44, 50, 51, 53, 54
	; end

