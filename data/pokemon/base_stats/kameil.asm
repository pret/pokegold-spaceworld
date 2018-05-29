	db DEX_KAMEIL ; 008

	db  59,  63,  80,  58,  65,  75
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_WATER ; type
	db 45 ; catch rate
	db 143 ; base exp
	db ITEM_BERRY, ITEM_STEEL_SHELL ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw KameilPicFront, dw KameilPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 11, 12, 13, 14, 17, 18, 19, 20, 28, 31, 32, 33, 34, 40, 44, 50, 53, 54
	; end

