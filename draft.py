from lmdbfw.db import *

import re


c = open('lmdb.h').read()

for i in re.findall(r'int\s+\w+\([a-zA-z0-9*\s,]+\)', c):
    print(' '.join(i.split()))

