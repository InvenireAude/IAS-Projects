#!/bin/bash

script_dir=$(dirname $(readlink -f ${BASH_SOURCE}))
export IAS_BASEDIR=$(readlink -f ${script_dir}/..)
echo IAS_BASEDIR=$IAS_BASEDIR


export IAS_APP_PROJECTS=${IAS_BASEDIR}/APP-Projects
export IAS_APP_ENVIRONMENT=${IAS_BASEDIR}/APP-Environment
export IAS_PROJECTS=${IAS_BASEDIR}/IAS-Projects


IAS_ALL_COMMON_DIRS="${IAS_BASEDIR}/*/common"
IAS_ALL_APPS_DIRS="${IAS_BASEDIR}/*/apps"

echo $IAS_ALL_COMMON_DIRS

discover(){
result=`find $* -name ${1} 2>/dev/null | tr '\n' : | sed 's/:$//'`
echo $result
}

prettyPrint(){
  echo
  echo $1
  echo $2 | tr : \\n
}

export IAS_LANG_XSD=$(discover all.xsd $IAS_ALL_COMMON_DIRS):xsd/all.xsd
export IAS_SM_CFGDIR=$(discover sm $IAS_ALL_APPS_DIRS)
export IAS_LANG_SRC_DIRS=$(discover lang $IAS_ALL_COMMON_DIRS):lang
export IAS_LANG_SRC_DIRS_WEBBROWSE=$(discover lang $IAS_ALL_COMMON_DIRS $IAS_ALL_APPS_DIRS)
export PATH=$(discover bin $IAS_ALL_COMMON_DIRS):$PATH

prettyPrint IAS_LANG_XSD      $IAS_LANG_XSD
prettyPrint IAS_SM_CFGDIR     $IAS_SM_CFGDIR
prettyPrint IAS_LANG_SRC_DIRS $IAS_LANG_SRC_DIRS
prettyPrint IAS_LANG_SRC_DIRS_WEBBROWSE $IAS_LANG_SRC_DIRS_WEBBROWSE

export IAS_DBG_GLOBAL=-stacktrace,+error,-memory,-info,-trace,-system
export IAS_DBG_DM=-stacktrace,+error,-memory,-info,-trace,-system

export IAS_QS_REGISTRY_SHARED=${IAS_APP_ENVIRONMENT}/cfg/shared/registry/registry.xml
export IAS_QS_REGISTRY=${IAS_QS_REGISTRY_SHARED}:registry/registry.xml

export IAS_ESBSD=${IAS_APP_PROJECTS}/common/ServiceDirectory/esbsd
export IAS_ESBSD_AUTOGEN=${IAS_APP_ENVIRONMENT}/autogen
export IAS_SM_RUNTIME=${IAS_APP_ENVIRONMENT}/runtime
export IAS_QS_TEMPL_DIRS=templates
#. $IAS_APP_ENVIRONMENT/setenv.sh

