library verilog;
use verilog.vl_types.all;
entity mealy is
    generic(
        WAITING         : vl_logic_vector(2 downto 0) := (Hi0, Hi0, Hi0);
        RCV1            : vl_logic_vector(2 downto 0) := (Hi0, Hi0, Hi1);
        RCV11           : vl_logic_vector(2 downto 0) := (Hi0, Hi1, Hi0);
        RCV110          : vl_logic_vector(2 downto 0) := (Hi0, Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        i               : in     vl_logic;
        o               : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WAITING : constant is 2;
    attribute mti_svvh_generic_type of RCV1 : constant is 2;
    attribute mti_svvh_generic_type of RCV11 : constant is 2;
    attribute mti_svvh_generic_type of RCV110 : constant is 2;
end mealy;
