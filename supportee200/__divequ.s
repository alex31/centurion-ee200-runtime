; Compound assignment: preserve the destination and both return links.
	.setcpu 6
	.export __divequ
	.export __divequc
	.code
__divequ:
	stx (-s)
	ldx 4(s)
	lda (x)
	sta (-s)
	jsr __divu
	ldx 4(s)
	stb (x)
	ldx (s+)
	lda (s)
	sta 2(s)
	inr s
	inr s
	rsr
__divequc:
	stx (-s)
	ldx 4(s)
	ldab (x)
	clrb ah
	clrb bh
	sta (-s)
	jsr __divu
	ldx 4(s)
	stbb (x)
	ldx (s+)
	lda (s)
	sta 2(s)
	inr s
	inr s
	rsr
