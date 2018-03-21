`timescale 1ns/1ns

module clkgen;
    reg clk;

    initial begin
        clk=0;
        forever #(100) clk = ~clk;
    end
endmodule


module tb;
    reg rst;
    reg en;
    clkgen g1();

    pcounter 
    #(.WIDTH(6))
    u1(
        .rst_i(rst),
        .clk_i(g1.clk),
        .en_i(en)
    );


    initial begin
        $dumpfile("pcounter.vcd");
        $dumpvars(0, tb.u1);
    end

    initial begin
        rst = 1;
        en  = 1;
#(350)
        rst = 0;

#(8000)
        en = 0;
#(8000)
        en = 1;
#(8000)
        
        $finish;
    end

endmodule
