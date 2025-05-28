# INPUTS
# get the (x,y) coordinates of the first (source square) square from the user
srcX = int(input("Enter the x (first) coordinate for the source cell:"))
srcY = int(input("Enter the y (second) coordinate for the source cell:"))

# get the (x,y) coordinates of the second (destination square) square from the user
destX = int(input("Enter the x (first) coordinate for the destination cell:"))
destY = int(input("Enter the y (second) coordinate for the destination cell:"))

# LOGIC PATTERNS
# a white squares coordinates always consists of an even and even, or an odd and odd
# a black squares coordinates always consists of an even and odd, or an odd and even
# an even number modulus 2, will always result in 0
# an odd number modulus 2, will always result in 1

# DETERMINING COLOR
# the difference between each coordinate modulus 2 abs(x % 2 - y % 2) determines the color
# abs() is used so that it is just the absolute difference
# a white square results in a 0
# a black square results in a 1

# CALCULATE COLOR OF SQUARE
# calculate the color of the source square
srcColor = abs(srcX % 2 - srcY % 2)

# calculate the color of the destination square
destColor = abs(destX % 2 - destY % 2)

# FLIP VALUES OF SQUARES
# flip the values of white and black
# white which is defined as a 0 flips to 1
# black which is defined as a 1 flips to 0
# abs() used so that white(0) is +1 rather than -1
srcValue = abs(srcColor - 1)
destValue = abs(destColor - 1)

# DIFFERENCE IN X AND Y OF PAIRS
# finding the difference in the X's and Y's of each coordinate
# both differences must be equal for the path to be diagonal
diffInX = abs(srcX - destX)
diffInY = abs(srcY - destY)

# DETERMINING LENGTH OF PATH
# floor dividing the differences in X and Y results in 0 if they are unequal
# min and max are used so that division by zero can't occur
# 1 is added so that 0//0 never occurs
# if and only if the differences in X and Y are equal, the division equals 1
# the values of both source and destinations are included so that if either square is black the length returns as 0
# if and only if diffInX == diffInY the value of either is the length of the distance
# if all other values are 1 diffInX and diffInY is the length
lengthOfPath = (min(diffInX, diffInY) + 1) // (max(diffInY, diffInX) + 1) * srcValue * destValue * diffInX

print("The length of a diagonal path from (", srcX, ",", srcY, ") to (", destX, ",", destY, ") is :", lengthOfPath)
