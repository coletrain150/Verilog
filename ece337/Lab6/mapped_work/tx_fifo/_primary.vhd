library verilog;
use verilog.vl_types.all;
entity tx_fifo is
    port(
        clk             : in     vl_logic;
        read_enable     : in     vl_logic;
        n_rst           : in     vl_logic;
        write_enable    : in     vl_logic;
        write_data      : in     vl_logic_vector(7 downto 0);
        read_data       : out    vl_logic_vector(7 downto 0);
        fifo_empty      : out    vl_logic;
        fifo_full       : out    vl_logic
    );
end tx_fifo;
