library verilog;
use verilog.vl_types.all;
entity alu_DATA_SIZE_BITS16 is
    port(
        A               : in     vl_logic_vector(15 downto 0);
        B               : in     vl_logic_vector(15 downto 0);
        alu_op          : in     vl_logic;
        result          : out    vl_logic_vector(15 downto 0);
        overflow        : out    vl_logic
    );
end alu_DATA_SIZE_BITS16;
