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

SECTION "CB56", WRAM0[$CB5B]
wcb5b:: ds 1
wNameCategory:: ds 1

SECTION "Request2bpp", WRAM0[$CB62]

wRequested2bpp:: db
wRequested2bppSource:: dw
wRequested2bppDest:: dw


SECTION "CC38", WRAM0[$CC33] ; Please merge when more is disassembled

wVBlankOccurred: db

    ds 4

wcc38:: ; cc38 ; TODO: wceeb in pokegold, what is this?
    db

wDebugWarpSelection:: ; cc39
    db

    ds 6

wSGB:: ; cc40
    db

SECTION "CCB5", WRAM0[$CCB5]

wSpriteFlipped:: ; ccb5
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

SECTION "CE3C", WRAM0[$CE3C]

wBuffer:: ; ce3c
    db


SECTION "CE5F", WRAM0[$CE5F]

wce5f:: ; ce5f ; TODO
    db


SECTION "Stack bottom", WRAM0[$DFFF]

; Where SP is set at game init
wStackBottom:: ; dfff
; Due to the way the stack works (`push` first decrements, then writes), the byte at $DFFF is actually wasted
