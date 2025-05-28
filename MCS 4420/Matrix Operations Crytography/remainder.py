product = 1

for i in range(1, 27):
    product *= i
    product %= 29

print(product)
