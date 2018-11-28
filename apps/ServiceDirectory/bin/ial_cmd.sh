#!/bin/bash

script_dir=$(dirname $(readlink -f ${BASH_SOURCE}))

cd ${script_dir}/..

prog=${1?}

shift 1

ias_qs_processor -f svc/cmd/esbsd.qs.xml -l run esbsd::cmd::${prog} $* 
