import os
import sys
import shutil
from setuptools.extension import Extension
from setuptools import setup, find_packages

try:
    from Cython.Build import cythonize
except ImportError:
    print('Cython not installed.')
    print('Please, install Cython from http://www.cython.org')
    sys.exit(1)

scriptdir = os.path.dirname(os.path.abspath(__file__))

with open(os.path.join(scriptdir, 'README.md')) as f:
    long_description = f.read()

ext = Extension('*',
                ['lmdbfw/*.pyx', 'mdb.c', 'midl.c'],
                include_dirs=['.'])

setup(name='lmdbfw',
      packages=find_packages(),
      version='0.0.1',
      license='BSD License',
      author='Arthur Goncharuk',
      author_email='af3.inet@gmail.com',
      long_description=long_description,
      long_description_content_type="text/markdown",
      classifiers=[
          'Intended Audience :: Developers',
          'License :: OSI Approved :: BSD License',
          'Programming Language :: Cython',
          'Programming Language :: Python',
          'Programming Language :: Python :: Implementation :: CPython'
          'Programming Language :: C',
          'Topic :: Software Development :: Libraries',
          'Topic :: Database',
          'Topic :: Database :: Database Engines/Servers'
      ],
      ext_modules=cythonize(ext, build_dir='build'),
      zip_safe=False
)
