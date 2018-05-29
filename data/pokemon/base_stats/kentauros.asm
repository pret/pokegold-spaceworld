	db DEX_KENTAUROS ; 128

	db  75, 100,  95, 110,  55,  70
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_NORMAL ; type
	db 45 ; catch rate
	db 211 ; base exp
	db ITEM_BERRY, ITEM_TWIN_HORNS ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw KentaurosPicFront, KentaurosPicBack ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 6, 7, 8, 9, 10, 13, 14, 15, 20, 24, 25, 26, 27, 31, 32, 34, 38, 40, 44, 50, 54
	; end

