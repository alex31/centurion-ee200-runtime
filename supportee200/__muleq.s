; Compound assignment: preserve the destination and both return links.
	.setcpu 6
	.export __muleq
	.export __muleqc
	.export __mulequ
	.export __mulequc
	.code
__muleq:
__mulequ:
	stx (-s)
	ldx 4(s)
	lda (x)
	sta (-s)
	jsr __mul
	ldx 4(s)
	stb (x)
	ldx (s+)
	lda (s)
	sta 2(s)
	inr s
	inr s
	rsr
__muleqc:
__mulequc:
	stx (-s)
	ldx 4(s)
	ldab (x)
	clrb ah
	clrb bh
	sta (-s)
	jsr __mul
	ldx 4(s)
	stbb (x)
	ldx (s+)
	lda (s)
	sta 2(s)
	inr s
	inr s
	rsr
