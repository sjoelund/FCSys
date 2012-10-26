#!/usr/bin/env python
# Rewrap the lines of Modelica files in a folder.
#
# The first argument is the directory.
#
# Created by Kevin Davies, 10/26/12

import re
import glob
import sys
import os
from textwrap import TextWrapper

## Settings
textWrapper = TextWrapper(width=77, drop_whitespace=False,
                          break_long_words=False, break_on_hyphens=False)

# Directory specification
if (len(sys.argv) > 1):
    directory = sys.argv[1]
else:
    directory = ''

# Process the files.
for fname in glob.glob(os.path.join(directory, '*.mo')):
    # Read the source file.
    print("Processing %s ... " % fname)
    src = open(fname, 'r')
    text = src.read()
    src.close()

    # Wrap the text.
    print type(text)
    print len(text)
    text = textWrapper.wrap(text)

    # Re-write the file.
    src = open(fname, 'w')
    src.write(text)
    src.close()
