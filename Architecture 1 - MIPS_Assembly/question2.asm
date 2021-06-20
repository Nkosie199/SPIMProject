# question1.asm, a program to check whether or not a given number is a prime
# nkosi gumede
# 2/9/2016


.data
	integer: .word 0
   	iMsg: .asciiz "Enter a number:\n"
   	oMsg1: .asciiz "It is prime\n"
	oMsg2: .asciiz "It is not prime\n"

.text

   main:
# ouput the prompt
   	li $v0,4				# system call from print method
   	la $a0,iMsg				# load address input msg into register a0
   	syscall					# print out the message

# get the string 1
   	li $v0,5				# system call for scanner method, reads in the string in a0
   	syscall					# get the integer
	sw $v0,	integer			# store it in memory
	lw $t0, integer			# load the integer into register $t0
	lw $t1, integer			# also load the integer into register $t0
	
# load the default output message into register t6
	la $t6, oMsg1
	
# loop for integer > 1, 1 < integer. Decrease the int at t1 as denominator of t0 at each step. Until t1 = 1 
looptop:
	sub $t1, 1 				# i--;
	beq $t1, 1, loopend			# branch if i = 1
	div $t0, $t1			# divide the contents of t0 by t1
	mfhi $t2				# move the contents of Hi register into t2
		beq $t2, 0, notprime		# if Hi (remainder) is 0, ie there is a remainder, then it is not a prime
					
	j looptop 				# go back to the top of the loop
	
loopend:
	j end

notprime:
	la $t6, oMsg2			# set the output msg to not prime
	j end
	
end:
	la $a0, ($t6)			# load the contents of t0 into register a0
	li $v0, 4				# print the contents of a0
	syscall
	j exit
	
exit:   
	li $v0, 10
	syscall         		# Exit program	
