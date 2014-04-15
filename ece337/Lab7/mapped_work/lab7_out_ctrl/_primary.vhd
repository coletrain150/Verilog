library verilog;
use verilog.vl_types.all;
entity lab7_out_ctrl is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        d_plus          : out    vl_logic;
        d_minus         : out    vl_logic;
        bus_mode        : in     vl_logic_vector(1 downto 0);
        tx_value        : in     vl_logic
    );
end lab7_out_ctrl;
