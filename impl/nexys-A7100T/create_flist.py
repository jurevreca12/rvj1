import os

SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))
ROOT_DIR   = os.path.join(SCRIPT_DIR, "..", "..")
SOURCE_DIR = os.path.join(ROOT_DIR, "rtl")
TB_DIR = os.path.join(ROOT_DIR, "tb", "support")
OUTPUT_DIR = os.path.join(SCRIPT_DIR, "output")

_file_list = []
for searchdir in (SOURCE_DIR, SCRIPT_DIR, TB_DIR):
    for root, dirs, files in os.walk(searchdir):
        for file in files:
            if file.endswith('.sv') or file.endswith('.v'):
                rel_path = os.path.relpath(root + "/" + file, SCRIPT_DIR)
                _file_list.append(str(rel_path))
_file_list.remove('src/ibuf.v')
_file_list.remove('src/bufg.v')
_file_list.remove('src/plle2_base.v')
_file_str = '\n'.join(_file_list)
with open("synth.flist", 'w') as f:
    f.write(_file_str)
