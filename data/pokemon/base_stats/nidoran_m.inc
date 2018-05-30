	db DEX_NIDORAN_M ; 032

	db  46,  57,  40,  50,  40,  40
	;   hp  atk  def  spd  sat  sdf

	db TYPE_POISON, TYPE_POISON ; type
	db 235 ; catch rate
	db 60 ; base exp
	db ITEM_BERRY, ITEM_TOXIC_NEEDLE ; items
	db GENDER_MALE ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw Nidoran_MPicFront, Nidoran_MPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 6, 7, 8, 9, 10, 14, 20, 24, 25, 31, 32, 33, 34, 40, 44, 50
	; end

