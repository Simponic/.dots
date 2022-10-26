#!/usr/bin/python3

rows = (128-32) // 4
for i in range(rows):
    print("".join(list(map(lambda x: str(x*rows+i+32).ljust(5) + str(chr(x*rows + i + 32)).strip().ljust(2) + "|", range(4)))))
