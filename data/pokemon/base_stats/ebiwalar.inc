	db DEX_HITMONCHAN ; 107

	db  50, 105,  79,  76,  35,  85
	;   hp  atk  def  spd  sat  sdf

	db TYPE_FIGHTING, TYPE_FIGHTING ; type
	db 45 ; catch rate
	db 140 ; base exp
	db ITEM_APPLE, ITEM_DETECT_ORB ; items
	db GENDER_MALE ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw HitmonchanPicFront, HitmonchanPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 17, 18, 19, 20, 31, 32, 34, 35, 39, 40, 44, 50, 54
	; end

