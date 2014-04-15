library verilog;
use verilog.vl_types.all;
entity lab7_encoder is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        tx_bit          : in     vl_logic;
        shift_enable    : in     vl_logic;
        tx_value        : out    vl_logic
    );
end lab7_encoder;
