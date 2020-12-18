from distutils.core import setup, Extension

def main():
    setup(name="simModels",
          version="1.0.0",
          description="Arithmetic models for testing the ALU",
          author="JureVreca",
          author_email="jurevreca12@gmail.com",
          ext_modules=[Extension("simModels", ["simModels.c"])])

if __name__ == "__main__":
    main()

