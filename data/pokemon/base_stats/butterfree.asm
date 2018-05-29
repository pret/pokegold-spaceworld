	db DEX_BUTTERFREE ; 012

	db  60,  45,  50,  70,  80,  80
	;   hp  atk  def  spd  sat  sdf

	db TYPE_BUG, TYPE_FLYING ; type
	db 45 ; catch rate
	db 160 ; base exp
	db ITEM_APPLE, ITEM_SILVERPOWDER ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw ButterfreePicFront, dw ButterfreePicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 2, 4, 6, 9, 10, 15, 20, 21, 22, 29, 30, 31, 32, 33, 34, 39, 44, 46, 50
	; end

