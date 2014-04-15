library verilog;
use verilog.vl_types.all;
entity lab7_timer is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        start           : in     vl_logic;
        stop            : in     vl_logic;
        shift_enable    : out    vl_logic;
        bit_done        : out    vl_logic
    );
end lab7_timer;
