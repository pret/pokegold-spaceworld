	db DEX_DUGTRIO ; 051

	db  35,  80,  50, 120,  60,  70
	;   hp  atk  def  spd  sat  sdf

	db TYPE_GROUND, TYPE_GROUND ; type
	db 50 ; catch rate
	db 153 ; base exp
	db ITEM_APPLE, ITEM_DIGGING_CLAW ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw DugtrioPicFront, DugtrioPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 15, 20, 26, 27, 28, 31, 32, 34, 44, 48, 50
	; end

