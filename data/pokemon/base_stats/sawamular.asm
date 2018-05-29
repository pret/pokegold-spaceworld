	db DEX_SAWAMULAR ; 106

	db  50, 120,  53,  87,  35,  85
	;   hp  atk  def  spd  sat  sdf

	db TYPE_FIGHTING, TYPE_FIGHTING ; type
	db 45 ; catch rate
	db 139 ; base exp
	db ITEM_APPLE, ITEM_FOCUS_ORB ; items
	db GENDER_MALE ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw SawamularPicFront, dw SawamularPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 17, 18, 19, 20, 31, 32, 34, 35, 39, 40, 44, 50, 54
	; end

