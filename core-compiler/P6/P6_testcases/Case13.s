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
	la $t2, ArrayLoop_ved_TestLoop
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
	.globl ArrayLoop_ved_TestLoop
ArrayLoop_ved_TestLoop:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $t0, 5
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
ArrayLoop_ved_TestLoopLL1:
	nop
	li $t7, 1
	add $t8, $t7, $t0
	sne $t9, $t6, $t8
	beqz $t9, ArrayLoop_ved_TestLoopLL2
	li $t2, 4
	mul $t1, $t2, $t6
	add $t3, $t5, $t1
	li $t4, 0
	sw $t4, 0($t3)
	li $t7, 1
	add $t6, $t7, $t6
	j ArrayLoop_ved_TestLoopLL1
ArrayLoop_ved_TestLoopLL2:
	nop
	move $t8, $t5
	li $t9, 0
	move $t2, $t9
	li $t1, 0
	move $t3, $t1
ArrayLoop_ved_TestLoopLL3:
	nop
	li $t4, 4
	sle $t7, $t2, $t4
	beqz $t7, ArrayLoop_ved_TestLoopLL4
	li $t0, 2
	mul $t6, $t2, $t0
	move $t5, $t6
	li $t9, 4
	li $t1, 1
	add $t4, $t1, $t2
	mul $t7, $t9, $t4
	add $t0, $t8, $t7
	sw $t5, 0($t0)
	li $t6, 1
	add $t1, $t2, $t6
	move $t2, $t1
	j ArrayLoop_ved_TestLoopLL3
ArrayLoop_ved_TestLoopLL4:
	nop
	li $t9, 0
	move $t2, $t9
ArrayLoop_ved_TestLoopLL5:
	nop
	li $t4, 4
	sle $t7, $t2, $t4
	beqz $t7, ArrayLoop_ved_TestLoopLL6
	li $t0, 4
	li $t6, 1
	add $t1, $t6, $t2
	mul $t9, $t0, $t1
	add $t4, $t8, $t9
	lw $t7, 0($t4)
	move $t5, $t7
	add $t6, $t3, $t5
	move $t3, $t6
	move $a0, $t3
	jal _print
	li $t0, 1
	add $t1, $t2, $t0
	move $t2, $t1
	j ArrayLoop_ved_TestLoopLL5
ArrayLoop_ved_TestLoopLL6:
	nop
	li $t9, 0
	move $v0, $t9
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
