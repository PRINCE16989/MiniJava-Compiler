	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 44
	li $t0, 4
	add $v1, $t0, 4
	move $a0, $v1
	jal _halloc
	move $t1, $v0
	la $t2, A_method
	sw $t2, 0($t1)
	li $t3, 4
	add $v1, $t3, 4
	move $a0, $v1
	jal _halloc
	move $t4, $v0
	sw $t1, 0($t4)
	move $t5, $t4
	lw $t6, 0($t5)
	lw $t7, 0($t6)
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
	.globl A_method
A_method:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 48
	li $t0, 8
	add $v1, $t0, 4
	move $a0, $v1
	jal _halloc
	move $t1, $v0
	la $t2, B_foo2
	sw $t2, 0($t1)
	la $t3, B_foo1
	sw $t3, 4($t1)
	li $t4, 4
	add $v1, $t4, 4
	move $a0, $v1
	jal _halloc
	move $t5, $v0
	sw $t1, 0($t5)
	move $t6, $t5
	move $t7, $t6
	li $t8, 8
	add $v1, $t8, 4
	move $a0, $v1
	jal _halloc
	move $t9, $v0
	la $t0, B_foo2
	sw $t0, 0($t9)
	la $t2, B_foo1
	sw $t2, 4($t9)
	li $t3, 4
	add $v1, $t3, 4
	move $a0, $v1
	jal _halloc
	move $t4, $v0
	sw $t9, 0($t4)
	move $t1, $t4
	move $t5, $t1
	move $t6, $t7
	lw $t8, 0($t6)
	lw $t0, 4($t8)
	li $t2, 500
	move $t3, $t7
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
	move $a0, $t6
	move $a1, $t2
	move $a2, $t3
	jalr $t0
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
	move $t4, $t9
	li $t1, 9999
	move $a0, $t1
	jal _print
	li $t5, 9999
	move $v0, $t5
	addu $sp, $sp, 48
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl B_foo1
B_foo1:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 52
	sw $s0, -12($fp)
	move $t0, $a1
	move $t1, $a2
	move $t2, $t0
	li $t3, 0
	sle $t4, $t2, $t3
	li $t5, 1
	sub $t6, $t5, $t4
	beqz $t6, B_foo1LL0
	move $t7, $t0
	li $t8, 1
	sub $t9, $t7, $t8
	move $s0, $t9
	move $t2, $t1
	lw $t3, 0($t2)
	lw $t4, 0($t3)
	move $t5, $s0
	move $t6, $t1
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
	move $a0, $t2
	move $a1, $t5
	move $a2, $t6
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
	move $t0, $v0
	move $t7, $t0
	move $t8, $t7
	move $a0, $t8
	jal _print
	move $t9, $s0
	move $a0, $t9
	jal _print
B_foo1LL0:
	nop
	li $t3, 0
	move $v0, $t3
	lw $s0, -12($fp)
	addu $sp, $sp, 52
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl B_foo2
B_foo2:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 52
	sw $s0, -12($fp)
	move $t0, $a1
	move $t1, $a2
	move $t2, $t0
	li $t3, 0
	sle $t4, $t2, $t3
	li $t5, 1
	sub $t6, $t5, $t4
	beqz $t6, B_foo2LL1
	move $t7, $t0
	li $t8, 1
	sub $t9, $t7, $t8
	move $s0, $t9
	move $t2, $t1
	lw $t3, 0($t2)
	lw $t4, 4($t3)
	move $t5, $s0
	move $t6, $t1
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
	move $a0, $t2
	move $a1, $t5
	move $a2, $t6
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
	move $t0, $v0
	move $t7, $t0
	move $t8, $t7
	move $a0, $t8
	jal _print
	move $t9, $s0
	move $a0, $t9
	jal _print
B_foo2LL1:
	nop
	li $t3, 0
	move $v0, $t3
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
