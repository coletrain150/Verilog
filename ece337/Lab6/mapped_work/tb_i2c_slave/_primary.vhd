library verilog;
use verilog.vl_types.all;
entity tb_i2c_slave is
    generic(
        CLK_PERIOD      : real    := 10.000000;
        SCL_PERIOD      : real    := 300.000000
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLK_PERIOD : constant is 1;
    attribute mti_svvh_generic_type of SCL_PERIOD : constant is 1;
end tb_i2c_slave;
