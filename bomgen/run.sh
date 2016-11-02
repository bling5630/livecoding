#!/bin/sh

export BOMGEN_FORMAT="FOO"
export BOMGEN_FORMAT="EXPORT"
export BOMGEN_DATAPATH="$PWD/data"

stack exec bomgen
