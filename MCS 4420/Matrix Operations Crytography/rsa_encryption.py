n = 247
e = 5
# d = 173
d = 29

plain_text = "The private key of the RSA algorithm is one hundred and seventy three, which can be discovered by finding the inverse of 5 in Z_m, where m is 216."

for x in plain_text:
    print(f"{ord(x) ** e % n:x}", end=' ')
print()

cipher_text = "91 82 2b df b1 5f 4f 83 b8 33 2b df d9 2b 31 df e8 a3 df 33 82 2b df 3e ef dd df b8 a6 0c e8 5f 4f 33 82 c8 df 4f 14 df e8 02 2b df 82 5b 02 ed 5f 2b ed df b8 02 ed df 14 2b 83 2b 02 33 31 df 33 82 5f 2b 2b 05 df 7b 82 4f 70 82 df 70 b8 02 df a7 2b df ed 4f 14 70 e8 83 2b 5f 2b ed df a7 31 df a3 4f 02 ed 4f 02 0c df 33 82 2b df 4f 02 83 2b 5f 14 2b df e8 a3 df 28 df 4f 02 df b5 72 c8 05 df 7b 82 2b 5f 2b df c8 df 4f 14 df 2e 79 af 32"

for x in cipher_text.split():
    print(f"{chr(int(x, 16) ** d % n)}", end="")
print()

for i in range(2, n):
    if n % i == 0:
        print(i)
