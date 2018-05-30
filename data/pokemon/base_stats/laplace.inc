	db DEX_LAPLACE ; 131

	db 130,  85,  80,  60,  95, 105
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_ICE ; type
	db 45 ; catch rate
	db 219 ; base exp
	db ITEM_BERRY, ITEM_WISDOM_ORB ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw LaplacePicFront, LaplacePicBack ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 20, 22, 23, 24, 25, 29, 31, 32, 33, 34, 40, 44, 46, 50, 53, 54
	; end

