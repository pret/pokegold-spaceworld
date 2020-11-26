	db DEX_SQUIRTLE ; 007

	db  44,  48,  65,  43,  50,  55
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_WATER ; type
	db 45 ; catch rate
	db 66 ; base exp
	db ITEM_BERRY, ITEM_STEEL_SHELL ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw SquirtlePicFront, SquirtlePicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 11, 12, 13, 14, 17, 18, 19, 20, 28, 31, 32, 33, 34, 40, 44, 50, 53, 54
	; end

