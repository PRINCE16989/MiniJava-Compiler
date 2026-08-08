	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 48
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
	li $t7, 20
	li $t8, 4
	li $t9, 10
	li $t2, 5
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
	sw $t2, -12($sp)
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
	move $t1, $v0
	move $a0, $t1
	jal _print
	addu $sp, $sp, 48
	lw $ra, -4($fp)
	j $ra

	.text
	.globl D_funCall
D_funCall:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 12
	move $t0, $a1
	move $t1, $a2
	move $t2, $a3
	lw $v1, -12($fp)
	move $t3, $v1
	move $t4, $t0
	move $t5, $t1
	div $t6, $t4, $t5
	add $t7, $t6, $t2
	div $t8, $t7, $t3
	add $t9, $t8, 1
	mul $t4, $t9, 4
	add $v1, $t4, 4
	move $a0, $v1
	jal _halloc
	move $t5, $v0
	li $t2, 4
D_funCallLL0:
	mul $t6, $t8, 4
	sle $t3, $t2, $t6
	beqz $t3, D_funCallLL1
	add $t7, $t5, $t2
	li $t9, 0
	sw $t9, 0($t7)
	add $t2, $t2, 4
	j D_funCallLL0
D_funCallLL1:
	sw $t8, 0($t5)
	move $t4, $t5
	move $t6, $t4
	sub $t3, $t1, 2
	add $t7, $t3, 1
	mul $t9, $t7, 4
	add $t2, $t6, $t9
	li $t8, 4
	sw $t8, 0($t2)
	move $t5, $t4
	li $t1, 2
	add $t3, $t1, 1
	mul $t7, $t3, 4
	add $t6, $t5, $t7
	lw $t9, 0($t6)
	move $t2, $t9
	move $a0, $t2
	jal _print
	move $t8, $t4
	div $t1, $t0, 10
	sub $t3, $t1, 1
	add $t5, $t3, 1
	mul $t7, $t5, 4
	add $t6, $t8, $t7
	li $t9, 20
	sw $t9, 0($t6)
	move $t2, $t4
	li $t0, 1
	add $t1, $t0, 1
	mul $t3, $t1, 4
	add $t5, $t2, $t3
	lw $t8, 0($t5)
	move $t7, $t8
	move $a0, $t7
	jal _print
	li $v0, 1
	addu $sp, $sp, 12
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
