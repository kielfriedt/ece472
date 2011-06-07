//-----------------------------------------------------------------------------
// Title         : MIPS Pipelined Processor
// Project       : ECE 313 - Computer Organization
//-----------------------------------------------------------------------------
// File          : mips_single.v
// Author        : John Nestor  <nestorj@lafayette.edu>
// Organization  : Lafayette College
// 
// Created       : October 2002
// Last modified : 7 January 2005
//-----------------------------------------------------------------------------
// Description :
//   Pipelined implementation of the MIPS processor subset described in
//   Section 6.3 of "Computer Organization and Design, 3rd ed."
//   by David Patterson & John Hennessey, Morgan Kaufmann, 2004 (COD3e).  
//
//   It implements the equivalent of Figure 6.27 on page 404 of COD3e
//
//-----------------------------------------------------------------------------

module mips_pipeline(clk, reset);
input clk, reset;

    // ********************************************************************
    //                              Signal Declarations
    // ********************************************************************

    // IF Signal Declarations
    
    wire [31:0] IF_instr, IF_pc, IF_pc_next, IF_pc_final, IF_pc4, IF_PCTOP4, NO_STALL_PC;
    wire IF_Jumper;

    // ID Signal Declarations

    reg [31:0] IFPCPrev; //this holds the previous PC value

    reg [31:0]  ID_instr, ID_pc4;  // pipeline register values from EX

    wire [5:0]  ID_op;
    wire [4:0]  ID_rs, ID_rt, ID_rd;
    wire [15:0] ID_immed;
    wire [31:0] ID_extend, ID_rd1, ID_rd2;
    
    //added these three wires for the jump
    wire [31:0] ID_JumperNotSignExtended;
    wire [31:0] IDIF_JumperSignExtended;
    wire [31:0] IF_JumperPC;

    assign ID_op = ID_instr[31:26];
    assign ID_rs = ID_instr[25:21];
    assign ID_rt = ID_instr[20:16];
    assign ID_rd = ID_instr[15:11];
    assign ID_immed = ID_instr[15:0];

    wire ID_RegWrite, ID_Branch, ID_RegDst, ID_MemtoReg,  // ID Control signals
         ID_MemRead, ID_MemWrite, ID_ALUSrc;
    wire [1:0] ID_ALUOp;

    // EX Signals

    reg  [31:0] EX_pc4, EX_extend, EX_rd1, EX_rd2;
    wire [31:0] EX_offset, EX_btgt, EX_alub, EX_ALUOut;
    reg  [4:0]  EX_rt, EX_rd, EX_rs;
    wire [4:0]  EX_RegRd;
    wire [5:0]  EX_funct;
       
     // RAM: added extra wires to implement extra muxes required for forwarding
    wire [31:0] EX_forwarding_out_a, EX_forwarding_out_b;
    wire [1:0]  EX_forwarding_a, EX_forwarding_b;
    
    reg  EX_RegWrite, EX_Branch, EX_RegDst, EX_MemtoReg,  // EX Control Signals
         EX_MemRead, EX_MemWrite, EX_ALUSrc;

    wire EX_Zero;

    reg  [1:0] EX_ALUOp;
    wire [2:0] EX_Operation;

   // MEM Signals

    wire MEM_PCSrc;

    reg  MEM_RegWrite, MEM_Branch, MEM_MemtoReg, 
         MEM_MemRead, MEM_MemWrite, MEM_Zero;

    reg  [31:0] MEM_btgt, MEM_ALUOut, MEM_rd2;
    wire [31:0] MEM_memout;
    reg  [4:0] MEM_RegRd;

    // WB Signals

    reg WB_RegWrite, WB_MemtoReg;  // WB Control Signals

    reg  [31:0] WB_memout, WB_ALUOut;
    wire [31:0] WB_wd;
    reg  [4:0] WB_RegRd;
    
    

    // ********************************************************************
    //                              IF Stage
    // ********************************************************************

    // IF Hardware

    //changed IF_pc_next to IF_pc_final, which is the signal out of IF_JPCMUX
    reg32		IF_PC(clk, reset, IF_pc_final, IF_pc); 
    
    add32 	IF_PCADD(IF_pc, 32'd4, NO_STALL_PC);
    
    mux2   IF_PCMUX_STALL(HDU_PCWrite, NO_STALL_PC, ID_pc4, IF_pc4 );
    
    assign IF_PCTOP4[31:0] = 32'd0;
    assign IF_PCTOP4[31:27] = IF_pc4[31:27];
    
    /*   ADDER HERE   */
    //adder that will add the IDIF_JumperSignExtended with IF_PC4 and result in IF_JPC
    add32   IF_JADD(IDIF_JumperSignExtended, IF_PCTOP4, IF_JumperPC);
  
    mux2 #(32)	IF_PCMUX(MEM_PCSrc, IF_pc4, MEM_btgt, IF_pc_next);
  
    /* JPCMUX */  
    //mux that acts as an intermediary between the IF_PCMUX and the IF_PC. 
    //Selects output based on IF_Jumper, which is set in the ID stage.
    //IF_JumperPC is the 2 bit extended 26 bottom bits of the opcode added with the top 4 bits of the PC
    mux2 #(32) IF_JumperPCMUX(IF_Jumper, IF_pc_next, IF_JumperPC, IF_pc_final);
    
    ///mux2 #(1) IF_STALLMUX(HDU_PCWrite, IF_pc_final, IFPCPrev, IF_PCInput);
    
    rom32 		IMEM(IF_pc, IF_instr);

    always @(posedge clk)		    // IF/ID Pipeline Register
    begin
        if (reset)
        begin
            ID_instr <= 0;
            ID_pc4   <= 0;
        end
        else if (HDU_PCWrite)
        begin
            ID_instr <= ID_instr;
            ID_pc4   <= ID_pc4;
        end    
        else 
        begin
            ID_instr <= IF_instr;
            ID_pc4   <= IF_pc_final;
        end
    end

    // ********************************************************************
    //                              ID Stage
    // ********************************************************************
    
    //HDU here, need to figure out what it needs.
    //EX_MEMRead, EX_rt, ID_Rt, ID_Rs, Control_Mux_Signal, PCWrite

    reg_file	RFILE(clk, WB_RegWrite, ID_rs, ID_rt, WB_RegRd, ID_rd1, ID_rd2, WB_wd);

    // sign-extender
    assign ID_extend = { {16{ID_immed[15]}}, ID_immed };
    
    assign ID_JumperNotSignExtended[31:27] = 4'd0;
    assign ID_JumperNotSignExtended[26:0] = ID_instr[26:0];
    
    //2 sign-extender for J
    assign IDIF_JumperSignExtended = ID_JumperNotSignExtended << 2;
    assign IDIF_JumperSignExtended[31:27] = 4'd0;
    
    //wire HDU_MuxCtl, HDU_PCWrite;
    
    HazardDetect HDU(clk, reset, EX_MemRead, EX_rt, EX_rs, ID_rt, ID_rs, HDU_MuxCtl, HDU_PCWrite);

    control_pipeline CTL(.opcode(ID_op), .RegDst(ID_RegDst),
                       .ALUSrc(ID_ALUSrc), .MemtoReg(ID_MemtoReg), 
                       .RegWrite(ID_RegWrite), .MemRead(ID_MemRead),
                       .MemWrite(ID_MemWrite), .Branch(ID_Branch), 
                       .ALUOp(ID_ALUOp), .Jumper(IF_Jumper));


    always @(posedge clk)		    // ID/EX Pipeline Register
    begin
        if (reset || HDU_MuxCtl)
        begin
            EX_RegDst   <= 0;
	          EX_ALUOp    <= 0;
            EX_ALUSrc   <= 0;
            EX_Branch   <= 0;
            EX_MemRead  <= 0;
            EX_MemWrite <= 0;
            EX_RegWrite <= 0;
            EX_MemtoReg <= 0;
            EX_RegDst   <= 0;
            EX_ALUOp    <= 0;
            EX_ALUSrc   <= 0;
            EX_Branch   <= 0;
            EX_MemRead  <= 0;
            EX_MemWrite <= 0;
            EX_RegWrite <= 0;
            EX_MemtoReg <= 0;

            EX_pc4      <= 0;
            EX_rd1      <= 0;
            EX_rd2      <= 0;
            EX_extend   <= 0;
            EX_rt       <= 0;
            EX_rd       <= 0;
        end
        else begin
            
            EX_RegDst   <= ID_RegDst;
            EX_ALUOp    <= ID_ALUOp;
            EX_ALUSrc   <= ID_ALUSrc;
            EX_Branch   <= ID_Branch;
            EX_MemRead  <= ID_MemRead;
            EX_MemWrite <= ID_MemWrite;
            EX_RegWrite <= ID_RegWrite;
            EX_MemtoReg <= ID_MemtoReg;
            EX_RegDst   <= ID_RegDst;
            EX_ALUOp    <= ID_ALUOp;
            EX_ALUSrc   <= ID_ALUSrc;
            EX_Branch   <= ID_Branch;
            EX_MemRead  <= ID_MemRead;
            EX_MemWrite <= ID_MemWrite;
            EX_RegWrite <= ID_RegWrite;
            EX_MemtoReg <= ID_MemtoReg;
            EX_pc4      <= ID_pc4;
            EX_rd1      <= ID_rd1;
            EX_rd2      <= ID_rd2;
            EX_extend   <= ID_extend;
            EX_rt       <= ID_rt;
            EX_rd       <= ID_rd;
            EX_rs       <= ID_rs;
        end  
    end

    // ********************************************************************
    //                              EX Stage
    // ********************************************************************

    // branch offset shifter
    assign EX_offset = EX_extend << 2;

    assign EX_funct = EX_extend[5:0];  

    add32 		EX_BRADD(EX_pc4, EX_offset, EX_btgt);

    mux2 #(32) 	ALUMUX(EX_ALUSrc, EX_rd2, EX_extend, EX_alub);
    
    //Forwarding unit mcjazz
	ForwardUnit EX_Forward_Unit(EX_rs, EX_rt, MEM_RegRd, WB_RegRd, MEM_RegWrite, WB_RegWrite, EX_forwarding_a, EX_forwarding_b);
       
    mux3 ALUMUX_FWD_A( EX_forwarding_a, 
    				   EX_rd1,		// input 00 
    				   MEM_ALUOut,	// input 01
    				   WB_wd,  		// input 10
    				   EX_forwarding_out_a );
    				   
    mux3 ALUMUX_FWD_B( EX_forwarding_b, 
    				   EX_alub, 	// input 00 
    				   MEM_ALUOut,	// input 01
    				   WB_wd, 		// input 10
    				   EX_forwarding_out_b );

    alu 		EX_ALU(EX_Operation, EX_forwarding_out_a, EX_forwarding_out_b, EX_ALUOut, EX_Zero);

    mux2 #(5) 	EX_RFMUX(EX_RegDst, EX_rt, EX_rd, EX_RegRd);

    alu_ctl 	EX_ALUCTL(EX_ALUOp, EX_funct, EX_Operation);
    
    

    always @(posedge clk)		    // EX/MEM Pipeline Register
    begin
        if (reset)
        begin
            MEM_Branch   <= 0;
            MEM_MemRead  <= 0;
            MEM_MemWrite <= 0;
            MEM_RegWrite <= 0;
            MEM_MemtoReg <= 0;
            MEM_Zero     <= 0;

            MEM_btgt     <= 0;
            MEM_ALUOut   <= 0;
            MEM_rd2      <= 0;
            MEM_RegRd    <= 0;
        end
        else begin
            MEM_Branch   <= EX_Branch;
            MEM_MemRead  <= EX_MemRead;
            MEM_MemWrite <= EX_MemWrite;
            MEM_RegWrite <= EX_RegWrite;
            MEM_MemtoReg <= EX_MemtoReg;
            MEM_Zero     <= EX_Zero;

            MEM_btgt     <= EX_btgt;
            MEM_ALUOut   <= EX_ALUOut;
            MEM_rd2      <= EX_rd2;
            MEM_RegRd    <= EX_RegRd;
        end
    end

    //forwarding unit here, will take in EX_rt, EX_rd, MEM_RegRd, WB_RedRd, MEM_RegRd, EX_MemWrite, EX_RegWrite, MEM_MemWrite, MEM_RegWrite

    // ********************************************************************
    //                              MEM Stage
    // ********************************************************************

    mem32 		MEM_DMEM(clk, MEM_MemRead, MEM_MemWrite, MEM_ALUOut, MEM_rd2, MEM_memout);

    and  		MEM_BR_AND(MEM_PCSrc, MEM_Branch, MEM_Zero);

    always @(posedge clk)		// MEM/WB Pipeline Register
    begin
        if (reset)
        begin
            WB_RegWrite <= 0;
            WB_MemtoReg <= 0;
            WB_ALUOut   <= 0;
            WB_memout   <= 0;
            WB_RegRd    <= 0;
        end
        else begin
            WB_RegWrite <= MEM_RegWrite;
            WB_MemtoReg <= MEM_MemtoReg;
            WB_ALUOut   <= MEM_ALUOut;
            WB_memout   <= MEM_memout;
            WB_RegRd    <= MEM_RegRd;
        end
    end       

    // ********************************************************************
    //                              WB Stage
    // ********************************************************************

    mux2 #(32)	WB_WRMUX(WB_MemtoReg, WB_ALUOut, WB_memout, WB_wd);


endmodule


