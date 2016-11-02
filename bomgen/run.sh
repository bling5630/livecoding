#!/bin/sh

export BOMGEN_WERROR="1"
export BOMGEN_FORMAT="EXPORT"
export BOMGEN_DATAPATH="$PWD/data"

stack exec bomgen


