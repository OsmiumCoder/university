.data
	newline: .asciiz "\n"
	
.text
main:
	li $t0, 5 # X, outerLoop start
	li $t1, 65 # outerLoop end
	li $t2, 1 # Y, innerLoop start
	li $t3, 5 # innerLoop end
	li $t4, 0 # current iteration sum
	li $t5, 0 # Grand Total

loopOne:
	# if $t0 > 65 then jump to end
	bgt $t0, $t1, end
	
	loopTwo:
		# if $t2 > 5 then jump to loopTwoEnd
		bgt $t2, $t3, loopTwoEnd
		
		# current iteration sum = X + Y
		add $t4, $t0, $t2
		
		# print current iteration sum
		move $a0, $t4
		li $v0, 1
		syscall
		
		# print newline
		la $a0, newline
		li $v0, 4
		syscall
		
		# add current iteration to current grand total
		add $t5, $t5, $t4
		
		# increase Y by one
		addi $t2, $t2, 1
		j loopTwo

	loopTwoEnd:
		# increase X by five
		addi $t0, $t0, 5
		
		# reset Y to one
		li $t2, 1
		j loopOne

end:
	# print grand total
	move $a0, $t5
	li $v0, 1
	syscall
	
	# terminate run
	li $v0, 10
	syscall