library verilog;
use verilog.vl_types.all;
entity write_ptr is
    port(
        wclk            : in     vl_logic;
        rst_n           : in     vl_logic;
        wenable         : in     vl_logic;
        wptr            : out    vl_logic_vector(3 downto 0);
        wptr_nxt        : out    vl_logic_vector(3 downto 0)
    );
end write_ptr;
