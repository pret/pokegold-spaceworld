	db DEX_DOKUKURAGE ; 073

	db  80,  70,  65, 100,  80, 120
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_POISON ; type
	db 60 ; catch rate
	db 205 ; base exp
	db ITEM_APPLE, ITEM_TOXIC_NEEDLE ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw $74ae, $761c ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 3, 6, 9, 10, 11, 12, 13, 14, 15, 20, 21, 31, 32, 33, 34, 40, 44, 50, 51, 53
	; end
