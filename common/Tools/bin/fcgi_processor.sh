#!/bin/bash

socket=${IAS_APP_ENVIRONMENT}/runtime/fcgi-sockets/${1?}
shift
cmd=`which ias_qs_processor`

echo spawn-fcgi -n -s ${socket} -- ${cmd}  $*
exec spawn-fcgi -n -s ${socket} -- ${cmd}  $*

