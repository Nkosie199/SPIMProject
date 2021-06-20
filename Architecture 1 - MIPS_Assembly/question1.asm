# question1.asm, a program to check whether or not a given string is a palindrome
# nkosi gumede
# 2/9/2016


.data
	str1: .space 100 	# allocate 20 consecutive bytes, with storage uninitialized
   	iMsg: .asciiz "Enter a number:\n"
   	oMsg1: .asciiz "It is a palindrome\n"
	oMsg2: .asciiz "It is not a palindrome\n"

.text

   main:
# ouput the prompt
   	li $v0,4				# system call from print method
   	la $a0,iMsg				# load address input msg into register a0
   	syscall					# print out the message

# get the string 1
   	li $v0,8				# system call for scanner method, reads in the string in a0
   	la $a0,str1				# load the addess of string 1 into a0
   	syscall					# get the string
   	
# count the number of characters in the string (to be used for our for loop)
	la $t0, str1			# load base address of array into register $t0
	la $t1, str1			# AND load base address of array into register $t1
  	#li $t1, 0    			# $t1 is the counter. set it to 0 
  	
# load the default output message into register t6
	la $t6, oMsg1
   	
countChr:  
	lb $t2, 0($t0)  		# Load the first byte from address in $t0 , ie the first letter into register t2
	beqz $t2, adjust   		# if $t2 == 0 then go to label end  
	add $t0, $t0, 1     	# else increment the address
#debug print 	
	j countChr      		# finally loop 

adjust:
	sub $t0, $t0, 1     	# else reduce the address
	j reverse
	
reverse:
	sub $t0, $t0, 1     	# else reduce the address  
	lb $t2, 0($t0)  		# Load the first byte from address in $t0 , ie the first letter into register t2
	lb $t3, 0($t1)  		# Load the first byte from address in $t1 , ie the first letter into register t3
	beqz $t2, end   		# if $t2 == 0 then go to label end 
	
#lets see if we can print out each letter now
#	li $v0, 11				# system call for print method
#	la $a0, ($t2)				# load address of t2 into register a0
#	syscall
#	li $v0, 11				# system call for print method
#	la $a0, ($t3)				# load address of t3 into register a0
#	syscall
	
#check if this is NOT a palindrome
	bne $t2, $t3, notpalindrome
	add $t1, $t1, 1 		# and reduce the counter of course

	j reverse      			# finally loop 		

notpalindrome:
	la $t6, oMsg2			# set the output msg to not palindrome
	
end:
	la $a0, ($t6)			# load the contents of t0 into register a0
	li $v0, 4				# print the contents of a0
	syscall
	j exit
	
exit:   
	li $v0, 10
	syscall         		# Exit program	
