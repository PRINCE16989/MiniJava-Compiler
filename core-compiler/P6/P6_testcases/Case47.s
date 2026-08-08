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
	la $t2, CompareAssign_ved_TestCompare
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
	.globl CompareAssign_ved_TestCompare
CompareAssign_ved_TestCompare:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $t0, 10
	move $t1, $t0
	li $t2, 20
	move $t3, $t2
	sle $t4, $t1, $t3
	move $t5, $t4
	beqz $t5, CompareAssign_ved_TestCompareLL1
	li $t6, 1
	move $a0, $t6
	jal _print
	j CompareAssign_ved_TestCompareLL2
CompareAssign_ved_TestCompareLL1:
	nop
	li $t7, 0
	move $a0, $t7
	jal _print
CompareAssign_ved_TestCompareLL2:
	nop
	sle $t8, $t3, $t1
	move $t5, $t8
	beqz $t5, CompareAssign_ved_TestCompareLL3
	li $t9, 1
	move $a0, $t9
	jal _print
	j CompareAssign_ved_TestCompareLL4
CompareAssign_ved_TestCompareLL3:
	nop
	li $t0, 0
	move $a0, $t0
	jal _print
CompareAssign_ved_TestCompareLL4:
	nop
	sne $t2, $t1, $t3
	move $t5, $t2
	beqz $t5, CompareAssign_ved_TestCompareLL5
	li $t4, 1
	move $a0, $t4
	jal _print
	j CompareAssign_ved_TestCompareLL6
CompareAssign_ved_TestCompareLL5:
	nop
	li $t6, 0
	move $a0, $t6
	jal _print
CompareAssign_ved_TestCompareLL6:
	nop
	li $t7, 0
	move $v0, $t7
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
