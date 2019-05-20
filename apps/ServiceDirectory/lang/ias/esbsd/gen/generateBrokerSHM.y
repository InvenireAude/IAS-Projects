
IMPORT std::qs;
IMPORT std::default;

IMPORT ias::esbsd::web::esb::getApplications;
IMPORT ias::esbsd::web::esb::getInterfaces;

IMPORT ias::esbsd::gen::inc::shm;
IMPORT ias::esbsd::gen::inc::common;
IMPORT ias::esbsd::gen::inc::registry;

/* ************************************** */

PROGRAM ias::esbsd::gen::generateBrokerSHM(VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	    				       VAR data  AS AnyType)
BEGIN

   VAR apps     AS GetApplications : "http://www.invenireaude.com/esbsd/esb/api";
   VAR ints     AS GetInterfaces   : "http://www.invenireaude.com/esbsd/esb/api";
   VAR registry AS Registry        : "http://www.invenireaude.org/qsystem/workers/spec";

   apps = ias::esbsd::web::esb::getApplications(ctx, apps);
   ints = ias::esbsd::web::esb::getInterfaces(ctx, ints);
   registry =  ias::esbsd::gen::inc::getSharedRegistry();

   VAR systems AS ARRAY OF System : "http://www.invenireaude.org/qsystem";
   INDEX systems USING name;

   WITH a AS apps.applications DO
   	WITH i AS a.interfaceInstances DO BEGIN
      VAR qmgr AS String;
      qmgr = ias::esbsd::gen::inc::getQMGRName(registry, i.deployment.location.connectionAlias);

      IF NOT ISSET(systems[[ qmgr ]]) THEN BEGIN

       CREATE systems BEGIN
         name = qmgr;
       END;

       	ias::esbsd::gen::inc::shm::defInErr(systems[[ qmgr ]], "ESB.S.COLLECT");
      	ias::esbsd::gen::inc::shm::defAlias(systems[[ qmgr ]], "ESB.C.COLLECT", "ESB.S.COLLECT", "NO");

       	ias::esbsd::gen::inc::shm::defInErr(systems[[ qmgr ]], "ESB.S.EXCEPTION");

       END;

    END;


   WITH a AS apps.applications DO BEGIN
     //ias::esbsd::gen::inc::shm::client(a.id);
   END;

   WITH a AS apps.applications DO BEGIN
       VAR appSystems AS ARRAY OF System : "http://www.invenireaude.org/qsystem";
       INDEX appSystems USING name;

   	WITH i AS a.interfaceInstances DO BEGIN

  	   VAR qmgr AS String;
	     qmgr = ias::esbsd::gen::inc::getQMGRName(registry, i.deployment.location.connectionAlias);

       IF NOT ISSET(appSystems[[ qmgr ]]) THEN BEGIN
          CREATE appSystems BEGIN
            name = qmgr;
          END;
    	    ias::esbsd::gen::inc::shm::defAlias(systems[[ qmgr ]], a.id + ".C.EXCEPTION", "ESB.S.EXCEPTION", "NO");
      END;

   	   IF i ISTYPE (ServerInterface : "http://www.invenireaude.com/esbsd") THEN BEGIN
         ias::esbsd::gen::inc::shm::defInErr( systems[[ qmgr ]], a.id +".S."+i.id );
      END;

   	   IF i ISTYPE (ClientInterface : "http://www.invenireaude.com/esbsd") THEN BEGIN

   	    VAR interface AS InterfaceDefinition   : "http://www.invenireaude.com/esbsd";
   	    VAR persistance AS String;

   	    interface   = ias::esbsd::gen::inc::getInterface(ints, i.id);
   	    persistance = ias::esbsd::gen::inc::getPersistance(interface);

   		ias::esbsd::gen::inc::shm::defAlias(systems[[ qmgr ]], a.id +".C."+i.id, "ESB.S." + a.id +"." + i.id, persistance);
      ias::esbsd::gen::inc::shm::defInErr(systems[[ qmgr ]], a.id +".C."+i.id);
   		ias::esbsd::gen::inc::shm::defInErr(systems[[ qmgr ]], "ESB.S."+a.id +"."+i.id);

    END;
   END;
  END;

  WITH ca AS apps.applications DO
	   	WITH ci AS ca.interfaceInstances DO BEGIN

		  	VAR qmgrClient  AS String;
	   		qmgrClient = ias::esbsd::gen::inc::getQMGRName(registry, ci.deployment.location.connectionAlias);

        VAR hasReplies AS Boolean;
        hasReplies = FALSE;

    	 WITH sa AS apps.applications DO
     			WITH si AS sa.interfaceInstances DO BEGIN
   	   			IF si.id == ci.id AND
   	   		   		si ISTYPE (ServerInterface : "http://www.invenireaude.com/esbsd") AND
   	   		   		ci ISTYPE (ClientInterface : "http://www.invenireaude.com/esbsd") THEN BEGIN

  			 	    VAR interface   AS InterfaceDefinition   : "http://www.invenireaude.com/esbsd";
   	    			VAR persistance AS String;
	   		    	VAR qmgrServer  AS String;

   	     			qmgrServer = ias::esbsd::gen::inc::getQMGRName(registry, si.deployment.location.connectionAlias);

   	    			interface   = ias::esbsd::gen::inc::getInterface(ints, si.id);
   	    			persistance = ias::esbsd::gen::inc::getPersistance(interface);

   					  ias::esbsd::gen::inc::shm::defAlias(systems[[ qmgrClient ]], "ESB.C."+ca.id +"."+sa.id +"."+si.id, sa.id +".S." + si.id, persistance);

   					IF qmgrClient <> qmgrServer THEN
   							ias::esbsd::gen::inc::shm::defQRemote(systems[[ qmgrClient ]], systems[[ qmgrServer ]], sa.id +".S." + si.id, persistance);

   					IF interface.mode == "ClientServer" THEN BEGIN
   		    			hasReplies = TRUE;
   	   			END;

   			 END;
        END;

        IF hasReplies == TRUE THEN
          ias::esbsd::gen::inc::shm::defInErr(systems[[ qmgrClient ]], "ESB.C."+ca.id +"."+ci.id);

  		END;


  WITH s AS systems DO BEGIN

    WITH s DO BEGIN

     CREATE memory BEGIN
      heap.value  = 5000000;
      queue.value = 5000000;
      data.value  = 50000000;
     END;

     CREATE sessions BEGIN
      maxSessions=100;
     END;

     CREATE queues BEGIN
      maxQueues=100;
      dftSize=100;
     END;

     CREATE content BEGIN
      maxEntries=1000;
     END;

    END;

    SORT s.actions USING ias::esbsd::gen::inc::shm::compareAction;

  //  std::save("stdout",s);
    VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers";
    ctx.MID = s.name;
    std::send("output",ctx,s);
  END;


END;