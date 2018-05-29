	db DEX_HITOKAGE ; 004

	db  39,  52,  43,  65,  55,  50
	;   hp  atk  def  spd  sat  sdf

	db TYPE_FIRE, TYPE_FIRE ; type
	db 45 ; catch rate
	db 65 ; base exp
	db ITEM_BERRY, ITEM_CONFUSE_CLAW ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw HitokagePicFront, dw HitokagePicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 1, 3, 5, 6, 8, 9, 10, 17, 18, 19, 20, 23, 28, 31, 32, 33, 34, 38, 39, 40, 44, 50, 51, 54
	; end

