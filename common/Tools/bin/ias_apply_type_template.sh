#!/bin/bash

script_dir=$(dirname $(readlink -f ${BASH_SOURCE}))

cd ${script_dir}/..

#prog=${1?}
#shift 1

prog=applyTypeTemplate
unset IAS_QS_REGISTRY
ias_qs_processor -f svc/cmd/applyTypeTemplate.qs.xml -l run ias::tools::cmd::${prog} $*
