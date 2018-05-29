	db DEX_OKORIZARU ; 057

	db  65, 105,  60,  95,  60,  80
	;   hp  atk  def  spd  sat  sdf

	db TYPE_FIGHTING, TYPE_FIGHTING ; type
	db 75 ; catch rate
	db 149 ; base exp
	db ITEM_LOTTO_TICKET, ITEM_POWER_BRACER ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw OkorizaruPicFront, dw OkorizaruPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 15, 16, 17, 18, 19, 20, 24, 25, 28, 31, 32, 34, 35, 39, 40, 44, 48, 50, 54
	; end

