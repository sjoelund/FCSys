#!/usr/bin/env python
# Make custom replacements in files.
#
# The first argument is the directory.
#
# Created by Kevin Davies, 5/30/12

import re
import glob
import sys
import os
from textrwap import TextWrapper

## Settings
textWrapper = TextWrapper(width=77, drop_whitespace=False,
                          break_long_words=False, break_on_hyphens=False)

# Directory specification
if (len(sys.argv) > 1):
    directory = sys.argv[1]
else:
    directory = '.'

# Compile the regular expressions.
for i, rpl in enumerate(rpls):
    rpls[i] = (re.compile(rpl[0]), rpl[1])

# Replace strings.
for fname in glob.glob(os.path.join(directory, '*.mo')):
    # Read the source file.
    print "Processing " + fname + "..."
    src = open(fname, 'r')
    text = src.read()
    src.close()

    # Wrap the text.
    text = textWrapper.wrap(text)

    for rpl in rpls:
        text = rpl[0].sub(rpl[1], text)

    # Re-write the file.
    src = open(fname, 'w')
    src.write(text)
    src.close()
