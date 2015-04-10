This is a simple parameterized debouncer circuit, intended to make noisy, asynchronous signals, stable and synchronous with a logic clock.

The parameter pCLKS is the number of clock cycles for which the input signal must be STABLE before the debouncer will output that logic level.

When the output of the debouncer is low, the input must stay HIGH for pCLKS, after which time the output of the debouncer will transition, synchronously, to the high state.  When the output of the debouncer is high, the input must stay LOW for pCLKS, after which the debouncer will transition, synchronously, to the low state.
