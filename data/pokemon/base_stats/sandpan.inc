	db DEX_SANDPAN ; 028

	db  75, 100, 110,  65,  55,  75
	;   hp  atk  def  spd  sat  sdf

	db TYPE_GROUND, TYPE_GROUND ; type
	db 90 ; catch rate
	db 163 ; base exp
	db ITEM_APPLE, ITEM_CONFUSE_CLAW ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw SandpanPicFront, SandpanPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 3, 6, 8, 9, 10, 15, 17, 19, 20, 26, 27, 28, 31, 32, 34, 39, 40, 44, 48, 50, 51, 54
	; end

