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
	li $t0, 8
	add $v1, $t0, 4
	move $a0, $v1
	jal _halloc
	move $t1, $v0
	la $t2, B_initialize
	sw $t2, 0($t1)
	la $t3, B_printMe
	sw $t3, 4($t1)
	li $t4, 12
	add $v1, $t4, 4
	move $a0, $v1
	jal _halloc
	move $t5, $v0
	sw $t1, 0($t5)
	li $t6, 0
	sw $t6, 4($t5)
	li $t7, 0
	sw $t7, 8($t5)
	move $t8, $t5
	move $s1, $t8
	li $t9, 8
	add $v1, $t9, 4
	move $a0, $v1
	jal _halloc
	move $t0, $v0
	la $t2, B_initialize
	sw $t2, 0($t0)
	la $t3, C_printMe
	sw $t3, 4($t0)
	li $t4, 12
	add $v1, $t4, 4
	move $a0, $v1
	jal _halloc
	move $t1, $v0
	sw $t0, 0($t1)
	li $t6, 0
	sw $t6, 4($t1)
	li $t7, 0
	sw $t7, 8($t1)
	move $t5, $t1
	move $s2, $t5
	li $t8, 8
	add $v1, $t8, 4
	move $a0, $v1
	jal _halloc
	move $t9, $v0
	la $t2, B_initialize
	sw $t2, 0($t9)
	la $t3, D_printMe
	sw $t3, 4($t9)
	li $t4, 12
	add $v1, $t4, 4
	move $a0, $v1
	jal _halloc
	move $t0, $v0
	sw $t9, 0($t0)
	li $t6, 0
	sw $t6, 4($t0)
	li $t7, 0
	sw $t7, 8($t0)
	move $t1, $t0
	move $s3, $t1
	move $t5, $s1
	lw $t8, 0($t5)
	lw $t2, 0($t8)
	li $t3, 100
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
	move $a0, $t5
	move $a1, $t3
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
	move $t4, $v0
	move $t9, $t4
	move $t6, $s2
	lw $t7, 0($t6)
	lw $t0, 0($t7)
	li $t1, 100
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
	move $a0, $t6
	move $a1, $t1
	jalr $t0
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
	move $t8, $v0
	move $t9, $t8
	move $t5, $s3
	lw $t2, 0($t5)
	lw $t3, 0($t2)
	li $t4, 100
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
	move $a0, $t5
	move $a1, $t4
	jalr $t3
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
	move $t9, $t7
	li $t6, 0
	move $s4, $t6
	li $t0, 0
	move $s5, $t0
A_methodLL0:
	nop
	lw $t1, 0($s0)
	lw $t8, 4($t1)
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
	jalr $t8
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
	li $t4, 0
	sne $t9, $t3, $t4
	li $t7, 1
	sub $t6, $t7, $t9
	beqz $t6, A_methodLL1
	move $t0, $s1
	lw $t1, 0($t0)
	lw $t8, 4($t1)
	li $t2, 0
	li $t5, 20
	li $t3, 1
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
	move $a1, $t2
	move $a2, $t5
	move $a3, $t3
	jalr $t8
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
	move $t4, $v0
	move $s5, $t4
	j A_methodLL2
A_methodLL1:
	nop
	lw $t9, 0($s0)
	lw $t7, 4($t9)
	move $t6, $s4
	li $t1, 3
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
	move $a1, $t6
	move $a2, $t1
	jalr $t7
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
	li $t8, 1
	sne $t2, $t0, $t8
	li $t5, 1
	sub $t3, $t5, $t2
	beqz $t3, A_methodLL3
	move $t4, $s2
	lw $t9, 0($t4)
	lw $t7, 4($t9)
	li $t6, 50
	li $t1, 70
	li $t0, 0
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
	move $a0, $t4
	move $a1, $t6
	move $a2, $t1
	move $a3, $t0
	jalr $t7
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
	move $t8, $v0
	move $s5, $t8
	j A_methodLL4
A_methodLL3:
	nop
	lw $t2, 0($s0)
	lw $t5, 4($t2)
	move $t3, $s4
	li $t9, 3
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
	move $a2, $t9
	jalr $t5
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
	move $t4, $v0
	li $t7, 2
	sne $t6, $t4, $t7
	li $t1, 1
	sub $t0, $t1, $t6
	beqz $t0, A_methodLL5
	move $t8, $s3
	lw $t2, 0($t8)
	lw $t5, 4($t2)
	li $t3, 30
	li $t9, 40
	li $t4, 0
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
	move $a0, $t8
	move $a1, $t3
	move $a2, $t9
	move $a3, $t4
	jalr $t5
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
	move $s5, $t7
A_methodLL5:
	nop
A_methodLL4:
	nop
A_methodLL2:
	nop
	move $t6, $s5
	move $a0, $t6
	jal _print
	move $t1, $s4
	li $t0, 1
	add $t2, $t1, $t0
	move $s4, $t2
	move $t8, $s4
	li $t5, 100
	sle $t3, $t8, $t5
	beqz $t3, A_methodLL6
	j A_methodLL0
A_methodLL6:
	nop
	li $t9, 9999
	move $v0, $t9
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
	.globl B_initialize
B_initialize:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	move $t1, $a1
	move $t2, $t1
	li $t3, 4
	mul $t4, $t2, $t3
	add $t4, $t4, $t3
	add $v1, $t4, 4
	move $a0, $v1
	jal _halloc
	move $t5, $v0
	sw $t2, 0($t5)
	move $t6, $t5
	li $t7, 1
	li $t8, 0
B_initializeLL7:
	nop
	sle $t9, $t7, $t2
	beqz $t9, B_initializeLL8
	add $t6, $t6, $t3
	sw $t8, 0($t6)
	add $t7, $t7, 1
	j B_initializeLL7
B_initializeLL8:
	nop
	sw $t5, 8($t0)
	move $t4, $t1
	li $t9, 1
	sub $t2, $t4, $t9
	sw $t2, 4($t0)
	li $t3, 0
	move $t6, $t3
B_initializeLL9:
	nop
	move $t7, $t6
	lw $t8, 4($t0)
	sle $t5, $t7, $t8
	beqz $t5, B_initializeLL10
	lw $t1, 8($t0)
	move $t4, $t6
	li $t9, 4
	mul $t2, $t4, $t9
	add $t2, $t2, $t9
	add $t2, $t2, $t1
	li $t3, 2
	move $t7, $t6
	mul $t8, $t3, $t7
	sw $t8, 0($t2)
	move $t5, $t6
	li $t4, 1
	add $t9, $t5, $t4
	move $t6, $t9
	j B_initializeLL9
B_initializeLL10:
	nop
	li $t1, 9999
	move $v0, $t1
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
	subu $sp, $sp, 8
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	move $t3, $t1
	move $a0, $t3
	jal _print
	move $t4, $t2
	move $a0, $t4
	jal _print
	move $t5, $t1
	move $t6, $t5
	li $t7, 0
	move $t8, $t7
B_printMeLL11:
	nop
	move $t9, $t6
	move $t3, $t2
	sle $t4, $t9, $t3
	beqz $t4, B_printMeLL12
	lw $t5, 8($t0)
	move $t7, $t6
	li $t9, 4
	mul $t3, $t7, $t9
	add $t3, $t3, $t9
	add $t3, $t3, $t5
	lw $t4, 8($t0)
	move $t7, $t6
	li $t9, 4
	mul $t5, $t7, $t9
	add $t5, $t5, $t9
	add $t5, $t5, $t4
	lw $t7, 0($t5)
	move $t9, $t2
	move $t4, $t1
	sub $t5, $t9, $t4
	add $t9, $t7, $t5
	sw $t9, 0($t3)
	lw $t4, 8($t0)
	move $t7, $t6
	li $t5, 4
	mul $t3, $t7, $t5
	add $t3, $t3, $t5
	add $t3, $t3, $t4
	lw $t9, 0($t3)
	move $a0, $t9
	jal _print
	move $t7, $t8
	lw $t5, 8($t0)
	move $t4, $t6
	li $t3, 4
	mul $t9, $t4, $t3
	add $t9, $t9, $t3
	add $t9, $t9, $t5
	lw $t4, 0($t9)
	add $t3, $t7, $t4
	move $t8, $t3
	move $t5, $t6
	li $t9, 1
	add $t7, $t5, $t9
	move $t6, $t7
	j B_printMeLL11
B_printMeLL12:
	nop
	move $t4, $t8
	move $v0, $t4
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl C_printMe
C_printMe:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	move $t3, $t1
	move $a0, $t3
	jal _print
	move $t4, $t2
	move $a0, $t4
	jal _print
	move $t5, $t1
	move $t6, $t5
	li $t7, 0
	move $t8, $t7
C_printMeLL13:
	nop
	move $t9, $t6
	move $t3, $t2
	sle $t4, $t9, $t3
	beqz $t4, C_printMeLL14
	lw $t5, 8($t0)
	move $t7, $t6
	li $t9, 4
	mul $t3, $t7, $t9
	add $t3, $t3, $t9
	add $t3, $t3, $t5
	lw $t4, 8($t0)
	move $t7, $t6
	li $t9, 4
	mul $t5, $t7, $t9
	add $t5, $t5, $t9
	add $t5, $t5, $t4
	lw $t7, 0($t5)
	move $t9, $t2
	move $t4, $t1
	sub $t5, $t9, $t4
	add $t9, $t7, $t5
	sw $t9, 0($t3)
	lw $t4, 8($t0)
	move $t7, $t6
	li $t5, 4
	mul $t3, $t7, $t5
	add $t3, $t3, $t5
	add $t3, $t3, $t4
	lw $t9, 0($t3)
	move $a0, $t9
	jal _print
	move $t7, $t8
	lw $t5, 8($t0)
	move $t4, $t6
	li $t3, 4
	mul $t9, $t4, $t3
	add $t9, $t9, $t3
	add $t9, $t9, $t5
	lw $t4, 0($t9)
	add $t3, $t7, $t4
	move $t8, $t3
	move $t5, $t6
	li $t9, 1
	add $t7, $t5, $t9
	move $t6, $t7
	j C_printMeLL13
C_printMeLL14:
	nop
	move $t4, $t8
	move $v0, $t4
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl D_printMe
D_printMe:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	move $t3, $t1
	move $a0, $t3
	jal _print
	move $t4, $t2
	move $a0, $t4
	jal _print
	move $t5, $t1
	move $t6, $t5
	li $t7, 0
	move $t8, $t7
D_printMeLL15:
	nop
	move $t9, $t6
	move $t3, $t2
	sle $t4, $t9, $t3
	beqz $t4, D_printMeLL16
	lw $t5, 8($t0)
	move $t7, $t6
	li $t9, 4
	mul $t3, $t7, $t9
	add $t3, $t3, $t9
	add $t3, $t3, $t5
	lw $t4, 8($t0)
	move $t7, $t6
	li $t9, 4
	mul $t5, $t7, $t9
	add $t5, $t5, $t9
	add $t5, $t5, $t4
	lw $t7, 0($t5)
	move $t9, $t2
	move $t4, $t1
	sub $t5, $t9, $t4
	add $t9, $t7, $t5
	sw $t9, 0($t3)
	lw $t4, 8($t0)
	move $t7, $t6
	li $t5, 4
	mul $t3, $t7, $t5
	add $t3, $t3, $t5
	add $t3, $t3, $t4
	lw $t9, 0($t3)
	move $a0, $t9
	jal _print
	move $t7, $t8
	lw $t5, 8($t0)
	move $t4, $t6
	li $t3, 4
	mul $t9, $t4, $t3
	add $t9, $t9, $t3
	add $t9, $t9, $t5
	lw $t4, 0($t9)
	add $t3, $t7, $t4
	move $t8, $t3
	move $t5, $t6
	li $t9, 1
	add $t7, $t5, $t9
	move $t6, $t7
	j D_printMeLL15
D_printMeLL16:
	nop
	move $t4, $t8
	move $v0, $t4
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
