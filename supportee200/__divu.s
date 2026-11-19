; Unsigned 16-bit quotient/remainder via zero-extended 32-bit helpers.
	.setcpu 6
	.export __divu
	.export __remu
	.code
__divu:
	cla
	bra begin
__remu:
	lda 1
begin:
	stx (-s)
	sta (-s)
	stb (-s)	; 0 divisor, 2 selector, 4 return, 6 old X, 8 dividend
	cla
	sta (__hireg)
	ldb 8(s)
	stb (-s)
	cla
	sta (-s)
	ldb 4(s)
	lda 6(s)
	bz divide
	jsr __remul
	bra finish
divide:
	jsr __divul
finish:
	ldx 4(s)
	lda 6(s)
	sta 8(s)
	lda 8
	add a,s
	rsr
