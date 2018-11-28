
IMPORT std::qs;
IMPORT std::default;

IMPORT ias::esbsd::web::esb::getApplications;
IMPORT ias::esbsd::web::esb::getInterfaces;

IMPORT ias::esbsd::gen::inc::common;


/* ************************************** */

PROGRAM ias::esbsd::gen::generateBrokerSvc(VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	    				           VAR data  AS AnyType)
BEGIN

   VAR apps AS GetApplications : "http://www.invenireaude.com/esbsd/esb/api";
   VAR ints AS GetInterfaces   : "http://www.invenireaude.com/esbsd/esb/api";

   apps = ias::esbsd::web::esb::getApplications(ctx, apps);
   ints = ias::esbsd::web::esb::getInterfaces(ctx, ints);

   VAR cfgSM AS ServiceConfig : "http://www.invenireaude.org/sm/cfg";

   VAR cfgTester AS Specification  : "http://www.invenireaude.org/qsystem/workers/spec";

   	cfgTester.logicSpec.logics = NEW ExplicitExecute : "http://www.invenireaude.org/qsystem/workers/logic" BEGIN
  		 name = "proxy";
  		 instances = 1;
  		 input = "input";
  		 output = "output";
  		 error = "output";
  		 load = "ias::esbsd::web::tester::proxy";
  		 load = "ias::esbsd::web::tester::convert";
  		 run = COPYOF(load);
  	  END;

   cfgTester.inputSpec.inputs = NEW ConsumerInput : "http://www.invenireaude.org/qsystem/workers/io" BEGIN
  	   inputName = "input";
  	   connection.alias="front-end";
  	   destination = "any";
  	   responderName = "output";
  	   timeout = -1;
  	  END;


   WITH ca AS apps.applications DO
  	 WITH ci AS ca.interfaceInstances DO
  	  IF ci ISTYPE (ClientInterface : "http://www.invenireaude.com/esbsd") THEN BEGIN

  	  VAR cfg AS Specification  : "http://www.invenireaude.org/qsystem/workers/spec";

  	  VAR interface   AS InterfaceDefinition   : "http://www.invenireaude.com/esbsd";
   	  VAR persistance AS String;

   	  interface   = ias::esbsd::gen::inc::getInterface(ints, ci.id);
   	  persistance = ias::esbsd::gen::inc::getPersistance(interface);

  	  cfg.inputSpec.inputs = NEW ConsumerInput : "http://www.invenireaude.org/qsystem/workers/io" BEGIN
  	   inputName = "input";
  	   connection.alias = ci.deployment.location.connectionAlias;
  	   destination = "ESB.S."+ca.id+"."+ci.id+".IN";
  	   responderName = "input";
  	   timeout = -1;
  	   txnMode = "TXN";

  	   CREATE attrUpdates BEGIN
  	     name = "ESB";
  	     value = "@timestamp@";
  	     override = TRUE;
  	   END;

  	   CREATE attrUpdates BEGIN
  	     name = "FMT";
  	     value = "XML";
  	     override = TRUE;
  	   END;

  	  END;


 		cfg.outputSpec.outputs = NEW ProducerOutput : "http://www.invenireaude.org/qsystem/workers/io" BEGIN
  	  		 outputName = "error";
  	   		 connection.alias = ci.deployment.location.connectionAlias;
  	   		 destination = "ESB.S."+ca.id+"."+ci.id+".ERR";
  	   		 txnMode = "TXN";
  	  	   END;

  	   cfg.outputSpec.outputs = NEW ProducerOutput : "http://www.invenireaude.org/qsystem/workers/io" BEGIN
		 outputName = "output.collect";
   		 connection.alias = ci.deployment.location.connectionAlias;
   		 destination = "ESB.C.COLLECT.OUT";
   		 txnMode = "NONTXN";
   		 CREATE attrUpdates BEGIN
  	     	name = "FMT";
  	     	value = "XML";
  	     	override = TRUE;
  	   	END;
 	   END;

  	   IF ias::esbsd::gen::inc::getInterface(ints, ci.id).mode == "ClientServer___NO_STATUS_QUEUE" THEN BEGIN

   		   cfg.inputSpec.inputs = NEW ConsumerInput : "http://www.invenireaude.org/qsystem/workers/io" BEGIN
  	  		 inputName = "input.status";
  	   		connection.alias = ci.deployment.location.connectionAlias;
  	   		 destination = "ESB.X."+ca.id+"."+ci.id+".IN";
  	   		 timeout = 0;
  	   		 txnMode = "TXN";

  	   		 CREATE attrUpdates BEGIN
  	     		name = "FMT";
  	     		value = "XML";
  	     		override = TRUE;
  	   		END;

  	  	   END;

  	  	   cfg.outputSpec.outputs = NEW ProducerOutput : "http://www.invenireaude.org/qsystem/workers/io" BEGIN
  	  		 outputName = "output.status";
  	   		 connection.alias = ci.deployment.location.connectionAlias;
  	   		 destination = "ESB.X."+ca.id+"."+ci.id+".OUT";
  	   		 txnMode = "TXN";
  	  	   END;
        END;

  	  VAR hasReplies AS Boolean;
  	  hasReplies = FALSE;

  	  WITH sa AS apps.applications DO
   		WITH si AS sa.interfaceInstances DO BEGIN

   	   		 IF si.id == ci.id AND
   	   		   		si ISTYPE (ServerInterface : "http://www.invenireaude.com/esbsd") AND
   	   		   		ci ISTYPE (ClientInterface : "http://www.invenireaude.com/esbsd") THEN BEGIN

   					IF ias::esbsd::gen::inc::getInterface(ints, ci.id).mode == "ClientServer" THEN BEGIN

   		    			cfg.outputSpec.outputs = NEW RequesterOutput : "http://www.invenireaude.org/qsystem/workers/io" BEGIN
  	  		 				outputName = "output."+sa.id;
  	   		 				connection.alias = ci.deployment.location.connectionAlias;
  	   					 	destination = "ESB.C."+ca.id+"."+sa.id+"."+ci.id+".OUT";
  	   					 	inputDestination = "ESB.C."+ca.id+"."+ci.id+".IN";
  	  	   					timeout = -1;
  	  	   					txnMode = "TXN";
  	  	   				END;
						hasReplies = TRUE;

   	   				END ELSE BEGIN

   	   					cfg.outputSpec.outputs = NEW ProducerOutput : "http://www.invenireaude.org/qsystem/workers/io" BEGIN
  	  		 				outputName = "output."+sa.id;
  	   		 				connection.alias = ci.deployment.location.connectionAlias;
  	   					 	destination = "ESB.C."+ca.id+"."+sa.id+"."+ci.id+".OUT";
  	   					 	txnMode = "TXN";
  	  	   				END;

   	   				END;

   			 END;

   		END;

  		  cfg.ecSpec.ecs = NEW SimpleEventCounter : "http://www.invenireaude.org/qsystem/workers/ec" BEGIN
  	  		 name = "ec.timer";
  	  		 connection.alias = "ec.timer";
			 size=1024;
			 avgKeyLen=64;
			 resetInterval=9999999;
  	  	  END;

  	 	  cfg.logicSpec.logics = NEW ExplicitExecute : "http://www.invenireaude.org/qsystem/workers/logic" BEGIN
  	  		 name = "request";
  	  		 instances = 1;
  	  		 input = "input";
  	  		 output = "output";
  	  		 error = "error";
  	  		 load = "esb::broker::interface::"+std::str2lower(ci.id)+"::handleRequest";
  	  		 run = COPYOF(load);
  	  	  END;


  	 IF hasReplies == TRUE THEN BEGIN

  		cfgTester.outputSpec.outputs = NEW RequesterOutput : "http://www.invenireaude.org/qsystem/workers/io" BEGIN
  	    outputName = "io."+ca.id+"."+ci.id;
  	    connection.alias = ci.deployment.location.connectionAlias;
  	    destination = ""+ca.id+".C."+ci.id+".OUT";
        //inputDestination = ""+ca.id+".C."+ci.id+".IN"; or temporary queue
  	    inputDestination = ""+ca.id+".C."+ci.id+".IN.*";
  	    timeout = 30000;

  	   attrUpdates = NEW AttributeUpdate : "http://www.invenireaude.org/qsystem/workers" BEGIN
  	     name = "FMT";
  	     value = "XML";
  	     override = TRUE;
  	   END;

  	   attrUpdates = NEW AttributeUpdate : "http://www.invenireaude.org/qsystem/workers" BEGIN
  	     name = "INTERFACE";
  	     value = ci.id;
  	     override = TRUE;
  	   END;

  	   attrUpdates = NEW AttributeUpdate : "http://www.invenireaude.org/qsystem/workers" BEGIN
  	     name = "SRCAPPL";
  	     value = ca.id;
  	     override = TRUE;
  	   END;
  	    END;
  	 END ELSE BEGIN

  	    cfgTester.outputSpec.outputs = NEW ProducerOutput : "http://www.invenireaude.org/qsystem/workers/io" BEGIN
  	    outputName = "io."+ca.id+"."+ci.id;
  	    connection.alias = ci.deployment.location.connectionAlias;
  	    destination = ""+ca.id+".C."+ci.id+".OUT";

  	   attrUpdates = NEW AttributeUpdate : "http://www.invenireaude.org/qsystem/workers" BEGIN
  	     name = "FMT";
  	     value = "XML";
  	     override = TRUE;
  	   END;

  	   attrUpdates = NEW AttributeUpdate : "http://www.invenireaude.org/qsystem/workers" BEGIN
  	     name = "INTERFACE";
  	     value = ci.id;
  	     override = TRUE;
  	   END;

  	   attrUpdates = NEW AttributeUpdate : "http://www.invenireaude.org/qsystem/workers" BEGIN
  	     name = "SRCAPPL";
  	     value = ca.id;
  	     override = TRUE;
  	   END;
  	  END;
  	 END;

  	    IF hasReplies == TRUE THEN BEGIN

  	      cfg.logicSpec.logics = NEW ExplicitExecute : "http://www.invenireaude.org/qsystem/workers/logic" BEGIN
  	  		 name = "reply";
  	  		 instances = 1;
  	  		 input = "input.reply";
  	  		 output = "output.reply";
  	  		 error = "error.reply";
  	  		 load = "esb::broker::interface::"+std::str2lower(ci.id)+"::handleReply";
  	  		 run = COPYOF(load);
  	  	  END;

  	 	  cfg.inputSpec.inputs = NEW ConsumerInput : "http://www.invenireaude.org/qsystem/workers/io" BEGIN
  	  		 inputName = "input.reply";
  	   		 connection.alias = ci.deployment.location.connectionAlias;
  	   		 destination = "ESB.C."+ca.id+"."+ci.id+".IN";
  	   		 timeout = -1;

  	   		 CREATE attrUpdates BEGIN
  	     		name = "FMT";
  	     		value = "XML";
  	     		override = TRUE;
  	   		END;

  	  	   END;

  	      cfg.outputSpec.outputs = NEW ProducerOutput : "http://www.invenireaude.org/qsystem/workers/io" BEGIN
  	  		 outputName = "error.reply";
  	   		 connection.alias = ci.deployment.location.connectionAlias;
  	   		 destination = "ESB.C."+ca.id+"."+ci.id+".ERR";
  	  	   END;

  	    END;

  	    cfg.datasourceSpec.datasources = NEW Parameter : "http://www.invenireaude.org/qsystem/workers/ds" BEGIN
  	  		 name  = "ds.broker";
  	  		 connection.alias = "ds.broker";
  	  	 END;

  	   cfg.mode = "processor";

  	   VAR ctxFile  AS Context  : "http://www.invenireaude.org/qsystem/workers";
  	   ctxFile.MID = "esb."+ca.id+"."+ci.id+".qs.xml";
  	   std::send("output",ctxFile,cfg);


  	   cfgSM.services = NEW Service : "http://www.invenireaude.org/sm/cfg" BEGIN
  	   	 name = "esb."+ca.id+"."+ci.id;

  	   	 grpAttrs = NEW GroupingAttribute : "http://www.invenireaude.org/sm/cfg" BEGIN
  	   	  name = "flow";
  	   	  value = ci.id;
  	   	 END;

  	   	 grpAttrs = NEW GroupingAttribute : "http://www.invenireaude.org/sm/cfg" BEGIN
  	   	  name = "type";
  	   	  value = "broker";
  	   	 END;

  	   	 grpAttrs = NEW GroupingAttribute : "http://www.invenireaude.org/sm/cfg" BEGIN
  	   	  name = "mon";
  	   	  value = "yes";
  	   	 END;

		startCmd.exe  = "ias_qs_processor";
		startCmd.args = "-f";
		startCmd.args = "svc/esb/esb."+ca.id+"."+ci.id+".qs.xml";
		startCmd.args = "-T";
		startCmd.args = "1";

		resGrp = "rg.esb.flows";

  	   END;

  	END;

  	  VAR ctxFile  AS Context  : "http://www.invenireaude.org/qsystem/workers";
  	  ctxFile.MID = "tester.qs.xml";
  	  std::send("output",ctxFile,cfgTester);

   //std::save("stdout",cfgSM);
   std::send("output.sm",ctx,cfgSM);
END;
