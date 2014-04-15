library verilog;
use verilog.vl_types.all;
entity flex_counter_NUM_CNT_BITS8_ROLLOVER_VAL9 is
    port(
        clk             : in     vl_logic;
        n_reset         : in     vl_logic;
        cnt_up          : in     vl_logic;
        clear           : in     vl_logic;
        one_k_samples   : out    vl_logic
    );
end flex_counter_NUM_CNT_BITS8_ROLLOVER_VAL9;
