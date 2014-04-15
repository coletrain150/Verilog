library verilog;
use verilog.vl_types.all;
entity lab7_tcu is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        transmit        : in     vl_logic;
        bit_done        : in     vl_logic;
        bus_mode        : out    vl_logic_vector(1 downto 0);
        stop            : out    vl_logic;
        start           : out    vl_logic;
        sync            : out    vl_logic;
        read_done       : out    vl_logic;
        tx_sel          : out    vl_logic;
        tx_enable_0     : out    vl_logic;
        load_data_0     : out    vl_logic;
        tx_enable_1     : out    vl_logic;
        load_data_1     : out    vl_logic
    );
end lab7_tcu;
