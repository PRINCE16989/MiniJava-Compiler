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
	la $t2, FieldArg_ved_TestFieldArg
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
	.globl FieldArg_ved_TestFieldArg
FieldArg_ved_TestFieldArg:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 60
	sw $s0, -12($fp)
	sw $s1, -16($fp)
	sw $s2, -20($fp)
	li $a0, 16
	jal _halloc
	move $t0, $v0
	li $a0, 16
	jal _halloc
	move $t1, $v0
	sw $t1, 0($t0)
	la $t2, Data_ved_Initialize
	sw $t2, 0($t1)
	la $t3, Data_ved_GetX
	sw $t3, 4($t1)
	la $t4, Data_ved_GetY
	sw $t4, 8($t1)
	li $t5, 0
	sw $t5, 4($t0)
	li $t6, 0
	sw $t6, 8($t0)
	move $s0, $t0
	li $a0, 8
	jal _halloc
	move $t7, $v0
	li $a0, 8
	jal _halloc
	move $t8, $v0
	sw $t8, 0($t7)
	la $t9, Processor_ved_ProcessData
	sw $t9, 0($t8)
	move $s1, $t7
	li $t2, 100
	li $t3, 200
	lw $t1, 0($s0)
	lw $t4, 0($t1)
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
	move $a1, $t2
	move $a2, $t3
	jalr $t4
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
	move $t5, $v0
	move $t6, $t5
	lw $t0, 0($s0)
	lw $t8, 4($t0)
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
	jalr $t8
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
	move $s2, $v0
	lw $t9, 0($s0)
	lw $t7, 8($t9)
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
	move $t1, $v0
	lw $t2, 0($s1)
	lw $t3, 0($t2)
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
	move $a0, $s1
	move $a1, $s2
	move $a2, $t1
	jalr $t3
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
	move $t4, $v0
	move $t6, $t4
	move $a0, $t6
	jal _print
	li $t5, 0
	move $v0, $t5
	lw $s2, -20($fp)
	lw $s1, -16($fp)
	lw $s0, -12($fp)
	addu $sp, $sp, 60
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Data_ved_Initialize
Data_ved_Initialize:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	move $t3, $t0
	sw $t1, 4($t3)
	move $t4, $t0
	sw $t2, 8($t4)
	li $t5, 0
	move $v0, $t5
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Data_ved_GetX
Data_ved_GetX:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	lw $t1, 4($t0)
	move $v0, $t1
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Data_ved_GetY
Data_ved_GetY:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	lw $t1, 8($t0)
	move $v0, $t1
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Processor_ved_ProcessData
Processor_ved_ProcessData:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a1
	move $t1, $a2
	add $t2, $t0, $t1
	move $v0, $t2
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
