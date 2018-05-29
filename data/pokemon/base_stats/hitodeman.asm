	db DEX_HITODEMAN ; 120

	db  30,  45,  55,  85,  70,  55
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_WATER ; type
	db 225 ; catch rate
	db 106 ; base exp
	db ITEM_BERRY, ITEM_CRIMSON_JEWEL ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw HitodemanPicFront, HitodemanPicBack ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 6, 9, 10, 11, 12, 13, 14, 20, 24, 25, 29, 30, 31, 32, 33, 34, 39, 40, 44, 45, 46, 49, 50, 53, 55
	; end

