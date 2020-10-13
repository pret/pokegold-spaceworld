	db DEX_SEEL ; 086

	db  65,  45,  55,  45,  55,  70
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_WATER ; type
	db 190 ; catch rate
	db 100 ; base exp
	db ITEM_BERRY, ITEM_ICE_FANG ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw SeelPicFront, SeelPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 20, 31, 32, 34, 40, 44, 50, 53, 54
	; end

