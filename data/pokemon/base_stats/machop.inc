	db DEX_MACHOP ; 066

	db  70,  80,  50,  35,  35,  40
	;   hp  atk  def  spd  sat  sdf

	db TYPE_FIGHTING, TYPE_FIGHTING ; type
	db 180 ; catch rate
	db 88 ; base exp
	db ITEM_BERRY, ITEM_COUNTER_CUFF ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw MachopPicFront, MachopPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 17, 18, 19, 20, 26, 27, 28, 31, 32, 34, 35, 38, 40, 44, 48, 50, 54
	; end

