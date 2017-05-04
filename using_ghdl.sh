#!/bin/bash

ghdl -a *.vhdl // (Analyse der VHDL-Sourcen)
ghdl -s *.vhdl // (Syntax-Check VHDL-Sourcen)
ghdl -e testbench // (Compilieren/Linken der VHDL-Sourcen)
ghdl -r testbench –stop-time=1ms –vcd=testbench.vcd // (Starten der Simulation)
gtkwave testbench.vcd // (Ansehen der Signalverläufe)
