	db DEX_LIZARDON ; 006

	db  78,  84,  78, 100, 100,  85
	;   hp  atk  def  spd  sat  sdf

	db TYPE_FIRE, TYPE_FLYING ; type
	db 45 ; catch rate
	db 209 ; base exp
	db ITEM_APPLE, ITEM_CONFUSE_CLAW ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw LizardonPicFront, LizardonPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 1, 3, 5, 6, 8, 9, 10, 15, 17, 18, 19, 20, 23, 26, 27, 28, 31, 32, 33, 34, 38, 39, 40, 44, 50, 51, 54
	; end

