	.setcpu 4
	.export __mul
	.export __mulu

	.code

__mul:
__mulu:
	; Bit shift multiply
	xfr	b,a		; right operand, before loading the stacked left operand
	stx	(-s)
	xfr	y,x
	stx	(-s)

	clr	y
	ldb	6(s)
	ldx	16		; counter
	; Now do 16 iterations
nextbit:
	slr	y
	sla
	bnl	noadd
	add	b,y
noadd:	dcx
	bnz	nextbit

	; Result is now in Y
	xfr	y,b
	lda	(s+)
	xay
	ldx	(s+)
	lda	(s)		; preserve the caller's X while discarding the operand
	sta	2(s)
	inr	s
	inr	s
	rsr
