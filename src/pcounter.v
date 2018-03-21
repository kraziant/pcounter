module pcounter
#(
    parameter WIDTH = 4
)
(
    input                  rst_i,
    input                  clk_i,
    input                  en_i,

    output reg [WIDTH-1:0] value_o
);

    reg [WIDTH-1:0] enables;
    wire [WIDTH-1:0] w_en;

    assign w_en = {enables, en_i};

    
    genvar i;
    generate
    for(i=0; i<WIDTH; i=i+1) begin : bit

        always@(posedge rst_i or posedge clk_i)
            if(rst_i) 
                value_o[i] <= 0; 
            else 
                if (w_en[i]) value_o[i] <= ~value_o[i];

        always@(posedge rst_i or posedge clk_i)
            if (rst_i)
                enables[i] <= 0;
            else
                enables[i] <= value_o[i] & w_en[i];
    
    end
    endgenerate
endmodule
