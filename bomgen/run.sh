#!/bin/sh

export BOMGEN_FORMAT="FOO"
#export BOMGEN_ERROR="BINGO"
export BOMGEN_DATAPATH="$PWD/data/parts.csv"

stack exec bomgen
