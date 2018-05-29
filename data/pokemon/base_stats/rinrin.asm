	db DEX_RINRIN ; 197

	db  40,  65,  40,  70,  65,  50
	;   hp  atk  def  spd  sat  sdf

	db TYPE_DARK, TYPE_DARK ; type
	db 255 ; catch rate
	db 100 ; base exp
	db ITEM_BERRY, ITEM_AMULET_COIN ; items
	db GENDER_FEMALE ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw RinrinPicFront, RinrinPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 17, 18, 19, 20, 22, 24, 25, 29, 30, 31, 32, 33, 34, 35, 36, 38, 40, 44, 45, 46, 49, 50, 54, 55
	; end

