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
	la $t2, A_foo
	sw $t2, 0($t1)
	la $t3, A_start
	sw $t3, 4($t1)
	sw $t1, 0($t0)
	move $t4, $t0
	lw $t5, 0($t4)
	lw $t6, 4($t5)
	move $t7, $t6
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
	move $a0, $t4
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
	.globl A_start
A_start:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 48
	move $t0, $a0
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
	lw $t6, 0($t5)
	move $t7, $t6
	move $a0, $t7
	jal _print
	li $v0, 0
	addu $sp, $sp, 48
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
	li $t0, 5
	add $t1, $t0, 1
	mul $t2, $t1, 4
	add $v1, $t2, 4
	move $a0, $v1
	jal _halloc
	move $t3, $v0
	li $t4, 4
A_fooLL0:
	mul $t5, $t0, 4
	sle $t6, $t4, $t5
	beqz $t6, A_fooLL1
	add $t7, $t3, $t4
	li $t8, 0
	sw $t8, 0($t7)
	add $t4, $t4, 4
	j A_fooLL0
A_fooLL1:
	sw $t0, 0($t3)
	move $t9, $t3
	move $v0, $t9
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
