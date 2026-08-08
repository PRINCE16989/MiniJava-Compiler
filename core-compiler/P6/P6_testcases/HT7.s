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
	li $a0, 12
	jal _halloc
	move $t1, $v0
	la $t2, A_funA
	sw $t2, 0($t1)
	la $t3, A_funA2
	sw $t3, 4($t1)
	li $t4, 0
	sw $t4, 4($t0)
	sw $t1, 0($t0)
	move $t5, $t0
	move $t6, $t5
	lw $t7, 0($t6)
	lw $t8, 0($t7)
	move $t9, $t8
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
	move $a0, $t6
	jalr $t9
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
	move $a0, $t2
	jal _print
	li $a0, 16
	jal _halloc
	move $t3, $v0
	li $a0, 24
	jal _halloc
	move $t4, $v0
	la $t1, B_funOtherB
	sw $t1, 16($t4)
	la $t0, A_funA
	sw $t0, 0($t4)
	la $t7, A_funA2
	sw $t7, 4($t4)
	la $t8, B_funB
	sw $t8, 8($t4)
	la $t6, B_funC
	sw $t6, 12($t4)
	li $t9, 0
	sw $t9, 4($t3)
	li $t1, 0
	sw $t1, 8($t3)
	sw $t4, 0($t3)
	move $s0, $t3
	move $t0, $s0
	lw $t7, 0($t0)
	lw $t8, 8($t7)
	move $t6, $t8
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
	move $t2, $v0
	move $a0, $t2
	jal _print
	move $t5, $s0
	move $t9, $t5
	lw $t1, 0($t9)
	lw $t4, 0($t1)
	move $t3, $t4
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
	move $a0, $t9
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
	move $t2, $v0
	move $a0, $t2
	jal _print
	li $a0, 20
	jal _halloc
	move $t7, $v0
	li $a0, 24
	jal _halloc
	move $t8, $v0
	la $t0, C_funB
	sw $t0, 8($t8)
	la $t6, B_funOtherB
	sw $t6, 16($t8)
	la $t5, A_funA
	sw $t5, 0($t8)
	la $t1, A_funA2
	sw $t1, 4($t8)
	la $t4, B_funC
	sw $t4, 12($t8)
	li $t9, 0
	sw $t9, 4($t7)
	li $t3, 0
	sw $t3, 8($t7)
	li $t0, 0
	sw $t0, 12($t7)
	sw $t8, 0($t7)
	move $s0, $t7
	move $t6, $s0
	lw $t5, 0($t6)
	lw $t1, 8($t5)
	move $t4, $t1
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
	move $a0, $t6
	jalr $t4
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
	move $a0, $t2
	jal _print
	move $t9, $s0
	lw $t3, 0($t9)
	lw $t0, 12($t3)
	move $t8, $t0
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
	move $a0, $t9
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
	move $t2, $v0
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
	subu $sp, $sp, 48
	move $t0, $a0
	li $t1, 100
	add $t1, $t1, 10
	move $a0, $t1
	jal _print
	move $t2, $t0
	lw $t3, 0($t2)
	lw $t4, 4($t3)
	move $t5, $t4
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
	move $a0, $t2
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
	move $t1, $v0
	move $v0, $t1
	addu $sp, $sp, 48
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
	add $t3, $t2, 1000
	sw $t3, 4($t0)
	lw $t4, 4($t0)
	move $t5, $t4
	move $v0, $t5
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
	subu $sp, $sp, 48
	move $t0, $a0
	move $t1, $t0
	lw $t2, 0($t1)
	lw $t3, 16($t2)
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
	move $a0, $t1
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
	move $v0, $t5
	addu $sp, $sp, 48
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
	li $t1, 500
	lw $t2, 8($t0)
	move $t3, $t2
	add $t4, $t1, $t3
	move $a0, $t4
	jal _print
	lw $t5, 8($t0)
	move $t6, $t5
	add $t7, $t1, $t6
	move $v0, $t7
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
	lw $t1, 8($t0)
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
