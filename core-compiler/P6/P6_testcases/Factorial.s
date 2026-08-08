	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 44
	li $v1, 4
	move $s0, $v1
	move $a0, $s0
	jal _halloc
	move $s0, $v0
	move $s0, $s0
	li $v1, 4
	move $s1, $v1
	move $a0, $s1
	jal _halloc
	move $s1, $v0
	move $s1, $s1
	la $s2, Fac_ComputeFac
	sw $s2, 0($s0)
	sw $s0, 0($s1)
	move $s1, $s1
	lw $s0, 0($s1)
	lw $s0, 0($s0)
	li $v1, 10
	move $s2, $v1
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
	move $a0, $s1
	move $a1, $s2
	jalr $s0
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
	move $s2, $v0
	move $a0, $s2
	jal _print
	addu $sp, $sp, 44
	lw $ra, -4($fp)
	j $ra

	.text
	.globl Fac_ComputeFac
Fac_ComputeFac:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 80
	sw $s0, -12($fp)
	sw $s1, -16($fp)
	sw $s2, -20($fp)
	sw $s3, -24($fp)
	sw $s4, -28($fp)
	sw $s5, -32($fp)
	sw $s6, -36($fp)
	sw $s7, -40($fp)
	move $s0, $a0
	move $s1, $a1
	li $v1, 0
	move $s2, $v1
	sle $s2, $s1, $s2
	beqz $s2, L2
	li $v1, 1
	move $s0, $v1
	move $s0, $s0
	j L3
L2:
	move $s2, $s0
	lw $s3, 0($s2)
	lw $s3, 0($s3)
	li $v1, 1
	move $s4, $v1
	sub $s4, $s1, $s4
	sw $t0, -44($fp)
	sw $t1, -48($fp)
	sw $t2, -52($fp)
	sw $t3, -56($fp)
	sw $t4, -60($fp)
	sw $t5, -64($fp)
	sw $t6, -68($fp)
	sw $t7, -72($fp)
	sw $t8, -76($fp)
	sw $t9, -80($fp)
	move $a0, $s2
	move $a1, $s4
	jalr $s3
	lw $t0, -44($fp)
	lw $t1, -48($fp)
	lw $t2, -52($fp)
	lw $t3, -56($fp)
	lw $t4, -60($fp)
	lw $t5, -64($fp)
	lw $t6, -68($fp)
	lw $t7, -72($fp)
	lw $t8, -76($fp)
	lw $t9, -80($fp)
	move $s4, $v0
	mul $s4, $s1, $s4
	move $s0, $s4
L3:
	nop
	move $v0, $s0
	lw $s0, -12($fp)
	lw $s1, -16($fp)
	lw $s2, -20($fp)
	lw $s3, -24($fp)
	lw $s4, -28($fp)
	lw $s5, -32($fp)
	lw $s6, -36($fp)
	lw $s7, -40($fp)
	addu $sp, $sp, 80
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
