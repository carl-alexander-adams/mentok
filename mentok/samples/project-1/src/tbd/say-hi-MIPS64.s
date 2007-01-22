	.file	1 "say-hi.c"
	.section .mdebug.abi64
	.previous
	.abicalls
	.rdata
	.align	3
.LC0:
	.ascii	"Hi.\n\000"
	.text
	.align	2
	.globl	say_hi
	.ent	say_hi
	.type	say_hi, @function
say_hi:
	.frame	$fp,32,$31		# vars= 0, regs= 3/0, args= 0, gp= 0
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	daddiu	$sp,$sp,-32
	sd	$31,16($sp)
	sd	$fp,8($sp)
	sd	$28,0($sp)
	move	$fp,$sp
	lui	$28,%hi(%neg(%gp_rel(say_hi)))
	daddu	$28,$28,$25
	daddiu	$28,$28,%lo(%neg(%gp_rel(say_hi)))
	dla	$4,.LC0
	jal	printf
	move	$sp,$fp
	ld	$31,16($sp)
	ld	$fp,8($sp)
	ld	$28,0($sp)
	daddiu	$sp,$sp,32
	j	$31
	.end	say_hi
	.ident	"GCC: (GNU) 3.4.3 Cavium Networks Version: 0.07, build 9"
