INCLUDE "constants.asm"

SECTION "VRAM", VRAM

UNION

vChars0::
	ds $80 tiles

vChars1::
	ds $80 tiles

vChars2::
	ds $80 tiles

NEXTU

; Battle/menu
vSprites::
	ds $80 tiles

vFont::
	ds $80 tiles

vFrontPic::
	ds 7 * 7 tiles
vBackPic::
	ds 7 * 7 tiles

NEXTU

vNPCSprites::
	ds $80 tiles

vNPCSprites2::
	ds $80 tiles

vTileset::
	ds $20 tiles
vExteriorTileset::
	ds $40 tiles
vTilesetEnd::

NEXTU

	ds $80 tiles

vTitleLogo::
	ds $80 tiles

;vFrontPic::
	ds 7 * 7 tiles

vTitleLogo2::
	; TODO: what size?

NEXTU

	ds $80 tiles

vPicrossBackground::
	ds $70 tiles

vPicrossPlayArea::
	ds $90 tiles

ENDU


vBGMap0::
	ds BG_MAP_WIDTH * BG_MAP_HEIGHT

vBGMap1::
	ds BG_MAP_WIDTH * BG_MAP_HEIGHT
