	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 44
	li $a0, 8
	jal _halloc
	move $t0, $v0
	li $a0, 8
	jal _halloc
	move $t1, $v0
	sw $t1, 0($t0)
	la $t2, WhileComplex_ved_TestWhileComplex
	sw $t2, 0($t1)
	lw $t3, 0($t0)
	lw $t4, 0($t3)
	sw $t0, -12($fp)
	sw $t1, -16($fp)
	sw $t2, -20($fp)
	sw $t3, -24($fp)
	sw $t4, -28($fp)
	sw $t5, -32($fp)
	sw $t6, -36($fp)
	sw $t7, -40($fp)
	sw $t8, -44($fp)
	sw $t9, -48($fp)
	move $a0, $t0
	jalr $t4
	lw $t0, -12($fp)
	lw $t1, -16($fp)
	lw $t2, -20($fp)
	lw $t3, -24($fp)
	lw $t4, -28($fp)
	lw $t5, -32($fp)
	lw $t6, -36($fp)
	lw $t7, -40($fp)
	lw $t8, -44($fp)
	lw $t9, -48($fp)
	move $t5, $v0
	move $a0, $t5
	jal _print
	addu $sp, $sp, 44
	lw $ra, -4($fp)
	j $ra

	.text
	.globl WhileComplex_ved_TestWhileComplex
WhileComplex_ved_TestWhileComplex:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $t0, 0
	move $t1, $t0
	li $t2, 0
	move $t3, $t2
	li $t4, 20
	move $t5, $t4
WhileComplex_ved_TestWhileComplexLL1:
	nop
	li $t6, 10
	sle $t7, $t1, $t6
	sle $t8, $t3, $t5
	add $t9, $t7, $t8
	sne $t0, $t9, 2
	li $t2, 1
	sne $t0, $t2, $t0
	beqz $t0, WhileComplex_ved_TestWhileComplexLL2
	add $t4, $t3, $t1
	move $t3, $t4
	move $a0, $t3
	jal _print
	li $t6, 1
	add $t7, $t1, $t6
	move $t1, $t7
	j WhileComplex_ved_TestWhileComplexLL1
WhileComplex_ved_TestWhileComplexLL2:
	nop
	li $t8, 0
	move $v0, $t8
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl _halloc
_halloc:
	li $v0, 9
	syscall
	j $ra

	.text
	.globl _print
_print:
	li $v0, 1
	syscall
	la $a0, newl
	li $v0, 4
	syscall
	j $ra

	.data
	.align 0
newl:	.asciiz "\n"
	.data
	.align 0
str_er: .asciiz "ERROR: abnormal termination\n"
