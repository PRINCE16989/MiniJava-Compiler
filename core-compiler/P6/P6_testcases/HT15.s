	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 44
	li $a0, 8
	jal _halloc
	move $t0, $v0
	li $a0, 24
	jal _halloc
	move $t1, $v0
	la $t2, A_a
	sw $t2, 0($t1)
	la $t3, A_b
	sw $t3, 4($t1)
	la $t4, A_c
	sw $t4, 8($t1)
	la $t5, A_foo
	sw $t5, 12($t1)
	la $t6, A_start
	sw $t6, 16($t1)
	sw $t1, 0($t0)
	move $t7, $t0
	lw $t8, 0($t7)
	lw $t9, 16($t8)
	move $t2, $t9
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
	move $a0, $t7
	jalr $t2
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
	move $t3, $v0
	move $a0, $t3
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
	move $s1, $s0
	lw $t0, 0($s1)
	lw $t1, 12($t0)
	move $s2, $t1
	move $t2, $s0
	lw $t3, 0($t2)
	lw $t4, 0($t3)
	move $t5, $t4
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
	move $a0, $t2
	jalr $t5
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
	move $s3, $v0
	move $t6, $s0
	lw $t7, 0($t6)
	lw $t8, 4($t7)
	move $t9, $t8
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
	move $a0, $t6
	jalr $t9
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
	move $s4, $v0
	move $t0, $s0
	lw $t1, 0($t0)
	lw $t3, 8($t1)
	move $t4, $t3
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
	jalr $t4
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
	move $t2, $v0
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
	move $a0, $s1
	move $a1, $s3
	move $a2, $s4
	move $a3, $t2
	jalr $s2
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
	move $t5, $v0
	move $v0, $t5
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
	.globl A_c
A_c:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $a0, 3
	jal _print
	li $v0, 3
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl A_foo
A_foo:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
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
