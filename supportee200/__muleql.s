; Preserve the pointer while the arithmetic helper consumes its operand.
	.setcpu 6
	.export __muleql
	.code
__muleql:
	stx (-s)
	ldx 4(s)
	lda 2(x)
	sta (-s)
	lda (x)
	sta (-s)
	jsr __mull
	ldx 4(s)
	lda (__hireg)
	sta (x)
	stb 2(x)
	ldx (s+)
	lda (s)
	sta 2(s)
	inr s
	inr s
	rsr
