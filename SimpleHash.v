module SimpleHash(
    input  wire [15:0] msg,
    input  wire [7:0]  key,
    output wire [7:0]  hash
);
    //2 halves
    wire [7:0] A = msg[15:8];
    wire [7:0] B = msg[7:0];

    //First Mix
    wire [7:0] x1 = A ^ B ^ key;                     
    wire [7:0] r1 = { x1[4:0], x1[7:5] };        
    wire [7:0] t1 = r1 ^ (x1 >> 2) ^ (x1 << 1) ^ 8'hA5; 

    //Second Mix
    wire [7:0] x2 = t1 ^ key;              
    wire [7:0] r2 = { x2[2:0], x2[7:3] };            
    wire [7:0] t2 = r2 ^ (x2 << 2) ^ (x2 >> 3) ^ 8'h3C;

    //LUT
    function [3:0] sbox4;
        input [3:0] nib;
        begin
            case (nib)
                4'h0: sbox4 = 4'he; // 1110
                4'h1: sbox4 = 4'h4; // 0100
                4'h2: sbox4 = 4'hd; // 1101
                4'h3: sbox4 = 4'h1; // 0001
                4'h4: sbox4 = 4'h2; // 0010
                4'h5: sbox4 = 4'hf; // 1111
                4'h6: sbox4 = 4'hb; // 1011
                4'h7: sbox4 = 4'h8; // 1000
                4'h8: sbox4 = 4'h3; // 0011
                4'h9: sbox4 = 4'ha; // 1010
                4'ha: sbox4 = 4'h6; // 0110
                4'hb: sbox4 = 4'hc; // 1100
                4'hc: sbox4 = 4'h5; // 0101
                4'hd: sbox4 = 4'h9; // 1001
                4'he: sbox4 = 4'h0; // 0000
                default: sbox4 = 4'h7; // 0111 for 4'hf
            endcase
        end
    endfunction

    wire [7:0] sub = { sbox4(t2[7:4]), sbox4(t2[3:0]) };
    wire [7:0] final_mix = sub ^ t1 ^ {t1[3:0], t1[7:4]};
    assign hash = final_mix;

endmodule

