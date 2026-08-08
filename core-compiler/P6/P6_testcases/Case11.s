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
	la $t2, ArrayTest_ved_TestLength
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
	.globl ArrayTest_ved_TestLength
ArrayTest_ved_TestLength:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $t0, 10
	li $t1, 4
	li $t2, 1
	add $t3, $t2, $t0
	mul $t4, $t1, $t3
	add $v1, $t4, 4
	move $a0, $v1
	jal _halloc
	move $t5, $v0
	sw $t0, 0($t5)
	li $t6, 1
ArrayTest_ved_TestLengthLL1:
	nop
	li $t7, 1
	add $t8, $t7, $t0
	sne $t9, $t6, $t8
	beqz $t9, ArrayTest_ved_TestLengthLL2
	li $t2, 4
	mul $t1, $t2, $t6
	add $t3, $t5, $t1
	li $t4, 0
	sw $t4, 0($t3)
	li $t7, 1
	add $t6, $t7, $t6
	j ArrayTest_ved_TestLengthLL1
ArrayTest_ved_TestLengthLL2:
	nop
	move $t8, $t5
	lw $t9, 0($t8)
	move $t2, $t9
	move $a0, $t2
	jal _print
	li $t1, 0
	move $v0, $t1
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
