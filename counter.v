
//////////////////////////////////////////////////////////////////////////////////
// Company: Individual
// Engineer: tuna
// 
// Create Date: 01.09.2026 15:09:58
// Design Name: logic counter circuit
// Module Name: counter
// Project Name: Sequential Logic Project
// Target Devices: -
// Tool Versions: -
// Description: -
// 
// Dependencies: -
// 
// Revision: -
// Revision 0.01 - File Created
// Additional Comments:-
// 
//////////////////////////////////////////////////////////////////////////////////


module counter(
    input wire sys_clk, // Disaridan gelen ana saat sinyali (sadece iletim yapan kablo)
    input wire rst, // Asenkron sifirlama sinyali ( sadece iletim yapan kablo )
    output reg[3:0] q  // 4 bitlik cikis. 'reg' ifadesi, bu degerin bir flip-flop(bellek) tarafindan  saklandigini belirtir.

    );
    
    //  Manuel BUFG ekleme (Saat Tamponu) 
    BUFG bufg_inst (
    .I(sys_clk),  // Giris
    .O(sys_clk_buf) // Cikis ( Tamponlanmis saat)
    );
    
    
    
    // 1.Flip Flop (en düsük degerlikli bit - LSB)
    // Bu blok, sys_clk yukselen kenara gectiginde VEYA rst 1 oldugunda tetiklenir.
    always @(posedge sys_clk_buf or posedge rst) begin
    if (rst)
    
        q[0] <= 1'b0; // rst = 1 ise, saati beklemeden aninda 0 yap (Asenkron Reset)
    
    else
    
        q[0] <= ~q[0]; // rst = 0 ise, her saat darbesinde mevcut değeri tersle (Toggle / T Flip Flop)
    
   end
   
   // 2.Flip Flop
   // Kritik Nokta: Bu blogu artik 'sys_clk' değil, bir onceki bitin cikisi (q[0] tetikliyor
   always @(posedge q[0] or posedge rst) begin
   if(rst) 
           q[1] <= 1'b0;  // rst=1 ise aninda 0 yap.
   else
           q[1] <= ~q[1]; // q[0] 0'dan 1'e cikinca, q[1] degerini tersle. 
 end
 
    // 3.Flip Flop
    // Bu blogu onceki bitin cikisi (q[1]) tetikliyor.
    always @(posedge q[1] or posedge rst) begin
    if(rst) 
        q[2] <= 1'b0; //  rst = 1 ise aninda 0 yap.
    else
        q[2] <= ~q[2]; // q[1] 0'dan 1'e cikinca, q[2] degerini tersle.
    end
    
    
    // 4.Flip Flop ( En yuksek degerlikli bit - MSB) 
    // Bu blogu da bir onceki bitin cikisi q[2] tetikliyor.
    always @(posedge q[2] or posedge rst) begin
    if(rst)
        q[3] <= 1'b0; // rst= 1 ise aninda 0 yap
    else
        q[3] <= ~q[3];  // q[2] 0'dan 1'e cikinca, q[3] degerini tersle
   end
    
 
endmodule
