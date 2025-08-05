module DSP48A1_tb();
reg RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP;
reg CLK,CARRYIN,CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP;
reg[17:0] A,B,D,BCIN;
reg [47:0] C,PCIN;
reg [7:0] OPMODE;
wire CARRYOUT,CARRYOUTF;
wire [47:0] P,PCOUT;
wire [35:0] M;
wire [17:0] BCOUT;
DSP48A1  test (A,B,C,D,CARRYIN,M,P,CARRYOUT,CARRYOUTF,CLK,OPMODE,CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP
,RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP,BCOUT,PCIN,PCOUT,BCIN);
initial begin
    CLK=0;
    forever
    #1 CLK=~CLK;
end
initial begin
 {RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP} =8'b11111111;
    A=$random;
    B=$random;
    C=$random;
    D=$random;
    PCIN=$random; 
    BCIN=$random;
    OPMODE=$random;
    CARRYIN=$random;
    CEA=$random;
    CEB=$random;
    CEC=$random;
    CECARRYIN=$random;
    CED=$random;
    CEM=$random;
    CEOPMODE=$random;
    CEP=$random;
    @(negedge CLK);
     if({P,M,CARRYOUT,CARRYOUTF,BCOUT,PCOUT}!=0) begin
        $display("ERROR IN RST");
        $stop;
    end
     {CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP}=8'b11111111;
   {RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP}=8'b00000000;

  //path1 
   OPMODE=8'b11011101;
    A=20;
    B=10;
    C=350;
    D=25;
    BCIN=$random;
    PCIN=$random;
    CARRYIN=$random;
    repeat(4) @(negedge CLK);
    if(BCOUT!='hf || M!='h12c || P!='h32 || PCOUT!='h32 || CARRYOUT!=0 || CARRYOUTF!=0) begin
        $display ("ERROR IN PATH1");
        $stop;
    end
    //path2
   OPMODE = 8'b00010000;
    A=20;
    B=10;
    C=350;
    D=25;
    PCIN=$random;
    BCIN=$random;
    CARRYIN=$random;
    repeat(3) @(negedge CLK);
    if(BCOUT!='h23 || M!='h2bc || P!=0 || PCOUT!=0 || CARRYOUT!=0 || CARRYOUTF!=0 )begin
        $display("ERROR IN PATH2");
        $stop;
    end
    //path3 
     OPMODE = 8'b00001010;
     A = 20;
     B = 10;
     C = 350; 
     D = 25;
     PCIN=$random;
    BCIN=$random;
    CARRYIN=$random;
    repeat(3) @(negedge CLK);
    if(BCOUT!='ha || M!='hc8 || P!=PCOUT || CARRYOUT!=CARRYOUTF) begin
        $display("ERROR IN PATH3");
        $stop;
    end
    //path4
     OPMODE = 8'b10100111;
     A=5;
     B=6;
     C=350;
     D=25;
     PCIN=3000;
     BCIN=$random;
     CARRYIN=$random;
     repeat(3)@(negedge CLK);
     if(BCOUT != 'h6 || M != 'h1e || P !='hfe6fffec0bb1 || PCOUT!='hfe6fffec0bb1 || CARRYOUT !=1 || CARRYOUTF != 1)begin
        $display("ERROR IN PATH4");
        $stop;
     end
     $stop;
    end
endmodule  









