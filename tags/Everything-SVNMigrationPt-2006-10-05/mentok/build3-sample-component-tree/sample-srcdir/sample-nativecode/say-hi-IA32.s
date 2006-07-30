	.file	"say-hi.IA32.s"
	.section	.rodata
.LC0:
	.string	"Hi.\n"
	.text
.globl say_hi
	.type	say_hi,@function
say_hi:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$.LC0, (%esp)
	call	printf
	leave
	ret
.Lfe1:
	.size	say_hi,.Lfe1-say_hi
	.ident	"GCC: (GNU) 3.2.2"
