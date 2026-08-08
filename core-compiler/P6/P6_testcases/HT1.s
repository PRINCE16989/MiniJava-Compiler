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
	.globl D_funCall
D_funCall:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 52
	sw $s0, -12($fp)
	li $a0, 12
	jal _halloc
	move $t0, $v0
	li $a0, 8
	jal _halloc
	move $t1, $v0
	la $t2, A_funA
	sw $t2, 0($t1)
	li $t3, 0
	sw $t3, 4($t0)
	sw $t1, 0($t0)
	move $t4, $t0
	move $t5, $t4
	lw $t6, 0($t5)
	lw $t7, 0($t6)
	move $t8, $t7
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
	move $a0, $t5
	jalr $t8
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
	move $t9, $v0
	move $a0, $t9
	jal _print
	li $a0, 16
	jal _halloc
	move $t2, $v0
	li $a0, 20
	jal _halloc
	move $t3, $v0
	la $t1, B_funOtherB
	sw $t1, 12($t3)
	la $t0, A_funA
	sw $t0, 0($t3)
	la $t6, B_funB
	sw $t6, 4($t3)
	la $t7, B_funC
	sw $t7, 8($t3)
	li $t5, 0
	sw $t5, 4($t2)
	li $t8, 0
	sw $t8, 8($t2)
	sw $t3, 0($t2)
	move $s0, $t2
	move $t1, $s0
	lw $t0, 0($t1)
	lw $t6, 4($t0)
	move $t7, $t6
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
	move $a0, $t1
	jalr $t7
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
	move $t9, $v0
	move $a0, $t9
	jal _print
	move $t4, $s0
	move $t5, $t4
	lw $t8, 0($t5)
	lw $t3, 0($t8)
	move $t2, $t3
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
	move $a0, $t5
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
	move $t9, $v0
	move $a0, $t9
	jal _print
	li $a0, 20
	jal _halloc
	move $t0, $v0
	li $a0, 20
	jal _halloc
	move $t6, $v0
	la $t1, C_funB
	sw $t1, 4($t6)
	la $t7, B_funOtherB
	sw $t7, 12($t6)
	la $t4, A_funA
	sw $t4, 0($t6)
	la $t8, B_funC
	sw $t8, 8($t6)
	li $t3, 0
	sw $t3, 4($t0)
	li $t5, 0
	sw $t5, 8($t0)
	li $t2, 0
	sw $t2, 12($t0)
	sw $t6, 0($t0)
	move $s0, $t0
	move $a0, $t9
	jal _print
	move $t1, $s0
	lw $t7, 0($t1)
	lw $t4, 8($t7)
	move $t8, $t4
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
	move $a0, $t1
	jalr $t8
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
	move $t9, $v0
	li $v0, 1
	lw $s0, -12($fp)
	addu $sp, $sp, 52
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
	move $t0, $a0
	li $t1, 100
	sw $t1, 4($t0)
	lw $t2, 4($t0)
	move $t3, $t2
	add $t4, $t3, 10
	sw $t4, 4($t0)
	lw $t5, 4($t0)
	move $t6, $t5
	move $a0, $t6
	jal _print
	lw $t7, 4($t0)
	move $t8, $t7
	move $v0, $t8
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl B_funC
B_funC:
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
	sw $t4, 8($s0)
	lw $t5, 8($s0)
	move $t6, $t5
	move $a0, $t6
	jal _print
	move $t7, $s0
	lw $t8, 0($t7)
	lw $t9, 4($t8)
	move $t1, $t9
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
	move $a0, $t7
	jalr $t1
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
	move $t2, $v0
	sw $t2, 8($s0)
	lw $t0, 8($s0)
	move $t3, $t0
	move $v0, $t3
	lw $s0, -12($fp)
	addu $sp, $sp, 52
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl B_funB
B_funB:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	li $t1, 200
	sw $t1, 8($t0)
	lw $t2, 4($t0)
	move $t3, $t2
	lw $t4, 8($t0)
	move $t5, $t4
	add $t6, $t3, $t5
	sw $t6, 8($t0)
	lw $t7, 8($t0)
	move $t8, $t7
	move $a0, $t8
	jal _print
	lw $t9, 8($t0)
	move $t1, $t9
	move $v0, $t1
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl B_funOtherB
B_funOtherB:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	lw $t1, 8($t0)
	move $t2, $t1
	move $a0, $t2
	jal _print
	lw $t3, 8($t0)
	move $t4, $t3
	move $v0, $t4
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl C_funB
C_funB:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 48
	move $t0, $a0
	lw $t1, 12($t0)
	move $t2, $t1
	move $a0, $t2
	jal _print
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
	move $v0, $t7
	addu $sp, $sp, 48
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
