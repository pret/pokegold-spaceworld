	db DEX_KAIRIKY ; 068

	db  90, 130,  80,  55,  65,  80
	;   hp  atk  def  spd  sat  sdf

	db TYPE_FIGHTING, TYPE_FIGHTING ; type
	db 45 ; catch rate
	db 193 ; base exp
	db ITEM_APPLE, ITEM_COUNTER_CUFF ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw KairikyPicFront, dw KairikyPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 15, 17, 18, 19, 20, 26, 27, 28, 31, 32, 34, 35, 38, 40, 44, 48, 50, 54
	; end

