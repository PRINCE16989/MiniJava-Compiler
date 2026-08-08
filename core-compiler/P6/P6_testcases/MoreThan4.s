	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 44
	li $v1, 8
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
	la $s2, MT4_Change
	sw $s2, 4($s0)
	la $s2, MT4_Start
	sw $s2, 0($s0)
	sw $s0, 0($s1)
	move $s1, $s1
	lw $s0, 0($s1)
	lw $s0, 0($s0)
	li $v1, 1
	move $s2, $v1
	li $v1, 2
	move $s3, $v1
	li $v1, 3
	move $s4, $v1
	li $v1, 4
	move $s5, $v1
	li $v1, 5
	move $s6, $v1
	li $v1, 6
	move $s7, $v1
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
	move $a2, $s3
	move $a3, $s4
	sw $s5, -12($sp)
	sw $s6, -16($sp)
	sw $s7, -20($sp)
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
	move $s7, $v0
	move $a0, $s7
	jal _print
	addu $sp, $sp, 44
	lw $ra, -4($fp)
	j $ra

	.text
	.globl MT4_Start
MT4_Start:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 92
	sw $s0, -24($fp)
	sw $s1, -28($fp)
	sw $s2, -32($fp)
	sw $s3, -36($fp)
	sw $s4, -40($fp)
	sw $s5, -44($fp)
	sw $s6, -48($fp)
	sw $s7, -52($fp)
	move $s0, $a0
	move $s1, $a1
	move $s2, $a2
	move $s3, $a3
	move $a0, $s1
	jal _print
	move $a0, $s2
	jal _print
	move $a0, $s3
	jal _print
	lw $v1, -12($fp)
	move $a0, $v1
	jal _print
	lw $v1, -16($fp)
	move $a0, $v1
	jal _print
	lw $v1, -20($fp)
	move $a0, $v1
	jal _print
	move $s0, $s0
	lw $s4, 0($s0)
	lw $s4, 4($s4)
	sw $t0, -56($fp)
	sw $t1, -60($fp)
	sw $t2, -64($fp)
	sw $t3, -68($fp)
	sw $t4, -72($fp)
	sw $t5, -76($fp)
	sw $t6, -80($fp)
	sw $t7, -84($fp)
	sw $t8, -88($fp)
	sw $t9, -92($fp)
	move $a0, $s0
	lw $v0, -20($fp)
	move $a1, $v0
	lw $v0, -16($fp)
	move $a2, $v0
	lw $v0, -12($fp)
	move $a3, $v0
	sw $s3, -12($sp)
	sw $s2, -16($sp)
	sw $s1, -20($sp)
	jalr $s4
	lw $t0, -56($fp)
	lw $t1, -60($fp)
	lw $t2, -64($fp)
	lw $t3, -68($fp)
	lw $t4, -72($fp)
	lw $t5, -76($fp)
	lw $t6, -80($fp)
	lw $t7, -84($fp)
	lw $t8, -88($fp)
	lw $t9, -92($fp)
	move $s4, $v0
	move $s4, $s4
	move $v0, $s4
	lw $s0, -24($fp)
	lw $s1, -28($fp)
	lw $s2, -32($fp)
	lw $s3, -36($fp)
	lw $s4, -40($fp)
	lw $s5, -44($fp)
	lw $s6, -48($fp)
	lw $s7, -52($fp)
	addu $sp, $sp, 92
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl MT4_Change
MT4_Change:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 52
	sw $s0, -24($fp)
	sw $s1, -28($fp)
	sw $s2, -32($fp)
	sw $s3, -36($fp)
	sw $s4, -40($fp)
	sw $s5, -44($fp)
	sw $s6, -48($fp)
	sw $s7, -52($fp)
	move $v1, $a0
	move $s0, $a1
	move $s1, $a2
	move $s2, $a3
	move $a0, $s0
	jal _print
	move $a0, $s1
	jal _print
	move $a0, $s2
	jal _print
	lw $v1, -12($fp)
	move $a0, $v1
	jal _print
	lw $v1, -16($fp)
	move $a0, $v1
	jal _print
	lw $v1, -20($fp)
	move $a0, $v1
	jal _print
	li $v1, 0
	move $s2, $v1
	move $v0, $s2
	lw $s0, -24($fp)
	lw $s1, -28($fp)
	lw $s2, -32($fp)
	lw $s3, -36($fp)
	lw $s4, -40($fp)
	lw $s5, -44($fp)
	lw $s6, -48($fp)
	lw $s7, -52($fp)
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
