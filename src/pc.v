module pc (
    input wire        clk,
    input wire        rst,
    input wire        load,
    input wire        store,
    input wire        valid,
    input wire        branch_jal,
    input wire        jalr,
    input wire [31:0] jalr_address,
    input wire [31:0] branch_jump_address,

    output reg [31:0] address_out

);

    always @ (posedge clk or negedge rst) begin
        if (!rst) begin 
            address_out <= 0;
        end
        else if (branch_jal)begin
            address_out <= branch_jump_address;
        end
        else if (jalr)begin
            address_out <= jalr_address;
        end
        else if ((load | store) & !valid)begin
            address_out <= address_out;
        end
        else begin
            address_out <= address_out + 32'd4;
        end
    end
endmodule