library verilog;
use verilog.vl_types.all;
entity tx_sr is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        tx_data         : in     vl_logic_vector(7 downto 0);
        falling_edge_found: in     vl_logic;
        tx_enable       : in     vl_logic;
        load_data       : in     vl_logic;
        tx_out          : out    vl_logic
    );
end tx_sr;
