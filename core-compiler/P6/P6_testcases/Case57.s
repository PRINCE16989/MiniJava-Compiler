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
	li $a0, 16
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
	move $t6, $t0
	li $t7, 1
	li $t8, 2
	lw $t9, 0($t6)
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
	move $a0, $t6
	move $a1, $t7
	move $a2, $t8
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
	move $t1, $v0
	move $t3, $t1
	move $a0, $t3
	jal _print
	li $a0, 24
	jal _halloc
	move $t4, $v0
	li $a0, 16
	jal _halloc
	move $t5, $v0
	sw $t5, 0($t4)
	la $t0, Parent_ved_m0
	sw $t0, 0($t5)
	la $t9, C1_ved_SetData
	sw $t9, 4($t5)
	la $t7, C1_ved_m1
	sw $t7, 8($t5)
	li $t8, 0
	sw $t8, 4($t4)
	li $t2, 0
	sw $t2, 8($t4)
	li $t1, 0
	sw $t1, 12($t4)
	li $t0, 0
	sw $t0, 16($t4)
	move $t6, $t4
	li $t9, 3
	li $t5, 4
	lw $t7, 0($t6)
	lw $t8, 4($t7)
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
	move $a0, $t6
	move $a1, $t9
	move $a2, $t5
	jalr $t8
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
	move $t2, $v0
	move $t3, $t2
	move $a0, $t3
	jal _print
	li $a0, 32
	jal _halloc
	move $t1, $v0
	li $a0, 20
	jal _halloc
	move $t0, $v0
	sw $t0, 0($t1)
	la $t4, Parent_ved_m0
	sw $t4, 0($t0)
	la $t7, C2_ved_SetData
	sw $t7, 4($t0)
	la $t9, C1_ved_m1
	sw $t9, 8($t0)
	la $t5, C2_ved_m2
	sw $t5, 12($t0)
	li $t8, 0
	sw $t8, 4($t1)
	li $t2, 0
	sw $t2, 8($t1)
	li $t4, 0
	sw $t4, 12($t1)
	li $t7, 0
	sw $t7, 16($t1)
	li $t9, 0
	sw $t9, 20($t1)
	li $t0, 0
	sw $t0, 24($t1)
	move $t6, $t1
	li $t5, 4
	li $t8, 5
	lw $t2, 0($t6)
	lw $t4, 4($t2)
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
	move $a0, $t6
	move $a1, $t5
	move $a2, $t8
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
	move $t7, $v0
	move $t3, $t7
	move $a0, $t3
	jal _print
	li $a0, 40
	jal _halloc
	move $t9, $v0
	li $a0, 24
	jal _halloc
	move $t0, $v0
	sw $t0, 0($t9)
	la $t1, Parent_ved_m0
	sw $t1, 0($t0)
	la $t2, C3_ved_SetData
	sw $t2, 4($t0)
	la $t5, C1_ved_m1
	sw $t5, 8($t0)
	la $t8, C2_ved_m2
	sw $t8, 12($t0)
	la $t4, C3_ved_m3
	sw $t4, 16($t0)
	li $t7, 0
	sw $t7, 4($t9)
	li $t1, 0
	sw $t1, 8($t9)
	li $t2, 0
	sw $t2, 12($t9)
	li $t5, 0
	sw $t5, 16($t9)
	li $t8, 0
	sw $t8, 20($t9)
	li $t0, 0
	sw $t0, 24($t9)
	li $t4, 0
	sw $t4, 28($t9)
	li $t7, 0
	sw $t7, 32($t9)
	move $t6, $t9
	li $t1, 5
	li $t2, 6
	lw $t5, 0($t6)
	lw $t8, 4($t5)
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
	move $a0, $t6
	move $a1, $t1
	move $a2, $t2
	jalr $t8
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
	move $t3, $t0
	move $a0, $t3
	jal _print
	li $t4, 0
	move $v0, $t4
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
	subu $sp, $sp, 48
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	move $t3, $t0
	sw $t1, 4($t3)
	move $t4, $t0
	sw $t2, 8($t4)
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
	move $t8, $t7
	li $t9, 0
	move $v0, $t9
	addu $sp, $sp, 48
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
	lw $t5, 12($s0)
	lw $t6, 16($s0)
	add $t7, $t5, $t6
	add $t8, $t4, $t7
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
	.globl C1_ved_SetData
C1_ved_SetData:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 48
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	li $t3, 10000
	move $t4, $t0
	sw $t3, 4($t4)
	move $t5, $t0
	sw $t1, 12($t5)
	move $t6, $t0
	sw $t2, 16($t6)
	lw $t7, 0($t0)
	lw $t8, 8($t7)
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
	jalr $t8
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
	move $t3, $t9
	li $t4, 1
	move $v0, $t4
	addu $sp, $sp, 48
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
	lw $t5, 12($s0)
	lw $t6, 20($s0)
	lw $t7, 24($s0)
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
	subu $sp, $sp, 48
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	li $t3, 1000
	move $t4, $t0
	sw $t3, 4($t4)
	li $t5, 2000
	move $t6, $t0
	sw $t5, 12($t6)
	move $t7, $t0
	sw $t1, 20($t7)
	move $t8, $t0
	sw $t2, 24($t8)
	lw $t9, 0($t0)
	lw $t3, 12($t9)
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
	move $t4, $v0
	move $t5, $t4
	li $t6, 2
	move $v0, $t6
	addu $sp, $sp, 48
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
	lw $t5, 12($s0)
	lw $t6, 20($s0)
	lw $t7, 28($s0)
	lw $t8, 32($s0)
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
	subu $sp, $sp, 48
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	li $t3, 100
	move $t4, $t0
	sw $t3, 4($t4)
	li $t5, 200
	move $t6, $t0
	sw $t5, 12($t6)
	li $t7, 300
	move $t8, $t0
	sw $t7, 20($t8)
	move $t9, $t0
	sw $t1, 28($t9)
	move $t3, $t0
	sw $t2, 32($t3)
	lw $t4, 0($t0)
	lw $t5, 16($t4)
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
	jalr $t5
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
	move $t6, $v0
	move $t7, $t6
	li $t8, 3
	move $v0, $t8
	addu $sp, $sp, 48
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
	lw $t5, 12($s0)
	lw $t6, 20($s0)
	lw $t7, 28($s0)
	lw $t8, 36($s0)
	lw $t9, 40($s0)
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
	sw $t5, 12($t6)
	li $t7, 30
	move $t8, $t0
	sw $t7, 20($t8)
	li $t9, 40
	move $t3, $t0
	sw $t9, 28($t3)
	move $t4, $t0
	sw $t1, 36($t4)
	move $t5, $t0
	sw $t2, 40($t5)
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
