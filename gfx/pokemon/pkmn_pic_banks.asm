MonSpriteBankList::
MonSpriteBankListStart::
SECTION "PKMN Sprite Bank List", ROMX[$725C], BANK[$14]

; DEX Entry ROM bank
; i <= entry in list? --> use rom bank
db DEX_RAICHU,     $15
db DEX_DUGTRIO,    $16
db DEX_GOLONE,     $17
db DEX_CRAB,       $18
db DEX_STARMIE,    $19
db DEX_FREEZER,    $1A
db DEX_JARANRA,    $1B
db DEX_KOUNYA,     $1C
db DEX_BOMBSEEKER, $1D
db DEX_NYULA,      $1E
db $FF,            $1F
db $FF,            $20

MonSpriteBankListEnd::