; Compound assignment: preserve the destination and both return links.
	.setcpu 6
	.export __diveq
	.export __diveqc
	.code
__diveq:
	stx (-s)
	ldx 4(s)
	lda (x)
	sta (-s)
	jsr __div
	ldx 4(s)
	stb (x)
	ldx (s+)
	lda (s)
	sta 2(s)
	inr s
	inr s
	rsr
__diveqc:
	stx (-s)
	ldx 4(s)
	ldab (x)
	clrb ah
	clrb bh
	orib al,al
	bp left_positive
	dcrb ah
left_positive:
	orib bl,bl
	bp right_positive
	dcrb bh
right_positive:
	sta (-s)
	jsr __div
	ldx 4(s)
	stbb (x)
	ldx (s+)
	lda (s)
	sta 2(s)
	inr s
	inr s
	rsr
