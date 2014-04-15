library verilog;
use verilog.vl_types.all;
entity controller is
    generic(
        IDLE            : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi0, Hi0);
        STORE           : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi0, Hi1);
        SORT1           : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi1, Hi0);
        SORT2           : vl_logic_vector(3 downto 0) := (Hi0, Hi0, Hi1, Hi1);
        SORT3           : vl_logic_vector(3 downto 0) := (Hi0, Hi1, Hi0, Hi0);
        SORT4           : vl_logic_vector(3 downto 0) := (Hi0, Hi1, Hi0, Hi1);
        ADD1            : vl_logic_vector(3 downto 0) := (Hi0, Hi1, Hi1, Hi0);
        ADD2            : vl_logic_vector(3 downto 0) := (Hi0, Hi1, Hi1, Hi1);
        ADD3            : vl_logic_vector(3 downto 0) := (Hi1, Hi0, Hi0, Hi0);
        EIDLE           : vl_logic_vector(3 downto 0) := (Hi1, Hi0, Hi0, Hi1)
    );
    port(
        clk             : in     vl_logic;
        n_reset         : in     vl_logic;
        dr              : in     vl_logic;
        overflow        : in     vl_logic;
        cnt_up          : out    vl_logic;
        modwait         : out    vl_logic;
        op              : out    vl_logic_vector(1 downto 0);
        src1            : out    vl_logic_vector(3 downto 0);
        src2            : out    vl_logic_vector(3 downto 0);
        dest            : out    vl_logic_vector(3 downto 0);
        err             : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 2;
    attribute mti_svvh_generic_type of STORE : constant is 2;
    attribute mti_svvh_generic_type of SORT1 : constant is 2;
    attribute mti_svvh_generic_type of SORT2 : constant is 2;
    attribute mti_svvh_generic_type of SORT3 : constant is 2;
    attribute mti_svvh_generic_type of SORT4 : constant is 2;
    attribute mti_svvh_generic_type of ADD1 : constant is 2;
    attribute mti_svvh_generic_type of ADD2 : constant is 2;
    attribute mti_svvh_generic_type of ADD3 : constant is 2;
    attribute mti_svvh_generic_type of EIDLE : constant is 2;
end controller;
