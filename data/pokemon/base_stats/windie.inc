	db DEX_ARCANINE ; 059

	db  90, 110,  80,  95,  80, 100
	;   hp  atk  def  spd  sat  sdf

	db TYPE_FIRE, TYPE_FIRE ; type
	db 75 ; catch rate
	db 213 ; base exp
	db ITEM_APPLE, ITEM_TALISMAN_TAG ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw ArcaninePicFront, ArcaninePicBack ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 15, 20, 23, 28, 30, 31, 32, 33, 34, 38, 39, 40, 44, 50
	; end

