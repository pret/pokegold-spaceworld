INCLUDE "constants.asm"

SECTION "PlaceWaitingText", ROMX[$4000],BANK[$01]
INCLUDE "engine/link/place_waiting_text.asm"

SECTION "Title screen", ROMX[$5D8C],BANK[$01]
INCLUDE "engine/title.asm"

SECTION "Predef pointers", ROMX[$62B0],BANK[$01]
INCLUDE "engine/predef.asm"

SECTION "Main Menu Definition", ROMX[$5418], BANK[$01]
MainMenuHeader:
	db $40
	db 0, 0, 7, 13
	dw .data
	db 1 ; default option

.data
	db $80
	db 0 ; number of options

	dw $5461
	db $8a, $1f
	dw MainMenuStrings

MainMenuStrings: ; 01:5428
    db "つづきから　はじめる@"
    db "さいしょから　はじめる@"
    db "せっていを　かえる@"
    db "#を　あそぶ@"
    db "じかんセット@"
; 01:5457

SECTION "Nest Icon", ROMX[$4A0F], BANK[$02]
	INCBIN "gfx/mon_nest_icon.1bpp"

SECTION "TM/HM Moves", ROMX[$52D1],BANK[$04]
INCLUDE "data/moves/tmhm_moves.asm"

SECTION "Type Matchups", ROMX[$506D],BANK[$0D]
INCLUDE "data/types/type_matchups.asm"

INCLUDE "data/trainers/parties.asm"

SECTION "Alphabetical Pokedex Order", ROMX[$4943],BANK[$10]
INCLUDE "data/pokemon/dex_order_alpha.asm"

SECTION "Evolutions and Attacks", ROMX[$6493],BANK[$10]
INCLUDE "data/pokemon/evos_attacks.asm"

SECTION "Base Data", ROMX[$4F10],BANK[$14]
INCLUDE "data/pokemon/base_stats.asm"

SECTION "PKMN Sprite Bank List", ROMX[$725C], BANK[$14]
INCLUDE "gfx/pokemon/pkmn_pic_banks.asm"

INCLUDE "gfx/pokemon/pkmn_pics.asm"

SECTION "Annon Pic Ptrs and Pics", ROMX[$4d6a], BANK[$1f]
INCLUDE "gfx/pokemon/annon_pic_ptrs.asm"
INCLUDE "gfx/pokemon/annon_pics.asm"

SECTION "Misc GFX", ROMX[$4162], BANK[$3E]
FontExtraGfx::
	INCBIN "gfx/font_extra.2bpp"
	INCBIN "gfx/font.1bpp"
FontBattleExtraGfx::
	INCBIN "gfx/battle_hud_1.2bpp"
BorderGfx::
	INCBIN "gfx/text_box_borders.1bpp"
	INCBIN "gfx/status_screen_separator.2bpp"
	INCBIN "gfx/status_screen.2bpp"
	INCBIN "gfx/battle_hud_2.1bpp"
	INCBIN "gfx/exp_bar.2bpp"
	INCBIN "gfx/m_kg.2bpp"
	INCBIN "gfx/pokedex.2bpp"
	INCBIN "gfx/town_map.2bpp"
	INCBIN "gfx/gfx_f8fc2.2bpp"
BoldFontGfx::
	INCBIN "gfx/alphabet.1bpp"
	INCBIN "gfx/annon_alphabet.1bpp"
	INCBIN "gfx/gfx_f9322.1bpp"
PackIconGfx::
	INCBIN "gfx/pack_icons.2bpp"

SECTION "Town Map Cursor", ROMX[$506F], BANK[$3F]
	INCBIN "gfx/town_map_cursor.2bpp"
