	.file	1 "say-hi.c"
	.section .mdebug.eabi64
	.previous
	.rdata
	.align	3
$LC0:
	.ascii	"Hi.\n\000"
	.text
	.align	2
	.globl	say_hi
	.ent	say_hi
say_hi:
	.frame	$fp,16,$31		# vars= 0, regs= 2/0, args= 0, gp= 0
	.mask	0xc0000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	daddiu	$sp,$sp,-16
	sd	$31,8($sp)
	sd	$fp,0($sp)
	move	$fp,$sp
	lui	$2,%hi($LC0)
	daddiu	$4,$2,%lo($LC0)
	jal	printf
	nop

	move	$sp,$fp
	ld	$31,8($sp)
	ld	$fp,0($sp)
	daddiu	$sp,$sp,16
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	say_hi
