	db DEX_KYUKON ; 038

	db  73,  76,  75, 100, 100,  80
	;   hp  atk  def  spd  sat  sdf

	db TYPE_FIRE, TYPE_FIRE ; type
	db 75 ; catch rate
	db 178 ; base exp
	db ITEM_APPLE, ITEM_LIFE_TAG ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw KyukonPicFront, KyukonPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 15, 20, 28, 31, 32, 33, 34, 38, 39, 40, 44, 50
	; end

