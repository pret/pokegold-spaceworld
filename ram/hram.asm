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

	ds 2 ; TODO

hDebugMapViewerJumptable:: db

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

hInMenu:: db
; hJoySum will be updated from
; 00 - hJoyDown
; <> - hJoyState
; See GetJoypadDebounced

hJoypadState2:: db

UNION

hFFA7:: db
hFFA8:: db
hFFA9:: db

NEXTU

hDebugMenuSoundMenuIndex:: db
hDebugMenuSoundID:: db
hDebugMenuSoundBank:: db

ENDU

	ds 3 ; TODO
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

hMapObjectIndex:: db
hObjectStructIndex:: db

ENDU

UNION
hSpriteOffset::
	db
NEXTU
hEnemyMonSpeed:: dw
ENDU

UNION

; hProduct: unchanged
; replace certain instances of hDividend with hQuotient
; 


; math-related values

UNION
; inputs to Multiply
	ds 1
hMultiplicand:: ds 3
hMultiplier::   db
NEXTU
; result of Multiply
hProduct::      ds 4
NEXTU
; inputs to Divide
hDividend::     ds 4
hDivisor::      db
NEXTU
; results of Divide
hQuotient::     ds 4
hRemainder::    db
ENDU

hMathBuffer::
	ds 5

NEXTU

hPrintNumLeadingDigit:: db ; digit one place-value up
hPrintNumDividend:: ds 3 ; big-endian
hPrintNumDivisor:: ds 3 ; big-endian
hPrintNumTemp:: ds 3 ; big-endian

ENDU

	ds 3 ; TODO

hCurSpriteYCoord::
hFFC0:: ds 1

	ds 6

hFFC7:: db
hFFC8:: db
hFFC9:: db
hFFCA:: db
hFFCB:: db
hFFCC:: db
hFFCD:: db
	ds 2 ; TODO

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
; Meant to go from 0 --> to desired distance
; or else graphical errors will occur.
; 0 - regular distance
; 1 - 14x14 tile block
; 2 - 10x10 tile block
; 3 -  6x 6 tile block
; 4 -  2x 2 tile block

hBGMapMode::
	db

hBGMapTransferPosition::
	db

hBGMapAddress::
	dw

hFFE2::
	db

hSPTemp::
	dw

hRedrawRowOrColumnMode:: db
; Used for redrawing BG in small updates
; instead of once completely for faster
; scrolling on overworld etc.
; Valid values:
; $00 - no redraw
; $01 - column redraw (move horizontally)
; $02 - row redraw    (move vertically)
; $03 - flashlight row redraw 0 (move up)
; $04 - flashlight row redraw 0 (move down)
; $05 - flashlight column redraw 0 (move left)
; $06 - flashlight column redraw 0 (move right)
; $07 - flashlight row redraw 1 (move up)
; $08 - flashlight row redraw 1 (move down)
; $09 - flashlight column redraw 1 (move left)
; $0A - flashlight column redraw 1 (move right)
; $0B - flashlight row redraw 2 (move up)
; $0C - flashlight row redraw 2 (move down)
; $0D - flashlight column redraw 2 (move left)
; $0E - flashlight column redraw 2 (move right)
; $0F - flashlight row redraw 3 (move up)
; $10 - flashlight row redraw 3 (move down)
; $11 - flashlight column redraw 3 (move left)
; $12 - flashlight column redraw 3 (move right)

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
