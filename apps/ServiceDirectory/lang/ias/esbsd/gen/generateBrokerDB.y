
IMPORT std::qs;
IMPORT std::default;

IMPORT ias::esbsd::web::esb::getApplications;
IMPORT ias::esbsd::web::esb::getInterfaces;

IMPORT ias::esbsd::gen::inc::brokerdb;
IMPORT ias::esbsd::gen::inc::common;



/* ************************************** */

PROGRAM ias::esbsd::gen::generateBrokerDB(VAR ctx   AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	    				          VAR data  AS AnyType)
BEGIN

   VAR apps AS GetApplications : "http://www.invenireaude.com/esbsd/esb/api";
   VAR ints AS GetInterfaces   : "http://www.invenireaude.com/esbsd/esb/api";

   apps = ias::esbsd::web::esb::getApplications(ctx, apps);
   ints = ias::esbsd::web::esb::getInterfaces(ctx, ints);

   //std::save("stdout",apps);
   //std::save("stdout",ints);


    WITH ca AS apps.applications DO
  	 WITH ci AS ca.interfaceInstances DO
  	    IF ci ISTYPE (ClientInterface : "http://www.invenireaude.com/esbsd") THEN
  			WITH sa AS apps.applications DO
   				WITH si AS sa.interfaceInstances DO
			   	 IF si.id == ci.id AND
   	   		   		si ISTYPE (ServerInterface : "http://www.invenireaude.com/esbsd") THEN
   	   		   		    WITH cs AS (ci AS ClientInterface : "http://www.invenireaude.com/esbsd").services DO
				    		WITH ss AS (si AS ServerInterface : "http://www.invenireaude.com/esbsd").services DO
			    				IF ss.name == cs.name THEN

   TRY BEGIN

     VAR monRequest  AS MonitoringMode : "http://www.invenireaude.com/esbsd";
     VAR monResponse AS MonitoringMode : "http://www.invenireaude.com/esbsd";

     monRequest  = ias::esbsd::gen::generateBrokerDB::getDefaultRequestMode(ci.id);
     monResponse = ias::esbsd::gen::generateBrokerDB::getDefaultResponseMode(ci.id);

     monRequest  ?= cs.monitorRequest;
     monResponse ?= cs.monitorResponse;

     ias::esbsd::gen::inc::insertRouting(ca.id, ci.id, cs.name, sa.id, monRequest, monResponse);

   END CATCH (VAR e AS Exception : "http://www.invenireaude.org/qsystem/workers") BEGIN
     std::save("stdout",e);
     THROW NEW Exception : "http://www.invenireaude.org/qsystem/workers" BEGIN
      name = "ConfigurationProcessingException";
      info = " Error when inserting: " + ca.id + ":" + ci.id + ":" + cs.name + ":" +sa.id ;
     END;
   END;

     ias::esbsd::gen::inc::insertProperty("GEN_DATE", (std::getTime() AS String));

END;

PROGRAM ias::esbsd::gen::generateBrokerDB::getDefaultRequestMode(VAR interface AS String)
RETURNS MonitoringMode : "http://www.invenireaude.com/esbsd"
BEGIN
 RETURN "FULL";
END;

PROGRAM ias::esbsd::gen::generateBrokerDB::getDefaultResponseMode(VAR interface AS String)
RETURNS MonitoringMode : "http://www.invenireaude.com/esbsd"
BEGIN

  IF interface == "INQUIRY" THEN
    RETURN "HEADER";

  RETURN "FULL";
END;