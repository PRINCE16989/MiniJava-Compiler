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
	la $t2, ArrayFieldTest_ved_TestField
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
	.globl ArrayFieldTest_ved_TestField
ArrayFieldTest_ved_TestField:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	li $t1, 4
	li $t2, 4
	li $t3, 1
	add $t4, $t3, $t1
	mul $t5, $t2, $t4
	add $v1, $t5, 4
	move $a0, $v1
	jal _halloc
	move $t6, $v0
	sw $t1, 0($t6)
	li $t7, 1
ArrayFieldTest_ved_TestFieldLL1:
	nop
	li $t8, 1
	add $t9, $t8, $t1
	sne $t3, $t7, $t9
	beqz $t3, ArrayFieldTest_ved_TestFieldLL2
	li $t2, 4
	mul $t4, $t2, $t7
	add $t5, $t6, $t4
	li $t8, 0
	sw $t8, 0($t5)
	li $t9, 1
	add $t7, $t9, $t7
	j ArrayFieldTest_ved_TestFieldLL1
ArrayFieldTest_ved_TestFieldLL2:
	nop
	move $t3, $t0
	sw $t6, 4($t3)
	li $t2, 0
	li $t4, 5
	lw $t5, 4($t0)
	li $t8, 4
	li $t9, 1
	add $t1, $t9, $t2
	mul $t7, $t8, $t1
	add $t6, $t5, $t7
	sw $t4, 0($t6)
	li $t3, 1
	li $t2, 10
	lw $t9, 4($t0)
	li $t8, 4
	li $t1, 1
	add $t5, $t1, $t3
	mul $t7, $t8, $t5
	add $t4, $t9, $t7
	sw $t2, 0($t4)
	li $t6, 2
	li $t3, 15
	lw $t1, 4($t0)
	li $t8, 4
	li $t5, 1
	add $t9, $t5, $t6
	mul $t7, $t8, $t9
	add $t2, $t1, $t7
	sw $t3, 0($t2)
	li $t4, 3
	li $t6, 20
	lw $t5, 4($t0)
	li $t8, 4
	li $t9, 1
	add $t1, $t9, $t4
	mul $t7, $t8, $t1
	add $t3, $t5, $t7
	sw $t6, 0($t3)
	lw $t2, 4($t0)
	li $t4, 0
	li $t9, 4
	li $t8, 1
	add $t1, $t8, $t4
	mul $t5, $t9, $t1
	add $t7, $t2, $t5
	lw $t6, 0($t7)
	move $t3, $t6
	lw $t4, 4($t0)
	li $t8, 3
	li $t9, 4
	li $t1, 1
	add $t2, $t1, $t8
	mul $t5, $t9, $t2
	add $t7, $t4, $t5
	lw $t6, 0($t7)
	move $t8, $t6
	add $t1, $t3, $t8
	move $t9, $t1
	move $a0, $t9
	jal _print
	lw $t2, 4($t0)
	li $t4, 1
	li $t5, 4
	li $t7, 1
	add $t6, $t7, $t4
	mul $t1, $t5, $t6
	add $t4, $t2, $t1
	lw $t7, 0($t4)
	move $t3, $t7
	lw $t5, 4($t0)
	li $t6, 2
	li $t2, 4
	li $t1, 1
	add $t4, $t1, $t6
	mul $t7, $t2, $t4
	add $t0, $t5, $t7
	lw $t6, 0($t0)
	move $t8, $t6
	add $t1, $t3, $t8
	move $t9, $t1
	move $a0, $t9
	jal _print
	li $t2, 0
	move $v0, $t2
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
