import os
import logging
import glob
import pathlib 

import riscof.utils as utils
from riscof.pluginTemplate import pluginTemplate

logger = logging.getLogger()

class jedro_1(pluginTemplate):
    __model__ = "jedro_1"
    __version__ = "0.3"  # TODO: please update

    def __init__(self, *args, **kwargs):
        sclass = super().__init__(*args, **kwargs)

        config = kwargs.get('config')
        if config is None:
            print("Please enter input file paths in configuration.")
            raise SystemExit(1)

        self.num_jobs = str(int(os.cpu_count() / 2))

        self.pluginpath=os.path.abspath(config['pluginpath'])
        self.isa_spec = os.path.abspath(config['ispec'])
        self.platform_spec = os.path.abspath(config['pspec'])

        if 'target_run' in config and config['target_run']=='0':
            self.target_run = False
        else:
            self.target_run = True
        return sclass

    def initialise(self, suite, work_dir, archtest_env):
       self.work_dir = work_dir
       self.suite_dir = suite
       self.tb_dir = os.path.join(self.pluginpath, "..", "tb") # The location of the testbench.
       self.scripts_dir = os.path.join(pathlib.Path(__file__).parent.resolve(), "..", "..", "..", "scripts")
       self.elf2hex = os.path.join(self.scripts_dir, "elf2hex")

       # Note the march is not hardwired here, because it will change for each
       # test. Similarly the output elf name and compile macros will be assigned later in the
       # runTests function
       self.compile_cmd = 'riscv{1}-unknown-elf-gcc -march={0} \
         -static -mcmodel=medany -fvisibility=hidden -nostdlib -nostartfiles -g\
         -T '+self.pluginpath+'/env/link.ld\
         -I '+self.pluginpath+'/env/\
         -I ' + archtest_env + ' {2} -o {3} {4}'


    def build(self, isa_yaml, platform_yaml):
      ispec = utils.load_yaml(isa_yaml)['hart0']
      self.xlen = ('64' if 64 in ispec['supported_xlen'] else '32')

      self.isa = 'rv' + self.xlen
      if "I" in ispec["ISA"]:
          self.isa += 'i'
      if "M" in ispec["ISA"]:
          self.isa += 'm'
      if "F" in ispec["ISA"]:
          self.isa += 'f'
      if "D" in ispec["ISA"]:
          self.isa += 'd'
      if "C" in ispec["ISA"]:
          self.isa += 'c'

      self.compile_cmd = self.compile_cmd+' -mabi='+('lp64 ' if 64 in ispec['supported_xlen'] else 'ilp32 ')

    def runTests(self, testList):
      if os.path.exists(self.work_dir+ "/Makefile." + self.name[:-1]):
            os.remove(self.work_dir+ "/Makefile." + self.name[:-1])

      make = utils.makeUtil(makefilePath=os.path.join(self.work_dir, "Makefile." + self.name[:-1]))
      make.makeCommand = 'make -j' + self.num_jobs
      for testname in testList:
          testentry = testList[testname]
          test_file = testentry['test_path']
          test_dir = testentry['work_dir']  # where the artifacts of this test will be dumpedt
          elf_file = os.path.join(test_dir, 'my.elf')
          hex_file = os.path.join(test_dir, 'out.hex')
          sim_dir = os.path.join(test_dir, "obj_dir/")
          
          #  RISCOF expects the signature to be named as DUT-<dut-name>.signature.  
          sig_file = os.path.join(test_dir, self.name[:-1] + ".signature")
          compile_macros= ' -D' + " -D".join(testentry['macros'])
          compile_cmd = self.compile_cmd.format(testentry['isa'].lower(), self.xlen, test_file, elf_file, compile_macros)

          elf2hex_cmd = self.elf2hex + " --bit-width 32 --input " + elf_file + " --output " + hex_file
          rtl_dirs = (
            "/riscv-jedro-1/rtl/inc", # needs to be before others
            "/riscv-jedro-1/rtl", 
            "/riscv-jedro-1/tb/support",
            "/riscv-jedro-1/tb/riscof-plugin/tb/"
          )
          rtl_files = []
          for rootdir in rtl_dirs:
            rtl_files += list(glob.glob(f'{rootdir}/**/*.v', recursive=True))
            rtl_files += list(glob.glob(f'{rootdir}/**/*.sv', recursive=True))

          verilator_args = (
              " --timescale 1ns/1ps " + 
              " --binary " +
              " --debug " +
              " -I/riscv-jedro-1/rtl/inc " +
              " -Wno-fatal " +
              f" -Mdir {sim_dir} " +
              ' '.join(rtl_files) +

              f" -GMEM_INIT_FILE=\\\"{testentry['work_dir']}/out.hex\\\" " +
              f" -GSIGNATURE_FILE=\\\"{sig_file}\\\" "
          )

	      # if the user wants to disable running the tests and only compile the tests
          if self.target_run:
            sim_cmd = (f"verilator {verilator_args} --top jedro_1_riscof_tb; " +
                      f"{sim_dir}/Vjedro_1_riscof_tb\n"
            )
          else:
            sim_cmd = 'echo "NO RUN"'
          execute = (f"{compile_cmd}\n" +
                     f"{elf2hex_cmd}\n" +
                     sim_cmd + 
                     f"rm -rf {sim_dir}\n"
          )
          make.add_target(execute)

      make.execute_all(self.work_dir)

      if not self.target_run:
          raise SystemExit(0)

