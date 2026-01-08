; wLinkMode
	const_def
	const LINK_NULL        ; 0
	const LINK_TIMECAPSULE ; 1
	const LINK_TRADECENTER ; 2
	const LINK_COLOSSEUM   ; 3

; hSerialReceive high nybbles
DEF SERIAL_TRADECENTER EQU $60
DEF SERIAL_BATTLE      EQU $70

; serial
DEF ESTABLISH_CONNECTION_WITH_INTERNAL_CLOCK EQU $01
DEF ESTABLISH_CONNECTION_WITH_EXTERNAL_CLOCK EQU $02

DEF USING_EXTERNAL_CLOCK       EQU $01
DEF USING_INTERNAL_CLOCK       EQU $02
DEF CONNECTION_NOT_ESTABLISHED EQU $ff

; signals the start of an array of bytes transferred over the link cable
DEF SERIAL_PREAMBLE_BYTE EQU $FD

; this byte is used when there is no data to send
DEF SERIAL_NO_DATA_BYTE EQU $FE

; signals the end of one part of a patch list (there are two parts) for player/enemy party data
DEF SERIAL_PATCH_LIST_PART_TERMINATOR EQU $FF

; timeout duration after exchanging a byte
DEF SERIAL_LINK_BYTE_TIMEOUT EQU $5000
