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
	la $t2, ArrayExpr_ved_TestArrayExpr
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
	.globl ArrayExpr_ved_TestArrayExpr
ArrayExpr_ved_TestArrayExpr:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $t0, 3
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
ArrayExpr_ved_TestArrayExprLL1:
	nop
	li $t7, 1
	add $t8, $t7, $t0
	sne $t9, $t6, $t8
	beqz $t9, ArrayExpr_ved_TestArrayExprLL2
	li $t2, 4
	mul $t1, $t2, $t6
	add $t3, $t5, $t1
	li $t4, 0
	sw $t4, 0($t3)
	li $t7, 1
	add $t6, $t7, $t6
	j ArrayExpr_ved_TestArrayExprLL1
ArrayExpr_ved_TestArrayExprLL2:
	nop
	move $t8, $t5
	li $t9, 0
	li $t2, 5
	li $t1, 4
	li $t3, 1
	add $t4, $t3, $t9
	mul $t7, $t1, $t4
	add $t0, $t8, $t7
	sw $t2, 0($t0)
	li $t6, 1
	li $t5, 10
	li $t9, 4
	li $t3, 1
	add $t1, $t3, $t6
	mul $t4, $t9, $t1
	add $t7, $t8, $t4
	sw $t5, 0($t7)
	li $t2, 2
	li $t0, 3
	li $t6, 4
	li $t3, 1
	add $t9, $t3, $t2
	mul $t1, $t6, $t9
	add $t4, $t8, $t1
	sw $t0, 0($t4)
	li $t5, 0
	li $t7, 4
	li $t2, 1
	add $t3, $t2, $t5
	mul $t6, $t7, $t3
	add $t9, $t8, $t6
	lw $t1, 0($t9)
	move $t0, $t1
	li $t4, 1
	li $t5, 4
	li $t2, 1
	add $t7, $t2, $t4
	mul $t3, $t5, $t7
	add $t6, $t8, $t3
	lw $t9, 0($t6)
	move $t1, $t9
	add $t4, $t0, $t1
	move $t2, $t4
	move $a0, $t2
	jal _print
	li $t5, 1
	li $t7, 4
	li $t3, 1
	add $t6, $t3, $t5
	mul $t9, $t7, $t6
	add $t4, $t8, $t9
	lw $t5, 0($t4)
	move $t0, $t5
	li $t3, 2
	li $t7, 4
	li $t6, 1
	add $t9, $t6, $t3
	mul $t4, $t7, $t9
	add $t5, $t8, $t4
	lw $t3, 0($t5)
	move $t1, $t3
	mul $t6, $t0, $t1
	move $t2, $t6
	move $a0, $t2
	jal _print
	li $t7, 0
	li $t9, 4
	li $t4, 1
	add $t5, $t4, $t7
	mul $t3, $t9, $t5
	add $t6, $t8, $t3
	lw $t7, 0($t6)
	move $t0, $t7
	li $t4, 1
	li $t9, 4
	li $t5, 1
	add $t3, $t5, $t4
	mul $t6, $t9, $t3
	add $t7, $t8, $t6
	lw $t4, 0($t7)
	move $t1, $t4
	li $t5, 2
	li $t9, 4
	li $t3, 1
	add $t6, $t3, $t5
	mul $t7, $t9, $t6
	add $t4, $t8, $t7
	lw $t5, 0($t4)
	move $t3, $t5
	mul $t9, $t1, $t3
	move $t1, $t9
	add $t6, $t0, $t1
	move $t2, $t6
	move $a0, $t2
	jal _print
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
