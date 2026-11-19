; Shift stacked 16-bit operand by the count in B, preserving caller X.
	.setcpu 6
	.export __shl
	.code
__shl:
	stx (-s)
	xfr b,x
	ldb 4(s)
	ori x,x
	bz done
next:
	slr b
	dcx
	bnz next
done:
	ldx (s+)
	lda (s)
	sta 2(s)
	inr s
	inr s
	rsr

