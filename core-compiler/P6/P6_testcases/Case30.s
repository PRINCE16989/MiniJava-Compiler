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
	la $t2, ArrayObjTest_ved_TestArrayObj
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
	.globl ArrayObjTest_ved_TestArrayObj
ArrayObjTest_ved_TestArrayObj:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 52
	sw $s0, -12($fp)
	li $a0, 12
	jal _halloc
	move $t0, $v0
	li $a0, 12
	jal _halloc
	move $t1, $v0
	sw $t1, 0($t0)
	la $t2, Container_ved_Init
	sw $t2, 0($t1)
	la $t3, Container_ved_ProcessArray
	sw $t3, 4($t1)
	li $t4, 0
	sw $t4, 4($t0)
	move $s0, $t0
	lw $t5, 0($s0)
	lw $t6, 0($t5)
	sw $t0, -16($fp)
	sw $t1, -20($fp)
	sw $t2, -24($fp)
	sw $t3, -28($fp)
	sw $t4, -32($fp)
	sw $t5, -36($fp)
	sw $t6, -40($fp)
	sw $t7, -44($fp)
	sw $t8, -48($fp)
	sw $t9, -52($fp)
	move $a0, $s0
	jalr $t6
	lw $t0, -16($fp)
	lw $t1, -20($fp)
	lw $t2, -24($fp)
	lw $t3, -28($fp)
	lw $t4, -32($fp)
	lw $t5, -36($fp)
	lw $t6, -40($fp)
	lw $t7, -44($fp)
	lw $t8, -48($fp)
	lw $t9, -52($fp)
	move $t7, $v0
	move $t8, $t7
	lw $t9, 0($s0)
	lw $t2, 4($t9)
	sw $t0, -16($fp)
	sw $t1, -20($fp)
	sw $t2, -24($fp)
	sw $t3, -28($fp)
	sw $t4, -32($fp)
	sw $t5, -36($fp)
	sw $t6, -40($fp)
	sw $t7, -44($fp)
	sw $t8, -48($fp)
	sw $t9, -52($fp)
	move $a0, $s0
	jalr $t2
	lw $t0, -16($fp)
	lw $t1, -20($fp)
	lw $t2, -24($fp)
	lw $t3, -28($fp)
	lw $t4, -32($fp)
	lw $t5, -36($fp)
	lw $t6, -40($fp)
	lw $t7, -44($fp)
	lw $t8, -48($fp)
	lw $t9, -52($fp)
	move $t1, $v0
	move $t8, $t1
	li $t3, 0
	move $v0, $t3
	lw $s0, -12($fp)
	addu $sp, $sp, 52
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Container_ved_Init
Container_ved_Init:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	li $t1, 3
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
Container_ved_InitLL1:
	nop
	li $t8, 1
	add $t9, $t8, $t1
	sne $t3, $t7, $t9
	beqz $t3, Container_ved_InitLL2
	li $t2, 4
	mul $t4, $t2, $t7
	add $t5, $t6, $t4
	li $t8, 0
	sw $t8, 0($t5)
	li $t9, 1
	add $t7, $t9, $t7
	j Container_ved_InitLL1
Container_ved_InitLL2:
	nop
	move $t3, $t0
	sw $t6, 4($t3)
	li $t2, 0
	li $t4, 10
	lw $t5, 4($t0)
	li $t8, 4
	li $t9, 1
	add $t1, $t9, $t2
	mul $t7, $t8, $t1
	add $t6, $t5, $t7
	sw $t4, 0($t6)
	li $t3, 1
	li $t2, 20
	lw $t9, 4($t0)
	li $t8, 4
	li $t1, 1
	add $t5, $t1, $t3
	mul $t7, $t8, $t5
	add $t4, $t9, $t7
	sw $t2, 0($t4)
	li $t6, 2
	li $t3, 30
	lw $t1, 4($t0)
	li $t8, 4
	li $t5, 1
	add $t9, $t5, $t6
	mul $t7, $t8, $t9
	add $t2, $t1, $t7
	sw $t3, 0($t2)
	li $t4, 0
	move $v0, $t4
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Container_ved_ProcessArray
Container_ved_ProcessArray:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	li $t1, 0
	move $t2, $t1
	li $t3, 0
	move $t4, $t3
Container_ved_ProcessArrayLL3:
	nop
	li $t5, 2
	sle $t6, $t2, $t5
	beqz $t6, Container_ved_ProcessArrayLL4
	lw $t7, 4($t0)
	li $t8, 4
	li $t9, 1
	add $t1, $t9, $t2
	mul $t3, $t8, $t1
	add $t5, $t7, $t3
	lw $t6, 0($t5)
	move $t9, $t6
	add $t8, $t4, $t9
	move $t4, $t8
	move $a0, $t4
	jal _print
	li $t1, 1
	add $t7, $t2, $t1
	move $t2, $t7
	j Container_ved_ProcessArrayLL3
Container_ved_ProcessArrayLL4:
	nop
	move $v0, $t4
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
