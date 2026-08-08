	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 44
	li $t0, 8
	add $v1, $t0, 4
	move $a0, $v1
	jal _halloc
	move $t1, $v0
	la $t2, A_method
	sw $t2, 0($t1)
	la $t3, A_calcMod
	sw $t3, 4($t1)
	li $t4, 4
	add $v1, $t4, 4
	move $a0, $v1
	jal _halloc
	move $t5, $v0
	sw $t1, 0($t5)
	move $t6, $t5
	lw $t7, 0($t6)
	lw $t8, 0($t7)
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
	move $a0, $t9
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
	subu $sp, $sp, 72
	sw $s0, -12($fp)
	sw $s1, -16($fp)
	sw $s2, -20($fp)
	sw $s3, -24($fp)
	sw $s4, -28($fp)
	sw $s5, -32($fp)
	move $s0, $a0
	li $t0, 4
	add $v1, $t0, 4
	move $a0, $v1
	jal _halloc
	move $t1, $v0
	la $t2, B_printMe
	sw $t2, 0($t1)
	li $t3, 4
	add $v1, $t3, 4
	move $a0, $v1
	jal _halloc
	move $t4, $v0
	sw $t1, 0($t4)
	move $t5, $t4
	move $s1, $t5
	li $t6, 4
	add $v1, $t6, 4
	move $a0, $v1
	jal _halloc
	move $t7, $v0
	la $t8, C_printMe
	sw $t8, 0($t7)
	li $t9, 4
	add $v1, $t9, 4
	move $a0, $v1
	jal _halloc
	move $t0, $v0
	sw $t7, 0($t0)
	move $t2, $t0
	move $s2, $t2
	li $t3, 4
	add $v1, $t3, 4
	move $a0, $v1
	jal _halloc
	move $t1, $v0
	la $t4, D_printMe
	sw $t4, 0($t1)
	li $t5, 4
	add $v1, $t5, 4
	move $a0, $v1
	jal _halloc
	move $t6, $v0
	sw $t1, 0($t6)
	move $t8, $t6
	move $s3, $t8
	li $t9, 0
	move $s4, $t9
	li $t7, 0
	move $s5, $t7
A_methodLL0:
	nop
	lw $t0, 0($s0)
	lw $t2, 4($t0)
	move $t3, $s4
	li $t4, 3
	sw $t0, -36($fp)
	sw $t1, -40($fp)
	sw $t2, -44($fp)
	sw $t3, -48($fp)
	sw $t4, -52($fp)
	sw $t5, -56($fp)
	sw $t6, -60($fp)
	sw $t7, -64($fp)
	sw $t8, -68($fp)
	sw $t9, -72($fp)
	move $a0, $s0
	move $a1, $t3
	move $a2, $t4
	jalr $t2
	lw $t0, -36($fp)
	lw $t1, -40($fp)
	lw $t2, -44($fp)
	lw $t3, -48($fp)
	lw $t4, -52($fp)
	lw $t5, -56($fp)
	lw $t6, -60($fp)
	lw $t7, -64($fp)
	lw $t8, -68($fp)
	lw $t9, -72($fp)
	move $t5, $v0
	li $t1, 0
	sne $t6, $t5, $t1
	li $t8, 1
	sub $t9, $t8, $t6
	beqz $t9, A_methodLL1
	move $t7, $s1
	lw $t0, 0($t7)
	lw $t2, 0($t0)
	move $t3, $s4
	move $t4, $s4
	mul $t5, $t3, $t4
	li $t1, 107
	move $t6, $s4
	sub $t8, $t1, $t6
	li $t9, 1
	sw $t0, -36($fp)
	sw $t1, -40($fp)
	sw $t2, -44($fp)
	sw $t3, -48($fp)
	sw $t4, -52($fp)
	sw $t5, -56($fp)
	sw $t6, -60($fp)
	sw $t7, -64($fp)
	sw $t8, -68($fp)
	sw $t9, -72($fp)
	move $a0, $t7
	move $a1, $t5
	move $a2, $t8
	move $a3, $t9
	jalr $t2
	lw $t0, -36($fp)
	lw $t1, -40($fp)
	lw $t2, -44($fp)
	lw $t3, -48($fp)
	lw $t4, -52($fp)
	lw $t5, -56($fp)
	lw $t6, -60($fp)
	lw $t7, -64($fp)
	lw $t8, -68($fp)
	lw $t9, -72($fp)
	move $t0, $v0
	move $s5, $t0
	j A_methodLL2
A_methodLL1:
	nop
	lw $t3, 0($s0)
	lw $t4, 4($t3)
	move $t1, $s4
	li $t6, 3
	sw $t0, -36($fp)
	sw $t1, -40($fp)
	sw $t2, -44($fp)
	sw $t3, -48($fp)
	sw $t4, -52($fp)
	sw $t5, -56($fp)
	sw $t6, -60($fp)
	sw $t7, -64($fp)
	sw $t8, -68($fp)
	sw $t9, -72($fp)
	move $a0, $s0
	move $a1, $t1
	move $a2, $t6
	jalr $t4
	lw $t0, -36($fp)
	lw $t1, -40($fp)
	lw $t2, -44($fp)
	lw $t3, -48($fp)
	lw $t4, -52($fp)
	lw $t5, -56($fp)
	lw $t6, -60($fp)
	lw $t7, -64($fp)
	lw $t8, -68($fp)
	lw $t9, -72($fp)
	move $t7, $v0
	li $t2, 1
	sne $t5, $t7, $t2
	li $t8, 1
	sub $t9, $t8, $t5
	beqz $t9, A_methodLL3
	move $t0, $s2
	lw $t3, 0($t0)
	lw $t4, 0($t3)
	move $t1, $s4
	li $t6, 5
	mul $t7, $t1, $t6
	li $t2, 121
	move $t5, $s4
	sub $t8, $t2, $t5
	li $t9, 0
	sw $t0, -36($fp)
	sw $t1, -40($fp)
	sw $t2, -44($fp)
	sw $t3, -48($fp)
	sw $t4, -52($fp)
	sw $t5, -56($fp)
	sw $t6, -60($fp)
	sw $t7, -64($fp)
	sw $t8, -68($fp)
	sw $t9, -72($fp)
	move $a0, $t0
	move $a1, $t7
	move $a2, $t8
	move $a3, $t9
	jalr $t4
	lw $t0, -36($fp)
	lw $t1, -40($fp)
	lw $t2, -44($fp)
	lw $t3, -48($fp)
	lw $t4, -52($fp)
	lw $t5, -56($fp)
	lw $t6, -60($fp)
	lw $t7, -64($fp)
	lw $t8, -68($fp)
	lw $t9, -72($fp)
	move $t3, $v0
	move $s5, $t3
	j A_methodLL4
A_methodLL3:
	nop
	lw $t1, 0($s0)
	lw $t6, 4($t1)
	move $t2, $s4
	li $t5, 3
	sw $t0, -36($fp)
	sw $t1, -40($fp)
	sw $t2, -44($fp)
	sw $t3, -48($fp)
	sw $t4, -52($fp)
	sw $t5, -56($fp)
	sw $t6, -60($fp)
	sw $t7, -64($fp)
	sw $t8, -68($fp)
	sw $t9, -72($fp)
	move $a0, $s0
	move $a1, $t2
	move $a2, $t5
	jalr $t6
	lw $t0, -36($fp)
	lw $t1, -40($fp)
	lw $t2, -44($fp)
	lw $t3, -48($fp)
	lw $t4, -52($fp)
	lw $t5, -56($fp)
	lw $t6, -60($fp)
	lw $t7, -64($fp)
	lw $t8, -68($fp)
	lw $t9, -72($fp)
	move $t0, $v0
	li $t4, 2
	sne $t7, $t0, $t4
	li $t8, 1
	sub $t9, $t8, $t7
	beqz $t9, A_methodLL5
	move $t3, $s3
	lw $t1, 0($t3)
	lw $t6, 0($t1)
	move $t2, $s4
	move $t5, $s4
	mul $t0, $t2, $t5
	li $t4, 131
	move $t7, $s4
	add $t8, $t4, $t7
	li $t9, 0
	sw $t0, -36($fp)
	sw $t1, -40($fp)
	sw $t2, -44($fp)
	sw $t3, -48($fp)
	sw $t4, -52($fp)
	sw $t5, -56($fp)
	sw $t6, -60($fp)
	sw $t7, -64($fp)
	sw $t8, -68($fp)
	sw $t9, -72($fp)
	move $a0, $t3
	move $a1, $t0
	move $a2, $t8
	move $a3, $t9
	jalr $t6
	lw $t0, -36($fp)
	lw $t1, -40($fp)
	lw $t2, -44($fp)
	lw $t3, -48($fp)
	lw $t4, -52($fp)
	lw $t5, -56($fp)
	lw $t6, -60($fp)
	lw $t7, -64($fp)
	lw $t8, -68($fp)
	lw $t9, -72($fp)
	move $t1, $v0
	move $s5, $t1
A_methodLL5:
	nop
A_methodLL4:
	nop
A_methodLL2:
	nop
	move $t2, $s5
	move $a0, $t2
	jal _print
	move $t5, $s4
	li $t4, 1
	add $t7, $t5, $t4
	move $s4, $t7
	move $t3, $s4
	li $t6, 100
	sle $t0, $t3, $t6
	beqz $t0, A_methodLL6
	j A_methodLL0
A_methodLL6:
	nop
	li $t8, 9999
	move $v0, $t8
	lw $s5, -32($fp)
	lw $s4, -28($fp)
	lw $s3, -24($fp)
	lw $s2, -20($fp)
	lw $s1, -16($fp)
	lw $s0, -12($fp)
	addu $sp, $sp, 72
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl A_calcMod
A_calcMod:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a1
	move $t1, $a2
	move $t2, $t0
	move $t3, $t0
	move $t4, $t1
	div $t5, $t3, $t4
	move $t6, $t1
	mul $t7, $t5, $t6
	sub $t8, $t2, $t7
	move $v0, $t8
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl B_printMe
B_printMe:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 48
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	move $t3, $a3
	move $t4, $t1
	move $a0, $t4
	jal _print
	move $t5, $t2
	move $a0, $t5
	jal _print
	move $t6, $t3
	beqz $t6, B_printMeLL7
	lw $t7, 0($t0)
	lw $t8, 0($t7)
	move $t9, $t1
	move $t4, $t2
	li $t5, 1
	add $t6, $t4, $t5
	move $t7, $t3
	li $t2, 1
	sub $t4, $t2, $t7
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
	move $a1, $t9
	move $a2, $t6
	move $a3, $t4
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
	move $t5, $v0
	move $t1, $t5
B_printMeLL7:
	nop
	move $t3, $t1
	li $t7, 123
	add $t2, $t3, $t7
	move $t1, $t2
	move $t0, $t1
	move $v0, $t0
	addu $sp, $sp, 48
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl C_printMe
C_printMe:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 48
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	move $t3, $a3
	move $t4, $t1
	move $a0, $t4
	jal _print
	move $t5, $t2
	move $a0, $t5
	jal _print
	move $t6, $t3
	beqz $t6, C_printMeLL8
	lw $t7, 0($t0)
	lw $t8, 0($t7)
	move $t9, $t1
	li $t4, 10
	mul $t5, $t9, $t4
	move $t6, $t2
	li $t7, 1
	sub $t9, $t6, $t7
	move $t4, $t3
	li $t2, 1
	sub $t6, $t2, $t4
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
	move $a1, $t5
	move $a2, $t9
	move $a3, $t6
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
	move $t7, $v0
	move $t1, $t7
C_printMeLL8:
	nop
	move $t3, $t1
	li $t4, 456
	add $t2, $t3, $t4
	move $t1, $t2
	move $t0, $t1
	move $v0, $t0
	addu $sp, $sp, 48
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl D_printMe
D_printMe:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 48
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	move $t3, $a3
	move $t4, $t1
	move $a0, $t4
	jal _print
	move $t5, $t2
	move $a0, $t5
	jal _print
	move $t6, $t3
	beqz $t6, D_printMeLL9
	lw $t7, 0($t0)
	lw $t8, 0($t7)
	move $t9, $t1
	li $t4, 3
	mul $t5, $t9, $t4
	move $t6, $t2
	li $t7, 100
	sub $t9, $t6, $t7
	move $t4, $t3
	li $t2, 1
	sub $t6, $t2, $t4
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
	move $a1, $t5
	move $a2, $t9
	move $a3, $t6
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
	move $t7, $v0
	move $t1, $t7
D_printMeLL9:
	nop
	move $t3, $t1
	li $t4, 999
	sub $t2, $t3, $t4
	move $t1, $t2
	move $t0, $t1
	move $v0, $t0
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
