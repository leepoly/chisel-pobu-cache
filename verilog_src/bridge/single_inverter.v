module single_inverter
(
    input to_inverter,
    output inversed
);

assign inversed = ~to_inverter;

endmodule