library verilog;
use verilog.vl_types.all;
entity sync_0 is
    port(
        clk             : in     vl_logic;
        n_reset         : in     vl_logic;
        async_in        : in     vl_logic;
        sync_out        : out    vl_logic
    );
end sync_0;
