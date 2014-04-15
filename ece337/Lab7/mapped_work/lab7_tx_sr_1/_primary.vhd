library verilog;
use verilog.vl_types.all;
entity lab7_tx_sr_1 is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        shift_enable    : in     vl_logic;
        tx_enable       : in     vl_logic;
        tx_data         : in     vl_logic_vector(7 downto 0);
        load_data       : in     vl_logic;
        tx_out          : out    vl_logic
    );
end lab7_tx_sr_1;
