#!/bin/bash


script_dir=$(dirname $(readlink -f ${BASH_SOURCE}))
base_dir=$(readlink -f ${script_dir}/../../../..)

cd $base_dir
pwd
sm_stop_service -ad

find APP-Environment/runtime/logs -name \*.out\* -exec rm -f {} \;
find APP-Environment/runtime/logs -name \*.err\* -exec rm -f {} \;
find APP-Environment/runtime/logs -name \*.log\* -exec rm -f {} \;

sm_start_service -ad
