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
	la $t2, A_start
	sw $t2, 0($t1)
	sw $t1, 0($t0)
	move $t3, $t0
	lw $t4, 0($t3)
	lw $t5, 0($t4)
	move $t6, $t5
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
	move $a0, $t3
	jalr $t6
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
	move $t7, $v0
	move $a0, $t7
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
	subu $sp, $sp, 8
	li $t0, 1
	li $t1, 2
	li $t2, 3
	li $t3, 4
	li $t4, 10
	li $t5, 20
	li $t6, 30
	li $t7, 0
	add $t8, $t2, $t3
	mul $t9, $t1, $t8
	add $t2, $t0, $t9
	add $t3, $t5, $t6
	sub $t1, $t4, $t3
	sle $t8, $t2, $t1
	beqz $t8, A_startLL0
	sle $t9, $t0, 2
	beqz $t9, A_startLL0
	li $t7, 1
A_startLL0:
	nop
	move $t5, $t7
	beqz $t5, A_startLL1
	li $a0, 1
	jal _print
	j A_startLL2
A_startLL1:
	li $a0, 0
	jal _print
A_startLL2:
	nop
	li $v0, 0
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
