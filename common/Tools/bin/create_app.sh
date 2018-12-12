#!/bin/bash

appfull=${1?}

script_dir=$(dirname $(readlink -f ${BASH_SOURCE}))
base_dir=$(readlink -f ${script_dir}/../../../..)

echo $appfull
appbase=$(basename $appfull)
appbasel=$(echo $appbase | tr '[:upper:]' '[:lower:]')
appdir=${appfull/\/${appbase}/}
echo $appbase
echo $appdir

cd $base_dir

mkdir -p ${appfull}/lang
mkdir -p ${appfull}/svc
mkdir -p ${appfull}/sm
mkdir -p ${appfull}/registry

cat >${appfull}/sm/SMServices.xml <<EOF
<?xml version="1.0" encoding="ASCII"?>
<ns0:serviceConfig xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xmlns:ns0="http://www.invenireaude.org/sm/cfg" xsi:type="ns0:ServiceConfig" xsi:schemaLocation="http://www.invenireaude.org/sm/cfg ../../../../../IAS/IAS-ServiceManagerLib/xsd/smcfg.xsd">

   <services name="app.${appbasel}.svc.inquiry">
           <grpAttrs name="type" value="adp" />
           <grpAttrs name="mon"  value="yes" />
           <grpAttrs name="appl" value="cif" />
           <grpAttrs name="interface" value="inquiry" />
           <startCmd>
                        <exe>ias_qs_processor</exe>
                        <args>-f</args>
                        <args>svc/${appbase}.INQUIRY.qs.xml</args>
                        <args>-T</args>
                        <args>1</args>
                </startCmd>
                <resGrp>rg.app.${appbasel}.inquiry</resGrp>
   </services>

</ns0:serviceConfig>
EOF

mkdir -p APP-Environment/cfg/${appfull}/sm

cat >APP-Environment/cfg/${appfull}/sm/SMDeployment.xml <<EOF

<?xml version="1.0" encoding="ASCII"?>
<ns0:deploymentConfig xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ns0="http://www.invenireaude.org/sm/cfg"
	xsi:type="ns0:DeploymentConfig"	xsi:schemaLocation="http://www.invenireaude.org/sm/cfg ../../../../../IAS/IAS-ServiceManagerLib/xsd/smcfg.xsd">

  <lckDir>${IAS_SM_RUNTIME}/locks</lckDir>

	<refreshMS>1000</refreshMS>

	<resources name="rg.app.${appbasel}.inquiry">
	    <logDir>${IAS_SM_RUNTIME}/logs</logDir>
		<count>1</count>
		<exe xsi:type="ns0:ResourceGroupExe"/>
		 <env>
		   <vars name="PWD" value="\${IAS_APP_PROJECTS}/apps/${appbase}"/>
		   <vars name="IAS_DBG_GLOBAL" value="+memorytrace,-info,+stacktrace,+errors,-data"/>
		</env>
	</resources>

</ns0:deploymentConfig>
EOF

mkdir -p APP-Environment/cfg/${appfull}/registry

cat >APP-Environment/cfg/${appfull}/registry/registry.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<ns0:specification
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:ns0="http://www.invenireaude.org/qsystem/workers/spec"
  xsi:type="ns0:Registry">

   <io>

       <connections alias="front-end__">
       	 <protocol>fcgi</protocol>
         <host>localhost</host>
       </connections>

       <connections alias="front-end-old__">
         <protocol>asrvhttp</protocol>
         <host>localhost</host>
         <port>55100</port>
       </connections>

   </io>

    <ds>

     <connections alias="ds___">
         <protocol>postgresql</protocol>
         <user>__</user>
         <password>__</password>
         <location>__</location>
     </connections>

   </ds>

</ns0:specification>
EOF


(
 cd ${appfull}/sm
 ln -s ../../../../APP-Environment/cfg/${appfull}/sm/SMDeployment.xml .
)

(
 cd ${appfull}/registry
 ln -s ../../../../APP-Environment/cfg/${appfull}/registry/registry.xml .
)

