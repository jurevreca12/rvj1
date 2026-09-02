// sprejema ukaze iz FIFO in jih posreduje decoderju
// kompresirane ukaze vmes dekompresira
// prirejeno po https://github.com/lowRISC/ibex/blob/master/rtl/ibex_compressed_decoder.sv

module rvc_decomp import rvj1_pkg::*; (
    input  logic [31:0]     instr_i,
    output logic [31:0]     instr_o,

    output logic            compr_o
    );

  always_comb begin
    compr_o = 1'b1;
    unique case (instr_i[1:0])
      // uncompressed
      2'b11: begin
        instr_o = instr_i;
        compr_o = 1'b0;
      end
      // C0 kvadrant
      2'b00: begin
        unique case (instr_i[15:13])
          3'b000: begin
            // c.addi4spn -> addi rd', x2, imm
            instr_o = {2'b0, instr_i[10:7], instr_i[12:11], instr_i[5],
                       instr_i[6], 2'b00, 5'h02, 3'b000, 2'b01, instr_i[4:2], {OPCODE_OPIMM}};
          end

          3'b010: begin
            // c.lw -> lw rd', imm(rs1')
            instr_o = {5'b0, instr_i[5], instr_i[12:10], instr_i[6],
                       2'b00, 2'b01, instr_i[9:7], 3'b010, 2'b01, instr_i[4:2], {OPCODE_LOAD}};
          end

          3'b110: begin
            // c.sw -> sw rs2', imm(rs1')
            instr_o = {5'b0, instr_i[5], instr_i[12], 2'b01, instr_i[4:2],
                       2'b01, instr_i[9:7], 3'b010, instr_i[11:10], instr_i[6],
                       2'b00, {OPCODE_STORE}};
          end

          default: begin
            instr_o = 32'b00000000_00000000_00000000_00000000;
          end
        endcase
      end

      // C1 kvadrant
      2'b01: begin
        unique case (instr_i[15:13])
          3'b000: begin
            // c.nop (ko je rd/rs1 == 0) ali c.addi -> addi rd, rd, nzimm
            instr_o = {{6 {instr_i[12]}}, instr_i[12], instr_i[6:2],
                       instr_i[11:7], 3'b0, instr_i[11:7], {OPCODE_OPIMM}};
          end
          3'b001, 3'b101: begin
            // TODO loči?
            // 001: c.jal -> jal x1, imm
            // 101: c.j   -> jal x0, imm
            instr_o = {instr_i[12], instr_i[8], instr_i[10:9], instr_i[6],
                       instr_i[7], instr_i[2], instr_i[11], instr_i[5:3],
                       {9 {instr_i[12]}}, 4'b0, ~instr_i[15], {OPCODE_JAL}};
          end
          3'b010: begin
            // c.li -> addi rd, x0, nzimm
            // (c.li hints are translated into an addi hint) -- TODO kaj to pomeni
            instr_o = {{6 {instr_i[12]}}, instr_i[12], instr_i[6:2], 5'b0,
                       3'b0, instr_i[11:7], {OPCODE_OPIMM}};
          end
          3'b011: begin
            // c.lui, c.addi16sp

            // c.lui -> lui rd, imm
            // (c.lui hints are translated into a lui hint) -- TODO kaj to pomeni
            instr_o = {{15 {instr_i[12]}}, instr_i[6:2], instr_i[11:7], {OPCODE_LUI}};

            if (instr_i[11:7] == 5'h02) begin
              // c.addi16sp -> addi x2, x2, nzimm
              instr_o = {{3 {instr_i[12]}}, instr_i[4:3], instr_i[5], instr_i[2],
                         instr_i[6], 4'b0, 5'h02, 3'b000, 5'h02, {OPCODE_OPIMM}};
            end

            if ({instr_i[12], instr_i[6:2]} == 6'b0) instr_o = 32'b0; 
          end

          3'b100: begin
            unique case (instr_i[11:10])
              2'b00,
              2'b01: begin
                // 00: c.srli -> srli rd, rd, shamt
                // 01: c.srai -> srai rd, rd, shamt
                // (c.srli/c.srai hints are translated into a srli/srai hint)
                instr_o = {1'b0, instr_i[10], 5'b0, instr_i[6:2], 2'b01, instr_i[9:7],
                           3'b101, 2'b01, instr_i[9:7], {OPCODE_OPIMM}};
                if (instr_i[12] == 1'b1)  instr_o = 32'b0;
              end

              2'b10: begin
                // c.andi -> andi rd, rd, imm
                instr_o = {{6 {instr_i[12]}}, instr_i[12], instr_i[6:2], 2'b01, instr_i[9:7],
                           3'b111, 2'b01, instr_i[9:7], {OPCODE_OPIMM}};
              end

              2'b11: begin
                unique case ({instr_i[12], instr_i[6:5]})
                  3'b000: begin
                    // c.sub -> sub rd', rd', rs2'
                    instr_o = {2'b01, 5'b0, 2'b01, instr_i[4:2], 2'b01, instr_i[9:7],
                               3'b000, 2'b01, instr_i[9:7], {OPCODE_OP}};
                  end

                  3'b001: begin
                    // c.xor -> xor rd', rd', rs2'
                    instr_o = {7'b0, 2'b01, instr_i[4:2], 2'b01, instr_i[9:7], 3'b100,
                               2'b01, instr_i[9:7], {OPCODE_OP}};
                  end

                  3'b010: begin
                    // c.or  -> or  rd', rd', rs2'
                    instr_o = {7'b0, 2'b01, instr_i[4:2], 2'b01, instr_i[9:7], 3'b110,
                               2'b01, instr_i[9:7], {OPCODE_OP}};
                  end

                  3'b011: begin
                    // c.and -> and rd', rd', rs2'
                    instr_o = {7'b0, 2'b01, instr_i[4:2], 2'b01, instr_i[9:7], 3'b111,
                               2'b01, instr_i[9:7], {OPCODE_OP}};
                  end

                  3'b100,
                  3'b101: begin
                    // 100: c.subw
                    // 101: c.addw
                    instr_o = 32'b0; // subw, addw are reserved for future standard extensions
                  end

                  3'b110: begin
                      // The Zcb extension is not enabled
                      instr_o = 32'b0;
                  end

                  3'b111: begin
                      // The Zcb extension is not enabled
                      instr_o = 32'b0;
                  end

                  default: begin
                    instr_o = 32'b0; // TODO -- ali rabmo oba? tega in spodnjega?
                  end
                endcase
              end

              default: begin
                instr_o = 32'b0; 
              end
            endcase
          end
          3'b110, 3'b111: begin
            // 0: c.beqz -> beq rs1', x0, imm
            // 1: c.bnez -> bne rs1', x0, imm
            instr_o = {{4 {instr_i[12]}}, instr_i[6:5], instr_i[2], 5'b0, 2'b01,
                       instr_i[9:7], 2'b00, instr_i[13], instr_i[11:10], instr_i[4:3],
                       instr_i[12], {OPCODE_BRANCH}};
          end
          default: begin
            instr_o = 32'b0;
          end
          endcase
      end
      // C2 kvadrant
      2'b10: begin
        unique case (instr_i[15:13])
          3'b000: begin
            // c.slli -> slli rd, rd, shamt
            // (c.ssli hints are translated into a slli hint)
            instr_o = {7'b0, instr_i[6:2], instr_i[11:7], 3'b001, instr_i[11:7], {OPCODE_OPIMM}};
            if (instr_i[12] == 1'b1)  instr_o = 32'b0; // reserved for custom extensions
          end

          3'b010: begin
            // c.lwsp -> lw rd, imm(x2)
            instr_o = {4'b0, instr_i[3:2], instr_i[12], instr_i[6:4], 2'b00, 5'h02,
                       3'b010, instr_i[11:7], OPCODE_LOAD};
            if (instr_i[11:7] == 5'b0)  instr_o = 32'b0;
          end

          3'b100: begin
            if (instr_i[12] == 1'b0) begin
              if (instr_i[6:2] != 5'b0) begin
                // c.mv -> add rd/rs1, x0, rs2
                // (c.mv hints are translated into an add hint)
                instr_o = {7'b0, instr_i[6:2], 5'b0, 3'b0, instr_i[11:7], {OPCODE_OP}};
              end else begin
                // c.jr -> jalr x0, rd/rs1, 0
                instr_o = {12'b0, instr_i[11:7], 3'b0, 5'b0, {OPCODE_JALR}};
                if (instr_i[11:7] == 5'b0) instr_o = 32'b0;
              end
            end else begin
              if (instr_i[6:2] != 5'b0) begin
                // c.add -> add rd, rd, rs2
                // (c.add hints are translated into an add hint)
                instr_o = {7'b0, instr_i[6:2], instr_i[11:7], 3'b0, instr_i[11:7], {OPCODE_OP}};
              end else begin
                if (instr_i[11:7] == 5'b0) begin
                  // c.ebreak -> ebreak
                  instr_o = {32'h00_10_00_73};
                end else begin
                  // c.jalr -> jalr x1, rs1, 0
                  instr_o = {12'b0, instr_i[11:7], 3'b000, 5'b00001, {OPCODE_JALR}};
                end
              end
            end
          end
          3'b110: begin
            // c.swsp -> sw rs2, imm(x2)
            instr_o = {4'b0, instr_i[8:7], instr_i[12], instr_i[6:2], 5'h02, 3'b010,
                       instr_i[11:9], 2'b00, {OPCODE_STORE}};
          end
          default: begin
            instr_o = 32'b0; 
          end
        endcase
      end
      default: begin
        instr_o = 32'b0; 
      end
    endcase
  end


endmodule
