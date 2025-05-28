import numpy as np

weights = []

G = [
    [1, 0, 0, 2, 2],
    [0, 1, 0, 0, 1],
    [0, 0, 1, 1, 0]
]

X = 26
ternary = np.base_repr(X, base=3)
print(ternary)

for i in range(X + 1):
    row = [int(x) for x in np.base_repr(i, base=3).zfill(3)]

    wG = np.matmul(row, G) % 3

    print(f"{row} * G = {wG}")

    weights.append(np.count_nonzero(wG))

weights.sort()
print(weights)
