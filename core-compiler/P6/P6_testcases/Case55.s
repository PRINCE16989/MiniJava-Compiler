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
	sw $t1, 0($t0)
	la $t2, A_ved_foo
	sw $t2, 0($t1)
	la $t3, A_ved_bar
	sw $t3, 4($t1)
	li $t4, 2
	lw $t5, 0($t0)
	lw $t6, 0($t5)
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
	move $a1, $t4
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
	.globl A_ved_foo
A_ved_foo:
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
	move $s1, $a1
	li $a0, 12
	jal _halloc
	move $t0, $v0
	li $a0, 16
	jal _halloc
	move $t1, $v0
	sw $t1, 0($t0)
	la $t2, B_ved_setf2
	sw $t2, 0($t1)
	la $t3, B_ved_getf2
	sw $t3, 4($t1)
	la $t4, B_ved_getLambda
	sw $t4, 8($t1)
	li $t5, 0
	sw $t5, 4($t0)
	move $s4, $t0
	li $t6, 50
	lw $t7, 0($s4)
	lw $t8, 0($t7)
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
	move $a0, $s4
	move $a1, $t6
	jalr $t8
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
	move $t9, $v0
	move $t2, $t9
	li $t3, 4
	mul $t1, $t3, 7
	add $v1, $t1, 4
	move $a0, $v1
	jal _halloc
	move $t4, $v0
	li $a0, 8
	jal _halloc
	move $t5, $v0
	sw $t5, 0($t4)
	la $t0, Lambda_ved_1
	sw $t0, 0($t5)
	sw $s0, 4($t4)
	sw $s1, 8($t4)
	sw $t2, 12($t4)
	sw $s2, 16($t4)
	sw $s3, 20($t4)
	sw $s4, 24($t4)
	move $s2, $t4
	lw $t7, 0($s4)
	lw $t6, 8($t7)
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
	move $a0, $s4
	move $a1, $s2
	jalr $t6
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
	move $s3, $t8
	li $t9, 1
	lw $t3, 0($s3)
	lw $t1, 0($t3)
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
	move $a0, $s3
	move $a1, $t9
	jalr $t1
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
	move $t2, $t5
	move $v0, $t2
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
	.globl A_ved_bar
A_ved_bar:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a1
	beqz $t0, A_ved_barLL1
	li $t1, 1
	move $t2, $t1
	j A_ved_barLL2
A_ved_barLL1:
	nop
	li $t3, 10
	move $t2, $t3
A_ved_barLL2:
	nop
	move $v0, $t2
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl B_ved_setf2
B_ved_setf2:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	move $t1, $a1
	move $t2, $t0
	sw $t1, 4($t2)
	li $t3, 0
	move $v0, $t3
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl B_ved_getf2
B_ved_getf2:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	lw $t1, 4($t0)
	move $v0, $t1
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl B_ved_getLambda
B_ved_getLambda:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	move $t1, $a1
	li $t3, 3
	move $t4, $t3
	li $t5, 4
	mul $t6, $t5, 5
	add $v1, $t6, 4
	move $a0, $v1
	jal _halloc
	move $t7, $v0
	li $a0, 8
	jal _halloc
	move $t8, $v0
	sw $t8, 0($t7)
	la $t9, Lambda_ved_2
	sw $t9, 0($t8)
	sw $t0, 4($t7)
	sw $t1, 8($t7)
	sw $t4, 12($t7)
	sw $t2, 16($t7)
	move $t2, $t7
	move $v0, $t2
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Lambda_ved_1
Lambda_ved_1:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 60
	sw $s0, -12($fp)
	sw $s1, -16($fp)
	sw $s2, -20($fp)
	move $t0, $a0
	move $s0, $a1
	lw $t1, 8($t0)
	lw $t2, 12($t0)
	lw $t3, 16($t0)
	lw $t4, 20($t0)
	lw $s1, 24($t0)
	lw $t5, 4($t0)
	move $t0, $t5
	li $a0, 8
	jal _halloc
	move $t6, $v0
	li $a0, 12
	jal _halloc
	move $t7, $v0
	sw $t7, 0($t6)
	la $t8, A_ved_foo
	sw $t8, 0($t7)
	la $t9, A_ved_bar
	sw $t9, 4($t7)
	li $t1, 1
	lw $t2, 0($t6)
	lw $t3, 4($t2)
	sw $t0, -24($fp)
	sw $t1, -28($fp)
	sw $t2, -32($fp)
	sw $t3, -36($fp)
	sw $t4, -40($fp)
	sw $t5, -44($fp)
	sw $t6, -48($fp)
	sw $t7, -52($fp)
	sw $t8, -56($fp)
	sw $t9, -60($fp)
	move $a0, $t6
	move $a1, $t1
	jalr $t3
	lw $t0, -24($fp)
	lw $t1, -28($fp)
	lw $t2, -32($fp)
	lw $t3, -36($fp)
	lw $t4, -40($fp)
	lw $t5, -44($fp)
	lw $t6, -48($fp)
	lw $t7, -52($fp)
	lw $t8, -56($fp)
	lw $t9, -60($fp)
	move $s2, $v0
	lw $t4, 0($s1)
	lw $t0, 4($t4)
	sw $t0, -24($fp)
	sw $t1, -28($fp)
	sw $t2, -32($fp)
	sw $t3, -36($fp)
	sw $t4, -40($fp)
	sw $t5, -44($fp)
	sw $t6, -48($fp)
	sw $t7, -52($fp)
	sw $t8, -56($fp)
	sw $t9, -60($fp)
	move $a0, $s1
	jalr $t0
	lw $t0, -24($fp)
	lw $t1, -28($fp)
	lw $t2, -32($fp)
	lw $t3, -36($fp)
	lw $t4, -40($fp)
	lw $t5, -44($fp)
	lw $t6, -48($fp)
	lw $t7, -52($fp)
	lw $t8, -56($fp)
	lw $t9, -60($fp)
	move $t5, $v0
	add $t8, $s2, $t5
	add $t7, $t8, $s0
	move $v0, $t7
	lw $s2, -20($fp)
	lw $s1, -16($fp)
	lw $s0, -12($fp)
	addu $sp, $sp, 60
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Lambda_ved_2
Lambda_ved_2:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 52
	sw $s0, -12($fp)
	move $t0, $a0
	lw $t1, 8($t0)
	lw $s0, 12($t0)
	lw $t2, 16($t0)
	lw $t3, 4($t0)
	move $t0, $t3
	li $t4, 50
	lw $t5, 0($t1)
	lw $t6, 0($t5)
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
	move $a1, $t4
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
	move $t7, $v0
	add $t8, $s0, $t7
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
