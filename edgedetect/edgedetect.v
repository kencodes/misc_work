// Single bit edge detector
// - Does not synchronize an asynchronous input
// - Outputs a single clock pulse at the rising and falling edges
// - Rising edge pulse is coincident with the rising edge of iSIG
// - Falling edge pulse is 1 clock after falling edge of iSIG
// - Output "oRFE" is "Rising AND Falling Edge" detector.
//   Pulses on both edges, with same timing as rising and falling
//   edge outputs

// Instantiation Template:
// edgedetect # (.registered("TRUE")) edgedetect_inst (.iCLK(), .iRST(), .iSIG(), .oRE(), .oFE(), oRFE());

`timescale 1ns/1ns

module edgedetect (
    input iCLK      ,
    input iRST      ,
    input iSIG      ,
    output wire oRE ,
    output wire oFE ,
    output wire oRFE
);

parameter registered = "FALSE";

reg delay;

wire re;
wire fe;
wire rfe;


always @(posedge iCLK)
begin
    if (iRST)
    begin
        delay <= 1'b0;
    end
    else
    begin
        delay <= iSIG;
    end
end


// Edge detect logic
assign re   = (iSIG && !delay) ? 1'b1 : 1'b0;
assign fe   = (!iSIG && delay) ? 1'b1 : 1'b0;
assign rfe  = ((iSIG && !delay) || (!iSIG && delay)) ? 1'b1 : 1'b0;


// Register edge detect pulses
reg re_reg, fe_reg, rfe_reg;
always @(posedge iCLK)
begin
    if (iRST)
    begin
        re_reg     <= 1'b0;
        fe_reg     <= 1'b0;
        rfe_reg    <= 1'b0;
    end
    else
    begin
        re_reg     <= re;
        fe_reg     <= fe;
        rfe_reg    <= rfe;
    end
end


// MUX either the combination or registered edge detect pulses to the outputs
assign oRE =    (registered == "TRUE") ? re_reg  : re ;
assign oFE =    (registered == "TRUE") ? fe_reg  : fe ;
assign oRFE =   (registered == "TRUE") ? rfe_reg : rfe;


endmodule
