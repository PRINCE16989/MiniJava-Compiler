	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 44
	li $a0, 12
	jal _halloc
	move $t0, $v0
	li $a0, 8
	jal _halloc
	move $t1, $v0
	sw $t1, 0($t0)
	la $t2, LambdaFieldTest_ved_TestLambdaField
	sw $t2, 0($t1)
	li $t3, 0
	sw $t3, 4($t0)
	lw $t4, 0($t0)
	lw $t5, 0($t4)
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
	jalr $t5
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
	move $t6, $v0
	move $a0, $t6
	jal _print
	addu $sp, $sp, 44
	lw $ra, -4($fp)
	j $ra

	.text
	.globl LambdaFieldTest_ved_TestLambdaField
LambdaFieldTest_ved_TestLambdaField:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 56
	sw $s0, -12($fp)
	sw $s1, -16($fp)
	move $s0, $a0
	li $t1, 4
	mul $t2, $t1, 4
	add $v1, $t2, 4
	move $a0, $v1
	jal _halloc
	move $t3, $v0
	li $a0, 8
	jal _halloc
	move $t4, $v0
	sw $t4, 0($t3)
	la $t5, Lambda_ved_1
	sw $t5, 0($t4)
	sw $s0, 4($t3)
	sw $s1, 8($t3)
	sw $t0, 12($t3)
	move $t6, $s0
	sw $t3, 4($t6)
	li $a0, 8
	jal _halloc
	move $t7, $v0
	li $a0, 8
	jal _halloc
	move $t8, $v0
	sw $t8, 0($t7)
	la $t9, Item_ved_Process
	sw $t9, 0($t8)
	move $s1, $t7
	li $t1, 100
	lw $t2, 0($s1)
	lw $t4, 0($t2)
	sw $t0, -20($fp)
	sw $t1, -24($fp)
	sw $t2, -28($fp)
	sw $t3, -32($fp)
	sw $t4, -36($fp)
	sw $t5, -40($fp)
	sw $t6, -44($fp)
	sw $t7, -48($fp)
	sw $t8, -52($fp)
	sw $t9, -56($fp)
	move $a0, $s1
	move $a1, $t1
	jalr $t4
	lw $t0, -20($fp)
	lw $t1, -24($fp)
	lw $t2, -28($fp)
	lw $t3, -32($fp)
	lw $t4, -36($fp)
	lw $t5, -40($fp)
	lw $t6, -44($fp)
	lw $t7, -48($fp)
	lw $t8, -52($fp)
	lw $t9, -56($fp)
	move $t5, $v0
	move $t0, $t5
	move $a0, $t0
	jal _print
	lw $t3, 4($s0)
	lw $t6, 0($t3)
	lw $t8, 0($t6)
	sw $t0, -20($fp)
	sw $t1, -24($fp)
	sw $t2, -28($fp)
	sw $t3, -32($fp)
	sw $t4, -36($fp)
	sw $t5, -40($fp)
	sw $t6, -44($fp)
	sw $t7, -48($fp)
	sw $t8, -52($fp)
	sw $t9, -56($fp)
	move $a0, $t3
	move $a1, $s1
	jalr $t8
	lw $t0, -20($fp)
	lw $t1, -24($fp)
	lw $t2, -28($fp)
	lw $t3, -32($fp)
	lw $t4, -36($fp)
	lw $t5, -40($fp)
	lw $t6, -44($fp)
	lw $t7, -48($fp)
	lw $t8, -52($fp)
	lw $t9, -56($fp)
	move $t9, $v0
	move $s1, $t9
	li $t7, 101
	lw $t2, 0($s1)
	lw $t1, 0($t2)
	sw $t0, -20($fp)
	sw $t1, -24($fp)
	sw $t2, -28($fp)
	sw $t3, -32($fp)
	sw $t4, -36($fp)
	sw $t5, -40($fp)
	sw $t6, -44($fp)
	sw $t7, -48($fp)
	sw $t8, -52($fp)
	sw $t9, -56($fp)
	move $a0, $s1
	move $a1, $t7
	jalr $t1
	lw $t0, -20($fp)
	lw $t1, -24($fp)
	lw $t2, -28($fp)
	lw $t3, -32($fp)
	lw $t4, -36($fp)
	lw $t5, -40($fp)
	lw $t6, -44($fp)
	lw $t7, -48($fp)
	lw $t8, -52($fp)
	lw $t9, -56($fp)
	move $t4, $v0
	move $t0, $t4
	move $a0, $t0
	jal _print
	li $t5, 0
	move $v0, $t5
	lw $s1, -16($fp)
	lw $s0, -12($fp)
	addu $sp, $sp, 56
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Item_ved_Process
Item_ved_Process:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a1
	li $t1, 50
	add $t2, $t0, $t1
	move $v0, $t2
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Lambda_ved_1
Lambda_ved_1:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	move $t1, $a1
	lw $t2, 8($t0)
	lw $t3, 12($t0)
	lw $t4, 4($t0)
	move $t0, $t4
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
