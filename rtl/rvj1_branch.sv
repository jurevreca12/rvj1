module rvj1_branch import rvj1_pkg::*; (
    input  logic [31:0]  alu_res_r_i,
    input  branch_ctrl_e branch_type_i,
    input  logic         valid_i,
    output logic         cond_met_o
);
  logic cond_met;
  always_comb begin
    cond_met = 1'b0;
    unique case (branch_type_i)
      BRANCH_NEQ: cond_met = (alu_res_r_i    != 0   );
      BRANCH_EQ:  cond_met = (alu_res_r_i    == 0   );
      BRANCH_LT:  cond_met = (alu_res_r_i[0] == 1'b1);
      BRANCH_GE:  cond_met = (alu_res_r_i[0] == 1'b0);
      BRANCH_LTU: cond_met = (alu_res_r_i[0] == 1'b1);
      BRANCH_GEU: cond_met = (alu_res_r_i[0] == 1'b0);
    endcase
  end

  assign cond_met_o = cond_met & valid_i;
endmodule
