	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 44
	li $a0, 8
	jal _halloc
	move $t0, $v0
	li $a0, 16
	jal _halloc
	move $t1, $v0
	la $t2, A_a
	sw $t2, 0($t1)
	la $t3, A_b
	sw $t3, 4($t1)
	la $t4, A_start
	sw $t4, 8($t1)
	sw $t1, 0($t0)
	move $t5, $t0
	lw $t6, 0($t5)
	lw $t7, 8($t6)
	move $t8, $t7
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
	move $a0, $t5
	jalr $t8
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
	move $t9, $v0
	move $a0, $t9
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
	subu $sp, $sp, 68
	sw $s0, -12($fp)
	sw $s1, -16($fp)
	sw $s2, -20($fp)
	sw $s3, -24($fp)
	sw $s4, -28($fp)
	move $s0, $a0
	li $s1, 0
	move $t0, $s0
	lw $t1, 0($t0)
	lw $t2, 0($t1)
	move $t3, $t2
	sw $t0, -32($fp)
	sw $t1, -36($fp)
	sw $t2, -40($fp)
	sw $t3, -44($fp)
	sw $t4, -48($fp)
	sw $t5, -52($fp)
	sw $t6, -56($fp)
	sw $t7, -60($fp)
	sw $t8, -64($fp)
	sw $t9, -68($fp)
	move $a0, $t0
	jalr $t3
	lw $t0, -32($fp)
	lw $t1, -36($fp)
	lw $t2, -40($fp)
	lw $t3, -44($fp)
	lw $t4, -48($fp)
	lw $t5, -52($fp)
	lw $t6, -56($fp)
	lw $t7, -60($fp)
	lw $t8, -64($fp)
	lw $t9, -68($fp)
	move $s2, $v0
	move $t4, $s0
	lw $t5, 0($t4)
	lw $t6, 4($t5)
	move $t7, $t6
	sw $t0, -32($fp)
	sw $t1, -36($fp)
	sw $t2, -40($fp)
	sw $t3, -44($fp)
	sw $t4, -48($fp)
	sw $t5, -52($fp)
	sw $t6, -56($fp)
	sw $t7, -60($fp)
	sw $t8, -64($fp)
	sw $t9, -68($fp)
	move $a0, $t4
	jalr $t7
	lw $t0, -32($fp)
	lw $t1, -36($fp)
	lw $t2, -40($fp)
	lw $t3, -44($fp)
	lw $t4, -48($fp)
	lw $t5, -52($fp)
	lw $t6, -56($fp)
	lw $t7, -60($fp)
	lw $t8, -64($fp)
	lw $t9, -68($fp)
	move $t8, $v0
	add $s3, $s2, $t8
	move $t9, $s0
	lw $t1, 0($t9)
	lw $t2, 4($t1)
	move $t0, $t2
	sw $t0, -32($fp)
	sw $t1, -36($fp)
	sw $t2, -40($fp)
	sw $t3, -44($fp)
	sw $t4, -48($fp)
	sw $t5, -52($fp)
	sw $t6, -56($fp)
	sw $t7, -60($fp)
	sw $t8, -64($fp)
	sw $t9, -68($fp)
	move $a0, $t9
	jalr $t0
	lw $t0, -32($fp)
	lw $t1, -36($fp)
	lw $t2, -40($fp)
	lw $t3, -44($fp)
	lw $t4, -48($fp)
	lw $t5, -52($fp)
	lw $t6, -56($fp)
	lw $t7, -60($fp)
	lw $t8, -64($fp)
	lw $t9, -68($fp)
	move $t3, $v0
	mul $s4, $s3, $t3
	move $t5, $s0
	lw $t6, 0($t5)
	lw $t4, 0($t6)
	move $t7, $t4
	sw $t0, -32($fp)
	sw $t1, -36($fp)
	sw $t2, -40($fp)
	sw $t3, -44($fp)
	sw $t4, -48($fp)
	sw $t5, -52($fp)
	sw $t6, -56($fp)
	sw $t7, -60($fp)
	sw $t8, -64($fp)
	sw $t9, -68($fp)
	move $a0, $t5
	jalr $t7
	lw $t0, -32($fp)
	lw $t1, -36($fp)
	lw $t2, -40($fp)
	lw $t3, -44($fp)
	lw $t4, -48($fp)
	lw $t5, -52($fp)
	lw $t6, -56($fp)
	lw $t7, -60($fp)
	lw $t8, -64($fp)
	lw $t9, -68($fp)
	move $t8, $v0
	sle $t1, $s4, $t8
	li $t2, 1
	li $t9, 1
	sub $t0, $t9, $t1
	beqz $t0, A_startLL0
	li $t3, 1
	sub $t6, $t3, $s1
	beqz $t6, A_startLL0
	li $t4, 0
	j A_startLL1
A_startLL0:
	li $t4, 1
A_startLL1:
	nop
	move $t5, $t4
	sub $s1, $t2, $t5
	li $t7, 1
	li $t8, 1
	li $t9, 0
	beqz $t1, A_startLL2
	beqz $s1, A_startLL2
	li $t9, 1
A_startLL2:
	nop
	move $t0, $t9
	sub $t3, $t8, $t0
	sub $t6, $t7, $t3
	li $t4, 1
	sub $t2, $t4, $s1
	li $t5, 1
	sub $t9, $t5, $t6
	li $t8, 1
	sub $t0, $t8, $t1
	beqz $t0, A_startLL3
	li $a0, 1
	jal _print
	li $t7, 1
	li $t3, 0
	beqz $t2, A_startLL4
	beqz $t6, A_startLL4
	li $t3, 1
A_startLL4:
	nop
	move $t4, $t3
	sub $t5, $t7, $t4
	beqz $t5, A_startLL5
	li $a0, 100
	jal _print
	li $t1, 0
	beqz $s1, A_startLL6
	li $t8, 1
	sub $t0, $t8, $t9
	beqz $t0, A_startLL6
	li $t1, 1
A_startLL6:
	nop
	move $t2, $t1
	beqz $t2, A_startLL7
	li $a0, 200
	jal _print
	j A_startLL8
A_startLL7:
	li $t6, 1
	li $t3, 0
	beqz $s1, A_startLL9
	beqz $t9, A_startLL9
	li $t3, 1
A_startLL9:
	nop
	move $t7, $t3
	sub $t4, $t6, $t7
	beqz $t4, A_startLL10
	li $a0, 300
	jal _print
	j A_startLL11
A_startLL10:
	li $a0, 400
	jal _print
A_startLL11:
	nop
A_startLL8:
	nop
	j A_startLL12
A_startLL5:
	li $a0, 500
	jal _print
A_startLL12:
	nop
	j A_startLL13
A_startLL3:
	li $a0, 3
	jal _print
A_startLL13:
	nop
	li $v0, 3
	lw $s4, -28($fp)
	lw $s3, -24($fp)
	lw $s2, -20($fp)
	lw $s1, -16($fp)
	lw $s0, -12($fp)
	addu $sp, $sp, 68
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl A_a
A_a:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $a0, 1
	jal _print
	li $v0, 1
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl A_b
A_b:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $a0, 2
	jal _print
	li $v0, 2
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
