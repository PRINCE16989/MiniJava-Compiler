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
	subu $sp, $sp, 52
	sw $s0, -12($fp)
	li $t0, 16
	add $v1, $t0, 4
	move $a0, $v1
	jal _halloc
	move $t1, $v0
	la $t2, B_initialize
	sw $t2, 0($t1)
	la $t3, B_makeGraph
	sw $t3, 4($t1)
	la $t4, B_printColors
	sw $t4, 8($t1)
	la $t5, B_dfs
	sw $t5, 12($t1)
	li $t6, 20
	add $v1, $t6, 4
	move $a0, $v1
	jal _halloc
	move $t7, $v0
	sw $t1, 0($t7)
	li $t8, 0
	sw $t8, 4($t7)
	li $t9, 0
	sw $t9, 8($t7)
	li $t0, 0
	sw $t0, 12($t7)
	li $t2, 0
	sw $t2, 16($t7)
	move $t3, $t7
	move $s0, $t3
	move $t4, $s0
	lw $t5, 0($t4)
	lw $t6, 0($t5)
	li $t1, 10
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
	move $a0, $t4
	move $a1, $t1
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
	move $t8, $v0
	move $t9, $t8
	move $t0, $s0
	lw $t2, 0($t0)
	lw $t7, 4($t2)
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
	move $t3, $v0
	move $t9, $t3
	move $t5, $s0
	lw $t4, 0($t5)
	lw $t6, 12($t4)
	li $t1, 5
	li $t8, 1
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
	move $a1, $t1
	move $a2, $t8
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
	move $t9, $t2
	move $t0, $s0
	lw $t7, 0($t0)
	lw $t3, 8($t7)
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
	move $t9, $t4
	li $t5, 9999
	move $v0, $t5
	lw $s0, -12($fp)
	addu $sp, $sp, 52
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl B_initialize
B_initialize:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	move $t1, $a1
	move $t2, $t1
	sw $t2, 16($t0)
	move $t3, $t1
	li $t4, 1
	add $t5, $t3, $t4
	move $t1, $t5
	move $t6, $t1
	li $t7, 4
	mul $t8, $t6, $t7
	add $t8, $t8, $t7
	add $v1, $t8, 4
	move $a0, $v1
	jal _halloc
	move $t9, $v0
	sw $t6, 0($t9)
	move $t2, $t9
	li $t3, 1
	li $t4, 0
B_initializeLL0:
	nop
	sle $t5, $t3, $t6
	beqz $t5, B_initializeLL1
	add $t2, $t2, $t7
	sw $t4, 0($t2)
	add $t3, $t3, 1
	j B_initializeLL0
B_initializeLL1:
	nop
	sw $t9, 8($t0)
	move $t8, $t1
	li $t5, 4
	mul $t6, $t8, $t5
	add $t6, $t6, $t5
	add $v1, $t6, 4
	move $a0, $v1
	jal _halloc
	move $t7, $v0
	sw $t8, 0($t7)
	move $t2, $t7
	li $t3, 1
	li $t4, 0
B_initializeLL2:
	nop
	sle $t9, $t3, $t8
	beqz $t9, B_initializeLL3
	add $t2, $t2, $t5
	sw $t4, 0($t2)
	add $t3, $t3, 1
	j B_initializeLL2
B_initializeLL3:
	nop
	sw $t7, 12($t0)
	move $t6, $t1
	li $t9, 4
	mul $t8, $t6, $t9
	add $t8, $t8, $t9
	add $v1, $t8, 4
	move $a0, $v1
	jal _halloc
	move $t5, $v0
	sw $t6, 0($t5)
	move $t2, $t5
	li $t3, 1
	li $t4, 0
B_initializeLL4:
	nop
	sle $t7, $t3, $t6
	beqz $t7, B_initializeLL5
	add $t2, $t2, $t9
	sw $t4, 0($t2)
	add $t3, $t3, 1
	j B_initializeLL4
B_initializeLL5:
	nop
	sw $t5, 4($t0)
	li $t1, 0
	move $t8, $t1
B_initializeLL6:
	nop
	move $t7, $t8
	lw $t6, 16($t0)
	sle $t9, $t7, $t6
	beqz $t9, B_initializeLL7
	lw $t2, 12($t0)
	move $t3, $t8
	li $t4, 4
	mul $t5, $t3, $t4
	add $t5, $t5, $t4
	add $t5, $t5, $t2
	li $t1, 0
	sw $t1, 0($t5)
	move $t7, $t8
	li $t6, 1
	add $t9, $t7, $t6
	move $t8, $t9
	j B_initializeLL6
B_initializeLL7:
	nop
	li $t3, 9999
	move $v0, $t3
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl B_makeGraph
B_makeGraph:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	lw $t1, 8($t0)
	li $t2, 1
	li $t3, 4
	mul $t4, $t2, $t3
	add $t4, $t4, $t3
	add $t4, $t4, $t1
	li $t5, 2
	sw $t5, 0($t4)
	lw $t6, 8($t0)
	li $t7, 2
	li $t8, 4
	mul $t9, $t7, $t8
	add $t9, $t9, $t8
	add $t9, $t9, $t6
	li $t2, 3
	sw $t2, 0($t9)
	lw $t3, 8($t0)
	li $t1, 3
	li $t4, 4
	mul $t5, $t1, $t4
	add $t5, $t5, $t4
	add $t5, $t5, $t3
	li $t7, 4
	sw $t7, 0($t5)
	lw $t8, 8($t0)
	li $t6, 4
	li $t9, 4
	mul $t2, $t6, $t9
	add $t2, $t2, $t9
	add $t2, $t2, $t8
	li $t1, 5
	sw $t1, 0($t2)
	lw $t4, 8($t0)
	li $t3, 5
	li $t5, 4
	mul $t7, $t3, $t5
	add $t7, $t7, $t5
	add $t7, $t7, $t4
	li $t6, 6
	sw $t6, 0($t7)
	lw $t9, 8($t0)
	li $t8, 6
	li $t2, 4
	mul $t1, $t8, $t2
	add $t1, $t1, $t2
	add $t1, $t1, $t9
	li $t3, 7
	sw $t3, 0($t1)
	lw $t5, 8($t0)
	li $t4, 7
	li $t7, 4
	mul $t6, $t4, $t7
	add $t6, $t6, $t7
	add $t6, $t6, $t5
	li $t8, 8
	sw $t8, 0($t6)
	lw $t2, 8($t0)
	li $t9, 8
	li $t1, 4
	mul $t3, $t9, $t1
	add $t3, $t3, $t1
	add $t3, $t3, $t2
	li $t4, 9
	sw $t4, 0($t3)
	lw $t7, 8($t0)
	li $t5, 9
	li $t6, 4
	mul $t8, $t5, $t6
	add $t8, $t8, $t6
	add $t8, $t8, $t7
	li $t9, 10
	sw $t9, 0($t8)
	lw $t1, 8($t0)
	li $t2, 10
	li $t3, 4
	mul $t4, $t2, $t3
	add $t4, $t4, $t3
	add $t4, $t4, $t1
	li $t5, 1
	sw $t5, 0($t4)
	li $t6, 9999
	move $v0, $t6
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl B_dfs
B_dfs:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 48
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	lw $t3, 12($t0)
	move $t4, $t1
	li $t5, 4
	mul $t6, $t4, $t5
	add $t6, $t6, $t5
	add $t6, $t6, $t3
	li $t7, 1
	sw $t7, 0($t6)
	lw $t8, 4($t0)
	move $t9, $t1
	li $t4, 4
	mul $t5, $t9, $t4
	add $t5, $t5, $t4
	add $t5, $t5, $t8
	move $t3, $t2
	sw $t3, 0($t5)
	move $t6, $t1
	move $a0, $t6
	jal _print
	lw $t7, 8($t0)
	move $t9, $t1
	li $t4, 4
	mul $t8, $t9, $t4
	add $t8, $t8, $t4
	add $t8, $t8, $t7
	lw $t5, 0($t8)
	move $t3, $t5
	lw $t6, 12($t0)
	move $t1, $t3
	li $t9, 4
	mul $t4, $t1, $t9
	add $t4, $t4, $t9
	add $t4, $t4, $t6
	lw $t7, 0($t4)
	li $t8, 0
	sne $t5, $t7, $t8
	li $t1, 1
	sub $t9, $t1, $t5
	beqz $t9, B_dfsLL8
	lw $t6, 0($t0)
	lw $t4, 12($t6)
	move $t7, $t3
	li $t8, 1
	move $t5, $t2
	sub $t1, $t8, $t5
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
	move $a1, $t7
	move $a2, $t1
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
	move $t9, $v0
	move $t6, $t9
B_dfsLL8:
	nop
	li $t3, 9999
	move $v0, $t3
	addu $sp, $sp, 48
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl B_printColors
B_printColors:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	li $t1, 1
	move $t2, $t1
B_printColorsLL9:
	nop
	move $t3, $t2
	lw $t4, 16($t0)
	sle $t5, $t3, $t4
	beqz $t5, B_printColorsLL10
	lw $t6, 4($t0)
	move $t7, $t2
	li $t8, 4
	mul $t9, $t7, $t8
	add $t9, $t9, $t8
	add $t9, $t9, $t6
	lw $t1, 0($t9)
	move $a0, $t1
	jal _print
	move $t3, $t2
	li $t4, 1
	add $t5, $t3, $t4
	move $t2, $t5
	j B_printColorsLL9
B_printColorsLL10:
	nop
	li $t7, 9999
	move $v0, $t7
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
