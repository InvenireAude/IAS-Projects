IMPORT esb::broker::tools;
IMPORT esb::broker::ds::routing;
IMPORT std::qs;


PROGRAM esb::broker::interface::common::handleSend(VAR ctx       AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	   		  					      	                 VAR data      AS Routing  : "http://www.invenireaude.org/qsystem/workers")
BEGIN

   VAR client      AS String;
   VAR service     AS String;
   VAR interface   AS String;
   VAR routing     AS RoutingData : "http://www.invenireaude.com/esbsd/broker";

   interface = esb::broker::getAttribute(ctx.attributes, "INTERFACE");
   service   = esb::broker::getAttribute(ctx.attributes, "XMLfName");
   client    = esb::broker::getAttribute(ctx.attributes, "SRCAPPL");

   routing    = esb::broker::ds::fetchRouting(client, interface, service);

   IF routing.provider == "" THEN BEGIN
     THROW NEW Exception  : "http://www.invenireaude.org/qsystem/workers" BEGIN
    	name = "NotAuthorizedException";
    	info = client + ", i:"+interface+", s:"+service;
  	END;
   END;

   ctx.attributes=esb::broker::newAttribute("ESB_REPLY_TO", ctx.REPLY_TO);

   data.valid = TRUE;
   data.targets = "output.esb.collect";
   data.targets = "output." + routing.provider;

END;