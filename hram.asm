SECTION "HRAM", HRAM[$FF80]

hOAMDMA:: ; ff80
    ds 13

hRTCHours:: db ; ff8d
hRTCMinutes:: db ; ff8e
hRTCSeconds:: db ; ff8f
hRTCDays:: db ; ff90
    ds 6 ; TODO

hVBlankCounter:: ; ff97
    db

hROMBank:: ; ff98
    db


hVBlank:: ; ff99
    db

    ds 3 ; TODO

hJoypadUp:: db ; ff9d
; Raw Joypad Up Event
; A pressed key was released
hJoypadDown:: db ; ff9e
; Raw Joypad Down Event
; An unpressed key was pressed
hJoypadState:: db ; ff9f
; Raw Joypad State
; State of all keys during current frame
hJoypadSum:: db ; ffa0
; Raw Joypad State Sum
; Sum of all keys that were pressed
; since hJoypadSum was last cleared

    ds 1; TODO
hJoyDown:: db ; ffa2
hJoyState:: db ; ffa3
hJoySum:: db ; ffa4

hJoyDebounceSrc:: db ; ffa5
; hJoySum will be updated from
; 00 - hJoyDown
; <> - hJoyState
; See GetJoypadDebounced

hJoypadState2:: db ; ffa6

    ds 8 ; TODO

UNION

hTextBoxCursorBlinkInterval:: ds 2 ; ffaf

NEXTU
hSpriteWidth:: ; ffaf
hSpriteInterlaceCounter:: ; ffaf
    db 
hSpriteHeight:: ; ffb0
    db
ENDU

hSpriteOffset:: ; ffb1
    db

    db ; TODO

hPrintNumLeadingDigit:: db ; ffb3 digit one place-value up
hPrintNumDividend:: ds 3 ; ffb4 big-endian
hPrintNumDivisor:: ds 3 ; ffb7 big-endian
hPrintNumTemp:: ds 3 ; ffba big-endian

    ds 19 ; TODO


hLCDCPointer:: ; ffd0
    db


    ds 3 ; TODO


hSerialReceived:: ; ffd4
    db

hLinkPlayerNumber:: ; ffd5
    db


    db ; TODO


hSerialSend:: ; ffd7
    db
hSerialReceive:: ; ffd8
    db


hSCX:: db ; ffd9
hSCY:: db ; ffda
hWX:: db ; ffdb
hWY:: db ; ffdc

hOverworldFlashlightEffect:: db ; ffdd
; Influences draw distance of map around HIRO
; Meant to go from 0x00--> to desired distance
; or else graphical errors will occur.
; 0x00 - regular distance
; 0x01 - 14x14 tile block
; 0x02 - 10x10 tile block
; 0x03 -  6x 6 tile block
; 0x04 -  2x 2 tile block

hBGMapMode:: ; ffde
    db

hBGMapTransferPosition:: ; ffdf
    db

hBGMapAddress:: ; ffe0
    dw
    db ; TODO
    
hSPTemp:: ; ffe3
    dw
    
hRedrawRowOrColumnMode:: db ; ffe5
; Used for redrawing BG in small updates
; instead of once completely for faster
; scrolling on overworld etc.
; Valid values:
; 0x00 - no redraw
; 0x01 - column redraw (move horizontally)
; 0x02 - row redraw    (move vertically)
; 0x03 - flashlight row redraw 0 (move up)
; 0x04 - flashlight row redraw 0 (move down)
; 0x05 - flashlight column redraw 0 (move left)
; 0x06 - flashlight column redraw 0 (move right)
; 0x07 - flashlight row redraw 1 (move up)
; 0x08 - flashlight row redraw 1 (move down)
; 0x09 - flashlight column redraw 1 (move left)
; 0x0A - flashlight column redraw 1 (move right)
; 0x0B - flashlight row redraw 2 (move up)
; 0x0C - flashlight row redraw 2 (move down)
; 0x0D - flashlight column redraw 2 (move left)
; 0x0E - flashlight column redraw 2 (move right)
; 0x0F - flashlight row redraw 3 (move up)
; 0x10 - flashlight row redraw 3 (move down)
; 0x11 - flashlight column redraw 3 (move left)
; 0x12 - flashlight column redraw 3 (move right)

hRedrawRowOrColumnDest:: ds 2 ; ffe6

hMapAnims:: ; ffe8
    ; TODO: figure out size
    ds 7
hRandomAdd:: db ; ffef
hRandomSub:: db ; fff0
hRTCRandom:: db ; fff1

    ; TODO
