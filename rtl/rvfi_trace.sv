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
    parameter int CORE_NUM = 0,
    parameter string LOG_FILE = "rvfi_trace.log"
)
(
    input logic        clk,
    input logic        rvfi_valid,
    input logic [63:0] rvfi_order,
    input logic [31:0] rvfi_insn,
    input logic        rvfi_trap,
    input logic        rvfi_halt,
    input logic        rvfi_intr,
    input logic [ 1:0] rvfi_mode,
    input logic [ 1:0] rvfi_ixl,
    input logic [ 4:0] rvfi_rs1_addr,
    input logic [ 4:0] rvfi_rs2_addr,
    input logic [31:0] rvfi_rs1_rdata,
    input logic [31:0] rvfi_rs2_rdata,
    input logic [ 4:0] rvfi_rd_addr,
    input logic [31:0] rvfi_rd_wdata,
    input logic [31:0] rvfi_pc_rdata,
    input logic [31:0] rvfi_pc_wdata,
    input logic [31:0] rvfi_mem_addr,
    input logic [ 3:0] rvfi_mem_rmask,
    input logic [ 3:0] rvfi_mem_wmask,
    input logic [31:0] rvfi_mem_rdata,
    input logic [31:0] rvfi_mem_wdata,
    input logic [11:0] rvfi_csr_waddr,
    input logic [31:0] rvfi_csr_rval,
    input logic        rvfi_csr_written,
    input logic        rvfi_csr_mod
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
        string commit_str;
        $fwrite(file_handle, "core%4d:%2d 0x%8h (0x%8h)",
            CORE_NUM,
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
        if (rvfi_csr_written && rvfi_csr_mod)
            $fwrite(file_handle, " c%3d_%s 0x%8h",
                rvfi_csr_waddr,
                csr_addr_to_name(rvfi_csr_waddr),
                rvfi_csr_rval
            );
        // TODO: CSR
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
