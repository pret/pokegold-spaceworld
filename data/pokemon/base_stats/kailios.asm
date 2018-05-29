	db DEX_KAILIOS ; 127

	db  65, 125, 100,  85,  55,  75
	;   hp  atk  def  spd  sat  sdf

	db TYPE_BUG, TYPE_BUG ; type
	db 45 ; catch rate
	db 200 ; base exp
	db ITEM_BERRY, ITEM_TWIN_HORNS ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw KailiosPicFront, dw KailiosPicBack ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 3, 6, 8, 9, 10, 15, 17, 19, 20, 31, 32, 34, 44, 50, 51, 54
	; end

