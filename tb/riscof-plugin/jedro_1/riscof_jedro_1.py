import os
import re
import shutil
import subprocess
import shlex
import logging
import random
import string
from string import Template
import sys
import pathlib 

import riscof.utils as utils
import riscof.constants as constants
from riscof.pluginTemplate import pluginTemplate

logger = logging.getLogger()

class jedro_1(pluginTemplate):
    __model__ = "jedro_1"

    #TODO: please update the below to indicate family, version, etc of your DUT.
    __version__ = "0.3"

    def __init__(self, *args, **kwargs):
        sclass = super().__init__(*args, **kwargs)

        config = kwargs.get('config')

        # If the config node for this DUT is missing or empty. Raise an error. At minimum we need
        # the paths to the ispec and pspec files
        if config is None:
            print("Please enter input file paths in configuration.")
            raise SystemExit(1)

        # Because of te limitations of the vivado simulator, we limit this to 1.
        # (we are running the same simulation snapshot over and over in same directory)
        self.num_jobs = "1"

        # Path to the directory where this python file is located. Collect it from the config.ini
        self.pluginpath=os.path.abspath(config['pluginpath'])

        # Collect the paths to the  riscv-config absed ISA and platform yaml files. One can choose
        # to hardcode these here itself instead of picking it from the config.ini file.
        self.isa_spec = os.path.abspath(config['ispec'])
        self.platform_spec = os.path.abspath(config['pspec'])

        #We capture if the user would like the run the tests on the target or
        #not. If you are interested in just compiling the tests and not running
        #them on the target, then following variable should be set to False
        if 'target_run' in config and config['target_run']=='0':
            self.target_run = False
        else:
            self.target_run = True

        # Return the parameters set above back to RISCOF for further processing.
        return sclass

    def initialise(self, suite, work_dir, archtest_env):

       # capture the working directory. Any artifacts that the DUT creates should be placed in this
       # directory. Other artifacts from the framework and the Reference plugin will also be placed
       # here itself.
       self.work_dir = work_dir

       # capture the architectural test-suite directory.
       self.suite_dir = suite

       # The location of the testbench.
       self.tb_dir = os.path.join(self.pluginpath, "..", "tb")

       # Directory of the elf2hex script
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

      # load the isa yaml as a dictionary in python.
      ispec = utils.load_yaml(isa_yaml)['hart0']

      # capture the XLEN value by picking the max value in 'supported_xlen' field of isa yaml. This
      # will be useful in setting integer value in the compiler string (if not already hardcoded);
      self.xlen = ('64' if 64 in ispec['supported_xlen'] else '32')

      # for jedro_1 start building the '--isa' argument. the self.isa is dutnmae specific and may not be
      # useful for all DUTs
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

      #TODO: The following assumes you are using the riscv-gcc toolchain. If
      #      not please change appropriately
      self.compile_cmd = self.compile_cmd+' -mabi='+('lp64 ' if 64 in ispec['supported_xlen'] else 'ilp32 ')

    def runTests(self, testList):

      # Delete Makefile if it already exists.
      if os.path.exists(self.work_dir+ "/Makefile." + self.name[:-1]):
            os.remove(self.work_dir+ "/Makefile." + self.name[:-1])
      # create an instance the makeUtil class that we will use to create targets.
      make = utils.makeUtil(makefilePath=os.path.join(self.work_dir, "Makefile." + self.name[:-1]))

      # set the make command that will be used. The num_jobs parameter was set in the __init__
      # function earlier
      make.makeCommand = 'make -j' + self.num_jobs

      # we will iterate over each entry in the testList. Each entry node will be refered to by the
      # variable testname.
      for testname in testList:

          # for each testname we get all its fields (as described by the testList format)
          testentry = testList[testname]

          # we capture the path to the assembly file of this test
          test = testentry['test_path']

          # capture the directory where the artifacts of this test will be dumped/created. RISCOF is
          # going to look into this directory for the signature files
          test_dir = testentry['work_dir']

          # name of the elf file after compilation of the test
          elf = 'my.elf'

          # name of the hex file used later in simulation
          hex_file = 'out.hex'

          # result in tb dir
          sim_result = os.path.join(self.tb_dir, "dut.signature") 

          # simulation snapshot is the result of the simulation, we delete it so that the make
          # file in the tb dir can be used normally in the next test.
          sim_snap = os.path.join(self.tb_dir, "jedro_1_riscof_tb_simsnap.wdb")
          
          # name of the signature file as per requirement of RISCOF. RISCOF expects the signature to
          # be named as DUT-<dut-name>.signature. The below variable creates an absolute path of
          # signature file.
          sig_file = os.path.join(test_dir, self.name[:-1] + ".signature")

          # for each test there are specific compile macros that need to be enabled. The macros in
          # the testList node only contain the macros/values. For the gcc toolchain we need to
          # prefix with "-D". The following does precisely that.
          compile_macros= ' -D' + " -D".join(testentry['macros'])

          # substitute all variables in the compile command that we created in the initialize
          # function
          cmd = self.compile_cmd.format(testentry['isa'].lower(), self.xlen, test, elf, compile_macros)

          # after compilation we get an elf file, but we convert it for simulation purposes
          elf2hexcmd = self.elf2hex + " --bit-width 32 --input " + elf + " --output " + hex_file

	      # if the user wants to disable running the tests and only compile the tests, then
	      # the "else" clause is executed below assigning the sim command to simple no action
	      # echo statement.
          if self.target_run:
            # set up the simulation command. Template is for spike. Please change.
            simcmd = 'cd {0}; make; cd {1}'.format(self.tb_dir, self.work_dir)
          else:
            simcmd = 'echo "NO RUN"'

          # concatenate all commands that need to be executed within a make-target.
          # 0 - go to work dir
          # 1 - compile test to elf
          # 2 - elf2hex
          # 3,4 - copy hex to tb_dir
          # 5 - simulate in tb_dir
          # 6,7 - move result back to work_dir
          # 8 - remove simulation snapshot for next simulation
          execute = '@cd {0}; {1}; {2}; cp {3} {4}; {5}; cp {6} {7}; rm {8}'.format(testentry['work_dir'], # 0
                                                                             cmd, # 1
                                                                             elf2hexcmd, # 2 
                                                                             hex_file, # 3
                                                                             self.tb_dir, # 4
                                                                             simcmd,  # 5
                                                                             sim_result, # 6
                                                                             sig_file, # 7
                                                                             sim_snap) # 8

          # create a target. The makeutil will create a target with the name "TARGET<num>" where num
          # starts from 0 and increments automatically for each new target that is added
          make.add_target(execute)

      # if you would like to exit the framework once the makefile generation is complete uncomment the
      # following line. Note this will prevent any signature checking or report generation.
      #raise SystemExit

      # once the make-targets are done and the makefile has been created, run all the targets in
      # parallel using the make command set above.
      make.execute_all(self.work_dir)

      # if target runs are not required then we simply exit as this point after running all
      # the makefile targets.
      if not self.target_run:
          raise SystemExit(0)

