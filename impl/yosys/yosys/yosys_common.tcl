# Copyright (c) 2022 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Authors:
# - Philippe Sauter <phsauter@iis.ee.ethz.ch>

# Preparation for the synthesis flow
# A common setup to provide some functionality and define variables

# list of global variables that may be used
# define with scheme: <local-var> { <ENVVAR>  <fallback> }


# process ABC script and write to temporary directory
proc processAbcScript {abc_script} {
    set tmp_dir ./tmp/.
    set src_dir [file join [file dirname [info script]] ../src]
    set abc_out_path $tmp_dir/[file tail $abc_script]

    # substitute {STRING} placeholders with their value
    set raw [read -nonewline [open $abc_script r]]
    set abc_script_recaig [string map -nocase [list "{REC_AIG}" [subst "$src_dir/lazy_man_synth_library.aig"]] $raw]
    set abc_out [open $abc_out_path w]
    puts -nonewline $abc_out $abc_script_recaig

    flush $abc_out
    close $abc_out
    return $abc_out_path
}
