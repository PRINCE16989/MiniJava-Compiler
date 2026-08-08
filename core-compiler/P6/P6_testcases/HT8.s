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
	la $t2, D_funCall
	sw $t2, 0($t1)
	sw $t1, 0($t0)
	move $t3, $t0
	lw $t4, 0($t3)
	lw $t5, 0($t4)
	move $t6, $t5
	li $t7, 2
	li $t8, 3
	li $t9, 4
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
	move $a1, $t7
	move $a2, $t8
	move $a3, $t9
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
	move $t2, $v0
	move $a0, $t2
	jal _print
	addu $sp, $sp, 44
	lw $ra, -4($fp)
	j $ra

	.text
	.globl D_funCall
D_funCall:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 56
	sw $s0, -12($fp)
	sw $s1, -16($fp)
	move $t0, $a1
	move $t1, $a2
	move $s0, $a3
	li $a0, 12
	jal _halloc
	move $t2, $v0
	li $a0, 12
	jal _halloc
	move $t3, $v0
	la $t4, A_funA
	sw $t4, 0($t3)
	la $t5, A_funA2
	sw $t5, 4($t3)
	li $t6, 0
	sw $t6, 4($t2)
	sw $t3, 0($t2)
	move $s1, $t2
	move $t7, $s1
	lw $t8, 0($t7)
	lw $t9, 0($t8)
	move $t4, $t9
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
	move $a0, $t7
	move $a1, $t0
	move $a2, $t1
	move $a3, $s0
	jalr $t4
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
	move $a0, $t5
	jal _print
	move $t5, $s0
	move $a0, $t5
	jal _print
	move $t6, $s1
	lw $t3, 0($t6)
	lw $t2, 4($t3)
	move $t8, $t2
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
	move $a0, $t6
	jalr $t8
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
	move $a0, $t5
	jal _print
	move $v0, $t5
	lw $s1, -16($fp)
	lw $s0, -12($fp)
	addu $sp, $sp, 56
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl A_funA
A_funA:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a1
	move $t1, $a2
	add $t0, $t0, 100
	add $t0, $t0, 10
	add $t2, $t0, $t1
	move $a0, $t2
	jal _print
	move $v0, $t0
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl A_funA2
A_funA2:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	lw $t1, 4($t0)
	move $t2, $t1
	sub $t3, $t2, 50
	sw $t3, 4($t0)
	lw $t4, 4($t0)
	move $t5, $t4
	move $v0, $t5
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
