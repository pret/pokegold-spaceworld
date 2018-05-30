	db DEX_PARAS ; 046

	db  35,  70,  55,  25,  45,  55
	;   hp  atk  def  spd  sat  sdf

	db TYPE_BUG, TYPE_GRASS ; type
	db 190 ; catch rate
	db 70 ; base exp
	db ITEM_BERRY, ITEM_CORDYCEPS ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw ParasPicFront, ParasPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 3, 6, 8, 9, 10, 20, 21, 22, 28, 31, 32, 33, 34, 40, 44, 50, 51
	; end

