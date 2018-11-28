#!/bin/bash

script_dir=$(dirname $(readlink -f ${BASH_SOURCE}))

base_dir=$(readlink -f ${script_dir}/..)

if [ -z ${IAS_BASEDIR} ]
then
echo IAS environment was not set. Run . ./setenv.sh for main projects directory.
exit -1
fi


rm -f ${IAS_ESBSD_AUTOGEN?}/broker/svc/esb/*
rm -f ${IAS_ESBSD_AUTOGEN?}/broker/svc/*
rm -f ${IAS_ESBSD_AUTOGEN?}/broker/sm/*
rm -f ${IAS_ESBSD_AUTOGEN?}/broker/data/*
rm -f ${IAS_ESBSD_AUTOGEN?}/shm/*

mkdir -p ${IAS_ESBSD_AUTOGEN?}/broker/svc/esb
mkdir -p ${IAS_ESBSD_AUTOGEN?}/broker/sm
mkdir -p ${IAS_ESBSD_AUTOGEN?}/broker/data
mkdir -p ${IAS_ESBSD_AUTOGEN?}/shm/

export IAS_LANG_XSD="${IAS_LANG_XSD?}:${base_dir}/tools/smapi.xsd:${base_dir}/tools/smcfg.xsd"

(
  cd ${base_dir}

#Create database
echo Creating database
dbname=${IAS_ESBSD_AUTOGEN?}/broker/data/brokerdb.sqlite
rm -f ${dbname}
sqlite3 ${dbname} < ds/sqlite/sql/brokerdb.sql
ias_qs_processor -f svc/GEN.BrokerDB.qs.xml
ls -l ${dbname}

#Create services
ias_qs_processor -f svc/GEN.BrokerSvc.qs.xml
ls -l ${IAS_ESBSD_AUTOGEN?}/broker/svc


ias_qs_processor -f svc/GEN.BrokerSHM.qs.xml
)


