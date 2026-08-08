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
	la $t2, A_go
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
	.globl A_go
A_go:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 56
	sw $s0, -12($fp)
	sw $s1, -16($fp)
	li $t0, 2090
	move $t1, $t0
	li $a0, 8
	jal _halloc
	move $t2, $v0
	li $a0, 16
	jal _halloc
	move $t3, $v0
	la $t4, Class1_BMethod
	sw $t4, 0($t3)
	la $t5, Class1_AMethod
	sw $t5, 8($t3)
	la $t6, Class1_CMethod
	sw $t6, 4($t3)
	sw $t3, 0($t2)
	move $t7, $t2
	li $a0, 8
	jal _halloc
	move $t8, $v0
	li $a0, 20
	jal _halloc
	move $t9, $v0
	la $t4, Class2_BMethod
	sw $t4, 0($t9)
	la $t5, Class1_AMethod
	sw $t5, 8($t9)
	la $t6, Class2_DMethod
	sw $t6, 12($t9)
	la $t3, Class1_CMethod
	sw $t3, 4($t9)
	sw $t9, 0($t8)
	move $t2, $t8
	li $a0, 8
	jal _halloc
	move $t7, $v0
	li $a0, 24
	jal _halloc
	move $t4, $v0
	la $t5, Class2_BMethod
	sw $t5, 0($t4)
	la $t6, Class3_DMethod
	sw $t6, 12($t4)
	la $t3, Class3_AMethod
	sw $t3, 8($t4)
	la $t9, Class1_CMethod
	sw $t9, 4($t4)
	la $t8, Class3_FMethod
	sw $t8, 16($t4)
	sw $t4, 0($t7)
	move $s0, $t7
	li $a0, 8
	jal _halloc
	move $t5, $v0
	li $a0, 16
	jal _halloc
	move $t6, $v0
	la $t3, Class1_BMethod
	sw $t3, 0($t6)
	la $t9, Class1_AMethod
	sw $t9, 8($t6)
	la $t8, Class1_CMethod
	sw $t8, 4($t6)
	sw $t6, 0($t5)
	move $t4, $t5
	li $a0, 8
	jal _halloc
	move $t7, $v0
	li $a0, 24
	jal _halloc
	move $t3, $v0
	la $t9, Class2_BMethod
	sw $t9, 0($t3)
	la $t8, Class4_FMethod
	sw $t8, 16($t3)
	la $t6, Class4_DMethod
	sw $t6, 12($t3)
	la $t5, Class4_AMethod
	sw $t5, 8($t3)
	la $t4, Class1_CMethod
	sw $t4, 4($t3)
	sw $t3, 0($t7)
	move $s1, $t7
	move $t9, $s0
	lw $t8, 0($t9)
	lw $t6, 16($t8)
	move $t5, $t6
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
	move $a0, $t9
	move $a1, $t2
	jalr $t5
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
	move $t0, $v0
	move $t4, $s1
	lw $t3, 0($t4)
	lw $t7, 16($t3)
	move $t8, $t7
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
	move $a0, $t4
	move $a1, $s0
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
	move $t1, $v0
	li $v0, 1337
	lw $s1, -16($fp)
	lw $s0, -12($fp)
	addu $sp, $sp, 56
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Class1_AMethod
Class1_AMethod:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $a0, 0
	jal _print
	li $v0, 0
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Class1_BMethod
Class1_BMethod:
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
	.globl Class1_CMethod
Class1_CMethod:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 48
	move $t0, $a0
	li $a0, 2
	jal _print
	move $t1, $t0
	lw $t2, 0($t1)
	lw $t3, 0($t2)
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
	li $v0, 2
	addu $sp, $sp, 48
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Class2_BMethod
Class2_BMethod:
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
	.globl Class2_DMethod
Class2_DMethod:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $a0, 4
	jal _print
	li $v0, 4
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Class3_AMethod
Class3_AMethod:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $a0, 7
	jal _print
	li $v0, 7
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Class3_DMethod
Class3_DMethod:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $a0, 5
	jal _print
	li $v0, 5
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Class3_FMethod
Class3_FMethod:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $a0, 6
	jal _print
	li $v0, 6
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Class4_AMethod
Class4_AMethod:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 48
	move $t0, $a0
	li $a0, 8
	jal _print
	move $t1, $t0
	lw $t2, 0($t1)
	lw $t3, 4($t2)
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
	li $v0, 8
	addu $sp, $sp, 48
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Class4_DMethod
Class4_DMethod:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 48
	move $t0, $a0
	li $a0, 9
	jal _print
	move $t1, $t0
	lw $t2, 0($t1)
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
	move $v0, $t5
	addu $sp, $sp, 48
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Class4_FMethod
Class4_FMethod:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 48
	move $t0, $a0
	li $a0, 10
	jal _print
	move $t1, $t0
	lw $t2, 0($t1)
	lw $t3, 12($t2)
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
	li $v0, 10
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
