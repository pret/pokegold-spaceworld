HackInterrupt EQU $0000

; Note that a hack call takes 3 bytes.
hack: MACRO
    ld a, (Hack\1Entry - HackTable) / 2
    rst HackInterrupt
ENDM
