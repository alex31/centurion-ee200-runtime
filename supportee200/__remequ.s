; Compound assignment: preserve the destination and both return links.
	.setcpu 6
	.export __remequ
	.export __remequc
	.code
__remequ:
	stx (-s)
	ldx 4(s)
	lda (x)
	sta (-s)
	jsr __remu
	ldx 4(s)
	stb (x)
	ldx (s+)
	lda (s)
	sta 2(s)
	inr s
	inr s
	rsr
__remequc:
	stx (-s)
	ldx 4(s)
	ldab (x)
	clrb ah
	clrb bh
	sta (-s)
	jsr __remu
	ldx 4(s)
	stbb (x)
	ldx (s+)
	lda (s)
	sta 2(s)
	inr s
	inr s
	rsr
