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
	la $t2, MultiVar_ved_TestMultiVar
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
	.globl MultiVar_ved_TestMultiVar
MultiVar_ved_TestMultiVar:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 24
	sw $s0, -12($fp)
	sw $s1, -16($fp)
	sw $s2, -20($fp)
	sw $s3, -24($fp)
	li $t0, 10
	move $t1, $t0
	li $t2, 20
	move $t3, $t2
	li $t4, 30
	move $t5, $t4
	li $t6, 1
	move $t7, $t6
	li $t8, 0
	move $t9, $t8
	li $t0, 2
	li $t2, 4
	li $t4, 1
	add $t6, $t4, $t0
	mul $t8, $t2, $t6
	add $v1, $t8, 4
	move $a0, $v1
	jal _halloc
	move $t4, $v0
	sw $t0, 0($t4)
	li $t2, 1
MultiVar_ved_TestMultiVarLL1:
	nop
	li $t6, 1
	add $t8, $t6, $t0
	sne $t6, $t2, $t8
	beqz $t6, MultiVar_ved_TestMultiVarLL2
	li $t8, 4
	mul $t6, $t8, $t2
	add $t8, $t4, $t6
	li $t6, 0
	sw $t6, 0($t8)
	li $t8, 1
	add $t2, $t8, $t2
	j MultiVar_ved_TestMultiVarLL1
MultiVar_ved_TestMultiVarLL2:
	nop
	move $t6, $t4
	li $t8, 3
	li $t0, 4
	li $t2, 1
	add $t4, $t2, $t8
	mul $t2, $t0, $t4
	add $v1, $t2, 4
	move $a0, $v1
	jal _halloc
	move $t0, $v0
	sw $t8, 0($t0)
	li $t4, 1
MultiVar_ved_TestMultiVarLL3:
	nop
	li $t2, 1
	add $s0, $t2, $t8
	sne $t2, $t4, $s0
	beqz $t2, MultiVar_ved_TestMultiVarLL4
	li $t2, 4
	mul $s1, $t2, $t4
	add $t2, $t0, $s1
	li $s2, 0
	sw $s2, 0($t2)
	li $t2, 1
	add $t4, $t2, $t4
	j MultiVar_ved_TestMultiVarLL3
MultiVar_ved_TestMultiVarLL4:
	nop
	move $t2, $t0
	li $t8, 0
	li $t4, 4
	li $t0, 1
	add $s3, $t0, $t8
	mul $t8, $t4, $s3
	add $t0, $t6, $t8
	sw $t1, 0($t0)
	li $t4, 1
	li $t8, 4
	li $t1, 1
	add $t0, $t1, $t4
	mul $t4, $t8, $t0
	add $t1, $t6, $t4
	sw $t3, 0($t1)
	li $t8, 0
	li $t0, 4
	li $t4, 1
	add $t3, $t4, $t8
	mul $t1, $t0, $t3
	add $t8, $t2, $t1
	sw $t5, 0($t8)
	li $t4, 0
	li $t0, 4
	li $t3, 1
	add $t1, $t3, $t4
	mul $t5, $t0, $t1
	add $t8, $t6, $t5
	lw $t4, 0($t8)
	move $t3, $t4
	li $t0, 0
	li $t1, 4
	li $t6, 1
	add $t5, $t6, $t0
	mul $t8, $t1, $t5
	add $t4, $t2, $t8
	lw $t0, 0($t4)
	move $t6, $t0
	add $t1, $t3, $t6
	move $t5, $t1
	move $a0, $t5
	jal _print
	sne $t2, $t9, 1
	add $t8, $t7, $t2
	sne $t4, $t8, 2
	li $t0, 1
	sne $t4, $t0, $t4
	beqz $t4, MultiVar_ved_TestMultiVarLL5
	li $t3, 1
	move $a0, $t3
	jal _print
	j MultiVar_ved_TestMultiVarLL6
MultiVar_ved_TestMultiVarLL5:
	nop
	li $t6, 0
	move $a0, $t6
	jal _print
MultiVar_ved_TestMultiVarLL6:
	nop
	li $t1, 0
	move $v0, $t1
	lw $s3, -24($fp)
	lw $s2, -20($fp)
	lw $s1, -16($fp)
	lw $s0, -12($fp)
	addu $sp, $sp, 24
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
