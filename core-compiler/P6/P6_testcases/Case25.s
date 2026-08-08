	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 44
	li $a0, 16
	jal _halloc
	move $t0, $v0
	li $a0, 8
	jal _halloc
	move $t1, $v0
	sw $t1, 0($t0)
	la $t2, BoolFieldTest_ved_TestBoolField
	sw $t2, 0($t1)
	li $t3, 0
	sw $t3, 4($t0)
	li $t4, 0
	sw $t4, 8($t0)
	lw $t5, 0($t0)
	lw $t6, 0($t5)
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
	move $t7, $v0
	move $a0, $t7
	jal _print
	addu $sp, $sp, 44
	lw $ra, -4($fp)
	j $ra

	.text
	.globl BoolFieldTest_ved_TestBoolField
BoolFieldTest_ved_TestBoolField:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	li $t1, 1
	move $t2, $t0
	sw $t1, 4($t2)
	li $t3, 0
	move $t4, $t0
	sw $t3, 8($t4)
	lw $t5, 4($t0)
	beqz $t5, BoolFieldTest_ved_TestBoolFieldLL1
	li $t6, 100
	move $t7, $t0
	sw $t6, 8($t7)
	j BoolFieldTest_ved_TestBoolFieldLL2
BoolFieldTest_ved_TestBoolFieldLL1:
	nop
	li $t8, 200
	move $t9, $t0
	sw $t8, 8($t9)
BoolFieldTest_ved_TestBoolFieldLL2:
	nop
	lw $t1, 8($t0)
	move $a0, $t1
	jal _print
	li $t2, 0
	move $t3, $t0
	sw $t2, 4($t3)
	lw $t4, 4($t0)
	beqz $t4, BoolFieldTest_ved_TestBoolFieldLL3
	li $t5, 300
	move $t6, $t0
	sw $t5, 8($t6)
	j BoolFieldTest_ved_TestBoolFieldLL4
BoolFieldTest_ved_TestBoolFieldLL3:
	nop
	li $t7, 400
	move $t8, $t0
	sw $t7, 8($t8)
BoolFieldTest_ved_TestBoolFieldLL4:
	nop
	lw $t9, 8($t0)
	move $a0, $t9
	jal _print
	li $t1, 0
	move $v0, $t1
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
