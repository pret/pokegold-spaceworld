INCLUDE "constants.asm"

SECTION "Sprite Buffers", SRAM

UNION
sScratch:: ds  SCREEN_WIDTH * SCREEN_HEIGHT
NEXTU
sSpriteBuffer0:: ds SPRITEBUFFERSIZE
sSpriteBuffer1:: ds SPRITEBUFFERSIZE
sSpriteBuffer2:: ds SPRITEBUFFERSIZE
ENDU

SECTION "Unknown, bank 0", SRAM

s0_a600:: ds 7 ; TODO: properly label this and figure out exact size

SECTION "Window Stack Top", SRAM
sWindowStackTop:: dw
