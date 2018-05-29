	db DEX_PIGEOT ; 018

	db  83,  80,  75,  91,  70,  70
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_FLYING ; type
	db 45 ; catch rate
	db 172 ; base exp
	db ITEM_APPLE, ITEM_WHITE_FEATHER ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw PigeotPicFront, dw PigeotPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 2, 4, 6, 9, 10, 15, 20, 31, 32, 33, 34, 39, 43, 44, 50, 52
	; end

