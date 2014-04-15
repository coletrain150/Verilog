library verilog;
use verilog.vl_types.all;
entity regfile_NUM_REG_ADDR_BITS4_REG_SIZE_BITS16 is
    port(
        clk             : in     vl_logic;
        n_reset         : in     vl_logic;
        w_sel           : in     vl_logic_vector(3 downto 0);
        r1_sel          : in     vl_logic_vector(3 downto 0);
        r2_sel          : in     vl_logic_vector(3 downto 0);
        w_data          : in     vl_logic_vector(15 downto 0);
        w_en            : in     vl_logic;
        r1_data         : out    vl_logic_vector(15 downto 0);
        r2_data         : out    vl_logic_vector(15 downto 0);
        outreg_data     : out    vl_logic_vector(15 downto 0)
    );
end regfile_NUM_REG_ADDR_BITS4_REG_SIZE_BITS16;
