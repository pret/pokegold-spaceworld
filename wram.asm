INCLUDE "constants.asm"


SECTION "Music engine RAM", WRAM0[$C000]

wMusic:: ; c000

wChannels::
wChannel1:: channel_struct wChannel1 ; c000
wChannel2:: channel_struct wChannel2 ; c032
wChannel3:: channel_struct wChannel3 ; c064
wChannel4:: channel_struct wChannel4 ; c096

wSFXChannels::
wChannel5:: channel_struct wChannel5 ; c0c8
wChannel6:: channel_struct wChannel6 ; c0fa
wChannel7:: channel_struct wChannel7 ; c12c
wChannel8:: channel_struct wChannel8 ; c15e

    ds 8 ; TODO

wCurChannel:: ; c198
    db

wVolume:: ; c199
    db

    ds 2 ; TODO

wMusicID:: ; c19c
    dw

wMusicBank:: ; c19e
    db

    ds 14 ; TODO

wMapMusic:: ; c1ad
    db

wCryPitch:: ; c1ae
    dw

wCryLength:: ; c1b0
    dw

    ds 10 ; TODO


; either wChannelsEnd or wMusicEnd, unsure
wMusicInitEnd:: ; c1bc


SECTION "OAM buffer", WRAM0[$C200]

wVirtualOAM:: ; c200
    ds SPRITEOAMSTRUCT_LENGTH * NUM_SPRITE_OAM_STRUCTS
wVirtualOAMEnd::

wTileMap:: ; c2a0
    ds SCREEN_HEIGHT * SCREEN_WIDTH

UNION

wTileMapBackup:: ; c408
    ds SCREEN_HEIGHT * SCREEN_WIDTH

NEXTU

    ds 3

; Monster or Trainer test?
wWhichPicTest:: ; c40b
    db

ENDU


SECTION "LY overrides buffer", WRAM0[$C600]

wLYOverrides:: ; c600
    ds SCREEN_HEIGHT_PX

SECTION "CB14", WRAM0[$CB14]

UNION
wRedrawRowOrColumnSrcTiles:: ; cb14
; the tiles of the row or column to be redrawn by RedrawRowOrColumn
    ds SCREEN_WIDTH * 2
NEXTU
wRedrawFlashlightDst0:: dw ; cb14
wRedrawFlashlightSrc0:: dw ; cb16
wRedrawFlashlightBlackDst0:: dw ; cb18
wRedrawFlashlightDst1:: dw ; cb1a
wRedrawFlashlightSrc1:: dw ; cb1c
wRedrawFlashlightBlackDst1:: dw ; cb1e
wRedrawFlashlightWidthHeight:: db ; cb20
; width or height of flashlight redraw region
; in units of two tiles (people event meta tile)
ENDU

SECTION "CB56", WRAM0[$CB5B]
wcb5b:: ds 1         ; multipurpose, also wName, wMonDexIndex2
wNameCategory:: ds 1

SECTION "CB62", WRAM0[$CB62]

wVBCopySize:: ds 1 ; cb62
wVBCopySrc:: ds 2 ; cb63
wVBCopyDst:: ds 2 ; cb65
wVBCopyDoubleSize:: ds 1 ; cb67
wVBCopyDoubleSrc:: ds 2 ; cb68
wVBCopyDoubleDst:: ds 2 ; cb6a

SECTION "CB71", WRAM0[$CB71]

wVBCopyFarSize:: ds 1 ; cb71
wVBCopyFarSrc:: ds 2 ; cb72
wVBCopyFarDst:: ds 2 ; cb74
wVBCopyFarSrcBank:: ds 1 ; cb76

SECTION "CC32", WRAM0[$CC32] ; Please merge when more is disassembled

wVBlankCounter: db ; cc32

wVBlankOccurred: db ; cc33

    ds 4

wcc38:: ; cc38 ; TODO: wceeb in pokegold, what is this?
    db

wDebugWarpSelection:: ; cc39
    db

    ds 6

wSGB:: ; cc40
    db

SECTION "CCAC", WRAM0[$CCAC]

wSpriteCurPosX          : ds 1 ; ccac
wSpriteCurPosY          : ds 1 ; ccad
wSpriteWidth            : ds 1 ; ccae
wSpriteHeight           : ds 1 ; ccaf
wSpriteInputCurByte     : ds 1 ; ccb0
wSpriteInputBitCounter  : ds 1 ; ccb1
wSpriteOutputBitOffset  : ds 1 ; ccb2
wSpriteLoadFlags        : ds 1 ; ccb3
wSpriteUnpackMode       : ds 1 ; ccb4
wSpriteFlipped          : ds 1 ; ccb5
wSpriteInputPtr         : ds 2 ; ccb6
wSpriteOutputPtr        : ds 2 ; ccb8
wSpriteOutputPtrCached  : ds 2 ; ccba
wSpriteDecodeTable0Ptr  : ds 2 ; ccbc
wSpriteDecodeTable1Ptr  : ds 2 ; ccbe

SECTION "CCC7", WRAM0[$CCC7]

wDisableVBlankOAMUpdate:: db ; ccc7

SECTION "CCCA", WRAM0[$CCCA]

wBGP:: db ; ccca
wOBP0:: db ; cccb
wOBP1:: db ; cccc

SECTION "CCCE", WRAM0[$CCCE]

wDisableVBlankWYUpdate:: db ; ccce

SECTION "CD26", WRAM0[$CD26]

wcd26:: ; cd26
    db

SECTION "CD31", WRAM0[$CD31]

wcd31:: ; cd31
    db

SECTION "CD4F", WRAM0[$CD4F]

wPredefID:: ; cd4f
    db

wPredefHL:: ; cd50
    dw
wPredefDE:: ; cd52
    dw
wPredefBC:: ; cd54

wFarCallBCBuffer:: ; cd54
    dw

SECTION "CD76", WRAM0[$CD76]

wcd76:: ; cd76
    db

wcd77:: ;cd77
    db

wMonDexIndex: ds 1 ; cd78

SECTION "CD7D", WRAM0[$CD7D]

wItemQuantity:: ; cd7d
    db

SECTION "CE00", WRAM0[$CE00]

wBattleMode:: ; ce00
    db

SECTION "CE07", WRAM0[$CE07]

wMonHeader::

wMonHIndex:: ; ce07
; In the ROM base stats data structure, this is the dex number, but it is
; overwritten with the dex number after the header is copied to WRAM.
    ds 1

wMonHBaseStats:: ; ce08
wMonHBaseHP:: ; ce08
    ds 1
wMonHBaseAttack:: ; ce09
    ds 1
wMonHBaseDefense:: ; ce0a
    ds 1
wMonHBaseSpeed:: ; ce0b
    ds 1
wMonHBaseSpecialAtt:: ; ce0c
    ds 1
wMonHBaseSpecialDef:: ; ce0d
    ds 1

wMonHTypes:: ; ce0e
wMonHType1:: ; ce0e
    ds 1
wMonHType2:: ; ce0f
    ds 1

wMonHCatchRate:: ; ce10
    ds 1
wMonHBaseEXP:: ; ce11
    ds 1

wMonHItems:: ; ce12
wMonHItem1:: ; ce12
    ds 1
wMonHItem2:: ; ce13
    ds 1

wMonHGenderRatio:: ; ce14
    ds 1

wMonHUnk0:: ; ce15
    ds 1
wMonHUnk1:: ; ce16
    ds 1
wMonHUnk2:: ; ce17
    ds 1

wMonHSpriteDim:: ; ce18
    ds 1
wMonHFrontSprite:: ; ce19
    ds 2
wMonHBackSprite:: ; ce1b
    ds 2

wMonHGrowthRate:: ; ce1d
    ds 1

wMonHLearnset:: ; ce1e
; bit field
    flag_array 50 + 5
    ds 1

SECTION "CE37", WRAM0[$CE37]

wce37:: ; ce37
    db

SECTION "CE3B", WRAM0[$CE3B]

wVBlankSavedROMBank:: ; ce3b
    db

wBuffer:: ; ce3c
    db

wTimeOfDay:: db ; ce3d
; based on RTC
; Time of Day   Regular    Debug
; 00 - Day      09--15h    00--30s
; 01 - Night    15--06h    30--35s
; 02 - Cave                35--50s
; 03 - Morning  06--09h    50--59s

SECTION "CE5F", WRAM0[$CE5F]

wce5f:: ; ce5f ; TODO
    db

SECTION "CE63", WRAM0[$CE63]

wce63:: db ; ce63
; 76543210
;       \-- global debug enable

SECTION "D152", WRAM0[$D152]

wMapTimeOfDayPalette:: db ; d152
; Applied according to wMapTimeOfDay from wMapTimeOfDayPaletteMap

wd153:: db ; d153
; 76543210
; \-------- switch overworld palettes according to seconds not hours

    ds 3 ; TODO
wd157:: db ; d157
; 76543210
; \-------- disable overworld palette switch

wMapTimeOfDayPaletteMap:: db ; d158
; 76543210
; \/\/\/\/
;  | | | \- Map Palette for TimeOfDay 0x00
;  | | \--- Map Palette for TimeOfDay 0x01
;  | \----- Map Palette for TimeOfDay 0x02
;  \------- Map Palette for TimeOfDay 0x03

wMapTimeOfDay:: db ; d159

SECTION "D19E", WRAM0[$D19E]

wNumBagItems:: ; d19e
    db

SECTION "D4AB", WRAM0[$D4AB]

wJoypadFlags:: db ; d4ab
; 76543210
; ||||\__/
; ||||  \-- unkn
; |||\----- unkn
; ||\------ don't wait for keypress to close text box
; |\------- joypad sync mtx
; \-------- joypad disabled

SECTION "PokeDexFlags", WRAM0[$D81A]

wPokedexOwned::    ; d81a
    flag_array NUM_POKEMON
wPokedexOwnedEnd:: ; d839

wPokedexSeen::     ; d83a
    flag_array NUM_POKEMON
wPokedexSeenEnd::  ; d859

wAnnonDex:: ds 26  ; d85a

wAnnonID:: ds 1    ; d874

SECTION "Stack bottom", WRAM0[$DFFF]

; Where SP is set at game init
wStackBottom:: ; dfff
; Due to the way the stack works (`push` first decrements, then writes), the byte at $DFFF is actually wasted
