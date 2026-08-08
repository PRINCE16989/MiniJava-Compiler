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
	la $t2, NotTest_ved_TestNot
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
	.globl NotTest_ved_TestNot
NotTest_ved_TestNot:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $t0, 1
	move $t1, $t0
	sne $t2, $t1, 1
	beqz $t2, NotTest_ved_TestNotLL1
	li $t3, 100
	move $t4, $t3
	j NotTest_ved_TestNotLL2
NotTest_ved_TestNotLL1:
	nop
	li $t5, 200
	move $t4, $t5
NotTest_ved_TestNotLL2:
	nop
	move $a0, $t4
	jal _print
	li $t6, 5
	li $t7, 3
	sle $t8, $t6, $t7
	sne $t9, $t8, 1
	beqz $t9, NotTest_ved_TestNotLL3
	li $t0, 300
	move $t4, $t0
	j NotTest_ved_TestNotLL4
NotTest_ved_TestNotLL3:
	nop
	li $t2, 400
	move $t4, $t2
NotTest_ved_TestNotLL4:
	nop
	move $a0, $t4
	jal _print
	sne $t3, $t1, 1
	sne $t5, $t3, 1
	beqz $t5, NotTest_ved_TestNotLL5
	li $t6, 500
	move $t4, $t6
	j NotTest_ved_TestNotLL6
NotTest_ved_TestNotLL5:
	nop
	li $t7, 600
	move $t4, $t7
NotTest_ved_TestNotLL6:
	nop
	move $a0, $t4
	jal _print
	li $t8, 0
	move $v0, $t8
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
