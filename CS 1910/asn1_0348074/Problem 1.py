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

# CALCULATING THE RESULT
# 0 if same color, 1 if different color
# if both source and destination are white it will always be 0 - 0 = 0
# if both source and destination are black it will always be 1 - 1 = 0
# if source and destination are of different color it will always be 1 - 0 = 1 or 0 - 1 = -1
# abs() is used to override as we are only interested in the absolute difference
result = abs(srcColor - destColor)

print("Evaluated expression resulted in:", result)
