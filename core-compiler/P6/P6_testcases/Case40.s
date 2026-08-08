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
	la $t2, ComplexBool_ved_TestComplexBool
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
	.globl ComplexBool_ved_TestComplexBool
ComplexBool_ved_TestComplexBool:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $t0, 5
	move $t1, $t0
	li $t2, 10
	move $t3, $t2
	li $t4, 15
	move $t5, $t4
	sle $t6, $t1, $t3
	sle $t7, $t3, $t5
	add $t8, $t6, $t7
	sne $t9, $t8, 2
	li $t0, 1
	sne $t9, $t0, $t9
	beqz $t9, ComplexBool_ved_TestComplexBoolLL1
	li $t2, 1
	move $t4, $t2
	j ComplexBool_ved_TestComplexBoolLL2
ComplexBool_ved_TestComplexBoolLL1:
	nop
	li $t6, 0
	move $t4, $t6
ComplexBool_ved_TestComplexBoolLL2:
	nop
	move $a0, $t4
	jal _print
	sle $t7, $t1, $t3
	sle $t8, $t5, $t1
	add $t0, $t7, $t8
	sne $t9, $t0, 0
	beqz $t9, ComplexBool_ved_TestComplexBoolLL3
	li $t2, 2
	move $t4, $t2
	j ComplexBool_ved_TestComplexBoolLL4
ComplexBool_ved_TestComplexBoolLL3:
	nop
	li $t6, 3
	move $t4, $t6
ComplexBool_ved_TestComplexBoolLL4:
	nop
	move $a0, $t4
	jal _print
	sle $t7, $t1, $t3
	sle $t8, $t5, $t3
	add $t0, $t7, $t8
	sne $t9, $t0, 0
	sne $t2, $t9, 1
	beqz $t2, ComplexBool_ved_TestComplexBoolLL5
	li $t6, 4
	move $t4, $t6
	j ComplexBool_ved_TestComplexBoolLL6
ComplexBool_ved_TestComplexBoolLL5:
	nop
	li $t1, 5
	move $t4, $t1
ComplexBool_ved_TestComplexBoolLL6:
	nop
	move $a0, $t4
	jal _print
	li $t3, 0
	move $v0, $t3
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
