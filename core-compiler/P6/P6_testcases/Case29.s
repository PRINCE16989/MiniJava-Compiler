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
	la $t2, ObjectParamTest_ved_TestObjectParam
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
	.globl ObjectParamTest_ved_TestObjectParam
ObjectParamTest_ved_TestObjectParam:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 56
	sw $s0, -12($fp)
	sw $s1, -16($fp)
	li $a0, 16
	jal _halloc
	move $t0, $v0
	li $a0, 16
	jal _halloc
	move $t1, $v0
	sw $t1, 0($t0)
	la $t2, Point_ved_SetCoords
	sw $t2, 0($t1)
	la $t3, Point_ved_GetX
	sw $t3, 4($t1)
	la $t4, Point_ved_GetY
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
	la $t9, Printer_ved_PrintPoint
	sw $t9, 0($t8)
	move $s1, $t7
	li $t2, 10
	li $t3, 20
	lw $t1, 0($s0)
	lw $t4, 0($t1)
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
	move $a1, $t2
	move $a2, $t3
	jalr $t4
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
	move $t5, $v0
	move $t6, $t5
	lw $t0, 0($s1)
	lw $t8, 0($t0)
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
	move $a0, $s1
	move $a1, $s0
	jalr $t8
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
	move $t9, $v0
	move $t6, $t9
	li $t7, 0
	move $v0, $t7
	lw $s1, -16($fp)
	lw $s0, -12($fp)
	addu $sp, $sp, 56
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Point_ved_SetCoords
Point_ved_SetCoords:
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
	.globl Point_ved_GetX
Point_ved_GetX:
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
	.globl Point_ved_GetY
Point_ved_GetY:
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
	.globl Printer_ved_PrintPoint
Printer_ved_PrintPoint:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 56
	sw $s0, -12($fp)
	sw $s1, -16($fp)
	move $s0, $a1
	lw $t0, 0($s0)
	lw $t1, 4($t0)
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
	jalr $t1
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
	move $t2, $v0
	move $s1, $t2
	lw $t3, 0($s0)
	lw $t4, 8($t3)
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
	jalr $t4
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
	move $t5, $v0
	move $t6, $t5
	move $a0, $s1
	jal _print
	move $a0, $t6
	jal _print
	li $t7, 0
	move $v0, $t7
	lw $s1, -16($fp)
	lw $s0, -12($fp)
	addu $sp, $sp, 56
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
