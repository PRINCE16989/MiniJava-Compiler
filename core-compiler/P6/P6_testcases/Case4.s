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
	la $t2, LogicalOps_ved_TestLogical
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
	.globl LogicalOps_ved_TestLogical
LogicalOps_ved_TestLogical:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	li $t0, 1
	move $t1, $t0
	li $t2, 0
	move $t3, $t2
	add $t4, $t1, $t3
	sne $t5, $t4, 2
	li $t6, 1
	sne $t5, $t6, $t5
	beqz $t5, LogicalOps_ved_TestLogicalLL1
	li $t7, 1
	move $t8, $t7
	j LogicalOps_ved_TestLogicalLL2
LogicalOps_ved_TestLogicalLL1:
	nop
	li $t9, 0
	move $t8, $t9
LogicalOps_ved_TestLogicalLL2:
	nop
	move $a0, $t8
	jal _print
	add $t0, $t1, $t3
	sne $t2, $t0, 0
	beqz $t2, LogicalOps_ved_TestLogicalLL3
	li $t4, 1
	move $t8, $t4
	j LogicalOps_ved_TestLogicalLL4
LogicalOps_ved_TestLogicalLL3:
	nop
	li $t6, 0
	move $t8, $t6
LogicalOps_ved_TestLogicalLL4:
	nop
	move $a0, $t8
	jal _print
	sne $t5, $t1, 1
	beqz $t5, LogicalOps_ved_TestLogicalLL5
	li $t7, 1
	move $t8, $t7
	j LogicalOps_ved_TestLogicalLL6
LogicalOps_ved_TestLogicalLL5:
	nop
	li $t9, 0
	move $t8, $t9
LogicalOps_ved_TestLogicalLL6:
	nop
	move $a0, $t8
	jal _print
	sne $t0, $t3, 1
	beqz $t0, LogicalOps_ved_TestLogicalLL7
	li $t2, 1
	move $t8, $t2
	j LogicalOps_ved_TestLogicalLL8
LogicalOps_ved_TestLogicalLL7:
	nop
	li $t4, 0
	move $t8, $t4
LogicalOps_ved_TestLogicalLL8:
	nop
	move $a0, $t8
	jal _print
	li $t6, 0
	move $v0, $t6
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
