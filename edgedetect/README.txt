Single bit edge detector
- Does not synchronize an asynchronous input
- Outputs a single clock pulse at the rising and falling edges
- Rising edge pulse is coincident with the rising edge of the input signal
- Falling edge pulse is 1 clock after falling edge of the input signal
- Output "oRFE" is "Rising AND Falling Edge" detector.
  Pulses on both edges, with same timing as rising and falling
  edge outputs
- The edge detector outputs can be optionally registered, if timing is a concern

Instantiation Template:
edgedetect # (.registered("TRUE")) edgedetect_inst (.iCLK(), .iRST(), .iSIG(), .oRE(), .oFE(), oRFE());
