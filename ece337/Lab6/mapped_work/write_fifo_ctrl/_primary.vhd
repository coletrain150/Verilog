library verilog;
use verilog.vl_types.all;
entity write_fifo_ctrl is
    port(
        wclk            : in     vl_logic;
        rst_n           : in     vl_logic;
        wenable         : in     vl_logic;
        rptr            : in     vl_logic_vector(3 downto 0);
        wenable_fifo    : out    vl_logic;
        wptr            : out    vl_logic_vector(3 downto 0);
        waddr           : out    vl_logic_vector(2 downto 0);
        full_flag       : out    vl_logic
    );
end write_fifo_ctrl;
