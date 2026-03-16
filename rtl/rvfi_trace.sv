////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    rvfi_trace                                                 //
// Project Name:   riscv-jedro-1                                              //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    Traces the rvfi interface to produce a log equivalent to   //
//                 the log produced by spike with --log-commits option.       //
//                 This enables easy debuging of traces.                      //
////////////////////////////////////////////////////////////////////////////////

/* verilator lint_off IMPORTSTAR */
import rvj1_defines::*;

module rvfi_trace #(
    parameter int CORE_ID = 0,
    parameter string LOG_FILE = "rvfi_trace.log"
)
(
    input logic clk,
    `RVFI_INPUTS
);
    int file_handle;
    logic reg_write;
    logic mem_load;
    logic mem_write;
    logic [11:7]  regdest;
    logic [14:12] funct3;
    logic [19:15] regs1;

    initial begin
        file_handle = $fopen(LOG_FILE, "w");
    end

    always_ff @(posedge clk) begin
        if (rvfi_valid && ~rvfi_trap)
            log_insn_commit();
    end

    final begin
        if (file_handle != 32'h0)
            $fclose(file_handle);
    end

    function automatic void log_insn_commit();
        // Based on spikes "commit_log_print_insn" in execute.cc
        string commit_str;
        $fwrite(file_handle, "core%4d:%2d 0x%8h (0x%8h)",
            CORE_ID,
            rvfi_mode,
            rvfi_pc_rdata,
            rvfi_insn
        );
        if (reg_write)
            log_reg_write();
        if (mem_load)
            $fwrite(file_handle, " mem 0x%8h", rvfi_mem_addr);
        if (mem_write)
            $fwrite(file_handle, " mem 0x%8h 0x%8h", rvfi_mem_addr, rvfi_mem_wdata); // mask?
        // CSR registers should be written by addres (lower to higher)
        log_csr_write(rvfi_csr_mstatus_wmask, rvfi_csr_mstatus_wdata, CSR_MSTATUS_ADDR);
        log_csr_write(rvfi_csr_mie_wmask, rvfi_csr_mie_wdata, CSR_MIE_ADDR);
        log_csr_write(rvfi_csr_mip_wmask, rvfi_csr_mip_wdata, CSR_MIP_ADDR);
        log_csr_write(rvfi_csr_mtvec_wmask, rvfi_csr_mtvec_wdata, CSR_MTVEC_ADDR);
        log_csr_write(rvfi_csr_mepc_wmask, rvfi_csr_mepc_wdata, CSR_MEPC_ADDR);
        log_csr_write(rvfi_csr_mcause_wmask, rvfi_csr_mcause_wdata, CSR_MCAUSE_ADDR);
        log_csr_write(rvfi_csr_mtval_wmask, rvfi_csr_mtval_wdata, CSR_MTVAL_ADDR);
        log_csr_write(rvfi_csr_mscratch_wmask, rvfi_csr_mscratch_wdata, CSR_MSCRATCH_ADDR);
        $fwrite(file_handle, "\n");
    endfunction

    function automatic void log_reg_write();
        if (rvfi_rd_addr != 0) begin
            if (rvfi_rd_addr > 9)
                $fwrite(file_handle, " x%0d 0x%8h", rvfi_rd_addr, rvfi_rd_wdata);
            else
                $fwrite(file_handle, " x%0d  0x%8h", rvfi_rd_addr, rvfi_rd_wdata);
        end
    endfunction

    function automatic void log_csr_write(logic [XLEN-1:0] wmask, logic [XLEN-1:0] wdata, logic [11:0] addr);
        if (wmask != '0)
            $fwrite(file_handle, " c%3d_%s 0x%8h", addr, csr_addr_to_name(addr), wdata);
    endfunction

    function automatic string csr_addr_to_name(logic [11:0] csr_addr);
        string ret;
        unique case(csr_addr)
            // Machine Information Registers
            CSR_MVENDORID_ADDR: ret = "mvendorid";
            CSR_MARCHID_ADDR:   ret = "marchid";
            CSR_MIMPID_ADDR:    ret = "mimpid";
            CSR_MHARTID_ADDR:   ret = "mhartid";

            // Machine Trap Setup
            CSR_MSTATUS_ADDR:    ret = "mstatus";
            CSR_MSTATUSH_ADDR:   ret = "mstatush";
            CSR_MISA_ADDR:       ret = "misa";
            CSR_MEDELEG_ADDR:    ret = "medeleg";
            CSR_MEDELEGH_ADDR:   ret = "medelegh";
            CSR_MIDELEG_ADDR:    ret = "mideleg";
            CSR_MIE_ADDR:        ret = "mie";
            CSR_MTVEC_ADDR:      ret = "mtvec";
            CSR_MCOUNTEREN_ADDR: ret = "mcounteren";

            // Machine Trap Handling
            CSR_MSCRATCH_ADDR:   ret = "mscratch";
            CSR_MEPC_ADDR:       ret = "mepc";
            CSR_MCAUSE_ADDR:     ret = "mcause";
            CSR_MTVAL_ADDR:      ret = "mtval";
            CSR_MIP_ADDR:        ret = "mip";
            default:             ret = "";
        endcase
        return ret;
    endfunction

    always_comb begin
        reg_write = 1'b0;
        mem_load  = 1'b0;
        mem_write = 1'b0;
        regs1     = rvfi_insn[19:15];
        regdest   = rvfi_insn[11:7];
        funct3    = rvfi_insn[14:12];
        unique case(rvfi_insn[6:0])
            OPCODE_OPIMM: reg_write = 1'b1;
            OPCODE_OP:    reg_write = 1'b1;
            OPCODE_LUI:   reg_write = 1'b1;
            OPCODE_AUIPC: reg_write = 1'b1;
            OPCODE_STORE: mem_write = 1'b1;
            OPCODE_LOAD:  begin
                reg_write = 1'b1;
                mem_load = 1'b1;
            end
            OPCODE_JAL:    reg_write = 1'b1;
            OPCODE_JALR:   reg_write = 1'b1;
            OPCODE_BRANCH:;
            OPCODE_SYSTEM: begin
                if (~((regs1 == 5'b0) && (regdest == 5'b0) && (funct3 == 3'b0)))
                    reg_write = 1'b1;
            end
            default:;
        endcase
    end

endmodule
