	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 44
	li $a0, 20
	jal _halloc
	move $t0, $v0
	li $a0, 20
	jal _halloc
	move $t1, $v0
	la $t2, B_f3
	sw $t2, 12($t1)
	la $t3, B_f2
	sw $t3, 4($t1)
	la $t4, A_f1
	sw $t4, 0($t1)
	la $t5, A_funCall
	sw $t5, 8($t1)
	li $t6, 0
	sw $t6, 8($t0)
	li $t7, 0
	sw $t7, 4($t0)
	li $t8, 0
	sw $t8, 12($t0)
	sw $t1, 0($t0)
	move $t9, $t0
	lw $t2, 0($t9)
	lw $t3, 8($t2)
	move $t4, $t3
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
	move $a0, $t9
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
	.globl A_funCall
A_funCall:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 48
	move $t0, $a0
	li $t1, 10
	sw $t1, 4($t0)
	lw $t2, 4($t0)
	move $t3, $t2
	move $a0, $t3
	jal _print
	li $t4, 20
	sw $t4, 8($t0)
	lw $t5, 8($t0)
	move $t6, $t5
	move $a0, $t6
	jal _print
	move $t7, $t0
	lw $t8, 0($t7)
	lw $t9, 0($t8)
	move $t1, $t9
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
	jalr $t1
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
	move $t2, $v0
	li $v0, 1
	addu $sp, $sp, 48
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl A_f1
A_f1:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 48
	move $t0, $a0
	lw $t1, 4($t0)
	move $t2, $t1
	move $a0, $t2
	jal _print
	lw $t3, 8($t0)
	move $t4, $t3
	move $a0, $t4
	jal _print
	move $t5, $t0
	lw $t6, 0($t5)
	lw $t7, 4($t6)
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
	move $v0, $t9
	addu $sp, $sp, 48
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl A_f2
A_f2:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	lw $t1, 4($t0)
	move $t2, $t1
	move $a0, $t2
	jal _print
	lw $t3, 8($t0)
	move $t4, $t3
	move $a0, $t4
	jal _print
	lw $t5, 8($t0)
	move $t6, $t5
	move $v0, $t6
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl B_f3
B_f3:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t1, $a0
	li $t0, 100
	sw $t0, 12($t1)
	lw $t2, 12($t1)
	move $t3, $t2
	move $a0, $t3
	jal _print
	lw $t4, 8($t1)
	move $t5, $t4
	move $a0, $t5
	jal _print
	lw $t6, 12($t1)
	move $t7, $t6
	move $v0, $t7
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl B_f2
B_f2:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 52
	sw $s0, -12($fp)
	move $s0, $a0
	move $t0, $s0
	lw $t1, 0($t0)
	lw $t2, 12($t1)
	move $t3, $t2
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
	move $a0, $t0
	jalr $t3
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
	move $t4, $v0
	lw $t5, 12($s0)
	move $t6, $t5
	move $a0, $t6
	jal _print
	lw $t7, 12($s0)
	move $t8, $t7
	move $v0, $t8
	lw $s0, -12($fp)
	addu $sp, $sp, 52
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
