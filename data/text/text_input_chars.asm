INCLUDE "constants.asm"

SECTION "data/text/text_input_chars.asm", ROMX

TextEntryChars:
	db "あいうえお　かきくけこ　さしすせそ"
	db "たちつてと　なにぬねの　はひふへほ"
	db "まみむめも　やゆよわん　らりるれろ"
	db "アイウエオ　カキクケコ　サシスセソ"
	db "タチツテト　ナニヌネノ　ハヒフヘホ"
	db "マミムメモ　ヤユヨワン　ラリルレロ"
	db "ゃゅょっを　ャュョッヲ　ﾞﾟ　ー。"
	db "１２３４５　６７８９０　？！×．円"

TextEntryHiragana:
	db "あいうえお　かきくけこ　さしすせそ"
	db "たちつてと　なにぬねの　はひふへほ"
	db "まみむめも　やゆよわん　らりるれろ"
	db "ゃゅょっを　１２３４５　６７８９０"
	db "　ﾞﾟ　ー？！円"

TextEntryKatakana:
	db "アイウエオ　カキクケコ　サシスセソ"
	db "タチツテト　ナニヌネノ　ハヒフヘホ"
	db "マミムメモ　ヤユヨワン　ラリルレロ"
	db "ャュョッヲ　１２３４５　６７８９０"
	db "　ﾞﾟ　ー？！円"
