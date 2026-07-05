GetTerminatingString::
	ld hl, .EmptyString
	ret

.EmptyString:
	db "@"
