library verilog;
use verilog.vl_types.all;
entity datapath_ctrl is
    port(
        op              : in     vl_logic_vector(1 downto 0);
        w_data_sel      : out    vl_logic;
        w_en            : out    vl_logic;
        alu_op          : out    vl_logic
    );
end datapath_ctrl;
