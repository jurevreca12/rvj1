import tempfile
import subprocess
import shlex
import time
import os
import sys
import re

class VerilatorSim:
    # pylint: disable-next=consider-using-with
    logfile = tempfile.NamedTemporaryFile(prefix='verilator_debug_sim', suffix='.log')
    logname = logfile.name
    lognames = [logname]

    def __init__(self, sim_cmd=None, debug=False, timeout=300,
                 server_started=r"^Listening on port (\d+)$"):
        cmd = ["/foss/designs/rvj1/tb/debug_sim_model/Vrvj1_debug_top"]
        # pylint: disable-next=consider-using-with
        logfile = open(self.logname, "w", encoding='utf-8')
        print(f"Temporary Verilator log: {self.logname}\n")
        logfile.write("+ " + " ".join(cmd) + "\n")
        logfile.flush()
        self.port=9999

        with open(self.logname, "r", encoding='utf-8') as listenfile:
            listenfile.seek(0, 2)
            # pylint: disable-next=consider-using-with
            print(f"VerilatorSim cmd: {cmd}")
            print(f"VerilatorSim logfile: {logfile}")
            my_env = os.environ.copy()
            my_env["LD_LIBRARY_PATH"] = "/foss/designs/rvj1/.bender/git/checkouts/riscv-dbg-642dc0969721d64a/tb/remote_bitbang/"
            self.process = subprocess.Popen(cmd, stdin=subprocess.PIPE, env=my_env, stdout=logfile, stderr=logfile)
            done = False
            start = time.time()
            while not done:
                # Fail if VCS exits early
                exit_code = self.process.poll()
                if exit_code is not None:
                    raise RuntimeError(
                        f'Verilator simulator exited early with status {exit_code}')
                print("Waiting for simulation to startup.")
                line = listenfile.readline()
                if not line:
                    time.sleep(1)
                match = re.match(server_started, line)
                if match:
                    print("MATCHED")
                    done = True
                    self.port = int(match.group(1))
                    os.environ['JTAG_VPI_PORT'] = str(self.port)
                if (time.time() - start) > timeout:
                    raise TestLibError(
                        "Timed out waiting for Verilator to listen for JTAG vpi")

   # def __del__(self):
   #     try:
   #         #self.process.terminate()
   #         #self.process.wait()
   #     except OSError:
   #         pass

