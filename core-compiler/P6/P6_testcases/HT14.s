	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 44
	li $a0, 8
	jal _halloc
	move $t0, $v0
	li $a0, 12
	jal _halloc
	move $t1, $v0
	la $t2, A_cond
	sw $t2, 4($t1)
	la $t3, A_start
	sw $t3, 0($t1)
	sw $t1, 0($t0)
	move $t4, $t0
	lw $t5, 0($t4)
	lw $t6, 0($t5)
	move $t7, $t6
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
	move $a0, $t4
	jalr $t7
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
	move $t8, $v0
	move $a0, $t8
	jal _print
	addu $sp, $sp, 44
	lw $ra, -4($fp)
	j $ra

	.text
	.globl A_start
A_start:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 56
	sw $s0, -12($fp)
	sw $s1, -16($fp)
	move $s0, $a0
	li $s1, 0
A_startLL0:
	move $t0, $s0
	lw $t1, 0($t0)
	lw $t2, 4($t1)
	move $t3, $t2
	li $t4, 5
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
	move $a0, $t0
	move $a1, $s1
	move $a2, $t4
	jalr $t3
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
	beqz $t5, A_startLL1
	add $s1, $s1, 1
	li $a0, 1
	jal _print
	j A_startLL0
A_startLL1:
	nop
	li $v0, 0
	lw $s1, -16($fp)
	lw $s0, -12($fp)
	addu $sp, $sp, 56
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl A_cond
A_cond:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a1
	move $t1, $a2
	sle $t2, $t0, $t1
	beqz $t2, A_condLL2
	li $t3, 1
	j A_condLL3
A_condLL2:
	li $t3, 0
A_condLL3:
	nop
	add $t4, $t0, $t1
	move $a0, $t4
	jal _print
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
