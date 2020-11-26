	db DEX_SANDSHREW ; 027

	db  50,  75,  85,  40,  30,  40
	;   hp  atk  def  spd  sat  sdf

	db TYPE_GROUND, TYPE_GROUND ; type
	db 255 ; catch rate
	db 93 ; base exp
	db ITEM_BERRY, ITEM_CONFUSE_CLAW ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw SandshrewPicFront, SandshrewPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 3, 6, 8, 9, 10, 17, 19, 20, 26, 27, 28, 31, 32, 34, 39, 40, 44, 48, 50, 51, 54
	; end

