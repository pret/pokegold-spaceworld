	db DEX_GOLONE ; 075

	db  55,  95, 115,  35,  45,  65
	;   hp  atk  def  spd  sat  sdf

	db TYPE_ROCK, TYPE_GROUND ; type
	db 120 ; catch rate
	db 134 ; base exp
	db ITEM_BERRY, ITEM_HARD_STONE ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw GolonePicFront, dw GolonePicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 1, 6, 8, 9, 10, 17, 18, 19, 20, 26, 27, 28, 31, 32, 34, 35, 36, 38, 44, 47, 48, 50, 54
	; end

