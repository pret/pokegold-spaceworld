	db DEX_PORYGON ; 137

	db  65,  60,  70,  40,  90,  75
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_NORMAL ; type
	db 45 ; catch rate
	db 130 ; base exp
	db ITEM_BERRY, ITEM_UP_GRADE ; items
	db GENDER_UNKNOWN ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw PorygonPicFront, PorygonPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 9, 10, 14, 15, 20, 24, 25, 29, 30, 31, 32, 33, 34, 39, 40, 44, 45, 46, 49, 50, 55
	; end

