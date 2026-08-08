	.text
	.globl main
main:
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 44
	li $a0, 108
	jal _halloc
	move $t0, $v0
	li $a0, 16
	jal _halloc
	move $t1, $v0
	sw $t1, 0($t0)
	la $t2, InheritFieldTest_ved_TestInheritFields
	sw $t2, 0($t1)
	la $t3, InheritFieldTest_ved_set
	sw $t3, 4($t1)
	la $t4, InheritFieldTest_ved_m
	sw $t4, 8($t1)
	li $t5, 0
	sw $t5, 4($t0)
	li $t6, 0
	sw $t6, 8($t0)
	li $t7, 0
	sw $t7, 12($t0)
	li $t8, 0
	sw $t8, 16($t0)
	li $t9, 0
	sw $t9, 20($t0)
	li $t2, 0
	sw $t2, 24($t0)
	li $t3, 0
	sw $t3, 28($t0)
	li $t1, 0
	sw $t1, 32($t0)
	li $t4, 0
	sw $t4, 36($t0)
	li $t5, 0
	sw $t5, 40($t0)
	li $t6, 0
	sw $t6, 44($t0)
	li $t7, 0
	sw $t7, 48($t0)
	li $t8, 0
	sw $t8, 52($t0)
	li $t9, 0
	sw $t9, 56($t0)
	li $t2, 0
	sw $t2, 60($t0)
	li $t3, 0
	sw $t3, 64($t0)
	li $t1, 0
	sw $t1, 68($t0)
	li $t4, 0
	sw $t4, 72($t0)
	li $t5, 0
	sw $t5, 76($t0)
	li $t6, 0
	sw $t6, 80($t0)
	li $t7, 0
	sw $t7, 84($t0)
	li $t8, 0
	sw $t8, 88($t0)
	li $t9, 0
	sw $t9, 92($t0)
	li $t2, 0
	sw $t2, 96($t0)
	li $t3, 0
	sw $t3, 100($t0)
	lw $t1, 0($t0)
	lw $t4, 0($t1)
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
	subu $sp, $sp, 140
	sw $s0, -12($fp)
	sw $s1, -16($fp)
	sw $s2, -20($fp)
	sw $s3, -24($fp)
	sw $s4, -28($fp)
	sw $s5, -32($fp)
	sw $s6, -36($fp)
	sw $s7, -40($fp)
	move $s0, $a0
	lw $t0, 0($s0)
	lw $t1, 4($t0)
	sw $t0, -104($fp)
	sw $t1, -108($fp)
	sw $t2, -112($fp)
	sw $t3, -116($fp)
	sw $t4, -120($fp)
	sw $t5, -124($fp)
	sw $t6, -128($fp)
	sw $t7, -132($fp)
	sw $t8, -136($fp)
	sw $t9, -140($fp)
	move $a0, $s0
	jalr $t1
	lw $t0, -104($fp)
	lw $t1, -108($fp)
	lw $t2, -112($fp)
	lw $t3, -116($fp)
	lw $t4, -120($fp)
	lw $t5, -124($fp)
	lw $t6, -128($fp)
	lw $t7, -132($fp)
	lw $t8, -136($fp)
	lw $t9, -140($fp)
	move $t2, $v0
	move $t3, $t2
	li $t4, 1
	move $t5, $t4
	li $t6, 2
	move $t7, $t6
	li $t8, 3
	move $t9, $t8
	li $t0, 4
	move $t1, $t0
	li $t2, 5
	move $t4, $t2
	li $t6, 6
	move $t8, $t6
	li $t0, 7
	move $t2, $t0
	li $t6, 8
	move $t0, $t6
	li $t6, 9
	move $s1, $t6
	li $t6, 10
	move $s2, $t6
	li $t6, 11
	move $s3, $t6
	li $t6, 12
	move $s4, $t6
	li $t6, 13
	move $s5, $t6
	li $t6, 14
	move $s6, $t6
	li $t6, 15
	move $s7, $t6
	li $t6, 16
	move $v1, $t6
	sw $v1, -44($fp)
	li $t6, 17
	move $v1, $t6
	sw $v1, -48($fp)
	li $t6, 18
	move $v1, $t6
	sw $v1, -52($fp)
	li $t6, 19
	move $v1, $t6
	sw $v1, -56($fp)
	li $t6, 20
	move $v1, $t6
	sw $v1, -60($fp)
	li $t6, 21
	move $v1, $t6
	sw $v1, -64($fp)
	li $t6, 22
	move $v1, $t6
	sw $v1, -68($fp)
	li $t6, 23
	move $v1, $t6
	sw $v1, -72($fp)
	li $t6, 24
	move $v1, $t6
	sw $v1, -76($fp)
	li $t6, 25
	move $v1, $t6
	sw $v1, -80($fp)
	lw $v1, -76($fp)
	lw $a0, -80($fp)
	add $t6, $v1, $a0
	lw $v1, -72($fp)
	add $v1, $v1, $t6
	sw $v1, -84($fp)
	lw $v1, -68($fp)
	lw $a0, -84($fp)
	add $t6, $v1, $a0
	lw $v1, -64($fp)
	add $v1, $v1, $t6
	sw $v1, -88($fp)
	lw $v1, -60($fp)
	lw $a0, -88($fp)
	add $t6, $v1, $a0
	lw $v1, -56($fp)
	add $v1, $v1, $t6
	sw $v1, -92($fp)
	lw $v1, -52($fp)
	lw $a0, -92($fp)
	add $t6, $v1, $a0
	lw $v1, -48($fp)
	add $v1, $v1, $t6
	sw $v1, -96($fp)
	lw $v1, -44($fp)
	lw $a0, -96($fp)
	add $t6, $v1, $a0
	add $v1, $s7, $t6
	sw $v1, -100($fp)
	lw $a0, -100($fp)
	add $t6, $s6, $a0
	add $s7, $s5, $t6
	add $t6, $s4, $s7
	add $s6, $s3, $t6
	add $t6, $s2, $s6
	add $s5, $s1, $t6
	add $t6, $t0, $s5
	add $t0, $t2, $t6
	add $t2, $t8, $t0
	add $t6, $t4, $t2
	add $t8, $t1, $t6
	add $t0, $t9, $t8
	add $t4, $t7, $t0
	add $t2, $t5, $t4
	move $t3, $t2
	move $a0, $t3
	jal _print
	lw $t1, 0($s0)
	lw $t6, 8($t1)
	sw $t0, -104($fp)
	sw $t1, -108($fp)
	sw $t2, -112($fp)
	sw $t3, -116($fp)
	sw $t4, -120($fp)
	sw $t5, -124($fp)
	sw $t6, -128($fp)
	sw $t7, -132($fp)
	sw $t8, -136($fp)
	sw $t9, -140($fp)
	move $a0, $s0
	jalr $t6
	lw $t0, -104($fp)
	lw $t1, -108($fp)
	lw $t2, -112($fp)
	lw $t3, -116($fp)
	lw $t4, -120($fp)
	lw $t5, -124($fp)
	lw $t6, -128($fp)
	lw $t7, -132($fp)
	lw $t8, -136($fp)
	lw $t9, -140($fp)
	move $t9, $v0
	move $t3, $t9
	move $v0, $t3
	lw $s7, -40($fp)
	lw $s6, -36($fp)
	lw $s5, -32($fp)
	lw $s4, -28($fp)
	lw $s3, -24($fp)
	lw $s2, -20($fp)
	lw $s1, -16($fp)
	lw $s0, -12($fp)
	addu $sp, $sp, 140
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl InheritFieldTest_ved_set
InheritFieldTest_ved_set:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 8
	move $t0, $a0
	li $t1, 10
	move $t2, $t0
	sw $t1, 4($t2)
	li $t3, 20
	move $t4, $t0
	sw $t3, 8($t4)
	li $t5, 30
	move $t6, $t0
	sw $t5, 12($t6)
	li $t7, 40
	move $t8, $t0
	sw $t7, 16($t8)
	li $t9, 50
	move $t1, $t0
	sw $t9, 20($t1)
	li $t2, 60
	move $t3, $t0
	sw $t2, 24($t3)
	li $t4, 70
	move $t5, $t0
	sw $t4, 28($t5)
	li $t6, 80
	move $t7, $t0
	sw $t6, 32($t7)
	li $t8, 90
	move $t9, $t0
	sw $t8, 36($t9)
	li $t1, 100
	move $t2, $t0
	sw $t1, 40($t2)
	li $t3, 110
	move $t4, $t0
	sw $t3, 44($t4)
	li $t5, 120
	move $t6, $t0
	sw $t5, 48($t6)
	li $t7, 130
	move $t8, $t0
	sw $t7, 52($t8)
	li $t9, 140
	move $t1, $t0
	sw $t9, 56($t1)
	li $t2, 150
	move $t3, $t0
	sw $t2, 60($t3)
	li $t4, 160
	move $t5, $t0
	sw $t4, 64($t5)
	li $t6, 170
	move $t7, $t0
	sw $t6, 68($t7)
	li $t8, 180
	move $t9, $t0
	sw $t8, 72($t9)
	li $t1, 190
	move $t2, $t0
	sw $t1, 76($t2)
	li $t3, 200
	move $t4, $t0
	sw $t3, 80($t4)
	li $t5, 210
	move $t6, $t0
	sw $t5, 84($t6)
	li $t7, 220
	move $t8, $t0
	sw $t7, 88($t8)
	li $t9, 230
	move $t1, $t0
	sw $t9, 92($t1)
	li $t2, 240
	move $t3, $t0
	sw $t2, 96($t3)
	li $t4, 250
	move $t5, $t0
	sw $t4, 100($t5)
	li $t6, 0
	move $v0, $t6
	addu $sp, $sp, 8
	lw $ra, -4($fp)
	lw $fp, -8($sp)
	j $ra

	.text
	.globl InheritFieldTest_ved_m
InheritFieldTest_ved_m:
	sw $fp -8($sp)
	move $fp, $sp
	sw $ra, -4($fp)
	subu $sp, $sp, 88
	sw $s0, -12($fp)
	sw $s1, -16($fp)
	sw $s2, -20($fp)
	sw $s3, -24($fp)
	sw $s4, -28($fp)
	sw $s5, -32($fp)
	sw $s6, -36($fp)
	sw $s7, -40($fp)
	move $t0, $a0
	lw $t1, 4($t0)
	lw $t2, 8($t0)
	lw $t3, 12($t0)
	lw $t4, 16($t0)
	lw $t5, 20($t0)
	lw $t6, 24($t0)
	lw $t7, 28($t0)
	lw $t8, 32($t0)
	lw $t9, 36($t0)
	lw $s0, 40($t0)
	lw $s1, 44($t0)
	lw $s2, 48($t0)
	lw $s3, 52($t0)
	lw $s4, 56($t0)
	lw $s5, 60($t0)
	lw $s6, 64($t0)
	lw $s7, 68($t0)
	lw $v1, 72($t0)
	sw $v1, -44($fp)
	lw $v1, 76($t0)
	sw $v1, -48($fp)
	lw $v1, 80($t0)
	sw $v1, -52($fp)
	lw $v1, 84($t0)
	sw $v1, -56($fp)
	lw $v1, 88($t0)
	sw $v1, -60($fp)
	lw $v1, 92($t0)
	sw $v1, -64($fp)
	lw $v1, 96($t0)
	sw $v1, -68($fp)
	lw $v1, 100($t0)
	sw $v1, -72($fp)
	lw $v1, -68($fp)
	lw $a0, -72($fp)
	add $t0, $v1, $a0
	lw $v1, -64($fp)
	add $v1, $v1, $t0
	sw $v1, -76($fp)
	lw $v1, -60($fp)
	lw $a0, -76($fp)
	add $t0, $v1, $a0
	lw $v1, -56($fp)
	add $v1, $v1, $t0
	sw $v1, -80($fp)
	lw $v1, -52($fp)
	lw $a0, -80($fp)
	add $t0, $v1, $a0
	lw $v1, -48($fp)
	add $v1, $v1, $t0
	sw $v1, -84($fp)
	lw $v1, -44($fp)
	lw $a0, -84($fp)
	add $t0, $v1, $a0
	add $v1, $s7, $t0
	sw $v1, -88($fp)
	lw $a0, -88($fp)
	add $t0, $s6, $a0
	add $s7, $s5, $t0
	add $t0, $s4, $s7
	add $s6, $s3, $t0
	add $t0, $s2, $s6
	add $s5, $s1, $t0
	add $t0, $s0, $s5
	add $s4, $t9, $t0
	add $t9, $t8, $s4
	add $t0, $t7, $t9
	add $t8, $t6, $t0
	add $t7, $t5, $t8
	add $t9, $t4, $t7
	add $t6, $t3, $t9
	add $t0, $t2, $t6
	add $t5, $t1, $t0
	move $v0, $t5
	lw $s7, -40($fp)
	lw $s6, -36($fp)
	lw $s5, -32($fp)
	lw $s4, -28($fp)
	lw $s3, -24($fp)
	lw $s2, -20($fp)
	lw $s1, -16($fp)
	lw $s0, -12($fp)
	addu $sp, $sp, 88
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
