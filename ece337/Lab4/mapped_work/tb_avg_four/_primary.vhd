library verilog;
use verilog.vl_types.all;
entity tb_avg_four is
    generic(
        INPUT_FILENAME  : string  := "./docs/test_1.bmp";
        RESULT_FILENAME : string  := "./docs/filtered_1.bmp";
        TMP_FILENAME    : string  := "./docs/tmp.txt"
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of INPUT_FILENAME : constant is 1;
    attribute mti_svvh_generic_type of RESULT_FILENAME : constant is 1;
    attribute mti_svvh_generic_type of TMP_FILENAME : constant is 1;
end tb_avg_four;
