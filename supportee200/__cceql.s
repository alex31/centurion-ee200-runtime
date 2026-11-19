	.setcpu 4
	.export __cceql

	.code
__cceql:
	; 2,s is the high 4,s the low to comare with hireg:b
	; A is free
	lda 4(s)
	sab
	bnz false
	lda 2(s)
	ldb (__hireg)
	sab
	bnz false
	lda (s)
	sta 4(s)
	lda 4
	add a,s
	ldb 1
	rsr
false:
	lda (s)
	sta 4(s)
	lda 4
	add a,s
	clr b
	rsr
