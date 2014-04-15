library verilog;
use verilog.vl_types.all;
entity read_ptr is
    port(
        rclk            : in     vl_logic;
        rst_n           : in     vl_logic;
        renable         : in     vl_logic;
        rptr            : out    vl_logic_vector(3 downto 0);
        rptr_nxt        : out    vl_logic_vector(3 downto 0)
    );
end read_ptr;
