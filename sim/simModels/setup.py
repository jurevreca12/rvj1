from distutils.core import setup, Extension

simModelsModule = Extension('simModels',
					include_dirs = [],
					libraries = [],
					sources = ['simModels.c'])



setup (name = 'simModels',
	   version = '1.0',
	   description = 'Contains models of the ALU.',
	   author  = 'Jure Vreca',
	   url = '',
	   ext_modules=[simModelsModule])
