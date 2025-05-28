import numpy as np
from numpy import array2string


def min_weight(representative_one, representative_two):
    weight_of_one = representative_one.count(0)
    weight_of_two = representative_two.count(0)

    return representative_one if weight_of_one >= weight_of_two else representative_two


H = [
    [1, 0, 2, 1, 0],
    [1, 2, 0, 0, 1]
]

X = 242
ternary = np.base_repr(X, base=3)

print(ternary)

syndrome_to_representative = {}


for i in range(X + 1):
    row = [int(x) for x in np.base_repr(i, base=3).zfill(5)]

    HxT = np.matmul(H, np.transpose(row)) % 3

    HxTString = array2string(HxT)

    if HxTString not in syndrome_to_representative:
        syndrome_to_representative[HxTString] = [row]
    else:
        syndrome_to_representative[HxTString].append(row)

    print(f"{H} * {np.transpose(row)} = {HxT}")

for syndrome, representative in syndrome_to_representative.items():
    print(f"{syndrome} = {representative}")
