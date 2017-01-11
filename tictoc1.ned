//
// This file is part of an OMNeT++/OMNEST simulation example.
//
// Copyright (C) 2003 Ahmet Sekercioglu
// Copyright (C) 2003-2015 Andras Varga
//
// This file is distributed WITHOUT ANY WARRANTY. See the file
// `license' for details on this and other legal matters.
//
import ned.DatarateChannel;

simple Txc1
{
    gates:
        input in;
        output out;
}

//
// Two instances (tic and toc) of Txc1 connected both ways.
// Tic and toc will pass messages to one another.
//
network Tictoc1
{
    @display("bgb=530,341");
    submodules:
        tic: Txc1;
        toc: Txc1;
    connections:
        tic.out --> DatarateChannel {  delay = default(100ms); per = default(0.4); datarate = default(10000bps); } --> toc.in;
        toc.out --> DatarateChannel  {  delay = default(100ms); per = default(0.4); datarate = default(10000bps); } --> tic.in;
}

