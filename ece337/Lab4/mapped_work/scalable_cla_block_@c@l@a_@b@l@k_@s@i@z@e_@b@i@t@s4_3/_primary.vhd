library verilog;
use verilog.vl_types.all;
entity scalable_cla_block_CLA_BLK_SIZE_BITS4_3 is
    port(
        A               : in     vl_logic_vector(3 downto 0);
        B               : in     vl_logic_vector(3 downto 0);
        Cin             : in     vl_logic;
        S               : out    vl_logic_vector(3 downto 0);
        PG              : out    vl_logic;
        GG              : out    vl_logic
    );
end scalable_cla_block_CLA_BLK_SIZE_BITS4_3;
