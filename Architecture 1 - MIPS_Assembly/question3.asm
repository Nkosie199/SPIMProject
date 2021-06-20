# question3.asm, a program to check whether or not a given number is a primindromic prime
# 2/9/2016
# nkosi gumede

.data
	integer: .word 0
	integer2: .word 0
	string: .space 100 	# allocate 20 consecutive bytes, with storage uninitialized
   	iMsg: .asciiz "Enter the starting point N:\n"
   	iMsg2: .asciiz "Enter the ending point M:\n"
	oMsg: .asciiz "The palindromic primes are:\n"
	cr:	.asciiz		"\n"

.text

   main:
# ouput the prompt
   	li $v0,4				# system call from print method
   	la $a0,iMsg				# load address input msg into register a0
   	syscall					# print out the message

# get the string N
   	li $v0,5				# system call for scanner method, reads in the string in a0
   	syscall					# get the integer
	sw $v0,	integer			# store it in memory
	lw $t0, integer			# load the integer into register $t0 (for divisible number)
	lw $t1, integer			# also load the integer into register $t1 (for iterator i N<i<M) 

# ouput the prompt
   	li $v0,4				# system call from print method
   	la $a0,iMsg2			# load address input msg into register a0
   	syscall					# print out the message
	
# get the string M
   	li $v0,5				# system call for scanner method, reads in the string in a0
   	syscall					# get the integer	
	sw $v0,	integer2		# store it in memory
	lw $t2, integer2		# load the integer2 into register $t2
	#addi $t2, $t2, 1		# turn M into (M+1)
	
	beq, $t0, $t2, exit
	addi $t0, $t0, 1
	
# print the output message
	li $v0,4				# system call from print method
   	la $a0,oMsg				# load address input msg into register a0
   	syscall					# print out the message

# MAIN LOOP: ITERATING BETWEEN NUMBERS N AND M
# FIRST CHECK IF EACH NUMBER IS A PRIME
mainlooptop:
	beq $t0, $t2, exit 			# branch if N == M+1 then thats the end of the program
	beq $t0, 2, print
	li $t6, 0				# switch between 0 (default: prime) and 1 (not prime)
	# loop for integer > 1, 1 < integer. Decrease the int at t1 as denominator of t0 at each step. Until t1 = 1 
	sublooptop:
		sub $t1, 1 				# i--;
		beq $t1, 1, primechecker	# branch if i = 1
		div $t0, $t1			# divide the contents of t0 by t1
		mfhi $t3				# move the contents of Hi register into t2
			beq $t3, 0, notprime		# if Hi (remainder) is 0, ie there is a remainder, then it is not a prime
						
		j sublooptop 				# go back to the top of the loop
nextindex:		
	add $t0, 1				# N++;	
	la $t1, ($t0)				# set t1 to corresponding t0
	j mainlooptop
	
mainloopend:
	j exit
	
primechecker:
	beq $t6, 0, palindromechecker		#if register t6 == 0 ie. prime number, go to palindromechecker
	
notprime:
	li $t6, 1				# set the output msg to not prime
	j nextindex
	
# NOW WE ALSO NEED TO CHECK IF THE INTEGER AT INDEX OF $t0 IS A PALINDROME	
palindromechecker:
	la $t5, ($t0)				# n (t5) = num
	li $t7, 0					# rev (t7) = 0
	li $t9, 10					# because i need to divide by 10 a few times
whileloop:
	beq $t5, 0, palindromechecker2		#while number (ie. quotient) > 0
	div $t5, $t9					# digit = num % 10
	mfhi $t8					# digit (t8)
	mult $t7, $t9				# rev = rev * 10
	mflo $t7
	add $t7, $t8, $t7				# rev = rev + digit
	div $t5, $t9				# num = num / 1
	mflo $t5
	j whileloop

palindromechecker2:
	beq $t0, $t7, print			# if (n == rev) //is a palindrome
	j nextindex					# go back to loop
	
print:
	la $a0, ($t0)			# load the contents of t0 into register a0
	li $v0, 1				# print the contents of a0 (integer)
	syscall
	la $a0, cr			# also print return carriage
	li $v0, 4				# print the contents of a0 (integer)
	syscall
	
	j nextindex
	
exit:   
	li $v0, 10
	syscall         		# Exit program	