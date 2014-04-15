library verilog;
use verilog.vl_types.all;
entity scalable_cla_addr_NUM_CLA_BLKS4_CLA_BLK_SIZE_BITS4 is
    port(
        A               : in     vl_logic_vector(15 downto 0);
        B               : in     vl_logic_vector(15 downto 0);
        Cin             : in     vl_logic;
        S               : out    vl_logic_vector(15 downto 0);
        V               : out    vl_logic
    );
end scalable_cla_addr_NUM_CLA_BLKS4_CLA_BLK_SIZE_BITS4;
