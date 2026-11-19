; Preserve the pointer while the arithmetic helper consumes its operand.
	.setcpu 6
	.export __diveql
	.export __remeql
	.code
__diveql:
	stx (-s)
	ldx 4(s)
	lda 2(x)
	sta (-s)
	lda (x)
	sta (-s)
	jsr __divl
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
__remeql:
	stx (-s)
	ldx 4(s)
	lda 2(x)
	sta (-s)
	lda (x)
	sta (-s)
	jsr __reml
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
