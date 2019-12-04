// A simple helper module. A 2x1 multiplixer

module mux2x1(
    input in0,
    input in1,
    input sel,
    output out
);

    assign out = (sel)?in1:in0;

endmodule
