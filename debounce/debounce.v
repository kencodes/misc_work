
///////////////////////////////////////////////////////////////////////////////
// debounce # (
//     .pCLKS(32'd 1_000_000) // number of clocks to count before signal is "stable"
// ) debounce_inst (
//     .iCLK(), .iRESET(), .oSIG(), .iSIG()
// );
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module debounce # (
  parameter pCLKS = 32'd 1_000_000) // around 20-50ms works OK for a button; 2-10us could work for an asynchronous machine source
(
  input iCLK,
  input iRESET, // active high reset
  input iSIG,
  output reg oSIG
);

integer debounceCtr = 0;

always @(posedge iCLK or posedge iRESET) begin
    if (iRESET)
    begin
        debounceCtr <= 0;
        oSIG <= 0;
    end
    else if (iSIG)
    begin // iSIG trying to go high
        if (!oSIG)
        begin // output low, increment counter
            if (debounceCtr < pCLKS)
            begin
                debounceCtr <= debounceCtr + 1;
                oSIG <= 0;
            end
            else
            begin
                debounceCtr <= 0;
                oSIG <= 1;
            end
        end
        else
        begin // output already high, do nothing
            debounceCtr <= 0;
        end
    end
    else
    begin // iSIG trying to go low
        if (oSIG)
        begin
            if (debounceCtr < pCLKS)
            begin // output high, increment counter
                debounceCtr <= debounceCtr + 1;
                oSIG <= 1;
            end
            else
            begin
                debounceCtr <= 0;
                oSIG <= 0;
            end
        end
        else
        begin // output already low, do nothing
            debounceCtr <= 0;
        end
    end
end

endmodule
