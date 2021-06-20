# exercise2 - read in and print a string
# hussein suleman
# 17 september 2015

.data
   str: .space 100
   iMsg: .asciiz "Enter a string:\n"
   oMsg: .asciiz "The string is:\n"

.text

main:

# ouput the prompt
   li $v0,4
   la $a0,iMsg
   syscall
# get the string
   li $v0,8
   la $a0,str
   syscall

# output the string prefix text
   li $v0,4
   la $a0,oMsg
   syscall
# output the number
   li $v0,4
   la $a0,str
   syscall

# exit
   jr $ra
