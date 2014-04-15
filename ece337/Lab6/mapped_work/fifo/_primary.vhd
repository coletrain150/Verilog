library verilog;
use verilog.vl_types.all;
entity fifo is
    port(
        r_clk           : in     vl_logic;
        w_clk           : in     vl_logic;
        n_rst           : in     vl_logic;
        r_enable        : in     vl_logic;
        w_enable        : in     vl_logic;
        w_data          : in     vl_logic_vector(7 downto 0);
        r_data          : out    vl_logic_vector(7 downto 0);
        empty           : out    vl_logic;
        full            : out    vl_logic
    );
end fifo;
