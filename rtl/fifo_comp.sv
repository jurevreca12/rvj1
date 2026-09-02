// 
// FIFO always reads in 32 bits of data. It outputs either 32 bit or 16 bit,
// depending on the last two bits (see RV compressed instrucitons). If the
// output is 16 bit, it is expected that the lower 16 bits of read_data_o
// are populated, and the other 16 bits is set to zero.
//

// LIMITATIONS:
// - assume DEPTH is po2 (for pointer arithmetic) TODO

module fifo_comp #(
  parameter int unsigned DEPTH=4
)(
    input  logic        clk_i,
    input  logic        rstn_i,
    input  logic        flush_i,

    output logic        write_ready_o,
    input  logic        write_valid_i,
    input  logic [31:0] write_data_i,

    input  logic        read_ready_i,
    output logic        read_valid_o,
    output logic [31:0] read_data_o,

    input  logic        input_err_i,
    output logic        output_err_o,

    input  logic        half_strobe_i
);
  logic [15:0] mem[DEPTH];
  logic        err_mem[DEPTH];
  logic [$clog2(DEPTH)-1:0] read_ptr, write_ptr, read_ptr_next, write_ptr_next;
  logic [$clog2(DEPTH)-1:0] err_read_ptr, err_write_ptr, err_read_ptr_next, err_write_ptr_next;
  logic [$clog2(DEPTH + 1)-1:0] fifo_counter;

  logic [$clog2(DEPTH)-1:0] read_ptr_p1;
  assign read_ptr_p1 = read_ptr + 1'b1;

  logic write_fire, read_fire;
  assign write_fire = write_ready_o && write_valid_i;
  assign read_fire = read_ready_i && read_valid_o;

  // Next pointer
  always_comb begin
    if (mem[read_ptr][1:0] == 2'b11) begin
      read_ptr_next = read_ptr + 2;
    end else begin
      read_ptr_next = read_ptr + 1;
    end
  end
  always_comb begin
    if (half_strobe_i) begin
      write_ptr_next = write_ptr + 1;
    end else begin
      write_ptr_next = write_ptr + 2;
    end
  end
  assign err_read_ptr_next = err_read_ptr + 2;
  assign err_write_ptr_next = err_write_ptr + 2;
  
  // WRITE POINTER
  always_ff @(posedge clk_i or negedge rstn_i) begin
    if (~rstn_i) begin
      write_ptr <= '0;
    end
    else if (write_fire) begin
      write_ptr <= write_ptr_next;
      err_write_ptr <= err_write_ptr_next;
    end
    else if (flush_i) begin
      write_ptr <= '0;
      err_write_ptr <= '0;
    end
  end

  // READ POINTER
  always_ff @(posedge clk_i or negedge rstn_i) begin
    if (~rstn_i) begin
      read_ptr <= '0;
    end else if (read_fire) begin
      read_ptr <= read_ptr_next;
      err_read_ptr <= err_read_ptr_next;
    end else if (flush_i) begin
      read_ptr <= '0;
      err_read_ptr <= '0;
    end
  end

  // Parcel counter
  always_ff @(posedge clk_i or negedge rstn_i) begin
    if (~rstn_i)
      fifo_counter <= '0;
    else if (flush_i) begin
      fifo_counter <= '0;
    end
    else if (write_fire && ~read_fire && ~half_strobe_i) // push / write
      fifo_counter <= fifo_counter + 2;
    else if (write_fire && ~read_fire && half_strobe_i)
      fifo_counter <= fifo_counter + 1;
    else if (~write_fire && read_fire) // pop / read
      if (mem[read_ptr][1:0] == 2'b11) begin
        fifo_counter <= fifo_counter - 2;
      end else begin
        fifo_counter <= fifo_counter - 1;
      end
    else if (write_fire && read_fire && mem[read_ptr][1:0] != 2'b11 && ~half_strobe_i) begin
      fifo_counter <= fifo_counter + 1;
    end
    else if (write_fire && read_fire && mem[read_ptr][1:0] == 2'b11 && half_strobe_i) begin
      fifo_counter <= fifo_counter - 1;
    end 
  end

  // Input data
  always_ff @(posedge clk_i or negedge rstn_i) begin
    if (write_fire) begin
      if (~half_strobe_i) begin
        mem[write_ptr    ] <= write_data_i[15:0];
        mem[write_ptr + 1] <= write_data_i[31:16];
      end else begin
        mem[write_ptr    ] <= write_data_i[15:0];
      end
    end
  end

  always_ff @(posedge clk_i or negedge rstn_i) begin
    if (write_fire) begin
      err_mem[err_write_ptr    ] <= input_err_i;
      err_mem[err_write_ptr + 1] <= input_err_i;
    end
  end

  // Output data
  always_comb begin
    if (mem[read_ptr][1:0] == 2'b11) begin
      read_data_o = {mem[read_ptr_p1], mem[read_ptr]};
    end else begin
      read_data_o = {16'b0, mem[read_ptr]};
    end
  end
  assign output_err_o = err_mem[err_read_ptr];

  // Full/empty
  always_comb begin
    if (mem[read_ptr][1:0] == 2'b11) begin
      read_valid_o = fifo_counter >= 2;
      // read_valid_o = fifo_counter >= 2 && ~err_mem[err_read_ptr];
    end else begin
      read_valid_o = fifo_counter >= 1;
      // read_valid_o = fifo_counter >= 1 && ~err_mem[err_read_ptr];
    end
  end
  assign write_ready_o  = fifo_counter < (DEPTH - 1);  // FIFO not full - TODO 16
endmodule
