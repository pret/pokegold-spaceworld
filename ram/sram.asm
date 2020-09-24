INCLUDE "constants.asm"

SECTION "Sprite Buffers", SRAM

sSpriteBuffer0:: ds SPRITEBUFFERSIZE
sSpriteBuffer1:: ds SPRITEBUFFERSIZE
sSpriteBuffer2:: ds SPRITEBUFFERSIZE

SECTION "Unknown, bank 0", SRAM

s0_a600:: ds 7 ; TODO: properly label this and figure out exact size

SECTION "Window Stack Top", SRAM
sWindowStackTop:: dw
