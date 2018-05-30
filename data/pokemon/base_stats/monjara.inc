	db DEX_MONJARA ; 114

	db  65,  55, 115,  60,  55, 100
	;   hp  atk  def  spd  sat  sdf

	db TYPE_GRASS, TYPE_GRASS ; type
	db 45 ; catch rate
	db 166 ; base exp
	db ITEM_BERRY, ITEM_LONG_VINE ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw MonjaraPicFront, MonjaraPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 3, 6, 8, 9, 10, 15, 20, 21, 22, 31, 32, 34, 40, 44, 50, 51
	; end

