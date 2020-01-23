import binascii
import sys

try: # with argument
    file = sys.argv[1]
    f = open(file, 'r')
    print('Open file', file)
except: # with |
    f = sys.stdin

data = f.readlines()
for d in data:
    d = d.replace('\n', '') # generate an error with unhexlify
    if d is '':
        continue
    print('data:', d)
    print('unhexify:', binascii.unhexlify(d))
