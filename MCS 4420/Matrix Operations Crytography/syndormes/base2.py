import numpy as np
from numpy import array2string


def min_weight(representative_one, representative_two):
    weight_of_one = representative_one.count(0)
    weight_of_two = representative_two.count(0)

    return representative_one if weight_of_one >= weight_of_two else representative_two


H = [
    [1, 1, 0, 1, 0, 1],
    [1, 1, 0, 0, 1, 0],
    [1, 0, 1, 1, 0, 0]
]

X = 0b111111

syndrome_to_representative = {}

for i in range(X + 1):
    row = [int(x) for x in format(i, '06b')]

    HxT = np.matmul(H, np.transpose(row)) % 2

    HxTString = array2string(HxT)

    if HxTString not in syndrome_to_representative:
        syndrome_to_representative[HxTString] = row
    else:
        syndrome_to_representative[HxTString] = min_weight(syndrome_to_representative[HxTString], row)

for syndrome, representative in syndrome_to_representative.items():
    print(f"{syndrome} = {representative}")
