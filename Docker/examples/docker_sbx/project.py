import time
import numpy as np
from tqdm import tqdm

total = 1000
iter_tqdm = tqdm(range(total))
for i in iter_tqdm:
    # print(f"sin({i/100}) = {np.sin(i/100):.4f}")
    iter_tqdm.set_description(f"x = {i/100}, sin = {np.sin(i/100):.4f}")
    time.sleep(1)

# import time

# total = 100
# count = 0
# while count < total:
#     count += 1
#     print("Line: " + str(count))
#     time.sleep(1)