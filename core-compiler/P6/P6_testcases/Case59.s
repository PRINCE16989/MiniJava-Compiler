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
	la $t2, InheritFieldTest_ved_TestInheritFields
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
	.globl InheritFieldTest_ved_TestInheritFields
InheritFieldTest_ved_TestInheritFields:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 48
	li $a0, 20
	jal _halloc
	move $t0, $v0
	li $a0, 12
	jal _halloc
	move $t1, $v0
	sw $t1, 0($t0)
	la $t2, Parent_ved_m0
	sw $t2, 0($t1)
	la $t3, Parent_ved_SetData
	sw $t3, 4($t1)
	li $t4, 0
	sw $t4, 4($t0)
	li $t5, 0
	sw $t5, 8($t0)
	li $t6, 0
	sw $t6, 12($t0)
	move $t7, $t0
	li $t8, 1
	li $t9, 2
	lw $t2, 0($t7)
	lw $t1, 4($t2)
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
	move $a0, $t7
	move $a1, $t8
	move $a2, $t9
	jalr $t1
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
	move $t3, $v0
	move $t4, $t3
	move $a0, $t4
	jal _print
	li $a0, 32
	jal _halloc
	move $t5, $v0
	li $a0, 16
	jal _halloc
	move $t6, $v0
	sw $t6, 0($t5)
	la $t0, Parent_ved_m0
	sw $t0, 0($t6)
	la $t2, C1_ved_SetData
	sw $t2, 4($t6)
	la $t8, C1_ved_m1
	sw $t8, 8($t6)
	li $t9, 0
	sw $t9, 4($t5)
	li $t1, 0
	sw $t1, 8($t5)
	li $t3, 0
	sw $t3, 12($t5)
	li $t0, 0
	sw $t0, 16($t5)
	li $t2, 0
	sw $t2, 20($t5)
	li $t6, 0
	sw $t6, 24($t5)
	move $t7, $t5
	li $t8, 3
	li $t9, 4
	lw $t1, 0($t7)
	lw $t3, 4($t1)
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
	move $a0, $t7
	move $a1, $t8
	move $a2, $t9
	jalr $t3
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
	move $t0, $v0
	move $t4, $t0
	move $a0, $t4
	jal _print
	li $a0, 44
	jal _halloc
	move $t2, $v0
	li $a0, 20
	jal _halloc
	move $t6, $v0
	sw $t6, 0($t2)
	la $t5, Parent_ved_m0
	sw $t5, 0($t6)
	la $t1, C2_ved_SetData
	sw $t1, 4($t6)
	la $t8, C1_ved_m1
	sw $t8, 8($t6)
	la $t9, C2_ved_m2
	sw $t9, 12($t6)
	li $t3, 0
	sw $t3, 4($t2)
	li $t0, 0
	sw $t0, 8($t2)
	li $t5, 0
	sw $t5, 12($t2)
	li $t1, 0
	sw $t1, 16($t2)
	li $t8, 0
	sw $t8, 20($t2)
	li $t6, 0
	sw $t6, 24($t2)
	li $t9, 0
	sw $t9, 28($t2)
	li $t3, 0
	sw $t3, 32($t2)
	li $t0, 0
	sw $t0, 36($t2)
	move $t7, $t2
	li $t5, 4
	li $t1, 5
	lw $t8, 0($t7)
	lw $t6, 4($t8)
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
	move $a0, $t7
	move $a1, $t5
	move $a2, $t1
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
	move $t9, $v0
	move $t4, $t9
	move $a0, $t4
	jal _print
	li $a0, 56
	jal _halloc
	move $t3, $v0
	li $a0, 24
	jal _halloc
	move $t0, $v0
	sw $t0, 0($t3)
	la $t2, Parent_ved_m0
	sw $t2, 0($t0)
	la $t8, C3_ved_SetData
	sw $t8, 4($t0)
	la $t5, C1_ved_m1
	sw $t5, 8($t0)
	la $t1, C2_ved_m2
	sw $t1, 12($t0)
	la $t6, C3_ved_m3
	sw $t6, 16($t0)
	li $t9, 0
	sw $t9, 4($t3)
	li $t2, 0
	sw $t2, 8($t3)
	li $t8, 0
	sw $t8, 12($t3)
	li $t5, 0
	sw $t5, 16($t3)
	li $t1, 0
	sw $t1, 20($t3)
	li $t0, 0
	sw $t0, 24($t3)
	li $t6, 0
	sw $t6, 28($t3)
	li $t9, 0
	sw $t9, 32($t3)
	li $t2, 0
	sw $t2, 36($t3)
	li $t8, 0
	sw $t8, 40($t3)
	li $t5, 0
	sw $t5, 44($t3)
	li $t1, 0
	sw $t1, 48($t3)
	move $t7, $t3
	li $t0, 5
	li $t6, 6
	lw $t9, 0($t7)
	lw $t2, 4($t9)
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
	move $a0, $t7
	move $a1, $t0
	move $a2, $t6
	jalr $t2
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
	move $t8, $v0
	move $t4, $t8
	move $a0, $t4
	jal _print
	li $t5, 0
	move $v0, $t5
	addu $sp, $sp, 48
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Parent_ved_m0
Parent_ved_m0:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	lw $t1, 4($t0)
	lw $t2, 8($t0)
	add $t3, $t1, $t2
	move $a0, $t3
	jal _print
	li $t4, 0
	move $v0, $t4
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl Parent_ved_SetData
Parent_ved_SetData:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 52
	sw $s0, -12($fp)
	move $s0, $a0
	move $t0, $a1
	move $t1, $a2
	move $t2, $s0
	sw $t0, 4($t2)
	move $t3, $s0
	sw $t1, 8($t3)
	lw $t4, 0($s0)
	lw $t5, 0($t4)
	sw $t0, -16($fp)
	sw $t1, -20($fp)
	sw $t2, -24($fp)
	sw $t3, -28($fp)
	sw $t4, -32($fp)
	sw $t5, -36($fp)
	sw $t6, -40($fp)
	sw $t7, -44($fp)
	sw $t8, -48($fp)
	sw $t9, -52($fp)
	move $a0, $s0
	jalr $t5
	lw $t0, -16($fp)
	lw $t1, -20($fp)
	lw $t2, -24($fp)
	lw $t3, -28($fp)
	lw $t4, -32($fp)
	lw $t5, -36($fp)
	lw $t6, -40($fp)
	lw $t7, -44($fp)
	lw $t8, -48($fp)
	lw $t9, -52($fp)
	move $t6, $v0
	move $t7, $t6
	li $a0, 32
	jal _halloc
	move $t8, $v0
	li $a0, 16
	jal _halloc
	move $t9, $v0
	sw $t9, 0($t8)
	la $t0, Parent_ved_m0
	sw $t0, 0($t9)
	la $t2, C1_ved_SetData
	sw $t2, 4($t9)
	la $t1, C1_ved_m1
	sw $t1, 8($t9)
	li $t3, 0
	sw $t3, 4($t8)
	li $t4, 0
	sw $t4, 8($t8)
	li $t5, 0
	sw $t5, 12($t8)
	li $t6, 0
	sw $t6, 16($t8)
	li $t0, 0
	sw $t0, 20($t8)
	li $t2, 0
	sw $t2, 24($t8)
	move $t9, $s0
	sw $t8, 12($t9)
	lw $t1, 12($s0)
	lw $t3, 0($t1)
	lw $t4, 8($t3)
	sw $t0, -16($fp)
	sw $t1, -20($fp)
	sw $t2, -24($fp)
	sw $t3, -28($fp)
	sw $t4, -32($fp)
	sw $t5, -36($fp)
	sw $t6, -40($fp)
	sw $t7, -44($fp)
	sw $t8, -48($fp)
	sw $t9, -52($fp)
	move $a0, $t1
	jalr $t4
	lw $t0, -16($fp)
	lw $t1, -20($fp)
	lw $t2, -24($fp)
	lw $t3, -28($fp)
	lw $t4, -32($fp)
	lw $t5, -36($fp)
	lw $t6, -40($fp)
	lw $t7, -44($fp)
	lw $t8, -48($fp)
	lw $t9, -52($fp)
	move $t5, $v0
	move $t7, $t5
	li $t6, 0
	move $v0, $t6
	lw $s0, -12($fp)
	addu $sp, $sp, 52
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl C1_ved_m1
C1_ved_m1:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 52
	sw $s0, -12($fp)
	move $s0, $a0
	lw $t0, 16($s0)
	li $t1, 0
	sne $t2, $t0, $t1
	sne $t3, $t2, 1
	beqz $t3, C1_ved_m1LL1
	lw $t4, 16($s0)
	li $t5, 1
	add $t6, $t4, $t5
	move $t7, $s0
	sw $t6, 16($t7)
C1_ved_m1LL1:
	nop
	lw $t8, 20($s0)
	li $t9, 0
	sne $t0, $t8, $t9
	sne $t1, $t0, 1
	beqz $t1, C1_ved_m1LL2
	lw $t2, 20($s0)
	li $t3, 2
	add $t4, $t2, $t3
	move $t5, $s0
	sw $t4, 20($t5)
C1_ved_m1LL2:
	nop
	lw $t6, 0($s0)
	lw $t7, 0($t6)
	sw $t0, -16($fp)
	sw $t1, -20($fp)
	sw $t2, -24($fp)
	sw $t3, -28($fp)
	sw $t4, -32($fp)
	sw $t5, -36($fp)
	sw $t6, -40($fp)
	sw $t7, -44($fp)
	sw $t8, -48($fp)
	sw $t9, -52($fp)
	move $a0, $s0
	jalr $t7
	lw $t0, -16($fp)
	lw $t1, -20($fp)
	lw $t2, -24($fp)
	lw $t3, -28($fp)
	lw $t4, -32($fp)
	lw $t5, -36($fp)
	lw $t6, -40($fp)
	lw $t7, -44($fp)
	lw $t8, -48($fp)
	lw $t9, -52($fp)
	move $t8, $v0
	move $t9, $t8
	lw $t0, 4($s0)
	lw $t1, 16($s0)
	lw $t2, 20($s0)
	add $t3, $t1, $t2
	add $t4, $t0, $t3
	move $a0, $t4
	jal _print
	li $t5, 0
	move $v0, $t5
	lw $s0, -12($fp)
	addu $sp, $sp, 52
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl C1_ved_SetData
C1_ved_SetData:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 52
	sw $s0, -12($fp)
	move $s0, $a0
	move $t0, $a1
	move $t1, $a2
	li $t2, 10000
	move $t3, $s0
	sw $t2, 4($t3)
	move $t4, $s0
	sw $t0, 16($t4)
	move $t5, $s0
	sw $t1, 20($t5)
	lw $t6, 0($s0)
	lw $t7, 8($t6)
	sw $t0, -16($fp)
	sw $t1, -20($fp)
	sw $t2, -24($fp)
	sw $t3, -28($fp)
	sw $t4, -32($fp)
	sw $t5, -36($fp)
	sw $t6, -40($fp)
	sw $t7, -44($fp)
	sw $t8, -48($fp)
	sw $t9, -52($fp)
	move $a0, $s0
	jalr $t7
	lw $t0, -16($fp)
	lw $t1, -20($fp)
	lw $t2, -24($fp)
	lw $t3, -28($fp)
	lw $t4, -32($fp)
	lw $t5, -36($fp)
	lw $t6, -40($fp)
	lw $t7, -44($fp)
	lw $t8, -48($fp)
	lw $t9, -52($fp)
	move $t8, $v0
	move $t9, $t8
	li $a0, 44
	jal _halloc
	move $t2, $v0
	li $a0, 20
	jal _halloc
	move $t3, $v0
	sw $t3, 0($t2)
	la $t0, Parent_ved_m0
	sw $t0, 0($t3)
	la $t4, C2_ved_SetData
	sw $t4, 4($t3)
	la $t1, C1_ved_m1
	sw $t1, 8($t3)
	la $t5, C2_ved_m2
	sw $t5, 12($t3)
	li $t6, 0
	sw $t6, 4($t2)
	li $t7, 0
	sw $t7, 8($t2)
	li $t8, 0
	sw $t8, 12($t2)
	li $t0, 0
	sw $t0, 16($t2)
	li $t4, 0
	sw $t4, 20($t2)
	li $t1, 0
	sw $t1, 24($t2)
	li $t3, 0
	sw $t3, 28($t2)
	li $t5, 0
	sw $t5, 32($t2)
	li $t6, 0
	sw $t6, 36($t2)
	move $t7, $s0
	sw $t2, 24($t7)
	lw $t8, 24($s0)
	lw $t0, 0($t8)
	lw $t4, 12($t0)
	sw $t0, -16($fp)
	sw $t1, -20($fp)
	sw $t2, -24($fp)
	sw $t3, -28($fp)
	sw $t4, -32($fp)
	sw $t5, -36($fp)
	sw $t6, -40($fp)
	sw $t7, -44($fp)
	sw $t8, -48($fp)
	sw $t9, -52($fp)
	move $a0, $t8
	jalr $t4
	lw $t0, -16($fp)
	lw $t1, -20($fp)
	lw $t2, -24($fp)
	lw $t3, -28($fp)
	lw $t4, -32($fp)
	lw $t5, -36($fp)
	lw $t6, -40($fp)
	lw $t7, -44($fp)
	lw $t8, -48($fp)
	lw $t9, -52($fp)
	move $t1, $v0
	move $t9, $t1
	li $t3, 1
	move $v0, $t3
	lw $s0, -12($fp)
	addu $sp, $sp, 52
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl C2_ved_m2
C2_ved_m2:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 52
	sw $s0, -12($fp)
	move $s0, $a0
	lw $t0, 0($s0)
	lw $t1, 0($t0)
	sw $t0, -16($fp)
	sw $t1, -20($fp)
	sw $t2, -24($fp)
	sw $t3, -28($fp)
	sw $t4, -32($fp)
	sw $t5, -36($fp)
	sw $t6, -40($fp)
	sw $t7, -44($fp)
	sw $t8, -48($fp)
	sw $t9, -52($fp)
	move $a0, $s0
	jalr $t1
	lw $t0, -16($fp)
	lw $t1, -20($fp)
	lw $t2, -24($fp)
	lw $t3, -28($fp)
	lw $t4, -32($fp)
	lw $t5, -36($fp)
	lw $t6, -40($fp)
	lw $t7, -44($fp)
	lw $t8, -48($fp)
	lw $t9, -52($fp)
	move $t2, $v0
	move $t3, $t2
	lw $t4, 4($s0)
	lw $t5, 16($s0)
	lw $t6, 28($s0)
	lw $t7, 32($s0)
	add $t8, $t6, $t7
	add $t9, $t5, $t8
	add $t0, $t4, $t9
	move $a0, $t0
	jal _print
	li $t1, 0
	move $v0, $t1
	lw $s0, -12($fp)
	addu $sp, $sp, 52
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl C2_ved_SetData
C2_ved_SetData:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 52
	sw $s0, -12($fp)
	move $s0, $a0
	move $t0, $a1
	move $t1, $a2
	li $t2, 1000
	move $t3, $s0
	sw $t2, 4($t3)
	li $t4, 2000
	move $t5, $s0
	sw $t4, 16($t5)
	move $t6, $s0
	sw $t0, 28($t6)
	move $t7, $s0
	sw $t1, 32($t7)
	lw $t8, 0($s0)
	lw $t9, 12($t8)
	sw $t0, -16($fp)
	sw $t1, -20($fp)
	sw $t2, -24($fp)
	sw $t3, -28($fp)
	sw $t4, -32($fp)
	sw $t5, -36($fp)
	sw $t6, -40($fp)
	sw $t7, -44($fp)
	sw $t8, -48($fp)
	sw $t9, -52($fp)
	move $a0, $s0
	jalr $t9
	lw $t0, -16($fp)
	lw $t1, -20($fp)
	lw $t2, -24($fp)
	lw $t3, -28($fp)
	lw $t4, -32($fp)
	lw $t5, -36($fp)
	lw $t6, -40($fp)
	lw $t7, -44($fp)
	lw $t8, -48($fp)
	lw $t9, -52($fp)
	move $t2, $v0
	move $t3, $t2
	li $a0, 56
	jal _halloc
	move $t4, $v0
	li $a0, 24
	jal _halloc
	move $t5, $v0
	sw $t5, 0($t4)
	la $t0, Parent_ved_m0
	sw $t0, 0($t5)
	la $t6, C3_ved_SetData
	sw $t6, 4($t5)
	la $t1, C1_ved_m1
	sw $t1, 8($t5)
	la $t7, C2_ved_m2
	sw $t7, 12($t5)
	la $t8, C3_ved_m3
	sw $t8, 16($t5)
	li $t9, 0
	sw $t9, 4($t4)
	li $t2, 0
	sw $t2, 8($t4)
	li $t0, 0
	sw $t0, 12($t4)
	li $t6, 0
	sw $t6, 16($t4)
	li $t1, 0
	sw $t1, 20($t4)
	li $t7, 0
	sw $t7, 24($t4)
	li $t5, 0
	sw $t5, 28($t4)
	li $t8, 0
	sw $t8, 32($t4)
	li $t9, 0
	sw $t9, 36($t4)
	li $t2, 0
	sw $t2, 40($t4)
	li $t0, 0
	sw $t0, 44($t4)
	li $t6, 0
	sw $t6, 48($t4)
	move $t1, $s0
	sw $t4, 36($t1)
	lw $t7, 36($s0)
	lw $t5, 0($t7)
	lw $t8, 16($t5)
	sw $t0, -16($fp)
	sw $t1, -20($fp)
	sw $t2, -24($fp)
	sw $t3, -28($fp)
	sw $t4, -32($fp)
	sw $t5, -36($fp)
	sw $t6, -40($fp)
	sw $t7, -44($fp)
	sw $t8, -48($fp)
	sw $t9, -52($fp)
	move $a0, $t7
	jalr $t8
	lw $t0, -16($fp)
	lw $t1, -20($fp)
	lw $t2, -24($fp)
	lw $t3, -28($fp)
	lw $t4, -32($fp)
	lw $t5, -36($fp)
	lw $t6, -40($fp)
	lw $t7, -44($fp)
	lw $t8, -48($fp)
	lw $t9, -52($fp)
	move $t9, $v0
	move $t3, $t9
	li $t2, 2
	move $v0, $t2
	lw $s0, -12($fp)
	addu $sp, $sp, 52
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl C3_ved_m3
C3_ved_m3:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 52
	sw $s0, -12($fp)
	move $s0, $a0
	lw $t0, 0($s0)
	lw $t1, 8($t0)
	sw $t0, -16($fp)
	sw $t1, -20($fp)
	sw $t2, -24($fp)
	sw $t3, -28($fp)
	sw $t4, -32($fp)
	sw $t5, -36($fp)
	sw $t6, -40($fp)
	sw $t7, -44($fp)
	sw $t8, -48($fp)
	sw $t9, -52($fp)
	move $a0, $s0
	jalr $t1
	lw $t0, -16($fp)
	lw $t1, -20($fp)
	lw $t2, -24($fp)
	lw $t3, -28($fp)
	lw $t4, -32($fp)
	lw $t5, -36($fp)
	lw $t6, -40($fp)
	lw $t7, -44($fp)
	lw $t8, -48($fp)
	lw $t9, -52($fp)
	move $t2, $v0
	move $t3, $t2
	lw $t4, 4($s0)
	lw $t5, 16($s0)
	lw $t6, 28($s0)
	lw $t7, 40($s0)
	lw $t8, 44($s0)
	add $t9, $t7, $t8
	add $t0, $t6, $t9
	add $t1, $t5, $t0
	add $t2, $t4, $t1
	move $a0, $t2
	jal _print
	li $t3, 0
	move $v0, $t3
	lw $s0, -12($fp)
	addu $sp, $sp, 52
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl C3_ved_SetData
C3_ved_SetData:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 52
	sw $s0, -12($fp)
	move $s0, $a0
	move $t0, $a1
	move $t1, $a2
	li $t2, 100
	move $t3, $s0
	sw $t2, 4($t3)
	li $t4, 200
	move $t5, $s0
	sw $t4, 16($t5)
	li $t6, 300
	move $t7, $s0
	sw $t6, 28($t7)
	move $t8, $s0
	sw $t0, 40($t8)
	move $t9, $s0
	sw $t1, 44($t9)
	lw $t2, 0($s0)
	lw $t3, 16($t2)
	sw $t0, -16($fp)
	sw $t1, -20($fp)
	sw $t2, -24($fp)
	sw $t3, -28($fp)
	sw $t4, -32($fp)
	sw $t5, -36($fp)
	sw $t6, -40($fp)
	sw $t7, -44($fp)
	sw $t8, -48($fp)
	sw $t9, -52($fp)
	move $a0, $s0
	jalr $t3
	lw $t0, -16($fp)
	lw $t1, -20($fp)
	lw $t2, -24($fp)
	lw $t3, -28($fp)
	lw $t4, -32($fp)
	lw $t5, -36($fp)
	lw $t6, -40($fp)
	lw $t7, -44($fp)
	lw $t8, -48($fp)
	lw $t9, -52($fp)
	move $t4, $v0
	move $t5, $t4
	li $a0, 64
	jal _halloc
	move $t6, $v0
	li $a0, 28
	jal _halloc
	move $t7, $v0
	sw $t7, 0($t6)
	la $t0, Parent_ved_m0
	sw $t0, 0($t7)
	la $t8, C4_ved_SetData
	sw $t8, 4($t7)
	la $t1, C1_ved_m1
	sw $t1, 8($t7)
	la $t9, C2_ved_m2
	sw $t9, 12($t7)
	la $t2, C3_ved_m3
	sw $t2, 16($t7)
	la $t3, C4_ved_m4
	sw $t3, 20($t7)
	li $t4, 0
	sw $t4, 4($t6)
	li $t0, 0
	sw $t0, 8($t6)
	li $t8, 0
	sw $t8, 12($t6)
	li $t1, 0
	sw $t1, 16($t6)
	li $t9, 0
	sw $t9, 20($t6)
	li $t2, 0
	sw $t2, 24($t6)
	li $t7, 0
	sw $t7, 28($t6)
	li $t3, 0
	sw $t3, 32($t6)
	li $t4, 0
	sw $t4, 36($t6)
	li $t0, 0
	sw $t0, 40($t6)
	li $t8, 0
	sw $t8, 44($t6)
	li $t1, 0
	sw $t1, 48($t6)
	li $t9, 0
	sw $t9, 52($t6)
	li $t2, 0
	sw $t2, 56($t6)
	move $t7, $s0
	sw $t6, 48($t7)
	lw $t3, 48($s0)
	lw $t4, 0($t3)
	lw $t0, 20($t4)
	sw $t0, -16($fp)
	sw $t1, -20($fp)
	sw $t2, -24($fp)
	sw $t3, -28($fp)
	sw $t4, -32($fp)
	sw $t5, -36($fp)
	sw $t6, -40($fp)
	sw $t7, -44($fp)
	sw $t8, -48($fp)
	sw $t9, -52($fp)
	move $a0, $t3
	jalr $t0
	lw $t0, -16($fp)
	lw $t1, -20($fp)
	lw $t2, -24($fp)
	lw $t3, -28($fp)
	lw $t4, -32($fp)
	lw $t5, -36($fp)
	lw $t6, -40($fp)
	lw $t7, -44($fp)
	lw $t8, -48($fp)
	lw $t9, -52($fp)
	move $t8, $v0
	move $t5, $t8
	li $t1, 3
	move $v0, $t1
	lw $s0, -12($fp)
	addu $sp, $sp, 52
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl C4_ved_m4
C4_ved_m4:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 52
	sw $s0, -12($fp)
	move $s0, $a0
	lw $t0, 0($s0)
	lw $t1, 12($t0)
	sw $t0, -16($fp)
	sw $t1, -20($fp)
	sw $t2, -24($fp)
	sw $t3, -28($fp)
	sw $t4, -32($fp)
	sw $t5, -36($fp)
	sw $t6, -40($fp)
	sw $t7, -44($fp)
	sw $t8, -48($fp)
	sw $t9, -52($fp)
	move $a0, $s0
	jalr $t1
	lw $t0, -16($fp)
	lw $t1, -20($fp)
	lw $t2, -24($fp)
	lw $t3, -28($fp)
	lw $t4, -32($fp)
	lw $t5, -36($fp)
	lw $t6, -40($fp)
	lw $t7, -44($fp)
	lw $t8, -48($fp)
	lw $t9, -52($fp)
	move $t2, $v0
	move $t3, $t2
	lw $t4, 4($s0)
	lw $t5, 16($s0)
	lw $t6, 28($s0)
	lw $t7, 40($s0)
	lw $t8, 52($s0)
	lw $t9, 56($s0)
	add $t0, $t8, $t9
	add $t1, $t7, $t0
	add $t2, $t6, $t1
	add $t3, $t5, $t2
	add $t8, $t4, $t3
	move $a0, $t8
	jal _print
	li $t9, 0
	move $v0, $t9
	lw $s0, -12($fp)
	addu $sp, $sp, 52
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl C4_ved_SetData
C4_ved_SetData:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 48
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	li $t3, 10
	move $t4, $t0
	sw $t3, 4($t4)
	li $t5, 20
	move $t6, $t0
	sw $t5, 16($t6)
	li $t7, 30
	move $t8, $t0
	sw $t7, 28($t8)
	li $t9, 40
	move $t3, $t0
	sw $t9, 40($t3)
	move $t4, $t0
	sw $t1, 52($t4)
	move $t5, $t0
	sw $t2, 56($t5)
	lw $t6, 0($t0)
	lw $t7, 20($t6)
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
	jalr $t7
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
	move $t8, $v0
	move $t9, $t8
	li $t3, 4
	move $v0, $t3
	addu $sp, $sp, 48
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
