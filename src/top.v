module top(
    input wire clk,
    input wire rst
);

    wire [31:0]pc_address_out;
    wire [31:0]alu_out;
    wire [31:0]byte_accessS;
    wire [3:0]masking;
    wire [31:0]instr_out;
    wire [31:0]dataMem_out;
    wire request;
    wire store;

    ram_top u_data_mem(
        .rst(rst),
        .request(request),
        .clk(clk),
        .address(alu_out[9:2]),
        .w_en(store),
        .write_data(byte_accessS),
        .masking(masking),

        .read_data(dataMem_out),
        .valid()
    );

    ram_top #(
        .INIT_MEM(1)
    )u_instruction_mem(
        .rst(rst),
        .request(request),
        .clk(clk),
        .address(pc_address_out[9:2]),
        .w_en(1'b0),
        .write_data(0),
        .masking(4'b0),

        .read_data(instr_out),
        .valid()
    );

    core u_core(
        .clk(clk),
        .rst(rst),
        .instr_out(instr_out),
        .dataMem_out(dataMem_out),

        .pc_address_out(pc_address_out),
        .alu_out(alu_out),
        .store(store),
        .masking_byte(masking),
        .byte_accessS(byte_accessS),
        .request(request)
    );
endmodule