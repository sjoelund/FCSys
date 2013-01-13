#!/usr/bin/python
"""Set up the FCRes module.

See README.txt for instructions.
"""
from distutils.core import setup
from glob import glob

import fcres # Only to read the version number

setup(name='FCRes',
      version=fcres.__version__,
      author='Kevin Davies',
      author_email='kdavies4@gmail.com',
      #credits=['Kevin Bandy'],
      packages=['fcres'],
      scripts=glob('bin/*'),
      url='http://kdavies4.github.com/FCSys/',
      license = "Modelica License Version 2",
      description='Python utilities for the FCSys package',
      long_description=open('README.txt').read(),
      provides=['fcres'],
      requires=['modelicares  (>=0.4)'],
      keywords=['Modelica', 'Dymola', 'plot', 'matplotlib', 'simulation',
                'experiment', 'results', 'proton exchange membrane',
                'polymer exchange membran', 'fuel cell', 'PEMFC', 'FCSys'],
      classifiers=['Development Status :: 3 - Alpha',
                   'Operating System :: POSIX :: Linux',
                   'Operating System :: Microsoft :: Windows',
                   'Environment :: Console',
                   'License :: OSI Approved :: BSD License',
                   'Programming Language :: Python :: 2.7',
                   'Intended Audience :: Science/Research',
                   'Topic :: Scientific/Engineering',
                   'Topic :: Utilities',
                     ],
     )
