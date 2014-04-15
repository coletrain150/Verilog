library verilog;
use verilog.vl_types.all;
entity fiforam is
    port(
        wclk            : in     vl_logic;
        wenable         : in     vl_logic;
        waddr           : in     vl_logic_vector(2 downto 0);
        raddr           : in     vl_logic_vector(2 downto 0);
        wdata           : in     vl_logic_vector(7 downto 0);
        rdata           : out    vl_logic_vector(7 downto 0)
    );
end fiforam;
