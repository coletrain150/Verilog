library verilog;
use verilog.vl_types.all;
entity flex_counter is
    generic(
        NUM_CNT_BITS    : integer := 8;
        ROLLOVER_VAL    : integer := 10
    );
    port(
        clk             : in     vl_logic;
        n_reset         : in     vl_logic;
        cnt_up          : in     vl_logic;
        one_k_samples   : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NUM_CNT_BITS : constant is 1;
    attribute mti_svvh_generic_type of ROLLOVER_VAL : constant is 1;
end flex_counter;
