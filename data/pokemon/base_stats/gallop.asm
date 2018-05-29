	db DEX_GALLOP ; 078

	db  65, 100,  70, 105,  80,  75
	;   hp  atk  def  spd  sat  sdf

	db TYPE_FIRE, TYPE_FIRE ; type
	db 60 ; catch rate
	db 192 ; base exp
	db ITEM_APPLE, ITEM_FIRE_MANE ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw GallopPicFront, dw GallopPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 7, 8, 9, 10, 15, 20, 31, 32, 33, 34, 38, 39, 40, 44, 50
	; end

