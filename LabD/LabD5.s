#############################################################
#			LabD1.s
#		    Fraction Class 
#############################################################

	.text

#------------------------------------------------------------

#------------Global Declaration------------------------------
	.globl	getNumerator
	.globl	getDenominator
	.globl	adding 	
	.globl	Fraction
	.globl	setNumerator
	.globl	setDenominator
	.globl	multiply
	.globl	divide
	.globl	subtract
#------------------------------------------------------------
Fraction:
	
		add	$t5, $0, $a0	#temporary storing a0
	
	#-------------------Heap--------------------------#
		addi	$v0, $0, 9	
		addi	$a0, $0, 8	# allocating memorary for two parameter
		syscall			# v0 = address of 8B block
	#-------------------------------------------------#
		
		add	$a0, $0, $t5	#get back the a0 parameter
		
		sw	$a0, 0($v0)	# store argument one to heap
		sw 	$a1, 4($v0)	# store argument two to heap
	
		jr $ra

#--------------------------------------------------------------
getNumerator:
	
		lw	$t1, 0($a0)
		add 	$v0, $0, $t1	#returns	 numerator

		jr $ra

#---------------------------------------------------------------
getDenominator:
	
		lw 	$t2, 4($a0)	
		add	$v0, $0, $t2	#returns denominator

		jr $ra

#---------------------------------------------------------------
setNumerator:
		
		sw	$a0, 0($a1)	#add parameter in a0 to memeory location of heap which is stored in a1
		jr $ra
#----------------------------------------------------------------
setDenominator:
		
		sw	$a0, 4($a1)
		jr $ra

#-----------------------------------------------------------------------#
# public void add(Fraction other){					#
# 	this.numerator = this.numerator * other.denominator +		#
#	this.denominator * other.numerator;				#
# 	this.denominator = this.denominator * other.denominator;	#
#} 									#
#########################################################################
adding:		
		lw 	$t3, 0($a0)	#this.numerator
		lw	$t4, 4($a0)	#this.denominator
		lw 	$t5, 0($a1)	#other numertor
		lw	$t6, 4($a1)	#other denominator

		mult	$t3, $t6
		mflo	$t7
		
		mult 	$t4, $t5
		mflo 	$t8
		
		add 	$t9, $t7, $t8	# a numerator
		mult 	$t4, $t6
		mflo	$s5
	
		sw 	$t9, 0($a0)	#a numerator
		sw 	$s5, 4($a0)	#a denominator

		jr $ra
#----------------------------------------------------------------
#--------------------multiply method-----------------------------

multiply:	
		lw 	$t3, 0($a0)	#this.numerator
		lw	$t4, 4($a0)	#this.denominator
		lw 	$t5, 0($a1)	#other numertor
		lw	$t6, 4($a1)	#other denominator
	
		mult 	$t3, $t5
		mflo	$t7
		
		mult	$t4, $t6
		mflo	$t8
	
		sw	$t7, 0($a0)
		sw	$t8, 4($a0)
		
		jr $ra

#-----------------------------------------------------------------
subtract:
		add	$t3, $0, $a0
		add	$t4, $0, $a1
		lw 	$t5, 0($a1)	#other numertor
		lw	$t6, 4($a1)	#other denominator

		sub	$t5, $0, $t5
		
		add	$a0, $0, $t5	#Fraction a = new Fraction(-other.numerator, other.denominator)
		add 	$a1, $0, $t6	# 

		
	#-----------------------------------------------------------
		sw	$ra, 0($sp)
		addi	$sp, $sp, -4	#push ra
	#-----------------------------------------------------------
		jal Fraction

	#------------------------------------------------------------
		addi	$sp, $sp, 4
		lw	$ra, 0($sp)	#pop ra
	#------------------------------------------------------------
		
		add	$s3, $0, $v0
		add 	$a0, $0, $t3
		add	$a1, $0, $s3
	#-----------------------------------------------------------
		sw	$ra, 0($sp)
		addi	$sp, $sp, -4	#push ra
	#-----------------------------------------------------------
		jal adding
	#------------------------------------------------------------
		addi	$sp, $sp, 4
		lw	$ra, 0($sp)	#pop ra
	#------------------------------------------------------------
		jr $ra
#--------------------------------------------------------------------------
divide:

		add	$t3, $0, $a0 	#address of a
		add	$t4, $0, $a1	#address of b
		lw 	$t5, 0($a1)	#other numertor
		lw	$t6, 4($a1)	#other denominator

		sub	$t5, $0, $t5
		
		add	$a0, $0, $t5	#Fraction a = new Fraction(-other.numerator, other.denominator)
		add 	$a1, $0, $t6	# 

		
	#-----------------------------------------------------------
		sw	$ra, 0($sp)
		addi	$sp, $sp, -4	#push ra
	#-----------------------------------------------------------
		jal Fraction

	#------------------------------------------------------------
		addi	$sp, $sp, 4
		lw	$ra, 0($sp)	#pop ra
	#------------------------------------------------------------
		
		add	$s3, $0, $v0
		add 	$a0, $0, $t3
		add	$a1, $0, $s3
	#-----------------------------------------------------------
		sw	$ra, 0($sp)
		addi	$sp, $sp, -4	#push ra
	#-----------------------------------------------------------
		jal multiply
	#------------------------------------------------------------
		addi	$sp, $sp, 4
		lw	$ra, 0($sp)	#pop ra
	#------------------------------------------------------------
		jr $ra
		
	
