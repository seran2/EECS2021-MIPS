	.text
main:	#-------------------
	sw	$ra, 0($sp)
	addi	$sp, $sp, -4
	addi	$v0, $0, 5
	syscall
	add	$a0, $0, $v0
	jal	calc
	add	$a0, $0, $v0
	addi	$v0, $0, 1
	syscall
done:	addi	$sp, $sp, 4
	lw	$ra, 0($sp)
	jr	$ra


calc:	#-------------------
	add	$t0, $0, $0
	addi	$t6, $0, 10	#t6 =10
	slt	$t9, $a0, $t6	#argument a0 < 10 if yes go to skip
	beq	$t9, $0, skip
	add	$t0, $0, $a0	#result = $a0
	add 	$v0, $0, $t0	#return result
	j 	comp


skip:	
	addi 	$t3, $0, 2	#t3 = 2
	
	
	#-------------------------------------------------------------
		sw	$ra, 0($sp)
		addi	$sp, $sp, -4	#push ra
	#------------------------------------------------------------
		
	#-------------------------------------------------------------
		sw 	$a0, 0($sp)
		addi 	$sp, $sp, -4
	#-------------------------------------------------------------	
		div 	$a0, $t3	#div a0/t3
		mflo	$a0		#store divide in $a0
		jal calc
		
	#-------------------------------------------------------------
		addi	$sp, $sp, 4
		lw	$a0, 0($sp)	#pop a
	#-------------------------------------------------------------	
		add	$t0, $t0, $a0
	#------------------------------------------------------------
		addi	$sp, $sp, 4
		lw	$ra, 0($sp)	#pop sum
	#-------------------------------------------------------------
		
		add	$v0, $0, $t0	# result  = a
		
comp:	
	jr 	$ra			

########################################################