# SimpleHash: Verilog-Based Hash Function

## Overview

SimpleHash is a hardware-oriented keyed hash function implemented in Verilog. It processes a 16-bit input message and an 8-bit key to generate an 8-bit hash value.

The design uses XOR-based mixing, bit shifts, rotations, fixed constants, and S-box substitution. A Verilog testbench is included for functional simulation, exhaustive input testing, output distribution analysis, and waveform generation.

## Features

* Keyed 8-bit hash generation for 16-bit input messages.
* XOR operations, bit shifts, and rotations for input mixing.
* 4-bit S-box substitution for non-linear transformation.
* Testbench for functional verification and waveform analysis.
* Avalanche-effect demonstration using closely related inputs.
* Exhaustive testing of all 65,536 possible 16-bit inputs.
* Hash distribution analysis using 256 histogram buckets.
* VCD waveform generation for signal inspection.

## Design Flow

The 16-bit input is divided into two 8-bit halves and processed through two mixing stages using the input key, XOR operations, shifts, rotations, and fixed constants.

The intermediate result is passed through a 4-bit S-box substitution layer. A final XOR-based mixing stage produces the 8-bit hash output.

## Testing and Verification

The testbench:

* Tests representative input values.
* Compares closely related inputs to observe changes in hash output.
* Processes the complete 16-bit input space.
* Calculates the number of distinct hash values generated.
* Reports minimum and maximum histogram bucket counts.
* Generates a `SimpleHash.vcd` file for waveform analysis.

## Project Structure

```text
SimpleHash/
├── SimpleHash.v
├── SimpleHash_tb.v
└── README.md
```

## Running the Project

Compile the Verilog files using Icarus Verilog:

```bash
iverilog -o SimpleHash_sim SimpleHash.v SimpleHash_tb.v
```

Run the simulation:

```bash
vvp SimpleHash_sim
```

View the generated waveform using GTKWave:

```bash
gtkwave SimpleHash.vcd
```

## Technologies Used

* Verilog HDL
* Icarus Verilog
* GTKWave
* Digital Logic Design
* Hardware Simulation and Verification


