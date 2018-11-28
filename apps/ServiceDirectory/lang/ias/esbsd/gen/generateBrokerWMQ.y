
IMPORT std::qs;
IMPORT std::default;

IMPORT ias::esbsd::web::esb::getApplications;
IMPORT ias::esbsd::web::esb::getInterfaces;

IMPORT ias::esbsd::gen::wmq::inc::mqsc;
IMPORT ias::esbsd::gen::wmq::inc::common;
IMPORT ias::esbsd::gen::wmq::inc::registry;

/* ************************************** */

PROGRAM ias::esbsd::gen::wmq::generateMQESB(VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	    				       VAR data  AS AnyType)
BEGIN

   VAR apps     AS GetApplications : "http://www.invenireaude.com/esbsd/esb/api"; 			    	  			 			    	  			 			    	 
   VAR ints     AS GetInterfaces   : "http://www.invenireaude.com/esbsd/esb/api"; 			    	  			 			    	  			 			    	 
   VAR registry AS Registry        : "http://www.invenireaude.org/qsystem/workers/spec";
   
   apps = ias::esbsd::web::esb::getApplications(ctx, apps);
   ints = ias::esbsd::web::esb::getInterfaces(ctx, ints);
   registry =  ias::esbsd::gen::wmq::inc::getSharedRegistry();
  
   
   //std::save("stdout",ias::esbsd::gen::wmq::inc::getQMGRName(registry, "qs.MQESB"));
   //std::save("stdout",apps);
   //std::save("stdout",ints);
  
   WITH a AS apps.applications DO BEGIN
     //ias::esbsd::gen::wmq::inc::client(a.id);
   END;
      
   WITH a AS apps.applications DO 
   	WITH i AS a.interfaceInstances DO BEGIN	

   	   IF i ISTYPE (ServerInterface : "http://www.invenireaude.com/esbsd") THEN
   		ias::esbsd::gen::wmq::inc::defInErr(
   					ias::esbsd::gen::wmq::inc::getQMGRName(registry, i.deployment.location.connectionAlias),
   					a.id +".S."+i.id
   		);

   	   IF i ISTYPE (ClientInterface : "http://www.invenireaude.com/esbsd") THEN BEGIN
   	   
   	    VAR interface AS InterfaceDefinition   : "http://www.invenireaude.com/esbsd";
   	    VAR persistance AS String;
	    VAR qmgr AS String;   		    
   	
   	    qmgr = ias::esbsd::gen::wmq::inc::getQMGRName(registry, i.deployment.location.connectionAlias);
   	    
   	    interface   = ias::esbsd::gen::wmq::inc::getInterface(ints, i.id);  	   
   	    persistance = ias::esbsd::gen::wmq::inc::getPersistance(interface);
   	    
   		ias::esbsd::gen::wmq::inc::defAlias(qmgr, a.id +".C."+i.id, "ESB.S." + a.id +"." + i.id, persistance);
   		
   		ias::esbsd::gen::wmq::inc::defInErr(qmgr, "ESB.S."+a.id +"."+i.id);
    		
   		IF interface.mode == "ClientServer" THEN BEGIN
   		    
   		    ias::esbsd::gen::wmq::inc::defInErr(qmgr, "ESB.X."+a.id +"."+i.id);
   		    ias::esbsd::gen::wmq::inc::defAlias(qmgr, "ESB.X."+a.id +"."+i.id, "ESB.X."+a.id +"."+i.id, persistance);
     		ias::esbsd::gen::wmq::inc::defInErr(qmgr, a.id +".C."+i.id);
   	    END;	

    END;
   END;
 
  WITH ca AS apps.applications DO
  	  WITH sa AS apps.applications DO
	   	WITH ci AS ca.interfaceInstances DO	
   			WITH si AS sa.interfaceInstances DO BEGIN
   	   			IF si.id == ci.id AND
   	   		   		si ISTYPE (ServerInterface : "http://www.invenireaude.com/esbsd") AND
   	   		   		ci ISTYPE (ClientInterface : "http://www.invenireaude.com/esbsd") THEN BEGIN
   	
  			 	    VAR interface   AS InterfaceDefinition   : "http://www.invenireaude.com/esbsd";
   	    			VAR persistance AS String;
	   		    	VAR qmgrClient  AS String;
	   		    	VAR qmgrServer  AS String;   		   		    
	   		    	
   		    		qmgrClient = ias::esbsd::gen::wmq::inc::getQMGRName(registry, ci.deployment.location.connectionAlias);
   	    			qmgrServer = ias::esbsd::gen::wmq::inc::getQMGRName(registry, si.deployment.location.connectionAlias);
   	    
   	    			interface   = ias::esbsd::gen::wmq::inc::getInterface(ints, si.id);  	   
   	    			persistance = ias::esbsd::gen::wmq::inc::getPersistance(interface);
  
   					ias::esbsd::gen::wmq::inc::defAlias(qmgrClient, "ESB.C."+ca.id +"."+sa.id +"."+si.id, sa.id +".S." + si.id, persistance);
   	
   					IF qmgrClient <> qmgrServer THEN
   							ias::esbsd::gen::wmq::inc::defQRemote(qmgrClient, qmgrServer, sa.id +".S." + si.id, persistance);
   							
   					IF interface.mode == "ClientServer" THEN BEGIN
   		    			ias::esbsd::gen::wmq::inc::defInErr(qmgrClient, "ESB.C."+ca.id +"."+si.id);
   	   				END;	

   			 END;
  		END;
  		
  		
  WITH ca AS apps.applications DO
   IF ca.id == "SHA" THEN 
   	WITH ci AS ca.interfaceInstances DO
   	 IF ci.id == "COLLECT" THEN BEGIN		
   		VAR qmgr AS String;   		    
		qmgr = ias::esbsd::gen::wmq::inc::getQMGRName(registry, ci.deployment.location.connectionAlias);

    	ias::esbsd::gen::wmq::inc::defInErr(qmgr, ca.id +".S.COLLECT.IN");
    	ias::esbsd::gen::wmq::inc::defAlias(qmgr, "ESB.C.COLLECT", ca.id +".S.COLLECT", "NO");
   END;
   	
END;	