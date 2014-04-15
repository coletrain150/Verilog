library verilog;
use verilog.vl_types.all;
entity datapath is
    port(
        clk             : in     vl_logic;
        n_reset         : in     vl_logic;
        op              : in     vl_logic_vector(1 downto 0);
        src1            : in     vl_logic_vector(3 downto 0);
        src2            : in     vl_logic_vector(3 downto 0);
        dest            : in     vl_logic_vector(3 downto 0);
        ext_data        : in     vl_logic_vector(15 downto 0);
        outreg_data     : out    vl_logic_vector(15 downto 0);
        overflow        : out    vl_logic
    );
end datapath;
