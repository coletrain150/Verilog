library verilog;
use verilog.vl_types.all;
entity lab7_tx_fifo is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        read_done       : in     vl_logic;
        read_data       : out    vl_logic_vector(7 downto 0);
        fifo_empty      : out    vl_logic;
        fifo_full       : out    vl_logic;
        write_enable    : in     vl_logic;
        write_data      : in     vl_logic_vector(7 downto 0)
    );
end lab7_tx_fifo;
