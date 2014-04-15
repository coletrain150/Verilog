library verilog;
use verilog.vl_types.all;
entity avg_four is
    port(
        clk             : in     vl_logic;
        n_reset         : in     vl_logic;
        sample_data     : in     vl_logic_vector(15 downto 0);
        data_ready      : in     vl_logic;
        one_k_samples   : out    vl_logic;
        modwait         : out    vl_logic;
        avg_out         : out    vl_logic_vector(15 downto 0);
        err             : out    vl_logic
    );
end avg_four;
