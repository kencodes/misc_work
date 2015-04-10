To use setBuildtime.tcl, do the following in your Vivado project:

1) In "Synthesis Settings"...
  1a)  Click the text field next to "tcl.pre" and browse to the setBuildtime.tcl file
  1b)  In the "More Options" field, enter the string:

    -generic COMPILATION_DATECODE=$buildtimeHDL

*** Note: "-generic" is a Vivado Tcl command that allows Tcl to specify the value of VHDL generics, or Verilog parameters
  
  
  
2) In your top level Verilog, include the following line

    parameter COMPILATION_DATECODE = 32'b0;



3) Connect the parameter COMPILATION_DATECODE to a read-only register connected to the host. E.g.:
    
    <your address decoder>
    ...
    else if (rd_addr_i[15:0] == `COMPILE_DATECODE_ADDRESS) PCIe_DataOut_o <= SYNTHESIS_DATECODE;
    ...



4) When the design is synthesized, the Vivado synthesis log should contain lines similar to this:

    ...
    # synth_design -top myFPGA_top -part xc7k160tfbg676-2 -flatten_hierarchy none -generic COMPILATION_DATECODE=$buildtimeHDL
    Command: synth_design -top myFPGA_top -part xc7k160tfbg676-2 -flatten_hierarchy none -generic COMPILATION_DATECODE=32'h14031010

    Starting synthesis...
    ...
    ---------------------------------------------------------------------------------
    Starting RTL Elaboration : Time (s): cpu = 00:00:05 ; elapsed = 00:00:27 . Memory (MB): peak = 245.836 ; gain = 98.844
    ---------------------------------------------------------------------------------
    INFO: [Synth 8-638] synthesizing module 'myFPGA_top' [C:/Work/branches/myFPGA/myFPGA_top.srcs/sources_1/imports/myFPGA_top.v:90]
      Parameter COMPILATION_DATECODE bound to: 335745040 - type: integer 
    ...


5) OPTIONAL - When write_bitstream is run, use "write_bitstream $buildtimeVal.bit" to automatically name your .bit file with your buildtime value that will be read by software

