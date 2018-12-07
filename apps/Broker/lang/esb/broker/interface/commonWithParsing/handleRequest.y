

IMPORT esb::broker::tools;
IMPORT esb::broker::ds::routing;
IMPORT std::qs;
IMPORT esb::broker::interface::common::registerServiceCall;

PROGRAM esb::broker::interface::common::handleRequest(VAR ctx       AS Context  : "http://www.invenireaude.org/qsystem/workers",
		   	   		  					      		  VAR data      AS Service  : "http://www.invenireaude.com/esbsd/services/common")
BEGIN

   VAR client      AS String;
   VAR service     AS String;
   VAR replyTo     AS String;
   VAR interface   AS String;
   VAR routing     AS RoutingData : "http://www.invenireaude.com/esbsd/broker";

   interface = esb::broker::getAttribute(ctx.attributes, "INTERFACE");
   service   = esb::broker::getAttribute(ctx.attributes, "XMLfName");
   client    = esb::broker::getAttribute(ctx.attributes, "SRCAPPL");

   routing    = esb::broker::ds::fetchRouting(client, interface, service);

   IF routing.provider == "" THEN BEGIN
     THROW NEW Exception  : "http://www.invenireaude.org/qsystem/workers" BEGIN
    	name="NotAuthorizedException";
    	info=client + ", i:"+interface+", s:"+service;
  	END;
   END;

   replyTo = ctx.REPLY_TO;

   ctx.attributes=esb::broker::newAttribute("ESB_REPLY_TO",replyTo);
   //ctx.attributes=esb::broker::newAttribute("EXPIRATION","36000"); // 1h

   std::send("output." + routing.provider, ctx, data);

   IF routing.monRequest == "FULL" THEN BEGIN
	   esb::broker::interface::common::registerServiceCall(ctx.MID, "REQUEST", interface, service, client, routing.provider, data, std::getTime(), (NULL AS DateTime), FALSE);
   END ELSE IF routing.monRequest == "HEADER" THEN BEGIN
	   esb::broker::interface::common::registerServiceCall(ctx.MID, "REQUEST", interface, service, client, routing.provider, data, std::getTime(), (NULL AS DateTime), TRUE);
   END;

END;



