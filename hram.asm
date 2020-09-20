SECTION "HRAM", HRAM

hOAMDMA::
	ds 10

	ds 3 ; TODO

hRTCHours:: db
hRTCMinutes:: db
hRTCSeconds:: db
hRTCDays:: db
	ds 2 ; TODO
hRTCStatusFlags:: db
	ds 3 ; TODO

hVBlankCounter::
	db

hROMBank::
	db


hVBlank::
	db

hMapEntryMethod::
	db

hStartmenuCloseAndSelectHookEnable:: db

hStartmenuCloseAndSelectHookTemp:: db

hJoypadUp:: db
; Raw Joypad Up Event
; A pressed key was released
hJoypadDown:: db
; Raw Joypad Down Event
; An unpressed key was pressed
hJoypadState:: db
; Raw Joypad State
; State of all keys during current frame
hJoypadSum:: db
; Raw Joypad State Sum
; Sum of all keys that were pressed
; since hJoypadSum was last cleared

	ds 1; TODO
hJoyDown:: db
hJoyState:: db
hJoySum:: db

hJoyDebounceSrc:: db
; hJoySum will be updated from
; 00 - hJoyDown
; <> - hJoyState
; See GetJoypadDebounced

hJoypadState2:: db

	ds 6 ; TODO
hGraphicStartTile:: db
hMoveMon:: db

UNION

hTextBoxCursorBlinkInterval:: ds 2

NEXTU
hEventCollisionException:: db
hEventID:: db

NEXTU

hSpriteWidth::
hSpriteInterlaceCounter::
	db
hSpriteHeight::
	db

NEXTU

hConnectionStripLength:: db
hConnectedMapWidth:: db

NEXTU

hMapObjectIndexBuffer:: db
hObjectStructIndexBuffer:: db

ENDU

hSpriteOffset::
	db

	db ; TODO

UNION

hProduct::
hDividend::
	; ds 4
	db

hMultiplicand::
hQuotient::
	ds 3

hMultiplier::
hDivisor::
hRemainder::
	db

hMathBuffer::
	ds 5

NEXTU

hPrintNumLeadingDigit:: db ; digit one place-value up
hPrintNumDividend:: ds 3 ; big-endian
hPrintNumDivisor:: ds 3 ; big-endian
hPrintNumTemp:: ds 3 ; big-endian

ENDU

	ds 3 ; TODO

hFFC0:: ds 1

	ds 6

hFFC7:: db
hFFC8:: db
hFFC9:: db
hFFCA:: db
hFFCB:: db
hFFCC:: db

	ds 3 ; TODO

hLCDCPointer::
	db

hLYOverrideStart:: db
hLYOverrideEnd:: db
	ds 1 ; TODO


hSerialReceived::
	db

hLinkPlayerNumber::
	db

hSerialIgnoringInitialData::
	db


hSerialSend::
	db
hSerialReceive::
	db


hSCX:: db
hSCY:: db
hWX:: db
hWY:: db

hOverworldFlashlightEffect:: db
; Influences draw distance of map around HIRO
; Meant to go from 0x00--> to desired distance
; or else graphical errors will occur.
; 0x00 - regular distance
; 0x01 - 14x14 tile block
; 0x02 - 10x10 tile block
; 0x03 -  6x 6 tile block
; 0x04 -  2x 2 tile block

hBGMapMode::
	db

hBGMapTransferPosition::
	db

hBGMapAddress::
	dw
	db ; TODO

hSPTemp::
	dw

hRedrawRowOrColumnMode:: db
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

hRedrawRowOrColumnDest:: ds 2

hMapAnims::
	db

hTileAnimFrame::
	db

hFFEA::
	db

hFFEB:: db
hFFEC:: db
hFFED:: db

hFFEE::
	db

hRandomAdd:: db
hRandomSub:: db
hRTCRandom:: db

hBattleTurn:: db

hCurMapTextSubroutinePtr:: dw

	; TODO
