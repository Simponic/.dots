#!/usr/bin/python3
(lambda rows: print("\n".join(["".join(list(map(lambda x: str(x*rows+i+32).ljust(5) + str(chr(x*rows + i + 32)).strip().ljust(2) + "|", range(4)))) for i in range(rows)])))((128-32) // 4)
