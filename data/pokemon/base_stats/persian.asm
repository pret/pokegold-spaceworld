	db DEX_PERSIAN ; 053

	db  65,  70,  60, 115,  65,  85
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_NORMAL ; type
	db 90 ; catch rate
	db 148 ; base exp
	db ITEM_APPLE, ITEM_AMULET_COIN ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw PersianPicFront, dw PersianPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 11, 12, 15, 16, 20, 24, 25, 31, 32, 34, 39, 40, 44, 50
	; end

