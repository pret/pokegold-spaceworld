	db DEX_DIGDA ; 050

	db  10,  55,  25,  95,  50,  45
	;   hp  atk  def  spd  sat  sdf

	db TYPE_GROUND, TYPE_GROUND ; type
	db 255 ; catch rate
	db 81 ; base exp
	db ITEM_BERRY, ITEM_DIGGING_CLAW ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw $77f7, $78e1 ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 20, 26, 27, 28, 31, 32, 34, 44, 48, 50
	; end
