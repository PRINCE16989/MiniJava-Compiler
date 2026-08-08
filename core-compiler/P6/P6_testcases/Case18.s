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
	sw $t1, 0($t0)
	la $t2, MultiObj_ved_TestMultiple
	sw $t2, 0($t1)
	lw $t3, 0($t0)
	lw $t4, 0($t3)
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
	move $a0, $t5
	jal _print
	addu $sp, $sp, 44
	lw $ra, -4($fp)
	j $ra

	.text
	.globl MultiObj_ved_TestMultiple
MultiObj_ved_TestMultiple:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 56
	sw $s0, -12($fp)
	sw $s1, -16($fp)
	li $a0, 12
	jal _halloc
	move $t0, $v0
	li $a0, 8
	jal _halloc
	move $t1, $v0
	sw $t1, 0($t0)
	la $t2, Counter_ved_SetAndGet
	sw $t2, 0($t1)
	li $t3, 0
	sw $t3, 4($t0)
	move $t4, $t0
	li $a0, 12
	jal _halloc
	move $t5, $v0
	li $a0, 8
	jal _halloc
	move $t6, $v0
	sw $t6, 0($t5)
	la $t7, Counter_ved_SetAndGet
	sw $t7, 0($t6)
	li $t8, 0
	sw $t8, 4($t5)
	move $s0, $t5
	li $t9, 10
	lw $t1, 0($t4)
	lw $t2, 0($t1)
	sw $t0, -20($fp)
	sw $t1, -24($fp)
	sw $t2, -28($fp)
	sw $t3, -32($fp)
	sw $t4, -36($fp)
	sw $t5, -40($fp)
	sw $t6, -44($fp)
	sw $t7, -48($fp)
	sw $t8, -52($fp)
	sw $t9, -56($fp)
	move $a0, $t4
	move $a1, $t9
	jalr $t2
	lw $t0, -20($fp)
	lw $t1, -24($fp)
	lw $t2, -28($fp)
	lw $t3, -32($fp)
	lw $t4, -36($fp)
	lw $t5, -40($fp)
	lw $t6, -44($fp)
	lw $t7, -48($fp)
	lw $t8, -52($fp)
	lw $t9, -56($fp)
	move $t3, $v0
	move $s1, $t3
	li $t0, 20
	lw $t6, 0($s0)
	lw $t7, 0($t6)
	sw $t0, -20($fp)
	sw $t1, -24($fp)
	sw $t2, -28($fp)
	sw $t3, -32($fp)
	sw $t4, -36($fp)
	sw $t5, -40($fp)
	sw $t6, -44($fp)
	sw $t7, -48($fp)
	sw $t8, -52($fp)
	sw $t9, -56($fp)
	move $a0, $s0
	move $a1, $t0
	jalr $t7
	lw $t0, -20($fp)
	lw $t1, -24($fp)
	lw $t2, -28($fp)
	lw $t3, -32($fp)
	lw $t4, -36($fp)
	lw $t5, -40($fp)
	lw $t6, -44($fp)
	lw $t7, -48($fp)
	lw $t8, -52($fp)
	lw $t9, -56($fp)
	move $t8, $v0
	move $t5, $t8
	move $a0, $s1
	jal _print
	move $a0, $t5
	jal _print
	li $t1, 0
	move $v0, $t1
	lw $s1, -16($fp)
	lw $s0, -12($fp)
	addu $sp, $sp, 56
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Counter_ved_SetAndGet
Counter_ved_SetAndGet:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	move $t1, $a1
	move $t2, $t0
	sw $t1, 4($t2)
	lw $t3, 4($t0)
	move $v0, $t3
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
