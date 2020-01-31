#/bin/env python3
import sys

file = sys.argv[1]
with open(file, 'r', encoding='ISO-8859-1') as f:
    row = f.read()[:-1]
    for i, c in enumerate(row):
        print( chr(ord(c) - i), end='' )



#/bin/env python3
import sys
file = sys.argv[1]
with open(file, 'r') as f:
    row = f.read()[:-1]
    result = ''
    for i, c in enumerate(row):
        result = result + chr(ord(c) - i)
    print (result)
