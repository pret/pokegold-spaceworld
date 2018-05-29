	db DEX_KAMONEGI ; 083

	db  52,  65,  55,  60,  58,  58
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_FLYING ; type
	db 45 ; catch rate
	db 94 ; base exp
	db ITEM_BERRY, ITEM_STICK ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw KamonegiPicFront, dw KamonegiPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 2, 3, 4, 6, 8, 9, 10, 20, 31, 32, 33, 34, 39, 40, 44, 50, 51, 52
	; end

