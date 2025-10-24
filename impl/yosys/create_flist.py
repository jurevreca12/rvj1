import os

SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))
ROOT_DIR   = os.path.join(SCRIPT_DIR, "..", "..")
SOURCE_DIR = os.path.join(ROOT_DIR, "rtl")
OUTPUT_DIR = os.path.join(SCRIPT_DIR, "output")

_file_list = []
for root, dirs, files in os.walk(SOURCE_DIR):
    for file in files:
        if file.endswith('.sv') or file.endswith('.v'):
            rel_path = os.path.relpath(root + "/" + file, SCRIPT_DIR)
            _file_list.append(str(rel_path))
_file_str = '\n'.join(_file_list)
with open("synth.flist", 'w') as f:
    f.write(_file_str)
