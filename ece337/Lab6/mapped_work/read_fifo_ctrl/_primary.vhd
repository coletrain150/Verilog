library verilog;
use verilog.vl_types.all;
entity read_fifo_ctrl is
    port(
        rclk            : in     vl_logic;
        rst_n           : in     vl_logic;
        renable         : in     vl_logic;
        wptr            : in     vl_logic_vector(3 downto 0);
        rptr            : out    vl_logic_vector(3 downto 0);
        raddr           : out    vl_logic_vector(2 downto 0);
        empty_flag      : out    vl_logic
    );
end read_fifo_ctrl;
