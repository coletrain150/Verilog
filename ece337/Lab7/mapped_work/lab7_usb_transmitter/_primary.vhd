library verilog;
use verilog.vl_types.all;
entity lab7_usb_transmitter is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        d_plus          : out    vl_logic;
        d_minus         : out    vl_logic;
        transmit        : in     vl_logic;
        write_enable    : in     vl_logic;
        write_data      : in     vl_logic_vector(7 downto 0);
        fifo_empty      : out    vl_logic;
        fifo_full       : out    vl_logic
    );
end lab7_usb_transmitter;
