import numpy as np

weights = []

# G = [
#     [1, 0, 0, 0, 0, 1, 1],
#     [0, 1, 0, 0, 1, 0, 1],
#     [0, 0, 1, 0, 1, 1, 0],
#     [0, 0, 0, 1, 1, 1, 1]
# ]

G = [
    [1, 1, 1, 0, 0],
    [0, 0, 1, 1, 1],
    [1, 1, 1, 1, 0]
]

X = 0b111

for i in range(X + 1):
    row = [int(x) for x in format(i, '03b')]

    wG = np.matmul(row, G) % 2

    print(f"{row} * G = {wG}")

    weights.append(np.count_nonzero(wG))

weights.sort()
print(weights)
