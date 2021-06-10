#!/bin/bash

# author: cw1997 <changwei1006@gmail.com>
# repo: https://github.com/cw1997/verilog-port-list-parser
# data: 2021-06-11 00:52:19

NAME='Verilog'
START='start'
FILE='../../port.v'
OUTPUT_DIRECTORY='./output'

java org.antlr.v4.Tool ${NAME}.g4 -o ${OUTPUT_DIRECTORY} && \
javac ${OUTPUT_DIRECTORY}/*.java && \
cd ${OUTPUT_DIRECTORY} && \
java org.antlr.v4.gui.TestRig ${NAME} ${START} -gui ${FILE}
