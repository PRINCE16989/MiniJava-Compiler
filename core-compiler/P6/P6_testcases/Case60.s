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
	la $t2, Ack_ack
	sw $t2, 0($t1)
	sw $t1, 0($t0)
	move $t3, $t0
	lw $t4, 0($t3)
	lw $t5, 0($t4)
	move $t6, $t5
	li $t7, 3
	li $t8, 2
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
	move $t9, $v0
	move $a0, $t9
	jal _print
	addu $sp, $sp, 44
	lw $ra, -4($fp)
	j $ra

	.text
	.globl Ack_ack
Ack_ack:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 60
	sw $s0, -12($fp)
	sw $s1, -16($fp)
	sw $s2, -20($fp)
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	li $t3, 1
	sne $t4, $t1, 0
	sub $t5, $t3, $t4
	beqz $t5, Ack_ackLL0
	add $t6, $t2, 1
	j Ack_ackLL1
Ack_ackLL0:
	li $t7, 1
	li $t8, 0
	sle $t9, $t1, 0
	beqz $t9, Ack_ackLL2
	li $t3, 1
	sne $t4, $t2, 0
	sub $t5, $t3, $t4
	beqz $t5, Ack_ackLL2
	li $t8, 1
Ack_ackLL2:
	nop
	move $t9, $t8
	sub $t3, $t7, $t9
	beqz $t3, Ack_ackLL3
	move $t4, $t0
	lw $t5, 0($t4)
	lw $t8, 0($t5)
	move $t7, $t8
	sub $t9, $t1, 1
	li $t3, 1
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
	move $a0, $t4
	move $a1, $t9
	move $a2, $t3
	jalr $t7
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
	move $t6, $v0
	j Ack_ackLL4
Ack_ackLL3:
	li $t5, 1
	li $t8, 0
	sle $t4, $t1, 0
	beqz $t4, Ack_ackLL5
	li $t7, 1
	sle $t9, $t2, 0
	sub $t3, $t7, $t9
	beqz $t3, Ack_ackLL5
	li $t8, 1
Ack_ackLL5:
	nop
	move $t4, $t8
	sub $t7, $t5, $t4
	beqz $t7, Ack_ackLL6
	move $s0, $t0
	lw $t9, 0($s0)
	lw $t3, 0($t9)
	move $s1, $t3
	sub $s2, $t1, 1
	move $t8, $t0
	lw $t5, 0($t8)
	lw $t4, 0($t5)
	move $t7, $t4
	sub $t9, $t2, 1
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
	move $a0, $t8
	move $a1, $t1
	move $a2, $t9
	jalr $t7
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
	move $t3, $v0
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
	move $a0, $s0
	move $a1, $s2
	move $a2, $t3
	jalr $s1
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
	move $t6, $v0
	j Ack_ackLL7
Ack_ackLL6:
	li $t6, 0
Ack_ackLL7:
	nop
Ack_ackLL4:
	nop
Ack_ackLL1:
	nop
	move $v0, $t6
	lw $s2, -20($fp)
	lw $s1, -16($fp)
	lw $s0, -12($fp)
	addu $sp, $sp, 60
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
