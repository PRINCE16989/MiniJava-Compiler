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
	la $t2, LambdaTest_ved_TestLambda
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
	.globl LambdaTest_ved_TestLambda
LambdaTest_ved_TestLambda:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 60
	sw $s0, -12($fp)
	sw $s1, -16($fp)
	sw $s2, -20($fp)
	move $s0, $a0
	li $t1, 4
	mul $t2, $t1, 5
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
	sw $s2, 12($t3)
	sw $t0, 16($t3)
	move $s1, $t3
	li $t6, 10
	lw $t7, 0($s1)
	lw $t8, 0($t7)
	sw $t0, -24($fp)
	sw $t1, -28($fp)
	sw $t2, -32($fp)
	sw $t3, -36($fp)
	sw $t4, -40($fp)
	sw $t5, -44($fp)
	sw $t6, -48($fp)
	sw $t7, -52($fp)
	sw $t8, -56($fp)
	sw $t9, -60($fp)
	move $a0, $s1
	move $a1, $t6
	jalr $t8
	lw $t0, -24($fp)
	lw $t1, -28($fp)
	lw $t2, -32($fp)
	lw $t3, -36($fp)
	lw $t4, -40($fp)
	lw $t5, -44($fp)
	lw $t6, -48($fp)
	lw $t7, -52($fp)
	lw $t8, -56($fp)
	lw $t9, -60($fp)
	move $t9, $v0
	move $t0, $t9
	move $a0, $t0
	jal _print
	li $t1, 4
	mul $t2, $t1, 5
	add $v1, $t2, 4
	move $a0, $v1
	jal _halloc
	move $t4, $v0
	li $a0, 8
	jal _halloc
	move $t5, $v0
	sw $t5, 0($t4)
	la $t3, Lambda_ved_2
	sw $t3, 0($t5)
	sw $s0, 4($t4)
	sw $s1, 8($t4)
	sw $s2, 12($t4)
	sw $t0, 16($t4)
	move $s2, $t4
	li $t7, 10
	lw $t6, 0($s2)
	lw $t8, 0($t6)
	sw $t0, -24($fp)
	sw $t1, -28($fp)
	sw $t2, -32($fp)
	sw $t3, -36($fp)
	sw $t4, -40($fp)
	sw $t5, -44($fp)
	sw $t6, -48($fp)
	sw $t7, -52($fp)
	sw $t8, -56($fp)
	sw $t9, -60($fp)
	move $a0, $s2
	move $a1, $t7
	jalr $t8
	lw $t0, -24($fp)
	lw $t1, -28($fp)
	lw $t2, -32($fp)
	lw $t3, -36($fp)
	lw $t4, -40($fp)
	lw $t5, -44($fp)
	lw $t6, -48($fp)
	lw $t7, -52($fp)
	lw $t8, -56($fp)
	lw $t9, -60($fp)
	move $t9, $v0
	move $t0, $t9
	move $a0, $t0
	jal _print
	move $s2, $s1
	lw $t1, 0($s2)
	lw $t2, 0($t1)
	sw $t0, -24($fp)
	sw $t1, -28($fp)
	sw $t2, -32($fp)
	sw $t3, -36($fp)
	sw $t4, -40($fp)
	sw $t5, -44($fp)
	sw $t6, -48($fp)
	sw $t7, -52($fp)
	sw $t8, -56($fp)
	sw $t9, -60($fp)
	move $a0, $s2
	move $a1, $t0
	jalr $t2
	lw $t0, -24($fp)
	lw $t1, -28($fp)
	lw $t2, -32($fp)
	lw $t3, -36($fp)
	lw $t4, -40($fp)
	lw $t5, -44($fp)
	lw $t6, -48($fp)
	lw $t7, -52($fp)
	lw $t8, -56($fp)
	lw $t9, -60($fp)
	move $t5, $v0
	move $t0, $t5
	move $a0, $t0
	jal _print
	li $t3, 0
	move $v0, $t3
	lw $s2, -20($fp)
	lw $s1, -16($fp)
	lw $s0, -12($fp)
	addu $sp, $sp, 60
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
	lw $t4, 16($t0)
	lw $t5, 4($t0)
	move $t0, $t5
	li $t6, 2
	mul $t7, $t1, $t6
	move $v0, $t7
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Lambda_ved_2
Lambda_ved_2:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	move $t1, $a1
	lw $t2, 8($t0)
	lw $t3, 12($t0)
	lw $t4, 16($t0)
	lw $t5, 4($t0)
	move $t0, $t5
	li $t6, 4
	mul $t7, $t1, $t6
	move $v0, $t7
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
